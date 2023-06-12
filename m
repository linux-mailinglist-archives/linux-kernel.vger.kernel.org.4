Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD4472CFAB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 21:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237605AbjFLTgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 15:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjFLTgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 15:36:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A72BD;
        Mon, 12 Jun 2023 12:36:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 114B762C5E;
        Mon, 12 Jun 2023 19:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59465C433D2;
        Mon, 12 Jun 2023 19:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686598571;
        bh=yAgX0JikH7rPLfyjpnILVBy5NjwslilMd796NeaS0cw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Lu7JgBx0RtFRsvt/kimbvd+yuM2etqKAHiGLJ/clyfA9v1cDzlgtvpg8eszSQi4fm
         ClfM0W+DWnugerIOE2NtwQ+oIRp39INKrn2vqLS/eoZsKX2FJdBMT+Chm7JkMEKwc1
         vQ4y5IuZrr0eupM2XcndrAUYWIwkGkRi7FvzqGeCj+MIxjGkaD0/gqE5xtLqRQvxiE
         KT0/1hYOQgTnOH1n9RnoDCyawfIRbgZkVA6yaKyjxRms0V/StXblcu+hqA5H1O80RW
         1lAWNy2PdTb7ot2iqh/8bzj4qNkWCC2NFqjUt1LkkccIbRFJS3aP8rP+dSxwB7pfP1
         bZ+DGC8JE9ymw==
Message-ID: <958e9a7abe1170876e96ae919db9273a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230526-topic-smd_icc-v3-4-5fb7d39b874f@linaro.org>
References: <20230526-topic-smd_icc-v3-0-5fb7d39b874f@linaro.org> <20230526-topic-smd_icc-v3-4-5fb7d39b874f@linaro.org>
Subject: Re: [PATCH v3 04/23] clk: qcom: smd-rpm: Move some RPM resources to the common header
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Georgi Djakov <djakov@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Mon, 12 Jun 2023 12:36:09 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Konrad Dybcio (2023-06-12 11:24:21)
> In preparation for handling the bus clocks in the icc driver, carve out
> some defines and a struct definition to the common rpm header.
>=20
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
