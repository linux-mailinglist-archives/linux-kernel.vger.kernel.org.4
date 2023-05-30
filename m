Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7675F71655D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjE3O5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbjE3O5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:57:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F19D9D;
        Tue, 30 May 2023 07:57:24 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C842F21A78;
        Tue, 30 May 2023 14:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685458642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OyCooO4+A9tHM1EwAX82bLac9dIaqTyYUJvSzhvUXNY=;
        b=exnFTkY71y7kWLBantSsf25O7t/HBP1TSq1/1Bb7cPReOsRtCIXntKMmNtN89P4hq+ThgF
        qJ6IZ5WMylQQCRqGXXzLKfcRbPckxbztf4IdD0W/CvM5uI7/dS++PugP/Ux02ohx4jeFx+
        vS6l+QKOycbCGU2I089+jploMCdaOpE=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 840202C141;
        Tue, 30 May 2023 14:57:22 +0000 (UTC)
Date:   Tue, 30 May 2023 16:57:22 +0200
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
Subject: Re: [PATCH 07/10] watchdog/buddy: Don't copy the cpumask in
 watchdog_next_cpu()
Message-ID: <ZHYO0usbjBXYW9-H@alley>
References: <20230527014153.2793931-1-dianders@chromium.org>
 <20230526184139.7.If466f9a2b50884cbf6a1d8ad05525a2c17069407@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526184139.7.If466f9a2b50884cbf6a1d8ad05525a2c17069407@changeid>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-05-26 18:41:37, Douglas Anderson wrote:
> There's no reason to make a copy of the "watchdog_cpus" locally in
> watchdog_next_cpu(). Making a copy wouldn't make things any more race
> free and we're just reading the value so there's no need for a copy.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
