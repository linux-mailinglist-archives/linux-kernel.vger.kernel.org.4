Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584D45B9A44
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiIOMBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiIOMA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:00:59 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E7E4B0FF;
        Thu, 15 Sep 2022 05:00:58 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-11e9a7135easo47131341fac.6;
        Thu, 15 Sep 2022 05:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Ibj0ymzRR4GUJoYQ24/tVkDs+sr69Nrlxd/BPWsb0Y8=;
        b=hfcqZB7eeOHUKALpnyiZ/0gy4uSU9AjijBqlGz6pVt9TUd9KtVooQxXqBgXrwOH/bf
         THqGPmtlZRkf/tAYouUEK8T4XfpvYhXG+kuYT5WxBcenqAHXGj9SZdEdX/Ua9daAGfWP
         wmTivsYfCoo0Ahp7rOgkJp09uSpyvs121na68zfGJRqrTVn/HWV46yHNf5dgCZc7Oi9j
         mr06AXfr1sL1F6fj3OORFLVegyy4Xfj+DagBOjtaSHun7i13rDh4i9wuLrhtXt84KXX/
         KcuoDo2g5WqKp0ee009/bvOyw4BsOK91B/M1MRQW989feWXPXp/aZHKZvAQtWcpKlrj6
         Yn2A==
X-Gm-Message-State: ACgBeo3TxIRc0TblYG9SJ+4nMsAuu42Zpds91UDytuAyewUo+U0dFajv
        YPgvTCUq/Akfu0iAtgM68g==
X-Google-Smtp-Source: AA6agR7pNMbq3j3o61DIlxtKFdHspY+N6pgmXWZtv/LHrDFYftbEP9a2x/r5eoiQ/3IuAf3pu1gqHQ==
X-Received: by 2002:a05:6870:2049:b0:127:927a:bf40 with SMTP id l9-20020a056870204900b00127927abf40mr4992974oad.248.1663243257253;
        Thu, 15 Sep 2022 05:00:57 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l2-20020a056808020200b00344f28a7a4csm7609592oie.22.2022.09.15.05.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 05:00:56 -0700 (PDT)
Received: (nullmailer pid 989368 invoked by uid 1000);
        Thu, 15 Sep 2022 12:00:56 -0000
Date:   Thu, 15 Sep 2022 07:00:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, Alex Elder <elder@ieee.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        vkoul@kernel.org, Rajendra Nayak <quic_rjendra@quicinc.com>,
        devicetree@vger.kernel.org, Sibi Sankar <quic_sibis@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH V9 1/7] dt-bindings: Added the yaml bindings for DCC
Message-ID: <20220915120056.GA988392-robh@kernel.org>
References: <cover.1663173477.git.quic_schowdhu@quicinc.com>
 <41b94746e1560d63f16fb5dc965042ec496aeaf1.1663173478.git.quic_schowdhu@quicinc.com>
 <20220915093715.ednaqtx7ko6f5zlw@krzk-bin>
 <00b01df4-232b-24d4-7339-0fcfa6b210a9@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00b01df4-232b-24d4-7339-0fcfa6b210a9@quicinc.com>
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

On Thu, Sep 15, 2022 at 05:06:29PM +0530, Souradeep Chowdhury wrote:
> 
> On 9/15/2022 3:07 PM, Krzysztof Kozlowski wrote:
> > On Wed, 14 Sep 2022 22:31:11 +0530, Souradeep Chowdhury wrote:
> > > Documentation for Data Capture and Compare(DCC) device tree bindings
> > > in yaml format.
> > > 
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> > > ---
> > >   .../devicetree/bindings/arm/msm/qcom,dcc.yaml      | 43 ++++++++++++++++++++++
> > >   1 file changed, 43 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,dcc.yaml
> > > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.example.dtb: dma-router@a0: dma-masters:0: [4294967295, 4294967295] is too long
> > 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/dma-router.yaml
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.example.dtb: dma-router@a0: dma-masters:0: [4294967295, 4294967295] is too long
> > 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.yaml
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/st,stm32-dmamux.example.dtb: dma-router@40020800: dma-masters:0: [4294967295, 4294967295] is too long
> > 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/dma-router.yaml
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/st,stm32-dmamux.example.dtb: dma-router@40020800: dma-masters:0: [4294967295, 4294967295] is too long
> > 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/st,stm32-dmamux.yaml
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/st,stm32-dmamux.example.dtb: dma-router@40020800: Unevaluated properties are not allowed ('dma-channels', 'dma-masters', 'dma-requests' were unexpected)
> > 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/st,stm32-dmamux.yaml
> > 
> > doc reference errors (make refcheckdocs):
> > 
> > See https://patchwork.ozlabs.org/patch/
> > 
> > This check can fail if there are any dependencies. The base for a patch
> > series is generally the most recent rc1.
> > 
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> > 
> > pip3 install dtschema --upgrade
> > 
> > Please check and re-submit.
> This reported error is unrelated to my yaml file. Kindly check from your
> end.

Yes, you can ignore it.

Rob

