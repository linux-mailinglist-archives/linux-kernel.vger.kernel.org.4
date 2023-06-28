Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7D9741C52
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 01:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjF1XRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 19:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjF1XRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 19:17:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E86E9;
        Wed, 28 Jun 2023 16:17:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66BD561474;
        Wed, 28 Jun 2023 23:17:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF81EC43391;
        Wed, 28 Jun 2023 23:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687994248;
        bh=VQcWqfNNTGRXW5Ozv0/w4nPMT/sl/yWpT5PmnPkPk74=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=atpK9ksOcxjxOQ/o99GtzMLN19hLfA+A0x/mitDAap5vI4aSw2zgO4z0gQkU3Tk+H
         QVVgGIn7QPvAt5ugIhy/BwHmBfMhTHpfUXLXvAsgLCwkssQVeYKVYRvrqN+xIl6Sgc
         tMnavC/WigfwfaN7/ArbICstwMLl6N3kKz1aHPAZyPtfnuIQGhyrQqVu2iTtxy1ZmI
         ASjpBC5hYSRu1R4Yqs3MqilZumWk2u2EdXe/kEVSNzuLGgHICEffgy9YrxlCUXXs64
         5NKhnWoTvGPQY4IeFdSB9kK8bcQge+qH5hF4OqIgXttFTKjxIEYnIgBiWzN1EjtO8Z
         KbA6e7DyB4uVg==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2b69a48368fso1282521fa.0;
        Wed, 28 Jun 2023 16:17:28 -0700 (PDT)
X-Gm-Message-State: AC+VfDxjSLTddrWBJrAdUX4GaCczjYtfUB0SJ5F2fpR8rPpr+5JoioCg
        UZdNdjGsQqCy9XU6/6mJR9q0xK09vB2JDeLMCg==
X-Google-Smtp-Source: ACHHUZ5t3E6Lgo02OuiXhRW6tZNDUrS2Rw0d3km9/4NhcusiMHjhvXX4/2FJkrfNlbQ3ToIS4SAviVxVUXpmfjNjv8c=
X-Received: by 2002:a2e:88d0:0:b0:2b6:a7a7:3607 with SMTP id
 a16-20020a2e88d0000000b002b6a7a73607mr5574337ljk.49.1687994246752; Wed, 28
 Jun 2023 16:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
 <1687955688-20809-9-git-send-email-quic_mojha@quicinc.com> <87ba1c2d-fa0b-4ac5-ba79-b3556101b612@quicinc.com>
In-Reply-To: <87ba1c2d-fa0b-4ac5-ba79-b3556101b612@quicinc.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 28 Jun 2023 17:17:13 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+_G4wBR7tm+DvN-yYSaoAX6OgxHa0AToJYucDdhD=Dtg@mail.gmail.com>
Message-ID: <CAL_Jsq+_G4wBR7tm+DvN-yYSaoAX6OgxHa0AToJYucDdhD=Dtg@mail.gmail.com>
Subject: Re: [PATCH v4 08/21] dt-bindings: reserved-memory: Add qcom,ramoops binding
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc:     Mukesh Ojha <quic_mojha@quicinc.com>, corbet@lwn.net,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        mathieu.poirier@linaro.org, catalin.marinas@arm.com,
        will@kernel.org, linus.walleij@linaro.org,
        andy.shevchenko@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 8:11=E2=80=AFAM Pavan Kondeti <quic_pkondeti@quicin=
