Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1589C623571
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiKIVJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiKIVJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:09:14 -0500
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F341D2EF76;
        Wed,  9 Nov 2022 13:09:13 -0800 (PST)
Received: by mail-oo1-f52.google.com with SMTP id s1-20020a4a81c1000000b0047d5e28cdc0so2623829oog.12;
        Wed, 09 Nov 2022 13:09:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pTx6KXl8drPJ8E5PhGgj7I7ubFV4pBqM5D1m7ayvNZY=;
        b=gAvosoS2CPWmEARPsidZ0T8zX8HUNM6GtDjs1RfJHWi20VWWh4QaRkKYjbg+tDBA3H
         KV66BMU8EB/vsXMdFfCiBO81L4Ezn9CSBal3zfUJ52AG0ao4STGH0QJ2W09Py/subZX1
         sEiHIV6YhiXIqjgbOk5UGpbcGnYtsyNHvR1h4tepyVxkjsD0Cqi3R/XFGQ5/BBhvR50F
         W88YHKrOhLlJkxw+w3Ez0VNkmu38HChkDi8sqNbo2RbMZQEoEXE67hC4LWeKsfBoIli0
         e7+06e2lU2Zrv6ES7VTwOyqlV1vRTjWltAAV9IClGVgzeZpJU8EY5uBYU+kELsixABbq
         8EKw==
X-Gm-Message-State: ACrzQf0oH6E+QKmjqJhRmh6rwxRr+81djSEWLrxsTStjgSSopROUmgTx
        W3eKWYFNi7NtyuaLymFJYw==
X-Google-Smtp-Source: AMsMyM74l5mv/EC48QYKoj/YZepZ9v4bVhOyjqW8nyLfXzz90f1TERxX/QeKPgV/jeuamIsn6OI3iQ==
X-Received: by 2002:a4a:e810:0:b0:47f:775a:b028 with SMTP id b16-20020a4ae810000000b0047f775ab028mr26271145oob.12.1668028153073;
        Wed, 09 Nov 2022 13:09:13 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q189-20020acac0c6000000b0035a0c543ad6sm5032033oif.21.2022.11.09.13.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 13:09:12 -0800 (PST)
Received: (nullmailer pid 2868050 invoked by uid 1000);
        Wed, 09 Nov 2022 21:09:10 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        tglx@linutronix.de, linux-gpio@vger.kernel.org, maz@kernel.org,
        lee@kernel.org, linus.walleij@linaro.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
In-Reply-To: <20221109165331.29332-12-rf@opensource.cirrus.com>
References: <20221109165331.29332-1-rf@opensource.cirrus.com>
 <20221109165331.29332-12-rf@opensource.cirrus.com>
Message-Id: <166802788527.2833369.15841700036002494433.robh@kernel.org>
Subject: Re: [PATCH 11/12] dt-bindings: sound: Add Cirrus Logic CS48L31/32/33 codecs
Date:   Wed, 09 Nov 2022 15:09:10 -0600
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


On Wed, 09 Nov 2022 16:53:30 +0000, Richard Fitzgerald wrote:
> Codecs in this family have multiple digital and analog audio I/O that
> support a variety of external hardware connections and configurations.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  .../bindings/sound/cirrus,cs48l32.yaml        | 96 +++++++++++++++++++
>  include/dt-bindings/sound/cs48l32.h           | 25 +++++
>  2 files changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/cirrus,cs48l32.yaml
>  create mode 100644 include/dt-bindings/sound/cs48l32.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/sound/cirrus,cs48l32.yaml:44:20: [error] syntax error: mapping values are not allowed here (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/sound/cirrus,cs48l32.example.dts'
Documentation/devicetree/bindings/sound/cirrus,cs48l32.yaml:44:20: mapping values are not allowed here
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/sound/cirrus,cs48l32.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/sound/cirrus,cs48l32.yaml:44:20: mapping values are not allowed here
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/cirrus,cs48l32.yaml: ignoring, error parsing file
make: *** [Makefile:1492: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):
Documentation/devicetree/bindings/sound/cirrus,cs48l32.yaml: Documentation/devicetree/bindings/mfd/cirrus,cs48l32.yaml

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

