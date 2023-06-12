Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CE972B8E8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 09:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbjFLHmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 03:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235238AbjFLHmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:42:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310F4E64
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 00:41:53 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686555627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ik2PbxJeEu4cqvcUohHtCee5Rq/H9LRZmejCC0KDr0s=;
        b=T1hFFfcOkNg3PJ1emI8GW0uqLCzD+uDWIrLhPy8ydmDFvMwaSHsz2pN/hU9b+XwSEXALD7
        EC4sSqpZeDK/gBTAtUVju851E2SUNRlppBUnfEdYOWxIWLG21Bp0shIUmGdTEp73xg0NTs
        UVqRAx63Ss2LkRefqtfL0SkV9k9nx2HgdIgBfGCLvUjlUirkbwOjvFjkkR1oQkjx+CX/z/
        5RBC2RBf0E/UzkPgSF697qcxpRHXTfTAbdnk5t/XDNHXzAivBEOO7xTqKca7sf+a8xiejY
        GjQ9/PQW+QPm77wIYFgoJEQGBoRiMnntRZr2DAOWppTqiKetxl1cYPUW8+wijw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686555627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ik2PbxJeEu4cqvcUohHtCee5Rq/H9LRZmejCC0KDr0s=;
        b=tx+F99Qf9FIjomd/q8CPgs5yOTdKVWi3hnQVfa+Bl1Uz0HnO1UH51mjLn3MtM81imH2j+3
        USNMNaVBSUsXVKBw==
To:     Li zeming <zeming@nfschina.com>, jstultz@google.com,
        sboyd@kernel.org, linux-kernel@vger.kernel.org
Cc:     Li zeming <zeming@nfschina.com>
Subject: Re: [PATCH] time: clocksource-wdtest: Remove unnecessary
 initialization of variable 'ret'
In-Reply-To: <20230613193540.3177-1-zeming@nfschina.com>
References: <20230613193540.3177-1-zeming@nfschina.com>
Date:   Mon, 12 Jun 2023 09:40:26 +0200
Message-ID: <87ttvd6sd1.ffs@tglx>
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

Li!

On Wed, Jun 14 2023 at 03:35, Li zeming wrote:

Can you please pick the proper prefixes and not create random ones.

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#patch-subject

> ret is assigned first, so it does not need to initialize the
> assignment.

This sentence does not make sense. You cannot initialize an
assignment. What you want to say is something like this.

'ret' is always assigned before being checked, so initializing the
variable is not required.

No?

Thanks,

        tglx
