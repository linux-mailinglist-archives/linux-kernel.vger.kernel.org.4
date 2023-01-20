Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1077675BC8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjATRmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjATRmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:42:21 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8325F6E40A
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:42:18 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id r2so5498506wrv.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VDZkhqwFOsgIMnr1ffA8Wl9YS35ktcX3ijiYmPNgJyc=;
        b=oB2RYPntMat4uRWwi//YXNXL76SLyz8fEv0Jznjb62D98tEATsMU/ZDIdky+Fq7wKl
         Uze/1ee3DQzUZZcX6Hpc52V/VC+NHN6QonF5LYdHcKKjiWI0uVxZApwCFsGBS8PxU3fa
         sO741v5i66XxXjJAlw8pufEXnPVF6WWfr598Xwdjs8T+/xD7qObRf60hpZxl01QPePng
         1OftdfPiHPJSMwoZ8X12u4IT2F9MXwBH9ytf0o9GYNsmiUu0BVHZdgZR3S2R5Bftzo+6
         xg9Lyc2z+e1kMkxWVFmfcahlZCPCqVTcr3jdi4/cgaHKe0JxtmJ/QkM0P0m5xfhbql6R
         sY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VDZkhqwFOsgIMnr1ffA8Wl9YS35ktcX3ijiYmPNgJyc=;
        b=En1ErreOodJKTppQApdEU3SFj43XeWQ3zeaAbCB2XLHio+fM7vEccPu+ZxUsYPZwcl
         EkgUTP7dI4E3L1oAiPoLtIYIjdZg9csb18lQpmBaC5RyZ5z9PxUYP896uROHp8y/jXMi
         feLaMMAWToSjM0gZSzeTIWtLSYoKALWQy7PJFYCQbas24IvN8kMuiyQPAtWnO/JPCOWg
         wllxT+CAgb+g18/ahwTnR+n7n5IlMrP8cTk9y67duyGH19mgw89Es0POnbvQhp86bL42
         1x9LRqm7ZhWVukF6XSDayy852bgbUuZzEWX6S7LZM5UrC+ZN8X0YDF7FEA22vfgrVWmE
         /U9g==
X-Gm-Message-State: AFqh2kqmtGK26qlJrCx/AAQRILARByuN3gdMxorGQmYrp00ZkiKYZeJS
        zQAWs5IwyPbuE19G0hlwtBT8yw==
X-Google-Smtp-Source: AMrXdXvfmB6jJvru/xlfNUOX0PYXnlRnAIySB/9Oaj3KA00ntii9qjhOJPKti8muOdsK1HdA5OI10A==
X-Received: by 2002:a5d:4a51:0:b0:2be:57b5:d50b with SMTP id v17-20020a5d4a51000000b002be57b5d50bmr2802921wrs.3.1674236537252;
        Fri, 20 Jan 2023 09:42:17 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id l5-20020adfe9c5000000b002238ea5750csm22416303wrn.72.2023.01.20.09.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 09:42:16 -0800 (PST)
Message-ID: <2b77d20c-efe4-a0f3-4260-5817f3068eb0@linaro.org>
Date:   Fri, 20 Jan 2023 17:42:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 3/3] nvmem: stm32: detect bsec pta presence for
 STM32MP15x
Content-Language: en-US
To:     Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     Etienne CARRIERE <etienne.carriere@linaro.org>,
        Fabrice GASNIER <fabrice.gasnier@foss.st.com>,
        Amelie DELAUNAY <amelie.delaunay@foss.st.com>,
        Lionel DEBIEVE <lionel.debieve@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20230118172940.841094-1-patrick.delaunay@foss.st.com>
 <20230118182856.v6.3.I59210046e368cfc22bd3cca2afe1653674f8ece8@changeid>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230118182856.v6.3.I59210046e368cfc22bd3cca2afe1653674f8ece8@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/01/2023 17:29, Patrick Delaunay wrote:
> On STM32MP15x SoC, the SMC backend is optional when OP-TEE is used;
> the PTA BSEC should be used as it is done on STM32MP13x platform,
> but the BSEC SMC can be also used: it is a legacy mode in OP-TEE,
> not recommended but used in previous OP-TEE firmware.
> 
> The presence of OP-TEE is dynamically detected in STM32MP15x device tree
> and the supported NVMEM backend is dynamically detected:
> - PTA with stm32_bsec_pta_find
> - SMC with stm32_bsec_check
> 
> With OP-TEE but without PTA and SMC detection, the probe is deferred for
> STM32MP15x devices.
> 
> On STM32MP13x platform, only the PTA is supported with cfg->ta = true
> and this detection is skipped.
> 
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Reviewed-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---


Applied thanks,

--srini

> 
> Changes in v6:
> - added reviewed by Etienne Carriere
> 
> Changes in v5:
> - update the BSEC SMC detection logic in stm32_romem_probe()
>    after Etienne Carierre review to support NVMEM probe after OP-TEE probe
> 
> Changes in v3:
> - use of_find_compatible_node in optee_presence_check function
>    instead of of_find_node_by_path("/firmware/optee")
> 
> Changes in v2:
> - Added patch in the serie for BSEC PTA support on STM32MP15x
>    with dynamic detection of OP-TEE presence and SMC support (legacy mode)
> 
>   drivers/nvmem/stm32-romem.c | 38 +++++++++++++++++++++++++++++++++----
>   1 file changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
> index 978a63edf297..ba779e26937a 100644
> --- a/drivers/nvmem/stm32-romem.c
> +++ b/drivers/nvmem/stm32-romem.c
> @@ -159,6 +159,31 @@ static int stm32_bsec_pta_write(void *context, unsigned int offset, void *buf,
>   	return stm32_bsec_optee_ta_write(priv->ctx, priv->lower, offset, buf, bytes);
>   }
>   
> +static bool stm32_bsec_smc_check(void)
> +{
> +	u32 val;
> +	int ret;
> +
> +	/* check that the OP-TEE support the BSEC SMC (legacy mode) */
> +	ret = stm32_bsec_smc(STM32_SMC_READ_SHADOW, 0, 0, &val);
> +
> +	return !ret;
> +}
> +
> +static bool optee_presence_check(void)
> +{
> +	struct device_node *np;
> +	bool tee_detected = false;
> +
> +	/* check that the OP-TEE node is present and available. */
> +	np = of_find_compatible_node(NULL, NULL, "linaro,optee-tz");
> +	if (np && of_device_is_available(np))
> +		tee_detected = true;
> +	of_node_put(np);
> +
> +	return tee_detected;
> +}
> +
>   static int stm32_romem_probe(struct platform_device *pdev)
>   {
>   	const struct stm32_romem_cfg *cfg;
> @@ -195,11 +220,16 @@ static int stm32_romem_probe(struct platform_device *pdev)
>   	} else {
>   		priv->cfg.size = cfg->size;
>   		priv->lower = cfg->lower;
> -		if (cfg->ta) {
> +		if (cfg->ta || optee_presence_check()) {
>   			rc = stm32_bsec_optee_ta_open(&priv->ctx);
> -			/* wait for OP-TEE client driver to be up and ready */
> -			if (rc)
> -				return rc;
> +			if (rc) {
> +				/* wait for OP-TEE client driver to be up and ready */
> +				if (rc == -EPROBE_DEFER)
> +					return -EPROBE_DEFER;
> +				/* BSEC PTA is required or SMC not supported */
> +				if (cfg->ta || !stm32_bsec_smc_check())
> +					return rc;
> +			}
>   		}
>   		if (priv->ctx) {
>   			rc = devm_add_action_or_reset(dev, stm32_bsec_optee_ta_close, priv->ctx);
