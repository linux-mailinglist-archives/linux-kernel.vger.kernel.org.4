Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF5B5BF579
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 06:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiIUEj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 00:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbiIUEja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 00:39:30 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718DA7D1F0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 21:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663735158; x=1695271158;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QU8NNkBAMsqxThn+jF6sCsOlO7Mv6BViePjr4RJ5x4o=;
  b=XogYWgH5HMPVvq1x8/4+mmBMqob1N1cDZO9bL5+OtF8er2q1bgcNyezT
   KHV8qIpH5AdQuXPXTa+YKB0EYZEtaCxEsnvT4r4/7LCJlkQ6T+wySYSl7
   bFRmeXvYSg1cQ14iqm6b5tHWQ6531EbcfXHvX5VUckKdy7wfhhlra0Kow
   cnec5KCaeyUV0z1iCGKCXNvYhGFF3WI5tPRQbylqlmSBmJ4lDvXyad0aO
   R7EnZwUS8SH4coM0Zvrs9ZbbP03XgjRm5/yICZQ+hJfTBmz0/z0by5G+i
   Duisqup8npCJC9sFy2m8g4k9TzDKpHxwPWdvfj26+D4njP+SFO3OoB/2Z
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,332,1654531200"; 
   d="scan'208";a="217054103"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2022 12:39:17 +0800
IronPort-SDR: VzRL0tuMBUWrhlTuLkBOmqvyNYkH4SaMeTlxDELp+eedS+sLacUhwcrjJ/umB5m6JQIxkEDec6
 C5NS77kY7BIkClwcu70lUMMolbanyg9RvOUpjnuCjMxrIJ9DmUV/UYM+8iE4sJxOG8M2ckR/PM
 PP87AvS4/wNGSXxzzSeqrA+/m78o7zEqKmMrjem4IFWLPbpuoaVvvnrqVkuZkVnBCPxeQL6X9B
 5Gxua8CYN4Qk1lFWzpz6+fEMFpEQYQhCQmzEgIqOKSAayT9HbX6Ea78uhZhCa616t1udXY3oln
 vy0l6ZqYu3GoE1o9oTHkahu7
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2022 20:59:23 -0700
IronPort-SDR: oDy0vGRCB1K7P6GIDzgfU0NqF1q9kyJlrGBnLvft8g6r0Z5Y9iaBdhsI99agfqVyX2S8bX0UXM
 D6BtI1O+AffzHsbCJrkzlLDfLnBcPYv/5kTi6r9CAqeReXo1FU5HNzmdi0OkAIlPIJfn934Jcw
 WPuAoh5Sl1gylrl6FhKPvLtvqaX//sGsvU78c58mYUhJj1Ix4EcSodtVIEtiIpMlRitTA9pW3K
 sqvpiuEGlEWGY0vBaTQiG+cFC9ncQA088Ng0LCJnbETR1H+ABt4lkN1ePl7cxdEJ+AAoNlqqBA
 7fg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2022 21:39:19 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MXQft5nRTz1RwqL
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 21:39:18 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1663735158; x=1666327159; bh=QU8NNkBAMsqxThn+jF6sCsOlO7Mv6BViePj
        r4RJ5x4o=; b=eeH+5lyMTikqkmsd6I+9wY0ZnSpVeeYHqSo1iw9sLL3DhQjgQVo
        Bp1+kcuZKRTtlNZhawj4I83K8sZ4WTjMIHoPBoVT1U3hE41K9hVTx+DHhOj4CbMp
        RQu3Zfa1eBpZO2FBmfgIREpT1/a9tvgOfmhGGWXbkHGf5K0TkOEF+sLONSDC0pbJ
        t4FQiHmc+77s1fKY2WH5ZPHn0PbFDh5hwb1ihNSAHnrFOlfg4WsFojsfPo6v45io
        AA7rHHjC3LjBFRXIwn2CnqRMPIzynlExxAVi48LnblRVGDzgJc8L+nmQtxDT4FHd
        O7bP8SUmlsHP9enYqs/upomz3oMtHbfzgzQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IHnPakK2iVrR for <linux-kernel@vger.kernel.org>;
        Tue, 20 Sep 2022 21:39:18 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MXQfr47gQz1RvLy;
        Tue, 20 Sep 2022 21:39:16 -0700 (PDT)
Message-ID: <a5b8d028-41a2-6a77-817b-37d9d7424594@opensource.wdc.com>
Date:   Wed, 21 Sep 2022 13:39:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH linux-next] ata: libata-eh: Remove the unneeded result
 variable
Content-Language: en-US
To:     cgel.zte@gmail.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220920062929.214976-1-ye.xingchen@zte.com.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220920062929.214976-1-ye.xingchen@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/22 15:29, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Return the value ata_port_abort() directly instead of storing it in
> another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Applied to for-6.1. Thanks !

> ---
>   drivers/ata/libata-eh.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 7c128c89b454..7dbca2a2f9ee 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -1086,14 +1086,11 @@ static void __ata_port_freeze(struct ata_port *ap)
>    */
>   int ata_port_freeze(struct ata_port *ap)
>   {
> -	int nr_aborted;
> -
>   	WARN_ON(!ap->ops->error_handler);
>   
>   	__ata_port_freeze(ap);
> -	nr_aborted = ata_port_abort(ap);
>   
> -	return nr_aborted;
> +	return ata_port_abort(ap);
>   }
>   EXPORT_SYMBOL_GPL(ata_port_freeze);
>   

-- 
Damien Le Moal
Western Digital Research

