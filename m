Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790C55FBE92
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 02:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiJLAB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 20:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJLABu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 20:01:50 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA70A4B93;
        Tue, 11 Oct 2022 17:01:48 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id l5so17588424oif.7;
        Tue, 11 Oct 2022 17:01:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3fAeho2Eqr7WdY5Q6r5sPrZ3FQPcP2pCR4gq4JvRwbI=;
        b=nfdlyCmhao/rxgjsbIPYfrDWDqVs7a4r586FErdMxfEOL4KCti9lw9/f+vljfU4g4L
         JPNOU/D1Xz8dJ6v+8jeo94m+DFQ0cgj4rmHuuvTvE50NFbSLoDCJFz1QYV0vHDFt3mUw
         XzKaybwkfKPlQpPNEIC3WR8nhn6jIlw348LMQuVDJ0lSxhg6HRidXStAlDbXXngV/ENB
         oxWYUQe8Q1a+ilEokUuy0qwUUryrEmhqEW4rD0MmsxugAtdGDiCulNJUMllEtsrWIydf
         p2qoNeROKNlqAEgC6bcZrNZhF6fRTbKwUHExI5XWStQHFL+uex8rl3jTxxUo13rfWZnb
         FN1g==
X-Gm-Message-State: ACrzQf3yvJyZOUKafbQ3X5QI9Q1Z8XZNEHXcg3tuY9C3A6D1lbtTvVhs
        mzIc1abugx1LmpZm9OKQ9Q==
X-Google-Smtp-Source: AMsMyM4LTOIea7y4B4rEJ6rNmLa3jrLz79VUZhaMvh2WocECH31DMUxRctr4Q7bA59RLauQhLeY9Gw==
X-Received: by 2002:a05:6808:1911:b0:354:cede:ec0d with SMTP id bf17-20020a056808191100b00354cedeec0dmr781400oib.161.1665532907100;
        Tue, 11 Oct 2022 17:01:47 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v24-20020a4ac018000000b00476995b5f0fsm423357oop.9.2022.10.11.17.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 17:01:46 -0700 (PDT)
Received: (nullmailer pid 418290 invoked by uid 1000);
        Wed, 12 Oct 2022 00:01:46 -0000
From:   Rob Herring <robh@kernel.org>
To:     Job Noorman <job@noorman.info>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Luca Weiss <luca@z3ntu.xyz>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20221011190729.14747-2-job@noorman.info>
References: <20221011190729.14747-1-job@noorman.info> <20221011190729.14747-2-job@noorman.info>
Message-Id: <166553283105.416548.10912099366359324486.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: touchscreen: add Himax hx83112b bindings
Date:   Tue, 11 Oct 2022 19:01:46 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Oct 2022 19:08:06 +0000, Job Noorman wrote:
> This patch adds device tree bindings for Himax 83112b touchscreen
> devices.
> 
> Signed-off-by: Job Noorman <job@noorman.info>
> ---
>  .../input/touchscreen/himax,hx83112b.yaml     | 59 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/himax,hx83112b.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/input/touchscreen/himax,hx83112b.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/input/touchscreen/himax,hx83112b.yaml#
Error: Documentation/devicetree/bindings/input/touchscreen/himax,hx83112b.example.dts:28.30-31 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:384: Documentation/devicetree/bindings/input/touchscreen/himax,hx83112b.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1420: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

