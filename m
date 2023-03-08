Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41776B0B43
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjCHOcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjCHOb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:31:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEF557D27;
        Wed,  8 Mar 2023 06:31:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA5B7B81CB2;
        Wed,  8 Mar 2023 14:31:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F82C4339C;
        Wed,  8 Mar 2023 14:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678285902;
        bh=KmoZ6Oyoq0qko8GaFGadIcTrYdCyseD9sb6zK+Fa+9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mz4+YssctZc6K2X6dmUb+6eMFGD3lvEpoh2uluwtsV9phXewDFx142HYKcBXrW9YV
         qBcucQzLL9zRc1UoxmHJPiP5u8BCep+j0Y37Ijkc8Z8n0nzDc0/FQBws8WmqCqKtG9
         YutgAKyiyslxPAmysfYKTb9lsWkpb73kg28JC8Oy/0O+ZAaP+U9g9Xrs4SyWjGqN0N
         NLmuOIPHHgDVFYlAooUp29CGLydwz+SBfwt8q2S2Nd+GEXOe2EI15ZpOYq7M5IyEIS
         gyOBVjmJrUx+K1pj9s6ht8KSIy3vI8Vst2eBDWmQEPyaaTWPYoaz9PnfZClBxm8TrZ
         yDHLll0vYhGYw==
Date:   Wed, 8 Mar 2023 14:31:37 +0000
From:   Lee Jones <lee@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Subject: Re: [PATCH 26/27] mfd: remove MODULE_LICENSE in non-modules
Message-ID: <20230308143137.GQ9667@google.com>
References: <20230224150811.80316-1-nick.alcock@oracle.com>
 <20230224150811.80316-27-nick.alcock@oracle.com>
 <20230303105203.GA2420672@google.com>
 <87mt4n5spv.fsf@esperi.org.uk>
 <20230308130420.GH9667@google.com>
 <87bkl35r2t.fsf@esperi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bkl35r2t.fsf@esperi.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Mar 2023, Nick Alcock wrote:

> On 8 Mar 2023, Lee Jones uttered the following:
>
> > On Wed, 08 Mar 2023, Nick Alcock wrote:
> >
> >> >>  drivers/mfd/omap-usb-host.c | 1 -
> >> >>  drivers/mfd/omap-usb-tll.c  | 1 -
> >> >>  drivers/mfd/twl4030-audio.c | 1 -
> >> >>  drivers/mfd/twl6040.c       | 1 -
> >> >>  4 files changed, 4 deletions(-)
> [...]
> >> For now, I'll split this one into four and mail it out again: coming
> >> shortly.
> >
> > If you haven't sent it out already, 2 will be fine.
> >
> > mfd: omap: ...
> > mfd: twl: ...
>
> I'm trying to automate this whole thing (since I've had to resplit it a
> dozen times already), and even making mfd a special case that wants
> splitting finer than by subsystem, I honestly have no idea how to
> automatically determine a split like *that*. I can't split on file, on
> subsystem, on dashes in the names... I think I'd have to literally parse
> the makefile to figure out which things belonged together in commits,
> and that's getting ridiculous even for me.
>
> So, if you don't mind, I'd rather do it by subsystem or by file :)

File is fine.

--
Lee Jones [李琼斯]