c.com> wrote:
>
> On Wed, Jun 28, 2023 at 06:04:35PM +0530, Mukesh Ojha wrote:
> > Qualcomm ramoops minidump logger provide a means of storing
> > the ramoops data to some dynamically reserved memory instead
> > of traditionally implemented ramoops where the region should
> > be statically fixed ram region. Its device tree binding
> > would be exactly same as ramoops device tree binding and is
> > going to contain traditional ramoops frontend data and this
> > content will be collected via Qualcomm minidump infrastructure
> > provided from the boot firmware.
> >
> > Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> > ---
> >  .../devicetree/bindings/soc/qcom/qcom,ramoops.yaml | 126 +++++++++++++=
++++++++
> >  1 file changed, 126 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,ram=
oops.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,ramoops.ya=
ml b/Documentation/devicetree/bindings/soc/qcom/qcom,ramoops.yaml
> > new file mode 100644
> > index 000000000000..b1fdcf3f8ad4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,ramoops.yaml
> > @@ -0,0 +1,126 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/soc/qcom/qcom,ramoops.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Qualcomm Ramoops minidump logger
> > +
> > +description: |
> > +  Qualcomm ramoops minidump logger provide a means of storing the ramo=
ops
> > +  data to some dynamically reserved memory instead of traditionally
> > +  implemented ramoops where the region should be statically fixed ram
> > +  region. Because of its similarity with ramoops it will also have sam=
e
> > +  set of property what ramoops have it in its schema and is going to
> > +  contain traditional ramoops frontend data and this region will be
> > +  collected via Qualcomm minidump infrastructure provided from the
> > +  boot firmware.
> > +
> > +maintainers:
> > +  - Mukesh Ojha <quic_mojha@quicinc.com>
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - qcom,sm8450-ramoops
> > +      - const: qcom,ramoops
> > +
> > +  memory-region:
> > +    maxItems: 1
> > +    description: handle to memory reservation for qcom,ramoops region.
> > +
> > +  ecc-size:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: enables ECC support and specifies ECC buffer size in =
bytes
> > +    default: 0 # no ECC
> > +
> > +  record-size:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: maximum size in bytes of each kmsg dump
> > +    default: 0
> > +
> > +  console-size:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: size in bytes of log buffer reserved for kernel messa=
ges
> > +    default: 0
> > +
> > +  ftrace-size:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: size in bytes of log buffer reserved for function tra=
cing and profiling
> > +    default: 0
> > +
> > +  pmsg-size:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: size in bytes of log buffer reserved for userspace me=
ssages
> > +    default: 0
> > +
> > +  mem-type:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: if present, sets the type of mapping is to be used to=
 map the reserved region.
> > +    default: 0
> > +    oneOf:
> > +      - const: 0
> > +        description: write-combined
> > +      - const: 1
> > +        description: unbuffered
> > +      - const: 2
> > +        description: cached
> > +
> > +  max-reason:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    default: 2 # log oopses and panics
> > +    maximum: 0x7fffffff
> > +    description: |
> > +      If present, sets maximum type of kmsg dump reasons to store.
> > +      This can be set to INT_MAX to store all kmsg dumps.
> > +      See include/linux/kmsg_dump.h KMSG_DUMP_* for other kmsg dump re=
ason values.
> > +      Setting this to 0 (KMSG_DUMP_UNDEF), means the reason filtering =
will be
> > +      controlled by the printk.always_kmsg_dump boot param.
> > +      If unset, it will be 2 (KMSG_DUMP_OOPS), otherwise 5 (KMSG_DUMP_=
MAX).
> > +
> > +  flags:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    default: 0
> > +    description: |
> > +      If present, pass ramoops behavioral flags
> > +      (see include/linux/pstore_ram.h RAMOOPS_FLAG_* for flag values).
> > +
> > +  no-dump-oops:
> > +    deprecated: true
> > +    type: boolean
> > +    description: |
> > +      Use max_reason instead. If present, and max_reason is not specif=
ied,
> > +      it is equivalent to max_reason =3D 1 (KMSG_DUMP_PANIC).
> > +
> > +  unbuffered:
> > +    deprecated: true
> > +    type: boolean
> > +    description: |
> > +      Use mem_type instead. If present, and mem_type is not specified,
> > +      it is equivalent to mem_type =3D 1 and uses unbuffered mappings =
to map
> > +      the reserved region (defaults to buffered mappings mem_type =3D =
0).
> > +      If both are specified -- "mem_type" overrides "unbuffered".
> > +
>
> Most of the properties you added here are already documented at
> Documentation/devicetree/bindings/reserved-memory/ramoops.yaml

That is certainly a problem. Don't define the same property more than
once. Not yet checked and enforced by the tools, but it will be.

> Can't we just reference them here? would something like work?
>
> max-reason:
>   $ref: "../../reserved-memory/ramoops.yaml#/properties/max-reason

Can work, but no. Common properties need to go into a schema of common
properties which the device specific schemas reference.

>
> > +unevaluatedProperties: false
> > +
>
> will there be any additional properties be added dynamically? if not,
> should not we use "additionalProperties: false" here?

I don't know what you mean by dynamically, but that's not the criteria
for which to use.

Rob
