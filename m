Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C166A653F1A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 12:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbiLVLgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 06:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235507AbiLVLgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:36:39 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DB817AA9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:36:37 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id x11so1604189ljh.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k8ovNiEd3+d9vW4JWY2O+ZJ++GaJUJscaofUT8dlIPo=;
        b=MJuVMd2RNOafk2cpPqvWO0KAqWKJ2lO+GWjGVV4e6b+t8MxEyOzDp6UkJeGl328Qv7
         FQuiEa5w7HJzy5NodhD34c9Z8woOyddzB3qDAlLUcCzEPKfIb+gulw/9Q35TksrIaXrJ
         BrLVJ4ZNgiZLcultIW+KzwL8DeaIVupzbMNQlzYpxJWL85XZQBd+EOV2wOLYa/FFRSno
         GI4IlUh2ftCyku6hFTS4SGiFWu/+tQfzjK2fIrzhW7fxnSp3nCbvT9t+Y1WWt2KfJgTx
         CEXfpU+CUokK7tvX9kh2gVHr+luLrh+0bqFaM/fg+odoz2eyNUzayiSLXUZDc/ouMBR6
         zzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k8ovNiEd3+d9vW4JWY2O+ZJ++GaJUJscaofUT8dlIPo=;
        b=uramKZi7pI2K6b0nZPkGSez6FJbqV7Fae4LA/T9cU6j9kUDERSMH5cAP8SriWbCoNC
         FMeRp9eJYodcMRMeoL5Yjc6p5eLWEYtOZdEG5OI35Z8aLL9fkHgYx5WdDzUt5UIMmIkn
         JgDavuI7uVwvgK79/LQBfI87zJTBLb0lN9RwiGraRS6CdoKUqyvyN4nhvwhq1r0c78TK
         RX9QaY+2VRynjxcpZ+z+WY0zEetvz8CYWZDr2epaVTopgi8r2SEeGDM1MxYD3Nin6MDj
         RM6MCBV4/+ywL7NVilWdravARuprM77NmHdwHjrt+LtfbcmXynyqdDjPO3Q7zTNlpfK0
         1mWw==
X-Gm-Message-State: AFqh2kox3Tq8YIr/u3OkUm2K94ZW21aamVTnZF83fQfx/CmM4uDwItuV
        ocpGqbctjPw2VGftDLfZFfAHGQ==
X-Google-Smtp-Source: AMrXdXvul5VWYerQOWEQXRFotaQ4uLAyISoNxGwItocjRdpcahtB5l6N+Kb4iaBXLA3WzwUcCwkddg==
X-Received: by 2002:a2e:9258:0:b0:279:f9a4:fbc with SMTP id v24-20020a2e9258000000b00279f9a40fbcmr1417188ljg.11.1671708995751;
        Thu, 22 Dec 2022 03:36:35 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id g11-20020a2eb5cb000000b00279ee47099dsm22393ljn.116.2022.12.22.03.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 03:36:35 -0800 (PST)
Message-ID: <ec955be9-affb-e84c-0b27-c27235608a81@linaro.org>
Date:   Thu, 22 Dec 2022 12:36:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [Patch v1 04/10] memory: tegra: add support for software mc
 clients in Tegra234
Content-Language: en-US
To:     Sumit Gupta <sumitg@nvidia.com>, treding@nvidia.com,
        dmitry.osipenko@collabora.com, viresh.kumar@linaro.org,
        rafael@kernel.org, jonathanh@nvidia.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     sanjayc@nvidia.com, ksitaraman@nvidia.com, ishah@nvidia.com,
        bbasu@nvidia.com
References: <20221220160240.27494-1-sumitg@nvidia.com>
 <20221220160240.27494-5-sumitg@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221220160240.27494-5-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2022 17:02, Sumit Gupta wrote:
> Adding support for dummy memory controller clients for use by
> software.

Use imperative mode (applies to other commits as well)
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> ---
>  drivers/memory/tegra/mc.c       | 65 +++++++++++++++++++++++----------
>  drivers/memory/tegra/tegra234.c | 21 +++++++++++
>  include/soc/tegra/mc.h          |  3 ++
>  include/soc/tegra/tegra-icc.h   |  7 ++++
>  4 files changed, 76 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
> index ff887fb03bce..4ddf9808fe6b 100644
> --- a/drivers/memory/tegra/mc.c
> +++ b/drivers/memory/tegra/mc.c
> @@ -755,6 +755,39 @@ const char *const tegra_mc_error_names[8] = {
>  	[6] = "SMMU translation error",
>  };
>  
> +static int tegra_mc_add_icc_node(struct tegra_mc *mc, unsigned int id, const char *name,
> +				 unsigned int bpmp_id, unsigned int type)
> +{
> +	struct tegra_icc_node *tnode;
> +	struct icc_node *node;
> +	int err;
> +
> +	tnode = kzalloc(sizeof(*tnode), GFP_KERNEL);
> +	if (!tnode)
> +		return -ENOMEM;
> +
> +	/* create MC client node */
> +	node = icc_node_create(id);
> +	if (IS_ERR(node))
> +		return -EINVAL;

Why do you return other error? It does not look like you moved the code
correctly, but with changes. I also do not see how this is related to
commit msg...

> +
> +	node->name = name;
> +	icc_node_add(node, &mc->provider);
> +
> +	/* link Memory Client to Memory Controller */
> +	err = icc_link_create(node, TEGRA_ICC_MC);
> +	if (err)
> +		return err;
> +
> +	node->data = tnode;
> +	tnode->node = node;
> +	tnode->bpmp_id = bpmp_id;
> +	tnode->type = type;
> +	tnode->mc = mc;
> +
> +	return 0;
> +}
> +
>  /*
>   * Memory Controller (MC) has few Memory Clients that are issuing memory
>   * bandwidth allocation requests to the MC interconnect provider. The MC
> @@ -780,7 +813,6 @@ const char *const tegra_mc_error_names[8] = {
>   */
>  static int tegra_mc_interconnect_setup(struct tegra_mc *mc)
>  {
> -	struct tegra_icc_node *tnode;
>  	struct icc_node *node;
>  	unsigned int i;
>  	int err;
> @@ -820,30 +852,23 @@ static int tegra_mc_interconnect_setup(struct tegra_mc *mc)
>  		goto remove_nodes;
>  
>  	for (i = 0; i < mc->soc->num_clients; i++) {
> -		tnode = kzalloc(sizeof(*tnode), GFP_KERNEL);
> -		if (!tnode)
> -			return -ENOMEM;
> -
> -		/* create MC client node */
> -		node = icc_node_create(mc->soc->clients[i].id);
> -		if (IS_ERR(node)) {
> -			err = PTR_ERR(node);
> +		err = tegra_mc_add_icc_node(mc, mc->soc->clients[i].id,
> +					    mc->soc->clients[i].name,
> +					    mc->soc->clients[i].bpmp_id,
> +					    mc->soc->clients[i].type);
> +		if (err)
>  			goto remove_nodes;
> -		}
>  
> -		node->name = mc->soc->clients[i].name;
> -		icc_node_add(node, &mc->provider);
> +	}
> +

Best regards,
Krzysztof

