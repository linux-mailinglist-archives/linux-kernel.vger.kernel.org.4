Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3966D7E05
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237944AbjDENrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237141AbjDENra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:47:30 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457A54C17;
        Wed,  5 Apr 2023 06:47:29 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id w13so15280233oik.2;
        Wed, 05 Apr 2023 06:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680702448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mAAPpJ9+2MB888vDbRAKOF1E3qNq6qV500x+hsvJt50=;
        b=iLHOak7kziuU7YAYw79yeYGIhlBn9ORnbD2hgpzDnKSq9DzMFZVoypw9ZJbXYI7aPv
         KOOXKYPq3A3UzhFMazWs8uTdLBKg3yPxPkqqpYayfbu22lmn5zqA7EjBlnhY5XA4pX6H
         UpK5akd9UjIUaw2l0XVODUCdQn58IPX4tq81yTV2ggqPhf0lgFJJnLH0Kw7JSmbLczlF
         Azjf8IrDuMtoJ3ciNESU6GAffOPEBMe1tkZvAbYSYHBiJFPspYm5rcn1j9KxBUlnAXmB
         Z889ZvDe9K+d70TmVFX3ZCePpHmPzYjRtrsjJ7xHQnmUXVNHvmSVU4y9xO7pDth5QJQv
         6gcA==
X-Gm-Message-State: AAQBX9c+CNRuxA2vw1k5qiL6/WvsnCmBXM+V1sfNErMk796nHk7eroyv
        aV/yVc+bM9mocWVSpBiJgc0oOQ/Uwg==
X-Google-Smtp-Source: AKy350ZyMRVpMnQOsF1iV3FWwWGv6ohmW/4j8PAYZNCrnzEVb80BKWCSQhmHHlGBV8f4E9fEkjLZLg==
X-Received: by 2002:a05:6808:19a5:b0:389:ad7:95d7 with SMTP id bj37-20020a05680819a500b003890ad795d7mr3039016oib.29.1680702448473;
        Wed, 05 Apr 2023 06:47:28 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m24-20020a05680806d800b0037b6f5d6309sm6305619oih.2.2023.04.05.06.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 06:47:28 -0700 (PDT)
Received: (nullmailer pid 2491083 invoked by uid 1000);
        Wed, 05 Apr 2023 13:47:27 -0000
Date:   Wed, 5 Apr 2023 08:47:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marc Zyngier <maz@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: interrupt-controller: mpm: Pass MSG
 RAM slice through phandle
Message-ID: <20230405134727.GA2461305-robh@kernel.org>
References: <20230328-topic-msgram_mpm-v2-0-e24a48e57f0d@linaro.org>
 <20230328-topic-msgram_mpm-v2-1-e24a48e57f0d@linaro.org>
 <168069726278.2356075.14351594478003012447.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168069726278.2356075.14351594478003012447.robh@kernel.org>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 07:22:40AM -0500, Rob Herring wrote:
> 
> On Wed, 05 Apr 2023 12:48:34 +0200, Konrad Dybcio wrote:
> > Due to the wild nature of the Qualcomm RPM Message RAM, we can't really
> > use 'reg' to point to the MPM's slice of Message RAM without cutting into
> > an already-defined RPM MSG RAM node used for GLINK and SMEM.
> > 
> > Document passing the register space as a slice of SRAM through the
> > qcom,rpm-msg-ram property. This also makes 'reg' deprecated.
> > 
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > ---
> >  .../devicetree/bindings/interrupt-controller/qcom,mpm.yaml   | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.example.dts:22.35-38.11: Warning (node_name_vs_property_name): /example-0/interrupt-controller: node name and property name conflict

Looks like this is colliding with the example template which has to 
craft an interrupt provider for 'interrupts' properties. Either adding a 
parent node or using interrupts-extended instead should work-around it.

Rob
