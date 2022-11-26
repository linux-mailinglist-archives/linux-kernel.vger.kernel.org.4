Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9055639292
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 01:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiKZASE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 19:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiKZASD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 19:18:03 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983AB2FC07
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 16:18:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EEFF8CE2FE3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 00:18:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381A8C433C1;
        Sat, 26 Nov 2022 00:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1669421878;
        bh=N0BkCIonzZFjorKsjBaLOWHmBGWXxgq4vQOHZYYI+QM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u0dmufMBeU/Hge17mRXBmPGXWvfk84ictiDbNzdkhYWzCJka/K8Y897LxUKz7Vj3z
         U1yJUtWHtoZFdoY4wBcpYuMB3DmBgMpNNHUtIQgiLA4Nb1IDJvLIqamUoTUitgl9U8
         USOEXxWnBItN7/5B+3liMkAy2ysF02xGzrkMnRvk=
Date:   Fri, 25 Nov 2022 16:17:57 -0800
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
Message-Id: <20221125161757.73f96b3b90f4884509097352@linux-foundation.org>
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

Oh, I get it.  Clang.  I'll tweak the above para to make that clearer.

cc:stable question still applies?  How much trouble will these build
errors be causing people for the next N years?

> With this set applied, I am able to obtain a successful allmodconfig Arm build.
