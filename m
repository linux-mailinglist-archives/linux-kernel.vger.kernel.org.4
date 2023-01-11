Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BE066505A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 01:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbjAKA3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 19:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbjAKA3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 19:29:53 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7443352C65
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 16:29:52 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so11421673wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 16:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GDU3b13swhpz+1ckV3zC5q8bsKV80I63Ph9YXnKd44=;
        b=MVu1Z5Mjgqd/lMdG+8zThTcHew9/lkSWteEBbsvcqcLcceQQm00jXGEBCbf3BnBqWT
         1fR+kGJvfPgS/VxbQXXPAr2VlpQCsi8K3bccTdeIiDCrKy1UX2l5lkH/6x1b0j99WYst
         o7ffOv6vD2UBnjtq8/YX7QrGQc2g+9ki1TGiwnr7SsZCcjn9QBQ6CRTo0u1zbJEY0s9G
         N6XgRxKYifsIJZymsIFwqKPh7keaWJsFrI2V3VsjSmwo+zVsH9I8KOUJb3Pb2UqDss3L
         hdnRUgs9lKNbMXkyeKecL55aF0/jDABJyVP6SkUMIWbctJ2UULKqMx+96EcXB/XBc9PM
         BzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/GDU3b13swhpz+1ckV3zC5q8bsKV80I63Ph9YXnKd44=;
        b=b0w81o+bxVJAZirESffAVbr5vJzCNt+EavnsVn3oTPP4t3ZJ9T2o7YGgSaiRTNvyf8
         juuLXydw/Qm1ru4dOaDLMhi6UCNmg1/Ch+epoBcZsuY1SB29eMUNG/AmRUr0dRbkh8O+
         S1mNOXVIZ+pl6GcTjKbq5YNN8K5eX/+uO2xX2IgRse6dvCcmWk5Cngnz0k/wg8oHzpxZ
         DpfcoTYeD4Dt7FX4nSCzB0KUnXbgmZoSdRxULLtPdC5qdftgiEoNvbUNKtVl7JTgJXKL
         kQX+JQIrN85xwpgULQV7wtt8xt4LNr4iSXuzY3UE7gKpuyIOPnOCtevEb2U0REI8eCEO
         wxAA==
X-Gm-Message-State: AFqh2kq4fynG0CYkJtjNHeXXFeTXfOKp0QFEixBmXC9lZctHmm5JGtDU
        aiW3rQaLpDvbCjFZe+dBXb+EADzM7Xx5+iJz0pQTOA==
X-Google-Smtp-Source: AMrXdXtvZ3JYT6h2W6TAS9MDvlYVEP/AIF175SWm5edz18p9MIWrt4unOJiYVDWg3IitA6BqmlFgOg==
X-Received: by 2002:a05:600c:3596:b0:3cf:497c:c4f5 with SMTP id p22-20020a05600c359600b003cf497cc4f5mr53050191wmq.13.1673396991015;
        Tue, 10 Jan 2023 16:29:51 -0800 (PST)
Received: from smtpclient.apple (global-5-143.n-2.net.cam.ac.uk. [131.111.5.143])
        by smtp.gmail.com with ESMTPSA id f11-20020a05600c4e8b00b003d04e4ed873sm24073379wmq.22.2023.01.10.16.29.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2023 16:29:50 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH] riscv: elf: add .riscv.attributes parsing
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <3e91a775-c671-35e8-0966-3ec9d8999e14@rivosinc.com>
Date:   Wed, 11 Jan 2023 00:29:49 +0000
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, Guo Ren <guoren@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>, linux@rivosinc.com,
        kernel test robot <lkp@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A2A77A5F-0322-4BFA-A163-33E373C819F7@jrtc27.com>
References: <20230110201841.2069353-1-vineetg@rivosinc.com>
 <01AF458D-1EDC-47D1-A902-A686E2DF26AF@jrtc27.com>
 <6dcdd143-ff1c-41f7-9f46-0c4505575669@rivosinc.com>
 <9061941F-3221-467D-B0FC-DCA8E8FF3996@jrtc27.com>
 <3e91a775-c671-35e8-0966-3ec9d8999e14@rivosinc.com>
To:     Vineet Gupta <vineetg@rivosinc.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Jan 2023, at 23:45, Vineet Gupta <vineetg@rivosinc.com> wrote:
> On 1/10/23 15:21, Jessica Clarke wrote:
>>>> You also should handle more than one sub-subsection even if tools =
don=E2=80=99t
>>>> emit it today.
>>> Just to be on same page, a sub-section implies the following
>>>=20
>>>       uint32:len, NTBS:vendor-name, uint8: Tag_file, =
uint32:data-len, <tag><value>....
>>>=20
>>> If so, the code does support multiple of these
>> That=E2=80=99s a sub-section, but I said sub-subsection.
>=20
> The psABI documentation that we reviewed yesterday only mentions =
Tag_File =3D 1 and doesn't mention the term sub-subsection at all.
> We need to be consistent between code and the new documentation or =
just add reference to ARM documentation which covers everything and =
write the general purpose parser.

Documentation you wrote and hasn=E2=80=99t been approved by anyone else. =
Where
I said that we need to document that multiple sub-subsections are
allowed.

Jess

