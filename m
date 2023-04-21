Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627C96EB02C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 19:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbjDURHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 13:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbjDURHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 13:07:15 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62431BC
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 10:07:03 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4ec8143400aso1979406e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 10:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682096822; x=1684688822;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nsVxuLXGb/HmPw4+8d4rfb4M9t507exbwNDKA5TIVj0=;
        b=HrNG838xCe/plUz92VSGxl/e4w2Pd1PcZs5KToy+urCwSP7bumfAbId236f4ii3Cr2
         ZEyJ52y41H0aFtjXZbEWFTUdugvGiTwjGEAKroJc19BY4I4HQtNmxd5Hu5dDldNe64IU
         joL6owyMglGtfqIJFPaHxmAvreliuUZ2pmhC3wV+sEpu/t63h+Denl8lm6KxJGTHOg2E
         AmYfQttbiLsz28aV12KXZLUi0C0oeMhZ1U6Jf/HIOd6UYJUZvmHZy+UtWWAOW/i6efvR
         sRs+cXOKy36HxpMv6kLBv4jLMgSG/A0ULmXen7Fq4G8E3i/v6/OCY09DSWzBGrxo8Jy3
         UCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682096822; x=1684688822;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nsVxuLXGb/HmPw4+8d4rfb4M9t507exbwNDKA5TIVj0=;
        b=gmYQ/9RBj+QkBOsCyjtys7iJMFmvq70tzaoZpWovrrd8/i0jw3S4ezFEsR0YxJ3cUc
         pyYYwGg2JG9O/B84LtXvAx9X3RaFFW/2FzwToF7YyUm/WijnAFVyhxGVtMsdp/hkTWzd
         JYtWTZ5b1kBloD8mn4saWzT2Tmwcacxsw0czJy+1MQerg0vhoBgefhkoyG41ti7diILV
         OTFg4DTW9ungS7O2IFbn5zoRktzBXkS8GnnvO2yYhkdG9cPGwNaUEtjL8zZae0Df12xg
         YekZPIeIK0w+6FFDO/2hpe6gEdswHMsnnfd95YmCeei4qpqQYp+SfbfBTcGn3JpA8xcO
         q9TA==
X-Gm-Message-State: AAQBX9cs+nmnublTkBFucRvUFJSVLWHZwBrkK/1TenHbSIEqbVp1Cg8e
        jWCeOPAOl4ODk7xcMgT96W6Jig==
X-Google-Smtp-Source: AKy350bmI8zPG+zpUhZ0o7e9UHzK1WMARz2ilni8s0oJ+vuQJEaH/EH2o7WV5UWwWtdWpkO+jf8JFA==
X-Received: by 2002:ac2:4821:0:b0:4e8:221f:5886 with SMTP id 1-20020ac24821000000b004e8221f5886mr1532394lft.19.1682096821884;
        Fri, 21 Apr 2023 10:07:01 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id x24-20020a19f618000000b004db3e7dfb8csm616096lfe.189.2023.04.21.10.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 10:07:01 -0700 (PDT)
Message-ID: <bc723ffd-73cd-0339-c2aa-42b3db5a3560@linaro.org>
Date:   Fri, 21 Apr 2023 20:07:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/3] DRM: Create new Content Protection connector
 property
Content-Language: en-GB
To:     Mark Yacoub <markyacoub@chromium.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     seanpaul@chromium.org, dianders@chromium.org,
        linux-kernel@vger.kernel.org
References: <20230421162749.360777-1-markyacoub@google.com>
 <20230421162749.360777-3-markyacoub@google.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230421162749.360777-3-markyacoub@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2023 19:27, Mark Yacoub wrote:
> From: Mark Yacoub <markyacoub@chromium.org>

Nit: is there a reason for this header? My first impression is that it 
matches your outgoing name & email address and as such is not necessary.

Nit#2: subject should mention 'Key', as you are creating a property for 
the key.

> 
> [Why]
> To enable Protected Content, some drivers require a key to be injected
> from user space to enable HDCP on the connector.
> 
> [How]
> Create new "Content Protection Property" of type "Blob"

Generic observation is that the ability to inject HDCP keys manually 
seems to be quite unique to your hardware. As such, I think the debugfs 
or sysfs suits better in comparison to the DRM property.

> 
> Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
> ---
>   drivers/gpu/drm/drm_atomic_uapi.c | 9 +++++++++
>   include/drm/drm_connector.h       | 6 ++++++
>   include/drm/drm_mode_config.h     | 6 ++++++
>   3 files changed, 21 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> index d867e7f9f2cd5..e20bc57cdb05c 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -749,6 +749,11 @@ static int drm_atomic_connector_set_property(struct drm_connector *connector,
>   		state->content_protection = val;
>   	} else if (property == config->hdcp_content_type_property) {
>   		state->hdcp_content_type = val;
> +	} else if (property == config->content_protection_key_property) {
> +		ret = drm_atomic_replace_property_blob_from_id(
> +			dev, &state->content_protection_key, val, -1, -1,
> +			&replaced);
> +		return ret;
>   	} else if (property == connector->colorspace_property) {
>   		state->colorspace = val;
>   	} else if (property == config->writeback_fb_id_property) {
> @@ -843,6 +848,10 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
>   		*val = state->content_protection;
>   	} else if (property == config->hdcp_content_type_property) {
>   		*val = state->hdcp_content_type;
> +	} else if (property == config->content_protection_key_property) {
> +		*val = state->content_protection_key ?
> +			       state->content_protection_key->base.id :
> +			       0;
>   	} else if (property == config->writeback_fb_id_property) {
>   		/* Writeback framebuffer is one-shot, write and forget */
>   		*val = 0;
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 7b5048516185c..2fbe51272bfeb 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -896,6 +896,12 @@ struct drm_connector_state {
>   	 */
>   	unsigned int content_protection;
>   
> +	/**
> +	 * @content_protection_key: DRM blob property for holding the Content
> +	 * Protection Key injected from user space.
> +	 */
> +	struct drm_property_blob *content_protection_key;
> +
>   	/**
>   	 * @colorspace: State variable for Connector property to request
>   	 * colorspace change on Sink. This is most commonly used to switch
> diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
> index e5b053001d22e..615d1e5f57562 100644
> --- a/include/drm/drm_mode_config.h
> +++ b/include/drm/drm_mode_config.h
> @@ -887,6 +887,12 @@ struct drm_mode_config {
>   	 */
>   	struct drm_property *hdcp_content_type_property;
>   
> +	/**
> +	 * @content_protection_key_property: DRM blob property that receives the
> +	 * content protection key from user space to be injected into the kernel.
> +	 */
> +	struct drm_property *content_protection_key_property;
> +
>   	/* dumb ioctl parameters */
>   	uint32_t preferred_depth, prefer_shadow;
>   

-- 
With best wishes
Dmitry

