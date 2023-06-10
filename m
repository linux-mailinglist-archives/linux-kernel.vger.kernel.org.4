Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF5972AD1D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 18:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjFJQQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 12:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFJQQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 12:16:25 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFCB30DD;
        Sat, 10 Jun 2023 09:16:05 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-978863fb00fso500821666b.3;
        Sat, 10 Jun 2023 09:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686413764; x=1689005764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iykgIKjjxkQC0iF6CPvpsM3rMPFudjl8N64c3ex61jQ=;
        b=Mtf6He6s/QN8TiwNWeLCZoj5CiJRnWMFhVFukaHoOI1KbHqGnhnl/J6wDRpo8I0fd7
         DIE0pXHUYRQ3V6sInfXdt7i/M2x4DYfm9MCsS4fo7AUVLWkoRcYqtGM/fCiqkIcxYdK1
         hKPPeMAplt+2UGvUJHY8QAbGKFZ4UwoBgox+l8MKei3qg7jHMoaHi+I0K3/rFClznYid
         r+b3V7dhBx/iDlTLg8zODMYiBnvWUkpyKvEKaV9AuUUXpRs8HWqO6tamF444Wj3RH5YZ
         /8ampRyNylIpDBzksaGvcLUrcJVkdhm5AgXJ0BytOlynw9ZYbdkGDmEAb37hG1QdS7AS
         OSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686413764; x=1689005764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iykgIKjjxkQC0iF6CPvpsM3rMPFudjl8N64c3ex61jQ=;
        b=k/z8WmKEL37VXrGQnZt1PXVpTSYOUDinJqCkPANbYvCLIN1VCzZEFlZgu9BspjDuqo
         R6XrX+LeQHoIswk5pmkZKsimzIEBVN0O14w4MpMvB1m6lpV93gekwd0Yh9H7i9Y1vbRL
         747Q/XoS388FS7ZiVojTsjzF2lUGD0h0VB0phmwGz8uuFxczj40nRnCnUZ9sp33hgdLk
         yEkM5O0YYUvKcLJuXNUrfhu35kLGaoHU291turKq8Y7be9CUd/5UVryYfsaUOYarf9KZ
         iuroTjndcr199S1/dNHSNT9r2HK4bpgOi/xlbdduwMWSjV1VccEBK6+C0FggQjjIb2Z5
         mMuQ==
X-Gm-Message-State: AC+VfDwOx+5MIOL+AIX3gXDRlLqslU52J1dKfk57oudqOTGf/rygUofz
        fzsBll2dpOk4mCMyweeqM5+tH916rhzjdTqfiM0=
X-Google-Smtp-Source: ACHHUZ5MSGxwbWWnndDcYjuv/3cdAQTV5Zw6a33v7H1CVdOEzhJP97/iR4Mnt8zGvf9ZP03fMF0YpgAyTbQP2Lse/UM=
X-Received: by 2002:a17:907:7244:b0:97e:a9ed:16bb with SMTP id
 ds4-20020a170907724400b0097ea9ed16bbmr786437ejc.18.1686413763631; Sat, 10 Jun
 2023 09:16:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230610122934.953106-1-bigunclemax@gmail.com>
 <20230610122934.953106-3-bigunclemax@gmail.com> <20230610-ranged-outboard-2aaa0cc36cbd@spud>
 <CALHCpMhHxAdDMGmpD9i2Kt93XqyrW_ABzr7FZSE-0+54LwgzPw@mail.gmail.com> <20230610-enchanted-late-e545ab2d74a0@spud>
In-Reply-To: <20230610-enchanted-late-e545ab2d74a0@spud>
From:   Maxim Kiselev <bigunclemax@gmail.com>
Date:   Sat, 10 Jun 2023 19:15:52 +0300
Message-ID: <CALHCpMg=k8r4o+qhLi-e3qSUFZp_4N0F=U1vDazoDQgJwZs3tg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: iio: adc: Add Allwinner
 D1/T113s/R329/T507 SoCs GPADC
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
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

=D1=81=D0=B1, 10 =D0=B8=D1=8E=D0=BD. 2023=E2=80=AF=D0=B3. =D0=B2 18:53, Con=
or Dooley <conor@kernel.org>:
>
> On Sat, Jun 10, 2023 at 06:48:08PM +0300, Maxim Kiselev wrote:
> > Hey,
> >
> > =D1=81=D0=B1, 10 =D0=B8=D1=8E=D0=BD. 2023=E2=80=AF=D0=B3. =D0=B2 18:06,=
 Conor Dooley <conor@kernel.org>:
> >
> > ...
> >
> > > >+
> > > >+    required:
> > > >+      - reg
> > > >+
> > > >+    additionalProperties: false
>
> [1]
>
> > > >+
> > > >+required:
> > > >+  - "#io-channel-cells"
> > > >+  - clocks
> > > >+  - compatible
> > > >+  - interrupts
> > > >+  - reg
> > > >+  - resets
> > > >+
> > > >+unevaluatedProperties: false
> > >
> > > How come this one changed to unevaluatedProperties: false?
> > > Wasn't it for the ADC that we previously discussed whether
> > > additionalProperties: false was correct or not?
> >
> > Hmm, I changed it to `unevaluatedProperties: false` as you suggested
> > in this message
> > https://lore.kernel.org/lkml/20230604-afternoon-frighten-42222010557b@s=
pud/
>
> That was about the adc child nodes [1], not at the top level, no?

Indeed, I confused it, sorry.
