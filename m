Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8314E6B5CC3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 15:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjCKOUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 09:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjCKOUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 09:20:13 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F096123C4B;
        Sat, 11 Mar 2023 06:18:35 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id l16-20020a9d4c10000000b006944b17058cso4504160otf.2;
        Sat, 11 Mar 2023 06:18:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678544289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XV/mrDBGKbRUqTXikDz3w8VFKTgqnuQ8vz5vXQLzCt4=;
        b=4P3klQaTwaf9ODmnymteM51ga+ZgRjWDH21Frbwznu5jpf+1l4lZqRujsvKXBOUOmq
         ttTn0uq1PTqBH+nXUTrxb/eJL7T6yIu1sDSkmBs2C49MoG+N+G66MzL+TnzEf4Rcf1Kj
         QkqoFZwSMpCOvqHtJaNCNOvaffPpfgsZeu67czBPss7p7s+CJFh9s7dcRLvVt4CNrocl
         QabAd3GCENwCFG6z+YoBRuqFSq0d1yN9Y+aiIuVeRl2Hg3laJBgWZ9OVVDIenvyk2iWV
         7kn3wMVy9IvPjdqNp+jgWCOIs2SkegDfm7f8fn8jeXeDMuyzJmm18so0yM3qaAs7YH2I
         F2vw==
X-Gm-Message-State: AO0yUKWJi4bQhIA6+iEhRI0Hw/Q7JsM/EVjxKc8sTP/Al8BXrGOgvozr
        hDCkQc0+6aMpdYnpuvrMXg==
X-Google-Smtp-Source: AK7set/I2cIlMz9mjzMsoaRlf96D2re3kZv70KnZkmskujOeyOmASWokfFmrMBBd5MHvRaSiMvy+MQ==
X-Received: by 2002:a05:6830:2b1e:b0:693:d8a3:1816 with SMTP id l30-20020a0568302b1e00b00693d8a31816mr18572913otv.16.1678544289266;
        Sat, 11 Mar 2023 06:18:09 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80f1:6fdb:8060:4df8:4037:6d6f])
        by smtp.gmail.com with ESMTPSA id t9-20020a056830082900b0069452b2aa2dsm1172512ots.50.2023.03.11.06.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 06:18:08 -0800 (PST)
Received: (nullmailer pid 142278 invoked by uid 1000);
        Sat, 11 Mar 2023 14:18:03 -0000
Date:   Sat, 11 Mar 2023 08:18:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, devicetree@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>,
        Marc Zyngier <maz@kernel.org>, linux-riscv@lists.infradead.org,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 12/21] dt-bindings: clock: Add StarFive JH7110
 always-on clock and reset generator
Message-ID: <167854426637.141815.17209731765325744156.robh@kernel.org>
References: <20230311090733.56918-1-hal.feng@starfivetech.com>
 <20230311090733.56918-13-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230311090733.56918-13-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 11 Mar 2023 17:07:24 +0800, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
> 
> Add bindings for the always-on clock and reset generator (AONCRG) on the
> JH7110 RISC-V SoC by StarFive Ltd.
> 
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../clock/starfive,jh7110-aoncrg.yaml         | 107 ++++++++++++++++++
>  .../dt-bindings/clock/starfive,jh7110-crg.h   |  18 +++
>  .../dt-bindings/reset/starfive,jh7110-crg.h   |  12 ++
>  3 files changed, 137 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-aoncrg.yaml
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

Missing tags:

Reviewed-by: Rob Herring <robh@kernel.org>



