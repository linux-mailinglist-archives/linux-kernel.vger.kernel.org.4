Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434826E14C2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 21:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjDMTC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 15:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjDMTCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 15:02:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB684220;
        Thu, 13 Apr 2023 12:02:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0438F61357;
        Thu, 13 Apr 2023 19:02:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BA3C433D2;
        Thu, 13 Apr 2023 19:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681412542;
        bh=nHNYpceJ4roSvXDKtTtCh6ig8YSudW6E4UTowUu9Cxk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=DR4LdQcqi4TgH/ULOR/JBgyy8FsDOVAQgXc90jAs+ld69dezOwe8LjTeZVFTqCdrJ
         nW+C4dngAdE+NS5dDSa6XUAwfnMlixqb8VnnshqclMAdWLRsYXl2BEgsYLzpf+h/XD
         sbc/c28zFFOrOHDgF9cneVegiIszVsypK3fzhgkIPzwBfVWiVzDowWBiIrG6e+75TW
         rbAilwV2+3oPmVEJncvzA3L2mC5FqoLCHRLzfHkHsfD1ky5Ecxd3mu/o0U2dFmMA5C
         LB5WV2pYgahcwahqS9lQK3wUZG7LmbUmz7xym8R3Min0qCV4Mbmp3Jf8dCVGjjfGni
         h6bxBSNVRvOzQ==
Message-ID: <cbb856f4f7e25b1267c902757e159322.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230413-topic-lahaina_vidcc-v1-1-134f9b22a5b3@linaro.org>
References: <20230413-topic-lahaina_vidcc-v1-0-134f9b22a5b3@linaro.org> <20230413-topic-lahaina_vidcc-v1-1-134f9b22a5b3@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: clock: qcom,videocc: Add SM8350
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>
Date:   Thu, 13 Apr 2023 12:02:20 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Konrad Dybcio (2023-04-13 11:44:58)
> SM8350, like most recent higher-end chips has a separate clock
> controller block just for the Venus IP. Document it.
>=20
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../devicetree/bindings/clock/qcom,videocc.yaml    | 29 ++++++++++++++++=
+-
>  include/dt-bindings/clock/qcom,sm8350-videocc.h    | 35 ++++++++++++++++=
++++++
>  include/dt-bindings/reset/qcom,sm8350-videocc.h    | 18 +++++++++++

Is there any reason to have two files?
