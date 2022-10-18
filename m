Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36858602E85
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbiJRObf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbiJROb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:31:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234C49DDA6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:31:27 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CBC1D1FD9C;
        Tue, 18 Oct 2022 14:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666103485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5tAkUE44dZqYPsRp5aff+5Vo9Yf5j8t3Uptr6Dnh4XM=;
        b=sI3h+z50lr9df0R/c9s6phPf0uKWtm9LoV6GeaD/ULWyVOzWulxLm/mofgtUTcaUWH9E1B
        pufC59f0XZWk6Ki8hweIDxfH4ZfD3+6g+ogffavzE3pw6DrY+MiAOnz1vKbpHgvOE6gtl5
        4Le6lfD71rYykOwNMqGWPz636/6U7dA=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 246F02C141;
        Tue, 18 Oct 2022 14:31:25 +0000 (UTC)
Date:   Tue, 18 Oct 2022 16:31:24 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     yexingchen116@gmail.com
Cc:     rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>
Subject: Re: [PATCH linux-next] vsprintf: replace in_irq() with in_hardirq()
Message-ID: <Y064vNAcOCSAimUT@alley>
References: <20221011024831.322799-1-ye.xingchen@zte.com.cn>
 <Y0UxLsYm71X1Lg+3@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0UxLsYm71X1Lg+3@alley>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-10-11 11:02:38, Petr Mladek wrote:
> On Tue 2022-10-11 02:48:31, yexingchen116@gmail.com wrote:
> > From: ye xingchen <ye.xingchen@zte.com.cn>
> > 
> > Replace the obsolete and ambiguos macro in_irq() with new
> > macro in_hardirq().
> > 
> > Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> I am going to queue it for 6.2. I would push it for 6.1 only together
> with another important changes. This one is not worth pull request
> at this stage.

JFYI, the patch is committed in printk/linux.git, branch for-6.2.

Best Regards,
Petr
