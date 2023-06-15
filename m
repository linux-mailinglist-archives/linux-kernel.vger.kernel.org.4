Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499C97319CE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343936AbjFONVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343910AbjFONVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:21:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5567F270A;
        Thu, 15 Jun 2023 06:21:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F03FC1FE25;
        Thu, 15 Jun 2023 13:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686835269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TrVNR5YBg7mfkrE02t70Ms3cyqfx5tB2TFuYK+7EJkI=;
        b=x/BdWHOHkWe2WasV/pUvs6obH6QCcDJL6X4sZDdDzsGJKh2/QN5RP6/uKkrzcdxOfmGx6G
        ZAkzuMFtKPlPuSMKANhspyGgv80chC6Ev7l+XKI6XkB0zI/872e1MTOJdpiut6a+xBa57H
        494DAKP8zoffySmOZZw3ByypJtZqviY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686835269;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TrVNR5YBg7mfkrE02t70Ms3cyqfx5tB2TFuYK+7EJkI=;
        b=+xll9ijtwX96g7AzQiIdJfrQ3zYgYisepLW5uvPXb0b3Xqsa3KMdadP8uVU1OHh9Nrhjho
        X5Mrj6byHVxCJtAQ==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 279FF2C141;
        Thu, 15 Jun 2023 13:21:09 +0000 (UTC)
Date:   Thu, 15 Jun 2023 15:21:07 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Salvatore Bonaccorso <carnil@debian.org>,
        Cyril Brulebois <cyril@debamax.com>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] fbdev/offb: Update expected device name
Message-ID: <20230615132107.GA9196@kitsune.suse.cz>
References: <20230412095509.2196162-1-cyril@debamax.com>
 <20230412095509.2196162-2-cyril@debamax.com>
 <ZDvrY7X9mpJ7WZ3z@eldamar.lan>
 <11b342dc-1a46-d1be-5fdd-c6eee661e15a@leemhuis.info>
 <fe3b90b0-b52f-9677-0245-a201975c3e0c@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe3b90b0-b52f-9677-0245-a201975c3e0c@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Jun 15, 2023 at 03:06:28PM +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 15.06.23 um 15:03 schrieb Linux regression tracking (Thorsten Leemhuis):
> > On 16.04.23 14:34, Salvatore Bonaccorso wrote:
> > > 
> > > On Wed, Apr 12, 2023 at 11:55:08AM +0200, Cyril Brulebois wrote:
> > > > Since commit 241d2fb56a18 ("of: Make OF framebuffer device names unique"),
> > > > as spotted by Frédéric Bonnard, the historical "of-display" device is
> > > > gone: the updated logic creates "of-display.0" instead, then as many
> > > > "of-display.N" as required.
> > > > 
> > > > This means that offb no longer finds the expected device, which prevents
> > > > the Debian Installer from setting up its interface, at least on ppc64el.
> > > > 
> > > > It might be better to iterate on all possible nodes, but updating the
> > > > hardcoded device from "of-display" to "of-display.0" is confirmed to fix
> > > > the Debian Installer at the very least.

At the time this was proposed it was said that "of-display", is wrong,
and that "of-display.0" must be used for the first device instead, and
if something breaks an alias can be provided.

So how does one provide an alias so that offb can find "of-display.0" as
"of-display"?

Thanks

Michal

> > > [...]
> > > #regzbot ^introduced 241d2fb56a18
> > > #regzbot title: Open Firmware framebuffer cannot find of-display
> > > #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=217328
> > > #regzbot link: https://lore.kernel.org/all/20230412095509.2196162-1-cyril@debamax.com/T/#m34493480243a2cad2ae359abfd9db5e755f41add
> > > #regzbot link: https://bugs.debian.org/1033058
> > 
> > No reply to my status inquiry[1] a few weeks ago, so I have to assume
> > nobody cares anymore. If somebody still cares, holler!
> 
> I'd take a look if anyone can point me to an example of Geert's proposal.
> 
> Best regards
> Thomas
> 
> > 
> > #regzbot inconclusive: no answer to a status inquiry
> > #regzbot ignore-activity
> > 
> > [1]
> > https://lore.kernel.org/lkml/d1aee7d3-05f6-0920-b8e1-4ed5cf3f9f70@leemhuis.info/
> > 
> > Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> > --
> > Everything you wanna know about Linux kernel regression tracking:
> > https://linux-regtracking.leemhuis.info/about/#tldr
> > If I did something stupid, please tell me, as explained on that page.
> 
> -- 
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstrasse 146, 90461 Nuernberg, Germany
> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> HRB 36809 (AG Nuernberg)



