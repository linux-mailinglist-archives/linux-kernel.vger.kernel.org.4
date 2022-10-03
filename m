Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6262F5F3124
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 15:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiJCNZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 09:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiJCNY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 09:24:56 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E471EC62;
        Mon,  3 Oct 2022 06:24:54 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id c13-20020a4ac30d000000b0047663e3e16bso6719432ooq.6;
        Mon, 03 Oct 2022 06:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=VwdzdygdgLbBp3fkNJZh/HpOAPaqnsjBDUAQiUXbsnM=;
        b=RiON6VCY/yjCtzZyJrfSKXIONjWnUkCgaU1yponUNrmy1L8y4TI6fZ1FbiTTHymQMK
         EGa4YI2LAbTD9CAZBSFhWRSlBtdmqG34nAziPENaRIhTWiswrumiuJCIm7GMHM2wFG+N
         E6hGVlZY9nNIWp6dGy9Jxgt0WAYcLul35Qt7yf17+wP+yIsBV8HdjjMXpGbcCqkY5/zh
         k6aRYrRfF5fBEfD9vvZaPZe4Srq/OQlnHOR36GGctJUsoN9uZK7u6/hxXmHhclLHjKRj
         E0UeSQiaauZz6JVS1GfO09XU2673DSeXbR1PmHYZaX+Eu+XbO+iYrIK5ANJfW8t++/cM
         PuOQ==
X-Gm-Message-State: ACrzQf04NpOjbdQ3C9ktccaf52tki+C2npTogth1j8Ofo3lGRT8euj/5
        U7/Zw9GhaChgReEBWsvstA==
X-Google-Smtp-Source: AMsMyM5krAxnwLBESkhLxGhsgU/Om3aFEpygfNyJsCkFlsCXefPQKFGdud5gg0scUr0lAuj8ba4w3A==
X-Received: by 2002:a05:6830:2706:b0:659:de15:2cae with SMTP id j6-20020a056830270600b00659de152caemr8411454otu.4.1664803493818;
        Mon, 03 Oct 2022 06:24:53 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o1-20020a056808124100b00350c5d946casm2428151oiv.4.2022.10.03.06.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 06:24:53 -0700 (PDT)
Received: (nullmailer pid 1863799 invoked by uid 1000);
        Mon, 03 Oct 2022 13:24:47 -0000
From:   Rob Herring <robh@kernel.org>
To:     Melody Olvera <quic_molvera@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20221001030403.27659-2-quic_molvera@quicinc.com>
References: <20221001030403.27659-1-quic_molvera@quicinc.com> <20221001030403.27659-2-quic_molvera@quicinc.com>
Message-Id: <166479587193.1658910.3198016342793087638.robh@kernel.org>
Subject: Re: [PATCH 1/5] dt-bindings: clock: Add QDU1000 and QRU1000 GCC clock bindings
Date:   Mon, 03 Oct 2022 08:24:47 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2022 20:03:59 -0700, Melody Olvera wrote:
> Add device tree bindings for global clock controller on QDU1000 and
> QRU1000 SoCs.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  .../bindings/clock/qcom,gcc-qdru1000.yaml     |  74 ++++++++
>  include/dt-bindings/clock/qcom,gcc-qdru1000.h | 170 ++++++++++++++++++
>  2 files changed, 244 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-qdru1000.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,gcc-qdru1000.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/clock/qcom,gcc-qdru1000.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/clock/qcom,gcc-qdru1000.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

