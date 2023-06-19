Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D3E7349F5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 04:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjFSCPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 22:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjFSCPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 22:15:31 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01B8E47;
        Sun, 18 Jun 2023 19:15:30 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-77e24ace5a8so146272039f.0;
        Sun, 18 Jun 2023 19:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687140930; x=1689732930;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=32Swg/UjoS3cjV/nFi0Bc3Ya5tQYAIpuii1MxYpla+0=;
        b=DSNq1iY/q3vXTnQFmvlLkw+K6+cfxRoVTbzbHJ6w+eqsC5Er6QJNuRRBVulcYyhGMw
         yJBnsuFYp+2NHRE9+1k2qqbBCMfnrDMt7cK2fLcrqSJqwM4Kntp1fxdFdSuvLZT4sz2X
         bBMfop6LC04d+59Kx3STEzhAey5Aj/TO/sXl7snNrc1LB/LZVISLha90SHBunBXc3rjJ
         Id2RTtho7sWkJXv9HLBL+ulSAkqEbTNXzEqejCDZKIDUbNyMAiYKnmDDYpfU3ExRnMjx
         mv5O8VrWbJ7/+qaiUE/tvbenv9ynTgt5vgN5jJNFn+c+9846Pr/1t4RSGor+ocYs2K6U
         wotw==
X-Gm-Message-State: AC+VfDzL+PK8W7mazzzEAyaAdtzZwxHLo12ErfYD7/YFC7T1IU31CEnk
        QhvqTm3HZll6YwIRUeANQA==
X-Google-Smtp-Source: ACHHUZ5TCWb4WJX/SaVFMO5AYbmrF1gAF1OID/i5CY95XSzj4oglTH4qvR0Wg6hTT1ROypX5YAMAiQ==
X-Received: by 2002:a92:90f:0:b0:33d:85c3:93ee with SMTP id y15-20020a92090f000000b0033d85c393eemr7373943ilg.17.1687140930209;
        Sun, 18 Jun 2023 19:15:30 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id h1-20020a92c081000000b003421d25e5a2sm1591707ile.50.2023.06.18.19.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 19:15:29 -0700 (PDT)
Received: (nullmailer pid 2830 invoked by uid 1000);
        Mon, 19 Jun 2023 02:15:27 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Furkan Kardame <f.kardame@manjaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org, conor+dt@kernel.org,
        dsterba@suse.com, heiko@sntech.de,
        linux-rockchip@lists.infradead.org, deller@gmx.de,
        devicetree@vger.kernel.org, broonie@kernel.org
In-Reply-To: <20230617135315.25441-2-f.kardame@manjaro.org>
References: <20230617135315.25441-1-f.kardame@manjaro.org>
 <20230617135315.25441-2-f.kardame@manjaro.org>
Message-Id: <168714092636.2784.10614022790347799844.robh@kernel.org>
Subject: Re: [PATCHv2 1/2] dt-bindings: arm: rockchip: Add Firefly Station
 P2
Date:   Sun, 18 Jun 2023 20:15:27 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 17 Jun 2023 16:53:14 +0300, Furkan Kardame wrote:
> Station P2 is a single board computer by firefly based
> on rk3568 soc
> 
> Signed-off-by: Furkan Kardame <f.kardame@manjaro.org>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/arm/rockchip.yaml:189:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/arm/rockchip.example.dts'
Documentation/devicetree/bindings/arm/rockchip.yaml:189:1: found a tab character that violates indentation
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/arm/rockchip.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/arm/rockchip.yaml:189:1: found a tab character that violates indentation
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/rockchip.yaml: ignoring, error parsing file
make: *** [Makefile:1512: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230617135315.25441-2-f.kardame@manjaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

