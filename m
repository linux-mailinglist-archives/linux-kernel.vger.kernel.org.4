Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F59697FB7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 16:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjBOPlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 10:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBOPlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 10:41:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1E03B0EC;
        Wed, 15 Feb 2023 07:40:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB4ADB82262;
        Wed, 15 Feb 2023 15:40:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B323C4339B;
        Wed, 15 Feb 2023 15:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676475643;
        bh=i9MhporBcJTt5xR2XfZDW6Mp8VsbL9YSV+PBt6/KRFQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u819VcjP9CgKrle8Zoejc8gjGbk6Rtsc4n8dvW47Nn3hTEbbRkvoGOyYUn439+uVU
         B5+vUuA36oIk7V3L9JrBjZjq0n8eaINcDNpFCg+JeSinVmO9n5C17EWs+Pg1AmG22r
         fraaTeZRF9pktxCtUCvN9X9tU9kvsAG9F7Y/C9qA4hqFj31LPYxIL8vhHvLJALBGXZ
         46Z0mqbBmjE/ma2mWLMts13UUDtTGaY0+R30He3EqwRUwj/KjKkT/SsvIlXnNps2gL
         s1P9jMu0weSpOGA4ZwtmcN6obA/hMHxgFte3+Dd6qMrTeFoYy7zqOqffVDurJSVdhl
         RQRTUrRpOaOnw==
Received: by mail-lj1-f171.google.com with SMTP id z37so12518148ljq.8;
        Wed, 15 Feb 2023 07:40:43 -0800 (PST)
X-Gm-Message-State: AO0yUKXm3oAjcOrDSQbMiw+3a7zsGY2W32ujYze8UVDEges62WmquHFJ
        Kck+gp8mKigFGofz6xPCQoYJueYY+lR+9+2Xrvo=
X-Google-Smtp-Source: AK7set+K9ujN/oASal1D74qjSBH58AN1Eqq2yKHtNRiSS8pT2VAt3YGzhssKKcT4fvYa3diWEMMROR24Jo9wsmlkbjg=
X-Received: by 2002:a05:651c:39b:b0:293:4ff3:49ad with SMTP id
 e27-20020a05651c039b00b002934ff349admr692845ljp.2.1676475641650; Wed, 15 Feb
 2023 07:40:41 -0800 (PST)
MIME-Version: 1.0
References: <20230128122904.1345120-1-ardb@kernel.org> <20230215151547.GA3766362@roeck-us.net>
In-Reply-To: <20230215151547.GA3766362@roeck-us.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 15 Feb 2023 16:40:30 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEnoghSNpQFucmSCEhG3s_nyBCm+btgLHzOTiU56=XPfQ@mail.gmail.com>
Message-ID: <CAMj1kXEnoghSNpQFucmSCEhG3s_nyBCm+btgLHzOTiU56=XPfQ@mail.gmail.com>
Subject: Re: [RFC PATCH] MAINTAINERS: Mark Itanium/IA64 as 'dead'
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, Tony Luck <tony.luck@intel.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Matthew Wilcox <willy@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ia64@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2023 at 16:15, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Sat, Jan 28, 2023 at 01:29:04PM +0100, Ard Biesheuvel wrote:
> > Create a new status 'dead' which conveys that a subsystem is
> > unmaintained and scheduled for removal, and developers are free to
> > behave as if it's already gone. Also, automated build tests should
> > ignore such subsystems, or at least notify only those who are known to
> > have an interest in the subsystem in particular.
> >
> > Given that Itanium/IA64 has no maintainer, is no longer supported in
> > QEMU (for boot testing under emulation) and does not seem to have a user
> > base beyond a couple of machines used by distros to churn out packages,
> > let's mark it as dead. This shall mean that any treewide changes (such
> > as changes to the EFI subsystem, which I maintain) can be made even if
> > they might cause build or boot time regressions on IA64 machines. Also,
> > mark the port as scheduled for removal after the next LTS release.
> >
>
> Since this just came up, I very much prefer complete removal. I don't
> see the point of keeping dead code in the tree. That is still hidden
> maintenance effort.
>

Can I take this as an ack on

https://lore.kernel.org/linux-kernel/20230215100008.2565237-1-ardb@kernel.org/

?

> If this proliferates, we'll end up having to parse the MAINTAINERS file
> for code marked "Dead" to ensure that we don't accidentally send e-mails
> to the wrong people, or we risk getting complaints about sending reports
> for such code. That puts extra burden on maintainers of automated test
> beds, which I think is not really appropriate. If the code is dead,
> remove it, period.
>
> For my part, I'll drop my test bed support immediately after this patch
> made it in, following the guidance above.
>

Thanks for the insight. I think we should take the immediate removal route.
