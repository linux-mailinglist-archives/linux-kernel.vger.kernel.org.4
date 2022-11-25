Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EB56385FD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiKYJUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiKYJUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:20:19 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E188B21E0F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 01:20:17 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id t25-20020a1c7719000000b003cfa34ea516so5772632wmi.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 01:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ISdb+dUtFQE23mn3Sm5zJXZGtL0EM+hNc7jB5fdTjWU=;
        b=KfWJH0MV61PIVcxP2H+v0XUG+fDhWmPCIweTT0pCwtBbqhiP1fFIqriLWWAobdsgeE
         O3Y5XiL+/ty3t3b5+Olkymup+itXcCNEr4FAXmxQxqfBmlxLgk7p1HP1+Bm6kIZ38OV6
         7+dgRPB9bHbnifcUdlBvTf+H8NLB4AWmporgRs21DSrpSpOHZJO4e2VRA8yG3soLVtI8
         WGocPPoPCdDMiTGsXs2/XUaB1txtFOpl4yb3jZfPZYPyDhpephP6V9MWNWyrHDbt0jMl
         LseOrl3rM6lxF5ckXZNmPuNtxlmu5rit2YZamH+qBVka/6BEEf+bHkfRN4jvx7ku5mY7
         01EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISdb+dUtFQE23mn3Sm5zJXZGtL0EM+hNc7jB5fdTjWU=;
        b=Hy4woM1UNsxrJS2VbDN8ELX+OJbrVwYEnQiFkUVDbVBrfNqCaW10ajaNALP/NDpG+W
         r3cuJzARTkVov66uHfsQZ1K9eAckCURMs1eYF7h7EXV0KkdgZAMqvkDggdqL3ttLxj5c
         xF7jXQuuw6/CEKgEZNzdI4JwNGWb844dt5T0jlp5P2CrpaRdxTceQXQIQqxazJ4f1Igi
         48NE50NVs5monjFMi1LjrB0miSC9yMhamYa1r0oqaJa6Q8fKpAlpE2HxJ1n21RiDuXnq
         hMgSW/yXv5SXfj7jBURqIKoxBVPGJz/9mvHT7986iEWdlhtUTUpE5fen/gmZ5R5XkH/o
         LW1w==
X-Gm-Message-State: ANoB5pmxC0Ag+ZeYFERv+olfbzqH3b0gPW6aj9MlvClqdB+17UdRsFEF
        FdpN2aWoGG1s8+PFY1LR7dVG+A==
X-Google-Smtp-Source: AA0mqf6xLHvDeiu/Z6ExtpXK2CKkq56d1B8nVjLLDfTveHIw7VKME8D5/QZAvHRmAHsDBGPfpOOmYQ==
X-Received: by 2002:a05:600c:4f01:b0:3cf:8952:2fd2 with SMTP id l1-20020a05600c4f0100b003cf89522fd2mr16887577wmq.9.1669368016405;
        Fri, 25 Nov 2022 01:20:16 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id u22-20020a7bc056000000b003c6c1686b10sm8373254wmc.7.2022.11.25.01.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 01:20:15 -0800 (PST)
Date:   Fri, 25 Nov 2022 11:20:13 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        michael@amarulasolutions.com, Abel Vesa <abelvesa@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 0/5] clk: imx8mn: miscellaneous cleanups and bug fixes
Message-ID: <Y4CIzTRXYGOf1VDy@linaro.org>
References: <20221117113637.1978703-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117113637.1978703-1-dario.binacchi@amarulasolutions.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-11-17 12:36:32, Dario Binacchi wrote:
> This series has been tested on the BSH SystemMaster (SMM) S2 board.
> 

Applied to my tree. Thanks!

> Changes in v2:
> - Update the commit message.
> - Add Fixes tag.
> - Maintain IMX8MN_VPU_* constants to not break backward compatibility.
> - Update the commit message.
> - Add Fixes tag.
> - Maintain IMX8MN_VIDEO_PLL1* constants to not break backward
>   compatibility.
> 
> Dario Binacchi (5):
>   clk: imx8mn: rename vpu_pll to m7_alt_pll
>   clk: imx: replace osc_hdmi with dummy
>   clk: imx: rename video_pll1 to video_pll
>   clk: imx8mn: fix imx8mn_sai2_sels clocks list
>   clk: imx8mn: fix imx8mn_enet_phy_sels clocks list
> 
>  drivers/clk/imx/clk-imx8mn.c             | 116 +++++++++++------------
>  include/dt-bindings/clock/imx8mn-clock.h |  24 +++--
>  2 files changed, 74 insertions(+), 66 deletions(-)
> 
> -- 
> 2.32.0
> 
