Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6E96EC0EB
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 17:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjDWPzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 11:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjDWPzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 11:55:23 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01952E70;
        Sun, 23 Apr 2023 08:55:21 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7D6AD35E;
        Sun, 23 Apr 2023 15:55:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7D6AD35E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1682265321; bh=Eq7I91rvkJgR1lXQO6Y7qo5YQsJ2G/Qu3dWfTJsNRl8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=H0hjvH0nrBX2pTgA8en1Cputc4qzLmxHL1pGrPTRcwR+k9ZyNRXJSNzvONjOImAgm
         UvR5yzXUf5xqd0z0Fkks7EYFs9uowQ/2CIQFZbokmc6pjxetnwedSv6+onxvTl96ki
         SET+R1cMjgrAa3mmoAPbW/QSVkgGkXLLDMLd+vBHqex4bhNaiicF1QCjS4Qzu0FUoh
         4NuzYZjJgPKNgMTOCIK5f7eSlipqqHHTYigA955hriHFhNbmlu96G2Ze2uzwgtIXgX
         f5soMGecqgLIGZ+ByycmFc86in7oH6QO6QPgHDDGsFb0ZPLkluMPZiH6W0v7JmC+qM
         SdsDM49oaDUAw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH] Documentation/process/changes: Escape --options to fix
 Sphinx output
In-Reply-To: <7e3b424d-2aba-3326-29c8-2ccdbfb12f70@gmail.com>
References: <87o7nitvd4.fsf@meer.lwn.net>
 <7e3b424d-2aba-3326-29c8-2ccdbfb12f70@gmail.com>
Date:   Sun, 23 Apr 2023 09:55:20 -0600
Message-ID: <87leiioaon.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akira Yokosawa <akiyks@gmail.com> writes:

> Whereas the summary reads "docs: turn off "smart quotes" in the HTML build",
> the change is also effective in the LaTeX/PDF build.

True...so the title is a bit off, but it is a fix for that build too,
right? 

> BTW, Jon, don't you test build pdfdocs these days?

I will confess that I don't do it as often as I should.  As you may have
noticed, it takes a little while to run, and the interest in PDF output
is pretty low these days.

> The fix to the pdfdocs build error from Tomi [1] is not yet picked up
> either by Mauro or you ... :-/
>
> [1] https://lore.kernel.org/linux-doc/29380b3e-1daa-3aef-1749-dbd9960ba620@gmail.com/

Media docs patches normally go through the media tree, just like the
original bug did; I had assumed that would happen here as well.
Seemingly not, so I've just picked those patches up into docs-next.

> I waited to see if there is anybody else who hits this build error.
> It looks like I am alone!
>
> If there is so few interest in pdfdocs, it might not be worth keeping
> kernel documentation compatible with PDF build. 

Interest is low, but not zero, and I'd prefer to keep it working.  It
really helps when somebody tells me that it breaks (it is rather
fragile, alas)!

One of these days I would really like to make a serious attempt to see
if rst2pdf has any hope of ever working for us.  Taking latex out of the
picture would simplify so many things.

Thanks,

jon
