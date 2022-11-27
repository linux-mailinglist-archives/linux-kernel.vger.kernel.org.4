Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E6F639BBC
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 17:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiK0QZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 11:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiK0QZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 11:25:35 -0500
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84316D97;
        Sun, 27 Nov 2022 08:25:34 -0800 (PST)
Received: by mail-io1-f49.google.com with SMTP id z3so6097563iof.3;
        Sun, 27 Nov 2022 08:25:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4iphqB3V3njdrZMtNw34CrJe3N2iDEl+tDNQa/YZi+c=;
        b=vh5zocrIlnHWH7qHliFpg2Rl3wQB9bJPqYzFy6vk271wDV141pUVQlloxid1X9qP+4
         u+PVvH7EwnSoQtNfgUHqR19mYnxQnoXy1aXO1TD6H8LUka+gXI90mW4Uj3Dktz0rDUFK
         mkj2DkCuUQfQBpK3HXyLAoJ0oNNhYdSbPZo65TSWzkH2fiQTWIMM/hGfoOmCkspoLF9D
         leWaV+/b1OjYPQv6vNFErEjwdJ5nRpHik2ui82jcL3Gjq3ecoksC9hoVpfuAUu2P8zFg
         QSz+sfijW6TaA4xb3g88/sq/5z/+SCP+Yko7KMqmvSfttt/f4M39ZZBDbNrYo7SN4Ryh
         024g==
X-Gm-Message-State: ANoB5pneOA1ADNNDlnbqKqNVERoQoiVJwplzK522JpE6zFimW+Le8xXQ
        DXVukB9bYiKaxRiIAAYT2g==
X-Google-Smtp-Source: AA0mqf5lRxAYsVtOblQJx782nbVWv9R6LXYMbMBaqudpFkDUV0f2N191eAUEFpzjYklx5TzPd3089g==
X-Received: by 2002:a05:6638:4709:b0:389:e195:e8fb with SMTP id cs9-20020a056638470900b00389e195e8fbmr214618jab.254.1669566333650;
        Sun, 27 Nov 2022 08:25:33 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80c3:406b:3c03:158a:46b4:95c8])
        by smtp.gmail.com with ESMTPSA id z15-20020a056e02088f00b003029afc3672sm3083058ils.36.2022.11.27.08.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 08:25:32 -0800 (PST)
Received: (nullmailer pid 7242 invoked by uid 1000);
        Sun, 27 Nov 2022 16:25:30 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?=2C?= Ilpo =?utf-8?q?J=C3=A4rvinen?= 
        <ilpo.jarvinen@linux.intel.com>, Albert Ou <aou@eecs.berkeley.edu>,
        devicetree@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Conor Dooley <conor@kernel.org>
In-Reply-To: <20221127132448.4034-6-jszhang@kernel.org>
References: <20221127132448.4034-1-jszhang@kernel.org>
 <20221127132448.4034-6-jszhang@kernel.org>
Message-Id: <166956617880.3839.1241284612339331336.robh@kernel.org>
Subject: Re: [PATCH v2 5/9] dt-bindings: riscv: Add bouffalolab bl808 board
 compatibles
Date:   Sun, 27 Nov 2022 10:25:30 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 27 Nov 2022 21:24:44 +0800, Jisheng Zhang wrote:
> Several SoMs and boards are available that feature the Bouffalolab
> bl808 SoC. Document the compatible strings.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  .../bindings/riscv/bouffalolab.yaml           | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/bouffalolab.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/riscv/bouffalolab.yaml:20:36: [error] syntax error: mapping values are not allowed here (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/riscv/bouffalolab.example.dts'
Documentation/devicetree/bindings/riscv/bouffalolab.yaml:20:36: mapping values are not allowed in this context
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/riscv/bouffalolab.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/riscv/bouffalolab.yaml:20:36: mapping values are not allowed in this context
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/riscv/bouffalolab.yaml: ignoring, error parsing file
make: *** [Makefile:1492: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221127132448.4034-6-jszhang@kernel.org

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command.

