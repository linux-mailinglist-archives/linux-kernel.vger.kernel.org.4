Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5540A72AEAB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 22:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjFJUbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 16:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjFJUbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 16:31:18 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AA735B0;
        Sat, 10 Jun 2023 13:31:17 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51475e981f0so5151377a12.1;
        Sat, 10 Jun 2023 13:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686429075; x=1689021075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CUfh0ADpVTOvYtA/QmP/1yzn/jTq6xsCBbjiRAuVBc=;
        b=M47Bs76cJZduUe2jX233QqIV+egitW4UlsEXHue+q2T4KOH4cAqzlb7wCpSXUpI5ei
         /Pi7TGIp+sOjRdi+kTM4L67E/u7YIbJu5mtyl5qUDc4RFchU5c7uHXsAAwTt2H1uoxCV
         Hfqzlj8/B7SADPb/+YEln2DmCrLl/Yo+Yzv6RjbzPMQEMW6/YascdgSIY28YE+Wec9/X
         dX91y+QUiMlkJ54z+Gc8eIHBpvT+1ngCWfGJUg4QW5plYiX6uWT0y75UJ+SRiTpW0A0o
         i+q82f/xOnog1S1/ovoy3GKVHDZl0Ns+Ce2hERd9m+gppCFbqIY+AmGOFjnmi9V37reW
         2Cdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686429075; x=1689021075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7CUfh0ADpVTOvYtA/QmP/1yzn/jTq6xsCBbjiRAuVBc=;
        b=cTeGS1Cf1q3R35wL+CS6pnAev4dYq2dDN4h3O9FbnlgtbfZxhoXvzQ/jkJF/gfPl2p
         1TLi6dDL23RzXoyoHgZZS1ofs4CidP4fPZpYXo4LVlUp5sck4lzuQ/vLljZyMhIQbNvk
         O2mMCeHiWm7MPgxlt54Ee2pe25oGexcWAfDF5nj7+uwbJChkCyyF7nqRS6UYv289aXpi
         JatvMwBe0majo+aOb8NkRJ2SMHtzqyrAfYegOU14WJ7/wGgqeXpJ6vl79bm7GrgXfzy6
         oDKhqSUi2sCI5bv5xIR6b/W95XLO3EVezYo9QHdPtoU6Saka9q3knvfGTQh7Iv8a/0bb
         19Uw==
X-Gm-Message-State: AC+VfDz4uP8GlYqt3m9sdv+J3FsmaPjyIFQIPaXjLeJvMqGRqJ/h7rLZ
        47t8xOG6wnX5VdEMWYF7bccaGlJF6tmgi5WoQHaQEidMI96Nquss
X-Google-Smtp-Source: ACHHUZ4dpstWeM5AQfuAw9+nOwca/wduEjuy/62JuC2LfBIkzmkX6x8lh9InUH1M4rzcmOxdrSkt3SvaUvu4hsiDGbc=
X-Received: by 2002:a17:907:9724:b0:979:7624:1f70 with SMTP id
 jg36-20020a170907972400b0097976241f70mr6808874ejc.18.1686429075593; Sat, 10
 Jun 2023 13:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230610141739.999268-1-bigunclemax@gmail.com>
 <20230610141739.999268-4-bigunclemax@gmail.com> <20230610-rehire-amid-2517f43504c0@spud>
 <CALHCpMiEmc8L=O86_x7-KkBHFwf2QpuP0M7ugz7dNPr71cpJmQ@mail.gmail.com>
 <20230610-enlarged-agonize-0e9219f9921d@spud> <20230610-crumpet-spender-4133090a4728@spud>
In-Reply-To: <20230610-crumpet-spender-4133090a4728@spud>
From:   Maxim Kiselev <bigunclemax@gmail.com>
Date:   Sat, 10 Jun 2023 23:31:03 +0300
Message-ID: <CALHCpMjFNvJAnd2_3-1n_L3QRz4eNc-Egm-BD6jcS6H694dSyg@mail.gmail.com>
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

=D1=81=D0=B1, 10 =D0=B8=D1=8E=D0=BD. 2023=E2=80=AF=D0=B3. =D0=B2 21:01, Con=
or Dooley <conor@kernel.org>:

...

> > > > +  - |
> > > > +    thermal-sensor@2009400 {
> > > > +          compatible =3D "allwinner,sun20i-d1-ths";
> > > > +          reg =3D <0x02009400 0x400>;
> > > > +          interrupts =3D <0 90 0>;
> > > > +          clocks =3D <&ccu 0>;
> > > > +          clock-names =3D "bus";
> > > > +          resets =3D <&ccu 2>;
> > > > +          nvmem-cells =3D <&ths_calibration>;
> > > > +          nvmem-cell-names =3D "calibration";
> > > > +          #thermal-sensor-cells =3D <0>;
> > > >
> > > >> Is this calibration required, or optional, for the d1?
> > >
> > > Calibration data for the D1 is optional as for the H6.
> > > (But without it, the sensor data will be inaccurate).
> >
> > Okay. Modulo the signoff:
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
> Wait, that's not what I meant to say... Clearly turned my brain off for
> a moment. If it is not going to function correctly without the
> calibration data, why not make the calibration data required for the
> d1's ths?

I don't really know why, but the calibration data is optional for
other controllers.
So I just did it the same way.
Here is explanation comment about it from the driver:
        /*
         * Even if the external calibration data stored in sid is
         * not accessible, the THS hardware can still work, although
         * the data won't be so accurate.
         *
         * The default value of calibration register is 0x800 for
         * every sensor, and the calibration value is usually 0x7xx
         * or 0x8xx, so they won't be away from the default value
         * for a lot.
         *
         * So here we do not return error if the calibration data is
         * not available, except the probe needs deferring.
         */
