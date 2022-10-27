Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A40460F3B0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbiJ0J3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbiJ0J3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:29:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE64CBE0E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=+JOutcbc7GRNl3P9qo6jvKuTc9hJH1Pdy+f0Fv335qI=; b=hUjKj3vUBHXs45hGHA0eEjLhKl
        IilLhQ5QAquUr6DXH2TSyxYiu/ZilXpB2w3N1MCJxHch5EL0x5TWZaNyvRtbEwZn1dWeqjZ/jZy49
        BD/6gnklVlXifHMmemqX9WyIz6gtMnrx5RLRlz4CGjlRg0gmzpk1s3OjSBKsgCxN17CA+2cZ+5pPR
        iIMddJg8e2xLfSa//vEe4jv+Dvl257n5G+8ZAfGO07dEYzMkVAoclC/YBFnXPKvHsEjR7b559Ff1X
        T5yHzaG+7pOG8etDIRBQRVJkrmBeF8mfRv34POsOlRAlE2HJs4fhhui03HWd217/CgF9obx56p3ZI
        pmqlL3ww==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onzCd-006p4K-2S; Thu, 27 Oct 2022 09:29:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8C23230035C;
        Thu, 27 Oct 2022 11:29:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 67C452C450396; Thu, 27 Oct 2022 11:29:30 +0200 (CEST)
Message-ID: <20221027092812.185993858@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 27 Oct 2022 11:28:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 0/4] x86/ibt: Implement FineIBT
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Updated FineIBT series; I've (hopefully) incorporated all feedback from last
time with the notable exception of the Kconfig CFI default -- I'm not sure we
want to add to the Kconfig space for this, also what would a distro do with it.

Anyway; please have a look, I'm hoping to merge this soonish so we can make the
next cycle.


