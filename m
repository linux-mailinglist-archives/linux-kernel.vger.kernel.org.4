Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6CF66B1D2
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 16:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjAOPFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 10:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjAOPFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 10:05:10 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D08DCDE6
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 07:05:08 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id w14so20285279edi.5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 07:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NBz7cqiVd9e6aGzJO6sSxgMMp/c0wf7CWjQCjUZnLOc=;
        b=weB02iuxCQuUjR4eMOm06SjJc0Z5vrhFbbAE3stJQdycLx+dcneNAyyAvcBVrv0NKi
         rbOfYnOrZnjoywNVCrdOlpcifs5m3b5LfAfunprejC+QfIkhbn2jP0J4XLqltVfXLxMU
         VOWQHzw8GBkIGUc/zCD7oGEalc5a1FtiR68rXVpbj+3WvO6K/fDtFhvh+wTUjCNgb9T8
         HarYW4HESB2aXafQJM7jfvZsexB3Bf+RyFVyDNOiPhsRx3V3wG7OX+9bou/WXkJl10Ce
         Z/61GHe94sVipTyZmoHoLldfNABGWSPI6WlVKtpIzUN1dTOEhVnt5Fobj32C9F+QLeuW
         3t2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NBz7cqiVd9e6aGzJO6sSxgMMp/c0wf7CWjQCjUZnLOc=;
        b=hvn3N830vMnfNNiDA6Vd+8isvoQXEhdTFqQLKni8lHC7omUtagyiNH20ZDyySWV2b7
         NM3lEw2V/e/1XSAT4G7LG0+CTw2qi/rooNsMFDX7jPimNxux1zXlVoPnjNn40uH7H9Vh
         DccCTMyZS2WrRI6NGYad3gndY2pjUo7np8VgS0Rj6Hl6bcfnAcyPPfnyQXSw3vx6513S
         uzJl0KlSLpLCBuoeXF25kQqEXjplA7la3xkO1VW1T+i2mxF0I/wZ15oqtBXaZey+YpOB
         8SGsPuOD3H+xavDK+GACqLzkqIT9Erybj/M/L+lx76sj9GzgCCHswewcpFrGF+A5jRir
         4uCg==
X-Gm-Message-State: AFqh2koPFGxV6vAEsc4PYEo20jQuAiua2ZOpjwDj35b4q7Tg7SsDWHxn
        smGxaMuPbOBb4g1DlsE/x29ZBQ==
X-Google-Smtp-Source: AMrXdXtMA5nHafq8S3q65oQm07Cx3buGe5X/vT5EvmcIHYotqgTk9qjfEoOx470xrqgup9PRfNMbsg==
X-Received: by 2002:a05:6402:528f:b0:47e:eaae:9a69 with SMTP id en15-20020a056402528f00b0047eeaae9a69mr78754776edb.41.1673795107259;
        Sun, 15 Jan 2023 07:05:07 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id c39-20020a509faa000000b00483cccdfeaesm10646282edf.38.2023.01.15.07.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jan 2023 07:05:06 -0800 (PST)
Message-ID: <55e2d839-1488-c5a9-0ef8-55248554b86a@linaro.org>
Date:   Sun, 15 Jan 2023 16:05:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 3/5] arm64: dts: fsd: Add I2S DAI node for Tesla FSD
Content-Language: en-US
To:     Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        perex@perex.cz, tiwai@suse.com, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, rcsekar@samsung.com,
        aswani.reddy@samsung.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
References: <20230113121749.4657-1-p.rajanbabu@samsung.com>
 <CGME20230113121825epcas5p30053dc48475ee6a8cf33bd5112d9d6ed@epcas5p3.samsung.com>
 <20230113121749.4657-4-p.rajanbabu@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230113121749.4657-4-p.rajanbabu@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2023 13:17, Padmanabhan Rajanbabu wrote:
> Add device tree node for I2S0 and I2S1 CPU DAI instances for Tesla
> FSD platform.
> 
> FSD SoC has 2 I2S instances driving stereo channel I2S audio playback
> and capture with external DMA support.
> 
> Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
> ---
>  arch/arm64/boot/dts/tesla/fsd-evb.dts      |  8 +++++
>  arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi | 14 +++++++++
>  arch/arm64/boot/dts/tesla/fsd.dtsi         | 34 ++++++++++++++++++++++
>  3 files changed, 56 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts b/arch/arm64/boot/dts/tesla/fsd-evb.dts
> index 1db6ddf03f01..cf5f2ce4d2a7 100644
> --- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
> +++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
> @@ -38,6 +38,14 @@
>  	status = "okay";
>  };
>  
> +&i2s_0 {
> +	status = "okay";
> +};
> +
> +&i2s_1 {
> +	status = "okay";
> +};
> +

You need to rebase.

>  &ufs {
>  	status = "okay";
>  };

Best regards,
Krzysztof

