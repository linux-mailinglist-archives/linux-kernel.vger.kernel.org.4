Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC6C67E7D3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbjA0OLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbjA0OK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:10:58 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D284F7D9BD
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 06:10:40 -0800 (PST)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AB33B3F1E9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1674828638;
        bh=oZN9ZgvVoZFD5cH0pJuh6IBZpyTqF0BSG7O/j2ykq4o=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=dcsPjG2PhpsdVExggm/0Xpu4uk0M/Wt2B/oMKxOSI+aOGWh7j6VpEzlN8d/XkriIM
         RfX6/2G7V7AVkqOliDkF8dux8F107lYa1ZNl05DF4RJtIs2k+MvApm4OlsVy/RWSIm
         mRqibnfxAd2yrRn1hGQIfoaVoKfQZldD+qqqCCbULbuAlD0uEeYug6f64KWTAy12Nq
         Vse4Hj4HIu5DQl0sqblQ+szgNj1Enf2r8zLUbN50llKyQ1sje5kp94qYIYi4lWa7f/
         QmWo6462Fog4Rh821KRJBDbFs6ShCBa0xp230KuKSH8Y/cZeCxXE8li0Kw6tQzifSJ
         XiNNsEZuS1Qpw==
Received: by mail-wm1-f71.google.com with SMTP id h9-20020a1ccc09000000b003db1c488826so4729498wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 06:10:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZN9ZgvVoZFD5cH0pJuh6IBZpyTqF0BSG7O/j2ykq4o=;
        b=MV9Pu/cXHmjAQKSGg9QwmbtHWMWsBTMSUy4xskabOG+xkMPVa6Lgh0+f+9Pw+uk5SQ
         xPLNYJ5muuKxPdOz+7tIpeuEgaV1G9aH0xAJslJ17Rd8OR2ea4vLaPOeKZv0uj+2er3d
         aMZEtWmCTln9iJrUrRLNUxq2uZF6JZQQEkaUcJ+g/cO5zjyhNtcVzQTYKPowyewPoxgo
         Vbh2pgtJewqcOjzGao304mX0Jw1AKk471Ct8f6jNsCakB7xhZ3waTwv9X3jn9zTb2sMf
         XoqYUsOUgnbqKwWQGrGUCAfcUNgIrYA9pqoW4cXAwRGC8e1h2dLiqMC67rM7pCooZgal
         2j4w==
X-Gm-Message-State: AFqh2kqfj4ftSNJiOhDHioYUNx20sx0epN/KSsNNVOv+WDuDai0O8ZFL
        5Qee0gfJarU+JPbo0S1EJ76K13zIcWIzLpIebBgJmmT/Ip2xYtEl7FjLmKMXdjiB5K4VYduhQnz
        wTrcBzOBJ7j/JSh44wUpu2jOBJjlDOXZ3cEyyOWrcYg==
X-Received: by 2002:a5d:6e08:0:b0:2be:493d:1384 with SMTP id h8-20020a5d6e08000000b002be493d1384mr24246112wrz.22.1674828637791;
        Fri, 27 Jan 2023 06:10:37 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsXH+cOMzFUup27auMjUGxsJO9RSPYKSE+c7FGLX/KkpEARW9yOBWrq17aboos/PD+urHQSJA==
X-Received: by 2002:a5d:6e08:0:b0:2be:493d:1384 with SMTP id h8-20020a5d6e08000000b002be493d1384mr24246095wrz.22.1674828637612;
        Fri, 27 Jan 2023 06:10:37 -0800 (PST)
Received: from qwirkle ([81.2.157.149])
        by smtp.gmail.com with ESMTPSA id a4-20020adffb84000000b002bc7f64efa3sm3999120wrr.29.2023.01.27.06.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 06:10:37 -0800 (PST)
Date:   Fri, 27 Jan 2023 14:10:35 +0000
From:   Andrei Gherzan <andrei.gherzan@canonical.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Hangbin Liu <liuhangbin@gmail.com>
Subject: Re: [PATCH v2 1/2] selftests: net: Fix missing nat6to4.o when
 running udpgro_frglist.sh
Message-ID: <Y9PbW7UpCJjPWtUt@qwirkle>
References: <20230125211350.113855-1-andrei.gherzan@canonical.com>
 <20230125230843.6ea157b1@kernel.org>
 <Y9JPiA11CHNOMibr@qwirkle>
 <20230126153621.7503a73e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126153621.7503a73e@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/26 03:36PM, Jakub Kicinski wrote:
> On Thu, 26 Jan 2023 10:01:44 +0000 Andrei Gherzan wrote:
> > On 23/01/25 11:08PM, Jakub Kicinski wrote:
> > > On Wed, 25 Jan 2023 21:13:49 +0000 Andrei Gherzan wrote:  
> > > > The udpgro_frglist.sh uses nat6to4.o which is tested for existence in
> > > > bpf/nat6to4.o (relative to the script). This is where the object is
> > > > compiled. Even so, the script attempts to use it as part of tc with a
> > > > different path (../bpf/nat6to4.o). As a consequence, this fails the script:  
> > > 
> > > Is this a recent regression? Can you add a Fixes tag?  
> > 
> > This issue seems to be included from the beginning (edae34a3ed92). I can't say
> > why this was not seen before upstream but on our side, this test was disabled
> > internally due to lack of CC support in BPF programs. This was fixed in the
> > meanwhile in 837a3d66d698 (selftests: net: Add cross-compilation support for
> > BPF programs) and we found this issue while trying to reenable the test.
> > 
> > So if you think that is reasonable, I could add a Fixes tag for the initial 
> > script commit edae34a3ed92 (selftests net: add UDP GRO fraglist + bpf
> > self-tests) and push a v3.
> 
> We have queued commit 3c107f36db06 ("selftests/net: mv bpf/nat6to4.c 
> to net folder") in net-next, I think that should fix it, too?

That would fix it indeed. Thanks for the pointer.

> 
> > > What tree did you base this patch on? Doesn't seem to apply  
> > 
> > The patches were done on top of
> > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git, the master
> > branch - 948ef7bb70c4 (Merge tag 'modules-6.2-rc6' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux). There is another
> > merge that happened in the meanwhile but the rebase works without issues. I can
> > send a rebased v3 if needed.
> 
> Could you try linux-next or net-next ?

I have sent a v3 rebased on linux-next, split out the remaining changes
and added a commit to fix some shellcheck warnings/errors.

-- 
Andrei Gherzan
