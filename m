Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DEA7020E8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 02:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbjEOA6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 20:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjEOA6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 20:58:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1204C10DB;
        Sun, 14 May 2023 17:58:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A213E611C3;
        Mon, 15 May 2023 00:58:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14CEC433D2;
        Mon, 15 May 2023 00:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684112330;
        bh=stuaiN+1qij1kKKnkaShMdqp55LrmB9j+713LOxNptw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M/tyFrPoQhHTpoH0eksA5FFQCm2u35t0P3Bs44mEMtVzipRlnfHyx67Orl8wFYkqQ
         S2boVdfKyEERdlsIgDlDt+xZ8uvWL7JpBgSewpUJzE/QjL7zX1es9MMGfbEl/Y54pg
         m6oYSACLjTFX5J1IJ67MvbCPj88ZGdsdeQrVcATvehAZaNxlP6rVv1t0NCxrSBWkWY
         0KA86v+7OeRkk0sqn5AIeQMLRoJiZHfCOtb6NcDXqim2aWjMn/osLZ81oBteJgs9X/
         oTHMyCYCtJbQ+biCPB2E9EYP34HjMTBQzGPRril09G1HmdOdVr8/KPgKWLprV3QALv
         CqwADxuh/KRJw==
Date:   Mon, 15 May 2023 08:58:37 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] ARM: dts: imx7ulp: add address/size-cells to OCOTP
Message-ID: <20230515005837.GC727834@dragon>
References: <20230506064255.34290-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230506064255.34290-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 06, 2023 at 08:42:55AM +0200, Krzysztof Kozlowski wrote:
> The OCOTP node should have address/size-cells so the cells can have unit
> address:
> 
>   imx7ulp-evk.dtb: efuse@410a6000: '#address-cells' is a required property
>   imx7ulp-evk.dtb: efuse@410a6000: '#size-cells' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thanks!
