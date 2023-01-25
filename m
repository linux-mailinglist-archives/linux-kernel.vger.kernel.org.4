Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96DA67BCA8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbjAYUfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjAYUfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:35:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9412A3F298;
        Wed, 25 Jan 2023 12:35:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44733B819C1;
        Wed, 25 Jan 2023 20:35:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60F8C433D2;
        Wed, 25 Jan 2023 20:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674678916;
        bh=8U2DugR9MKz12cxFiXKOhg5icyU2FP2WpZ+gq9wbYaA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=OQH3KGpP8uLcJIeQ6j+iZSMcfDEhvOegromXyLnN+AYR9+IMAXXnDLLYyW79LSYHz
         2LR6a8xl8Uevg21g23XOMaa49u8at72bYs8Ox2L+TnH9fdpNeDNoXlA4DTdkVtLvye
         sBBMlZgYqlMyzN6uxjbrxhJe7Fl+iU3fflfNPruzh1cDGtGhWD8CkcLR7dw6hGXryU
         nMzvM1wPSWXePgfrknMw/fksQapG+m4oLaFpWsVkb4MRqVfq3RavNAR8ImiPPZyug+
         Yp1pS3KFJ8Va2/ouZ06qV/ZmUcZkObTgYruNotw+DibQTcDxRGTpk+sq6Yt3h71Os7
         ifLkpMloV5Y/g==
Message-ID: <e9277836f6797a1b2aaca2300190da9a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230125104520.89684-4-quic_kathirav@quicinc.com>
References: <20230125104520.89684-1-quic_kathirav@quicinc.com> <20230125104520.89684-4-quic_kathirav@quicinc.com>
Subject: Re: [PATCH 03/10] clk: qcom: Add STROMER PLUS PLL type for IPQ5332
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Kathiravan T <quic_kathirav@quicinc.com>
To:     Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, arnd@arndb.de,
        bhupesh.sharma@linaro.org, broonie@kernel.org,
        catalin.marinas@arm.com, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, marcel.ziswiler@toradex.com,
        mturquette@baylibre.com, nfraprado@collabora.com,
        quic_gurus@quicinc.com, robh+dt@kernel.org, robimarko@gmail.com,
        shawnguo@kernel.org, ulf.hansson@linaro.org, will@kernel.org
Date:   Wed, 25 Jan 2023 12:35:13 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kathiravan Thirumoorthy (2023-01-25 02:45:13)
> From: Kathiravan T <quic_kathirav@quicinc.com>
>=20
> Add the support for stromer plus pll, which is found on the IPQ5332
> SoCs. Programming sequence is same as the stromer pll, so we can re-use
> the same.
>=20
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

I'm amazed that we need so many different register layouts for PLLs. Was
it really never standardized? So sad.
