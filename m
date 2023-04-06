Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF9E6D8F9B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 08:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235550AbjDFGkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 02:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbjDFGkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 02:40:21 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D715102;
        Wed,  5 Apr 2023 23:40:20 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b20so146847749edd.1;
        Wed, 05 Apr 2023 23:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680763218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ufn8dXIrnh+56Iea4gFx0gEX9oFLFPbZkbSS9EDVPbA=;
        b=fnJmHXkS2uyJjTmT3M6mMzRezWhpgHAgnt756Nb+ik0p9gixZjwrz7Z4/YqDN02THY
         Be58g0grhcXPBndhQETpFchxKaPbVFYpiJmjBg9Lhb2Fg5/uiBYoTC/G4IQwh7t+4lqi
         //UhTEXWr6WY9mRlSMJCl1nfISa9UByZ2o6RKHEm31XxuMu075zVF1gnbEZL82u+1nQL
         Djf9YFGdGf2rBdQaOGFivSZp5laX4lswHSRNqPFbxE+6bpUYdixhefzOh/IRR1DHe2F7
         HG3di5HCADSwluycWG3FxosUxs0jomgIzbAo3etbwibwYndaB0P+MNznCakHUpr9orB+
         gtgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680763218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ufn8dXIrnh+56Iea4gFx0gEX9oFLFPbZkbSS9EDVPbA=;
        b=wXlkXt04q+xsW/oaSLvVwv4j1MS9ruvbnItuYVnruGQHL7dDf9evE0SgdSl8wGqjIT
         67JHmyVJ0j9uXr9tu5E825z/IDeEhmgRCUkXAb+GSirIyaow+fuNP8p8/9PBA/Nw8sjC
         VHk4pPfSIzMAkux7AAkHygcbKGDEtnZEg0qE0MIkrbV5Oi81tpvA6k8fkKy4BA1tbxON
         dqkZ39zqDGub6wHFNcHPYNkhEf3V3D08anZGQVoTiu8dCym01VXmd3Teci7iOTS0vQya
         zIWh29MbtjuJtBQ7VK920OXp90Fh/6ZwuFQjINgt7Bxi8b6I3vu7f+KpTgUj/jtIa5Ac
         SSoA==
X-Gm-Message-State: AAQBX9dIdjG/RYiYKrsMimFEVb6tXPLJ+yS14+90HoIYtzGDskv9g54o
        j9+IE6UnpNo0qG9lFax6NIZYy2zg5TkFzqjXsg4NaL8s
X-Google-Smtp-Source: AKy350ZaitaIP37QKRvJ09Xxq14dBzKuBhP+qsRlaK9rt9XekriZtwV+88QyzbMY8o0YYuKBJFV84rdt3YK3h7b9m5s=
X-Received: by 2002:a17:906:3a8f:b0:947:335f:5a10 with SMTP id
 y15-20020a1709063a8f00b00947335f5a10mr2624674ejd.12.1680763218206; Wed, 05
 Apr 2023 23:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230405200341.4911-1-danascape@gmail.com> <168074344623.1301612.621743725976519280.robh@kernel.org>
In-Reply-To: <168074344623.1301612.621743725976519280.robh@kernel.org>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 6 Apr 2023 09:40:06 +0300
Message-ID: <CAEnQRZBCN6JrjvaJSD5dnuLXOUyx8Y9LOucY_Fwqcf4ZZLuwJg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: dt-bindings: wm8904: Convert to dtschema
To:     Rob Herring <robh@kernel.org>
Cc:     Saalim Quadri <danascape@gmail.com>, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.baluta@nxp.com,
        robh+dt@kernel.org, broonie@kernel.org,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com
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

On Thu, Apr 6, 2023 at 4:24=E2=80=AFAM Rob Herring <robh@kernel.org> wrote:
>
>
> On Thu, 06 Apr 2023 01:33:41 +0530, Saalim Quadri wrote:
> > Convert the WM8904 audio CODEC bindings to DT schema
> >
> > Signed-off-by: Saalim Quadri <danascape@gmail.com>
> > ---
> >  .../devicetree/bindings/sound/wlf,wm8904.yaml | 66 +++++++++++++++++++
> >  .../devicetree/bindings/sound/wm8904.txt      | 33 ----------
> >  2 files changed, 66 insertions(+), 33 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8904.=
yaml
> >  delete mode 100644 Documentation/devicetree/bindings/sound/wm8904.txt
> >
>
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
>
So, these properties are present in some dts files! We need to
evaluated if they are always expected
or can be optional.

> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
>
> Full log is available here: https://patchwork.ozlabs.org/project/devicetr=
ee-bindings/patch/20230405200341.4911-1-danascape@gmail.com
>
>
> audio-codec@1a: Unevaluated properties are not allowed ('AVDD-supply', 'C=
PVDD-supply', 'DBVDD-supply', 'DCVDD-supply', 'MICVDD-supply' were unexpect=
ed)
>         arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dtb
>         arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dtb
>
