Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A39C6DCB97
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 21:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjDJTbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 15:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjDJTbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 15:31:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026F31BD8;
        Mon, 10 Apr 2023 12:31:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F8BE61EE5;
        Mon, 10 Apr 2023 19:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6552C433D2;
        Mon, 10 Apr 2023 19:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681155096;
        bh=j0W1NgpsGtMj+qMWpb0ESDcDqJCah6edrt3yjwegYDM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=LSNvJyrDwPkm6jr0O6Ny1HLBf2vqWINPXcQUMmXjl8Rj6KALbsiP0bnGfcrIKCClC
         4+DI1mmLfWvGh7dR6NHk2N6BD5R7l/m9lAxdTnJCgagT3heTtg0QwooxYlu+SdyyLt
         EvjHIwkyw5Boouqx3HzS4AaFUmdmHwjGJxE0B9ThxpHg+zcrLT6VuGCwb6zqPA+mRy
         7R5UE+N6YAiqr1nJTtQgE/ESKQqc4C028nFvGVIVlRReZ0NO7TLBhkxp3/dZqIWe6I
         nZG9/1x5Uc/1YxGyJyrVOmjoB68iylz/5LkoOKReCRqK32UrIY2PrJmAk4DHbkpTtG
         jo71mVfJL+2Dw==
Message-ID: <3b118384151cb56123dc11349249a664.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230406061314.10916-2-quic_devipriy@quicinc.com>
References: <20230406061314.10916-1-quic_devipriy@quicinc.com> <20230406061314.10916-2-quic_devipriy@quicinc.com>
Subject: Re: [PATCH V3 1/5] dt-bindings: clock: qcom,a53pll: add IPQ9574 compatible
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com,
        quic_anusha@quicinc.com, quic_ipkumar@quicinc.com
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, arnd@arndb.de, broonie@kernel.org,
        catalin.marinas@arm.com, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org, geert+renesas@glider.be,
        jassisinghbrar@gmail.com, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        nfraprado@collabora.com, rafal@milecki.pl, robh+dt@kernel.org,
        will@kernel.org
Date:   Mon, 10 Apr 2023 12:31:34 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Devi Priya (2023-04-05 23:13:10)
> IPQ9574 uses A73 PLL of type Huayra. Add the IPQ9574 A73 compatible to A53
> bindings as the PLL properties match with that of A53.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
