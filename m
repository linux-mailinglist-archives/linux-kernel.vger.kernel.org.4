Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A747640825
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 15:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbiLBOEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 09:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbiLBOEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 09:04:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACFBDF602
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 06:04:20 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669989858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MlDUTsjgo6bL0fhoCKZVMHLfOD98kJWgiMTwePcZ5qc=;
        b=l4pJ27yA0vFm4iGnoHtCOaRaq1lbioA/m3lQZ3ttFQ6diEllGDYPkKg4pjFETjavlwvpjU
        wWNT7YuCILngRFUAWHzLixctFSZbSfjoV9xtXygoDP0qm1gONpkrzOCG1CXPEtoAAio4cM
        TD0Jgko7t8Z9wq9NpI/5Q7BKIfgGR2/L1e4eVm5MDcBfZcYdewpEh6IQEqzTgdO1WAAbzh
        NKQ4AZsSD+GbYU2g9w5kVCysdmpnrgv9dvob474G2FFCCakD+ezV34bc+LcUD1ECUsvrAv
        07zdLXOda8xOpMg7ovgYv6OEBlNVlpCxkzIYN9yAkdMk6oCbBGI+JeREtxjfow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669989858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MlDUTsjgo6bL0fhoCKZVMHLfOD98kJWgiMTwePcZ5qc=;
        b=SVzbn/bfR8ip7uRjGreGLiGt7ZOwBhbSYO6jK8bS68yC3tIm7lL87trAwD5YbFHh2zDSQ6
        Bwvb72/MPKWPQSDA==
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Joe Korty <joe.korty@concurrent-rt.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: arch_timer: XGene-1: TVAL register math error
 breaks timer expiry calculation.
In-Reply-To: <e0dfe6b9-7a68-852a-501d-a7c86ed3145c@linaro.org>
References: <20221024165422.GA51107@zipoli.concurrent-rt.com>
 <86o7u0dqzj.wl-maz@kernel.org>
 <b6bfebb77b593e578bacec70646bc7e3@kernel.org>
 <e0dfe6b9-7a68-852a-501d-a7c86ed3145c@linaro.org>
Date:   Fri, 02 Dec 2022 15:04:17 +0100
Message-ID: <87r0xhq4v2.ffs@tglx>
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

On Fri, Dec 02 2022 at 13:36, Daniel Lezcano wrote:
> On 03/11/2022 16:05, Marc Zyngier wrote:
>> On 2022-10-25 13:31, Marc Zyngier wrote:
>>> Daniel, would you mind fixing it up when applying this patch? XGene is
>>> trivially broken without this fix, and it would be good if it could
>>> make it in one of the 6.1-rc.
>> 
>> Daniel, are you able to take this patch? I don't mind respinning
>> it myself if necessary.
>
> Yes please, if you can take care of updating the patch that will help. 
> I've been in leave during a long time and I'm still processing all the 
> submitted changes I received in the meantime

It's in Linus tree already.
