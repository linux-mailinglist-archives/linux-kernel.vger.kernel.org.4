Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3D67266FF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjFGRR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjFGRRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:17:25 -0400
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D2E1BDC;
        Wed,  7 Jun 2023 10:17:24 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-655fce0f354so2409816b3a.0;
        Wed, 07 Jun 2023 10:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686158244; x=1688750244;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DFPGwpCQpZDlbK+2dcezD0d5mxiO5AMq/+/AN27SQOM=;
        b=Yc9OAdceP2EkMmzV5XHhv1rtLxoDRavVLZ4CyMM3lMoTYc6R2MHT9itt/VftOWArtu
         kuOnhb/Pkh9I4k5GuFBO2OcF8jnJaYVPA+GzRrE7r1z/pmnRQuvptgnguOItL1Zq7W1i
         IFs08raDkz4Bv7bvGTdvkJhhjG5YX12VLzq/VgwNiOWAAKN0Wme20PIpDNdQo5RpXf6T
         0rte9LSqojdgJxdhtPf+m1LFGb64MSRedxQHOT2FYPCOJJvjOrcwWKi0fvubGZJHt8lm
         DxUQO0AEheISX0ra6e61Ggv7D8Q9jAxYFFczZPZB67JELyyiInjmca8pcKMeDaKlcQq3
         Vw5A==
X-Gm-Message-State: AC+VfDw8F5OEhlHqX1FO9FAGXfqV5QOJ1/QTEqDOOg4yN+QSetR+5FwB
        /DJFtpODVquFXqoMQuZfED4=
X-Google-Smtp-Source: ACHHUZ7v8zzX5zKgbuGtCNfhzwZXUtn5YrrNGyBjX3Hfyxj9y8BR90kt2+NZlmgBHihAc8RVnQ2zPg==
X-Received: by 2002:a05:6a20:7293:b0:10f:13bb:5d4f with SMTP id o19-20020a056a20729300b0010f13bb5d4fmr2039900pzk.2.1686158243558;
        Wed, 07 Jun 2023 10:17:23 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id d10-20020a631d0a000000b0051b36aee4f6sm9349487pgd.83.2023.06.07.10.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 10:17:23 -0700 (PDT)
Message-ID: <ed3cad40-5634-ffff-aa29-c14f91c7f8a4@acm.org>
Date:   Wed, 7 Jun 2023 10:17:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] scsi: ufs-mediatek: add dependency for RESET_CONTROLLER
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Peter Wang <peter.wang@mediatek.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        linux-scsi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20230602023957.9187-1-rdunlap@infradead.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230602023957.9187-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/23 19:39, Randy Dunlap wrote:
> When RESET_CONTROLLER is not set, kconfig complains about missing
> dependencies for RESET_TI_SYSCON, so add the missing dependency
> just as is done above for SCSI_UFS_QCOM.
> 
> Silences this kconfig warning:
> 
> WARNING: unmet direct dependencies detected for RESET_TI_SYSCON
>    Depends on [n]: RESET_CONTROLLER [=n] && HAS_IOMEM [=y]
>    Selected by [m]:
>    - SCSI_UFS_MEDIATEK [=m] && SCSI_UFSHCD [=y] && SCSI_UFSHCD_PLATFORM [=y] && ARCH_MEDIATEK [=y]
> 
> Fixes: de48898d0cb6 ("scsi: ufs-mediatek: Create reset control device_link")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: lore.kernel.org/r/202306020859.1wHg9AaT-lkp@intel.com
> Cc: Stanley Chu <stanley.chu@mediatek.com>
> Cc: Peter Wang <peter.wang@mediatek.com>
> Cc: Paul Gazzillo <paul@pgazz.com>
> Cc: Necip Fazil Yildiran <fazilyildiran@gmail.com>
> Cc: linux-scsi@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> ---
>   drivers/ufs/host/Kconfig |    1 +
>   1 file changed, 1 insertion(+)
> 
> diff -- a/drivers/ufs/host/Kconfig b/drivers/ufs/host/Kconfig
> --- a/drivers/ufs/host/Kconfig
> +++ b/drivers/ufs/host/Kconfig
> @@ -72,6 +72,7 @@ config SCSI_UFS_QCOM
>   config SCSI_UFS_MEDIATEK
>   	tristate "Mediatek specific hooks to UFS controller platform driver"
>   	depends on SCSI_UFSHCD_PLATFORM && ARCH_MEDIATEK
> +	depends on RESET_CONTROLLER
>   	select PHY_MTK_UFS
>   	select RESET_TI_SYSCON
>   	help

Hmm ... is the above patch complete? Shouldn't a similar dependency be
added to the ufs-hisi and ufs-sprd drivers? See also the following git
grep output:

$ git grep -nH 'include.*linux/reset.h' */ufs
drivers/ufs/host/ufs-hisi.c:16:#include <linux/reset.h>
drivers/ufs/host/ufs-mediatek.c:21:#include <linux/reset.h>
drivers/ufs/host/ufs-qcom.h:9:#include <linux/reset.h>
drivers/ufs/host/ufs-sprd.c:14:#include <linux/reset.h>

Thanks,

Bart.
