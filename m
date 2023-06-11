Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B296A72B0AA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 09:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbjFKHyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 03:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbjFKHyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 03:54:12 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698952D4B;
        Sun, 11 Jun 2023 00:54:11 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-97458c97333so548259866b.2;
        Sun, 11 Jun 2023 00:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686470050; x=1689062050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2bYmU9gOFw7prawoSArqsjj7q30vNelMkCTOp3DUZA=;
        b=ZIEOX3tJHJOzGLZrKAdQ+Em+CgSdACZ6I8FnuJaC4jYMStxwz09k1IUU5ZVNT1dW2v
         ogPNUK7ZS+3BABiwD25+IzvvjnBLi493MzDiM/IR6p3MMAwZt7gXj55mTTsPuV1GhUnB
         iq6nxosD3itFoqyejgow+y2d+JcxEim7S9fh42peyFKgPu1KbhgXG/+edgWI+9mRGdCA
         yCU+aQjqgUZYEEPCg7Xt6cnvbidmIInJNEc58JumOG7Xe0aO208JhTCnXrR+QlWi1wMM
         tRieArJ9twGrAHIA7Zobx4X3k4JDjR7avO4YwD1ezT3hNQ7OM9N1Ahi5W08doshMsRBk
         2skQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686470050; x=1689062050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2bYmU9gOFw7prawoSArqsjj7q30vNelMkCTOp3DUZA=;
        b=I+ttrntzS2C14wJErvLh6A0742Xvi0NCeQS3UqRRtZ+cqSe9qNKU41gM9bTXbtskiG
         O6uyZd2LFqdSdamROVyawlpe3OZX6dCHI0pej4OZe7qnzMPP9DNvSYqF9lP51CPyeKPs
         LZ6Uno9HEc/xufPG5XhQZ1vF9vxlphlnmTDr2ARMFjiAguSm2NQI4XSXk2cG9i6TlvW+
         MMiy90BUBlzZ9//mwFe0nk6iDlGItr+KsJ/cvVJePgkCHc6GEQEPU9kS3PBCTD1yxH6S
         Bunn81P+I1JvL73kYlIGUiLI0oiQJCRcII67dwlWpqBInR2VT/f/ESBPD31hhvJoXvui
         IdVg==
X-Gm-Message-State: AC+VfDzOoW+HNJi0lhatKq4CUfXsvaNrYJAKj+f3cmmv+fbD0ook5giV
        O1gXC0MgGKbkpma5bqKMadWlJgBKx9cOWmpvnm8MNqL2tjJmRaKT
X-Google-Smtp-Source: ACHHUZ5ja8bZ3Ma/lzFyJGdan7jkXrsKOmmJXjhxvrXILS4V+ZNLzwM/6ID9I2oXbI3TE6BVuXmHvV/daKEMgKQnrEw=
X-Received: by 2002:a17:907:7f09:b0:973:a30d:b264 with SMTP id
 qf9-20020a1709077f0900b00973a30db264mr6940129ejc.46.1686470049410; Sun, 11
 Jun 2023 00:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230610141739.999268-1-bigunclemax@gmail.com>
 <20230610141739.999268-4-bigunclemax@gmail.com> <20230610-rehire-amid-2517f43504c0@spud>
 <CALHCpMiEmc8L=O86_x7-KkBHFwf2QpuP0M7ugz7dNPr71cpJmQ@mail.gmail.com>
 <20230610-enlarged-agonize-0e9219f9921d@spud> <20230610-crumpet-spender-4133090a4728@spud>
 <CALHCpMjFNvJAnd2_3-1n_L3QRz4eNc-Egm-BD6jcS6H694dSyg@mail.gmail.com> <20230610-whimsical-unrushed-2f5b30349588@spud>
In-Reply-To: <20230610-whimsical-unrushed-2f5b30349588@spud>
From:   Maxim Kiselev <bigunclemax@gmail.com>
Date:   Sun, 11 Jun 2023 10:53:56 +0300
Message-ID: <CALHCpMhQ8XxffHr_f=AtO-HoWadBQb1mSvojELctdwMKnF1tbw@mail.gmail.com>
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

=D0=B2=D1=81, 11 =D0=B8=D1=8E=D0=BD. 2023=E2=80=AF=D0=B3. =D0=B2 01:14, Con=
or Dooley <conor@kernel.org>:
>
> On Sat, Jun 10, 2023 at 11:31:03PM +0300, Maxim Kiselev wrote:
> > =D1=81=D0=B1, 10 =D0=B8=D1=8E=D0=BD. 2023=E2=80=AF=D0=B3. =D0=B2 21:01,=
 Conor Dooley <conor@kernel.org>:
> >
> > ...
> >
> > > > > > +  - |
> > > > > > +    thermal-sensor@2009400 {
> > > > > > +          compatible =3D "allwinner,sun20i-d1-ths";
> > > > > > +          reg =3D <0x02009400 0x400>;
> > > > > > +          interrupts =3D <0 90 0>;
> > > > > > +          clocks =3D <&ccu 0>;
> > > > > > +          clock-names =3D "bus";
> > > > > > +          resets =3D <&ccu 2>;
> > > > > > +          nvmem-cells =3D <&ths_calibration>;
> > > > > > +          nvmem-cell-names =3D "calibration";
> > > > > > +          #thermal-sensor-cells =3D <0>;
> > > > > >
> > > > > >> Is this calibration required, or optional, for the d1?
> > > > >
> > > > > Calibration data for the D1 is optional as for the H6.
> > > > > (But without it, the sensor data will be inaccurate).
> > > >
> > > > Okay. Modulo the signoff:
> > > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > >
> > > Wait, that's not what I meant to say... Clearly turned my brain off f=
or
> > > a moment. If it is not going to function correctly without the
> > > calibration data, why not make the calibration data required for the
> > > d1's ths?
> >
> > I don't really know why, but the calibration data is optional for
> > other controllers.
> > So I just did it the same way.
> > Here is explanation comment about it from the driver:
> >         /*
> >          * Even if the external calibration data stored in sid is
> >          * not accessible, the THS hardware can still work, although
> >          * the data won't be so accurate.
> >          *
> >          * The default value of calibration register is 0x800 for
> >          * every sensor, and the calibration value is usually 0x7xx
> >          * or 0x8xx, so they won't be away from the default value
> >          * for a lot.
> >          *
> >          * So here we do not return error if the calibration data is
> >          * not available, except the probe needs deferring.
> >          */
>
> Wait, so if there is no calibration data then this thing will just defer
> probing, ad infinitum? Looks like everything other than the a33 has the
> cells in the dts, and the software seems to expect the cells.
> What am I missing?

Not quite. If we don't have a calibration cell in the dts, then we
just skip the calibration.
We will only get EPROBE_DEFER if we have calibration in the dts.
Here is the whole function code:

static int sun8i_ths_calibrate(struct ths_device *tmdev)
{
    struct nvmem_cell *calcell;
    struct device *dev =3D tmdev->dev;
    u16 *caldata;
    size_t callen;
    int ret =3D 0;

    calcell =3D devm_nvmem_cell_get(dev, "calibration");
    if (IS_ERR(calcell)) {
        if (PTR_ERR(calcell) =3D=3D -EPROBE_DEFER)
            return -EPROBE_DEFER;
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
        goto out;
    }

    caldata =3D nvmem_cell_read(calcell, &callen);
    if (IS_ERR(caldata)) {
        ret =3D PTR_ERR(caldata);
        goto out;
    }

    tmdev->chip->calibrate(tmdev, caldata, callen);

    kfree(caldata);
out:
    return ret;
}
