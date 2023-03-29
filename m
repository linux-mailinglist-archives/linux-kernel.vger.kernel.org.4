Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7D96CD05F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 04:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjC2CvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 22:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjC2CvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 22:51:13 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CBC2D7F;
        Tue, 28 Mar 2023 19:51:11 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id eh3so57549389edb.11;
        Tue, 28 Mar 2023 19:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680058270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIzil1J+XzZVkE7VYxYF65ET2u5OaR0BuUTGA5SK+3A=;
        b=lGNK9Nvogi60ODmJUdGqiRoAeG692JLaGSJPxyyPBqDx6p3s8leRhzxDJ+/XjXFa5x
         lyIVL4hM5fAs8w3aSnbYjP2+Jj+BJXOH0o4vj7p+xw/8UoRy43jp3lBXduKr5WFFi37f
         z7HOHN6w+6nMgaK7eYnmpvJ5zKSHVPvvv8bgQNaIn7HlmstcUwCZSIX0GG/GtgG4SeYX
         e1kseVRdrS+IvArSeB3bO3nelYX/jn96Io1Ton3GMjyOg8aI8IzWDhuAK7gLL4/N5LX/
         J6q6Uger7FaAHkNlVtiVDsSpYhqDka1Gapt89RgNCWfO5oXsaKtqTlRphbV7Z3UskFYI
         YjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680058270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIzil1J+XzZVkE7VYxYF65ET2u5OaR0BuUTGA5SK+3A=;
        b=45GB1uLwG8mWHI+g4yAJzPq1jWNjo5GMaX7NaO0YPQnebOvqMEN6Hn8G1w6q8TS3yF
         YH6e7f48tj2sPiG/uQJ5dz84qwT1OpAOpByj/uy7Qd2PZsG0KzhLhgh10Su2KNFrzMRg
         FUQJCbytR44S9RMW5ODFIAndTUZJp7UtbK97kXjJoK3gVa+Wqn9UmDVMfLPFlqY2cojv
         3yq5x6S5D2z1I6CKZJIqQrgcTs54lDOTOVjtnUVn5EtjRvKnSfhJO10Td4z/NsYnAGfX
         N7CzECueZOc+ohMjJiw8qsiYY8bk0szdgtm6l+UyYKmTSdy8KV/UJ5dwyHCGv2etnFxd
         8/iw==
X-Gm-Message-State: AAQBX9fX6qux6Lrv9yu9b2hyznpSPFmsEILm4pRcUXqLUV8yaUi3WvkQ
        R/mI4yWZb9h9wBX4g8nmRwP/OO/QxuKDY/Fl17YHogyhj/hlUQ==
X-Google-Smtp-Source: AKy350bsrVpBT2/hOrtU+Hcf6gmZmN9zv4UBYcj7fxKuRxjEcKxZzyOpQIU+ffxGL6Wgjcnn1vA4rB+hEVxrZs8F96M=
X-Received: by 2002:a50:875e:0:b0:501:d2f5:7da9 with SMTP id
 30-20020a50875e000000b00501d2f57da9mr8498486edv.0.1680058269743; Tue, 28 Mar
 2023 19:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230328120506.375864-1-keguang.zhang@gmail.com>
 <20230328120506.375864-3-keguang.zhang@gmail.com> <168002881746.3753096.11245437677389006840.robh@kernel.org>
In-Reply-To: <168002881746.3753096.11245437677389006840.robh@kernel.org>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Wed, 29 Mar 2023 10:50:53 +0800
Message-ID: <CAJhJPsXBsP9akD9x++r7YCs_P-n2SpKJnJcDoJv93_=8+r1C-Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: timer: Add Loongson-1 clocksource
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Wed, Mar 29, 2023 at 2:52=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
>
> On Tue, 28 Mar 2023 20:05:05 +0800, Keguang Zhang wrote:
> > Add devicetree binding document for Loongson-1 clocksource.
> >
> > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > ---
> >  .../timer/loongson,ls1x-pwmtimer.yaml         | 48 +++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/timer/loongson,ls=
1x-pwmtimer.yaml
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/timer/loongson,ls1x-pwmtimer.example.dt=
s:21:18: fatal error: dt-bindings/clock/loongson,ls1x-clk.h: No such file o=
r directory
>    21 |         #include <dt-bindings/clock/loongson,ls1x-clk.h>
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This file is contained in commit
12de2f50244efdbc8e98f89a340255c3c847e1dc, which is already available
in 6.3-rc4.

> compilation terminated.
> make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings=
/timer/loongson,ls1x-pwmtimer.example.dtb] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1512: dt_binding_check] Error 2
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202303=
28120506.375864-3-keguang.zhang@gmail.com
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


--=20
Best regards,

Keguang Zhang
