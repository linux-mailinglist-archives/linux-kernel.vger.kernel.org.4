Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85582655DA4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 17:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiLYQdY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 25 Dec 2022 11:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLYQdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 11:33:21 -0500
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0990F5F82
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 08:33:20 -0800 (PST)
Message-ID: <628c5e32a437ad198866b03f2d6ff8a9c65754df.camel@gentoo.org>
Subject: Re: [PATCH] kheaders: prefer gtar over tar for better compatibility
From:   =?UTF-8?Q?Micha=C5=82_G=C3=B3rny?= <mgorny@gentoo.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Dmitry Goldin <dgoldin+lkml@protonmail.ch>,
        linux-kernel@vger.kernel.org, Sam James <sam@gentoo.org>
Date:   Sun, 25 Dec 2022 17:33:15 +0100
In-Reply-To: <CAK7LNAQ8=YbOVvugBUQBo8eXRMH+YA49aS-1C=2hCGq0xoW7XA@mail.gmail.com>
References: <20221217084155.663235-1-mgorny@gentoo.org>
         <CAK7LNAQ8=YbOVvugBUQBo8eXRMH+YA49aS-1C=2hCGq0xoW7XA@mail.gmail.com>
Organization: Gentoo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.2 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-12-25 at 01:45 +0900, Masahiro Yamada wrote:
> Instead of inserting a workaround like this,
> another way is to allow users to override a variable
> from the command line.
> 
> 
> See the top Makefile, for example,
> 
> 
> AWK             = awk
> 
> 
> Then, users can do "make AWK=gawk"

I'm sorry but are you requesting that I remove the check and use $TAR
instead, or allow overriding with TAR, and fall back to gtar or tar
respectively?  If the former, should the script unconditionally assume
that TAR will be always set in the environment, or include fallback to
tar for when the script is run directly?

> 
-- 
Best regards,
Michał Górny

