Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAC6604334
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiJSLa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbiJSLaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:30:04 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13ED33471D;
        Wed, 19 Oct 2022 04:04:33 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r14so24679105edc.7;
        Wed, 19 Oct 2022 04:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eMipZbj71SJyfQMN6L0nZo9wGi1DpZIoWLYb2uUqmQ=;
        b=mvbStkFmdY13OoP6CfpTga5QNfbJ1VpTopjbNIiSHfJ0xenylbFj2bTPQt91W/ELDZ
         C2Xr6DqnYXK2MjCBw8S7GYjiGmPqpBukyGoZopxdr7vI7qyMB8Gvw1VzcP81Nm890zGk
         73cxNQSkI+dO4VhKBGcgsX3UwADNYL9aHp8mow6M0twnuXVNRIRPMzZHJgfHnlab7992
         vFL18p/Zeqswk/Wk6GzisbCKlxr9QAY8w2wYdOI36jt9HEqKU7CpV2rdbHSVrxxIvyMU
         sxa2GGERvu9vz6F/8WStEteb18ImQC5ZC6nCu6PPEC8zLygWoW+QwOF2JdZoVikTidf1
         l34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+eMipZbj71SJyfQMN6L0nZo9wGi1DpZIoWLYb2uUqmQ=;
        b=vIHCIlNRVsJAFBztHXRTtDP5m+tLc4Z9rhPEw1bcKbTuAko5E/xbl2AddYao10/zDb
         9WG8Ox8R+GDWzQ0gCKw0tBqCIolFzuLfKmCIdyi3kIOkV53BzFppTYjUc0Iy+cF4kBK5
         HuYQWMFzttXTCeyE+CSb8YfhLWELs1nX2yHPuWcE0FQS7feQBMBNs0hf1Bc9m8xhM0DE
         caMqePrqakpzBetdgpDqRB2u4uqiGFSmMZFYA0AuRML9QsMgtEiMtjryDnoUtnBPTx1Q
         6IyG8y7uAdIkIzMbA296CVNIZDfVs3iIV9BCDkA7aDMLc3VC0fyXWJ1TL6RABzORknuQ
         XJDg==
X-Gm-Message-State: ACrzQf1GebWiXxdOczhwaB37OEvotW21JOUMUoit9XcAGWERwrTSK02x
        P4ocFocK4jCbntXVLMtKlR1ZVWYPHXKXTpnMHSw=
X-Google-Smtp-Source: AMsMyM6HMAzAjbn7itQW+UWK4dinjv82ntmdwV5hnfObluMJyEWkMPPNR4rBCnf4nIeyVMHU5xLKrjmJ20KA9OvkQvg=
X-Received: by 2002:a50:fb0f:0:b0:458:df03:c3aa with SMTP id
 d15-20020a50fb0f000000b00458df03c3aamr6717480edq.83.1666177375029; Wed, 19
 Oct 2022 04:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20221014114601.15594-1-victor.shih@genesyslogic.com.tw> <CAPDyKFr4je2WhF8oQW1CpQD+2dRZhn+5JB0bLqHjLDTOiao58g@mail.gmail.com>
In-Reply-To: <CAPDyKFr4je2WhF8oQW1CpQD+2dRZhn+5JB0bLqHjLDTOiao58g@mail.gmail.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Wed, 19 Oct 2022 19:02:42 +0800
Message-ID: <CAK00qKD3XqnwSkc3rDQ67zMizPLo3Qt8in4S-GNXAvuNcMsY-g@mail.gmail.com>
Subject: Re: [PATCH V5 00/26] Add support UHS-II for GL9755
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Victor Shih <victor.shih@genesyslogic.com.tw>
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

Hi, Ulf

Ulf Hansson <ulf.hansson@linaro.org> =E6=96=BC 2022=E5=B9=B410=E6=9C=8817=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E6=99=9A=E4=B8=8A7:32=E5=AF=AB=E9=81=93=EF=BC=
=9A

>
> Hi Victor,
>
> On Fri, 14 Oct 2022 at 13:47, Victor Shih <victorshihgli@gmail.com> wrote=
:
> >
> > Summary
> > =3D=3D=3D=3D=3D=3D=3D
> > These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
> >
> > About UHS-II, roughly deal with the following three parts:
> > 1) A UHS-II detection and initialization:
> > - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup Se=
quence
> >   [2]).
> > - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence=
[2]).
> > - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include=
 Section
> >   3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II Setting R=
egister
> >   Setup Sequence.
> >
> > 2) Send Legacy SD command through SD-TRAN
> > - Encapsulated SD packets are defined in SD-TRAN in order to ensure Leg=
acy SD
> >   compatibility and preserve Legacy SD infrastructures (Section 7.1.1 P=
acket
> >   Types and Format Overview[3]).
> > - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-=
II
> >   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2])=
.
> >
> > 3) UHS-II Interrupt
> > - Except for UHS-II error interrupts, most interrupts share the origina=
l
> >   interrupt registers.
> >
> > Patch structure
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > patch#1-#6:  for core
> > patch#7-#25: for sdhci
> > patch#26:    for GL9755
> >
> > Changes in v5 (Oct. 14, 2022)
> > * rebased to linux-v6.0.
>
> You sent a v5 on Oct 14 and then this one (v5 again) today. Why? What
> is the difference?

I left out two files in the October 14th edition, so I added it back
in the October 17th edition, but I forgot to change the date of the
cover-letter.

>
> Moreover, as v6.1-rc1 is now available, my next branch will be based
> on that. Can you please rebase the series on top of my next branch -
> or at least use the latest available "rc", when you test and submit?

Ok, I will follow your advice.
I will rebase to the linux-v6.1-rc1 in your next branch.

>
> > * according to the guidance and overall architecture provided
> >   by Ulf Hansson, Ben Chuang and Jason Lai to implement the
> >   UHS-2 Core function based on the patches of the [V4,0/6]
> >   Preparations to support SD UHS-II cards[5].
> > * according to the guidance and comments provided by
> >   Adrian Hunter, Ben Chuang and AKASHI Takahiro to implement
> >   the UHS-2 Host function based on the patches of the
> >   [RFC,v3.1,00/27] Add support UHS-II for GL9755[4].
> > * implement the necessary function to let the UHS-2 Core/Host
> >   work properly.
> > * fix most of checkpatch warnings/errors
> >
> > Reference
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [1] https://gitlab.com/ben.chuang/linux-uhs2-gl9755.git
> > [2] SD Host Controller Simplified Specification 4.20
> > [3] UHS-II Simplified Addendum 1.02
> > [4] https://patchwork.kernel.org/project/linux-mmc/cover/20201106022726=
.19831-1-takahiro.akashi@linaro.org/
> > [5] https://patchwork.kernel.org/project/linux-mmc/cover/20220418115833=
.10738-1-jasonlai.genesyslogic@gmail.com/
>
> Another general question, I assume you intend to move this forward
> instead of Jason Lai, right?

Yes. Please let me know if I have any mistakes.

>
> Kind regards
> Uffe

Thanks, Victor Shih
