Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA15A74140D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjF1OsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjF1Or6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:47:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9503198D;
        Wed, 28 Jun 2023 07:47:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C08F6134F;
        Wed, 28 Jun 2023 14:47:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF9DC433AB;
        Wed, 28 Jun 2023 14:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687963676;
        bh=dbZOpf4AHAye+gEQztEqh9VIZLtkDBUxqZMPbmGLl+s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hfVM45dloMH8kpSz4RnA6tTn5Ld1YZSOxngo6gRx8gB3cT0jp2HHXLgRp1fqBX0II
         cRTCk3pUyZMlclcJjZhOvrGdpR6LsjtdtAIB9CFX8M06Fno2t8wbDdtvm2bO3ZO0HO
         wv2KGOkj6SWDomsTKE70W8+70NOSs7wQRt62S0wlg+tfHGG3EO/YjGk/7EuAhJklCu
         jbpCeOayrir5ber3sfzyJaw3OtBlx4W4228/0Wn99AI7AWigdjDCRDaYnPg+/FzlhA
         K7newaxYSpWKyWXYY3gHfeGn7sojCWniftizFjyObeXh8vOPBMm85iWCUeQGyqLLQ4
         OxrVFy7ElWGnw==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2b44d77e56bso13402021fa.1;
        Wed, 28 Jun 2023 07:47:56 -0700 (PDT)
X-Gm-Message-State: AC+VfDw3twsgY06x0TFWDaJo/y6X2CZ/qTB+WP6cOIh2Vm77snwRWo1G
        wxyMAD2p85DlAYueSi1CdJVLnAapqSMaHmiNxg==
X-Google-Smtp-Source: ACHHUZ4FS2dC/MyJZTtVWrak5Zf1juHvb3xJu2MhfMoNpMasZghaqSA4jeia3iUcQKn0qlQLZbYEpYsJBo81i/I041E=
X-Received: by 2002:a05:651c:124b:b0:2b6:a694:aaa1 with SMTP id
 h11-20020a05651c124b00b002b6a694aaa1mr615716ljh.1.1687963674155; Wed, 28 Jun
 2023 07:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com> <1687955688-20809-9-git-send-email-quic_mojha@quicinc.com>
In-Reply-To: <1687955688-20809-9-git-send-email-quic_mojha@quicinc.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 28 Jun 2023 08:47:41 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ_TTnGjjB2d8_FKHpWBRG5GHLoWnabCKjsdeZ4QFdNEg@mail.gmail.com>
Message-ID: <CAL_JsqJ_TTnGjjB2d8_FKHpWBRG5GHLoWnabCKjsdeZ4QFdNEg@mail.gmail.com>
Subject: Re: [PATCH v4 08/21] dt-bindings: reserved-memory: Add qcom,ramoops binding
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     corbet@lwn.net, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, keescook@chromium.org, tony.luck@intel.com,
        gpiccoli@igalia.com, mathieu.poirier@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, linus.walleij@linaro.org,
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

On Wed, Jun 28, 2023 at 6:36=E2=80=AFAM Mukesh Ojha <quic_mojha@quicinc.com=
> wrote:
>
> Qualcomm ramoops minidump logger provide a means of storing
> the ramoops data to some dynamically reserved memory instead
> of traditionally implemented ramoops where the region should
> be statically fixed ram region. Its device tree binding
> would be exactly same as ramoops device tree binding and is
> going to contain traditional ramoops frontend data and this
> content will be collected via Qualcomm minidump infrastructure
> provided from the boot firmware.

The big difference is if firmware is not deciding where this log
lives, then it doesn't need to be in DT. How does anything except the
kernel that allocates the log find the logs?

I'm pretty sure I already said all this before.

>
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  .../devicetree/bindings/soc/qcom/qcom,ramoops.yaml | 126 +++++++++++++++=
++++++
>  1 file changed, 126 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,ramoo=
ps.yaml
>
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,ramoops.yaml=
 b/Documentation/devicetree/bindings/soc/qcom/qcom,ramoops.yaml
