Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A222A73859C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbjFUNrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjFUNrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:47:00 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99361981
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:46:58 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2586E1EC0102;
        Wed, 21 Jun 2023 15:46:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687355217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LQOl8EAvZf2t7v8QGzZNCmzghAFI3inwdZcRnjQh6G8=;
        b=UE14miEpQ4XPeDvm9F39bMveLpk8Klz0wYLtFd6rBHGQdsNpUiRYF/tkXjCunD9AjIPK9w
        6OXrsSv5TRB43SEsN/3TSQ6YtLo6q/5J6VVYG1aMIWCaz2Byokhq66MObEZbqMIm0en3B4
        9IuHX+TJ3I6Rf/juLEFaU4BV79IW7YY=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4vGi0cOYMiPG; Wed, 21 Jun 2023 13:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687355214; bh=LQOl8EAvZf2t7v8QGzZNCmzghAFI3inwdZcRnjQh6G8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EoYx2ImmiwReU3QRsZnMaGuXF+JmIOpBZuEZ8X19rp+oaRnifScV7l4abMfyyX9uA
         qsYUMuvytP7AORy4asJvIqjQhbbKlhVELDYej6dwXDwVwXidYdDCFT4mf4eEwLGqdq
         0lAj8YEkWJ09v3jDQNxwB+RrHH5pZyKFr7Awu1+Kfj4Z+x+4elshJMtyEzdEnnngAk
         yU5iNm7Ozjfee6TWDxruxTGdXsRrTnLFtIALTDIjNVyBzDRR2xetM4UahOBcfZdqeW
         avMZ+EtXY0Tarsq7f07c+5aBTEJ4y+eI9KJJtvoBS059Nj/75N69B/nG5UNDLRKws7
         Pxdk2R6I45PXVl5we62msYWMLfcN1aWTnAqWFus90Q9DlnZ1FFliFKJziUHj5SKv0F
         0OotfICxUnJdudwn47wEBXQpA2k3pXj+WlkTKD2T/tZGXvYJ9+MbU9S3FJl6ZgG7dA
         ZMjKXkQ3e/2katfTb038XT0DQK5cMkB8WwP5TIfVEjc/5pll6sAPUPuOIDhcUliX9+
         jXM5/FPpATVMLelgtzBYl9KhfyfX58cwNF6hyopzsz8BfC/IblceiPZuayHhaFrorC
         RdMRORnV/CiJWmPicQXlwBBmK3QjF7Pc36+eJqOxlcudEHuoCgWsA6cR8xeWCEqli9
         Lc7kbhANNS57im3VgwpsjmUQ=
Received: from zn.tnic (p200300ea971dc565329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c565:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0219040E0145;
        Wed, 21 Jun 2023 13:46:49 +0000 (UTC)
Date:   Wed, 21 Jun 2023 15:46:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: A question about prefetchw detection in "x86/asm: Cleanup
 prefetch primitives"
Message-ID: <20230621134645.GIZJL/Rf1IdeLMQGl2@fat_crate.local>
References: <0b663d8f6802e8dbf443397718234bcb6d0811c8.camel@xry111.site>
 <20230621111346.GFZJLbavDw1JiLi34n@fat_crate.local>
 <a155ebb791d3aefce5db32658e3c519a1cfac1f6.camel@xry111.site>
 <e76180a1b82d1c29715587e94e2d6923b64bb893.camel@xry111.site>
 <20230621125749.GGZJLzzUw0rA3goV1X@fat_crate.local>
 <b50735128c5a985634468d63fef092f093f0aebc.camel@xry111.site>
 <20230621130955.GHZJL2o771lIEPURUl@fat_crate.local>
 <29beee7faf370ea892cb4e5a85ddd1f7ee132164.camel@xry111.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <29beee7faf370ea892cb4e5a85ddd1f7ee132164.camel@xry111.site>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 09:19:34PM +0800, Xi Ruoyao wrote:
> On Wed, 2023-06-21 at 15:09 +0200, Borislav Petkov wrote:
> > On Wed, Jun 21, 2023 at 09:06:51PM +0800, Xi Ruoyao wrote:
> > > I think it's not an issue in the kernel itself, but announcing
> > > 3dnowprefetch in /proc/cpuinfo for an old Intel CPU w/o real prefetchw
> > > implementation seems problematic (to me).
> > 
> > And this is a problem because?
> 
> If a code generator parses /proc/cpuinfo for CPU capabilities, it may
> generates a no-op prefetchw instead of prefetcht0 as a fallback.

Err, go back.

That code snippet you pasted, did you see where that comes from?

A function called init_amd().

Now, is Intel hardware and SDM PREFETCHW text at all relevant here?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
