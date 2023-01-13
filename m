Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9CC66A2D3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjAMTZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjAMTY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:24:59 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1AA78158
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:24:58 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so18083730wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YR1JrLHd/rtFxm82ghcbpSNqJ9U6VT8clOL0KHLsa5M=;
        b=NoJzijQzwjgyIljHSYkYbk0seUpgWMQhS4NuAHMJ5TaSjbWObkY/jJmVcvvHUblMDF
         V51gDA14ckSsmKvpE4uyVCs3WkUhoiSjDpboE4NJKKLxx7ICT9Bd2Df0RZH+/IRpDBbU
         2UzBBHHY0wfQP08XyjerbkjyTFVlyXBa1BZYoEgWijek+piMp9ZDbJ3tXmlcGY+CG8NY
         TD0bzwQb/rskgWdcqKgEr4fScCzmCn6hDzwP/HovSGIvRRDQdw3VaRXnIqGpvJVNv2do
         favMDEmaZ3vAkGtSP4IRhGyOgD1hDEeI/05SsxfSwfUfdEePM5vg6d4OhtOxk+Pk/Uwv
         iNvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YR1JrLHd/rtFxm82ghcbpSNqJ9U6VT8clOL0KHLsa5M=;
        b=wbQRWBYO+xZyABgcBroW8pAxbRfmbi1AZCHt/y9U56YOh3nqLhQOikpff2+z5BHHpW
         /BpTWfMlBg29BuFgCas3pZyxu7Sv9xdoh7mj9uty86krspxoDoarqNkH9pT5VdleWUAG
         eL1pV/Lg2hKzhn2kjJLfI/PtCR9b1HO38/EnOJf+Okz2ZkF9v1XgWJWYLAcEO3hsnP/e
         YQkEdmiCVMNb3dOj2xYzVLY06QABrI06n5zDCIMf/dgFb913hmQ4wNgrw4dW6XLnDpz2
         Nt7PpRa8gpgiy3HnIkthDryF1UzK0vpw+38rLA2GH3c6Y4LgL9xi6WlI1AnpVUnuhuU5
         VKOA==
X-Gm-Message-State: AFqh2krmvOR+oGeb6+xkSKT80y0KLRfJN6OKnBLrzVWQypNtEEpXqpcE
        RWdXdoxKvkTXE5WEUfYA6sbw3Q==
X-Google-Smtp-Source: AMrXdXttwPsSq22LO3ha4/idlRRYyMS4mio7zLG55jfNREzxXrXYaXM7m5R+mxZHiRmL1afl9UouFQ==
X-Received: by 2002:a05:600c:4153:b0:3da:f0e:fe34 with SMTP id h19-20020a05600c415300b003da0f0efe34mr7914572wmm.32.1673637897138;
        Fri, 13 Jan 2023 11:24:57 -0800 (PST)
Received: from smtpclient.apple (global-5-143.n-2.net.cam.ac.uk. [131.111.5.143])
        by smtp.gmail.com with ESMTPSA id v8-20020a05600c444800b003c21ba7d7d6sm28362121wmn.44.2023.01.13.11.24.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jan 2023 11:24:56 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 0/2] Change PWM-controlled LED pin active mode and
 algorithm
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <Y8GjySjm9OjoZvCF@spud>
Date:   Fri, 13 Jan 2023 19:24:56 +0000
Cc:     Nylon Chen <nylon.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        nylon7717@gmail.com, zong.li@sifive.com, greentime.hu@sifive.com,
        vincent.chen@sifive.com, Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-pwm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <95F1EAA0-D8D6-4F8A-8049-5E7BFDE4C06C@jrtc27.com>
References: <20230113083115.2590-1-nylon.chen@sifive.com>
 <Y8GjySjm9OjoZvCF@spud>
To:     Conor Dooley <conor@kernel.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Jan 2023, at 18:32, Conor Dooley <conor@kernel.org> wrote:
>=20
> +CC Uwe, Thierry, linux-pwm
>=20
> Hey Nylon,
>=20
> Please run scripts/get_maintainer.pl before sending patches, you =
missed
> both me & the PWM maintainers unfortunately!
> AFAIK, the PWM maintainers use patchwork, so you will probably have to
> resend this patchset so that it is on their radar.
> I've marked the series as "Changes Requested" on the RISC-V one.
>=20
> On Fri, Jan 13, 2023 at 04:31:13PM +0800, Nylon Chen wrote:
>=20
>> According to the circuit diagram of User LEDs - RGB described in the
>> manual hifive-unmatched-schematics-v3.pdf[0].
>> The behavior of PWM is acitve-high.
>>=20
>> According to the descriptionof PWM for pwmcmp in SiFive FU740-C000
>> Manual[1].
>> The pwm algorithm is (PW) pulse active time  =3D (D) duty * (T) =
period[2].
>> The `frac` variable is pulse "inactive" time so we need to invert it.
>>=20
>> So this patchset removes active-low in DTS and adds reverse logic to
>> the driver.
>>=20
>> =
[0]:https://sifive-china.oss-cn-zhangjiakou.aliyuncs.com/HiFIve%20Unmatche=
d/hifive-unmatched-schematics-v3.pdf
>> =
[1]:https://sifive-china.oss-cn-zhangjiakou.aliyuncs.com/HiFIve%20Unmatche=
d/fu740-c000-manual-v1p2.pdf
>> [2]:https://en.wikipedia.org/wiki/Duty_cycle
>=20
> Please delete link 2, convert the other two to standard Link: tags and
> put this information in the dts patch. Possibly into the PWM patch =
too,
> depending on what the PWM maintainers think.
> This info should be in the commit history IMO and the commit message =
for
> the dts patch says what's obvious from the diff without any =
explanation
> as to why.
>=20
> I did a bit of looking around on lore, to see if I could figure out
> why it was done like this in the first place, and I found:
> =
https://lore.kernel.org/linux-pwm/CAJ2_jOG2M03aLBgUOgGjWH9CUxq2aTG97eSX70=3D=
UaSbGCMMF_g@mail.gmail.com/

That DTS documentation makes no sense to me, why does what the LED is
wired to matter? Whether you have your transistor next to ground or
next to Vdd doesn=E2=80=99t matter, what matters is whether the =
transistor is
on or off. Maybe what they mean is whether the *PWM's output* / *the
transistor's input* is pulled to ground or Vdd? In which case the
property would indeed not apply here.

Unless that=E2=80=99s written assuming the LED is wired directly to the =
PWM, in
which case it would make sense, but that=E2=80=99s a very narrow-minded =
view of
what the PWM output is (directly) driving.

Jess

> That doesn't explain the driver, but it does explain the dts being =
that
> way. Perhaps a Fixes tag is also in order? But only if both patches =
get
> one, otherwise backporting would lead to breakage.
>=20
> The min() construct appears to have been there since the RFC driver =
was
> first posted.
>=20
> Thanks,
> Conor.
>=20
>>=20
>> Nylon Chen (2):
>>  riscv: dts: sifive unmatched: Remove PWM controlled LED's active-low
>=20
> nit: s/sifive unmatched:/sifive: unmatched:/
>=20
>>    properties
>>  pwm: sifive: change the PWM controlled LED algorithm
>>=20
>> arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 4 ----
>> drivers/pwm/pwm-sifive.c                            | 1 +
>> 2 files changed, 1 insertion(+), 4 deletions(-)
>>=20
>> --=20
>> 2.36.1
>>=20
>>=20
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

