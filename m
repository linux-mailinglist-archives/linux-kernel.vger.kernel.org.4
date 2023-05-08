Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B60D6FB606
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 19:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbjEHRiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 13:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbjEHRiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 13:38:14 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90C24491
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 10:38:06 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3078d1c8828so2034387f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 10:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1683567485; x=1686159485;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M25WATLyhzQhxEa9d8o7KkxKQW/wNscePwtVST5KSrQ=;
        b=VE2s1SsbDx/aXrQS0NgPAk+WgOdHzf/3QqunudodyRdICX4j2qtYPKHQkGHIIrqlNx
         sx4mZcdMePOV2XyS4GUz43h30N5lR0N91qh2enquQDOHWMxCmhEogmN550EVNPOOajmC
         T0x2AFGIgbbpZS7DvVlBhuJ44DTjHR30UUw4NrL3yOb5M6b2+KA6kUoAsVoN1mQ1iyzl
         OVNvBRkmjh21X5KkqzBak91XB+t/0QQXsjirTPr/Q6+YcYKJ9HGxU2l1QjkwKW3s9zyq
         thAzQHhJR6/mHDxLulIlbitkOXbcetIB+3lFg17tvUW6gvs/DcD0KGz1MCjvPNuM/TFp
         AfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683567485; x=1686159485;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M25WATLyhzQhxEa9d8o7KkxKQW/wNscePwtVST5KSrQ=;
        b=b7zrUE7tLD8SQI/5J/TgIHBYvVo1lAI45rwBiz5/ciAmhZOKdItPsDaR/x4RrGvxPk
         lIwO+mmuF2K+eyFa2q0iUzZHvvreBrXpQ7FQui93u7/9X27KTg07SHXa3xIesSFEMif6
         ocq4HY9fPpPrwYpEuAjF4BXddUiDH3pjZEWn6MA0BY/8LSE52yDU3H/z6qemDlfDQtnp
         cGUAvbdw+PfddULyhWzhpA1SdONCimv4lmGojSJZpnApn+rMlmuMeQEisVU6OewltT0k
         BogW/hPFZuUDYRDcN8eieoUhAO35FIXnEHp9HAcxYb2b8hrvWdbIY5voZB1t2Jqy6RNS
         zxXA==
X-Gm-Message-State: AC+VfDxrChsHCnDrUeAZJAOtMw6SIVv48pcyHwzmTR67qY4x8uSvbTPv
        8Ii6FfzpYzSvzCyiNmr1TC9Anw==
X-Google-Smtp-Source: ACHHUZ5bFycPjjdZDy4zh3O1GgESwHukk7T6kJrOeduza6REZE6xLKd6D6eBN/8xMKM7PgA1xNoiXw==
X-Received: by 2002:a5d:470b:0:b0:306:2ddb:47ab with SMTP id y11-20020a5d470b000000b003062ddb47abmr8138690wrq.39.1683567485115;
        Mon, 08 May 2023 10:38:05 -0700 (PDT)
Received: from smtpclient.apple ([131.111.5.246])
        by smtp.gmail.com with ESMTPSA id z18-20020a1c4c12000000b003f188f608b9sm17420521wmf.8.2023.05.08.10.38.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 May 2023 10:38:04 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH 0/4] Expose the isa-string via the AT_BASE_PLATFORM aux
 vector
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <CAAeLtUCUNV36JQNQ1REzbe8Wwk-JvEOqpOZp2udYxfNPOqq3hQ@mail.gmail.com>
Date:   Mon, 8 May 2023 18:38:03 +0100
Cc:     Evan Green <evan@rivosinc.com>,
        =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Kito Cheng <kito.cheng@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        matthias.bgg@gmail.com,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Greentime Hu <greentime.hu@sifive.com>, nick.knight@sifive.com,
        =?utf-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        Richard Henderson <richard.henderson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7F569E2F-EDE5-452D-91B8-3781B611E438@jrtc27.com>
References: <mhng-4b9e3d86-2f0b-47da-8a5d-bd383a0171d6@palmer-ri-x1c9>
 <4830085.8hb0ThOEGa@diego>
 <CALs-HsveK-uUuSAOkUUPuUYK6_ChG95_YWtdwYvGsTfKYSWUpg@mail.gmail.com>
 <CAAeLtUDgWwT0wxhFANagBX4ExA_HkyqM-ZdPn==+_atGV3vTww@mail.gmail.com>
 <CAAeLtUCUNV36JQNQ1REzbe8Wwk-JvEOqpOZp2udYxfNPOqq3hQ@mail.gmail.com>
