Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1B067EF48
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 21:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbjA0UHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 15:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbjA0UHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 15:07:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2AA88CCF;
        Fri, 27 Jan 2023 12:05:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6FB361D9D;
        Fri, 27 Jan 2023 20:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410AAC433A4;
        Fri, 27 Jan 2023 20:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674849957;
        bh=v29blagsokF4DUYAWbvcpTiop0WyodX0gl/oyRzswqA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P3wMkOsmn/C6ifTpe0WSVeEB0ovdAXKs6HeHt68o0xMi0ysOsRvQKvkm4Aic9WQVV
         QuQ58v1cCfguXjQcLRiS9rqBxqjocjfkAjWiDAnLdAlyIFWcDV0/NqvCsvBhjCtUkY
         ajr7C/+lVYhOyi62hyy1gR61+yUyf2HBqFM45QczIo8fFapswJBDfH3D3FoKFP3mry
         YWfVKzVK/aqiC/LfKjprLrvjoOiZMVgSgk2inE2+rOIjfRhwbkvD4cspG+Q0p7qhBK
         P/wUIWrDXaR057BpjV1YmbPxjHS7rJ0Yk46AkycLntAg2vLNQuZSbMdIrew6dhE6FX
         KWXjC/cr59s9Q==
Received: by mail-vs1-f48.google.com with SMTP id h19so4685794vsv.13;
        Fri, 27 Jan 2023 12:05:57 -0800 (PST)
X-Gm-Message-State: AFqh2krchwUg//fwMF4FSzV5XvDNk/bRgVXl8y0gTtOveCLPwIOvYPtp
        PhPiBA6h6KrwIsxk4UWsUCq2gk9++38C5I6lNA==
X-Google-Smtp-Source: AMrXdXu9qsE8D6rWHgYZwwCPcVxgXD2SdLnghYhLaXPA9fqnGjkWOWvQtB2DHP+Tq8yStJ4VrPxvSNnkBQbACCj47Z0=
X-Received: by 2002:a67:ef8a:0:b0:3d0:b955:e0af with SMTP id
 r10-20020a67ef8a000000b003d0b955e0afmr6106856vsp.26.1674849956011; Fri, 27
 Jan 2023 12:05:56 -0800 (PST)
MIME-Version: 1.0
References: <1674835252-31954-1-git-send-email-quic_mojha@quicinc.com>
In-Reply-To: <1674835252-31954-1-git-send-email-quic_mojha@quicinc.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 27 Jan 2023 14:05:44 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK_wuOwJS=dSkSdYs10kE1S3gmtHVU31wkxkP5wT39qqg@mail.gmail.com>
Message-ID: <CAL_JsqK_wuOwJS=dSkSdYs10kE1S3gmtHVU31wkxkP5wT39qqg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: ramoops: Inherit reserve memory property
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 10:01 AM Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>
> The reserved memory region for ramoops is assumed to be at a
> fixed and known location when read from the devicetree. This
> is not desirable in an environment where it is preferred the
> region to be dynamically allocated at runtime, as opposed to
> being fixed at compile time.

I don't see how this can work. How do you find the region after
rebooting? Or this is only used for the current boot? If so, provide a
userspace interface to configure it (or the existing module params).

The addition of 'size' type regions was primarily for large carveouts
that needed to be allocated before anything else. ramoops is not that.
It's 10s or 100s of KB at most.


> So, update the ramoops binding by inheriting some reserve memory
> property to allocate the ramoops region dynamically.
>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Guilherme G. Piccoli <gpiccoli@igalia.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
> Changes in v4:
>  - Addressed comment made by Krzysztof on ramoops node name.
>
> Changes in v3:
>  - Fixed yaml error and updated commit text as per comment.
>
> Change in v2:
>   - Added this patch as per changes going to be done in patch 3/3
>
>  .../bindings/reserved-memory/ramoops.yaml          | 34 ++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml b/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
> index 0391871..8741626 100644
> --- a/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
> +++ b/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
> @@ -10,7 +10,8 @@ description: |
>    ramoops provides persistent RAM storage for oops and panics, so they can be
>    recovered after a reboot. This is a child-node of "/reserved-memory", and
>    is named "ramoops" after the backend, rather than "pstore" which is the
> -  subsystem.
> +  subsystem. This region can be reserved both statically or dynamically by
> +  using appropriate property in device tree.
>
>    Parts of this storage may be set aside for other persistent log buffers, such
>    as kernel log messages, or for optional ECC error-correction data.  The total
> @@ -112,7 +113,13 @@ unevaluatedProperties: false
>
>  required:
>    - compatible
> -  - reg
> +
> +oneOf:
> +  - required:
> +      - reg
> +
> +  - required:
> +      - size
>
>  anyOf:
>    - required: [record-size]
> @@ -142,3 +149,26 @@ examples:
>              };
>          };
>      };
> +
> +  - |
> +    / {

You can't have multiple root node examples. Check the example dts, the
examples will be merged together.

> +        compatible = "foo";
> +        model = "foo";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        reserved-memory {
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +            ranges;
> +
> +            ramoops_region: ramoops {
> +                compatible = "ramoops";
> +                alloc-ranges = <0x00000000 0xffffffff>;
> +                size = <0x0 0x10000>;       /* 64kB */
> +                console-size = <0x8000>;    /* 32kB */
> +                record-size = <0x400>;      /*  1kB */
> +                ecc-size = <16>;
> +            };
> +        };
> +    };
> --
> 2.7.4
>
