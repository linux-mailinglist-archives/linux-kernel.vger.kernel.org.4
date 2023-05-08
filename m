Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204136FB5FA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 19:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjEHReY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 13:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEHReW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 13:34:22 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985CB5BBA
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 10:34:20 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bdd7b229cso9142269a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 10:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1683567259; x=1686159259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0ACKyHbkTPD2yxeJB4ltSLZhmTYJ+ogPwt0nvA0/JA=;
        b=UsXO3z6T3+GWoAddjvibd65Ykan490NBq2LAUn1cOHoRrcJLoVmWV1qJHPlVfvbGWf
         xmaUeAnawFB+DBFV8UqgNkuXuxWn/M7Atu9iXvbHAH/GtNVVT8W3bj1PWFmQNHq2y3oJ
         IH+qpybYJ5jHnxyRNpSEqt7NbeMlcd8ghl6KUtFTXaCC+dPFMeclfHzXeEcGK+9xnIPa
         UAMcuzHZUbyGXMiJgtHfXblDXlK9cddv7Sqq77VZj6wrwaSDIgoZJwrBJZQ7n7T+4ABT
         RFq1vLu4HRX5qBL+bqKOgIVD2zu9m+64hqf8YT476AHQoTAumjWKViVu/6qJurugo2vi
         Fk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683567259; x=1686159259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0ACKyHbkTPD2yxeJB4ltSLZhmTYJ+ogPwt0nvA0/JA=;
        b=Aly0TCEIhI0oZRsmLySCF6MSsHqiIoMoNfivgZQWTFu24iQ23k/G5VFAGvESttMQwW
         gCj8vK+7dc97yM2VGvMlE6C+/Z0C2Rqs60H+xf0TDbNIdpIca9DSTHMgI8DFsMDtPBvh
         usTvBx2oBBeDHoKyqB3/fqr8ELNdRMr7scOQoiH8DqdTfpNSco8VWdWwzElLYPKU7Qgj
         t+61JGyI0q5f9rDXfiUpOoBmkWpSsp5R50ehbhphANn+TDlIwQZf1EX5SNyw+D86hyLb
         NbLBL/muyaw33X9wMveZzGxI4NVIZwlwcVLWn8Zw2mb68Q6w7bzQxhsUeathuwhIKuf8
         wUCA==
X-Gm-Message-State: AC+VfDxVE8ALCjgUyXJlP4mRJkE2xAwEvb1V1IuOsp11PiTqm+HDzD/0
        bKWIrR9t0D0LhKK+b+XynCiSgym1NkQQG4zy0sn1fQ==
X-Google-Smtp-Source: ACHHUZ7Sj+FKYsLDQ+HT4UqYHWe1Nzo+KBmAhf3tyHszfqS7HJSoV5ULTPKwxW3jHadvOOCcAfm23BxLYQG+tQeoZcM=
X-Received: by 2002:a17:907:26c2:b0:8b1:3467:d71b with SMTP id
 bp2-20020a17090726c200b008b13467d71bmr9594258ejc.48.1683567258828; Mon, 08
 May 2023 10:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-4b9e3d86-2f0b-47da-8a5d-bd383a0171d6@palmer-ri-x1c9>
 <4830085.8hb0ThOEGa@diego> <CALs-HsveK-uUuSAOkUUPuUYK6_ChG95_YWtdwYvGsTfKYSWUpg@mail.gmail.com>
 <CAAeLtUDgWwT0wxhFANagBX4ExA_HkyqM-ZdPn==+_atGV3vTww@mail.gmail.com>
In-Reply-To: <CAAeLtUDgWwT0wxhFANagBX4ExA_HkyqM-ZdPn==+_atGV3vTww@mail.gmail.com>
From:   Philipp Tomsich <philipp.tomsich@vrull.eu>
Date:   Mon, 8 May 2023 19:34:07 +0200
Message-ID: <CAAeLtUCUNV36JQNQ1REzbe8Wwk-JvEOqpOZp2udYxfNPOqq3hQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Expose the isa-string via the AT_BASE_PLATFORM aux vector
To:     Evan Green <evan@rivosinc.com>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>, bjorn@kernel.org,
        jrtc27@jrtc27.com, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        kito.cheng@sifive.com, Conor Dooley <conor.dooley@microchip.com>,
        matthias.bgg@gmail.com, heinrich.schuchardt@canonical.com,
        greentime.hu@sifive.com, nick.knight@sifive.com,
        christoph.muellner@vrull.eu,
        Richard Henderson <richard.henderson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Resend, as my mail client hadn't picked up that it should respond as
plain-text.]

