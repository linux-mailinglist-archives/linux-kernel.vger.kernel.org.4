Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D621B72E464
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242040AbjFMNm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241006AbjFMNmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:42:14 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC88D1730;
        Tue, 13 Jun 2023 06:42:07 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-33d22754450so32142465ab.0;
        Tue, 13 Jun 2023 06:42:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686663727; x=1689255727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5O33o6zgRpefLbSeRA3FQiNNmY/AxWBQOJYDguqJuI=;
        b=hTFKqUObeKeRHTXPpNtMLUMKc9fAwnGsr0tOHG+G9dzI+L2hFA94od4JZXyRWp8OMV
         Sup62xRRn/nhETIsnb8Txhi+HDjJlywQpTYYlNuA0cgNKPrMEMnaMR+MF50gzp4eF+B8
         fWtMCX79qliNCsBwGUpqM+qfZXgocuOsfSZLK7c+Ls1r6RdsyXZrZB2V/BVzzROYzVPm
         q0xxA562mwCL3SpNk4CW5z+qfPtL0xJ5AA+8WXpQsfAmn3rtTJjBg0qgvLbGC/lKF31X
         RjhANxUn4JK0OYghWou7Oxard9iOF7LgpP6cu2cdB5sYdd8X0JCPBVmlCx1Spwburvio
         CYqA==
X-Gm-Message-State: AC+VfDzFkChAW09Y3bvqYm4d6eYGsMPOEFzF+CWQu229asLRK1Au6+KR
        VIGdiUOAfKtzZNtU/b4j/BZ51Se+7w==
X-Google-Smtp-Source: ACHHUZ7Whh7A509JfFoMM8/UIhY7zBqK1hQNaTzTuVOwEoXe+k5fwW24aLsVJ6N62jJE1gmpvzCT5w==
X-Received: by 2002:a92:d943:0:b0:33e:7b40:18b3 with SMTP id l3-20020a92d943000000b0033e7b4018b3mr11105552ilq.18.1686663727132;
        Tue, 13 Jun 2023 06:42:07 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id k1-20020a92c9c1000000b0033c01c407fbsm3837117ilq.31.2023.06.13.06.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 06:42:06 -0700 (PDT)
Received: (nullmailer pid 1778481 invoked by uid 1000);
        Tue, 13 Jun 2023 13:42:05 -0000
Date:   Tue, 13 Jun 2023 07:42:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, jic23@kernel.org,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        mazziesaccount@gmail.com, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v6 1/7] dt-bindings: iio: Add KX132-1211 accelerometer
Message-ID: <20230613134205.GA1777720-robh@kernel.org>
References: <cover.1686651032.git.mehdi.djait.k@gmail.com>
 <0d6051ad217f91c7de0883c4ca1516bdacc343ce.1686651032.git.mehdi.djait.k@gmail.com>
 <168665515466.1407218.12335518729776515932.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168665515466.1407218.12335518729776515932.robh@kernel.org>
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

On Tue, Jun 13, 2023 at 05:19:14AM -0600, Rob Herring wrote:
> 
> On Tue, 13 Jun 2023 12:22:34 +0200, Mehdi Djait wrote:
> > Extend the kionix,kx022a.yaml file to support the kx132-1211 device
> > 
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> > ---
> > v6:
> > v5:
> > v4:
> > v3:
> > - no changes
> > 
> > v2:
> > - made the device name more specific from "kx132" to "kx132-1211"
> > - removed the output data-rates mentioned and replaced them with "variable
> > output data-rates"
> > 
> >  .../devicetree/bindings/iio/accel/kionix,kx022a.yaml | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
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
