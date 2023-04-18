Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA6E6E55C5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 02:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjDRAZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 20:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDRAZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 20:25:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B528DE47;
        Mon, 17 Apr 2023 17:25:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53AF9622BD;
        Tue, 18 Apr 2023 00:25:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96610C433EF;
        Tue, 18 Apr 2023 00:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681777519;
        bh=/GYrnxNI0AAUCINXLfRihOshTJOMYBGRcVFd7aUcS9Y=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=B8qkBWhAVOZIjbKpvtxI41jlgcy6wcICyiEcVMXnAZhmSo5iOGbjf2Ch+Ehg4rj3E
         yAv/f6vXQR8ENBjCCYea2T6GwYDMCN4l0HCOB32EBItZhDY0httNbM5OFfq+Sn6GUD
         7j6QZhEw9GTYNuNDnCf554ImeS5QnNSlBizgCZMyv4w5DUicehKPzIqtkCasBhynxk
         GYCrMOTDN8o4w+6+q3V1wIWgZ4zJ/cFxHE7vov6SsTg7ojcAmEXTnqdTB6VbUacEuf
         FKMUXkb2ijWcoYBlvOlYs5/xKo/BI7RN0m1u5coGOzPsrucyKtBxbtGCsyLR2GIG9U
         XF6D6UCruGGvg==
Message-ID: <800251d4de9afc23ef0617b558a4173c.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230417082127.11681-2-quic_tdas@quicinc.com>
References: <20230417082127.11681-1-quic_tdas@quicinc.com> <20230417082127.11681-2-quic_tdas@quicinc.com>
Subject: Re: [PATCH V2 1/3] dt-bindings: clock: qcom: Add SM8450 video clock controller
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     dmitry.baryshkov@linaro.org, quic_skakitap@quicinc.com,
        quic_jkona@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Date:   Mon, 17 Apr 2023 17:25:17 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2023-04-17 01:21:25)
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.=
yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
> new file mode 100644
> index 000000000000..7e191ba80a4c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,sm8450-videocc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Video Clock & Reset Controller on SM8450
> +
> +maintainers:
> +  - Taniya Das <quic_tdas@quicinc.com>
> +
> +description: |
> +  Qualcomm video clock control module provides the clocks, resets and po=
wer
> +  domains on SM8450.
> +
> +  See also:: include/dt-bindings/clock/qcom,videocc-sm8450.h
> +
> +properties:
> +  compatible:
> +    const: qcom,sm8450-videocc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Video AHB clock from GCC
> +      - description: Board XO source
> +
> +  clock-names:

Drop clock-names. It matches how newer qcom clk bindings are being done.

> +    items:
> +      - const: bi_tcxo
> +      - const: iface
> +
