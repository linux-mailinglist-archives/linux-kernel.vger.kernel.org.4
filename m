Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1681B632231
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbiKUMeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbiKUMdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:33:54 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD419B700E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 04:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669033995; x=1700569995;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QzEDzoGLYNBf9zycRZ1H2wdknqfe6Bf1J8TFEUmSIxo=;
  b=GfH50Zy+XbAv7fCWu6i9VUvpsXRz9NVVFyI64cFTJmciTgQSR62dai0c
   X+92CTWJ3JTHZ+6v47W0RuUSXeUHr07bKMbaURyOBEYATNlAZ7EiN/jXP
   wZSXb2G2HzBWFF/QIfU7EZ1ePA//pigyrmG6/ZxX6bReDtpS489bYWw4h
   D7y13zZ9zFYr40AH5cnkeXtrTWOXev7ioZSjtpWwQcjVgau1X+40b9DRs
   LtjYy0xtHfOEXucpFHTMXkuveEBkC286gfPsm1TdJf/5zue2i4JNiqUoi
   28dhsqL+DQ504veT84GVQr5fsYcU5DfitSGQZ8RwEYixqWwm9aOjSiyaQ
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,181,1665417600"; 
   d="scan'208";a="321137241"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Nov 2022 20:33:13 +0800
IronPort-SDR: IDFkde88uIhqIuazuSsBcx8V2er/8gNMGMAO7IxC4GwRUAMHOt2cS8XUqZOgg9A4mmmcobop4Y
 bFExUl/CyJWoQe+XUirCB8H4tH9RKRkId3UmCtYfAqWkHIoK4t/aUYlrmUxmFYmymxqcjuNzCU
 STI1iE4Nvrq7E0l5wcPQPw0EOeq88oVY1E6f9NRXiA3Oe9mBxvyZFifIR6uxY7NCS5njyyaRCZ
 vH+jnLRPy+ixqlLUTJ939CoCbXU8phywHbZt95gNg80SVl32PrxvkZCf12xrGgXDx08UcuWxYr
 mcM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Nov 2022 03:46:18 -0800
IronPort-SDR: pIdHGWUiBzpb3AiEnAclfU/VggKXworgWBTdCTCOO6/3R0/jvYu3ngnzkdKdh7Y0qnmWFKzvKV
 ebxy0umwqA9i9ytFN4QtXng5vdOGrF7NKvfFIpdhybt/xLEI1JnO5gzacBK9HvYUSGKyP9J1+2
 zsDYvucLwh3ZHHRGnCAamw3+IGK7TFGA9Oq9CbI7OsF5s85d/qLAX1y+1Z26OSuFmHuQuN2HMd
 4CG9R+g3hU0mxrWor7Kd1UBdKJfCedB6yGnlwTWK1Za1mknqbTvIitkOan+HtblMly2BenVMFu
 MjU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Nov 2022 04:33:13 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NG6HY14Xtz1RwqL
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 04:33:13 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1669033992; x=1671625993; bh=QzEDzoGLYNBf9zycRZ1H2wdknqfe6Bf1J8T
        FEUmSIxo=; b=ggxmouGIAJ4x0zjPGwvDSIlsVrkcdtC9JTLejcdl4W2FmXH9WOO
        G8O3350RoVPlhe5FdiajXwWtuwAO3v5r8GFKycGLG+N82U4ulwWNE96ba8ZPbY9w
        JL1tn+EJCdtD/lGj9krvr6qZlzbeCcNaMjDA3eVFRcVs03FNh/nWXwhxj/96uN6V
        thL1nWh96+Jyl8KRQawtO3oIAIO1fBJzXoYwlVcP+Iq/t7GzbpM7JOStPtyaZHN5
        LPolUCkNmEyxyXMkC/cJ2ccQxhwmhk5KK7ym8MWL1qBzd2tT+sN+wsqnFzviscjb
        ewrpQlcM+6AnQX88Sr5dIgurb+54jfFd6Ew==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PDbQH0wdZup5 for <linux-kernel@vger.kernel.org>;
        Mon, 21 Nov 2022 04:33:12 -0800 (PST)
Received: from [10.225.163.53] (unknown [10.225.163.53])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NG6HW6clhz1RvLy;
        Mon, 21 Nov 2022 04:33:11 -0800 (PST)
Message-ID: <83c29cc2-9bf4-265f-4f8a-ab83d8b6271b@opensource.wdc.com>
Date:   Mon, 21 Nov 2022 21:33:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/2] scsi: core: Use SCSI_SCAN_INITIAL in
 do_scsi_scan_host()
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>, martin.petersen@oracle.com,
        jejb@linux.ibm.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221121121725.1910795-1-john.g.garry@oracle.com>
 <20221121121725.1910795-3-john.g.garry@oracle.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221121121725.1910795-3-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/22 21:17, John Garry wrote:
> Instead of using hardcoded '0' as the do_scsi_scan_host() ->
> scsi_scan_host_selected() rescan arg, use proper macro SCSI_SCAN_INITIAL.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/scsi/scsi_scan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
> index 6cc974b382c1..920b145f80b7 100644
> --- a/drivers/scsi/scsi_scan.c
> +++ b/drivers/scsi/scsi_scan.c
> @@ -1920,7 +1920,7 @@ static void do_scsi_scan_host(struct Scsi_Host *shost)
>  			msleep(10);
>  	} else {
>  		scsi_scan_host_selected(shost, SCAN_WILD_CARD, SCAN_WILD_CARD,
> -				SCAN_WILD_CARD, 0);
> +				SCAN_WILD_CARD, SCSI_SCAN_INITIAL);
>  	}
>  }
>  

-- 
Damien Le Moal
Western Digital Research

