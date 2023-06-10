Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867F272AC9A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 17:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbjFJPbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 11:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbjFJPbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 11:31:03 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC790184;
        Sat, 10 Jun 2023 08:31:01 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-977c72b116fso418356366b.3;
        Sat, 10 Jun 2023 08:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686411060; x=1689003060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxPCqAAcwCfGdUZiMxaBjYAZU0A3wquYmcYNKNjhuUY=;
        b=VW/oFge+/+Orjlr3UpOgqadtUtBJ58tLJh7c0ptmvXHTALLI1Zz51N8TQSh9+aWdzL
         7VvgNo2iitsbJxxSrRsWx2ElXrUNQuqwp58AqaSWSR4MSb2p9jFQXMx61pVnLw9CzoxG
         +r0AdHepDGV1z/buMuMRwTLzgjk7Czyiwrfdwe7PF5abkrNROckIPIIXpr7LBt7cY1sp
         EGzLGx82Tf4t+lCcuIQJGM9ENkfSvd62acQeVjSUx6IeJnINgNEDTEQ/AnZoyEfE7ybl
         KA2+DI0SydJ5SmngpTSk2UYMStrAzFTfDFZ5jYHKRZcjhkat9scfDh6JIkCrSwnTMZ4g
         7YcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686411060; x=1689003060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxPCqAAcwCfGdUZiMxaBjYAZU0A3wquYmcYNKNjhuUY=;
        b=DP6YVKQQNvCrAGeNS3VIppKe+SV17xsmXz0zgcug0CHDpdzXiXHs3/epY56PSoafRP
         oxjElST0ND8wux59GX9yAUD2pFTz2Nrs9APZtqdzsQFYU3FqZeyCGU49MCTtlK0S7fx2
         ABHAV56f6t4KVumc2zYCIVPFlOkyPNxo2CkvLBdNdjSNBPIaiFL9P2vNfuOE621j25bM
         b/eDHQZaYJoOaeA9oS4N0rVALb4VnA9DdrIwpTMJ0Sec01wtKsS8fM4QaAsfEM+WXA6d
         sJfHrI/R22rMppdPBRnYdegJkqCG1zdKdtk4k7phb7xfAKIcD1PJ3mG88gInN80uQxjo
         77cg==
X-Gm-Message-State: AC+VfDyr2t1FLnyBu53aBzRb9g/raTe0QuCenLYoZt87DxrDoDUJyyne
        4iV3sv30q1hB0ctouwvUtLUjZ+Mizl+9vaS+uod/D5bKqrsKqk6U
X-Google-Smtp-Source: ACHHUZ5ze2gv8QfGmKLPkmbnKeZqHcnYPyn27zxIIkW9XeukUemNkvD0q1gl/Wy1GyoPAlHRwGYvRgduuF0eBtVKhis=
X-Received: by 2002:a17:907:c15:b0:97b:4c8f:c44f with SMTP id
 ga21-20020a1709070c1500b0097b4c8fc44fmr3530103ejc.46.1686411059681; Sat, 10
 Jun 2023 08:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230610141739.999268-1-bigunclemax@gmail.com>
 <20230610141739.999268-4-bigunclemax@gmail.com> <20230610-rehire-amid-2517f43504c0@spud>
In-Reply-To: <20230610-rehire-amid-2517f43504c0@spud>
From:   Maxim Kiselev <bigunclemax@gmail.com>
Date:   Sat, 10 Jun 2023 18:30:48 +0300
Message-ID: <CALHCpMiEmc8L=O86_x7-KkBHFwf2QpuP0M7ugz7dNPr71cpJmQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] dt-bindings: thermal: sun8i: Add binding for
 D1/T113s THS controller
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D1=81=D0=B1, 10 =D0=B8=D1=8E=D0=BD. 2023=E2=80=AF=D0=B3. =D0=B2 17:52, Con=
or Dooley <conor@kernel.org>:

...

>
> Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
>
>> Why do you have 2 sign-offs that are both you w/ different spellings?

Sorry for that. I accidentally signed it twice.

...

> +  - |
> +    thermal-sensor@2009400 {
> +          compatible =3D "allwinner,sun20i-d1-ths";
> +          reg =3D <0x02009400 0x400>;
> +          interrupts =3D <0 90 0>;
> +          clocks =3D <&ccu 0>;
> +          clock-names =3D "bus";
> +          resets =3D <&ccu 2>;
> +          nvmem-cells =3D <&ths_calibration>;
> +          nvmem-cell-names =3D "calibration";
> +          #thermal-sensor-cells =3D <0>;
>
>> Is this calibration required, or optional, for the d1?

Calibration data for the D1 is optional as for the H6.
(But without it, the sensor data will be inaccurate).
