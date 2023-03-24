Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44BE6C7E67
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjCXNFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 09:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCXNFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:05:35 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6688C1D903
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 06:05:34 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id C0A6C5C00DF;
        Fri, 24 Mar 2023 09:05:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 24 Mar 2023 09:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1679663133; x=
        1679749533; bh=D2Sm14YPitgKK7afGOPtHR9isHae7cDqwy06FDtuhyw=; b=W
        fliBE0UjjkAf15RgXiGdIAurivmNkQr8YudwGXpoF8tw20vbmR8wyga/z4QgkI9y
        +/4+9NHWTAqgPq5xvWYToH+iks9JFnk+bPG/jfyNYAtPxuZKTO7TujeD+gF7wJGu
        AsQr21A64zDI/xbX/6r3vRfxgy9hG/54P069zR+tJ0WY2CjeSE8RXTscQaRinwSs
        L//ZHMlqPjPQ+bOXcI+2xSyJKn/6jb+suhFSC9dD3pwmIk1pzIg3chJ3IA0pKbmD
        dQHXNgIK408XfrZSlqgCZPauEPtPGpmLI9f4foJrn9w5+vp9NbCXOFpd0m9+tSOI
        EYuYSV5NQBzFHkwY+xoNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679663133; x=1679749533; bh=D2Sm14YPitgKK
        7afGOPtHR9isHae7cDqwy06FDtuhyw=; b=lALm4zeA6r/UjwxKtUn1QbYnS89QO
        dtHZKgNyIC+9EPCIz7z72RV8b5bWG8gykFhlj0BNsEA2pubRz7icRiW+JZpfRIv+
        P/se6LPapbunC6/KDKS7oiRTL7zYUAuaZudifFtauLIiGjmcqSFMj4P3QXtaYClO
        I05MFJJFuAtYssnnX80GRZmzLa337kv3FVkIPUEYj3dpn9tOzvlQkpgU5DdshvUZ
        J5aO2fT7lbzwNBYmbspbfQonAFnnVd7d1ZZFn4npCxJn1nwDmWhVU4oSfmFUeOvQ
        m/Cf0MClkDn/3hcPOaSfnMt6Qg7WNw4u3a2dHzhhdGlSkihaXUP3Uiq9w==
X-ME-Sender: <xms:HaAdZPWAW7NZzv7Z_y2tDKdvS7HGUltqZmOi3uny8EMOABetF__tWg>
    <xme:HaAdZHkipDNO4ku4F7pMqiLRmRYSZlr5uFrr8L9u_2qbNZwLT8nNt9sqZ3pCie-3v
    qAwD13FlAgWXZvYhvg>
X-ME-Received: <xmr:HaAdZLa7xyCmRHFEt3ZosvrOqeH0ooQLbuYiYZyAG1D23QVNAFayzm3u5GOuGT7f8p7B4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegiedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:HaAdZKXcW4yz_li4B1oo2CD61IdB1ce1Ykw0YBgefSdi2WRDb5XQiw>
    <xmx:HaAdZJn0uAWUk0YVpNfz5cYP_zCdChYvcUMNvE5y95SqK2QfKsjBOw>
    <xmx:HaAdZHc3dEeKWEc9t4PsjbUVbFeY24bmYZHzLB0foV7aXViRKAskew>
    <xmx:HaAdZMu8itbkj7hBsRFPTp1ZaTpqptm-9OrIbTehXpc9ahfVIVrg4Q>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Mar 2023 09:05:33 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 0D6ED10A607; Fri, 24 Mar 2023 16:05:30 +0300 (+03)
Date:   Fri, 24 Mar 2023 16:05:30 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: WARN_ON in move_normal_pmd
Message-ID: <20230324130530.xsmqcxapy4j2aaik@box.shutemov.name>
References: <ZB2GTBD/LWTrkOiO@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZB2GTBD/LWTrkOiO@dhcp22.suse.cz>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 12:15:24PM +0100, Michal Hocko wrote:
> Hi,
> our QA is regularly hitting
> [  544.198822][T20518] WARNING: CPU: 1 PID: 20518 at ../mm/mremap.c:255 move_pgt_entry+0x4c6/0x510
> triggered by thp01 LTP test. This has been brought up in the past and
> resulted in f81fdd0c4ab7 ("mm: document warning in move_normal_pmd() and
> make it warn only once"). While it is good that the underlying problem
> is understood, it doesn't seem there is enough interest to fix it
> properly. Which is fair but I am wondering whether the WARN_ON gives
> us anything here.
> 
> Our QA process collects all unexpected side effects of tests and a WARN*
> in the log is certainly one of those. This trigger bugs which are mostly
> ignored as there is no upstream fix for them. This alone is nothing
> really critical but there are workloads which do run with panic on warn
> configured and this issue would put the system down which is unnecessary
> IMHO. Would it be sufficient to replace the WARN_ON_ONCE by
> pr_warn_once?

What about relaxing the check to exclude temporary stack from the WARN
condition:

diff --git a/mm/mremap.c b/mm/mremap.c
index 411a85682b58..eb0778b9d645 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -247,15 +247,12 @@ static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 	 * of any 4kB pages, but still there) PMD in the page table
 	 * tree.
 	 *
-	 * Warn on it once - because we really should try to figure
-	 * out how to do this better - but then say "I won't move
-	 * this pmd".
-	 *
-	 * One alternative might be to just unmap the target pmd at
-	 * this point, and verify that it really is empty. We'll see.
+	 * Warn on it once unless it is initial (temporary) stack.
 	 */
-	if (WARN_ON_ONCE(!pmd_none(*new_pmd)))
+	if (!pmd_none(*new_pmd)) {
+		WARN_ON_ONCE(!vma_is_temporary_stack(vma));
 		return false;
+	}

 	/*
 	 * We don't have to worry about the ordering of src and dst

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
