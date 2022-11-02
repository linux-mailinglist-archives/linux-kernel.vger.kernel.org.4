Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF044616F57
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 22:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiKBVFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 17:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiKBVFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 17:05:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1022EDF31
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 14:05:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4880B8250A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 21:05:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B53C433D6;
        Wed,  2 Nov 2022 21:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667423114;
        bh=Qx1Z0ButEyWpo8X9guW947tzbbEMRctWfpxqnwuqzkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E2ZaMDBrXAeWBVhRZvTXGCsybElLDGyIKyZpfTb3IUhmX8areS6HyWJ39l87jfzEs
         qMC0yYBp/CkhFgz4ixuWbtsvPb+Q+VcmmYEh/GjGtL85EMilZKu9Yu12dnUbWbz1cc
         mex4efMIHoCQJm6QFlKmapPYdHiwae8TXYVXm2A3lo/IeebxrYt7S28b9B6j3Sm3NE
         mmWDOWclhYCmGIh1iujrBK2t7SL0nNndq/pXL4iiG3dZe+SWE5DHvmxNhPzGj4Sygo
         VsM+fxhJtgCUYUfr03CkACt9k2k6eLrPuAHPrb2AN6CvaGEQL3jDJagqGtYleJhTJh
         QLj9GgFJUGJhQ==
Date:   Wed, 2 Nov 2022 14:05:12 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: add static_call_inline.c to STATIC
 BRANCH/CALL
Message-ID: <20221102210512.nnspywtg265z7pst@treble>
References: <20221102084134.4094-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221102084134.4094-1-jirislaby@kernel.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 09:41:34AM +0100, Jiri Slaby (SUSE) wrote:
> From: Jiri Slaby <jslaby@suse.cz>
> 
> Commit 8fd4ddda2f49 (static_call: Don't make __static_call_return0
> static) split static_call.c and static_call_inline.c was created. This
> was not reflected in MAINTAINERS.
> 
> Fix it now by adding a static_call*.c glob.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Jason Baron <jbaron@akamai.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh
