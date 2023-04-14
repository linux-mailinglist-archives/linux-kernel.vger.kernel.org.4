Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105DA6E2371
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 14:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjDNMhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 08:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjDNMhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 08:37:14 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77369113;
        Fri, 14 Apr 2023 05:37:11 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-187a1387021so4137441fac.3;
        Fri, 14 Apr 2023 05:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681475831; x=1684067831;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6z6SiSjyhsFruKlyCgEKdQS6ZzvvI8xprJYhm7mvty8=;
        b=LF+DN9Gmo4MXx2w7MzNZ8KcDzonbl8TQRacKnTeYJQugt6ehCgpko+vNcC3M2IRGn8
         ePx4TmcUOh7I1mjATbEwc0T57ufIwLtQbOxwHxdykq9C0zmpO/iOdbRlb9dWblm5J2QT
         HwiRi3i7P2HJTPOU416xaA+NK6tM0RvNb4kF9aNya82h+tS344wS5cpPGjKmwdSVVI4A
         1SMnM803aU5NCxTauVbJifAUQ8gMAJYraLHKjjoDR/tZbH7poy65+uVDFHEOOYz0IQxm
         y3uftL1gBWwUoWPhiaSWAYD67l6s56tEQTAQLFVLbn2UBzFDTpEqCZFUTEpaMX2Xn3ip
         lb3w==
X-Gm-Message-State: AAQBX9cMiXptWn6rDZ7RVysBVM+KbS3nAakxzj+hzp0Gv/gDvuE4Xf5I
        b12A5IjKinOzv+k+7g9DwQ==
X-Google-Smtp-Source: AKy350YLDnEij/+RT5c4VrdY69H0Gh8fljimJpXny4beHt4miLXMxpH9HeP14Yzjux4b6P2LXQXbUg==
X-Received: by 2002:a05:6870:32d5:b0:187:9718:4070 with SMTP id r21-20020a05687032d500b0018797184070mr2818930oac.39.1681475830703;
        Fri, 14 Apr 2023 05:37:10 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s6-20020acadb06000000b00383eaf88e75sm1629875oig.39.2023.04.14.05.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 05:37:09 -0700 (PDT)
Received: (nullmailer pid 3600816 invoked by uid 1000);
        Fri, 14 Apr 2023 12:37:05 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc:     Nitheesh Sekar <quic_nsekar@quicinc.com>, mturquette@baylibre.com,
        konrad.dybcio@linaro.org, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        krzysztof.kozlowski+dt@linaro.org, will@kernel.org,
        linus.walleij@linaro.org, agross@kernel.org,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        catalin.marinas@arm.com, sboyd@kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        andersson@kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <1681468167-11689-4-git-send-email-quic_srichara@quicinc.com>
References: <1681468167-11689-1-git-send-email-quic_srichara@quicinc.com>
 <1681468167-11689-4-git-send-email-quic_srichara@quicinc.com>
Message-Id: <168147485085.3576485.2274318981675565621.robh@kernel.org>
Subject: Re: [PATCH V3 3/9] dt-bindings: pinctrl: qcom: Add support for
 ipq5018
Date:   Fri, 14 Apr 2023 07:37:05 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 14 Apr 2023 15:59:21 +0530, Sricharan Ramabadhran wrote:
> Add device tree binding Documentation details for ipq5018
> pinctrl driver.
> 
> Co-developed-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>  [v3] Fixed review comments and DTS schema warnings
> 
>  .../bindings/pinctrl/qcom,ipq5018-tlmm.yaml        | 129 +++++++++++++++++++++
>  1 file changed, 129 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-tlmm.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-tlmm.example.dtb: pinctrl@1000000: uart2-state: 'oneOf' conditional failed, one must be fixed:
	'bias-pull-down', 'drive-strength', 'function', 'pins' do not match any of the regexes: '-pins$', 'pinctrl-[0-9]+'
	'blsp2_uart' is not one of ['atest_char', 'audio_pdm0', 'audio_pdm1', 'audio_rxbclk', 'audio_rxd', 'audio_rxfsync', 'audio_rxmclk', 'audio_txbclk', 'audio_txd', 'audio_txfsync', 'audio_txmclk', 'blsp0_i2c', 'blsp0_spi', 'blsp0_uart0', 'blsp0_uart1', 'blsp1_i2c0', 'blsp1_i2c1', 'blsp1_spi0', 'blsp1_spi1', 'blsp1_uart0', 'blsp1_uart1', 'blsp1_uart2', 'blsp2_i2c0', 'blsp2_i2c1', 'blsp2_spi', 'blsp2_spi0', 'blsp2_spi1', 'btss', 'burn0', 'burn1', 'cri_trng', 'cri_trng0', 'cri_trng1', 'cxc_clk', 'cxc_data', 'dbg_out', 'eud_gpio', 'gcc_plltest', 'gcc_tlmm', 'gpio', 'led0', 'led2', 'mac0', 'mac1', 'mdc', 'mdio', 'pcie0_clk', 'pcie0_wake', 'pcie1_clk', 'pcie1_wake', 'pll_test', 'prng_rosc', 'pwm0', 'pwm1', 'pwm2', 'pwm3', 'qdss_cti_trig_in_a0', 'qdss_cti_trig_in_a1', 'qdss_cti_trig_in_b0', 'qdss_cti_trig_in_b1', 'qdss_cti_trig_out_a0', 'qdss_cti_trig_out_a1', 'qdss_cti_trig_out_b0', 'qdss_cti_trig_out_b1', 'qdss_traceclk_a', 'qdss_traceclk_b', 'qdss_tracectl_a', 'qdss_tracectl_b', 'qdss_trac
 edata_a', 'qdss_tracedata_b', 'qspi_clk', 'qspi_cs', 'qspi_data', 'reset_out', 'sdc1_clk', 'sdc1_cmd', 'sdc1_data', 'wci_txd', 'wci_rxd', 'wsa_swrm', 'wsi_clk3', 'wsi_data3', 'wsis_reset', 'xfem']
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-tlmm.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1681468167-11689-4-git-send-email-quic_srichara@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

