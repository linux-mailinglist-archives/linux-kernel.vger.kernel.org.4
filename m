Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4367460B23A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbiJXQnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234719AbiJXQnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 12:43:07 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249A31CFCF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 08:29:36 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id o2so1961314ilo.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 08:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3RFUYnxkZfbGB4sUYeSVCHGTolA3bNrSoJ5VxM9ll30=;
        b=T8fZhnkSRW0EcYMeVwli0zShE13H8FMRgyv42sjmdyBdRt1iAKhbeWLluKgnHZxlQ5
         UI1vATreT4jIvGzHcmSm9NXP5o7zwk1z5/KuCy+w8rLSUALYMmvI1pgiDwCN7zdufSfe
         Rpwce8lZ2PXeUAv/dvtoN0dWQXnR6V+PyiDujRVKOEu/BBUs4S0zGFEwnpDw1EsXlo4v
         fJNcBGY8H5iiBy/SMSoBEhREubwsu7ivvui4kSZtRxAiePHjCG3I7uyfqibtFyBEvS/I
         frTwfcEEXLFrbgV1lgFay1OJVoH2Jg1HL43V4wJXkDQaJiBGEhgBDDBGVLlCKY9Yl6SH
         4UAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3RFUYnxkZfbGB4sUYeSVCHGTolA3bNrSoJ5VxM9ll30=;
        b=K+LOaZ1PC+7f2s3FHMEvukaDINDjf1rSD23CZst1CahNhfDR7ZWnPSsY+6eaSh/Goz
         dkciN4VqxLGZRzIlnHq1tGPcRqeScgJeyKOFgtcWbfhQC2S7F63igMMmwNTcAob/NZSs
         mXggBKIJ1FfZcH3YrjXDMzamBjp2YWx01DjgYQqHTpJpwQFYlYd9qpwodaMCDDUtoNB9
         WpiQA6908Cn70vgWMQzBK0Cl39b+IpDDUYp+cJAlDl+WON/BjA/uIinJD+BNWy0GuXGA
         4mzqNZw/TpDeYgcsrJJoxTSFJenV92GBJMnlBUWr2CnhHVX68ZDkfFWIvk3ACJHhzji9
         f6tg==
X-Gm-Message-State: ACrzQf3gRJq/KasdEJRxSoAxLHmO6/t9p0V3SKIztsCtTfPzGGuKXPNR
        BbjI0jduHeNc66Lw4c6FI0r3HiReZJQMeW09
X-Google-Smtp-Source: AMsMyM7MkD2jDxUhY+Ie+vHsovp22ZlwLzRWnn+eqHGHGwHdaJH1e1WLV2xJ8hBG+s3N0GsXto7nlA==
X-Received: by 2002:a63:450c:0:b0:443:94a1:3703 with SMTP id s12-20020a63450c000000b0044394a13703mr27735849pga.565.1666623173978;
        Mon, 24 Oct 2022 07:52:53 -0700 (PDT)
Received: from ?IPV6:2400:4050:c360:8200:8ae8:3c4:c0da:7419? ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id oc12-20020a17090b1c0c00b00212735c8898sm4126456pjb.30.2022.10.24.07.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 07:52:53 -0700 (PDT)
Message-ID: <37ec64ac-9e08-dd41-4b20-8701bf9413fb@daynix.com>
Date:   Mon, 24 Oct 2022 23:52:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2] ACPI: video: Fix missing native backlight on
 Chromebooks
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sean Paul <seanpaul@chromium.org>
Cc:     kernel@collabora.com, linux-acpi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221024141210.67784-1-dmitry.osipenko@collabora.com>
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20221024141210.67784-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/24 23:12, Dmitry Osipenko wrote:
> Chromebooks don't have backlight in ACPI table, they suppose to use
> native backlight in this case. Check presence of the CrOS embedded
> controller ACPI device and prefer the native backlight if EC found.
> 
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Fixes: 2600bfa3df99 ("ACPI: video: Add acpi_video_backlight_use_native() helper")
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
> 
> Changelog:
> 
> v2: - Added explanatory comment to the code and added check for the
>        native backlight presence, like was requested by Hans de Goede.
> 
>   drivers/acpi/video_detect.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 0d9064a9804c..9cd8797d12bb 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -668,6 +668,11 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>   	{ },
>   };
>   
> +static bool google_cros_ec_present(void)
> +{
> +	return acpi_dev_found("GOOG0004");
> +}
> +
>   /*
>    * Determine which type of backlight interface to use on this system,
>    * First check cmdline, then dmi quirks, then do autodetect.
> @@ -730,6 +735,13 @@ static enum acpi_backlight_type __acpi_video_get_backlight_type(bool native)
>   			return acpi_backlight_video;
>   	}
>   
> +	/*
> +	 * Chromebooks that don't have backlight handle in ACPI table
> +	 * are supposed to use native backlight if it's available.
> +	 */
> +	if (google_cros_ec_present() && native_available)
> +		return acpi_backlight_native;
> +
>   	/* No ACPI video (old hw), use vendor specific fw methods. */
>   	return acpi_backlight_vendor;
>   }

Hi,

The native_available check does not prevent duplicate registration if 
vendor backlight registers first. It was enough for the combination of 
ACPI video and native because ACPI video delays its registration, but it 
is not the case for vendor/native combination.

Regards,
Akihiko Odaki
