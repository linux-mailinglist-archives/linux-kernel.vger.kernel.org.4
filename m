Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3163712CBC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242986AbjEZSof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243070AbjEZSoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:44:30 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C35FE4D;
        Fri, 26 May 2023 11:44:08 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3f6b94062f3so4996781cf.0;
        Fri, 26 May 2023 11:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685126647; x=1687718647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8Soqmr4Cmql4V9gPC0Ws8IpyroUmhGOvXmfI1LG86I=;
        b=rMrfJD4XR25ov+VQKVpVXNLko3z+n+hYq+eqbbIKeSLxBZeLok5c3moKNx/BOZETSM
         i9Fo0DK8+f4g30TZN+bbW1NY22Zk4fuLha97rZRgnCldTR1LBUPYZwm9nXVmfTSQe/lD
         hEv085fHLVhPhg1Ts5cvBWEOZ0UcGX1i7CZEzXOJxQ7xsB0/26fmdU4vGxEz0LEtRSMX
         z5Jra5cDaReWO4CHcqAfOJfzvo7sOAXb9Fj6v9IpHE3Mk8sFtomUFLIkp4g2lOKy0zgQ
         /Bd2B97pGX8Kjyj1YaSw0fk8h60Uim4n+d356L6ZQCqGMHZ2AMxyt70gBBl8J0jcgme1
         158Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685126647; x=1687718647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8Soqmr4Cmql4V9gPC0Ws8IpyroUmhGOvXmfI1LG86I=;
        b=bOd8KOswEy6fIqVceiG4EkyO7z40Wb3g8jHq5rPtmfVfVA3HqhziprjDXUg2T4xPkG
         cCxd9aEYyImYkZUU977HEqLWcQ47p3t14wETxc/pt5wBtrMARdQ0F3fXdwWTDQTNFHjL
         gF0CD3kaNSHWMZ25v973tybDnu7uZhpHHQFGlye1dmqF/NRVFIHozzAdbKRNII+3Y2ck
         GeFgRL3ngSlVrnPr/cb+nbSlJD4kkw+PeiyYpkUnErJM/oNC+3XxWcws1H51v5xv5eBF
         tN21zuhXrSktvPzkRNK9eEoaB2briwLe6dLhery0LNdH6nSXH95JxtQP3Wc/5E0c5yV8
         IIBw==
X-Gm-Message-State: AC+VfDxeiyYyu74CmVWPHcSRhFR0MAxurE7mrSqTDuO/KZcU/MjGgX1q
        S6At4udVOf7xQgcyvRRQ/tCdCdlOE81eZs5wX6Y=
X-Google-Smtp-Source: ACHHUZ6HPf/Zp+tv2MrQlVYxIjGwBqf41XojhtMIEYqJ0MXZo+9KV8MKMi/GS8Zzk+m1rV1hHZ04/K7mY2aI6ESPOGA=
X-Received: by 2002:a05:622a:1a08:b0:3f6:b9af:51eb with SMTP id
 f8-20020a05622a1a0800b003f6b9af51ebmr2971771qtb.38.1685126647582; Fri, 26 May
 2023 11:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230522163115.2592883-1-eblanc@baylibre.com> <20230522163115.2592883-3-eblanc@baylibre.com>
 <ZG0QmjZwvzWbNwA4@surfacebook> <CSVF1AQBGQU0.1V5KJP08TCKLT@burritosblues>
In-Reply-To: <CSVF1AQBGQU0.1V5KJP08TCKLT@burritosblues>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 26 May 2023 21:43:31 +0300
Message-ID: <CAHp75VcF65xZUVYB1mjK4HV86=m+ayESeDD2Nwas7UDoJjeLSA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] pinctrl: tps6594: Add driver for TPS6594 pinctrl
 and GPIOs
To:     Esteban Blanc <eblanc@baylibre.com>
Cc:     linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, jpanis@baylibre.com,
        jneanne@baylibre.com, aseketeli@baylibre.com, u-kumar1@ti.com
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

On Thu, May 25, 2023 at 5:07=E2=80=AFPM Esteban Blanc <eblanc@baylibre.com>=
 wrote:
> On Tue May 23, 2023 at 9:14 PM CEST,  wrote:
> > Mon, May 22, 2023 at 06:31:14PM +0200, Esteban Blanc kirjoitti:

...

> > > +// Used to compute register address of GPIO1_CONF to GPIO11_CONF
> >
> > This is good.

Btw

  the register

and shouldn't it start from GPIO0_CONF (please, double check, my
memory can do tricks on me)?

--=20
With Best Regards,
Andy Shevchenko
