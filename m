Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009D5698763
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 22:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjBOVbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 16:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjBOVbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 16:31:43 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE1C233E1;
        Wed, 15 Feb 2023 13:31:42 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id x26-20020a056830115a00b0068bbc0ee3eeso69372otq.0;
        Wed, 15 Feb 2023 13:31:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O6xfNqM54ZLmIz2YbilJDBW+8SeWORFysxlKCUVbjQc=;
        b=XP7HDw83S0aQIfnpJngPADQJnMPxR8YtPx9VsoWs/WkEGK8JMN3MHvXAaB86NJQl/s
         PXho2NM8lY/bajyc6XuW2A3N6EzPDTaYs4eN4yIp/PWtgv816xpHjQoJJW8LdoCmHPEf
         q0j7CqiyqEvdrTwnQYELE2IFGr2+voL+iDTxyZI7dT9xKuYHNoB9lqcSrhW6FAFrU+6Q
         mzgTUtfZxqmeKnuoGshk7+FJe0sF6O4qLifi9KjGAy1Ufy7jiqWwq6ZVVuLkMc+t5dlV
         NxGsVjo+AYKzqmuMVFQoDMMmgw8Hykeo7nXTZx9jUQp3cqZnpoUtQZsP6zHyu5gP+3+a
         7MBg==
X-Gm-Message-State: AO0yUKXhHU9hOjuvkXBLImuu74IrNxesIVw5vsOtHpRoNJ9OgZggFcnH
        hKLCH57RkW53e1fMJ5OU9g==
X-Google-Smtp-Source: AK7set/2aDFkLTc1Pcmo3QEZ3+YP/E2bn04VhpJQ7gg4ECFUH3P8CEKxATClYtwv3H8G3aZT4y+8ag==
X-Received: by 2002:a05:6830:144a:b0:68d:3ea5:1734 with SMTP id w10-20020a056830144a00b0068d3ea51734mr1748127otp.16.1676496701422;
        Wed, 15 Feb 2023 13:31:41 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y10-20020a9d634a000000b0068bd20cf07dsm8096385otk.48.2023.02.15.13.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 13:31:40 -0800 (PST)
Received: (nullmailer pid 664383 invoked by uid 1000);
        Wed, 15 Feb 2023 21:31:39 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Bastian Germann <bage@debian.org>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        linux-remoteproc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-sunxi@lists.linux.dev,
        Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20230215203711.6293-5-bage@debian.org>
References: <20230215203711.6293-1-bage@debian.org>
 <20230215203711.6293-5-bage@debian.org>
Message-Id: <167649580161.649957.15557847976208120638.robh@kernel.org>
Subject: Re: [PATCH v2 4/5] dt-bindings: hwlock: sun6i: Add a64 compatible
 string
Date:   Wed, 15 Feb 2023 15:31:39 -0600
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


On Wed, 15 Feb 2023 21:37:09 +0100, Bastian Germann wrote:
> Add an allwinner,sun50i-a64-hwspinlock compatible string to the device
> tree binding. The A31 and A64 have compatible hwspinlocks.
> 
> Signed-off-by: Bastian Germann <bage@debian.org>
> ---
>  .../bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml       | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.example.dtb: hwlock@1c18000: compatible: ['allwinner,sun6i-a31-hwspinlock'] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230215203711.6293-5-bage@debian.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

