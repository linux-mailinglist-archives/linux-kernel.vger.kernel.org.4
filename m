Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982D4625B39
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 14:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbiKKNa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 08:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbiKKNaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 08:30:24 -0500
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21A66035E;
        Fri, 11 Nov 2022 05:30:23 -0800 (PST)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-13bd2aea61bso5475962fac.0;
        Fri, 11 Nov 2022 05:30:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oN/OJ/Hi5zpbBCRFQ/GdYDUjCbgG4tvmpft/DiCNH/Y=;
        b=r/S4XIy9DVfyHatnGr7Sphuvglw3TRdXx/eOdyecNcl9Iq6S2/WFoyhULv0e0ZIPli
         tsXc8mhPC7ic3vlsYd7+gQpzN9qZjDg/iLMx6p/PYjmcNk7dubL8aUvqzaFfDqQCYhOH
         FN1yfhUXxhh5kx9jGEYIIZzJy9zCDig2Z5IQyPIAqOmhgMolnzw6md40RTwrGqZxzZb8
         ZMjYQpbSPVFo5phksDS7b0KmgbhHM1ZJS6MljDmiuFNDFXcGBi4TtFetsc1+XtwXZe57
         ltcBagvQr9hABVzxtICLGh8+iax+finUdDU6lMs8UwxIyW/Kxk1pgfwCBrExSy48QJtJ
         hOSA==
X-Gm-Message-State: ANoB5pn0c3wLT4sQJaMfsH++SD12Z5qnUsL1kWUQ306exNb/iFEHaeHD
        nqcw3vqN+H3cNIwovZzBByDa9o0Zrg==
X-Google-Smtp-Source: AA0mqf6lMRZgX0pEcYG9YMsnrIHWktD7j72B9DQqtMKpSchtIooro6x+NpPfiOK3qEo/URWNngPDFw==
X-Received: by 2002:a05:6870:3e0b:b0:13a:eee0:199a with SMTP id lk11-20020a0568703e0b00b0013aeee0199amr854823oab.61.1668173422972;
        Fri, 11 Nov 2022 05:30:22 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t127-20020a4a5485000000b0049b17794d19sm794048ooa.20.2022.11.11.05.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 05:30:22 -0800 (PST)
Received: (nullmailer pid 3073765 invoked by uid 1000);
        Fri, 11 Nov 2022 13:30:24 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>
In-Reply-To: <20221111092457.10546-3-johan+linaro@kernel.org>
References: <20221111092457.10546-1-johan+linaro@kernel.org>
 <20221111092457.10546-3-johan+linaro@kernel.org>
Message-Id: <166817308692.3060117.13177587252682485028.robh@kernel.org>
Subject: Re: [PATCH 02/14] dt-bindings: phy: qcom,qmp-usb3-dp: fix sc8280xp bindings
Date:   Fri, 11 Nov 2022 07:30:24 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 11 Nov 2022 10:24:45 +0100, Johan Hovold wrote:
> The current QMP USB3-DP PHY bindings are based on the original MSM8996
> binding which provided multiple PHYs per IP block and these in turn were
> described by child nodes.
> 
> The QMP USB3-DP PHY block provides a single multi-protocol PHY and even
> if some resources are only used by either the USB or DP part of the
> device there is no real benefit in describing these resources in child
> nodes.
> 
> The original MSM8996 binding also ended up describing the individual
> register blocks as belonging to either the wrapper node or the PHY child
> nodes.
> 
> This is an unnecessary level of detail which has lead to problems when
> later IP blocks using different register layouts have been forced to fit
> the original mould rather than updating the binding. The bindings are
> arguable also incomplete as they only the describe register blocks used
> by the current Linux drivers (e.g. does not include the PCS LANE
> registers).
> 
> This is specifically true for later USB4-USB3-DP QMP PHYs where the TX
> registers are used by both the USB3 and DP parts of the PHY (and where
> the USB4 part of the PHY was not covered by the binding at all). Notably
> there are also no DP "RX" (sic) registers as described by the current
> bindings and the DP "PCS" region is really a set of DP_PHY registers.
> 
> Add a new binding for the USB4-USB3-DP QMP PHYs found on SC8280XP which
> further bindings can be based on.
> 
> Note that the binding uses a PHY type index to access either the USB3 or
> DP part of the PHY and that this can later be used also for the USB4
> part if needed.
> 
> Similarly, the clock inputs and outputs can later be extended to support
> USB4.
> 
> Also note that the current binding is simply removed instead of being
> deprecated as it was only recently merged and would not allow for
> supporting DP mode.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  .../phy/qcom,sc7180-qmp-usb3-dp-phy.yaml      |  12 --
>  .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml    | 111 ++++++++++++++++++
>  2 files changed, 111 insertions(+), 12 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml:16:11: [error] syntax error: mapping values are not allowed here (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.example.dts'
Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml:16:11: mapping values are not allowed here
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml:16:11: mapping values are not allowed here
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml: ignoring, error parsing file
make: *** [Makefile:1492: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