To:     Philipp Tomsich <philipp.tomsich@vrull.eu>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 May 2023, at 18:34, Philipp Tomsich <philipp.tomsich@vrull.eu> =
wrote:
>=20
> [Resend, as my mail client hadn't picked up that it should respond as
> plain-text.]
>=20
> On Mon, 8 May 2023 at 19:32, Philipp Tomsich =
<philipp.tomsich@vrull.eu> wrote:
>>=20
>> Evan,
>>=20
>> On Mon, 8 May 2023 at 18:50, Evan Green <evan@rivosinc.com> wrote:
>>>=20
>>> On Wed, May 3, 2023 at 3:31=E2=80=AFAM Heiko St=C3=BCbner =
<heiko@sntech.de> wrote:
>>>>=20
>>>> Hi,
>>>>=20
>>>> Am Dienstag, 2. Mai 2023, 19:15:29 CEST schrieb Palmer Dabbelt:
>>>>> On Tue, 02 May 2023 02:13:10 PDT (-0700), philipp.tomsich@vrull.eu =
wrote:
>>>>>> On Tue, 2 May 2023 at 09:58, Bj=C3=B6rn T=C3=B6pel =
<bjorn@kernel.org> wrote:
>>>>>>>=20
>>>>>>> Philipp Tomsich <philipp.tomsich@vrull.eu> writes:
>>>>>>>=20
>>>>>>>> It is a pity that the current interface was designed without =
involving
>>>>>>>> RVI (and that I had to ask my team to put together a patch set =
for
>>>>>>>> further discussion, given that none of the other major vendors =
in RVI
>>>>>>>> stepped forward).  I guarantee that plenty of reviewers would =
have
>>>>>>>> highlighted that a central registry (even if it is just a =
kernel
>>>>>>>> header) should be avoided.
>>>>>>>=20
>>>>>>> Are you claiming that the hwprobe work was not done in the open, =
but
>>>>>>> secretly merged? That is not only incorrect, but rude to =
upstream RISC-V
>>>>>>> Linux developers. I suggest you review how you interact with =
upstream
>>>>>>> kernel work.
>>>>>>=20
>>>>>> Please don't put words into my mouth...
>>>>>>=20
>>>>>> I was merely pointing out that there was no engagement by the RVI
>>>>>> member companies (in regard to this mechanism) within RVI, which =
would
>>>>>> have prevented Jessica's issue.
>>>>>> This would have also helped to address the concerns on =
vendor-defined
>>>>>> extensions.
>>>>>>=20
>>>>>> Also who do you refer to when you say "how _you_ interact"?  If =
it is
>>>>>> RVI that you refer to: it doesn't interact with upstream work
>>>>>> directly, as it doesn't own any engineering resources.
>>>>>> RVI provides a forum for member companies to come to an
>>>>>> understanding/design and then have the member companies perform =
the
>>>>>> work and take it upstream.
>>>>>=20
>>>>> I'm not even sure what you're looking for here: if RVI doesn't =
want to
>>>>> work upstream, then complaining that RVI isn't part of upstream
>>>>> discussions is pretty pointless.
>>>>>=20
>>>>>>> Why didn't RVI get involved in the review of the series? The =
expectation
>>>>>>> cannot be that all open source projects go to RVI, but rather =
the other
>>>>>>> way around.
>>>>>>=20
>>>>>> That is exactly the point I was making and which you seem to =
miss: RVI
>>>>>> does not own any engineering resources and depends solely on its
>>>>>> member companies to project into open source projects.
>>>>>>=20
>>>>>>> Take a look at commit ea3de9ce8aa2 ("RISC-V: Add a syscall for =
HW
>>>>>>> probing"). Your team was very much involved in the review.
>>>>>>=20
>>>>>> I am aware, as I had reviewed and commented on these are well.
>>>>>> And my only request (was and) is that we need to figure out a way =
to
>>>>>> efficiently deal with vendor-defined extensions.
>>>>>=20
>>>>> Maybe you should go talk to you team, then?  Handling vendor =
extensions
>>>>> via hwprobe has been discussed, sounds like you're confused again.
>>>>=20
>>>> I too have this vague memory of us talking about vendor extensions,
>>>> but my memory is really bad for stuff like this, so I spent the =
morning
>>>> combing through all the hwprobe iterations looking for it, but so =
far
>>>> have only found
>>>>=20
>>>> =
https://lore.kernel.org/lkml/CALs-HstoeoTWjTEZrLWouCgwq0t3tDB6uL=3DtB68RJD=
s1ub4Frw@mail.gmail.com/
>>>>=20
>>>> I'm most likely just blind, but does someone have another pointer?
>>>=20
>>> Hello! That's probably the only pointer.
>>=20
>>=20
>> Thanks for following up, as we were debating internally if and what =
discussions we had missed.
>>=20
>>>=20
>>> Couldn't handling vendor extensions within the hwprobe framework be =
as
>>> straightforward as explicitly carving out a region for them? Say
>>> 0x8000000000000000+ belongs to the vendor? The layout of keys within
>>> the vendor hwprobe region then depends on the value in mvendorid =
(and
>>> if the vendor so chooses, archid and impid as well). Then vendors =
can
>>> expose keys to their hearts (avoiding the dumb pun there) content.
>>>=20
>>> We can probably skip caching the vendor keys in the vDSO for now. If
>>> it really needs to be done we can add it later.
>>>=20
>>> This would enforce that there's only one "vendor" at a time for a
>>> given hart, but I think that's reasonable. Let me know what you =
think.
>>=20
>>=20
>> We generally try to treat vendor-extensions as "vendor-defined" and =
not "vendor-specific".  In other words, an implementor would be free to =
implement XVentanaCondOp and XTHeadVDot.  While we could simply alias =
things into the implementor's "vendor"-space, I see some benefits to =
having a unique id for every vendor-defined property=E2=80=A6
>>=20
>> Could we use ( 0x8000000000000000 | vendor-id << VENDOR_SHIFT | =
key-in-vendor-space )?
>> If so, do we have vendor-ids allocated today that we could use for =
this purpose?

The only somewhat useful one is mvendorid, but that=E2=80=99s a JEDEC =
thing so
if you=E2=80=99re an academic then yours will be 0 and we=E2=80=99re =
back to a shared
namespace.

Jess

>> Thanks,
>> Philipp.
>>=20
>>>=20
>>>=20
>>> -Evan

