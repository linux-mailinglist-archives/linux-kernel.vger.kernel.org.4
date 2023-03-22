Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592BA6C474B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 11:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjCVKO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 06:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjCVKOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 06:14:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426774BE8D;
        Wed, 22 Mar 2023 03:14:53 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679480091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VzDWYvuifBkntk/7g2EEju9mlsbW5oDHVJXRgp0vgaY=;
        b=kGK9tgftBBwMs6mUTt7D4WFjyS0X+Oq5qIUlEeaR3Gul9kYL6YQE0RlWcv2Tp+0LvfBlja
        zj0rqRCZL0Ix1b42uML/6FCr1t5cp3PS6E//BsxrMJKhepj7cNRhqWOS8IaJOUxPOWha41
        3jvLK4dVcYYdRvjgx9zK2AZFOf1SsqPVJPh3auO56nsN/ZzyGKihXAscV32X3Vq8E7q3+J
        7EqkH+fumPmZYjbuOA4XSOLn1bUCjQ25B+WFGGnGvh7kgZg1gViwa0ag3c94uFNVfOuoIc
        zQFC0kxp4MwXbduYirGvcvb3Hd3gycV4tb2qjRz9oNVkXi/CIh6Er0PWOij+pA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679480091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VzDWYvuifBkntk/7g2EEju9mlsbW5oDHVJXRgp0vgaY=;
        b=k9OTbLn8rLhDkflMXH5aMQZcgjFV5qNKmFEqVFnSK/4kFoj7cIGya32SvQ5/MmuHe7NoZK
        ahZvK9Q5iFNsIACw==
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] Documentation: maintainer-tip: Rectify link to
 "Describe your changes" section of submitting-patches.rst
In-Reply-To: <20230320124327.174881-1-bagasdotme@gmail.com>
References: <20230320124327.174881-1-bagasdotme@gmail.com>
Date:   Wed, 22 Mar 2023 11:14:50 +0100
Message-ID: <874jqd9jol.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20 2023 at 19:43, Bagas Sanjaya wrote:
> The general changelog rules for the tip tree refers to "Describe your
> changes" section of submitting patches guide. However, the internal link
> reference targets to non-existent "submittingpatches" label, which
> brings reader to the top of the linked doc.
>
> Correct the target. No changes to submitting-patches.rst since the
> required label is already there.
>
> Fixes: 31c9d7c8297558 ("Documentation/process: Add tip tree handbook")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

In cass Jonathan is picking this up:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

> ---
>  This patch is based on core/urgent branch of tip tree.

Why? Picking a random branch to base patches on is not really
helpful. It has zero dependencies on that branch.

Thanks,

        tglx

