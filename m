Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9976FB582
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 18:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbjEHQuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 12:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbjEHQuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 12:50:12 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA2740D0
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 09:50:10 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4efe8991b8aso5517442e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 09:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1683564609; x=1686156609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcrvD/HGfP0sQ8rn7rEA3w+8hNghq9eS4p2dVN+XRPw=;
        b=YOe7TLYwTq2FS+pgqtD6IU9zBah2N7CgzKD2s77+3g0flsJL5ZT26ZJDFP1VHBRTe4
         2IO8Ftmnh1CMF0cxapLxrjnmlFauKy8nE4BxvJGryBUlE39XnO915uS7n+XtzU6YuHZH
         flN05rExGkzzgrVw964Il3tUAsR9bOBc9C56OSxbKNlXIRyHJ45RyQ7oiZ7qDnKhk9+Z
         xr7UsTGKzw29fbQyJJTSybV9tLNGnyWkYTjOld/lmRZeCbFY3efN1VrMD8ZfQ/tRT8a4
         XyYtd05TmYT2MhEzor+UGPYjaigZ8vYNEcCt+d/hx75xkDaJUb/kWgzjkLcp4YQcipXw
         VWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683564609; x=1686156609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tcrvD/HGfP0sQ8rn7rEA3w+8hNghq9eS4p2dVN+XRPw=;
        b=Z7vWrycV+sbu7nYTQzAtX+aP+dXFgFBaOZboNDYze95aAQTWGRA6Wc4erBJiGECmZH
         RsCrnFgzU9A5Ap4aHnDHmGTcikvE+M0SW1dWtwnNnb306uHAxgfjpSJ+dTs6VMEdk0W0
         1jG9USUS3SWrT+BD6IPN8yk+J3nXtTdZ/FcVJhHGHI77MmZc/T5VOjXtnK3CegEk/X+e
         hlqj8LYfBNGScjGLIaiHw4VRIIWKb1CDyfocvcrdeqNg5QS3AojpW+3h6gClnS8BGsbu
         yw35n+3pVZYC5Exi1LZrzEIAFcCxxgX/eCRQsXz/ZFu1GC4M5DZxDAvOKl0gwO4abc+x
         EBHg==
X-Gm-Message-State: AC+VfDzzpMQte5KJZzOCJ97WOmEel3mkNx2raSfoBBcuOpdX6bbrEqBS
        NQgvi6UhYmtNIBlO8Yntvt9V+DI4Z3RyPTBPS7uFZQ==
X-Google-Smtp-Source: ACHHUZ4+gjA9MQpcwzYPPM5k47cAY6H6hQhv8AiOghh9B/HC+0qEmiIPg0YCZV1xuf2Ou2iOsJjKnEGGtcVPWiJTNEw=
X-Received: by 2002:a19:f709:0:b0:4ef:9633:f119 with SMTP id
 z9-20020a19f709000000b004ef9633f119mr2918416lfe.26.1683564608901; Mon, 08 May
 2023 09:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-4b9e3d86-2f0b-47da-8a5d-bd383a0171d6@palmer-ri-x1c9> <4830085.8hb0ThOEGa@diego>
In-Reply-To: <4830085.8hb0ThOEGa@diego>
From:   Evan Green <evan@rivosinc.com>
Date:   Mon, 8 May 2023 09:49:32 -0700
Message-ID: <CALs-HsveK-uUuSAOkUUPuUYK6_ChG95_YWtdwYvGsTfKYSWUpg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Expose the isa-string via the AT_BASE_PLATFORM aux vector
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     philipp.tomsich@vrull.eu, Palmer Dabbelt <palmer@dabbelt.com>,
        bjorn@kernel.org, jrtc27@jrtc27.com,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        kito.cheng@sifive.com, Conor Dooley <conor.dooley@microchip.com>,
        matthias.bgg@gmail.com, heinrich.schuchardt@canonical.com,
        greentime.hu@sifive.com, nick.knight@sifive.com,
        christoph.muellner@vrull.eu,
        Richard Henderson <richard.henderson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 3, 2023 at 3:31=E2=80=AFAM Heiko St=C3=BCbner <heiko@sntech.de>=
 wrote:
