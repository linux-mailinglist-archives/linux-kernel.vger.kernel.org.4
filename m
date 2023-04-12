Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C894B6DFE56
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 21:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjDLTGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 15:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjDLTGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 15:06:12 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19947EEF;
        Wed, 12 Apr 2023 12:05:51 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id x26so1599654uav.3;
        Wed, 12 Apr 2023 12:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681326351; x=1683918351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHl3xMADI5hN6nrItE+CXMH7i3XUE1Fkq1lBYfWj2qI=;
        b=W0i+EXwCq0lk10i2ADD75/QRy/Gv6MULDmKOWNQg+XbwAdohtLGWoZHTjeKXO1MQ1y
         K3hOLok0vXeY2QaT/vZmgF3jaEYl5F7aAZh9D9DWKRaHl3BU1rtf5jIPt60YR1Hl8JRl
         wzMTRgxVOGBMze7O2zYczDucMj/cqanM1x1384og4iC8EX34hOfaTpGwoWCDVNq7NWrb
         SOqOaCc3yojI92X1UscXdspO6AhlK6E5K5Qc1jYz5N/K4dEuImciTPQHMBeVXPoVvquz
         rgzAlzoluUAAAM35EreHG+FffdLIAC0OQRfU7IJuPnoA62lU+TqKdqT7Ue0/LsBTT8U5
         DVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681326351; x=1683918351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHl3xMADI5hN6nrItE+CXMH7i3XUE1Fkq1lBYfWj2qI=;
        b=aWGLGAsGWHxpAVafK9ucfMzrLxfFuyPzXAgEp87FnTWVel2/fhs/950d7bpfwpPSIb
         YXBB0IlwGa8CxwJRW9xUlmRmo6A0uQ/BAM/WfK4Wi/MJZwGCO0D8r+0ay4fl8XZuI7eh
         w5aHL3yfctqHNDvTWTDoqkuNS0R+hJa9eka9Imc5bsowd5Gjt4PnsEqRzm6OQdcaaVe8
         s90kON/dW/6x1KRB2JBJLLMEJUwQnXNm9w3YHZ1Ctl51b5JuyEXobwqWtJf111tyuqBy
         dViqa5Be4CMPkk5WkBS210FT8j1maoDcoz1l7QPDLBqlvGVMcuZV7ZrWleB+cynYQuaC
         D1Rw==
X-Gm-Message-State: AAQBX9c30l/CUZhQeVsVIZjO0VDkoaQ1BrSH9p6hORbzxlsrCt0cTFzs
        BwU9KUqjdrQBfXmuEv8ojVzoFuM4v1KVHLqRKWE=
X-Google-Smtp-Source: AKy350aGXZ+e3Ra62TuD2YRo53mw5RvCkY3Z3NXI1XwydMgMZaL7UT8KWo7M2+ZH5h9j1t1gmueXD3LxnL7CGQXEFFU=
X-Received: by 2002:a1f:2192:0:b0:43f:c4ba:48ec with SMTP id
 h140-20020a1f2192000000b0043fc4ba48ecmr1992989vkh.0.1681326350844; Wed, 12
 Apr 2023 12:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230412025737.20280-1-mibodhi@gmail.com> <20230412025737.20280-2-mibodhi@gmail.com>
 <168130276446.1439316.3427548118074442016.robh@kernel.org>
In-Reply-To: <168130276446.1439316.3427548118074442016.robh@kernel.org>
From:   Tony Dinh <mibodhi@gmail.com>
Date:   Wed, 12 Apr 2023 12:05:39 -0700
Message-ID: <CAJaLiFxNbz+EygSy8OMKafZ667ingeiTw8Z17p3dwtPTpiH40g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ARM: dts: mvebu: Add device tree binding for
 Marvell Armada 38x
To:     Rob Herring <robh@kernel.org>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,
Hi Krzysztof,

On Wed, Apr 12, 2023 at 5:36=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
>
> On Tue, 11 Apr 2023 19:57:35 -0700, Tony Dinh wrote:
> > Add device tree binding for Marvell Armada 38x.
> >
> > Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> > ---
> >
> > Changes in v2:
> > - Add marvell,38x.yaml. For now, add this binding to the Marvell
> > directory to keep it consistent with other Marvell yaml files.
> > At a later date and a separate patch, consolidate the Marvell
> > yaml files into  marvell.yaml.
> >
> >  .../bindings/arm/marvell/armada-38x.yaml      | 27 +++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/marvell/armad=
a-38x.yaml
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> ./Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml: $id: rel=
ative path/filename doesn't match actual path or filename
>         expected: http://devicetree.org/schemas/arm/marvell/armada-38x.ya=
ml#
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202304=
12025737.20280-2-mibodhi@gmail.com
>
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your sch=
ema.
>

Thanks for the reviews. After running make dt_binding_check for it
seems like hours (on a dual-core 1.8GHz ARM box), I got impatient and
used
make CHECK_DTBS=3Dy armada-385-thecus-n2350.dtb

I'll move this to another faster box and run make dt_binding_check.

All the best,
Tony
