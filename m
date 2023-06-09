Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F787729C25
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239078AbjFIOEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjFIOEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:04:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2B11BE2;
        Fri,  9 Jun 2023 07:04:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA597657C1;
        Fri,  9 Jun 2023 14:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F5EC433AE;
        Fri,  9 Jun 2023 14:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686319439;
        bh=4I/YaRz0JPgSntsbq21xyleaxpnwMk0f+rSHrten7Nw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QTjPr4BQzbZS7kcBkdvcX9gguddiAcRUQeBYOrvpCGkV1OocqyYgmEtB9r+hOPi9+
         tSxL8Bwm9vWyFef8f2ODCmzw5xl4CkyNGwIrKIIp7+K9qPuEFvtV/7qN88f7LqW/ax
         Kmc8FMV1/RmQx5mDWnHLFDkWLlPBjlQrvSFaTY51eHzHOF4dzuQWrYbWZRNEfHo9Vf
         S4foi/r3ypOX0hupQDiv6EHZHIPsGFiU0VJGsrhoQyscRUvpM7XjSq6sLzpdPEc2Yr
         Yj784qpihdV77wqQV6ZQ5NEKxNQw8ph2rvRfq9XdRvIYR02Uho5nbuREYXb2zT1gpe
         BVmLUhqW5MO3A==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2b1b66a8fd5so20031511fa.0;
        Fri, 09 Jun 2023 07:03:58 -0700 (PDT)
X-Gm-Message-State: AC+VfDwi1aIaPxzZxQWim2WVWGfw5AOoD2oio15v7vEipzZnx15Y8eyd
        B9GgBwZTczb4CnLW6OC7XAigFmFQTHyqze8NJg==
X-Google-Smtp-Source: ACHHUZ5YQv2XPsQRf7fiS5EHNK3U/O/dTd2T5JKiUmddht7wp+IV/pFj6+87nrAXOzHuwKYwetH7tBI6o/ZkH7J0SvU=
X-Received: by 2002:a2e:9942:0:b0:2b1:b8ad:3456 with SMTP id
 r2-20020a2e9942000000b002b1b8ad3456mr1157920ljj.50.1686319436756; Fri, 09 Jun
 2023 07:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230608-sitting-bath-31eddc03c5a5@spud> <168624654839.3085745.9088493205796442132.robh@kernel.org>
 <20230608-unlucky-carpenter-b3a95f269712@spud>
In-Reply-To: <20230608-unlucky-carpenter-b3a95f269712@spud>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 9 Jun 2023 08:03:44 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK8pr5itTr8xTOf=h7zOan6giGsQcwQ-zUCbjtpUsosfw@mail.gmail.com>
Message-ID: <CAL_JsqK8pr5itTr8xTOf=h7zOan6giGsQcwQ-zUCbjtpUsosfw@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: riscv: deprecate riscv,isa
To:     Conor Dooley <conor@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Oleksii <oleksii.kurochko@gmail.com>,
        Anup Patel <apatel@ventanamicro.com>, qemu-riscv@nongnu.org,
        u-boot@lists.denx.de, Andrew Jones <ajones@ventanamicro.com>,
        palmer@dabbelt.com, Atish Patra <atishp@atishpatra.org>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Rick Chen <rick@andestech.com>, linux-kernel@vger.kernel.org,
        Leo <ycliang@andestech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 8, 2023 at 12:05=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Thu, Jun 08, 2023 at 11:49:08AM -0600, Rob Herring wrote:
> > On Thu, 08 Jun 2023 17:54:05 +0100, Conor Dooley wrote:
>
> > > As a result of implementing Sean's suggestion, I believe I need to ad=
d
> > > riscv,isa-extensions as an exception to the rules preventing vendor
> > > properties being of object type, otherwise dt_binding_check is less t=
han
> > > happy with me.
>
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings=
/riscv/extensions.yaml: properties:riscv,isa-extensions: 'oneOf' conditiona=
l failed, one must be fixed:
> >       Additional properties are not allowed ('additionalProperties', 'p=
roperties' were unexpected)
> >               hint: A vendor boolean property can use "type: boolean"
> >       /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bi=
ndings/riscv/extensions.yaml: properties:riscv,isa-extensions: 'oneOf' cond=
itional failed, one must be fixed:
> >               'enum' is a required property
> >               'const' is a required property
> >               hint: A vendor string property with exact values has an i=
mplicit type
> >               from schema $id: http://devicetree.org/meta-schemas/vendo=
r-props.yaml#
> >       Additional properties are not allowed ('additionalProperties', 'p=
roperties', 'type' were unexpected)
> >               hint: A vendor string property with exact values has an i=
mplicit type
> >       /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bi=
ndings/riscv/extensions.yaml: properties:riscv,isa-extensions: 'oneOf' cond=
itional failed, one must be fixed:
> >               '$ref' is a required property
> >               'allOf' is a required property
> >               hint: A vendor property needs a $ref to types.yaml
> >               from schema $id: http://devicetree.org/meta-schemas/vendo=
r-props.yaml#
> >       'boolean' was expected
> >               hint: A vendor boolean property can use "type: boolean"
> >       hint: Vendor specific properties must have a type and description=
 unless they have a defined, common suffix.
> >       from schema $id: http://devicetree.org/meta-schemas/vendor-props.=
yaml#
>
> Yeah, expected. I think I need an exception in vendor-props for this to
> pass the checks.

Nope, vendor prefixes don't go in node names. That's not explicit
anywhere, but goes against using generic node names.

Also, note that looking at the DT spec, there's already prior art here
with PPC. See "power-isa-*". Though that appears in .dts files, but no
kernel code. Maybe you already saw that as your v1 is similar. There's
not really much advantage to align with it, but also not much reason
to deviate.

Rob
