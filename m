Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26E45B5CFC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 17:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiILPOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 11:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiILPOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 11:14:24 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D57731219;
        Mon, 12 Sep 2022 08:14:22 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id h188so8543427pgc.12;
        Mon, 12 Sep 2022 08:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=3LIvkOEyvsO12bIO/i0VTg8LKVH6pA/3kBwyTKfIfXc=;
        b=AH+UHKkiw71ziOFnPZ6iO/e9oVZhkCSuC+WC8wkJj4COaRi0yYMJ1M4hnn14BTyzUj
         hWoYeZ9pmCZhFtAH721ks5qVX/B3EZGArU6e03HS1PCsM7CG87gGAyTjc9zL3rHt9sFG
         PE2xrilenk6ng26wtNTTEi5Z36MXldH3IgLS+yS8Z/hMOnhrT+iGrki430hlfiMGQ2EN
         9W9f70f87b/Jo+q2+TQajwRf4r4VKRGTjhSwgZE9J2/HZWCKUB/mpWJ37bMnsRZ+KMMd
         M9XzjRuw7B8oj7Q4knY6WKh11inN4urUspvWniWooyOgn/vYOws3hZ2jGryDmur3s/ok
         Bjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=3LIvkOEyvsO12bIO/i0VTg8LKVH6pA/3kBwyTKfIfXc=;
        b=k+BtfG0Q3goxK7peCCzsZyXJvbSFDaQsSIG7Bn2BP+ZDQnKywJi22itSVubnYdTQeC
         dYO7CIi8wLsTqKP6Yp3UtLoRoZvVBgUjJByB5sSje8c+2wfD+sxo+OCJwd6d1d3gzoyB
         +EtPli6eHi0uGmXr2Xfk9MlaRDGmdocTcV9gBKTDynJGDXStkz0+NpJs5wNFPp9gSKtu
         TZSPybo6kpxdpa+yAWAbZJGuXVi1PTtD7NDwvgFbS2q2bNrAGZ7Rs7pmA7UO7KTPXBHx
         xz4lKMfK7QNfuqoLIWwp7E2AM1piBDKaBzDH8q51brrqZOReLSdLpjZ2vMXpFb0UJRw9
         ihzw==
X-Gm-Message-State: ACgBeo0JA2fCEBDjlrD1ZFaeTn7iGHFNorqrxWqt5qqgTyZfauTJNojq
        oSfVv1ULQ0aSgFJ61qzRm/U=
X-Google-Smtp-Source: AA6agR6UzCwr14Ivu5EhdYGjyGPfPSW7M+N6TJh9Pdp2gd0mCYmIWskfRNimormQ6KuHtMcrhNab6g==
X-Received: by 2002:a05:6a00:1808:b0:542:f4f2:86aa with SMTP id y8-20020a056a00180800b00542f4f286aamr7250225pfa.28.1662995662034;
        Mon, 12 Sep 2022 08:14:22 -0700 (PDT)
Received: from [0.0.0.0] ([192.109.233.222])
        by smtp.gmail.com with ESMTPSA id y5-20020a17090a2b4500b00200b866d061sm5304888pjc.30.2022.09.12.08.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 08:14:21 -0700 (PDT)
Message-ID: <eb83d8a3-2d53-1189-a7a3-42f7fcdc982a@gmail.com>
Date:   Mon, 12 Sep 2022 23:14:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: linux-next: build failure after merge of the coresight tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Joerg Roedel <jroedel@suse.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220912154219.162eb9d3@canb.auug.org.au>
From:   Yicong Yang <yangyccccc@gmail.com>
In-Reply-To: <20220912154219.162eb9d3@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/2022 1:42 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the coresight tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/hwtracing/ptt/hisi_ptt.c:13:10: fatal error: linux/dma-iommu.h: No such file or directory
>    13 | #include <linux/dma-iommu.h>
>       |          ^~~~~~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>   ff0de066b463 ("hwtracing: hisi_ptt: Add trace function support for HiSilicon PCIe Tune and Trace device")
> 
> interacting with commit
> 
>   f2042ed21da7 ("iommu/dma: Make header private")
> 
> from the iommu tree.
> 
> Since the public interfaces in dna-iommu.h were moved to iommu.h, I have
> applied the following merge fix patch:
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 12 Sep 2022 15:35:37 +1000
> Subject: [PATCH] hwtracing: hihi_ptt: fix up for "iommu/dma: Make header private"
> 

s/hihi_ptt/hisi_ptt

thanks for fixing this!

Acked-by: Yicong Yang <yangyicong@hisilicon.com>

> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/hwtracing/ptt/hisi_ptt.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
> index 666a0f14b6c4..5d5526aa60c4 100644
> --- a/drivers/hwtracing/ptt/hisi_ptt.c
> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
> @@ -10,7 +10,6 @@
>  #include <linux/bitops.h>
>  #include <linux/cpuhotplug.h>
>  #include <linux/delay.h>
> -#include <linux/dma-iommu.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
