Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EA4610959
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 06:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJ1EjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 00:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiJ1EjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 00:39:21 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02531A1B04;
        Thu, 27 Oct 2022 21:39:20 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e19so2428892ili.4;
        Thu, 27 Oct 2022 21:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WhBTGaBcgzM59zxiugd1LdPyjuKQI0L1h5Ir7by9Mo=;
        b=dmoaYIR9+pOQ2cu0Zj77vWOIrDG3SHVAUs75YWWHe+zERA3giEDX5sRZRvn1j0PAfq
         OhOBPMh9KMos2fnr8MAEJCY1pSnkTBX951s1zMxj6+r2kOynw5Yi23bkm7dRi8Yz8A5/
         PfX/HRTPUHnVcDrkx9Acz8Lj6j1WY6HTSD2FDro0R3Dg8PG43wCbP93mlVDZj0t/OVwV
         S3Z87LQeWF3WcYrt2yCSSQJQOO72mi31RYcbj1uU6U1OPlrjNVFz5iuo5fTWFid5kD/y
         63Y0GXmkY8wffgT2q+Z0j1cZo9hdA+ZMRaGflrCnLMQDr4q6hG5q/+Wauq0aY+dTaEkL
         SDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WhBTGaBcgzM59zxiugd1LdPyjuKQI0L1h5Ir7by9Mo=;
        b=HEAZHsKi79nRWWDcTLhnfC38YKsL9xuuTomOPSmVrFA1V9kAfVFCi0xImRUN/Ut/5j
         CSfiuBaDFFxxqnf70NvSuiFc755CYOQlznFDIuh05PJPWDTxzfjM3IYZYVh/D5Koqyyp
         /sBqgyE2rDnYv+wgtLkz1aaXvRf6nmOrNHQRFzJUWU0G8/2TiE15a+uA46UKigZWaNHr
         2JTYDsqMq6OaNaA/aQRE8uFFkQIX2xTBABJzHDu8sswUeNXmkXNRsjmTqsTP/0pQtSf0
         FsOc1sgW4/0Ud/LYb9DgtlnSQHzDeobcpWWVTHIykFeqUhMORYH5rZ+/rY6VeAFV9SVR
         2QnA==
X-Gm-Message-State: ACrzQf2cd+Ubve9N6si+nUcI3qEAbHiIdpqU6gZ937bl+WZWrlIiSpRQ
        Z026fFCw2V1PMrmFCy4rQ6KRkp5W5VecJpH9kkY=
X-Google-Smtp-Source: AMsMyM4K7vKfzl95B9uiZeNHtdbNAXz5q8UtaraFfmCu8xRlrsj2A63VBuhsOdt8ODpayZIfLekoxRq+QsDbjKWZXEE=
X-Received: by 2002:a05:6e02:20ea:b0:2fa:bf8:300a with SMTP id
 q10-20020a056e0220ea00b002fa0bf8300amr32908132ilv.309.1666931960039; Thu, 27
 Oct 2022 21:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221027192024.484320-1-lis8215@gmail.com> <20221027192024.484320-4-lis8215@gmail.com>
 <20221027215716.77250C433D6@smtp.kernel.org>
In-Reply-To: <20221027215716.77250C433D6@smtp.kernel.org>
From:   Siarhei Volkau <lis8215@gmail.com>
Date:   Fri, 28 Oct 2022 07:39:08 +0300
Message-ID: <CAKNVLfaA20jO0HMDMU28e-96HaQEAZ5At_vqQU+Ni_tEEt84gQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] clk: Add Ingenic JZ4755 CGU driver
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=BF=D1=82, 28 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 00:57, Stephen Boy=
d <sboyd@kernel.org>:
>
> Quoting Siarhei Volkau (2022-10-27 12:20:23)
> > diff --git a/drivers/clk/ingenic/jz4755-cgu.c b/drivers/clk/ingenic/jz4=
755-cgu.c
> > new file mode 100644
> > index 000000000..d2eb3ae0c
> > --- /dev/null
> > +++ b/drivers/clk/ingenic/jz4755-cgu.c
> > @@ -0,0 +1,346 @@
> [...]
> > +static void __init jz4755_cgu_init(struct device_node *np)
> > +{
> > +       int retval;
> > +
> > +       cgu =3D ingenic_cgu_new(jz4755_cgu_clocks,
> > +                             ARRAY_SIZE(jz4755_cgu_clocks), np);
> > +       if (!cgu) {
> > +               pr_err("%s: failed to initialise CGU\n", __func__);
> > +               return;
> > +       }
> > +
> > +       retval =3D ingenic_cgu_register_clocks(cgu);
> > +       if (retval)
> > +               pr_err("%s: failed to register CGU Clocks\n", __func__)=
;
> > +
> > +       ingenic_cgu_register_syscore_ops(cgu);
> > +}
> > +CLK_OF_DECLARE_DRIVER(jz4755_cgu, "ingenic,jz4755-cgu", jz4755_cgu_ini=
t);
>
> Is there another driver that probes this device? CLK_OF_DECLARE_DRIVER()
> is for the situation where we want to probe this device again with
> another platform driver. Please add a comment indicating what that other
> driver is.

I wasn't aware of that, it's just
> + * Heavily based on JZ4725b CGU driver
with no comment either, same as a few others.
Maybe it's better to fix that in a separate commit as per Paul's
proposal on unused macros'?
