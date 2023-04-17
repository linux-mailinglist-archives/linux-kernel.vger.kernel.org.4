Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE736E51ED
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 22:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjDQUhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 16:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjDQUhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 16:37:04 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C3F4236;
        Mon, 17 Apr 2023 13:36:53 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id w15-20020a056830410f00b006a386a0568dso20202414ott.4;
        Mon, 17 Apr 2023 13:36:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681763813; x=1684355813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+QAWI6HAoCLsTSrdd3iRiJoq4aMeJmCh6mY2TAkIBc=;
        b=Dc12sEBCehwPTv2eVHr4DX7CX4vZkhkCg97430i+0oX2YBu45B67flbrTm8oarTh8r
         omncR29qlDa5pNPTD+3GGCnSf8GWXmYHvniFuFJ4HYi3ya4CmqbrFr5/U/bnDmE/0iFw
         UwoH8aClvKTSmY1NdGuZZNQ5NRLVT1V+VdGQUs03jcAyaz3WLJ9RKmIJFhmXwzM72pkC
         /acMG9EDcetJDStRKYcOervo0jCLV1pkS5TQmYSJHS1zO9oPNw0UBXIlTPLkh2zhjjGp
         kD0agEbEQqEg0sgyMqtCf9e/PGqGWleVqtKiYfXy0wo+Jf0hMiEWzMbnVdDrGJrrCKVC
         cvhg==
X-Gm-Message-State: AAQBX9co+hAEBS/Ubav6WYMYkg6j9MpJo4Di/U+3bQj42bsU58avZ8x5
        sw41AZeP23RifIC3+AAK/w==
X-Google-Smtp-Source: AKy350ZzPROXT2PlKvU2SU951qQVWLCRSEIxLBJC/mGvKH/rXm//HY70PVAU5Zz6bI6JxxuBMbXmxw==
X-Received: by 2002:a9d:6217:0:b0:6a2:49e6:9afc with SMTP id g23-20020a9d6217000000b006a249e69afcmr7537309otj.12.1681763813076;
        Mon, 17 Apr 2023 13:36:53 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f24-20020a9d7b58000000b006a5e0165d3esm1789231oto.19.2023.04.17.13.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:36:52 -0700 (PDT)
Received: (nullmailer pid 3327898 invoked by uid 1000);
        Mon, 17 Apr 2023 20:36:51 -0000
Date:   Mon, 17 Apr 2023 15:36:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     William Qiu <william.qiu@starfivetech.com>,
        linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hal Feng <hal.feng@starfivetech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-clk@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v3 5/7] dt-bindings: soc: starfive: Add StarFive syscon
 module
Message-ID: <20230417203651.GA3319886-robh@kernel.org>
References: <20230414024157.53203-1-xingyu.wu@starfivetech.com>
 <20230414024157.53203-6-xingyu.wu@starfivetech.com>
 <168147484896.3576391.17289619505417988717.robh@kernel.org>
 <8c396a98-a76e-cd68-4d26-15ae3a15a623@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c396a98-a76e-cd68-4d26-15ae3a15a623@starfivetech.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 03:43:48PM +0800, Xingyu Wu wrote:
> On 2023/4/14 20:37, Rob Herring wrote:
> > 
> > On Fri, 14 Apr 2023 10:41:55 +0800, Xingyu Wu wrote:
> >> From: William Qiu <william.qiu@starfivetech.com>
> >> 
> >> Add documentation to describe StarFive System Controller Registers.
> >> 
> >> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> >> ---
> >>  .../soc/starfive/starfive,jh7110-syscon.yaml  | 58 +++++++++++++++++++
> >>  MAINTAINERS                                   |  6 ++
> >>  2 files changed, 64 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
> >> 
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > ./Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/clock/starfive,jh7110-pll.yaml
> > 
> > doc reference errors (make refcheckdocs):
> > 
> > See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230414024157.53203-6-xingyu.wu@starfivetech.com
> > 
> > The base for the series is generally the latest rc1. A different dependency
> > should be noted in *this* patch.
> > 
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> > 
> > pip3 install dtschema --upgrade
> > 
> > Please check and re-submit after running the above command yourself. Note
> > that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> > your schema. However, it must be unset to test all examples with your schema.
> > 
> 
> I have updated yamllint and dtschema, and tested it and didn't see this error.
> I asked william and also didn't see this. This error says the file:
> http://devicetree.org/schemas/clock/starfive,jh7110-pll.yaml was not found.
> This file is added in patch 1 but patch 1 should be applied after these patchset
> about JH7110 basic clock drivers. I don't know if that's the reason.

Yes, patch 1 could not be applied[1].

Rob

[1] https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230414024157.53203-2-xingyu.wu@starfivetech.com/
