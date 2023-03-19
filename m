Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9506C034F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 17:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjCSQwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 12:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjCSQwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 12:52:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23689EEA;
        Sun, 19 Mar 2023 09:52:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78018B80C88;
        Sun, 19 Mar 2023 16:52:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09386C433D2;
        Sun, 19 Mar 2023 16:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679244720;
        bh=jyYS3GJ/aW+lYyizBjOxRkQkb6yrUyO89tl2RA9/JlY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HeeVkxFDGXC7Wn9Q5k+tqRo6+JO85Y4mlVURyf8GOp51/iIyVsFWa59Tuc2kaq0PG
         eCWG5VCnBIJbxTZmoyxPs9/lOAXhRF59S64xYCl4smaAVtb60sSJTOIsL65V0SZLgK
         7CG2pyLFFCVRLwQyC6L12Ie60H284jBFgtWmmLNvDPl4IF79GXCLPmoj+ByLkrAMyk
         1j2eMb3zkIU2HLw9iqckEVgvpEnkXf+ewrf465nrX9k/HDo4nv/SOuS+CiYFidwY0l
         L43kmXbyD3ItWNbE0bedW+EQ6VtbPPfgvFSqUeIAMId/aQSEEcFLYkjgrM836nanJ/
         fgvfLUZIIxr8g==
Received: by pali.im (Postfix)
        id 4F3F9622; Sun, 19 Mar 2023 17:51:57 +0100 (CET)
Date:   Sun, 19 Mar 2023 17:51:57 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Steffen <wiesenbergsteffen+lxkernel@gmail.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lanelone@gmail.com
Subject: Re: [regression] Bug 217182 - Dell Latitude E7450 Trackpoint not
 working as expected
Message-ID: <20230319165157.xyaxo3wlziqrjurx@pali>
References: <6625ee0a-31a7-9fef-d299-457c0f98f5a0@leemhuis.info>
 <b7de0060-8555-65f7-c687-1326a5762929@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7de0060-8555-65f7-c687-1326a5762929@leemhuis.info>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 March 2023 10:50:46 Thorsten Leemhuis wrote:
> On 13.03.23 11:20, Linux regression tracking (Thorsten Leemhuis) wrote:
> > 
> > Hi, Thorsten here, the Linux kernel's regression tracker.
> > 
> > I noticed a regression report in bugzilla.kernel.org. As many (most?)
> > kernel developer don't keep an eye on it, I decided to forward it by
> > mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217182 :
> > 
> >>  Steffen 2023-03-12 11:17:02 UTC
> >>
> >> Hi,
> >> I'm new to this bug tracking system and just a user, not a developer.
> >>
> >> I use a Dell Latitude E7450 running with the Debian unstable based
> >> distribution Siduction.
> >> After upgrading to Linux kernel 6.2.x the Trackpoint does not work
> >> anymore as expected. It uses an Alps PS/2 DualPoint Stick.
> >> Even slight touches in any direction send the cursor to the top right
> >> corner of the screen where it stays regardless of actual pointer
> >> movement. This also appears in console mode. One can retrieve the
> >> pointer again with the touchpad, but I'm more precise with the
> >> Trackpoint and prefer using that.
> >> The Trackpoint works well in kernel 6.1.14
> >> Can somebody help?
> > 
> > See the ticket for more details.
> 
> FWIW, another user reported seeing the same problem on a different machine:
> 
> ```
>  Radek 2023-03-14 08:00:31 UTC
> 
> I am experiencing the same issue with kernel >6.2.x on Toshiba Z30
> with Alps PS/2 DualPoint trackpoint / touchpad. The cursor jumps top
> right even with the lowest sensitivity settings. It works just fine
> with 6.1 or lower.
> ```
> 
> Pali, or anybody else: anyone any idea what's might be wrong there?
> There afaics is only one recent commit to the alps driver (292a089d78d3
> ("treewide: Convert del_timer*() to timer_shutdown*()")); it it maybe
> worth trying to revert it?
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.

Could you try following patch?
https://lore.kernel.org/linux-input/20230318144206.14309-1-msizanoen@qtmlabs.xyz/
