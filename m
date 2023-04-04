Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B726D67D0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 17:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbjDDPrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 11:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235842AbjDDPrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:47:08 -0400
Received: from out-26.mta1.migadu.com (out-26.mta1.migadu.com [95.215.58.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6016DCE
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 08:47:06 -0700 (PDT)
Date:   Tue, 4 Apr 2023 11:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680623224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DIGWXQ9vv3X++kkU2M6IyO4Hkx0enP0cYM7Gzv29lqg=;
        b=WPnTKr/7CYEzdqgByUKoGtMQp9Se4+//Agi0QGz0EHdminhmD5YQ4mFxiPFzWb4Y1kbYY0
        QbloC2Zd82EgSQpc8ZycxLavom3cg8DnQcQs6m1fip51NcclGmgS8pUmTgqnXWdR+Du+kn
        dHw48G02SbfvQ7EZf8NmNDrJBjB9Sic=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        willy@infradead.org, axboe@kernel.dk
Subject: Re: [PATCH 0/2] bio iter improvements
Message-ID: <ZCxGdj3JKl2RPUJW@moria.home.lan>
References: <20230327174402.1655365-1-kent.overstreet@linux.dev>
 <ZCIVLQ6Klrps6k1g@infradead.org>
 <ZCNN2GE3WBjMkLkH@moria.home.lan>
 <ZCrsbv+zKGf4jvUm@infradead.org>
 <ZCsAhDpsiNWpiAxS@moria.home.lan>
 <ZCxAIR8pxOfSE6OR@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCxAIR8pxOfSE6OR@infradead.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 08:20:01AM -0700, Christoph Hellwig wrote:
> On Mon, Apr 03, 2023 at 12:36:20PM -0400, Kent Overstreet wrote:
> > But this was all right there in the original commit message. And to be
> > honest Christoph, these kinds of drive by "let's focus on the easiest
> > thing to measure" comments are what I expect from you at this point,
> 
> I'm really just curious what the motivation is.  The code does not
> seem much cleaner to me as the user of the API, and it doesn't reduce
> code size.  Maybe there is a good reason for it, but then it needs to
> be very clearly stated and you need to sell people on it.

Yeah, you're not trying to advance the discussion here, you're just
restating your original position. I heard you, and I responded.

> Starting to get personal instead tends to not help to convince your
> reviewers that it's really useful in general.

I know you and others like to talk a lot about what you want as
maintainers and reviewers - but I find that the people who are the
loudest and the most authoritarian in that respect tend not to be the
people who drive discussions forward in productive ways.
