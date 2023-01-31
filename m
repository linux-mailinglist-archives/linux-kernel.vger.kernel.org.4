Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18062682A68
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjAaKYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjAaKYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:24:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BFF3B3F5;
        Tue, 31 Jan 2023 02:24:10 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675160648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LTi1u1FDPCvVffVR/Ikn8vepvtF8TRtXOvs36q4wHU0=;
        b=MUkSdyb7ihOOpo/GoETmiJdN9ycgfAkGtjHqlXT2Vgsq+eFtE9aERoq1gVZowsw4R3SXpV
        FahT4+BCTeCBcw+lvYUPMZBksCOhk7Uvs91L7KUJQWlvD9BJ81Wxdp0e7XWQ6T7AqZ9H0x
        4Qf9P9Fc3akC8bM26k/Ei3cbZqZBXl8qVlmcRU2q2qUS/c1hiRcOtJIPeuvnjYwAJKmvbR
        3oJLFngn9xQ/5MrfdgC63cXYcYjZhZ8DFMXj9STS/FnMW+gUAWCr18KlrXaUbV6i9V4uDx
        QU1wK34lco83uvt0atWQHD3lDFGClJSe67/lLglw34LPttTuBt7OeWSG28yOaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675160648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LTi1u1FDPCvVffVR/Ikn8vepvtF8TRtXOvs36q4wHU0=;
        b=wNjX7RzQo0l0i8jbeYkl43My+b6CjcpFQpBxTfKOkbAJFDWm+fEq94wNdxtICTAt97oWr1
        kRFjZerwiCI1/vCw==
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     mingo@kernel.org, peterz@infradead.org, bigeasy@linutronix.de,
        dave@stgolabs.net, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kernel/hrtimer: Rely on rt_task() for DL tasks too
In-Reply-To: <20230123173206.6764-2-dave@stgolabs.net>
References: <20230123173206.6764-1-dave@stgolabs.net>
 <20230123173206.6764-2-dave@stgolabs.net>
Date:   Tue, 31 Jan 2023 11:24:08 +0100
Message-ID: <87bkmf0zp3.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23 2023 at 09:32, Davidlohr Bueso wrote:

'kernel/hrtimer:' is not the correct prefix. Hint:

 git log --oneline path/to/file

I fixed that up for you this time....
