Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B756260BA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 18:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbiKKR5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 12:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbiKKR5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 12:57:41 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE59B63B8C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 09:57:40 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id kt23so14255100ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 09:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWXOKwSCNiWFxa7hmosYdMNO2lwjKLac88kLHIg1Usg=;
        b=aqnolRfgeQFgv3n413nvwSQmeD5Jb3s9CgBYttB5dOy583QFcqmnSx47Hvp9/BBxlL
         GU5otCoTjPAijwt5KBcgwFFCgwczI4rPJ0CW/CyycK+ry9g1UECBtSomlRbxhOX145sk
         U4rfwq7eVT9bp1Clf7inuTRBumR2g0Gl+q5aQftgnxGO/+bqA2549HikvV8o2ehWFSWn
         L5fu1IqgJWGkBOtHkZNmdgmaR9IFqUcl/ELNZU86+7lkXt7AWKJskF9Bhdu2Wdwv0W7E
         jU12avW+714Xj1hEL1Uw560nBmzPPbC/1ezq5HGhCyzABsO34UAFjGwQdDPuZ3mvL82T
         tbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zWXOKwSCNiWFxa7hmosYdMNO2lwjKLac88kLHIg1Usg=;
        b=uhvjzMd9eaexAh/80QikWW56rLIalggkAhGEmAh9EvEZdzzRs0iEN7vV/fwHgfpChK
         D7sqGqFdVvJqsxs4GfE/KWbMUE9S7nFxz9Bn7soLhl2WvSHuOg+YpY8uwgSmUgtbEogn
         ZEOeHZG/PSjJFXG8D4ZVo8xldNGiyrmz1hKleYAST6fVPGNK4Bmxns4zkW+6j36fzSra
         /MNFPwYA9OxjgDl3D/38ghDRlxfqnBGK2zM5ebG2Z8GglxoYmCAdhjDOaKnT/eaBGI7k
         Fm/3K4Yi/l2YafWq+jzwDeLz8oYy4pem7sHW+e6wyXTLg7TIYpZJtG3yrrj9Sa5RD4vz
         HXHA==
X-Gm-Message-State: ANoB5pk5bjPjQHGuLOjb6ApEQL64dC3HFWeUClAk4gh8PnEcW8lsRY0l
        1BTZRX+ctkjitpcunm5CAJwiL5FdAaU=
X-Google-Smtp-Source: AA0mqf4ClbOP6Zp5M/XQHBSOfGSTG/lejqc7KON1WJwIhfWlORYzuSILnjBQVf9YCRlJGwMRZx78AA==
X-Received: by 2002:a17:906:81da:b0:78d:a01b:b474 with SMTP id e26-20020a17090681da00b0078da01bb474mr2873993ejx.8.1668189459395;
        Fri, 11 Nov 2022 09:57:39 -0800 (PST)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id c8-20020a056402120800b0045726e8a22bsm1344977edw.46.2022.11.11.09.57.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 09:57:38 -0800 (PST)
Message-ID: <fe41146d-48f9-3e9c-1e5a-48e8488f4fee@gmail.com>
Date:   Fri, 11 Nov 2022 18:57:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH] nvmem: u-boot-env: add Broadcom format support
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     Tom Rini <trini@konsulko.com>,
        linux-arm-kernel@lists.infradead.org, u-boot@lists.denx.de,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
References: <20221017071722.32731-1-zajec5@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20221017071722.32731-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.10.2022 09:17, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Broadcom uses U-Boot for a lot of their bcmbca familiy chipsets. They
> decided to store U-Boot environment data inside U-Boot partition and to
> use a custom header (with "uEnv" magic and env data length).
> 
> Add support for Broadcom's specific binding and their custom format.
> 
> Ref: c34f9f5499278 ("dt-bindings: nvmem: u-boot,env: add Broadcom's variant binding")

This should be actually:
6b0584c19d87 ("dt-bindings: nvmem: u-boot,env: add Broadcom's variant binding")

Srinivas: could you fix it up while applying, please?


> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>   drivers/nvmem/u-boot-env.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
> index 8e72d1bbd649..049330660fd7 100644
> --- a/drivers/nvmem/u-boot-env.c
> +++ b/drivers/nvmem/u-boot-env.c
> @@ -16,6 +16,7 @@
>   enum u_boot_env_format {
>   	U_BOOT_FORMAT_SINGLE,
>   	U_BOOT_FORMAT_REDUNDANT,
> +	U_BOOT_FORMAT_BROADCOM,
>   };
>   
>   struct u_boot_env {
> @@ -40,6 +41,13 @@ struct u_boot_env_image_redundant {
>   	uint8_t data[];
>   } __packed;
>   
> +struct u_boot_env_image_broadcom {
> +	__le32 magic;
> +	__le32 len;
> +	__le32 crc32;
> +	uint8_t data[0];
> +} __packed;
> +
>   static int u_boot_env_read(void *context, unsigned int offset, void *val,
>   			   size_t bytes)
>   {
> @@ -138,6 +146,11 @@ static int u_boot_env_parse(struct u_boot_env *priv)
>   		crc32_data_offset = offsetof(struct u_boot_env_image_redundant, mark);
>   		data_offset = offsetof(struct u_boot_env_image_redundant, data);
>   		break;
> +	case U_BOOT_FORMAT_BROADCOM:
> +		crc32_offset = offsetof(struct u_boot_env_image_broadcom, crc32);
> +		crc32_data_offset = offsetof(struct u_boot_env_image_broadcom, data);
> +		data_offset = offsetof(struct u_boot_env_image_broadcom, data);
> +		break;
>   	}
>   	crc32 = le32_to_cpu(*(__le32 *)(buf + crc32_offset));
>   	crc32_data_len = priv->mtd->size - crc32_data_offset;
> @@ -202,6 +215,7 @@ static const struct of_device_id u_boot_env_of_match_table[] = {
>   	{ .compatible = "u-boot,env", .data = (void *)U_BOOT_FORMAT_SINGLE, },
>   	{ .compatible = "u-boot,env-redundant-bool", .data = (void *)U_BOOT_FORMAT_REDUNDANT, },
>   	{ .compatible = "u-boot,env-redundant-count", .data = (void *)U_BOOT_FORMAT_REDUNDANT, },
> +	{ .compatible = "brcm,env", .data = (void *)U_BOOT_FORMAT_BROADCOM, },
>   	{},
>   };
>   
