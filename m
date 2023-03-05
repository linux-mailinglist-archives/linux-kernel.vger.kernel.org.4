Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C4A6AAE66
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 07:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjCEGUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 01:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjCEGT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 01:19:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD791689D;
        Sat,  4 Mar 2023 22:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=mCw3qlccCZ7Fdqt9RrwRnLxZ5h4SPVaUk3+bNuEDCeI=; b=bgx+vLIQQuBBLQwTieomKaf79v
        mJJBWybsH6QBtZkr8uKLrgxcPPGpBvsvJzeBcME2RanJfTpMuVPRZuTUfdCkYQWZvhaMVaWYl0e3q
        pDqGxMP2I6X96DFvJdzSVFk63Rpne4xHqdh6ekUXVT4ojn4D5TOmGjdKpOE0h+QrpJdEtgUi3B4U5
        Eakdc/YgytpC3m5Iz3Rd0JEU4M0bEi4gZ2xugLpcXzDFFGRFqS2KyuFYTIWkSJHAxSPXvkR8KYsgz
        jPUEbqIMkC0bu9rwgdfUeYKf9iTOX4lQJ0rLgh38q2igWeAaMIsnUE4djdx0jFG2aMmZhUuWDYUgJ
        m1GxfuOA==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pYhis-009sQB-2V; Sun, 05 Mar 2023 06:19:54 +0000
Message-ID: <0fbd4e90-17de-fb1f-1b1a-7578a34ce386@infradead.org>
Date:   Sat, 4 Mar 2023 22:19:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] menuconfig: delete shadows, reclaim vertical space
Content-Language: en-US
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <94a94ef4-9d55-4293-8363-3c0243eceae1@p183>
 <d01112c2-b5a4-4aa3-4ee7-711abc9da079@infradead.org>
 <1c28155c-6931-432c-8308-c9b3638e3202@p183>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <1c28155c-6931-432c-8308-c9b3638e3202@p183>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/4/23 10:54, Alexey Dobriyan wrote:
> On Sat, Mar 04, 2023 at 09:56:08AM -0800, Randy Dunlap wrote:
>> Hi,
>>
>> On 3/4/23 08:55, Alexey Dobriyan wrote:
>>> Menuconfig has lots of vertical space wasted: on my system there are
>>> 17 lines of useful information about config options and 14 lines of
>>> useless fluff: legend, horizontal separators and shadows.
>>>
>>> Sitation is even worse on smaller terminals because fixed vertical lines
>>> do not go away, but config option lines do decreasing informational
>>> density even more.
>>>
>>> Delete shadows and increase menu size to reclaim vertical space.
>>>
>>> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
>>> ---
>>>
>>>  scripts/kconfig/lxdialog/checklist.c |    2 --
>>>  scripts/kconfig/lxdialog/dialog.h    |    1 -
>>>  scripts/kconfig/lxdialog/inputbox.c  |    2 --
>>>  scripts/kconfig/lxdialog/menubox.c   |    6 ++----
>>>  scripts/kconfig/lxdialog/textbox.c   |    2 --
>>>  scripts/kconfig/lxdialog/util.c      |   22 ----------------------
>>>  scripts/kconfig/lxdialog/yesno.c     |    2 --
>>>  7 files changed, 2 insertions(+), 35 deletions(-)
>>>
>>
>> This patch works for me, but since the right side shadow is
>> also being removed, the one column (width) that it had
>> occupied might as well be used (reclaimed) instead of just
>> going to waste.
> 
> Horizontal space is not really important because monitors are wider
> than taller and our config option descriptions are quite short.

Yeah, but there is no reason not to reclaim the one horizontal column.
This does it for me: (lightly tested)

diff -- a/scripts/kconfig/lxdialog/menubox.c b/scripts/kconfig/lxdialog/menubox.c
--- a/scripts/kconfig/lxdialog/menubox.c
+++ b/scripts/kconfig/lxdialog/menubox.c
@@ -184,7 +184,7 @@ do_resize:
 		return -ERRDISPLAYTOOSMALL;
 
 	height -= 2;
-	width  -= 5;
+	width  -= 4;
 	menu_height = height - 10;
 

We might also be able to reduce the length of menu_instructions[]
and put more of it into the other Help text if that interests you.

-- 
~Randy
