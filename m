Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467456B3712
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 08:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjCJHFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 02:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjCJHFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 02:05:48 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29488FAD4F;
        Thu,  9 Mar 2023 23:05:45 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id bj30so3547116oib.6;
        Thu, 09 Mar 2023 23:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678431944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Apt9Dk2CoziEfGeeXSNDKcm/bw3e59igOKBoc9kqRQ=;
        b=cODHW23nSAnCvbakw46m/53/O/w9otESK75OxxEupLEIYQIdR5uoOiqe+IUMmsIrfa
         sLA8+U1GZJFly3Kc+O8qM5/LBChLX50Z3lCRKw0rgG0A4ZAOAtgo6+isHaMY4gw3yT2G
         dDqTa2VDHWzd8jb1rs0+Lh85Il5qBhBx4RrX1dkfIDyR8HDzCuK0a3qkVknpWSAwauHN
         +i/kRmInCOlH6JsXxKSn1ODbPiLwZmeaDpDTsvQOXWh0UMDhFvjHw3AjszKczXdEFXCB
         rPaGakwJyuvhSQ7lfiHdBmdDZzALeQSFF9SQEyZIPeDGODuUhiXCh8Djelf2BVmzqwZY
         eiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678431944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Apt9Dk2CoziEfGeeXSNDKcm/bw3e59igOKBoc9kqRQ=;
        b=OmSsLZLKsK3gowmKk6ztZ2nAZ+3Za3FadiI+HSveeNhrdHMv9tazmzk2VdWnY7Jgn/
         n45o6QlydmaL2dCmRUaXfCtkjJvSX4byDOzoXL5T+dCDPXr1WY1N+SAAxUsr7Lbikgtp
         eyV/6rrFJJ8lpThriGxyGCe3bPQ2Quse7Zl8lbmN2384Lr4reikoF2AGFigFVf4oxiA+
         XAkkRIjDC2vGBvyPepcCVkfjviTTGiLtCybFl6oTcma8uACd/LfqVejHpQP5fO08y3Dy
         Qj+8p5MxnAeck3r0ai0Fgf4U9Ck+nYIQTV5fNtPyXuUpvjNPl0zwu5nD8Cy4cZPkqBAu
         JpqA==
X-Gm-Message-State: AO0yUKV/LRg1073xAmjSdXq+flY9t5SU1oTX8a4W9HbEn20PELwQ8qt0
        o8v6uRtbuQ7/DkGOf3ZLqhBT8W4i0UFqI/gVoUA=
X-Google-Smtp-Source: AK7set+Dm/R3lBw0fzhFuTzV5Lb+E9hla4HLfDXtL8iri21EzQdxnwTyxFKAsn39JI7FHQUQeGMGpEFMqrEAbnm3Bcg=
X-Received: by 2002:a05:6808:aa1:b0:384:2022:f9b1 with SMTP id
 r1-20020a0568080aa100b003842022f9b1mr8254384oij.2.1678431944516; Thu, 09 Mar
 2023 23:05:44 -0800 (PST)
MIME-Version: 1.0
References: <20230303002850.51858-1-arinc.unal@arinc9.com> <20230303002850.51858-10-arinc.unal@arinc9.com>
 <20230308210514.GA3767521-robh@kernel.org> <12be053e-b70a-faca-71c8-d8eef69a3b73@arinc9.com>
 <ccdfd262-eaf3-dbbe-7a3c-a911a5ec0fc4@arinc9.com> <9663817e-7f6f-c3b1-8bf9-321f9b067e96@linaro.org>
 <deca532a-bdf5-c49e-1422-ce6124b61882@arinc9.com> <CAMhs-H8M3ir+DshHF60W=QMn9WG3Jgbo8GgXZnDKCLhs=+WBoQ@mail.gmail.com>
 <81cf9e50-d626-cbb3-ebb1-56d080eca66d@arinc9.com>