> new file mode 100644
> index 000000000000..b1fdcf3f8ad4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,ramoops.yaml
> @@ -0,0 +1,126 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/soc/qcom/qcom,ramoops.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Qualcomm Ramoops minidump logger
> +
> +description: |
> +  Qualcomm ramoops minidump logger provide a means of storing the ramoop=
s
> +  data to some dynamically reserved memory instead of traditionally
> +  implemented ramoops where the region should be statically fixed ram
> +  region. Because of its similarity with ramoops it will also have same
> +  set of property what ramoops have it in its schema and is going to
> +  contain traditional ramoops frontend data and this region will be
> +  collected via Qualcomm minidump infrastructure provided from the
> +  boot firmware.
> +
> +maintainers:
> +  - Mukesh Ojha <quic_mojha@quicinc.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - qcom,sm8450-ramoops
> +      - const: qcom,ramoops
> +
> +  memory-region:
> +    maxItems: 1
> +    description: handle to memory reservation for qcom,ramoops region.
> +
> +  ecc-size:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: enables ECC support and specifies ECC buffer size in by=
tes
> +    default: 0 # no ECC
> +
> +  record-size:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: maximum size in bytes of each kmsg dump
> +    default: 0
> +
> +  console-size:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: size in bytes of log buffer reserved for kernel message=
s
> +    default: 0
> +
> +  ftrace-size:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: size in bytes of log buffer reserved for function traci=
ng and profiling
> +    default: 0
> +
> +  pmsg-size:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: size in bytes of log buffer reserved for userspace mess=
ages
> +    default: 0
> +
> +  mem-type:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: if present, sets the type of mapping is to be used to m=
ap the reserved region.
> +    default: 0
> +    oneOf:
> +      - const: 0
> +        description: write-combined
> +      - const: 1
> +        description: unbuffered
> +      - const: 2
> +        description: cached
> +
> +  max-reason:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 2 # log oopses and panics
> +    maximum: 0x7fffffff
> +    description: |
> +      If present, sets maximum type of kmsg dump reasons to store.
> +      This can be set to INT_MAX to store all kmsg dumps.
> +      See include/linux/kmsg_dump.h KMSG_DUMP_* for other kmsg dump reas=
on values.
> +      Setting this to 0 (KMSG_DUMP_UNDEF), means the reason filtering wi=
ll be
> +      controlled by the printk.always_kmsg_dump boot param.
> +      If unset, it will be 2 (KMSG_DUMP_OOPS), otherwise 5 (KMSG_DUMP_MA=
X).
> +
> +  flags:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0
> +    description: |
> +      If present, pass ramoops behavioral flags
> +      (see include/linux/pstore_ram.h RAMOOPS_FLAG_* for flag values).
> +
> +  no-dump-oops:
> +    deprecated: true

Why would you define deprecated properties in a *new* binding?

> +    type: boolean
> +    description: |
> +      Use max_reason instead. If present, and max_reason is not specifie=
d,
> +      it is equivalent to max_reason =3D 1 (KMSG_DUMP_PANIC).
> +
> +  unbuffered:
> +    deprecated: true
> +    type: boolean
> +    description: |
> +      Use mem_type instead. If present, and mem_type is not specified,
> +      it is equivalent to mem_type =3D 1 and uses unbuffered mappings to=
 map
> +      the reserved region (defaults to buffered mappings mem_type =3D 0)=
.
> +      If both are specified -- "mem_type" overrides "unbuffered".
> +
> +unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - memory-region
> +
> +anyOf:
> +  - required: [record-size]
> +  - required: [console-size]
> +  - required: [ftrace-size]
> +  - required: [pmsg-size]
> +
> +examples:
> +  - |
> +
> +    qcom_ramoops {
> +        compatible =3D "qcom,sm8450-ramoops", "qcom,ramoops";
> +        memory-region =3D <&qcom_ramoops_region>;
> +        console-size =3D <0x8000>;    /* 32kB */
> +        record-size =3D <0x400>;      /*  1kB */
> +        ecc-size =3D <16>;
> +    };
> --
> 2.7.4
>
