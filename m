Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74D365A3C8
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 12:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbiLaLny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 06:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiLaLnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 06:43:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803246585;
        Sat, 31 Dec 2022 03:43:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09823B8037A;
        Sat, 31 Dec 2022 11:43:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA35C433D2;
        Sat, 31 Dec 2022 11:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672487028;
        bh=2BRHVCnJSCiNgdpz8pKFueVlfuaotxlZrd19TYFK35o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YMuSquco7gBP+J0YHBdGMkYhxpHBiX2ox61JPfmtbNIbGCtkEU6FjeoTu+ovMHkZA
         LA3lnDWI28Q91jvK/MtTNcsSwxOjr047/7zULiY89b8XRf456JRLwrsAQ5V7d9LPKD
         pbs3k8F9l5Sku4IrixPb7vrjzY8sU44HPvU5iQiXIXIKI7HDrVRAnOjTT9qJhhAw81
         qrREB0zNyInbkea8U32SGsldrBGcRzlY3JikKKP9Vazz/VqrS9jkfqxArtxShTEtb9
         N4o57Ocaa0/pd8m9f57q7Mmq4+GUuQqLO0ZF6kU4kWSKWV1Y6iojTSv9hEx1uiljSp
         MBAdMmjgOZEoQ==
Date:   Sat, 31 Dec 2022 19:43:41 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: imx: align LED node names with dtschema
Message-ID: <20221231114340.GN6112@T480>
References: <20221125144223.477376-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125144223.477376-1-krzysztof.kozlowski@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 03:42:21PM +0100, Krzysztof Kozlowski wrote:
> The node names should be generic and DT schema expects certain pattern:
> 
>   freescale/imx8mm-emcon-avari.dtb: leds: 'green', 'red' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied all, thanks!
