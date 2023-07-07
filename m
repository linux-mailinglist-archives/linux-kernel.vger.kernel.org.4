Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FBF74B8A6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 23:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbjGGVYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 17:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjGGVYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 17:24:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56BD1FC6;
        Fri,  7 Jul 2023 14:24:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D68361866;
        Fri,  7 Jul 2023 21:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D164C433C8;
        Fri,  7 Jul 2023 21:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688765084;
        bh=G+d4KOWEk1wXy8u9qtfZ01SmJVIBU1UrPs7uv3d7fB4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gGpy61BiU3TIVBv+6T4Bj6QSGqobJ9AVL1JxYo2Pnk+7/BGs2Z220GJ+1jGriMp+4
         GDI8qpMfNhT4Kf1l4Leu38Xo0gWeE/9CctBDprHFr2QudGNGxgX427aKd0cK3NaURY
         XmuC4SWV2ddixE6Lq2tZNUnIQ3vdrpWd1/mD1yqnMn6BVeqPJyN3nv17t+R12w+eil
         OymXn7P1affC3X411MLJ727ynfFvK2tSZZkLHM5G86ZJXF+CfDj/1G00PJnF6vsfEM
         KXTlLJmc1XSn7QJ45LMNriVDTcx0cTQTDcbIpcryDfHVEsnTlByFdLpHzgo/hf/3g4
         H33MgHbf9VUkw==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2b703d7ed3aso38621521fa.1;
        Fri, 07 Jul 2023 14:24:44 -0700 (PDT)
X-Gm-Message-State: ABy/qLa8KQaDD6naUi12ZhJ91GHuDq/phuY173KbQlIr/jI3BT16652I
        LRUCzQg2qm4tzRNW87UYLVcbvYKjjWvxrm3mwA==
X-Google-Smtp-Source: APBJJlE6ugW2YHIKmWhWhAiS7uipRKQDgwf4HnMIWjN19FfoUdxCqdZhP0gk3DrCyJ0isLVGgJQkRZgV6Tet8cPlyK8=
X-Received: by 2002:a2e:7a16:0:b0:2b5:7a87:a85a with SMTP id
 v22-20020a2e7a16000000b002b57a87a85amr4695203ljc.13.1688765082593; Fri, 07
 Jul 2023 14:24:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230707210653.868907-1-robh@kernel.org>
In-Reply-To: <20230707210653.868907-1-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 7 Jul 2023 15:24:30 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJDHG=W7sObRU5iONhrMzEG9racR2ESrtFkux36a1f=nw@mail.gmail.com>
Message-ID: <CAL_JsqJDHG=W7sObRU5iONhrMzEG9racR2ESrtFkux36a1f=nw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: leds: Convert Panasonic AN30259A to DT schema
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, Jul 7, 2023 at 3:07=E2=80=AFPM Rob Herring <robh@kernel.org> wrote:
>
> Convert the Panasonic AN30259A 3-channel LED controller binding to DT
> schema format.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

[...]

> diff --git a/Documentation/devicetree/bindings/leds/panasonic,an30259a.ya=
ml b/Documentation/devicetree/bindings/leds/panasonic,an30259a.yaml
> new file mode 100644
> index 000000000000..f55f8c232bc6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/panasonic,an30259a.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/panasonic,an30259a.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Panasonic AN30259A 3-channel LED controller
> +
> +maintainers:
> +  - Simon Shields <simon@lineageos.org>

Bounces. Will need someone else.
