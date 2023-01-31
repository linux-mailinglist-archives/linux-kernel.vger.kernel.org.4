Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9D1682899
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjAaJUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjAaJUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:20:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEBE122
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:20:50 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675156849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nPaZFWq+g8+flZgFtqcZmamrvdOou8FxxDXIsi+hB/8=;
        b=NujW6LC+xhU2Oq9kZsYccgFm4+liWGpkuHz9LK/pZSxcbEe+Bia3gsOWYszZBJn4becdCR
        Yi2S2sul/iFPgPwQzGv7Z/ausHIIGNnaAsoaFV4tt/b6ExGo5cj3UbO3uzaRU0qchTyxk0
        +sIXGZPjLku9pi28DpLD+VINJX6mQjq9YzNYIXnVaaGt2EwDb02jbPqY8Xyq/eyB9yFWgK
        oYaznIALiZWhcSUQZuU+nNfePbNlodHtdV+gkbbTrAZ6x4QbFh33pk2cCYtf5Q4ug6hQAt
        JaghRsiY/Iqb1mzJeI6N5EYRZ1mZ/df1W/KbRyV+J55r72DiG0Csx+PMmakxjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675156849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nPaZFWq+g8+flZgFtqcZmamrvdOou8FxxDXIsi+hB/8=;
        b=UuzPpnBEFyBVut4E1MHMwkWtNaL1MNWvbn4+5VduzhAhCXLBG/2IHyBDi5fhF3vcOnthWC
        cTAOjYr874LDoBCg==
To:     Shanker Donthineni <sdonthineni@nvidia.com>,
        Marc Zyngier <maz@kernel.org>, Michael Walle <michael@walle.cc>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] genirq: Introduce two helper functions
In-Reply-To: <20230130005725.3517597-4-sdonthineni@nvidia.com>
References: <20230130005725.3517597-1-sdonthineni@nvidia.com>
 <20230130005725.3517597-4-sdonthineni@nvidia.com>
Date:   Tue, 31 Jan 2023 10:20:49 +0100
Message-ID: <87k01312mm.ffs@tglx>
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

On Sun, Jan 29 2023 at 18:57, Shanker Donthineni wrote:
> Introduce helper functions irq_find_free_area() and irq_find_next_irq().
> The first function is used to locate available free space for a new IRQ,
> and the second one is used to find the next valid IRQ.
>
> These helper functions will be later modified to utilize the Maple data

So you first introduce helpers just to modify them in the next patch?

What you want to say here in this changelog is:

     genirq: Encapsulate sparse bitmap handling

     Move the open coded sparse bitmap handling into helper functions as
     a preparatory step for converting the sparse interrupt management
     to a maple tree.

     No functional change.

Hmm?

Thanks,

        tglx
