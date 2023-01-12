Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5906E666D0D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236648AbjALIyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239692AbjALIxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:53:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B29F61
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 00:52:11 -0800 (PST)
Date:   Thu, 12 Jan 2023 09:52:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673513529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J/eSBlsq8q2vU82CuVDIaJTqPLbe0hjWIbb6pf0d81g=;
        b=ffJcxzy0pSMEzvgPFBVJ0ruGz68AYUSsFAbwyAWXdgoywJxTkMHmKVreRNBwgP+FJQDOsL
        gtDi5hwp71Jsjoy/RZ/Hk85WPkbceo2O1m6okeCCRKo/kGOnxz36b+DzMPqVNBmFypqfwq
        yKG3/FsaOyIQ4/zrRnWxAvnzM89cUKuKno35FcAN5gxn7O1IqTEaLVRbao2XAC5BZ4nR+1
        42JPlbwdmzMaH51iPY/vxYRo2z046E5ScxdLVWbPb0qLw+TNOkOJtsnCsfUu0hhTt6jwJl
        W0g1cy0Ujz1o9b43EdjcJZrV80RYChqCVHb883FTCNtC10JeOJGwRljSjbYKog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673513529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J/eSBlsq8q2vU82CuVDIaJTqPLbe0hjWIbb6pf0d81g=;
        b=izmdwi1CqPSCYqcn/kp+rvRUeIruM2BtrjU83whOz5FAeY00Ihpr00A1m1HBe+1u3V9gc/
        Ak/w/Cgc3Ym/JxCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Roland Mainz <roland.mainz@nrubsig.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/3] x86: Provide a vdso for getcpu on x86-32.
Message-ID: <Y7/KN7amVvF7NAiV@linutronix.de>
References: <20221125094216.3663444-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221125094216.3663444-1-bigeasy@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-25 10:42:13 [+0100], To linux-kernel@vger.kernel.org wrote:
> This tiny series provides getcpu in vdso on x86-32. Due to the setup
> RDTSCP now also returns CPU and node information like x86-64 does.
> 
> The usage of RDTSCP + vdso has been tested in a VM with 64bit kernel and
> 32bit binary and a 32bit kernel.

ping.

Sebastian