>
> Hi,
>
> Am Dienstag, 2. Mai 2023, 19:15:29 CEST schrieb Palmer Dabbelt:
> > On Tue, 02 May 2023 02:13:10 PDT (-0700), philipp.tomsich@vrull.eu wrot=
e:
> > > On Tue, 2 May 2023 at 09:58, Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>=
 wrote:
> > >>
> > >> Philipp Tomsich <philipp.tomsich@vrull.eu> writes:
> > >>
> > >> > It is a pity that the current interface was designed without invol=
ving
> > >> > RVI (and that I had to ask my team to put together a patch set for
> > >> > further discussion, given that none of the other major vendors in =
RVI
> > >> > stepped forward).  I guarantee that plenty of reviewers would have
> > >> > highlighted that a central registry (even if it is just a kernel
> > >> > header) should be avoided.
> > >>
> > >> Are you claiming that the hwprobe work was not done in the open, but
> > >> secretly merged? That is not only incorrect, but rude to upstream RI=
SC-V
> > >> Linux developers. I suggest you review how you interact with upstrea=
m
> > >> kernel work.
> > >
> > > Please don't put words into my mouth...
> > >
> > > I was merely pointing out that there was no engagement by the RVI
> > > member companies (in regard to this mechanism) within RVI, which woul=
d
> > > have prevented Jessica's issue.
> > > This would have also helped to address the concerns on vendor-defined
> > > extensions.
> > >
> > > Also who do you refer to when you say "how _you_ interact"?  If it is
> > > RVI that you refer to: it doesn't interact with upstream work
> > > directly, as it doesn't own any engineering resources.
> > > RVI provides a forum for member companies to come to an
> > > understanding/design and then have the member companies perform the
> > > work and take it upstream.
> >
> > I'm not even sure what you're looking for here: if RVI doesn't want to
> > work upstream, then complaining that RVI isn't part of upstream
> > discussions is pretty pointless.
> >
> > >> Why didn't RVI get involved in the review of the series? The expecta=
tion
> > >> cannot be that all open source projects go to RVI, but rather the ot=
her
> > >> way around.
> > >
> > > That is exactly the point I was making and which you seem to miss: RV=
I
> > > does not own any engineering resources and depends solely on its
> > > member companies to project into open source projects.
> > >
> > >> Take a look at commit ea3de9ce8aa2 ("RISC-V: Add a syscall for HW
> > >> probing"). Your team was very much involved in the review.
> > >
> > > I am aware, as I had reviewed and commented on these are well.
> > > And my only request (was and) is that we need to figure out a way to
> > > efficiently deal with vendor-defined extensions.
> >
> > Maybe you should go talk to you team, then?  Handling vendor extensions
> > via hwprobe has been discussed, sounds like you're confused again.
>
> I too have this vague memory of us talking about vendor extensions,
> but my memory is really bad for stuff like this, so I spent the morning
> combing through all the hwprobe iterations looking for it, but so far
> have only found
>
> https://lore.kernel.org/lkml/CALs-HstoeoTWjTEZrLWouCgwq0t3tDB6uL=3DtB68RJ=
Ds1ub4Frw@mail.gmail.com/
>
> I'm most likely just blind, but does someone have another pointer?

Hello! That's probably the only pointer.

Couldn't handling vendor extensions within the hwprobe framework be as
straightforward as explicitly carving out a region for them? Say
0x8000000000000000+ belongs to the vendor? The layout of keys within
the vendor hwprobe region then depends on the value in mvendorid (and
if the vendor so chooses, archid and impid as well). Then vendors can
expose keys to their hearts (avoiding the dumb pun there) content.

We can probably skip caching the vendor keys in the vDSO for now. If
it really needs to be done we can add it later.

This would enforce that there's only one "vendor" at a time for a
given hart, but I think that's reasonable. Let me know what you think.

-Evan
