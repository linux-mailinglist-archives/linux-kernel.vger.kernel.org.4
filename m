Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E44F6DCBA2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 21:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjDJTeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 15:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDJTeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 15:34:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F2C1BD1;
        Mon, 10 Apr 2023 12:34:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DA59617BC;
        Mon, 10 Apr 2023 19:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DFEC433EF;
        Mon, 10 Apr 2023 19:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681155240;
        bh=D6YU7sRE8nbRBi9Uu64NQEqv/ZbXRVGET4eYI4J8/Ls=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=f5CtC+7ZyczqM7xhdpd8SRa/270zF7uhAGlvD4qxzSsIT+dl2FRiRkZmcWGzc1/jn
         0Yssu8mTM9+T28IZLs3L9T6AyGQSEzH+Bv0ruGxkYYV1WOnuM4ZXDY5ditCpuEtCat
         Y1H3kETkigppAQCeDs0nGYor7e//lFdzJNae7ukVp6KR1W3ECp08lc7bvJ/ByQRISP
         +qmES7ZNi8pZL963vU3qHuFxW1zki+reIFHfQayoEhEe1oi1IwO8V/2mzw/zG+7KBB
         qzfTqRFevZB3zLz1eEAkCBLaU/ULktoQ5l3iJ0JOfythFuN1X3DQxlOlzJuYkcQ0Uj
         aUEtY4aF8YfQg==
Message-ID: <5cc6625ccee772346660b775da341335.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230408134820.76050-1-krzysztof.kozlowski@linaro.org>
References: <20230408134820.76050-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/3] dt-bindings: clock: qcom,gcc-sm8250: add missing bi_tcxo_ao clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 10 Apr 2023 12:33:58 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2023-04-08 06:48:18)
> Without actual explanation commit 76bd127e6ca5 ("arm64: dts: qcom:
> sm8250: add bi_tcxo_ao to gcc clocks") added bi_tcxo_ao clock input to
> the GCC clock controller, so update the bindings hoping this is really
> needed.  This fixes warnings like:
>=20
>   sm8250-xiaomi-elish-csot.dtb: clock-controller@100000: clock-names: ['b=
i_tcxo', 'bi_tcxo_ao', 'sleep_clk'] is too long
>=20
> Fixes: 76bd127e6ca5 ("arm64: dts: qcom: sm8250: add bi_tcxo_ao to gcc clo=
cks")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
