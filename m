Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD0969DE61
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 12:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbjBULEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 06:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjBULEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 06:04:00 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3F4222EF
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 03:03:59 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id t13so3894993wrv.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 03:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nuii1O1uXqWSPb5QmokeXfWS5vvCDyLzlvaBL4q0jA=;
        b=ngKsUA1fri3dXJyo2WTKtv8pm59KVoqPZ2+wgww4/qt+B18+838Nmg8/c4vLBr8Hb1
         RrX1cr3XacBMEm9yDpKinYwiGx29E1SG3yprab9xqBXSQ0XdjH111hptHlJfYXd4cSJM
         A66sA7XajwTLYsjkIH0ol67ql3xA/ewCbNi4Jt/kRnQ7q4nziMVFfRCk4QojMaH9BUod
         BnH6pjZropMvQdyfC2WLB4qreyNQGpzkQsxsB/54Rqxl/zV3+vISHw4F3/zjfP1n+W9s
         9MIvCr5vXXQSFyvV5Vxc7tJlMX9oFfYicNUjTpP8RKs+atZKPBXTbjx7KdGMOLiNAUo/
         YiCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nuii1O1uXqWSPb5QmokeXfWS5vvCDyLzlvaBL4q0jA=;
        b=67sukuWffoBfKmB93tGFUUWK77TvFNB+50pZ3aZzQxExqOOe7wkmEfaxsbp43AY49T
         Od/cdlNQ4VSIrxLbYKgIuyZWfC7zKJL9ivGBd+7gBe2Hs5a9mlmbOs8vo1bCj6iWrQlz
         Hcu7Y5bwdBwxOIVXOaxYf/ibjHuoV8x9uaTwKnI5FNYgdYU3TVf9aVP+cIoTkxFMQr2J
         Uj7BfzEKHmT9aJiY7AViKIfWtYuhNtlIKY5HLqpGN4JQcEfXCC96JWsYOxmrdzrG9CXa
         Hx73ztVHrHA6oMrm8AX7F+F2KcI1Pg6Y7FAsbqcidAwrwqejtlEOR39gQ7SP0Tba/SHo
         01vg==
X-Gm-Message-State: AO0yUKVd8W0TbeNS1tjU7Pj6L9JPWyX8Op3ybNClrikGFAMU1ROKYPBS
        27Bf9G1rqxlvnoyY4ubfo+YVWwTYqe/myEwtp1J3wg==
X-Google-Smtp-Source: AK7set/p0Op55W1O5D/4Ls2gp3wEI6ZwX06UJ6h/kCzp2F6pBHxE8g/N5Its7aG571Qjz7hLDLVIdY1hi3fybLfcBSU=
X-Received: by 2002:a5d:45c2:0:b0:2c5:5b2f:8c80 with SMTP id
 b2-20020a5d45c2000000b002c55b2f8c80mr350550wrs.318.1676977437766; Tue, 21 Feb
 2023 03:03:57 -0800 (PST)
MIME-Version: 1.0
References: <20230128072737.2995881-3-apatel@ventanamicro.com>
 <mhng-0f9bdf58-5289-4db4-8fd7-38898824c44f@palmer-ri-x1c9>
 <CAEg0e7hrQFu+cdZy+3QO1ML9FNTPBehZwOOBnr1F-5ABYDnkGg@mail.gmail.com>
 <CAEg0e7hRjMSgYZbPTQztbQ3bGZf-r8wAfCK5ZnDXOcx27HcTCA@mail.gmail.com>
 <Y/Sfpb2c/LS0LCiA@wendy> <F80EBB4C-29C4-472D-B213-EFD220EF9B1F@jrtc27.com> <Y/SkES28TNBz02wM@wendy>
In-Reply-To: <Y/SkES28TNBz02wM@wendy>
From:   =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Date:   Tue, 21 Feb 2023 12:03:45 +0100
Message-ID: <CAEg0e7i3=Zg5pxG4HCEfFkzpot5-u6yHoTSFKPBuCGU+djZ5uw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] RISC-V: Detect AIA CSRs from ISA string
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Jessica Clarke <jrtc27@jrtc27.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <apatel@ventanamicro.com>, pbonzini@redhat.com,
        Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 12:00 PM Conor Dooley
<conor.dooley@microchip.com> wrote:
>
> On Tue, Feb 21, 2023 at 10:51:13AM +0000, Jessica Clarke wrote:
> > On 21 Feb 2023, at 10:40, Conor Dooley <conor.dooley@microchip.com> wro=
te:
> > > On Tue, Feb 21, 2023 at 08:12:58AM +0100, Christoph M=C3=BCllner wrot=
e:
> > >> The full meeting minutes can be found here:
> > >>  https://lists.riscv.org/g/tech-chairs/message/1381
> > >
> > > This link is non functional unfortunately :/
> >
> > tech-chairs is private, for (co-)chairs only... not sure why it went
> > there rather than tech-privileged.
>
> Yah, that's what I was getting at.. This is a conversation on a public
> ML, so it'd be annoying enough for some readers if it was gated around
> RVI membership, but gating on membership of the inner circle makes it
> kinda useless!

The mail was forwarded there as well (and to tech-unprivileged):
  https://lists.riscv.org/g/tech-privileged/message/1294
  https://lists.riscv.org/g/tech-unprivileged/message/430

BR
Christoph
