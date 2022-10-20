Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B015605E72
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiJTLGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiJTLGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:06:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D42148F79
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SElGQfKNwDIPPSfTZApA4VvCfDdRlEWNuSutnH46FrI=; b=mB/lW4gBwHTQEJxpwW1VuwcMmi
        ygzJ/TF1XFh4WdGoFU4WtZrd2opJD278NmFWGaQXqaSF0TAXLi64433Mx0JEK6/ShSrWEPQsGs7L0
        f+u2k3SUjCJbN8fc38aQS5OANKFX0IQ3z90JED94RQR745hXj8smeQvRGhdz0RPqwi7nS8VIcCtqJ
        f40v/Kl0VkZRul5PuHE9DAoDRd9QoJN79E9P80iXPNZf/wZ+fJRZQ2lxDrgB/E6DuPQxMCs43SMQT
        uzHOZjq5hnGL6akyt65/dggN7ELEBst+is7EtATBMUDFVFVf2pMeU+VN4XzLNjlMLGcnoTuJHECkD
        RWmDUPZQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olTMu-0050yB-3w; Thu, 20 Oct 2022 11:05:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BAD9A300155;
        Thu, 20 Oct 2022 13:05:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AA8972857668F; Thu, 20 Oct 2022 13:05:43 +0200 (CEST)
Date:   Thu, 20 Oct 2022 13:05:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/ibt: Implement FineIBT
Message-ID: <Y1Erh7uWkRrCn/yP@hirez.programming.kicks-ass.net>
References: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
 <202210181020.79AF7F7@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210181020.79AF7F7@keescook>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 11:09:13AM -0700, Kees Cook wrote:

> And this is a good time to ping you about this patch as well:
> https://lore.kernel.org/lkml/20220902234213.3034396-1-keescook@chromium.org/

Can you add a little justification to that Changelog and repost? Then
I'll carry it in the fineibt branch.
