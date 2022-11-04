Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1750B619F83
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 19:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbiKDSMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 14:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiKDSMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:12:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7753137F;
        Fri,  4 Nov 2022 11:12:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5D5F622F3;
        Fri,  4 Nov 2022 18:12:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A001C433D6;
        Fri,  4 Nov 2022 18:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667585550;
        bh=U9bt9ylt7yMf9CDfDRcO6MQQ2UNKCSEwJSPsP6zavKI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=gw57mwV41gR+YG09so0cTwYZF59Y349+yxd/1o2OB+qt+2nJbNXUbaQLgQM8Wmyro
         CJ17KwayoN/MSWkfRGmUiDNFJoqV0aWoao9N0g+XakhgY8I2054JOjTSW0y2+LKSSk
         QCshy67YEQAk6au0tYoVdpxLsE0eZPEDlv9u9ulcC9+E7OimXK//zlrTaZK15eyMdM
         mz5cIP9VZOvg+sIBlfaIz0ukAqJfO1Y7+RvmHDvFpMLvwcn64+fXzSufjovkmY1WH+
         ity0JGfv+sUwRCD4FsqYkYkxHhz7qGzqh7cK68094dMF3L2u9qgCrhYAZtXlVaG5p5
         sf01a1qlGaIdQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221104170552.72242-1-krzysztof.kozlowski@linaro.org>
References: <20221104170552.72242-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: clock: qcom,sdm845-lpasscc: convert to dtschema
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 04 Nov 2022 11:12:28 -0700
User-Agent: alot/0.10
Message-Id: <20221104181230.2A001C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2022-11-04 10:05:52)
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sdm845-lpasscc.=
yaml b/Documentation/devicetree/bindings/clock/qcom,sdm845-lpasscc.yaml
> new file mode 100644
> index 000000000000..10aa9b6e8d89
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,sdm845-lpasscc.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,sdm845-lpasscc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SDM845 LPASS Clock Controller
> +
> +maintainers:
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>

Should fix this email.
