Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076E26F4902
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 19:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbjEBRQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 13:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbjEBRQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 13:16:10 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5008C10D5;
        Tue,  2 May 2023 10:16:09 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BA0F844A;
        Tue,  2 May 2023 17:16:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BA0F844A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1683047768; bh=HLjhLmEt6uZUUg5tiAvtcISQ613CriNHuNgTGoABfDY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=VwxYl2gNXwlcMCTlCGtKRlYSwwcxCZ97K77RZxNTQgFZhIYIysmQxY9Z7Wd4niqlq
         igK+TdvnFtAAeUQQEDkR6iydK4VT/USiw6gkrqqNBy6EgevgFjymiDRTeROkfE89ez
         40cXM75Tou2hjNqZFhSBAxaiVakTobJhFc/fJVCMDfI02bPPiQAVhmBaI1fKiy9seI
         1gge2tOzK4bXdlzuRoyyeftyqoHgyKy+ac1nnKBL1SRp6xdQbBkknWtNr3DIGa6kJT
         SpcGTeP153GwSsis6FAf4AWlZeyJN/S21CRlcLepsNufLmn/ii6b48O58hRykjJg0a
         //fDsQ/eymiRA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        mauriciofb@gmail.com, Carlos Bilbao <carlos.bilbao@amd.com>
Subject: Re: [PATCH] docs/sp_SP: Add translation of process/adding-syscalls
In-Reply-To: <fc88992d-dfda-0265-5199-d6cae3ba3260@amd.com>
References: <20230315143526.1213813-1-carlos.bilbao@amd.com>
 <fc88992d-dfda-0265-5199-d6cae3ba3260@amd.com>
Date:   Tue, 02 May 2023 11:16:07 -0600
Message-ID: <87ilda7iy0.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Bilbao <carlos.bilbao@amd.com> writes:

> Hello Jon,
>
> I applied on top of my most recent docs-next version:
>
> 0b656310bfc33c5e044df9cf6013df8280ec69cc ("docs/admin-guide/mm/ksm.rst fix
> intraface -> interface typo")
>
> and it worked, and make htmldocs too. Could you please tell me what errors
> or warnings are you experiencing?

How did you try to apply it?  I get the dreaded:

  Applying: docs/sp_SP: Add translation of process/adding-syscalls
  error: patch failed: Documentation/translations/sp_SP/process/index.rst:18
  error: Documentation/translations/sp_SP/process/index.rst: patch does not apply
  Patch failed at 0001 docs/sp_SP: Add translation of process/adding-syscalls

The problem was this hunk:

diff --git a/Documentation/translations/sp_SP/process/index.rst
b/Documentation/translations/sp_SP/process/index.rst
index 351bcd3921ba..a0ff2e132c54 100644
--- a/Documentation/translations/sp_SP/process/index.rst
+++ b/Documentation/translations/sp_SP/process/index.rst
@@ -18,3 +18,4 @@
    email-clients
    programming-language
    deprecated
+   adding-syscalls

I have your addition of magic-number.rst applied, you seemingly did not
when the patch was generated.

Figuring these things out takes time.  Next time something like this
happens, can you just regenerate the patch against the current tree and
resend?

Anyway, I've applied it.

Thanks,

jon
