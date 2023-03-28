Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5B46CB37D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 03:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjC1B6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 21:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjC1B6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 21:58:49 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8CD2123
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 18:58:47 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 0F8AEC009; Tue, 28 Mar 2023 03:58:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1679968725; bh=MNbvf38tFwUshpZ3ZUagdvlwgRRXXt+hc1JGT6cCqBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kGJ3npjE890XdkZSASYkPnnFXL7jprIU8aMQCfXxOXMoXPZ54I207bI5DPEaz9BPs
         LqKWlKaHuJjmc/tnK6Sh4rpdQ5GF3RLCkJIQbWdKra04F/qcOi5r63hOtTMy+COre5
         dLji/j1UTOBhLsYcB6L45OT4HqTfmB1C9KIKHdCM4ceAylbbSxaKwtK3W1N1cv2IsN
         i/xkKlAHfV9RqZhnI6aJ1xcBQA2zDY9y1AO/SPQnl1f1xGBW4mL4qYTFN2FNALHl2V
         TUyxOzI6FQGreqJ7Omy4unWOssnEGRgAyBh9ZiSThcdATa15QeQUoZwdGQCajLid1r
         5FkgO5blt1NMg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id B4F4DC009;
        Tue, 28 Mar 2023 03:58:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1679968724; bh=MNbvf38tFwUshpZ3ZUagdvlwgRRXXt+hc1JGT6cCqBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D9xD+rOQ4ASi6jQMVilPWEuBnVKy3lTQM2id/c99zYa3QJf0dBXhesQ0mbMZWOEks
         fEM/riJezIOUZ/hF+r5RMuPlBozFCH/bEeTG4GVcedWF0LEzHicxVqAYQgvkUxSAJF
         1VHLMFWvrH7963zlmaBY1I22tGtW0geP74/xOsYWKqyA7IRmSuLT8QaT9JEa1iYDgV
         m86ppWuACRj7f5n/bqJyjxOW7GxXjZkji0eXKm/IjfvCF/MwK9GQQSkY2+vBuyjxmS
         eq53FQ3O0iHlZ4vSDy3ajgvx7emEo3U10b56fYmsD45aokgVrbI9XgFVPABBtrOcV4
         5/Tsc0E6F+Fcw==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 5fab2ea1;
        Tue, 28 Mar 2023 01:58:39 +0000 (UTC)
Date:   Tue, 28 Mar 2023 10:58:24 +0900
From:   asmadeus@codewreck.org
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     lucho@ionkov.net, Pankaj Raghav <p.raghav@samsung.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: [V9fs-developer] 9p regression linux-next next-20230327
Message-ID: <ZCJJwDij0mLB0gwb@codewreck.org>
References: <ZCI+7Wg5OclSlE8c@bombadil.infradead.org>
 <ZCJGjuOYR6nGXiAw@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZCJGjuOYR6nGXiAw@codewreck.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asmadeus@codewreck.org wrote on Tue, Mar 28, 2023 at 10:44:46AM +0900:
> I've just built Eric's for-next branch and I'm not seeing any issue
> there, I'll be checking the next tag you pointed at next.

Well, at the very least I can confirm mount hangs there :)

[<0>] p9_client_rpc+0xf1/0x380 [9pnet]
[<0>] p9_client_attach+0x8d/0x1d0 [9pnet]
[<0>] v9fs_session_init+0x4ad/0x810 [9p]
[<0>] v9fs_mount+0x6a/0x420 [9p]
[<0>] legacy_get_tree+0x28/0x50
[<0>] vfs_get_tree+0x1a/0x90
[<0>] path_mount+0x746/0x9b0
[<0>] __x64_sys_mount+0x153/0x1b0
[<0>] do_syscall_64+0x3c/0x80
[<0>] entry_SYSCALL_64_after_hwframe+0x63/0xcd


And my async flush hasn't gotten fixed yet, so that mount cannot be
killed either.


I can mount over tcp so it's a virtio change, I'll dig a bit more and
report back with you and cc
-- 
Dominique
