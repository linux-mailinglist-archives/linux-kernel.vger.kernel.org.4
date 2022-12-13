Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9056464AE4B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 04:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiLMDgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 22:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbiLMDgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 22:36:37 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7731B7B5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 19:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LK5H+YkxoD3TJEyhmLP43hl5OtRfjO3MXQ8m3C86zoc=; b=jISCmkT1qjr6vdezqb6MH0Bypw
        m8iOfns3z8ofAveFQR6SrqVWADLXXXtO/AjA5DXhWAmlrF6tjQmojclbCJdPYgZV793RN6t+OHSOa
        tz+21Qmaff9j29xYMjhuHeRAhpwUJHLBxqKEYfIcXCsIKO6piMf5rREcMK0mvjDOgeClg/BVJiLCy
        rv1JdAgjlr+dzlh+Ng0op0dNce0RQNWcTCWE0Y+zAOgjvLAHYWyIFLh8hzPSqYoAYdZT2AcOQBXX+
        ffIpDU36ey2AYrmi61dEyEoof5ZPrE1ZcoJgP6W+JWnrL3LKkbA4UQi/uHlSfMK9TZPCuAHaKPvwK
        cgrluqjg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1p4w5f-00BW8m-0R;
        Tue, 13 Dec 2022 03:36:23 +0000
Date:   Tue, 13 Dec 2022 03:36:23 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        syzbot <syzbot+919c5a9be8433b8bf201@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in do_mkdirat
Message-ID: <Y5fzN9ZWgXFyT+fU@ZenIV>
References: <20221211002908.2210-1-hdanton@sina.com>
 <00000000000025ff8d05ef842be6@google.com>
 <20221211075612.2486-1-hdanton@sina.com>
 <20221211102208.2600-1-hdanton@sina.com>
 <20221212032911.2965-1-hdanton@sina.com>
 <20221213014716.3347-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213014716.3347-1-hdanton@sina.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 09:47:16AM +0800, Hillf Danton wrote:

> > maintainer time is expensive.  So by not improving syzbot in a way
> > that really shouldn't be all that difficult, the syzbot maintainers is
> > disrespectiving the time of the upstream maintainers.
> 
> Are upstream maintainers prefering to spend weeks and months creating
> ext4 beatles for example over taking a couple of hours scanning the
> syzbot reports like this one? Why does the bot kick you if you have a
> clean butt? Why are usb people irrelevant in this case?

And to continue with the rethorical questions: has anyone bothered to
inform you that you are an obnoxious cunt?

*plonk*
