Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DE6671978
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjARKpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 05:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjARKm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:42:57 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEA32101;
        Wed, 18 Jan 2023 01:48:09 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso1050774wms.3;
        Wed, 18 Jan 2023 01:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YzZf1LOeJUJ3aYNXdqGuXA8Bu54sNOZGFFAWJSz1vB4=;
        b=NxwB+Bks6L72C1uEFgdA5tAcEV8PFk8pzwoscBFQkK94V/aQy0cftmS1YfyO37bUNr
         6oLV6HDKbtedd1k8YtNzu+1zg7jHHPFzPZ0CmEWA8lv3Et4k10Oz07iqIFEWQQh6lZkj
         ypZzg0ldiWRzODCrLC/V7YB6tCPbSEam6V0Ny/8abKFPtgSjGpS62Lo+1ub5SemqrPdv
         RyQ9RVexGSwYszhWz6KrVrkeuwbcDJTAgdElyxQ2G+SkZLYo8cUBsaGfr6mtlhuuAeMl
         nSuFx0F1kIUCp9KFdXPaqt6+lvm93a/cADt4wI82urA1YqT3t7EVTVTlnu6/DUiSCUva
         ujdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YzZf1LOeJUJ3aYNXdqGuXA8Bu54sNOZGFFAWJSz1vB4=;
        b=5NOWasBqvpcao36J57I00RPp1aIx0ZsVqSkqAC5x0RvM2brffpEVJvRbtQNcWXCSrd
         DxCpisatiqEXt3I/RMIllMGegthpAXX/lM5cmKVDE3ZFukU/5/Q+ajh15AiyIVcIfJ8o
         +JzWpwJcT2Ajb0buzVkLAyqOYv1b/70luVfGe/ZDMi3ywVq42HcVF0C0AYn5Gwj6MzVi
         lArHfbeFivXJeuGVfd4+c7UsAkEHOTqAOAHTmgVc8W9STC9osm+rlksL5BzaKdwb0UtN
         nfvYuH2oMJqeoJLZ9pfpjaVPtP6L1MDvye7IrVrIjExSSqQ9AjPaLrrke58pKDxIMkA5
         E49g==
X-Gm-Message-State: AFqh2kovUKKxyUR3k7Y/SPFJhJ5ArsWHZ4URALf1sTJBiYPOFA+YXtBP
        8x9Zd+QWxGZdgCiPMM0y5+RxgzFav1ngnQ==
X-Google-Smtp-Source: AMrXdXtbOmN49Qnsek1dW3mxhucBX6xU3mvr1oneBz9H8Ti0TUF4EFAHwf7xzdTxvNuFpsU4j8cT5Q==
X-Received: by 2002:a05:600c:4e50:b0:3da:4e:8dfe with SMTP id e16-20020a05600c4e5000b003da004e8dfemr5865917wmq.38.1674035287869;
        Wed, 18 Jan 2023 01:48:07 -0800 (PST)
Received: from [192.168.2.202] (pd9ea3221.dip0.t-ipconnect.de. [217.234.50.33])
        by smtp.gmail.com with ESMTPSA id p18-20020a05600c359200b003db040f0d5esm1448371wmq.33.2023.01.18.01.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 01:48:07 -0800 (PST)
Message-ID: <e40d3977-17bd-be9c-8ea5-1e5f7c2d47b0@gmail.com>
Date:   Wed, 18 Jan 2023 10:48:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 1/1] platform/surface: Switch to use
 acpi_evaluate_dsm_typed()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>
References: <20230118093823.39679-1-andriy.shevchenko@linux.intel.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20230118093823.39679-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/23 10:38, Andy Shevchenko wrote:
> The acpi_evaluate_dsm_typed() provides a way to check the type of the
> object evaluated by _DSM call. Use it instead of open coded variant.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I think the reason I went with the non-typed version here was for the
explicit error message. Specifically, to simplify debugging in case we'd
get any new device that behaves differently. But since then I think MS
discontinued the use of this driver (or at least this part) in their
devices (no more detachable GPUs). Also, the likelihood of that
interface changing is pretty small regardless.

So I'm fine with changing that.

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

> ---
>   drivers/platform/surface/surface_hotplug.c | 13 +++----------
>   1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/platform/surface/surface_hotplug.c b/drivers/platform/surface/surface_hotplug.c
> index f004a2495201..7b6d887dccdb 100644
> --- a/drivers/platform/surface/surface_hotplug.c
> +++ b/drivers/platform/surface/surface_hotplug.c
> @@ -101,18 +101,12 @@ static void shps_dsm_notify_irq(struct platform_device *pdev, enum shps_irq_type
>   	param.type = ACPI_TYPE_INTEGER;
>   	param.integer.value = value;
>   
> -	result = acpi_evaluate_dsm(handle, &shps_dsm_guid, SHPS_DSM_REVISION,
> -				   shps_dsm_fn_for_irq(type), &param);
> -
> +	result = acpi_evaluate_dsm_typed(handle, &shps_dsm_guid, SHPS_DSM_REVISION,
> +					 shps_dsm_fn_for_irq(type), &param, ACPI_TYPE_BUFFER);
>   	if (!result) {
>   		dev_err(&pdev->dev, "IRQ notification via DSM failed (irq=%d, gpio=%d)\n",
>   			type, value);
>   
> -	} else if (result->type != ACPI_TYPE_BUFFER) {
> -		dev_err(&pdev->dev,
> -			"IRQ notification via DSM failed: unexpected result type (irq=%d, gpio=%d)\n",
> -			type, value);
> -
>   	} else if (result->buffer.length != 1 || result->buffer.pointer[0] != 0) {
>   		dev_err(&pdev->dev,
>   			"IRQ notification via DSM failed: unexpected result value (irq=%d, gpio=%d)\n",
> @@ -121,8 +115,7 @@ static void shps_dsm_notify_irq(struct platform_device *pdev, enum shps_irq_type
>   
>   	mutex_unlock(&sdev->lock[type]);
>   
> -	if (result)
> -		ACPI_FREE(result);
> +	ACPI_FREE(result);
>   }
>   
>   static irqreturn_t shps_handle_irq(int irq, void *data)
