Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0760670CF59
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 02:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbjEWA1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 20:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbjEWAIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 20:08:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1F61BD4;
        Mon, 22 May 2023 16:45:43 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684799141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HNfvfTxVOpl2K7qMYcvndQ8gy3p44IHcsFiRmQKaTzc=;
        b=AFvydX8NJEymHuWzFxfZPZFv1ztDvPqouBElKX2Y7HF7iCDAiERXHOwkVkF5EX4fNoDdk+
        y6ZsOKNdJwnB5FxVei1rtl28M44xGqLVdo6qQB2+MLe6SL2nK2Tb1Lktz5cnZ8jEvdDeQW
        c/Bm3osSWyib/Ey2M3cKvru0cHjUEIXrm1oTQvP180tA1MGaG4NxSqYFnuP6CXi6IF5kWw
        Z1msuSNyTRwL247v233o36LHj7hPLUgGtCjchX3834Y1utR8DeYQyzNMtnmVBEmHAFVJof
        YRgB/H5phw/CCaOWjlqoLIZukt6xLEjfMIdgtPMoNwm5GSfVe9pMSijrIZJCgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684799141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HNfvfTxVOpl2K7qMYcvndQ8gy3p44IHcsFiRmQKaTzc=;
        b=cq3/O47bFWXIcQtQ6qHObwfC10gVJqO6ukQjwSI4IYk+yhQ7bNJnCfWUa60G6WCLuOJAAx
        SCgZ8RV9vWB0vjBw==
To:     linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        adobriyan@gmail.com, akpm@linux-foundation.org
Subject: Re: + fix-mult_frac-multiple-argument-evaluation-bug.patch added to
 mm-nonmm-unstable branch
In-Reply-To: <20230522211514.E0037C4339C@smtp.kernel.org>
References: <20230522211514.E0037C4339C@smtp.kernel.org>
Date:   Tue, 23 May 2023 01:45:40 +0200
Message-ID: <87ttw4udzv.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22 2023 at 14:15, Andrew Morton wrote:
> ------------------------------------------------------
> From: Alexey Dobriyan <adobriyan@gmail.com>
> Subject: include/linux/math.h: fix mult_frac() multiple argument evaluation bug
> Date: Sat, 20 May 2023 21:25:19 +0300
>
> mult_frac() evaluates _all_ arguments multiple times in the body.

I'm not opposed to the patch, but to the description.

Multiple evaluation is not a bug per se.

Unless there is a reasonable explanation for the alleged bug this is
just a cosmetic exercise.

Changelogs have to be self explanatory and if the shortlog, aka
$subject, claims "bug" then there has to be a reasonable explanation
what the actual bug is.

Seriously.

All this is documented, but obviously documention for changelogs and the
acceptance of patches is just there to be ignored, right?

Thanks,

        tglx