On Mon, 8 May 2023 at 19:32, Philipp Tomsich <philipp.tomsich@vrull.eu> wro=
te:
>
> Evan,
>
> On Mon, 8 May 2023 at 18:50, Evan Green <evan@rivosinc.com> wrote:
>>
>> On Wed, May 3, 2023 at 3:31=E2=80=AFAM Heiko St=C3=BCbner <heiko@sntech.=
de> wrote:
>> >
>> > Hi,
>> >
>> > Am Dienstag, 2. Mai 2023, 19:15:29 CEST schrieb Palmer Dabbelt:
>> > > On Tue, 02 May 2023 02:13:10 PDT (-0700), philipp.tomsich@vrull.eu w=
rote:
>> > > > On Tue, 2 May 2023 at 09:58, Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.o=
rg> wrote:
>> > > >>
>> > > >> Philipp Tomsich <philipp.tomsich@vrull.eu> writes:
>> > > >>
>> > > >> > It is a pity that the current interface was designed without in=
volving
>> > > >> > RVI (and that I had to ask my team to put together a patch set =
for
>> > > >> > further discussion, given that none of the other major vendors =
in RVI
>> > > >> > stepped forward).  I guarantee that plenty of reviewers would h=
ave
>> > > >> > highlighted that a central registry (even if it is just a kerne=
l
>> > > >> > header) should be avoided.
>> > > >>
>> > > >> Are you claiming that the hwprobe work was not done in the open, =
but
>> > > >> secretly merged? That is not only incorrect, but rude to upstream=
 RISC-V
>> > > >> Linux developers. I suggest you review how you interact with upst=
ream
>> > > >> kernel work.
>> > > >
>> > > > Please don't put words into my mouth...
>> > > >
>> > > > I was merely pointing out that there was no engagement by the RVI
>> > > > member companies (in regard to this mechanism) within RVI, which w=
ould
>> > > > have prevented Jessica's issue.
>> > > > This would have also helped to address the concerns on vendor-defi=
ned
>> > > > extensions.
>> > > >
>> > > > Also who do you refer to when you say "how _you_ interact"?  If it=
 is
>> > > > RVI that you refer to: it doesn't interact with upstream work
>> > > > directly, as it doesn't own any engineering resources.
>> > > > RVI provides a forum for member companies to come to an
>> > > > understanding/design and then have the member companies perform th=
e
>> > > > work and take it upstream.
>> > >
>> > > I'm not even sure what you're looking for here: if RVI doesn't want =
to
>> > > work upstream, then complaining that RVI isn't part of upstream
>> > > discussions is pretty pointless.
>> > >
>> > > >> Why didn't RVI get involved in the review of the series? The expe=
ctation
>> > > >> cannot be that all open source projects go to RVI, but rather the=
 other
>> > > >> way around.
>> > > >
>> > > > That is exactly the point I was making and which you seem to miss:=
 RVI
>> > > > does not own any engineering resources and depends solely on its
>> > > > member companies to project into open source projects.
>> > > >
>> > > >> Take a look at commit ea3de9ce8aa2 ("RISC-V: Add a syscall for HW
>> > > >> probing"). Your team was very much involved in the review.
>> > > >
>> > > > I am aware, as I had reviewed and commented on these are well.
>> > > > And my only request (was and) is that we need to figure out a way =
to
>> > > > efficiently deal with vendor-defined extensions.
>> > >
>> > > Maybe you should go talk to you team, then?  Handling vendor extensi=
ons
>> > > via hwprobe has been discussed, sounds like you're confused again.
>> >
>> > I too have this vague memory of us talking about vendor extensions,
>> > but my memory is really bad for stuff like this, so I spent the mornin=
g
>> > combing through all the hwprobe iterations looking for it, but so far
>> > have only found
>> >
>> > https://lore.kernel.org/lkml/CALs-HstoeoTWjTEZrLWouCgwq0t3tDB6uL=3DtB6=
8RJDs1ub4Frw@mail.gmail.com/
>> >
>> > I'm most likely just blind, but does someone have another pointer?
>>
>> Hello! That's probably the only pointer.
>
>
> Thanks for following up, as we were debating internally if and what discu=
ssions we had missed.
>
>>
>> Couldn't handling vendor extensions within the hwprobe framework be as
>> straightforward as explicitly carving out a region for them? Say
>> 0x8000000000000000+ belongs to the vendor? The layout of keys within
>> the vendor hwprobe region then depends on the value in mvendorid (and
>> if the vendor so chooses, archid and impid as well). Then vendors can
>> expose keys to their hearts (avoiding the dumb pun there) content.
>>
>> We can probably skip caching the vendor keys in the vDSO for now. If
>> it really needs to be done we can add it later.
>>
>> This would enforce that there's only one "vendor" at a time for a
>> given hart, but I think that's reasonable. Let me know what you think.
>
>
> We generally try to treat vendor-extensions as "vendor-defined" and not "=
vendor-specific".  In other words, an implementor would be free to implemen=
t XVentanaCondOp and XTHeadVDot.  While we could simply alias things into t=
he implementor's "vendor"-space, I see some benefits to having a unique id =
for every vendor-defined property=E2=80=A6
>
> Could we use ( 0x8000000000000000 | vendor-id << VENDOR_SHIFT | key-in-ve=
ndor-space )?
> If so, do we have vendor-ids allocated today that we could use for this p=
urpose?
>
> Thanks,
> Philipp.
>
>>
>>
>> -Evan
