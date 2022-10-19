Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A7D60493E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiJSO3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbiJSO2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:28:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEE3102DC8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:13:04 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666188729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z1E66GlY66yiLgq//IGcbPbMjBTix1nW1g6VhhORoME=;
        b=3BDUIKnwib4dQc6WNHbVJhXGOXP9ABwJkjmvDFqDa42Durvla7ocQb6T66Kem8JwK7OX7J
        NyiUSHWFvOOydeOccIH27QYel74wOcecYXEjVwIXOwDpJIkN/02jLMSOPPJfRpWVvzu2G9
        YMJ4JQziS/5SdsNCuNmIy/FjjU8ovoJrz9TV/Ausu2f+kh/C6sRe0Z7RVGdLfiMFccD9Hp
        6FmBppT1jvbbAqIIisgnk6FB1NlDyzv3x+8TzVJ8LhN+kS0aWJrsKd0NeA1Ht+HVWJHU95
        v4pLSDsHkSHEVr3FlMK1HAHgt4WhFkSWPalna77/NaU5cgnH+DbvTdeUEeMZTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666188729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z1E66GlY66yiLgq//IGcbPbMjBTix1nW1g6VhhORoME=;
        b=umHGKxzUeRxIAO3HcDPwb+8tOeKqlgXKkK+2TJztmiCuqYruxYydwd2/+2goDKgEVmCmxq
        S/4dvIceui1Rx4Ag==
To:     Xin Li <xin3.li@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org, brgerst@gmail.com,
        chang.seok.bae@intel.com
Subject: Re: [PATCH v4 0/5] x86: Enable LKGS instruction
In-Reply-To: <20221019102310.1543-1-xin3.li@intel.com>
References: <20221019102310.1543-1-xin3.li@intel.com>
Date:   Wed, 19 Oct 2022 16:12:09 +0200
Message-ID: <87ilkfaona.ffs@tglx>
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

Xin,

On Wed, Oct 19 2022 at 03:23, Xin Li wrote:
> LKGS instruction is introduced with Intel FRED (flexible return and event
> delivery) specification https://cdrdv2.intel.com/v1/dl/getContent/678938.

So I have two versions of the same thing in my inbox now. What's the
difference?
