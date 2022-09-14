Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5111A5B82B2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 10:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiINIPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 04:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiINIOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 04:14:52 -0400
X-Greylist: delayed 366 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 14 Sep 2022 01:14:49 PDT
Received: from frolo.macqel.be (smtp2.macqel.be [109.135.2.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3896813DE3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 01:14:47 -0700 (PDT)
Received: by frolo.macqel.be (Postfix, from userid 1000)
        id 364CEDF00AC; Wed, 14 Sep 2022 10:08:38 +0200 (CEST)
Date:   Wed, 14 Sep 2022 10:08:39 +0200
From:   Philippe De Muyter <phdm@macq.eu>
To:     Wu Bo <bo.wu@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] f2fs: fix to check space of current segment journal
Message-ID: <20220914080839.GA19067@172.21.0.10>
References: <20220914040423.539-1-bo.wu@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914040423.539-1-bo.wu@vivo.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Wu Bo,

On Wed, Sep 14, 2022 at 12:04:23PM +0800, Wu Bo wrote:
> As Philippe De Muyter reported:
> https://lore.kernel.org/linux-f2fs-devel/20220913224908.GA25100@172.21.0.10/T/#u
> 
> The warning log showed that when finding a new space for nat the journal
> space turned out to be full. This because the journal_rwsem is not
> locked before the journal space checking. The journal space may become
> full just after we check it.
> 
> Reported-by: Philippe De Muyter <phdm@macq.eu>
> Signed-off-by: Wu Bo <bo.wu@vivo.com>
> ---
>  fs/f2fs/node.c    |  6 +++---
>  fs/f2fs/segment.c | 10 +++++-----
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 

Thank you for your patch.

Unfortunately it does not apply to my 4.1.15 or newer 4.1.y sources,
and I do not have the knowledge of f2fs internals to modify your
patch myself.  E.g. 4.1.y lacks the '.journal' field in the
'struct curseg_info'.

Could you make a version suitable for 4.1.y ?

Best regards

Philippe
