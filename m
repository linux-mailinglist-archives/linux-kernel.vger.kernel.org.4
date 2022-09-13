Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31EE5B7688
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 18:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbiIMQdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 12:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbiIMQcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 12:32:52 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB238B1B9A;
        Tue, 13 Sep 2022 08:27:50 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-127f5411b9cso33055144fac.4;
        Tue, 13 Sep 2022 08:27:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=VVZjlnn+THkJqyJoRk9RBQPIt/3qGui9L2xBWv1no4A=;
        b=DYXOx2epFovfGFJTyFufOREnqZSd/pnX/KWK7PnZ3qLZURRyDlndYPqJl/ADpBT900
         mX0Fa0EIkc92ZJbud+WnwTiICsiTfN89X5NDDGDDpXTpXWCLtCJI3hHa1ZiEqdr5L1jX
         zAtG895Q3mXXM8Lhq4ZAB1cB9001BqqkCGfGzVaRlNlWBiij8Gb3tfGS+U0gwWITIfBe
         pmEbnzj7i1g1oT4+R+2vcJBkJgl7U36Ui88oyHE+Q7ilMKiZDq4rWKXQ4sfXHOQ+b6ri
         +kJlbZO2c5CiF1PwstzVIa4iiLuXKZa13AI31x3Qobk1BZIXxEsyjzTiBFjxtoIrCubP
         G9bw==
X-Gm-Message-State: ACgBeo32xxELQbZK/Mwz/SXs2D6hf9n9jBYgXu8c5STJPKQ/U3MH2Sfb
        mGXd6Nf8peegEYc6nDjB1w==
X-Google-Smtp-Source: AA6agR6Xeph40B/AphNQeHOSVdWolS1Sqe/wRlZeFUjKP/k/ZntbKo+PcwJJyVFs2nGsVh70g3Qr4w==
X-Received: by 2002:a05:6870:4727:b0:126:e6:3848 with SMTP id b39-20020a056870472700b0012600e63848mr2027523oaq.60.1663082781782;
        Tue, 13 Sep 2022 08:26:21 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x88-20020a9d20e1000000b00637032a39a3sm5977109ota.6.2022.09.13.08.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 08:26:21 -0700 (PDT)
Received: (nullmailer pid 3767287 invoked by uid 1000);
        Tue, 13 Sep 2022 15:26:20 -0000
Date:   Tue, 13 Sep 2022 10:26:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: add QCOM SM6115 display clock
 bindings
Message-ID: <20220913152620.GA3762864-robh@kernel.org>
References: <20220911164635.182973-1-a39.skl@gmail.com>
 <20220911164635.182973-2-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220911164635.182973-2-a39.skl@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2022 at 06:46:18PM +0200, Adam Skladowski wrote:
> Add device tree bindings for display clock controller for
> Qualcomm Technology Inc's SM6115 SoC.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>  .../bindings/clock/qcom,sm6115-dispcc.yaml    | 70 +++++++++++++++++++
>  .../dt-bindings/clock/qcom,sm6115-dispcc.h    | 36 ++++++++++
>  2 files changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm6115-dispcc.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,sm6115-dispcc.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm6115-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm6115-dispcc.yaml
> new file mode 100644
> index 000000000000..a6bf363b5015
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,sm6115-dispcc.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,sm6115-dispcc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Display Clock Controller Binding for SM6115

s/Binding //

> +
> +maintainers:
> +  - Bjorn Andersson <andersson@kernel.org>
> +
> +description: |

Don't need '|' when no formatting to preserve.

With those fixes,

Reviewed-by: Rob Herring <robh@kernel.org>
