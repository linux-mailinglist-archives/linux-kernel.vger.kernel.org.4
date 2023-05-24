Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1C470FACD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 17:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237289AbjEXPwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 11:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237197AbjEXPwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 11:52:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E5113E
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:52:07 -0700 (PDT)
Date:   Wed, 24 May 2023 17:37:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684942655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1jSq4VCUYdhAtbCu7gYijkxnH3hRK+gwqho6b12tHfw=;
        b=af72ZCVDmCXtCzHlWyUQt/68BPvvspgLvjzej98nKd4oLoVKyxV0T+5VKt/ioJ0BtblEXX
        Q+tyn1g7pcqvfpCtb7cQNLiAm0HKQzUnpOAVIR2qH/FhCJEfV7yTAVVK43qy7Gs99CNF9v
        o12kgV1zoJeWEBS63Ht/R20NtpDeugPo1lMMBvKUyLemS9paXVrD9vk1ZveawcfRAgHAX8
        LQcU3zUTGqWOYUExF4N36k5KlOeLfBhSw/DO0ZfhflvYZLEuwBqErJjLxYD2skzPeL/lFo
        ukzNLL2gdGdy3c4h9CRSq9GdR+0S781ZizKlwYpcjqUKJHuMOGNB5h6Q0xoHuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684942655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1jSq4VCUYdhAtbCu7gYijkxnH3hRK+gwqho6b12tHfw=;
        b=yonSZdxac34C2Y2xpUfsFzQISrCakS1M94bqqnyJpcNgDhpqlhHG1eWH8cn1+NslFZoF2d
        exqvU8rWe2yWKBCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/2] signal: Avoid preempt_disable() in ptrace_stop() on
 PREEMPT_RT
Message-ID: <20230524153733.6g0DVlsH@linutronix.de>
References: <20230406205713.1843072-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230406205713.1843072-1-bigeasy@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-06 22:57:10 [+0200], To linux-kernel@vger.kernel.org wrote:
> Hi,
> 
> this mini series updates the comment to properly explain why the
> preempt-disable section has been added and then disables this on
> PREEMPT_RT explaining why it can not be done.

a polite ping.

Sebastian
