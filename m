Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB4D649215
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 03:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiLKCxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 21:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiLKCxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 21:53:06 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE545CC5
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 18:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t95IFhghx8fFN5Zi4qolRw4rWZiEp2gB10ZI00RADuY=; b=SwJkislYdZvQyeRmItSa9zQZVm
        LLvZpmXnufpnXmaSmqS+SfL2YYPl/tuKnDy9IKuEBkB7bY39dVm0oe9AFil6Bb/ANAfWWTb1hHdcS
        JTn8ThbkY8bR2iV5IHOtdiJfM1llKsy0DoX5vzdSdbZmf88J8u1K0e+n12Ob5+FPRfn1Psosqlkk+
        QqnLvNoDy8DdPuuBRDCRvypCrjMHa6ovaegaokrRsy4W+vaaErJp6LNsn7//Wy9oykytqbh1pKpUv
        fjbsUc/wC3tSNGfHuJNHzIYx7ZC3jGFohcGsCIE12rQ2LwItpdBXWK6pnI3sQTuxRtoGAjLxKjZLo
        c6Iffiug==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1p4CSX-00AwiG-1I;
        Sun, 11 Dec 2022 02:52:57 +0000
Date:   Sun, 11 Dec 2022 02:52:57 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     syzbot <syzbot+919c5a9be8433b8bf201@syzkaller.appspotmail.com>
Cc:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in do_mkdirat
Message-ID: <Y5VGCefLZmrOyd0Z@ZenIV>
References: <20221211002908.2210-1-hdanton@sina.com>
 <00000000000025ff8d05ef842be6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000025ff8d05ef842be6@google.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 10, 2022 at 06:30:22PM -0800, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> WARNING in done_path_create

How many times does it need to be repeated that ANY BUG REPORTS INVOLVING NTFS3 IN
REPRODUCER NEED TO BE CCED TO MAINTAINERS OF NTFS3?

I'm done with any syzbot output.  From now on it's getting triaged
straight to /dev/null here.

*plonk*
