Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD436C415E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 05:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjCVEAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 00:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjCVEA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 00:00:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD5747403
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 21:00:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C52D661ED7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 04:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3F8C433A1;
        Wed, 22 Mar 2023 04:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679457624;
        bh=QIV/cEnEzL7WBeJCOmt5xLvQJhUqQpKK+8+VlbgRk9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DRtffnoaIadl3zDBIZesmRxjD8edsN+2yBdx/qEFRedOIbG7vm/wd/vaCVGYRbtuS
         KARPX0xGOhlinI3MIcmkd9iZKFfObhdEV5pfqyCBQHxxodGVjUQZxPULLhFNSK0BB8
         dN2kTQnEIxwZJpK+JQwQkBJ8r9JjwhONwgtwcfvgMADbYf5zqA648zN8nqQKdEu6MW
         AEuKrDTswZ3El4E/2xyPbz8OLnckHqjSPIzzzrewTNqnv7ufpWcxq2YCAx3UlQ0CHW
         xvcTDoEwZGVVhx0vCUBk7gbNix834HehgKGfPJuY1KQeYiqETcb6/Hopx2tuBY3vgO
         sioRJ9KUG1EyQ==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will McVicker <willmcvicker@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 03/11] static_call: Remove static_call_mod_init() declaration
Date:   Tue, 21 Mar 2023 21:00:09 -0700
Message-Id: <3b07f3830d7e4e967cc9714dbf54b7391f35cf8b.1679456900.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679456900.git.jpoimboe@kernel.org>
References: <cover.1679456900.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function doesn't exist (and never did).

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/linux/static_call.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index f984b8f6d974..890ddc0c3190 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -177,7 +177,6 @@ struct static_call_tramp_key {
 };
 
 extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
-extern int static_call_mod_init(struct module *mod);
 extern int static_call_text_reserved(void *start, void *end);
 
 extern long __static_call_return0(void);
-- 
2.39.2

