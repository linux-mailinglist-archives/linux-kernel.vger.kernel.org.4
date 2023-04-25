Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0375B6ED9E1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 03:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjDYBaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 21:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjDYBat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 21:30:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD98F5277;
        Mon, 24 Apr 2023 18:30:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76A5962566;
        Tue, 25 Apr 2023 01:30:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB23EC433D2;
        Tue, 25 Apr 2023 01:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682386247;
        bh=w58zvq6SYmbfbSoeAu0aO4ZUeU56HHK96WcPNF+3gro=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=FZ4jWRo0I48oIjYMIDpVNxS+isPkUxGPpRE0BoHwvI8RC8+x/q6rWxZr9Lb+5RSX1
         bCLPAGs4XpXCMLCMiZ7cKyR9dV63sC8489tnja12BOK5WiEBnTOdwt6OK5VlfEbxm1
         1uc8Fa1aU00tzs7mOWAsIW0s87n7lmj29lrqDQa4CEEawyVCH4m4/QZ+Uqi5yfEQyn
         N+tBBPzzPcKfw6LSh+tRPLEeAbFK2YByfQ2kjyTmBWth4T+lC6pMfHvx8B0xdL9IDq
         9gk03uGbeYgWUB/L2aPibxBsW0/RhoP+PmQ/IwFwYijGyOf5TNzHQ7qI1wh+Emmb/I
         2wRrMXRSFAPPQ==
Message-ID: <d7c96f7f38e88f0c9d8aa182dc71743a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1682338412-15420-1-git-send-email-mantas@8devices.com>
References: <1682338412-15420-1-git-send-email-mantas@8devices.com>
Subject: Re: [PATCH 1/3] clk: qcom: gcc-ipq6018: Use floor ops for sdcc clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Abhishek Sahu <absahu@codeaurora.org>,
        Anusha Canchi Ramachandra Rao <anusharao@codeaurora.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, Mantas Pucka <mantas@8devices.com>
To:     Andy Gross <agross@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mantas Pucka <mantas@8devices.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 Apr 2023 18:30:45 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mantas Pucka (2023-04-24 05:13:30)
> SDCC clocks must be rounded down to avoid overclocking the controller.
>=20
> Fixes: d9db07f088af ("clk: qcom: Add ipq6018 Global Clock Controller supp=
ort")
>=20

There should be no extra newline here.

> Signed-off-by: Mantas Pucka <mantas@8devices.com>
