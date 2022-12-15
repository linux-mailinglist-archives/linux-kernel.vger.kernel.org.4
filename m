Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7F464D94E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 11:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiLOKNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 05:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiLOKNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 05:13:12 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2601926AFC
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 02:13:11 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id v11so9405853ljk.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 02:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dq2vrlwDc/pcOx3EDWN16MaZnUyWNNZ9wxctRH/iUDc=;
        b=pziXf/ZboIPanNuGpPFrAu5JQ0BCZ8SnHV17yorcCLrhXmfacq5tX11/0sgoHfGYlF
         kpxWnkSOCoeIpVi2MnLGGwMeJVfrKDFDnuXsAnZxMZuQBjpdASMRMCMAcEBlbn4JqLmA
         14xp2UVTVuTkLEBkrYTpyOPPWP4taThbcEGRnTPfgyh7BS8TrihwFHjCarJ0C8s23iO/
         5aB2GPzTf8PCZQGo6fYDO3jKsB94fBVPRZwJGnYOUumgt7mJ71VIyEJfBfawWHr0YjWK
         MDi/X9o1ChqBmXDN1Sjfh2N7IFi23BvXm8aKA7voJ4NKNPXS3LNOApvDj3+jxim2pXdg
         t8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dq2vrlwDc/pcOx3EDWN16MaZnUyWNNZ9wxctRH/iUDc=;
        b=JTXGQOJlUpQh6RtB8WgLB9Zp1/DPQLX0PG34ukMhyJfR4ljflMVg0QYIhBnh0CE2lQ
         SHRRMDWFgHK27wkDxhlboik8PnKzaV1zLuPAOgBPMHNgGrl8PO0CNCQaAtO9Yh8/b8bY
         ukfUMXoRPxEUiwq75bZTEKkec/FcgWDu9a2nzIMFFyf1VqzpqQ5PWie0gok8QleaoccL
         P87BQIXxjbIzRL2XGjp5N4hOf3UpvILsTOCekrQnepH5G+H15hJVz+dYWafaBMj5E1R4
         VQRGW0oGF7r3+4TIuWddnoQcGm8wVeyNtR0phV5lakrPGk1gIYx655IMjJvY363Bfogt
         zc3Q==
X-Gm-Message-State: ANoB5pmqnQC4bHrykgsxeKNhkFeSXKVqFfWQHjXEVU+PmksD1Y00lS43
        t8WvSVKfGOqfoMWViLGQHIHjYw==
X-Google-Smtp-Source: AA0mqf6PbJFqvC7fn8BReEsGcPP5B3CQXctlxPM/fe7Aziu8TpWLzMvyBQYrVMoYVwP8mybNQM31Vw==
X-Received: by 2002:a05:651c:3c1:b0:27a:3eeb:66c4 with SMTP id f1-20020a05651c03c100b0027a3eeb66c4mr5065199ljp.26.1671099189459;
        Thu, 15 Dec 2022 02:13:09 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p7-20020a2eb7c7000000b0027c1395ca13sm478167ljo.41.2022.12.15.02.13.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 02:13:09 -0800 (PST)
Message-ID: <035e9326-d507-2930-d1ab-22b95af035f8@linaro.org>
Date:   Thu, 15 Dec 2022 11:13:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH net] arm64: dts: imx8dxl: Disable hibernation mode of
 AR8031 for EQOS
Content-Language: en-US
To:     wei.fang@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Frank.Li@nxp.com, shenwei.wang@nxp.com,
        xiaoning.wang@nxp.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221215093627.956417-1-wei.fang@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221215093627.956417-1-wei.fang@nxp.com>
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

On 15/12/2022 10:36, wei.fang@nxp.com wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> The hibernation mode of AR8031 PHY defaults to be enabled after hardware
> reset. When the cable is unplugged, the PHY will enter hibernation mode
> after about 10 senconds and the PHY clocks will be stopped to save
> power. However, due to the design of EQOS, the mac needs the RX_CLK of
> PHY for software reset to complete. Otherwise the software reset of EQOS
> will be failed and do not work correctly. The only way is to disable
> hibernation mode of AR8031 PHY for EQOS, the "qca,disable-hibernation-mode"
> property is used for this purpose and has already been submitted to the
> upstream, for more details please refer to the below link:
> https://lore.kernel.org/netdev/20220818030054.1010660-2-wei.fang@nxp.com/

This is not a patch for net-next as you indicate in the subject. DTS
patches go via SoC platform maintainers.

Best regards,
Krzysztof

