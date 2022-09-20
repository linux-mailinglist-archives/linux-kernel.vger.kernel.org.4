Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F1B5BEF95
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 00:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiITWDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 18:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiITWDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 18:03:42 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F787760D9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 15:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663711420; x=1695247420;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+hPpgbC5aTpEknoMOIocfRrMBJmIwKssPL6d+jJ3i58=;
  b=MNIl2A/nkU7KWxq7UhIxsrBAPHPgo1GoJ+0Q0ZSUiWO3DH7AZMhYHFUf
   nPQVRodbufg5O2aL1Tlb53i3Lv/HKCHU7mm0cqT1h+2DZlrCssudOWxJN
   SdiRUKjAMZUCFO9Pr8sseAuo4vKsE6nbxhBYGcfZhF7jpDejd7q1YMXoK
   XfWhC04oWq1oHDHYvWIXnBf7nhUXELhplIpnQr1HrouV2J6YzwMsckcyF
   x88oiRTbj9qglxbDqu7hlrKHXUfg2IH1Oadd2ZzyJxTHNGfM8Bh6hArrj
   yX3/cf7dTVeQRZx8LSBw6HQ7jzPnxJ1J2ancqomNCnIscX/RUtbnjuNC4
   A==;
X-IronPort-AV: E=Sophos;i="5.93,331,1654531200"; 
   d="scan'208";a="217030195"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2022 06:03:39 +0800
IronPort-SDR: b52gPdzIWvL7eXF7zPPq9tXun54L0CmSPx/ieq8MNwfGvACAgMZABORZbWI6GZ7UOMAvm23Y/j
 QDQZjzgQcLq/cNvKtr/6l3+zLfAKzx8C9qPF8QIin2m7Eoiy2QM6s/6jGfFcQLs16cFZdTsr9V
 qTmNh9hHPe7OMz25x3UWdtsLq8KNiA1sf2szWcGgRlE8S+6LreL40r2DuSmMsqQW2UDDNmsqxP
 gwFmd9t4Q7C1sVAKsXQalGTuEhDc0UBSVptAZYU7UVNGBoTR+34hG+6KeVjb3ErQNqvwNAI6vr
 h2c3QNCLXnt0JIHh9/qDkjOa
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2022 14:18:15 -0700
IronPort-SDR: KSMTrrCySjebUuryG1VPGpFalH9S1GfYe/eDO9rL6dnMT4dEWMWbSPiDYAdV3rAD03c6uOKVZT
 BUI/sUzaBzFaHxuI2Jx7T8japJvaoVUr+oopfZdfeuNzG6ZO8L9r4dOIxaA0rLelUscJlGuRKE
 02HLH5DGqTvdSDm4IWr0JxxpzsoCtknXZCPnkodL+Q2aMEADzYw+UBMZ6p3hBQWbi6ETu4/2dF
 NhDTiVOt/5a9dTAJl0tUXtkPOHvwm3hoGxRzQcMdBkhdxH4ejnbI3go3ZNHR+yk5OZliLNuHBj
 +vE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2022 15:03:40 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MXFtM3STQz1Rwtm
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 15:03:39 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1663711418; x=1666303419; bh=+hPpgbC5aTpEknoMOIocfRrMBJmIwKssPL6
        d+jJ3i58=; b=RlpUBSmgP2MlKTyHdrVMvy2qbkj0Lc/Bti0ZF3d+/hbaUkGAfnk
        QjhquYKhKYvkpZeSmmUlIG4wEmXCo+09kSc1ebtRKQCxQXaF1k7twbLYAnq0Qc2Q
        kfdUPzWmLH0gNwM6cUpBiVIE5wVWUONHnJJpUMpuWhf2E2zyqV8L6KYx0kOh7OL6
        CtOudvjp1J1YV536kRmzaYiABTZdCe1jPDkscPd8RbxhzR9oqqSdfuYPXTPH45Fr
        n6FGHPzGSAjSyAAYd2Z5WpNzdKAmZb0yInrtgUxWyRzYZGtUiU1+ZDFKyTt0sfbJ
        t9eI8JWRTtPuHKhADdyiAdQamcznsN0Psdw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Wsg5gtuHIWpl for <linux-kernel@vger.kernel.org>;
        Tue, 20 Sep 2022 15:03:38 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MXFtH54PRz1RvLy;
        Tue, 20 Sep 2022 15:03:35 -0700 (PDT)
Message-ID: <67b11e85-3e4e-beb7-4a2b-ef856207b227@opensource.wdc.com>
Date:   Wed, 21 Sep 2022 07:03:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 1/6] scsi: core: Use SCSI_SCAN_RESCAN in
 __scsi_add_device()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, hare@suse.de, hch@lst.de
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, brking@us.ibm.com
References: <1663669630-21333-1-git-send-email-john.garry@huawei.com>
 <1663669630-21333-2-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1663669630-21333-2-git-send-email-john.garry@huawei.com>
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

On 9/20/22 19:27, John Garry wrote:
> Instead of using hardcoded '1' as the __scsi_add_device() ->
> scsi_probe_and_add_lun() rescan arg, use proper macro SCSI_SCAN_RESCAN.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/scsi/scsi_scan.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
> index ac6059702d13..3759b1a77504 100644
> --- a/drivers/scsi/scsi_scan.c
> +++ b/drivers/scsi/scsi_scan.c
> @@ -1588,7 +1588,8 @@ struct scsi_device *__scsi_add_device(struct Scsi_Host *shost, uint channel,
>   		scsi_complete_async_scans();
>   
>   	if (scsi_host_scan_allowed(shost) && scsi_autopm_get_host(shost) == 0) {
> -		scsi_probe_and_add_lun(starget, lun, NULL, &sdev, 1, hostdata);
> +		scsi_probe_and_add_lun(starget, lun, NULL, &sdev,
> +				       SCSI_SCAN_RESCAN, hostdata);
>   		scsi_autopm_put_host(shost);
>   	}
>   	mutex_unlock(&shost->scan_mutex);

Looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

