Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8BC6DC026
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 15:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjDINqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 09:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjDINqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 09:46:24 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D673A9B
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 06:46:22 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id dm2so7109020ejc.8
        for <linux-kernel@vger.kernel.org>; Sun, 09 Apr 2023 06:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681047981; x=1683639981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fv1Htcq000795meXUCt94e3ZQK9pCFAbOsZ+LsTps1o=;
        b=GzZ0Sfy4wKkDs1EgCXEYxzTTBKeM1btI1U2KzPgExEY4H6r2CJj2YX6YMPBG1akYpB
         1EPc3MSCKgQ9CCoCruLnDpk3tJEfwTdf64XerXrMqiv8/ybwdd1zJV4ukk8f9KY9Axzy
         NFDGonSvLxDvJCzteSbKYv99I9Oodr7aSwsFF7yAC7Ehqzl9iH6AfKZJHoIYZawlYKUS
         Y3zUWTH8VCBH2saZ4jbRAMlTl+QEqFS9WGeEeJJS1eLi6JoTnBEHum5M/N97+XHt7WIZ
         3DEO/1HXkUf13VwHF9caxaIKUs7koQN4cBen5OEgqbt04mVKsDsqSUMoAibpjqcj9pyA
         i0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681047981; x=1683639981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fv1Htcq000795meXUCt94e3ZQK9pCFAbOsZ+LsTps1o=;
        b=KvZgw+fnMtKHbHhy+8FiTmZVmYPZZ6gdmzTy/+yIE9rSNkUq9mIisY+pKP8GRkLcVk
         rFTQ4frPCTLBt946jvQma2rXXH3HajbDnH+3xbjgxOscv1njvqQ4XPYaO0t8Fg2VooTg
         TXZD0nfyaujKyWsduYd+ytjNexyjJqpPdKN/S2p1ICbhYlXnT/cwf1JqLdPNesJuVoI5
         h4LU/jPAhowRhnHLC+S7T5UMsvz/qTy9SQDgldztt3MCooswk6IE73VpxotJ4irwqtb+
         QlPuFdbTYcL/6t5DzXEnE5Ori3pCf2kdMv8yNQKaHL9DGNymmr5euR8/119UxxVdgeM0
         U8mg==
X-Gm-Message-State: AAQBX9fPFQgSckxqPFcBVkEhZLTA3v+EPwtPcCyVCXuMt0rg2F448RXK
        g4WXflf9EyOv9YNvpsYPk9dIDw==
X-Google-Smtp-Source: AKy350ZI+1T5LtiV9iDPsr8PJ+ruphexg15E+ozh+duVVEi9yDsmhR/OTWpZPwIik/6Pw/KHoX3Neg==
X-Received: by 2002:a17:906:9711:b0:94a:76f6:8e52 with SMTP id k17-20020a170906971100b0094a76f68e52mr1165889ejx.35.1681047981234;
        Sun, 09 Apr 2023 06:46:21 -0700 (PDT)
Received: from linaro.org ([188.25.26.161])
        by smtp.gmail.com with ESMTPSA id mm25-20020a170906cc5900b0093e9fb91837sm4154400ejb.76.2023.04.09.06.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Apr 2023 06:46:20 -0700 (PDT)
Date:   Sun, 9 Apr 2023 16:46:19 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jacky Bai <ping.bai@nxp.com>, Ye Li <ye.li@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3 4/7] clk: imx: fracn-gppll: Add 300MHz freq support
 for imx9
Message-ID: <ZDLBq3WJOVoFbnV/@linaro.org>
References: <20230403095300.3386988-1-peng.fan@oss.nxp.com>
 <20230403095300.3386988-5-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403095300.3386988-5-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-04-03 17:52:57, Peng Fan (OSS) wrote:
> From: Jacky Bai <ping.bai@nxp.com>
> 
> Add 300MHz frequency config support on i.MX93 PLL.
> 
> Reviewed-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  drivers/clk/imx/clk-fracn-gppll.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
> index e2633ad94640..c54f9999da04 100644
> --- a/drivers/clk/imx/clk-fracn-gppll.c
> +++ b/drivers/clk/imx/clk-fracn-gppll.c
> @@ -85,7 +85,8 @@ static const struct imx_fracn_gppll_rate_table fracn_tbl[] = {
>  	PLL_FRACN_GP(484000000U, 121, 0, 1, 0, 6),
>  	PLL_FRACN_GP(445333333U, 167, 0, 1, 0, 9),
>  	PLL_FRACN_GP(400000000U, 200, 0, 1, 0, 12),
> -	PLL_FRACN_GP(393216000U, 163, 84, 100, 0, 10)
> +	PLL_FRACN_GP(393216000U, 163, 84, 100, 0, 10),
> +	PLL_FRACN_GP(300000000U, 150, 0, 1, 0, 12)
>  };
>  
>  struct imx_fracn_gppll_clk imx_fracn_gppll = {
> -- 
> 2.37.1
> 
