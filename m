Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05373660293
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 15:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbjAFOxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 09:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbjAFOwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 09:52:49 -0500
Received: from fx303.security-mail.net (mxout.security-mail.net [85.31.212.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4143C81120
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 06:52:42 -0800 (PST)
Received: from localhost (fx303.security-mail.net [127.0.0.1])
        by fx303.security-mail.net (Postfix) with ESMTP id 39A0530F779
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 15:52:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1673016761;
        bh=f+Pm/3QgFlgjawVLGXD2Mw0FtuEi2NQPNxXSQ4OxBYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=MQbVQRA4YAPDyYD9e55kt74PVZPleHgCBeDzvm53GGaZiYHR8MKfCBahmg3ScgjVN
         w/I6PdVD+K7U9yHvQkmZFGmVxfWPJCDYossEdY8YbiSNzqXnZVBHxpNkeH3EduCcDD
         r/f8CmsqOI+SU2+at90MFZuXMeqf+Ck0jQ5sDucw=
Received: from fx303 (fx303.security-mail.net [127.0.0.1]) by
 fx303.security-mail.net (Postfix) with ESMTP id 17C9430F76C; Fri,  6 Jan
 2023 15:52:41 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx303.security-mail.net (Postfix) with ESMTPS id 0E0FF30F3CC; Fri,  6 Jan
 2023 15:52:40 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id D6D5627E028C; Fri,  6 Jan 2023
 15:52:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id BBC1F27E02E4; Fri,  6 Jan 2023 15:52:39 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 4DEs0klPw1Yt; Fri,  6 Jan 2023 15:52:39 +0100 (CET)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 9F45C27E028C; Fri,  6 Jan 2023
 15:52:39 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <ea8e.63b835b8.bf31.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu BBC1F27E02E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1673016759;
 bh=J68gEx/G8KthTnESDh8LRHiL2PdKKdtS5wtKgSSLlYQ=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=k9X6X78lx+fmIQ83avGFjD+AYQXuQ1mkKB3YmLI69TNEq5lVwBgc8bPlnofxG8zJp
 avezaVbothzZytnirg+VIUzt+JHWeThVBnixaBXPK60BM48Cb3koLKqRpv8PYU7aCR
 9rAojKYzR/aKf//voEaDlw5RL+DHuwUeiUYLFDtY=
Date:   Fri, 6 Jan 2023 15:52:38 +0100
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Yann Sionneau <ysionneau@kalray.eu>, linux-kernel@vger.kernel.org,
        Ashley Lesdalons <alesdalons@kalray.eu>,
        Benjamin Mugnier <mugnier.benjamin@gmail.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Julian Vetter <jvetter@kalray.eu>,
        Samuel Jones <sjones@kalray.eu>,
        Thomas Costis <tcostis@kalray.eu>,
        Vincent Chardon <vincent.chardon@elsys-design.com>
Subject: Re: [RFC PATCH 18/25] kvx: Add kvx default config file
Message-ID: <20230106145238.GD7446@tellis.lin.mbt.kalray.eu>
References: <20230103164359.24347-1-ysionneau@kalray.eu>
 <20230103164359.24347-19-ysionneau@kalray.eu> <Y7V48w+k+asLbrpY@debian.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y7V48w+k+asLbrpY@debian.me>
User-Agent: Mutt/1.9.4 (2018-02-28)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 08:02:43PM +0700, Bagas Sanjaya wrote:
> On Tue, Jan 03, 2023 at 05:43:52PM +0100, Yann Sionneau wrote:
> >  arch/kvx/configs/default_defconfig | 130 +++++++++++++++++++++++++++++
> >  1 file changed, 130 insertions(+)
> >  create mode 100644 arch/kvx/configs/default_defconfig
> > 
> 
> Shouldn't it be arch/kvx/configs/defconfig to be consistent with other
> archs?
Yes, we are going to use defconfig instead of default_defconfig (which
doesn't make much sens)

Thanks,
-- Jules





