Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98F3692EFC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 08:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjBKHQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 02:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBKHQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 02:16:41 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4D13D0BF;
        Fri, 10 Feb 2023 23:16:38 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-15f97c478a8so9406843fac.13;
        Fri, 10 Feb 2023 23:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58HBYmuEbwT6P5YGu4V8yOdkWgdYqUn/I6lFr6XEbsY=;
        b=SQroH5KE1FCEFJ51Oh3r6W/UAf6YnZ8whUjag4IHbgEMlpVBW7rFfNDsmr4CZWTAJN
         ACTOf883lDJOd4fJk6kYepPUv8/PHEZRb1LJDirXHwHfqsphDCxE/AriVMav/h462s/a
         aURwTTXkeIFXjN9w3TbdV0Ulp9UR2jEeePwiELWDyobH7il4TGjTKK3jHIspoxzr0F/8
         ht6G6TE/ianzGua5l+SAiis+eIRsuHwbcah2h0pjbB1qo3hJIcSRmu2ihcaSNT6khinW
         WCDHdRz6xY49nLAJbMA6JAc+Oz0yrotFGAn3eIy2l2Mz5SkJAwRftSZl6dTBGFlPIm8v
         yA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58HBYmuEbwT6P5YGu4V8yOdkWgdYqUn/I6lFr6XEbsY=;
        b=bzLb65gnFvus4uQZwnpbEgFklJX2T2ey5h7Zp3tva8i/mztbA05N+l6bWrPvAt8CfW
         xTyqFTQ1Sa1VDffMHtU6hBc3eGOULo/sl/HqWU8FqBf65J/W2KfkrZiz4BZgeok0wbFk
         Z5XaU1X0r+cgTDyDnqK+vO4Otkfda0dk0eBwzBepDSIzPsN6VTsApJw+WH6u5LlQdwYe
         qULPWS8V5UC87rXKKac1Gel8nq1axvSU0DHmXUblca6DLXBrwMkffcnBL+CdkuBTsfQe
         yGVV8y0nK6ePZlSJLM+8M9xkS5u6PD1ZjkN6bfF/JQOEGvEz13fS82Q5ofZUByI/UtFl
         6xuw==
X-Gm-Message-State: AO0yUKX0v1SaaBjtFqHxmSAL9WjcwBPW3xop1VnlzGcdIW5YswDY0oXj
        7LjTC/PhUbKWCNpLsIja4GEt5Wil161fbZEagyA=
X-Google-Smtp-Source: AK7set+lXDlU78iVkFXkGoy8FMRUpawSgAhVaxC/em3HXsapY0SZ2hBQvwYxndhqDquz9J65CjwThXkXXw7rkgiWxTw=
X-Received: by 2002:a05:6870:9615:b0:169:fabf:b222 with SMTP id
 d21-20020a056870961500b00169fabfb222mr2460667oaq.83.1676099797383; Fri, 10
 Feb 2023 23:16:37 -0800 (PST)
MIME-Version: 1.0
References: <20230210173841.705783-1-sergio.paracuellos@gmail.com>
 <20230210173841.705783-3-sergio.paracuellos@gmail.com> <3ca26ba2-80f5-32a2-0357-d91c87efd1c0@arinc9.com>
In-Reply-To: <3ca26ba2-80f5-32a2-0357-d91c87efd1c0@arinc9.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sat, 11 Feb 2023 08:16:26 +0100
Message-ID: <CAMhs-H9eQo-F9G62yyMbRyjmnaTYsJjnYA0puuFb71jCcnq7LA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] mips: dts: ralink: mt7621: add phandle to system
 controller node for watchdog
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        tsbogend@alpha.franken.de, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org
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

Hi Ar=C4=B1n=C3=A7,

On Fri, Feb 10, 2023 at 6:47 PM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc=
9.com> wrote:
>
> Could you also change the node name to watchdog@100? make dtbs_check
> points it out:
>
> wdt@100: $nodename:0: 'wdt@100' does not match '^watchdog(@.*|-[0-9a-f])?=
$'

Sure, let me add a small patch fixing this warning in the series.

>
> Thanks.
> Ar=C4=B1n=C3=A7

Best regards,
    Sergio Paracuellos

>
> On 10.02.2023 20:38, Sergio Paracuellos wrote:
> > To allow to access system controller registers from watchdog driver cod=
e
> > add a phandle in the watchdog 'wdt' node. This avoid using arch depende=
nt
> > operations in driver code.
> >
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> >   arch/mips/boot/dts/ralink/mt7621.dtsi | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts=
/ralink/mt7621.dtsi
> > index 5ca40fd21..764916eaf 100644
> > --- a/arch/mips/boot/dts/ralink/mt7621.dtsi
> > +++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
> > @@ -73,6 +73,7 @@ sysc: syscon@0 {
> >               wdt: wdt@100 {
> >                       compatible =3D "mediatek,mt7621-wdt";
> >                       reg =3D <0x100 0x100>;
> > +                     mediatek,sysctl =3D <&sysc>;
> >               };
> >
> >               gpio: gpio@600 {
