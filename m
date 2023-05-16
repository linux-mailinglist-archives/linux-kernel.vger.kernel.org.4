Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0D270564B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 20:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjEPSrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 14:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjEPSrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 14:47:31 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBDD26B8;
        Tue, 16 May 2023 11:47:13 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 734BB993;
        Tue, 16 May 2023 18:47:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 734BB993
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1684262833; bh=obidCeCWF2KGB0qky+83Ie4e7z76fxG96v1p7sOnKgc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=UwDh5+r5O+CJ/HU2EnwCRTcitbQ95ZmeKnWjlv+4WTk7p17CB+R0/deYSJDsmiOC9
         eu3obp2YJ8RpueOL1DpR8p2wfZpcue3u8h4cLYwHIq+eG81giYT8RsKlhbjzHaZI5O
         63iU6XLss723Sqc+3PXUQwW7glqkKJf2wCmRGvnlRxjdI8Jb2IXJ0tbjBsvWDy8yJr
         RVcHL+spTFb50sSf8LAD5+IENxZsRHtGqxdhOkvTd/1H1KYq0m/XFe7VOo8iDbmWgJ
         8brbFol4TZ2FAvy9UFIJpzP6pNd6NDDgi/aoX8ToHcOfH6DilUZDcdDRjj0v1YpNQr
         bPkR1j3VHAe8w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] docs: quickly-build-trimmed-linux: various small
 fixes and improvements
In-Reply-To: <6f4684b9a5d11d3adb04e0af3cfc60db8b28eeb2.1684140700.git.linux@leemhuis.info>
References: <6f4684b9a5d11d3adb04e0af3cfc60db8b28eeb2.1684140700.git.linux@leemhuis.info>
Date:   Tue, 16 May 2023 12:47:12 -0600
Message-ID: <87r0rgazbj.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thorsten Leemhuis <linux@leemhuis.info> writes:

> * improve the short description of localmodconfig in the step-by-step
>   guide while fixing its broken first sentence
>
> * briefly mention immutable Linux distributions
>
> * use '--shallow-exclude=v6.0' throughout the document
>
> * instead of "git reset --hard; git checkout ..." use "git checkout
>   --force ..." in the step-by-step guide: this matches the TLDR and is
>   one command less to execute. This led to a few small adjustments to
>   the text and the flow in the surrounding area.
>
> * fix two thinkos in the section explaining full git clones
>
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>
> Hi. Let me know if you would have prefered this as five seperate
> commits. Ciao, Thorsten

That would be kind of silly; one patch for a set of fixups like this is
fine. 

>  .../quickly-build-trimmed-linux.rst           | 49 ++++++++++---------
>  1 file changed, 27 insertions(+), 22 deletions(-)

Applied, thanks.

jon
