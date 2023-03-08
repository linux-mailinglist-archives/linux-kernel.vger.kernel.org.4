Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B8F6B07F7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjCHNHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjCHNHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:07:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6809362305;
        Wed,  8 Mar 2023 05:05:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E064961790;
        Wed,  8 Mar 2023 13:04:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E6CC433D2;
        Wed,  8 Mar 2023 13:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678280665;
        bh=B61KN9duhSmmDDVRSNlG6qoXho9YatpKJo8xaLmHhLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SNytLSMNv1lmVBNVt43M4mHgi3FC192BFZfNNLHYiK6TOIf1DLlM8da6l2Jbob8Y6
         XviT03DqIxTAEb2QEM/hNQUREDYNOfQo28N3FnCVlLWpuMwPM0PIs+iqHoHCQjfyes
         R5vlRoUDXEaNV7sfgIGmjchMZupjs6f0KPzBQJhUuyxa4K7tkoqjb1FvYJyrhxNmoo
         tdSoyHQB9sLLpApOH23JrPIyeZavTlUvhGBf0I5QSPopYEP1+RWwCJ+08Duy2N5+RF
         GdeZSH2B5Gm7ftu8i2Yr1Mrs5kYf7NNX/UbKiNC4Qfx3U0a4sLBGUfHKPa6cQ6wYVE
         h6iuaqReNZTEA==
Date:   Wed, 8 Mar 2023 13:04:20 +0000
From:   Lee Jones <lee@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Subject: Re: [PATCH 26/27] mfd: remove MODULE_LICENSE in non-modules
Message-ID: <20230308130420.GH9667@google.com>
References: <20230224150811.80316-1-nick.alcock@oracle.com>
 <20230224150811.80316-27-nick.alcock@oracle.com>
 <20230303105203.GA2420672@google.com>
 <87mt4n5spv.fsf@esperi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mt4n5spv.fsf@esperi.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Mar 2023, Nick Alcock wrote:

> On 3 Mar 2023, Lee Jones verbalised:
>
> > On Fri, 24 Feb 2023, Nick Alcock wrote:
> >
> >> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> >> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> >> are used to identify modules. As a consequence, uses of the macro
> >> in non-modules will cause modprobe to misidentify their containing
> >> object file as a module when it is not (false positives), and modprobe
> >> might succeed rather than failing with a suitable error message.
> >>
> >> So remove it in the files in this commit, none of which can be built as
> >> modules.
> >>
> >> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> >> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> >> Cc: Luis Chamberlain <mcgrof@kernel.org>
> >> Cc: linux-modules@vger.kernel.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> >> Cc: Tony Lindgren <tony@atomide.com>
> >> Cc: Lee Jones <lee@kernel.org>
> >> Cc: linux-omap@vger.kernel.org
> >> ---
> >>  drivers/mfd/omap-usb-host.c | 1 -
> >>  drivers/mfd/omap-usb-tll.c  | 1 -
> >>  drivers/mfd/twl4030-audio.c | 1 -
> >>  drivers/mfd/twl6040.c       | 1 -
> >>  4 files changed, 4 deletions(-)
> >
> > Please adapt the subject line(s) to include the drivers changed.  It might
> > also make sense to separate out changes to cover one driver per patch.
>
> The subject line is automatically generated, and uses whatever
> subsystem prefix was most commonly used for all files touched in that
> subsystem, while not containing any prefixes *not* so touched.
>
> It's also automatically split up per-subsystem from a single big source
> commit that changes everything at once. I can split this bit more
> finely, but that means automated regeneration will be impossible, so
> it'll probably backslide if I ever have to regenerate it -- and I've had
> to regenerate this series a *lot*.
>
> In fact if I'd split this bit per driver, I'd probably have
> automatically got the subject line right as well -- but if the series as
> a whole were split up like that, it'd have had about 400 patches rather
> than 120, and got a lot of maintainers even more annoyed than they are
> now.
>
> For now, I'll split this one into four and mail it out again: coming
> shortly.

If you haven't sent it out already, 2 will be fine.

mfd: omap: ...
mfd: twl: ...

--
Lee Jones [李琼斯]
