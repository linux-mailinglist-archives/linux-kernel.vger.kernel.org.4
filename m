Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA986F9FF1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 08:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbjEHGag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 02:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbjEHGab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 02:30:31 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20AD150D7
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 23:30:22 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-559debdedb5so61873767b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 23:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683527421; x=1686119421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EiW0EErM60L5kKyN8Tg1XRCsrwIPCFSbfaR0hDH4fIM=;
        b=PD5U7ZMhII+6+SjvgyG4A5wFy7HdkIORS9BQEGaFBmJjE9+oMN0Vx8HqiWZs4eVOPs
         afuHj1WMTyyw/hS0ED2tANEKGvJ4ptWToyfBrqtRdOtAe6SfT5kQODSfuLqgeUr4tX7o
         mU0JgACABNru85+HGLVuNmKLvj1xgeGQDFlGX5IprfGDeoDm/jnmj3MtccOX8TBDvXPK
         65cCc7knVFso0feyk/QJtDFhd+2nFo4LbgZjLF+Z/r0gtsRAtmxkcyrkqyyMOTHznhrg
         gcRiVhptcrcmE32WIR6JYFjATJ6rWFR9+WRi0NzOlRuGV0gLL9vNkyAM3kH9UFCIAMNo
         hang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683527421; x=1686119421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EiW0EErM60L5kKyN8Tg1XRCsrwIPCFSbfaR0hDH4fIM=;
        b=ZON3MP1zsHNby9RwbUHwri8c5hPVfZMkxq42AY71TmfXb9TkOWkK7qwmN0Ly8U8v4W
         NgAfgwj4DNk104e3eKd57ZPRtEG6WNsTfbnv6LClA8QtfqiOZ3NMiElV5OMp6p7WA3wt
         4QpQPsvn6MiDwsc1Wgg4RMbCmmCposQnBNnXXxtQ6C/kIPs0XxnyykDlymvBEQQNz36g
         S1Ia6JVUwZfdN5gtCVFzmQ9sK4MarWMlQds8gkGh5+0wvmtrrkmmWEQ898vLM/W3ORD6
         dDb6WaXojnUryFfrxgi5YHl43O+YbXcTn1PXhvw7lvEMwJwc8TsRS90lRFPA70tgPML6
         n83Q==
X-Gm-Message-State: AC+VfDyJn6pa4nBwFO3RsnNd0nisRvBv1RkLMJ5TKF2zLCQN/8jzlTkF
        f5RcfPunHjg1UMKLYWj429nkmoybjQ0sioorBTU4eg+MxFTQkdBY
X-Google-Smtp-Source: ACHHUZ56+p3cOj5Ygdf5gAj+LPJUGFCGrlnUoUN/TeVRSYGs3dJ22juJvikJC8sZjsPhzK4znwJaCoGPzbb8PFzrKkw=
X-Received: by 2002:a81:6587:0:b0:555:cee3:d143 with SMTP id
 z129-20020a816587000000b00555cee3d143mr10089004ywb.4.1683527421593; Sun, 07
 May 2023 23:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230426-stmpe-dt-bindings-v3-0-eac1d736e488@linaro.org>
 <20230426-stmpe-dt-bindings-v3-1-eac1d736e488@linaro.org> <168349835606.3623231.4270033272905089508.robh@kernel.org>
In-Reply-To: <168349835606.3623231.4270033272905089508.robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 8 May 2023 08:30:10 +0200
Message-ID: <CACRpkdZsC6s3MjX5Mkr5u763CYSAotJKcK5wZMwCQxgEzvw+vQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: gpio: Add STMPE YAML DT schema
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-gpio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        linux-stm32@st-md-mailman.stormreply.com,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stefan Agner <stefan@agner.ch>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Lee Jones <lee@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 8, 2023 at 12:26=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
> On Sun, 07 May 2023 23:19:19 +0200, Linus Walleij wrote:

> > This adds a schema for the STMPE GPIO that while it is used a
> > lot in the kernel tree is anyway missing its bindings.
> >
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > ChangeLog v2->v3:
> > - Use a compact hog node schema backed by the standard hog
> >   schema.
> > ChangeLog v1->v2:
> > - New patch split off from the MFD patch.
> > ---
> >  .../devicetree/bindings/gpio/st,stmpe-gpio.yaml    | 51 ++++++++++++++=
++++++++
> >  1 file changed, 51 insertions(+)
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/m=
edia/i2c/ovti,ov2685.example.dtb: camera-sensor@3c: port:endpoint:data-lane=
s: [[1]] is too short
>         From schema: /builds/robherring/dt-review-ci/linux/Documentation/=
devicetree/bindings/media/i2c/ovti,ov2685.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/m=
edia/rockchip-isp1.example.dtb: camera@3c: port:endpoint:data-lanes: [[1]] =
is too short
>         From schema: /builds/robherring/dt-review-ci/linux/Documentation/=
devicetree/bindings/media/i2c/ovti,ov2685.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/p=
ci/fsl,imx6q-pcie-ep.example.dtb: pcie-ep@33800000: Unevaluated properties =
are not allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigne=
d-clocks' were unexpected)
>         From schema: /builds/robherring/dt-review-ci/linux/Documentation/=
devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml

Looks like these are not mine...

Yours,
Linus Walleij
