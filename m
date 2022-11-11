Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A556260E3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 19:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbiKKSKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 13:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbiKKSKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 13:10:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A86117C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 10:10:36 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668190235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=83xJECtQ8LCpmDxlTNxAmW19rqmCnpjHE1NDAjkv8tA=;
        b=jucrbjJnLZGSgEAvTALGDpjYWfZ/WuwzCNvjUzE+obstqT6Jlq+ZDJfts3v3CShEb1be6o
        rLA/wG+/1zqZgZquiT2HnWvleg6OE8SR9rKtYY/6KYrvsFyt0eWWD4U2GJxw02LrLfWy2Y
        fUXRAXLyvq4AeqvvtBsxzYOZTrQjwTWIsaKasxG6XNSnuacIhBayg5PLn2W9ZUIPTSk93x
        Xfj0fgJdi8QJEv0UIaCAESxQfoBOcs/8k7jyjiZQV/oPTrtxTBuLXL6xi2f9GoVg4wDUv1
        f5rvhSWsuHkAW6YrGHC4p9T+DTL4Ldzw34bER8DCSMhZ9DpQOAOzCySNkNhMbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668190235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=83xJECtQ8LCpmDxlTNxAmW19rqmCnpjHE1NDAjkv8tA=;
        b=PIhYg4D6ashZovjH4pNFxBU/QZw1guniCyZemtaA3s2gAAEoIHrqBo7PMVBg6VO1O7yV69
        kFHGd2796ZPFUvCw==
To:     Angus Chen <angus.chen@jaguarmicro.com>
Cc:     linux-kernel@vger.kernel.org,
        Angus Chen <angus.chen@jaguarmicro.com>
Subject: Re: [PATCH] genirq: Remove unused parameter force of
 irq_set_affinity_deactivated()
In-Reply-To: <20221007103236.599-1-angus.chen@jaguarmicro.com>
References: <20221007103236.599-1-angus.chen@jaguarmicro.com>
Date:   Fri, 11 Nov 2022 19:10:34 +0100
Message-ID: <87cz9tcqg5.ffs@tglx>
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

On Fri, Oct 07 2022 at 18:32, Angus Chen wrote:
> The force parameter in irq_set_affinity_deactivated() is not used,
> get rid of it.

Correct.

> Fixes: baedb87d1b53 ("genirq/affinity: Handle affinity setting on
> inactive interrupts correctly")

What does this fix? An unused argument is neither a bug nor a
problem. Removing it is a cleanup nothing else.

Thanks,

        tglx
