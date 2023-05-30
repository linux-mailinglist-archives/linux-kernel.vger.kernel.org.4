Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CFF71647C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjE3OlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjE3OlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:41:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847E4123;
        Tue, 30 May 2023 07:40:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 338C921A03;
        Tue, 30 May 2023 14:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685457650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a9sB6H+XW8Y7WjDvQjfVnkpXnUAqYkrBI6CEECBeZUA=;
        b=UGwjgMinTKp0NsJ7pZlarCt1OheuX6unt7XijzKaXk1mMO1rIPhdMjZBOd+sRPfBYEZTXf
        3Exe5XXnF/9X9UqRSJdkgenu/x8GSb4mziBg7Ay1i9WhzKP/icDtGBDBRreSWdLf3bTTFp
        N5ljukBANN3f+Pmdgj1Dp+CwZ/3c4fs=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E44292C141;
        Tue, 30 May 2023 14:40:49 +0000 (UTC)
Date:   Tue, 30 May 2023 16:40:49 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        sparclinux@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 04/10] watchdog/hardlockup: In
 watchdog_hardlockup_check() use cpumask_copy()
Message-ID: <ZHYK8dP8-kQ-_pBi@alley>
References: <20230527014153.2793931-1-dianders@chromium.org>
 <20230526184139.4.Iccee2d1ea19114dafb6553a854ea4d8ab2a3f25b@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526184139.4.Iccee2d1ea19114dafb6553a854ea4d8ab2a3f25b@changeid>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-05-26 18:41:34, Douglas Anderson wrote:
> In the patch ("watchdog/hardlockup: add a "cpu" param to
> watchdog_hardlockup_check()") we started using a cpumask to keep track
> of which CPUs to backtrace. When setting up this cpumask, it's better
> to use cpumask_copy() than to just copy the structure directly. Fix this.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
