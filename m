Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB326967B7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 16:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbjBNPNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 10:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBNPNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 10:13:05 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2431018147;
        Tue, 14 Feb 2023 07:13:05 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1442977d77dso19381010fac.6;
        Tue, 14 Feb 2023 07:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQOQuIF4OrW9D2zr50BWcnhTroIr9Ceg7lObbpZeMhk=;
        b=nGKPVX/3PIKqUdMy0UtHsv0IvveUo9mKvNhzILdDImr99pX0GueMuw3agyDoRtAbxv
         iO0AXKqg7M929DIo3x9ormySTA47gM36yZmlPmfvHnyfjR01Vfpa6EgFNatP4C6FG8sn
         tOK6rQf86Wp6+Oner0iiyRn1pB6Fp5Lu2hFqejhvINDRadpHCuDKF4JyTCZ6ZhLaeXQa
         qmLKrnHX4Tv2xOdZLQTE/JBIcpZVHiE23dRo8hl1crn9t0K0041qtyK78bNCv8QahcXh
         A/e843qsdLmpQCqmuwd9nWxHleV4CjrRlO/w2aQ+avgKbLs8oZydqJWKmWpQ/V0YHFTi
         PRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQOQuIF4OrW9D2zr50BWcnhTroIr9Ceg7lObbpZeMhk=;
        b=WaYVQci9fT64UFi1+aHjMPjqgIwjfmvL4cBQoI0YyN/9vjdz4BB2lIB2G0WBFHVGdX
         34kyFA12AWVmGmQrOLPt50Avc6q+cohb4Aa2CBYNXC7GXm5sNeAz/oovwfAll25TFrUd
         xUtuphJvDRhJi5W+XP0J373DsjIdfKEcwvhbg6eTgGqemdB9Bo5J9xk6uctoxYrtm5HS
         hBmqVr/n5cLDWSXulOLmkRSTKs1L+8KG3mGJF4TeBPZq7ZnvpuI3LyYbyx8NWbUDuk0Q
         HptEDkE53PyC9tryH2vkPMTrWOugJvq+k3eevFYZLamkj9MxUzXxgE9j2AyOHV4GOsws
         X3GA==
X-Gm-Message-State: AO0yUKVwNrEVOkIysjnYbi8KytQN0T+1dl76kSTfFRkpXl+L4FbdtUVc
        gsdnZQHFqzYc0qZG5htkGNRfJ6lolPuLHAthb2w=
X-Google-Smtp-Source: AK7set/IB4IyAoSaBvVlK9Dzn0peBaqsU6p/h5b5dqivZuU5Ch3pvzoxiAdMqIaq2aZJ3HU/gmdBkyy/t8tjpH9RXmg=
X-Received: by 2002:a05:6870:9615:b0:169:fabf:b222 with SMTP id
 d21-20020a056870961500b00169fabfb222mr3942918oaq.83.1676387584439; Tue, 14
 Feb 2023 07:13:04 -0800 (PST)
MIME-Version: 1.0
References: <20230214103936.1061078-1-sergio.paracuellos@gmail.com>
 <20230214103936.1061078-3-sergio.paracuellos@gmail.com> <20230214151101.GB742354@roeck-us.net>
In-Reply-To: <20230214151101.GB742354@roeck-us.net>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 14 Feb 2023 16:12:52 +0100
Message-ID: <CAMhs-H915iSR7TpuXdcg8NKLV8Scv9cwW36SZaXNK839kA4ybg@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] mips: dts: ralink: mt7621: rename watchdog node
 from 'wdt' into 'watchdog'
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, arinc.unal@arinc9.com,
        tsbogend@alpha.franken.de, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org,
        =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 4:11 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Tue, Feb 14, 2023 at 11:39:33AM +0100, Sergio Paracuellos wrote:
> > Watchdog nodes must use 'watchdog' for node name. When a 'make dtbs_che=
ck'
> > is performed the following warning appears:
> >
> > wdt@100: $nodename:0: 'wdt@100' does not match '^watchdog(@.*|-[0-9a-f]=
)?$'
> >
> > Fix this warning up properly renaming the node into 'watchdog'.
> >
> > Reviewed-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
>
> Note that we can not apply this and the next patch of the series
> through the watchdog tree since it crosses a maintainer boundary.

I was expecting Thomas to get these two arch/mips patches or get an
Acked-by from him in order for you to apply them.

Thanks,
    Sergio Paracuellos

>
> Guenter
>
> > ---
> >  arch/mips/boot/dts/ralink/mt7621.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts=
/ralink/mt7621.dtsi
> > index 5ca40fd21662..ac818fd721ae 100644
> > --- a/arch/mips/boot/dts/ralink/mt7621.dtsi
> > +++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
> > @@ -70,7 +70,7 @@ sysc: syscon@0 {
> >                                            "250m", "270m";
> >               };
> >
> > -             wdt: wdt@100 {
> > +             wdt: watchdog@100 {
> >                       compatible =3D "mediatek,mt7621-wdt";
> >                       reg =3D <0x100 0x100>;
> >               };
> > --
> > 2.25.1
> >
