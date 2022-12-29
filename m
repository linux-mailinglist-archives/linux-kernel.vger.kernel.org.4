Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C71659218
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 22:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbiL2VRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 16:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbiL2VRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 16:17:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFFCBC27
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 13:17:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 560DE61952
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 21:17:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B55C433EF;
        Thu, 29 Dec 2022 21:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672348653;
        bh=8YwBWtfqcOw4/5Y6SIJxdp8hYh7IWiKRN6E9DHu2hrM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HadDJu1Zd+e49LAgjD4XT6bNUv+QecEPdJKJPmNmdmIVEkpy4t2x2IbW0pFs3fQ43
         XDO1vWU29wr5sC4srzTTYEC8tpwarBsyeD93hrECxSt7IC6Nk8o2boiFooP7KTAN9Q
         u6td1vy4ttkhb0W9wOhkGiBdTgFzCaVFerBO7CzxeiiCd2URvwYI/ydDN2iSirZsGN
         dNu8LvB3anx7JHiqX0BkLNq5nnWNlR43SeHbJp8Ey6scurTzTkEcvUPcHnwIW8wpsz
         AKWksVtvulP1Bu4EG17AjF4AgaWPK52p473pDE7JIYqINpO6celvBMdrQQHxLY41fY
         Gnu11U4eFgYWA==
Date:   Thu, 29 Dec 2022 13:17:31 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Marco Elver <elver@google.com>,
        Theodore Ts'o <tytso@mit.edu>, Hillf Danton <hdanton@sina.com>,
        Matthew Wilcox <willy@infradead.org>,
        syzbot <syzbot+919c5a9be8433b8bf201@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in do_mkdirat
Message-ID: <Y64D69VTnJEQuHwT@sol.localdomain>
References: <20221211002908.2210-1-hdanton@sina.com>
 <00000000000025ff8d05ef842be6@google.com>
 <20221211075612.2486-1-hdanton@sina.com>
 <20221211102208.2600-1-hdanton@sina.com>
 <20221212032911.2965-1-hdanton@sina.com>
 <Y5d565XVsinbNNL2@mit.edu>
 <CANpmjNNCQEXpJt1PQptyr8mrBbhWpToCRfvUT+RXmw5EA5EwVw@mail.gmail.com>
 <Y5fY6BRTB9OfwFU0@ZenIV>
 <CANp29Y4x8zoXW0z-HarX3xZ6o8OHzWnGyHw8+JGsbLJKDWUgGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANp29Y4x8zoXW0z-HarX3xZ6o8OHzWnGyHw8+JGsbLJKDWUgGA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 04:48:34PM +0100, 'Aleksandr Nogikh' via syzkaller-bugs wrote:
> 
> Thanks for the feedback, and we regret the inconvenience this may have caused.
> 
> We've deployed a simple short term solution to the immediate issue:
> syzbot will extract the involved filesystems from reproducers and use
> this information to construct the email subject line and Cc the
> related people/mailing lists. This should take effect starting next
> week.
> 
> That being said, in response to the original feedback we have already
> been planning comprehensive improvements to the subsystem selection
> process that will support more than just filesystems. But
> unfortunately, this is going to take longer to become available.
> 

Thanks Aleksandr.  From what I can see, the fix is working for new filesystem
bugs: the filesystem(s) involved get added to the title and the recipients.

One question: what happens to all the open bugs, like this one ("WARNING in
do_mkdirat") that were reported before the syzbot fix?  Are they going to be
re-reported correctly?  Perhaps any bug whose reproducer includes
"syz_mount_image" and was reported before the date of this fix should be
invalidated more aggressively than usual, so that it can be re-reported?

- Eric
