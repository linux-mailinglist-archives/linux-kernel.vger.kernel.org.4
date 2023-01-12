Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42802666D19
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbjALIzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240038AbjALIyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:54:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125C4D3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 00:53:53 -0800 (PST)
Date:   Thu, 12 Jan 2023 09:53:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673513631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3ohZwtnrskZxRLhPOI5/O+G29E2KgdfiedVgn+NSx5w=;
        b=lnx7+B89q3CCawYOYqsTRvJXU3AZTlvNW+boSsofEV3717eL8iLIhHcr19RqkNc/lSiJDs
        N83dlb9qzganec5xqzvUGmfh3qrXRFoOrHseL4Jfc4UCCwjHTIxspwmbMEgPvay9zzNbmP
        ZVN8TVj0I3jdZ8b5UJonXIDU9XytMVSAVJFElccgNonwDSKLEXxBjlln1Ao7Mtnp71xPa1
        wxb1l0Jssg0uKS2t31OUS4Pvfg1PhuuJ+sjgom/+goY0Kn41DZbKm8Sh83PGYEcmZw/EPe
        jPkM1BWsSXDLQQjLSdxQq2wBBGhww9NojGgZPk5TCO4PGGFtnlf9kOF69pdtzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673513631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3ohZwtnrskZxRLhPOI5/O+G29E2KgdfiedVgn+NSx5w=;
        b=EAaFjscMKSDh8Oig/IpFIStkhbZDFKgqiRF0iiwz63Dz6oIuo+Njd+lq7D54MDg/gD6c1r
        aD+1MIY5zDh6u+DA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [REPOST PATCH] locking/lockdep: Remove
 lockdep_init_map_crosslock.
Message-ID: <Y7/KnhLvzfFf80hi@linutronix.de>
References: <YqITgY+2aPITu96z@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YqITgY+2aPITu96z@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-09 17:36:34 [+0200], To linux-kernel@vger.kernel.org wrote:
> The cross-release bits have been removed, lockdep_init_map_crosslock() is
> a leftover.
> 
> Remove lockdep_init_map_crosslock.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Reviewed-by: Waiman Long <longman@redhat.com>
> Link: https://lore.kernel.org/r/20220311164457.46461-1-bigeasy@linutronix.de

Ping.

Sebastian
