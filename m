Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA675E6CAA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiIVUFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiIVUFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:05:36 -0400
Received: from smtp-out.xnet.cz (smtp-out.xnet.cz [178.217.244.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA5AAEDA4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 13:05:33 -0700 (PDT)
Received: from meh.true.cz (meh.true.cz [108.61.167.218])
        (Authenticated sender: petr@true.cz)
        by smtp-out.xnet.cz (Postfix) with ESMTPSA id 48071361D;
        Thu, 22 Sep 2022 22:05:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=true.cz; s=xnet;
        t=1663877130; bh=ejMzlwclMrgb1layxLTSYcJCux9M8r7dblyvchErL2k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
        b=BFQqhIEj3alYb5w0DoIVOMYddN763f7SU/GrWP8CLgtaTzj/tpE5miMFeG3T7EqAJ
         +jRWkK9Kwjue72V/OrMR2Zta3hT/BpqP7oiinLTn8xlrO6GkgywThnAt8wOISiZ+z8
         8e95wqXw3yoBzFgJx8rb8z9tDaD+ppjBfGvpOgyE=
Received: from localhost (meh.true.cz [local])
        by meh.true.cz (OpenSMTPD) with ESMTPA id 6f159da1;
        Thu, 22 Sep 2022 22:05:07 +0200 (CEST)
Date:   Thu, 22 Sep 2022 22:05:06 +0200
From:   Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
To:     Phil Auld <pauld@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, yury.norov@gmail.com,
        rafael@kernel.org
Subject: Re: aarch64 5.15.68 regression in topology/thread_siblings (huge
 file size and no content)
Message-ID: <20220922200506.GC87797@meh.true.cz>
Reply-To: Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
References: <20220922113217.GA90426@meh.true.cz>
 <YyxVytqQDbGWPa+6@lorien.usersys.redhat.com>
 <YyxXoPmtTZHCr5pR@kroah.com>
 <Yyxgtx/Vr6Ar1xEe@lorien.usersys.redhat.com>
 <20220922140504.GA58265@meh.true.cz>
 <YyyY1LgHzQZpQkqM@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyyY1LgHzQZpQkqM@lorien.usersys.redhat.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Auld <pauld@redhat.com> [2022-09-22 13:18:12]:

> Then I applied the fix and the problem went away:

I've just tried the same aarch64 and I can confirm, that the
patch fixes the issue.

Cheers,

Petr
