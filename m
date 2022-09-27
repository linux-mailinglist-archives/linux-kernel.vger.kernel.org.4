Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0255EC8C2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbiI0P4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiI0P4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:56:30 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D1379ED6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:56:00 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id 3so6286918qka.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=6/fNwUZTk6ef7XasN0kmfa44jw+IlnUA/jmMgGdEMSE=;
        b=D12f0zROjnqvNnWmRi0rI9ImkEfp41uIlczqI2LG/6Y4UgltIAqF9hRWoEjF43k34D
         v0AB2D1XHot7Hl3t7y8WOf9Wo7WEx9RE9RHvmADxUiAGTJtEgh1sX8lKHKTgXItY1z5n
         qkZFzRO27WrI4XgPtwqEAUNrEuflfBfi9CnJigTbWmAl0q17pcWsMa5NzQ7FvSyWrz9t
         Aq8ybrykoOhHy4D+0OoR/gFpNdVOrI/xArPGh5XuEB1fiRsB5Z9vFZDKcGMYm8dbk5/r
         ahysNnAGwIhqGSy+8XYRzWhYAXNT2kb6vx79tK91ID5MohCnrpFyiSJCul/t7FQ1Fw3T
         KWnA==
X-Gm-Message-State: ACrzQf3+dViWlyz+VP6o+N3YT/TCDEKoDvfeS4GXAMH+GCdTp2e4wNT3
        sMyCDzepNl3yoWvZ+HJ3jqYCpGl8KiGOqQ==
X-Google-Smtp-Source: AMsMyM49rMDFwfNXmMRYsylYe0ILhEhRha7CzIGA5jY146c9by102NIURF5PBa56Kl9ovJbb4pHDLg==
X-Received: by 2002:a05:620a:248f:b0:6ce:a3c7:abfb with SMTP id i15-20020a05620a248f00b006cea3c7abfbmr18336593qkn.112.1664294159362;
        Tue, 27 Sep 2022 08:55:59 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id z80-20020a376553000000b006b953a7929csm1197362qkb.73.2022.09.27.08.55.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 08:55:58 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-345528ceb87so104567697b3.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:55:58 -0700 (PDT)
X-Received: by 2002:a81:1691:0:b0:345:17df:4fc6 with SMTP id
 139-20020a811691000000b0034517df4fc6mr25239963yww.502.1664294157901; Tue, 27
 Sep 2022 08:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <b0981cb5a97452af73b9dd0dd0eb03c5002f7af4.1664285626.git.geert+renesas@glider.be>
 <fe2b1f48-e18a-b1d9-0c62-ddddf9e6515f@arm.com> <CAMuHMdVFAwqVtrRFf-_jSODWeJuGAzbpoyk65HDOqj9h6AUt2A@mail.gmail.com>
 <9db42ab0-da49-95fd-3fea-eb505af0867e@arm.com> <CAMuHMdW1KQ5TTftYuTT4_b6mmCT5Y+_jpSKau46-g8siDKWjGQ@mail.gmail.com>
 <76a84590-995a-f958-0135-a344762bffe1@arm.com>
In-Reply-To: <76a84590-995a-f958-0135-a344762bffe1@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Sep 2022 17:55:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV-MbjyoyVM4_aAYs18L4i+2XbeQvRoMChzvsapX+1TKQ@mail.gmail.com>
Message-ID: <CAMuHMdV-MbjyoyVM4_aAYs18L4i+2XbeQvRoMChzvsapX+1TKQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/io-pgtable: Make IOMMU_IO_PGTABLE_DART invisible
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>,
        Hector Martin <marcan@marcan.st>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Tue, Sep 27, 2022 at 5:50 PM Robin Murphy <robin.murphy@arm.com> wrote:
> On 2022-09-27 16:29, Geert Uytterhoeven wrote:
> > On Tue, Sep 27, 2022 at 5:09 PM Robin Murphy <robin.murphy@arm.com> wrote:
> >> On 2022-09-27 15:48, Geert Uytterhoeven wrote:
> >>> On Tue, Sep 27, 2022 at 4:15 PM Robin Murphy <robin.murphy@arm.com> wrote:
> >>>> On 2022-09-27 14:36, Geert Uytterhoeven wrote:
> >>>>> There is no point in asking the user about both "Apple DART Formats" and
> >>>>> "Apple DART IOMMU Support", as the former is useless without the latter,
> >>>>> and the latter auto-selects the former.
> >>>>>
> >>>>> Fixes: 745ef1092bcfcf3b ("iommu/io-pgtable: Move Apple DART support to its own file")
> >>>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >>>>> ---
> >>>>> Should IOMMU_IO_PGTABLE_LPAE and IOMMU_IO_PGTABLE_ARMV7S be made
> >>>>> invisible, too?
> >>>>> Are there users that do not select them?
> >>>>
> >>>> The aim was for formats to be independently selectable for COMPILE_TEST
> >>>> coverage. The Arm formats are manually selectable for the sake of their
> >>>> runtime self-tests, which are self-contained, but since DART format
> >>>> doesn't do anything by itself I'd agree there's no need to prompt when
> >>>> !COMPILE_TEST here.
> >>>
> >>> IOMMU_IO_PGTABLE_LPAE and IOMMU_IO_PGTABLE_ARMV7S are
> >>> selected by other symbols that can be enabled when compile-testing, so
> >>> the tests can still be enabled in those cases, too
> >>
> >> Sure, but when you want to compile-test a thing, what would you rather
> >> do: enable the thing, or go hunting to find some other thing that
> >> happens to select the thing you actually want, then potentially have to
> >> figure out *that* thing's dependencies, and so on?
> >
> > Agreed.
> >
> >> Coverage isn't solely about whether it's technically possible to ever
> >> reach somewhere at all, it's just as much about how easily and/or often
> >> you can get there in practice. I don't see who benefits from making
> >> COMPILE_TEST harder to use :/
> >
> > So perhaps the visibility of IOMMU_IO_PGTABLE_LPAE and
> > IOMMU_IO_PGTABLE_ARMV7S should depend on COMPILE_TEST?
> > Normal users would still get it through select when needed.
>
> As I say those still offer functionality beyond compile-testing, but now
> you've got me suspecting that it's already suboptimal that one has to
> enable the format to make the self-test option appear... Perhaps what we

IMHO that's the only sensible thing to do: you want to have the option
to enable (preferably modular) tests for the functionality you have
enabled in your product, so you can run the tests when needed.

> want is a separate master option to enable io-pgtable self-tests in
> general, then rejig the rest around that.

IMHO you do not want a master test option that suddenly enables
lots of functionality you do not need in your product.

> Of course the self-tests would be even more useful if the harness was at
> the level of the core io-pgtable API so it could cover new formats
> automatically as long as they provide the configuration parameters, but
> that's a separate matter for someone with sufficient free time and
> enthusiasm :)

OK, I will shut up ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
