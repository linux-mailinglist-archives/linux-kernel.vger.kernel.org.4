Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887EF683872
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 22:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjAaVNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 16:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjAaVNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 16:13:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB2947408;
        Tue, 31 Jan 2023 13:13:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CCB52B81F03;
        Tue, 31 Jan 2023 21:13:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 623A4C433D2;
        Tue, 31 Jan 2023 21:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675199620;
        bh=VL+rZ6hI815ahbQIQZB50x/KUsJNcZufvjyjenXPPKQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=uiWDpYHbUhja/iF80U6mJXYOC0151kUi2ccPlsHPsuwLsC1e75zJfGuc3dV0bTmlH
         rrW6ClP0waQ/tn+sfdpAXb4f4HX7FzSL/DVsAx0I0EeLI7435rMTopW4zUs402QXfh
         laI+X0atym0ivT3jb3DfqQk74GmzG+ijuCJSdxRxPXL5lKEx6y84vRkr+yNSLF8v/I
         6GYKnE2S0vh9uIFjIwA2A6oxzmmCrHib9Eyu5eodBye54Ts0P3FzJpZA+nMB3ZzJbw
         M5IsFMJ6AtYili/i5sKYjYpZcowjuFCAh4wnnsL/QdGuFCdGJH61g+6vVh0ra5tD+k
         ryZcsvxs66I0A==
Message-ID: <0e40502f2d8c0f0801eeb250b9c27af7.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230130125528.11509-2-quic_devipriy@quicinc.com>
References: <20230130125528.11509-1-quic_devipriy@quicinc.com> <20230130125528.11509-2-quic_devipriy@quicinc.com>
Subject: Re: [PATCH V3 1/7] dt-bindings: Add ipq9574 clock and reset definitions
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
To:     agross@kernel.org, andersson@kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, devi priya <quic_devipriy@quicinc.com>,
        devicetree@vger.kernel.org, dmitry.baryshkov@linaro.org,
        konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel.ziswiler@toradex.com, mturquette@baylibre.com,
        nfraprado@collabora.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, shawnguo@kernel.org, will@kernel.org
Date:   Tue, 31 Jan 2023 13:13:38 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting devi priya (2023-01-30 04:55:22)
> diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yam=
l b/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml
> new file mode 100644
> index 000000000000..7a98469b197c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,ipq9574-gcc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Global Clock & Reset Controller on IPQ9574
> +
> +maintainers:
> +  - Stephen Boyd <sboyd@kernel.org>

Can you be the maintainer? I don't work for Qualcomm.
