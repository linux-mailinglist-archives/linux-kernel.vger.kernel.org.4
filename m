Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0686372E476
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242602AbjFMNoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242557AbjFMNn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:43:57 -0400
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF84E6;
        Tue, 13 Jun 2023 06:43:39 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-33e75ca0a8bso24590845ab.0;
        Tue, 13 Jun 2023 06:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686663819; x=1689255819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nmua7iGyrNHd+POWyUwRwRVOKzPbU1axH5KsFnA/6xU=;
        b=hitn1Jb3ubnKZgMDIzLdQzZe+2gfnfnJ7Qf5+7KmnOiw/vYodxeyHUmBrbTTKit/z9
         O2kN8YXi4l7FRgyJVovPE3g8Ge7Tup2A/IjpY+c8qrMT1km+iEgKkUki33x7yD7UEjtV
         eaH1Ppq7yZfwZXvgcQioDzJbT9MHRqQeemxjd6+fBl/ZbTEWW2aIdpAmfFRnigBUrT/e
         TKfJ7XU/NLAgc2pxvIlvWmpzf/sOGshqLcYVIYiT3NaMDaolhbUeck0Ix+CNIMlhgTbw
         /GUNtFlfX44i8fAahEuABxL4QIaXsYoI7xJHeqBIF0W7s92Gk8Sf7wdax10/2/BxSjGB
         cwbg==
X-Gm-Message-State: AC+VfDw5dzTfmSQZ/yiZzkGbmatN0P3uDJCuViL62Ggqoa8o0srW1Xrs
        qBIik2hMAQw9wGqWLQif3w==
X-Google-Smtp-Source: ACHHUZ4N5LxEwQghbyZ0mVuAkfOFHBheqmu8DGwgun+YnzbyznQW+Hrq6vho8Zw5x6oO0ynuI43ghA==
X-Received: by 2002:a92:d692:0:b0:33b:16e9:bba5 with SMTP id p18-20020a92d692000000b0033b16e9bba5mr10434067iln.28.1686663818733;
        Tue, 13 Jun 2023 06:43:38 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id j18-20020a926e12000000b00326bd11f5d1sm2190658ilc.11.2023.06.13.06.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 06:43:38 -0700 (PDT)
Received: (nullmailer pid 1780603 invoked by uid 1000);
        Tue, 13 Jun 2023 13:43:36 -0000
Date:   Tue, 13 Jun 2023 07:43:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Piyush Mehta <piyush.mehta@amd.com>
Cc:     michal.simek@xilinx.com, git@amd.com, nava.manne@xilinx.com,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-usb@vger.kernel.org, michal.simek@amd.com,
        conor+dt@kernel.org, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, siva.durga.prasad.paladugu@amd.com
Subject: Re: [PATCH V3] dt-bindings: reset: convert the xlnx,zynqmp-reset.txt
 to yaml
Message-ID: <20230613134336.GA1780229-robh@kernel.org>
References: <20230613123048.2935502-1-piyush.mehta@amd.com>
 <168666237486.1671584.5832429615873674500.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168666237486.1671584.5832429615873674500.robh@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 07:19:34AM -0600, Rob Herring wrote:
> 
> On Tue, 13 Jun 2023 18:00:48 +0530, Piyush Mehta wrote:
> > Convert the binding to DT schema format. It also updates the
> > reset-controller description.
> > 
> > Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
> > ---
> > Changes in V2:
> > - Addressed the Krzysztof review comment:
> >  - Update DT binding to fix the dt_binding_check warning.
> >  - Removed 2/2 - xlnx,zynqmp-firmware.yaml binding patch: Will send after
> >    xlnx,zynqmp-reset.yaml binding merge.
> > 
> > Link: https://lore.kernel.org/lkml/168612336438.2153757.6000360498539992409.robh@kernel.org/T/#m4abfe6287177d5fd09f781d298dd19d56aae5e27
> > 
> > Changes in V3:
> > - Addressed the Krzysztof review comment:
> >  - Removed 2/2 - xlnx,zynqmp-firmware.yaml binding patch: Will send after
> >    xlnx,zynqmp-reset.yaml binding merge.
> >  - Update title: Removed "binding".
> >  - Update Example:
> >   - Removed header file.
> >   - Dropped three levels of indentations: firmware and zynqmp_firmware.
> >   - Removed the sata example.
> > 
> > Link: https://lore.kernel.org/all/22e3c25e-487b-c02f-46f3-6d2ab2be8813@linaro.org/
> > ---
> >  .../bindings/reset/xlnx,zynqmp-reset.txt      | 55 -------------------
> >  .../bindings/reset/xlnx,zynqmp-reset.yaml     | 52 ++++++++++++++++++
> >  2 files changed, 52 insertions(+), 55 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
> >  create mode 100644 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml: $defs:qcom-pmic-mpp-state:properties:qcom,paired: [{'description': 'Indicates that the pin should be operating in paired mode.'}] is not of type 'object', 'boolean'
> 	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

Unrelated. This can be ignored.

Rob
