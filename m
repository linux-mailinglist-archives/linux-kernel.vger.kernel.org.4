Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE416E8391
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 23:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjDSVXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 17:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjDSVXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 17:23:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA246EB5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:22:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7617A642E3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 21:22:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A44C433EF;
        Wed, 19 Apr 2023 21:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1681939320;
        bh=8FeQtFAQmPMVFM6tlsPfxwIQGqlujFEHWXaf5ZMyDsM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O6ocRganDUAI/lV4ZCyRbchU+HXxtFyVbREH3btuT0gjfzXgwtyv7D43AyPRMzXyA
         EQ6Pd2R4k+DRhAtQvNH3oWtdQ82oY/hINPkXCHmrPVdxYHYJVGSb2YkAasQvskU9w6
         mcADFIq4WPfezFJM+igySqjMcS2Us4tmG7ZULkt8=
Date:   Wed, 19 Apr 2023 14:21:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        ocfs2-devel <ocfs2-devel@oss.oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ocfs2: reduce ioctl stack usage
Message-Id: <20230419142159.fd5ca2e91658fe304e317a72@linux-foundation.org>
In-Reply-To: <d1e719ea-95bf-bb96-62db-e550cefe0a80@linux.alibaba.com>
References: <20230417205631.1956027-1-arnd@kernel.org>
        <20230418-fortgehen-inkubationszeit-5d3db3f0c2b1@brauner>
        <7555eaf9-b195-5189-3928-c7292e4a0ba5@linux.alibaba.com>
        <20230418-vielmehr-nominieren-7f2adb0f6703@brauner>
        <d1e719ea-95bf-bb96-62db-e550cefe0a80@linux.alibaba.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2023 10:00:15 +0800 Joseph Qi <joseph.qi@linux.alibaba.com> wrote:

> 
> 
> On 4/18/23 8:56 PM, Christian Brauner wrote:
> > On Tue, Apr 18, 2023 at 05:37:06PM +0800, Joseph Qi wrote:
> >> Andrew picked ocfs2 patches into -mm tree before.
> > Yup and that's fine obviously, but this belongs to fs/ and we're aiming
> > to take fs/ stuff through the dedicated fs trees going forward.
> 
> Either is fine for me.
> Hi Andrew, what's your opinion?

I've been wrangling ocfs2 for over a decade and this is the first I've
heard of this proposal.

Who is "we", above?  What was their reasoning?

Who will be responsible for ocfs2 patches?  What will be their workflow
and review and test processes?

Overall, what benefit does this proposal offer the ocfs2 project?
