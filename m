Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573297158A5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjE3Ied (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjE3Iea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:34:30 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58729A1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:34:29 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-96f7bf29550so647558066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685435668; x=1688027668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3DWzEonbFWbbY/J/LUS3ZtdblQa3UBeh1JXjSViZoU=;
        b=D5dXsb+0ihlpmZyKQ/rbP+vLRp+n6mddWpLXjnF/gTeR0yIsl0XbZCzTF8+ZcMqQhb
         HA6y5H4HYOl5BTQgn5XQxjKsXFdfTe/pKWsrC8M0+whLII5sb27JIBFmDkFEflfLltCd
         XxxzJiaTjMLatuIeHAZjI2SZTi5CPsXwFWO+kpl8aEttaZCf8VmY5UfqwiQLZ/vHaeDp
         f29X7c/R5bqKkVdeFklAEJDBUKRiacQjoKHxaj3fnWG+vzh8yz+2sUDHl8uAMHVyGSW4
         7zhJbe2ELiBgqds9U/Is5x5bZ1fkoeKoHEC9r0B6024ZbyYm0RONahVyKsW1uSB2/u9v
         LYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685435668; x=1688027668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q3DWzEonbFWbbY/J/LUS3ZtdblQa3UBeh1JXjSViZoU=;
        b=j3JIKZI+Ggz5ODfvQxAVZmLHXw4/y5ScZsxMu+ed/+CVAtlAbvYEMnXkW+4XbNpS2J
         2NTDAXK196fHcwDBZoyZTDbNUWbcf0y30UdL+7knLyAFJb5+3KLkUQWykQZHHdNxn4fZ
         h/IgruQlYle1ljDmRDcf3CECYq7TUpI+NGVfOKTrNGkjmED5yt1JocPsnb8WlRK9XOhP
         s4DTK0VbsUtZ7Hm4mrupkmPx2v6eNv4Z6nq8eeYbOTLssLLYsh/1g1JcAIab44xaclhd
         2qwkQayva4429ORO9HIk6SJnlZNU/xv9xJNMMWZR199k1K5W/Yd4jPJSEa16WgKd5JdY
         NGqw==
X-Gm-Message-State: AC+VfDw5RtsAxaMpfaQ28argN7WVcPXNO92/q251aOxxXPL+AtP+rvKe
        uZFw3Tyrz9nGNYIG5khilyTVA1kzC/SYXGO8ny8=
X-Google-Smtp-Source: ACHHUZ7sBqTHQwlN8Izrnz3Ga9PApVnmonBzyCJuqF9y3iV4I5MlxFGqfl7vrS1qssq7S3umn2KRTP/icPbPFf4keDc=
X-Received: by 2002:a17:907:2d11:b0:973:ed4a:375f with SMTP id
 gs17-20020a1709072d1100b00973ed4a375fmr1752245ejc.46.1685435667522; Tue, 30
 May 2023 01:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230527054633.704916-1-chenhuacai@loongson.cn>
 <20230527054633.704916-2-chenhuacai@loongson.cn> <87pm6llvm6.ffs@tglx>
 <86fs7gdhid.wl-maz@kernel.org> <CAAhV-H6KpNhL5VvumvhcAKGOpe-EO0zfzm_xPprP0rTVf18Leg@mail.gmail.com>
 <87ilcblc72.ffs@tglx> <CAAhV-H41vDyBktE25Fdb34QtZ_yWSgTq4yMOyfD9H7YytKS3RA@mail.gmail.com>
 <878rd6lwlh.ffs@tglx>
In-Reply-To: <878rd6lwlh.ffs@tglx>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Tue, 30 May 2023 16:34:15 +0800
Message-ID: <CAAhV-H6uZWgZQsVh=1-U2B4ZZZz6EPJ3gkv0mxHSNGOMPB=VwQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] genirq/msi, platform-msi: Adjust return value of msi_domain_prepare_irqs()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Marc Zyngier <maz@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thomas,

On Tue, May 30, 2023 at 4:19=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> Huacai!
>
> On Mon, May 29 2023 at 17:36, Huacai Chen wrote:
> > On Mon, May 29, 2023 at 5:27=E2=80=AFPM Thomas Gleixner <tglx@linutroni=
x.de> wrote:
> >> By default you allow up to 256 interrupts to be allocated, right? So t=
o
> >> prevent vector exhaustion, the admin needs to reboot the machine and s=
et
> >> a command line parameter to limit this, right? As that parameter is no=
t
> >> documented the admin is going to dice a number. That's impractical and
> >> just a horrible bandaid.
> >
> > OK, I think I should update the documents in the new version.
>
> Updating documentation neither makes it more practical (it still
> requires a reboot) nor does it justify the abuse of the msi_prepare()
> callback.
>
> The only reason why this hack "works" is that there is a historical
> mechanism which tells the PCI/MSI core that the number of requested
> vectors cannot be allocated, but that there would be $N vectors
> possible. But even that return value has no guarantee.
>
> This mechanism is ill defined and really should go away.
>
> Adding yet another way to limit this via msi_prepare() is just
> proliferating this ill defined mechanism and I have zero interest in
> that.
>
> Let's take a step back and look at the larger picture:
>
>  1) A PCI/MSI irqdomain is attached to a PCI bus
>
>  2) The number of PCI devices on that PCI bus is usually known at boot
>     time _before_ the first device driver is probed.
>
>     That's not entirely true for PCI hotplug devices, but that's hardly
>     relevant for an architecture which got designed less than 10 years
>     ago and the architects decided that 256 MSI vectors are good enough
>     for up to 256 CPUs. The concept of per CPU queues was already known
>     at that time, no?
Does this solution depend on the per-device msi domain? Can we do that
if we use the global msi domain?

>
> So the irqdomain can tell the PCI/MSI core the maximum number of vectors
> available for a particular bus, right?
>
> The default, i.e if the irqdomain does not expose that information,
> would be "unlimited", i.e. ULONG_MAX.
OK, thanks, but how to expose? By msi_domain_info::hwsize?

>
> Now take that number and divide it by the number of devices on the bus
> and you get at least a sensible limit which does not immediately cause
> vector exhaustion.
>
> That limit might be suboptimal if there are lots of other devices on
> that bus which just require one or two vectors, but that's something
> which can be optimized via a generic command line option or even a sysfs
> mechanism.
Hmm, if we still use the command line, then we still have some similar
drawbacks.

Huacai
>
> Thanks,
>
>         tglx
>
>
>
>
>
