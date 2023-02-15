Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7600D697FCF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 16:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjBOPou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 10:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjBOPoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 10:44:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7792739B86
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 07:44:45 -0800 (PST)
Date:   Wed, 15 Feb 2023 16:44:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676475883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EJ1OMkGKAhulekyGtodTofc1ueBcmHuLjislMeJF+7E=;
        b=brY7L4gJGA5EDKWfGlKgBLC+yGl/3+Ua8WyCJEaCgi7G3nWd0WlmV0KUEC3hJ2bdlrl+DF
        P15VaDjwrCUt6rxAY4WDstV8GJGLMIaj7EzNsuMXU+sU1BVu+UuIEgxGI99zFUcKgPEX0H
        WlkF+Ll0W+yCur14M/UMK0w1TNxqhi3K0bpsP0F2GcPapIG5oqoQpTCluXbS+0G1qvWCgo
        iF2q77Z5YIvgYY05zT6zn3N9uI1ampQJlkTfvAHZAyS7ylGfLWZ2W5VzErFxbCnoGcpEtX
        MxX7eTn3RyFtpzSS5syIzt63/zleESvCY4MVm/pq9qPemm90mdoUJLebFBLdBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676475883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EJ1OMkGKAhulekyGtodTofc1ueBcmHuLjislMeJF+7E=;
        b=vXOu0+WezXQiAMc9ixcM+x02Y0YHRI6fk3xREJQGogpw5I3iIycwd5fRqBsnKXO/wVuPR4
        hUAWLgeCPQdiwkCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [tip:x86/vdso 3/4] arch/x86/entry/vdso/vdso32/../vgetcpu.c:13:1:
 warning: no previous prototype for '__vdso_getcpu'
Message-ID: <Y+z96g1rVaHGf3HI@linutronix.de>
References: <202302070742.iYcnoJwk-lkp@intel.com>
 <Y+KFYUqM5pT7iuoK@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y+KFYUqM5pT7iuoK@zn.tnic>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-07 18:07:45 [+0100], Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> Date: Tue, 7 Feb 2023 16:13:24 +0100
> Subject: [PATCH] x86/vdso: Fix -Wmissing-prototypes warnings

terribly sorry to have missed this. I wrongly parsed it as another
instance of the other thing.
Thank you for dealing with it.

Sebastian
