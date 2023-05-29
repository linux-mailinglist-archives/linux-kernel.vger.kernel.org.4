Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFD6714725
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 11:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjE2Jg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 05:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjE2JgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 05:36:24 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD00ED
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 02:36:21 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-514859f3ffbso3577579a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 02:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685352980; x=1687944980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6HhsVWhTLIX/zKXEmQIlcJy3oQM7uNYV5sO+LVhw4A=;
        b=hagvf3S+qJ/o9cf3nFUMZseHrJV8fdDjbuotGVYUG7990EYSJx9ng/qDpiCRJ+k2WI
         MSkX9A2gJ8ksrlMZ4ypj7T/5rMx8i9XWM6kTsqwnUimZBgyWz8ps8ixOyrjc8+Z3YgQg
         BqhGFKsrNriCOxYmVk5L5y3w6Ftkm8xRaAq0AoJeCj2/oqdpW0s07SyHcWZLkcTys32n
         OE2jtblXHmnK0yThMxklhysHFjI4blfNuMMwtTiAWwWgbLcWBr8R9WZskLn+s2dVoqmt
         S35CCE1QeKgmklAyWdYYgxNhaPHDCgbjb+xSEFLSl2z+prUVwUiMY17E2oRnkn88xAMH
         iHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685352980; x=1687944980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6HhsVWhTLIX/zKXEmQIlcJy3oQM7uNYV5sO+LVhw4A=;
        b=XEFfT/UmO5j8VqGFxXullTW0vZSyTjintIm8ndgRr2X/V9VcvdYlNOoNKUDeDZERND
         mGhM94PXEOhysfSN7ukH2IgzJC/DIj0g8zk6J9xaT/WNPGFr+U2N0cnNvaDFViDdXMco
         pDqU1r2HfrfV+yZ/+6tI3xEEHFwDm5wOcgfyx5GD9Nm8xqBPm9h47m9Dj5goqNOpZ2VB
         yuqaHca7MaAddxDOkE8aDOIRt3MELdEv1ev5EAiyYZ78xzVuQ7IvWz5R9CaJ2Ui7SwUH
         5V7GbTSa/uYXgC3vbRU3+Tj9X8KHoKzBZt4VCLbIOaPn+7z3kDE0z6vDHJp7K+LUJ9k4
         mU4w==
X-Gm-Message-State: AC+VfDwk6LCNNxazXrefCuEhFN8QVSFuNSDN8glXNQB5e2QYTRWa7/xe
        I9tTccVUGyMIfRtBivGb9la1UbxG7gsINuUCWPM=
X-Google-Smtp-Source: ACHHUZ6GptyW0y6QW+1Vr7zecgW3c3cm4SlUtSK6ieRTeE06G8VBvQ2BK7rKChjBo34LTrClSi6V+yWw5kF2loQFKQ4=
X-Received: by 2002:a17:906:6a14:b0:962:582d:89d7 with SMTP id
 qw20-20020a1709066a1400b00962582d89d7mr10555695ejc.38.1685352979626; Mon, 29
 May 2023 02:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230527054633.704916-1-chenhuacai@loongson.cn>
 <20230527054633.704916-2-chenhuacai@loongson.cn> <87pm6llvm6.ffs@tglx>
 <86fs7gdhid.wl-maz@kernel.org> <CAAhV-H6KpNhL5VvumvhcAKGOpe-EO0zfzm_xPprP0rTVf18Leg@mail.gmail.com>
 <87ilcblc72.ffs@tglx>
In-Reply-To: <87ilcblc72.ffs@tglx>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Mon, 29 May 2023 17:36:07 +0800
Message-ID: <CAAhV-H41vDyBktE25Fdb34QtZ_yWSgTq4yMOyfD9H7YytKS3RA@mail.gmail.com>
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

On Mon, May 29, 2023 at 5:27=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Sun, May 28 2023 at 20:07, Huacai Chen wrote:
> > On Sun, May 28, 2023 at 3:47=E2=80=AFPM Marc Zyngier <maz@kernel.org> w=
rote:
> >>
> >> Being able to allocate MSIs is not a guarantee, and is always
> >> opportunistic. If some drivers badly fail because the they don't get
> >> the number of MSIs they need, then they need fixing.
> >
> > Yes, I know allocating MSIs is not a guarantee, and most existing
> > drivers will fallback to use legacy irqs when failed. However, as I
> > replied in an early mail, we want to do some proactive throttling in
> > the loongson-pch-msi irqchip driver, rather than consume msi vectors
> > aggressively. For example, if we have two NICs, we want both of them
> > to get 32 msi vectors; not one exhaust all available vectors, and the
> > other fallback to use legacy irq.
>
> By default you allow up to 256 interrupts to be allocated, right? So to
> prevent vector exhaustion, the admin needs to reboot the machine and set
> a command line parameter to limit this, right? As that parameter is not
> documented the admin is going to dice a number. That's impractical and
> just a horrible bandaid.
OK, I think I should update the documents in the new version.

Huacai
>
> Thanks,
>
>         tglx
>
>
