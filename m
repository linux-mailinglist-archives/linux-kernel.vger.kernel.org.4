Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F040D72CA2E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235312AbjFLPdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbjFLPdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:33:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DF610C2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:33:05 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686583984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/UvyXBdVxxlWWcERZKAMVV5yubMV3jI1ppNTGKsWYiI=;
        b=zRxDqcB1bbxwXuD6IdH/eUc2JgtDOHtuelxT7cHs9p7/LBYdSSJSYPUK6IiASdmMVkiuNA
        nQbMuhWY+rpEGs4LohEmyvVDMHCLxfSvralNZBOCLH312drG+lWzA0j2ZSJ5Cx4VvIirQJ
        El8BBomwvszQLnA6E7VEnhc/WNjKgpgJOcikMpnSbMafhxvE3FhX2m4jCV5tryss9TxrgA
        UgJZlQpI5j2H5Q2WPtOs/PGhLFmhjsFu3vERiQBk/tBY4PYIQmE0jqgw+VjDSZG93B6bq3
        7Bb66KQ+Sc96H9mrhDh+O+i6MHU/er1x4ZOTspyclcLbZiGMbZTtMO3tpCjR3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686583984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/UvyXBdVxxlWWcERZKAMVV5yubMV3jI1ppNTGKsWYiI=;
        b=t3xGRQnHyYTPJ0S7b9oM1lvaZpVGlKkeC/bkSDsxAaMqmokVU9h3elI8lYjocjb2vKkxiU
        PEzUe8iIFIUFLqAA==
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] MAINTAINERS: Add CPU HOTPLUG entry
In-Reply-To: <c4ec2d2e-309a-50e3-c584-d9375416c771@infradead.org>
References: <87o7ll6ogo.ffs@tglx>
 <c4ec2d2e-309a-50e3-c584-d9375416c771@infradead.org>
Date:   Mon, 12 Jun 2023 17:33:03 +0200
Message-ID: <87fs6w7l1s.ffs@tglx>
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

On Mon, Jun 12 2023 at 08:14, Randy Dunlap wrote:
>> +CPU HOTPLUG
>> +M:	Thomas Gleixner <tglx@linutronix.de>
>> +M:	Peter Zijlstra <peterz@infradead.org>
>> +L:	linux-kernel@vger.kernel.org
>> +S:	Maintained
>> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp/core
>> +F:	kernel/cpu.c
>> +F:	kernel/smpboot.*
>> +F:	include/linux/cpu.h
>> +F:	include/linux/cpuhotplug.h
>> +F:	include/linux/smpboot.h
>> +
>
> The new entry should be before CPU IDLE, not after it.

Duh. I clearly need a refresh course at primary school.

> Otherwise LGTM, thanks for adding this. I was looking for it recently.
>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>

