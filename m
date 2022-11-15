Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E38262A24F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 20:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiKOT6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 14:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiKOT6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 14:58:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EC914D02;
        Tue, 15 Nov 2022 11:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wkNdwJHAKziEE6309xkOYMnvNT11EPNoY/CfaDzZEx4=; b=A/zsdlcRdbGflGctZ6U83MWyLM
        CBV9ZvMwwqcYScp5HfiWV1wiVGzPDX9hLnreiZcxCt9qz58biGaFN/UKF3Xhz56rjhVqOBP5dgQMv
        ROo03/OCvwAeCovCLAuRYA/xqaWuP95Qw4ldGN86gK2p6s5lVgTUFA6uCfigV8qphtyrYPa8x3TVr
        XUKDCHgFb7uDIXhrZPR6ZUz85TVsiyEd3B4up3QluudIIiHnTLtF507YBbEI/jo7hdPWOFyJuS89g
        KSArmkZoy2OLhskcW1tbh97iLfmMy9nYc2yWxuePr2Rpny+b07U7B8Une1luNqoYQsQsQQSEkUntY
        P7LY1j+A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ov24o-00ESak-2L; Tue, 15 Nov 2022 19:58:34 +0000
Date:   Tue, 15 Nov 2022 11:58:34 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        masahiroy@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v9 4/8] kallsyms: introduce sections needed to map
 symbols to built-in modules
Message-ID: <Y3PvavbJDZsQCiuQ@bombadil.infradead.org>
References: <20221109134132.9052-1-nick.alcock@oracle.com>
 <20221109134132.9052-5-nick.alcock@oracle.com>
 <Y3BhRvt53xO5A0iQ@bombadil.infradead.org>
 <87mt8tv554.fsf@esperi.org.uk>
 <76d7ba29-c7d2-d082-5928-599844112494@huawei.com>
 <87edu4uz7z.fsf@esperi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edu4uz7z.fsf@esperi.org.uk>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 01:25:04PM +0000, Nick Alcock wrote:
> (I'm also a bit miffed because people are worrying about 10K of
> overhead at the same time as a patch is going in adding half a meg ;)

You are missing that the reason why your patch lacks much traction is
it lacks a clear *use* case. It has nothing to do with space. The cover
letter can be really summarized in a condensed way to get the point accross
to just include the text on your first paragraph you had at Plumbers:

https://lpc.events/event/16/contributions/1379/

This gets the point accross well.

The rest of the cover letter is just pure noise and gets me lost.

But for instance, when I reviewed the patch for adding ranges, your
cover letter describes the *justification*, the *why* to do that, but
the patch does not at all.

Please make sure that your commits describe *why* clearly. Please get
a bit of help from your team to condense to the cover letter to only
include what is needed if someone is reading the patchset for the
very first time.

And then users.. we need users clearly documented, who the heck is
using this or wants this / is going to use it and why.

  Luis
