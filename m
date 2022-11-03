Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B573D618CC7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 00:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiKCXcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 19:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiKCXcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 19:32:06 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016611F601;
        Thu,  3 Nov 2022 16:32:05 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e72b329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e72b:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8BD561EC04E2;
        Fri,  4 Nov 2022 00:32:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667518323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=eVWe2dv0SREgTL0EatF2jCJmMTOM/UpbhdkTrzmlVEE=;
        b=CzItbvwL6ts3qGFTw2UTW8TnFYrTv4FduqBZaxs7lqIYrAe9hPRnopXl39HovJa1VvLOmD
        QM6eU+EKhB8OZFw2RM6g369rOUSZarnToyR/f1AwDyHXgeO3O0QH5i7bT9XEoFcnykamCj
        71L2ciDo0mbh69pu/fbucmiMGz+4SZw=
Date:   Fri, 4 Nov 2022 00:32:03 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Jithu Joseph <jithu.joseph@intel.com>, hdegoede@redhat.com,
        markgross@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com
Subject: Re: [PATCH 07/14] x86/microcode/intel: Expose
 microcode_sanity_check()
Message-ID: <Y2RPc7T0PCUubcjB@zn.tnic>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221021203413.1220137-8-jithu.joseph@intel.com>
 <Y2OnHuSHgIMGxcUH@zn.tnic>
 <Y2QVrEGkfvpT/2KB@a4bf019067fa.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2QVrEGkfvpT/2KB@a4bf019067fa.jf.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 12:25:32PM -0700, Ashok Raj wrote:
> CPU microcode has stayed the same for over 15 years roughly. Changing
> formats isn't something that's done lightly especially since there is cost
> of enabling in all OS's. 

Yeah, because it has been that way for the last 15 years and that means
it'll not change in the future either. Yeah, right.

> Even if its only a few hundred lines of code, it seems odd to simply
> duplicate for the sake of fear of testing.

I don't think I ever said "fear" but rather that it would be real hard
to test. But it's not like you're reading my mails properly.

But don't worry about it. We'll change the microcode loader and if we
break the IFS thing in the process, then, oh well, sh*t happens.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
