Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492E873BF22
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 21:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjFWT7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 15:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjFWT7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 15:59:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C46E65;
        Fri, 23 Jun 2023 12:59:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BAA861B07;
        Fri, 23 Jun 2023 19:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987A7C433CB;
        Fri, 23 Jun 2023 19:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687550376;
        bh=x69fHIP2je3gDZwqyjGBKo1jt2snNaQ3tcGdMwx/N+c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h+bwh8gf8SGSpQNtRQ/ZcPyyRsuy595Iwc7fBtTeSEMBchLYDMvIrMFZLcrWUEHdd
         NYLwcBOc485+Q6KCuYQbdu1A3/PxPBDtqxJGs8OwbR/QHD7OwJMffJXX3iGH691c5K
         55rvSD/aqtgFrSzed8Je8MQKUzG2wUq54uz5OgnMUAvMJX/e7vJjdM6cvuE/dIdfo4
         VGBCUzaQdMlkt7c1mICHSu0yeQlX6rnL6yqiP//qrfKuUWNNko+3NaFYIZ40bYF106
         xCL02yW/tdi4UUBu4xGZUO/sFDywwgTr838TxBl/5yEXPg/UxeEcvBLBU6t1vOZZba
         5hij9z6V7kQYQ==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2b4636bb22eso17615711fa.2;
        Fri, 23 Jun 2023 12:59:36 -0700 (PDT)
X-Gm-Message-State: AC+VfDzcY66wGoMBZaPhnY9qv15ATDgIKD1F+xYOzsl0lFOpG6fn0Qij
        jkG128SfL4arl+/d8nb2CIG2tn9c/uZoMoOT8A==
X-Google-Smtp-Source: ACHHUZ4YXbnWqXIH9PucV4QWrhD1DoIEcrGRjoJNH9gv7TQjOZQ/B27CwVHmHZUHVvbtfIyJA/J1lD8HhD4jCdIPyfg=
X-Received: by 2002:a05:651c:105b:b0:2a7:b986:3481 with SMTP id
 x27-20020a05651c105b00b002a7b9863481mr14772424ljm.41.1687550374565; Fri, 23
 Jun 2023 12:59:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230516184626.154892-1-afd@ti.com> <20230516184626.154892-2-afd@ti.com>
 <20230517075310.iduc2eisw7a5bm45@krzk-bin>
In-Reply-To: <20230517075310.iduc2eisw7a5bm45@krzk-bin>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 23 Jun 2023 13:59:21 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL7EPkBAigGJ8iR4t532R82N0fFFmb4BVUw84xpb0545w@mail.gmail.com>
Message-ID: <CAL_JsqL7EPkBAigGJ8iR4t532R82N0fFFmb4BVUw84xpb0545w@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: clock: ehrpwm: Remove unneeded syscon compatible
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andrew Davis <afd@ti.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 1:53=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On Tue, 16 May 2023 13:46:26 -0500, Andrew Davis wrote:
> > This node's register space is not accessed by any other node, which
> > is the traditional use for the "syscon" hint. It looks to have been
> > added here to make use of a Linux kernel helper syscon_node_to_regmap()=
.
> > The Linux driver now uses a more appropriate helper that does not
> > require the hint, so let's remove it from the binding.
> >
> > Signed-off-by: Andrew Davis <afd@ti.com>
> > ---
> >  .../devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml     | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/m=
fd/ti,j721e-system-controller.example.dtb: scm-conf@100000: clock-controlle=
r@4140:compatible: ['ti,am654-ehrpwm-tbclk', 'syscon'] is too long
>         From schema: /builds/robherring/dt-review-ci/linux/Documentation/=
devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/m=
fd/ti,j721e-system-controller.example.dtb: clock-controller@4140: compatibl=
e: ['ti,am654-ehrpwm-tbclk', 'syscon'] is too long
>         From schema: /builds/robherring/dt-review-ci/linux/Documentation/=
devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml

Now failing in linux-next.

Rob
