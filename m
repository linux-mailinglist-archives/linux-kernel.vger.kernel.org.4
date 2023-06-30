Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3309E743B11
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 13:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbjF3Lob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 07:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjF3Lo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:44:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E39EE
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 04:44:26 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688125465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XXZHvgO2qFzbK9yTdOIgb9D/ZOxZTRXV4tcNIvFdPFs=;
        b=DPj6A4C4ZCPlMXGYjLE+bXpUFjHFxnRidoJrVcs83zSCk330UTm13LH1v0QpxucBJPwBJt
        1xl72yJf6x4XGHcf6mT6YIL5teGnzlnj8x2rhEhiMg4WFlc+iqaRdAXOZk65qWGCw5m5mX
        XLw7jx7p4uH1LEh1GIinVICWwo+sAN6HN7k1cIzCfEYfGCXP/EG1iy63s2gvx6HBUvQxPv
        h0zYvoyilIdM1J7JyzjR0XE4hHMyoD1RXlwZuVRgwGzEJOeSw+mu9LjoxCFuliiVz/d9nE
        ovbE5MmHpVWK0DfLgtRT4oQX/s9UsKGaJZxxfCx3QpcdjV0h/zVEBMxOUGB0Ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688125465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XXZHvgO2qFzbK9yTdOIgb9D/ZOxZTRXV4tcNIvFdPFs=;
        b=nfDdqDqUuDSE1Eskpt5Lb9mtEABmNFpH4q7vrGd9t3y0xivQ/BuJGXfEo4UH+yGwFCRJgk
        yQsWL5Ez1CZzg6BQ==
To:     Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mohocko@suse.com, jslaby@suse.cz,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [PATCH v4 1/6] x86: Introduce ia32_enabled()
In-Reply-To: <87edltyz9n.ffs@tglx>
References: <20230623111409.3047467-1-nik.borisov@suse.com>
 <20230623111409.3047467-2-nik.borisov@suse.com> <87edltyz9n.ffs@tglx>
Date:   Fri, 30 Jun 2023 13:44:25 +0200
Message-ID: <87bkgxyy1y.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30 2023 at 13:18, Thomas Gleixner wrote:
> On Fri, Jun 23 2023 at 14:14, Nikolay Borisov wrote:
>>  
>> +#ifdef CONFIG_IA32_EMULATION
>> +bool __ia32_enabled = true;
>
> This wants to be __ro_after_init as it can't change during runtime.

Other than this the series is now in acceptable state. No need to
resend. I have fixed it up locally. The series now in the queue for post
merge window processing.

Thanks,

        tglx
