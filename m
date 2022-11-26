Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB6B639285
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 01:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiKZAN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 19:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiKZAN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 19:13:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827752BB0D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 16:13:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EADC61143
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 00:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C5AC433C1;
        Sat, 26 Nov 2022 00:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1669421606;
        bh=F2Iz4FmHG/F1E/NZVczN3uc6knKQCTCJz/o482AKOHI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xc82kQZsd+dQC/numsQShfrRl+O0J8DnCYj1NMIktTDjsGED0IanHoKaOvb7l6l9W
         oyafUj9mcWJNEimTbhve+jbIwR6TknhuIP/fj2WgmMJHG9oI1T07xeHAmMfC/UNu6A
         Uq12fxjx9eR+6SxN34H8xSMxLbYx+XtpzKU+ElTI=
Date:   Fri, 25 Nov 2022 16:13:25 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Lee Jones <lee@kernel.org>
Cc:     arnd@arndb.de, nathan@kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        ndesaulniers@google.com, trix@redhat.com, harry.wentland@amd.com,
        sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 0/2] Fix a bunch of allmodconfig errors
Message-Id: <20221125161325.bed715211b887d0a298813de@linux-foundation.org>
In-Reply-To: <20221125120750.3537134-1-lee@kernel.org>
References: <20221125120750.3537134-1-lee@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Nov 2022 12:07:48 +0000 Lee Jones <lee@kernel.org> wrote:

> Since b339ec9c229aa ("kbuild: Only default to -Werror if COMPILE_TEST") WERROR 
> now defaults to COMPILE_TEST meaning that it's enabled for allmodconfig        
> builds.  This leads to some interesting failures, each resolved in this set.   

I'm not sure who this patchset is aimed at, so I'll take my usual
approach of grabbing it and seeing who complains.

> With this set applied, I am able to obtain a successful allmodconfig Arm build.

b339ec9c229aa is a year old and I've been doing arm allmodconfig for
ever.  What am I missing here?

A broken arm allmodconfig is pretty irritating - I'm thinking that a
fix should be backported into -stable kernels.  But I'm clearly missing
something here.

