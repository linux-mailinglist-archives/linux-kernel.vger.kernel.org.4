Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49777710D7C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 15:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241320AbjEYNn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 09:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbjEYNn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 09:43:26 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EC8183
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 06:43:25 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-96fb1642b09so96721166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 06:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20221208.gappssmtp.com; s=20221208; t=1685022204; x=1687614204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOccQXmo2035CwTFujmC8mOqSuEwBb9LtX0oVjEbuJY=;
        b=OkMUYmydKGw5MAtGrmnKLknwVM75BiYt9vXJFl4d/v5aKqnpw6s3mNfu7ess3qJSGC
         c2bKWnfDgNr5FMrKg+vu0jVS+n7L3NjEfUx0ue8njRxP8alsciAXDQAkG/exd7FF1518
         bK+KgQs8QtbQ6mmdp2t6r1rE+FWMtj1uYIDnScU2XgNFW43moZ70VxdX+SCD3PE7nnVm
         J2F/9VRwXstHKK2rstRz+rr5DIdQ3A8OW7Uiy0DJftQhaluXAO6zOxWH11RoedQYGBgS
         FXatctF8adb7RyiB7Vu+EvIE+lpMZmZnbdRwtvvkohUsq7dYnciWCwyT9XbzWWAQwbRE
         BggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685022204; x=1687614204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOccQXmo2035CwTFujmC8mOqSuEwBb9LtX0oVjEbuJY=;
        b=LDQwIfM8VecH1V2UDxMnF8mAa/kynp9H03v5fE/qriYLsj4KaZqt8tLBgeni8cmuDF
         ajpdbJvwPyPP0Vh1lLr/M8BHJecijz18ZHK0Qv/pM5T0zqYUMqqSzuhat8/XO3ghs2bD
         FMFtvzvRWOJTkXZaVD1UN3XgPOsI4klcHk2WbxqdmbA0ypu/Whz0kr1pKuA6EB327fvu
         SEiikQYCg3xPSf6CRRWOL0QvOaiZgjHhRDhR42bIpoDTmGtUhf59HDCuqU7ud7qWrWeg
         OBSWUmC3KeaqqjkWwZh2fNb7dyh5VAwyh1nAOEIhgnDJ5co2jC4RztYQXm8AUFpOyp5t
         48dg==
X-Gm-Message-State: AC+VfDxGHNWfcYE4/aTLRt2dwzGh9mhl1gokIzQKjc5r3tQgrFf8OPRw
        1jZSe8o7pDzYD7SS4qYn6JmoxBWqNipkXee0POmRFA==
X-Google-Smtp-Source: ACHHUZ6wsi7g3mzKLT7/HrWAvj9ILnXRy+0i9nwts74wzsSjaf9/EQm8jI3GTRil4xAQ0ViuEiXsGmxbWJd9lTb/GhQ=
X-Received: by 2002:a17:907:944e:b0:973:92d4:9f4e with SMTP id
 dl14-20020a170907944e00b0097392d49f4emr1353242ejc.53.1685022204015; Thu, 25
 May 2023 06:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAHVXubgse4Lw7ucg52FkQW4c=QrNo56BXsRZ_nkCHAAPxUXUig@mail.gmail.com>
 <CAHVXubj92O_dwGShOJgrYezqk2pA2NtFyhNFbAPyhn7=PztK6Q@mail.gmail.com>
 <20230517-preacher-primer-f41020b3376a@wendy> <CAHVXubhMLgb54_7zV2yFuGPoMKCkUXwozHbDvghc7kQqNLK-JA@mail.gmail.com>
 <CAAhSdy3tKAk1xjinwnSWan0ivdDapcLvSb+hGNynPFZMUsoB9A@mail.gmail.com>
 <fe8d716c-fb4f-1f3f-6c69-de1d8b9fb6af@ghiti.fr> <CAK9=C2X1BjZCHfYM33pZQtavu7yRqxwsypWL5OWj79bJrnDMQg@mail.gmail.com>
 <CAOnJCULpa-TJuG=TtCDOxOdUviZzWheLE-GMiU1r7GWaKn0nuQ@mail.gmail.com>
 <20230525-guacamole-swimmer-68048a73baac@wendy> <CAK9=C2WUyLxZwQO37cN-i+V+A3yxmEoaj=uE8yR8nseYTDW7oQ@mail.gmail.com>
 <20230525-postnasal-monopoly-98adb96ffaa1@wendy>
In-Reply-To: <20230525-postnasal-monopoly-98adb96ffaa1@wendy>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 25 May 2023 19:13:11 +0530
Message-ID: <CAAhSdy06nQh4H1FP_K_-VF462mhj+F2M=4AV4QSCUGe5XVqX0g@mail.gmail.com>
Subject: Re: Bug report: kernel paniced when system hibernates
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Alexandre Ghiti <alex@ghiti.fr>, robh@kernel.org,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        jeeheng.sia@starfivetech.com, linux-kernel@vger.kernel.org,
        palmer@rivosinc.com, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Song Shuai <suagrfillet@gmail.com>,
        linux-riscv@lists.infradead.org,
        Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 7:08=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> On Thu, May 25, 2023 at 06:51:28PM +0530, Anup Patel wrote:
>
> > > We should only rely on this node name for known bad versions of opens=
bi
> > > IMO. Going forward, if something needs to be reserved for firmware, t=
he
> > > firmware should make sure that it is reserved by using the property f=
or
> > > that purpose :)
>
> > There is no issue with OpenSBI since it does the right thing by marking
> > memory as reserved in the DT. This real issue is with the kernel handli=
ng
> > of reserved memory for hibernate.
>
> I don't think we are talking about the same thing here. I meant the
> no-map property which OpenSBI does not set.

Yes, we are talking about the same thing. It's not just OpenSBI not
setting no-map property in reserved memory node because other
SBI implementations would be doing the same thing (i.e. not setting
no-map property)

Regards,
Anup

>
> > Like Atish mentioned, not just OpenSBI, there will be other entities
> > (like TSM) or some other M-mode firmware which will also reserve
> > memory in DT/ACPI so clearly kernel needs a SBI implementation
> > independent way of handling reserved memory for hibernate.
>
> > > > Another option is to use compatible string or label property to ind=
icate
> > > > that this memory region is not to be saved/restored during hibernat=
ion.
> > > > This can be documented in RISC-V DT bindings as well as the booting=
 guide
> > > > doc that alex was talking about.
> > >
> > > Sure, a dt-binding for sbi reserved regions doesn't immediately sound
> > > like an awful idea... But we still have to work around the borked
> > > firmware - be that disabling hibernation or using the mmode_resv node
> > > when we know that the version of OpenSBI is one of those with the
> > > problem.
>
> Did you skip over this? I was agreeing that defining a common binding for
> sbi reserved regions was a good idea.
