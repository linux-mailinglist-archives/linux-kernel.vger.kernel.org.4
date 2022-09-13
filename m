Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C234A5B6721
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 07:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiIMFGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 01:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiIMFF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 01:05:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBCD1181F;
        Mon, 12 Sep 2022 22:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=ppzte+5p0wdjle2gEwtaYNu3PIf+7fU0TZJWelWUXLY=; b=SHDd3PXq3BPBHSjQyvdIg6D/Ts
        5Un3Z3seNAbqOK6HkWzV7aRTc4ADivGY5u1VEdvX2d/2ePgi3kmBH9sTN7COo/b5Nt/z7+6IJC/qD
        jauY5Yq1HVrMv0vt59WDonohyZ0oQhOhWOXF8aq1U45MYqPiN4VCwV0toJXNgsKcadc2jRnfmD8OP
        mp3Fd74411/2AuwJHhdIR8o4tVgXU9KRe2XunsUzOtqqXuoEK7yDUl4Afs2zL+mEH5O1bP2rrs5ow
        pKdF6PKSRymrlQ5EJ0vy/+6CbtAiuExV0usstwO4UjTgTW6L2epViQUQ4CdVUo9S7RnggRpUG6odS
        DHHdQgzw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oXy7O-0024EP-Jk; Tue, 13 Sep 2022 05:05:54 +0000
Date:   Mon, 12 Sep 2022 22:05:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Kai Germaschewski <kai.germaschewski@gmx.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Marc Zyngier <maz@kernel.org>, kernel@pengutronix.de,
        linux-spdx@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/2] SPDX tags for copyright
Message-ID: <YyAPsqKNSwdHccLj@infradead.org>
References: <20220908223850.13217-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220908223850.13217-1-u.kleine-koenig@pengutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 12:38:48AM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> for Debian packaging having SPDX license tags already simplifies
> creating the required copyright documentation considerably. Another
> information that is needed for Debian packaging is the copyright
> information. There is an SPDX way for copyright information, too. The
> second patch converts scripts/kallsyms.c to that mechanism as an example
> to maybe discuss if we want to do that in the kernel.
> 
> While the SPDX-FileCopyrightText is officially a free-form field, I
> suggest to just stick to the format
> 
> 	(<year> )?<copyright holder>
> 
> to simplify machine consumption even further.

Adding the linux-spdx list and Linus.  If we go with this format
(which doesn't sound bad), we'll clearly need to document the format
we want, and that people should use it.

