Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D0B6A7A9B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 05:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjCBEqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 23:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCBEqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 23:46:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E46A2BEF6
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 20:46:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFE8CB811E1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 04:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C8DC433EF;
        Thu,  2 Mar 2023 04:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677732363;
        bh=qkBNSUUKZTROyRtWiTrl7muwV8AqNVcCJdaU8+3/C5o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H8Q9482i9wwOKeGMoEQ4WOP/s0qf+nAagVwqpSCMNAT12/j8L6G/XBGxaAAbCavBG
         2dZv5x1YQO29rxCInZYHwqWtdaNV+m4byz6FJkFR1DTTk7iMf35e1Uk2d54aVsMqBd
         JBwtMr9+LFIzgkx67gfTzbCRnA5gzaybF8uI0IMWdH909gulpdVaZ7xBsf0QSZlDg8
         f32LC+8/WDDzpJbDJO4n0zZN780wQaar13WE2vDProrJcy8E8hTg7JxSHzPTnqnXyR
         BmnIm4nL+W6zM0zZMivfkwLOsTFJthg5+v6huhdaKGbgfnaJ1DgZlHh48Paupj3OXG
         yTeu6fNj0NfWQ==
Date:   Wed, 1 Mar 2023 20:46:02 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Kai =?UTF-8?B?V2Fzc2VyYsOkY2g=?= <kai@dev.carbon-project.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] checkpatch: warn when Reported-by: is not
 followed by Link:
Message-ID: <20230301204602.5e9bf3c0@kernel.org>
In-Reply-To: <bb5dfd55ea2026303ab2296f4a6df3da7dd64006.1674217480.git.linux@leemhuis.info>
References: <cover.1674217480.git.linux@leemhuis.info>
        <bb5dfd55ea2026303ab2296f4a6df3da7dd64006.1674217480.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2023 13:35:19 +0100 Thorsten Leemhuis wrote:
> From: Kai Wasserb=C3=A4ch <kai@dev.carbon-project.org>
>=20
> Encourage patch authors to link to reports by issuing a warning, if
> a Reported-by: is not accompanied by a link to the report. Those links
> are often extremely useful for any code archaeologist that wants to know
> more about the backstory of a change than the commit message provides.
> That includes maintainers higher up in the patch-flow hierarchy, which
> is why Linus asks developers to add such links [1, 2, 3]. To quote [1]:

Is it okay if we exclude syzbot reports from this rule?
If full syzbot report ID is provided - it's as good as a link.=20
And regression tracking doesn't seem to happen much on syzbot=20
reports either.

I like the addition otherwise, it's already catching missing links=20
in netdev land!
