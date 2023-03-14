Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D166B9EB0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjCNSgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjCNSgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:36:02 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C2661336;
        Tue, 14 Mar 2023 11:35:33 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 390977F9;
        Tue, 14 Mar 2023 18:35:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 390977F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1678818912; bh=21JZoynDX/z31Zg5FGW/tyVDgDWZYcBOij++lRW0aQQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=A06TqP/wqaCeWsZk/smPQxO9J9asnMP0QPXWWpDmrvpBC1tglFyMA5uYzoSVYr8ik
         Udf1dqxROogobGj3tCcq5Myf/ptx/CFTUeH8MuDfyYTFTq62HIQLd2S1W3vSKPyRuJ
         JYvaugYf5m086thHXExnOXYpyAUTkvfySSHhKVYV9P+VifsankUv2QXD6zmL7P4eTF
         ETGhHxGHmOvAwlLzLZCJ2IcwsLbZToyzvlpyrnLgI1MRNALI+Cjbsv8un/Hvu09H3O
         sQIngbKwJFcR4KdMd/MOxhAZdb56+LhFlZdKiNcDz2b0wj8nrwype+gjVW3bU0UkWm
         nSnPPQwAuGiIQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
Subject: Re: [PATCH v3] docs: describe how to quickly build a trimmed kernel
In-Reply-To: <1a788a8e7ba8a2063df08668f565efa832016032.1678021408.git.linux@leemhuis.info>
References: <1a788a8e7ba8a2063df08668f565efa832016032.1678021408.git.linux@leemhuis.info>
Date:   Tue, 14 Mar 2023 12:35:11 -0600
Message-ID: <87a60frxk0.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thorsten Leemhuis <linux@leemhuis.info> writes:

> Add a text explaining how to quickly build a kernel, as that's something
> users will often have to do when they want to report an issue or test
> proposed fixes.

So I think the time has come to apply this.  I did have one final
thought, though...  In the v2 discussion, you said:

> Be warned, if it works I might do the same for "reporting issues". ;)
> But let's first see how this goes (and if we get any feedback to be able
> to tell if this experiment worked).

This caused me to wonder if we shouldn't create a new book called
"tutorials" for this kind of stuff, with an explicit proviso that a more
web-oriented approach is OK in that section?  Tutorial documentation
*is* quite different from reference material, but we've really made no
effort to treat the two differently so far.

Thoughts?

Thanks,

jon
