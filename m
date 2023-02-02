Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963946879AB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 11:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjBBKAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 05:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjBBKAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 05:00:03 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5F0889BF
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 01:59:42 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A48CC1FD7E;
        Thu,  2 Feb 2023 09:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675331981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oQ0+XzsEQdzXMkaUdS8m+6MCw+CA7pDq0uJMDy4T/bI=;
        b=LOzlw4VD0qshp3uDClABfWKb/O1PJrJPT3iBxjyTchRHqYqqxNtKdA1NzkDatPQxCbt3re
        FDPNaQ637KfiBGkpJjQV0EkJN5+3HS1psAj8rdXk40QG5FyI5orUH59Z4cMHKA/eIgwKKH
        R7wh4XLkfPmshTvO0t2PVf/NEi6Lp78=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7E5BC2C141;
        Thu,  2 Feb 2023 09:59:41 +0000 (UTC)
Date:   Thu, 2 Feb 2023 10:59:41 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     akpm@linux-foundation.org, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hung_task: Print message when hung_task_warnings gets
 down to zero.
Message-ID: <Y9uJjeUhtiDegNjG@alley>
References: <20230201135416.GA6560@didi-ThinkCentre-M920t-N000>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201135416.GA6560@didi-ThinkCentre-M920t-N000>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-02-01 21:54:33, fuyuanli wrote:
> It's useful to report it when hung_task_warnings gets down to zero,
> so that we can know if kernel log was lost or there is no hung task
> was detected.
> 
> Signed-off-by: fuyuanli <fuyuanli@didiglobal.com>

Looks good to me.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
