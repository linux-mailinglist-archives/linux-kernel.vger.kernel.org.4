Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E22A72CE7E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjFLSeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237125AbjFLSeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:34:25 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19B7171F;
        Mon, 12 Jun 2023 11:34:10 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-977d6aa3758so846760366b.0;
        Mon, 12 Jun 2023 11:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686594849; x=1689186849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjxKYpDykfJHHAFMlYnHgt/KtNfNEauymoXHInEP4vM=;
        b=fdYVg3CrHfYmOH+yQnThlmPuy5K7Ec9e+rHetrmfAE8U3jCTdYy30Lz22r6JK/dUWO
         fGXiUbALgxdGn2lw2KSzhZYVZ1cEYH6M8+p8bbAR5d7mr/T2LqrOGv2cmf/Rt8SPBagW
         zIVLfGcnCEGk0C/e6R76r6ovMDsRaFgQmgmwLTtA1i3UzQHEfQHkqdSwYK6fLpm4xFgE
         mjrdut3xCamDSyzfp1xFRAs+hmGZ5wKc+D5rE7joQF4E8WiovvkeVt8Wq0Ce7QoKtd00
         f50SP5YRSF2zVFRDJ/jPYFMRfoITlONYXDYUSNMbdOm8fFNXBrZBWelj/LNME/yZlee8
         3uBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686594849; x=1689186849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjxKYpDykfJHHAFMlYnHgt/KtNfNEauymoXHInEP4vM=;
        b=ZtZ4lEcyxBElQb655qg0t2JRlbeh84ONsPYPDgY5B7nr+BNX/FHwCo0B0HWNrlo+yN
         P7jE6/bXZaJPLrHSs3MlSj2iEQM+rRJuXJDhoblJ89KhrLmUA3T3IhsDgVpJPPj82Qsu
         V9z2uJGhW0B7WlEZ1W/RdFS+zfoX9qop7uNpZ4U/ieMBtV5tc6LkExY+nyb81pho66Zb
         9AYUmmGaCj8Ub7aFHEi4ZIqdTryQmETjZWyza5+dqYIc3COxk1kOWofywY1wzqfIiXMx
         Q6zNf5AFVICBqDLfvWFcjaUZ6TErMaTjdM2/0ofWDHVtXq2Zhp6nGWSdo3nNa0i94UF3
         pYEg==
X-Gm-Message-State: AC+VfDw4R83fE5hNIiqQkAe+rL98y0egt4+oF51HjlHXelqn/MiUNtaj
        YXoRnpJtzuIG12D0TwaoD6VxAOb8W3cmtPjl4TY=
X-Google-Smtp-Source: ACHHUZ6HVJPNDxoxp2Cvdq8Nf48yX+kPMvxENdK/HbCk4P4iVuj89/INjrfgS3cZ3HvNthb6VJXM7cJI0toaf9QtkR0=
X-Received: by 2002:a17:907:320a:b0:975:942e:81d5 with SMTP id
 xg10-20020a170907320a00b00975942e81d5mr10759652ejb.1.1686594848974; Mon, 12
 Jun 2023 11:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230610203549.1127334-1-bigunclemax@gmail.com> <13282074.uLZWGnKmhe@jernej-laptop>
In-Reply-To: <13282074.uLZWGnKmhe@jernej-laptop>
From:   Maxim Kiselev <bigunclemax@gmail.com>
Date:   Mon, 12 Jun 2023 21:33:57 +0300
Message-ID: <CALHCpMi9h_KGJKJ4qH44kypePsMpqjgDke-A1LiBgiSOnXjXLA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add D1/T113s thermal sensor controller support
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
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
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Andre Przywara <andre.przywara@arm.com>,
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

=D0=BF=D0=BD, 12 =D0=B8=D1=8E=D0=BD. 2023=E2=80=AF=D0=B3. =D0=B2 21:22, Jer=
nej =C5=A0krabec <jernej.skrabec@gmail.com>:
>
> Dne sobota, 10. junij 2023 ob 22:35:41 CEST je Maksim Kiselev napisal(a):
> > This series adds support for Allwinner D1/T113s thermal sensor controll=
er.
> > THIS controller is similar to the one on H6, but with only one sensor a=
nd
> > uses a different scale and offset values.
> >
> > v2:
> > - Fixed SoB tag
>
> It doesn't seems you fixed that.

Sorry for that. I accidentally sent the wrong version of patches . And
immediately after that I sent v3.