In-Reply-To: <81cf9e50-d626-cbb3-ebb1-56d080eca66d@arinc9.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 10 Mar 2023 08:05:31 +0100
Message-ID: <CAMhs-H_YkdacZXE2xqn=_JQtitLvqRFB20s7rjS63dFabAL4qw@mail.gmail.com>
Subject: Re: [PATCH 09/20] dt-bindings: pinctrl: ralink: {mt7620,mt7621}:
 rename to mediatek
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 9, 2023 at 10:09 PM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc=
9.com> wrote:
>
> On 9.03.2023 14:33, Sergio Paracuellos wrote:
> > On Thu, Mar 9, 2023 at 11:34 AM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@a=
rinc9.com> wrote:
> >>
> >> On 9.03.2023 12:52, Krzysztof Kozlowski wrote:
> >>> On 09/03/2023 08:53, Ar=C4=B1n=C3=A7 =C3=9CNAL wrote:
> >>>> On 9.03.2023 00:19, Ar=C4=B1n=C3=A7 =C3=9CNAL wrote:
> >>>>> On 9.03.2023 00:05, Rob Herring wrote:
> >>>>>> On Fri, Mar 03, 2023 at 03:28:38AM +0300, arinc9.unal@gmail.com wr=
ote:
> >>>>>>> From: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> >>>>>>>
> >>>>>>> This platform from Ralink was acquired by MediaTek in 2011. Then,
> >>>>>>> MediaTek
> >>>>>>> introduced these SoCs which utilise this platform. Rename the sch=
emas to
> >>>>>>> mediatek to address the incorrect naming.
> >>>>>>
> >>>>>> I said we don't do renames due to acquistions, you said that wasn'=
t the
> >>>>>> reason, but then that's your reasoning here.
> >>>>>
> >>>>> It's not a marketing/acquistion rename as the name of these SoCs we=
re
> >>>>> wrong from the get go. The information on the first sentence is to =
give
> >>>>> the idea of why these SoCs were wrongfully named as the base platfo=
rm
> >>>>> that these new MediaTek SoCs share code with was called Ralink.
> >>>>>
> >>>>>>
> >>>>>> To give you another example, *new* i.MX things are still called
> >>>>>> 'fsl,imx...' and it has been how many years since merging with NXP=
?
> >>>>>
> >>>>> Ok this is a point I see now. Though, I fail to see how this is cal=
led
> >>>>> renaming when there's only new SoCs (from NXP in this case) to be a=
dded.
> >>>>
> >>>> If I understand correctly, i.MX is a family from Freescale so the na=
me
> >>>
> >>> It's the same "family" as your platform, because as you said:
> >>> "introduced these SoCs which utilise this platform"
> >>>
> >>>> was kept the same on new SoC releases from NXP. I believe it's diffe=
rent
> >>>> in this case here. There's no family name. The closest thing on the =
name
> >>>> of the SoC model is, it's RT for Ralink, MT for MediaTek.
> >>>
> >>> It's not about the name. NXP took Freescale platform and since many
> >>> years makes entirely new products, currently far, far away from origi=
nal
> >>> platform.
> >>>
> >>> That's the same case you have here - Mediatek took existing platform =
and
> >>> started making new products with it.
> >>>
> >>>>
> >>>> On top of that, mediatek strings already exist for MT SoCs already, =
at
> >>>> least for MT7621.
> >>>>
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/=
tree/Documentation/devicetree/bindings/mips/ralink.yaml?id=3Ddd3cb467ebb565=
9d6552999d6f16a616653f9933#n83
> >>>
> >>> NXP also has compatibles with nxp, thus still not that good reason.
> >>
> >> Ok, makes sense. Am I free to call the SoCs MediaTek, change the schem=
a
> >> name from ralink,mtXXXX-pinctrl.yaml to mediatek,mtXXXX-pinctrl.yaml
> >> whilst keeping the compatible string ralink?
> >>
> >> I plan to do some cleanup on ralink.yaml as well. From what I
> >> understand, I should change the mediatek,mt7621-soc compatible string =
to
> >> ralink,mt7621-soc?
> >
> > You have to take care of these SoC strings since they are used in the
> > very beginning of the ralink startup platforms for any single ralink
> > SoC. See for example [0] and [1] (but they are in all soc init code).
> > I think it is better to maintain the ralink.yaml file as it is.
>
> I'd really rather address this inconsistency everywhere possible. The
> code you pointed out looks different than what I did on the pinctrl
> driver but, surely it's possible on the code to introduce ralink and
> keep the mediatek string for the sake of old DTs, no?

In any case, the changes you might have in mind for this should be a
different patch series.

Best regards,
     Sergio Paracuellos
>
> Ar=C4=B1n=C3=A7
