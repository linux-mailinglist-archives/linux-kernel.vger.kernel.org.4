Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C555F738956
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbjFUPdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbjFUPdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:33:45 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C3C135;
        Wed, 21 Jun 2023 08:33:44 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D3A002AE;
        Wed, 21 Jun 2023 15:33:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D3A002AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1687361624; bh=3ZFWDSO+reYFpGs4tZmQ5F6rDLf13sG+j5atW4bDLRU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=B23KwCXMs22lOyQcruAFR0CnFPI5/KUwTrf6/v0NULlPLAwVrqGqHIzNRfBXx6I5S
         2GIFKwhlRL7yWGa0bZ6ZD5LJdCe3+lBpRh0tWBDzuRRbIF5BQs0nXF77oD3GSoG8vs
         X14xrUymMe4ux6VIYrgM6Hjx0SHMl6vQrggC9rGp06enmLYdllmh70phhohKkaMAGk
         7zSSrPLM/iROTK1T5V2/B2LkDBkslz3fsHi7yKMMPi0B7niUNMDPOqxC+oDWS8vIsC
         qdifVxh8vi/Lj8j/q/qXGncssb+5LAgq5sCMROPm6l97q+WVEKVkpJD46sPbh8P2oh
         c2HYMMNGPNlqg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Costa Shulyupin <costa.shul@redhat.com>, linux-doc@vger.kernel.org
Cc:     Costa Shulyupin <costa.shul@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] docs: consolidate storage interfaces
In-Reply-To: <20230618062937.481280-1-costa.shul@redhat.com>
References: <87h6rhoyag.fsf@meer.lwn.net>
 <20230618062937.481280-1-costa.shul@redhat.com>
Date:   Wed, 21 Jun 2023 09:33:43 -0600
Message-ID: <87y1kcq17s.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Costa Shulyupin <costa.shul@redhat.com> writes:

> to make the page more organized as requested
>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
>
> ---
>
> Changes:
>  v4. rollback to single Storage category, add 'TCM Virtual Device'
>  v3. add Integrity, Virtualization and Miscellaneous per Bagas Sanjaya
>  v2. add Core subsystems, Networking, Peripherals and Embedded
>  v1. add Storage category
> ---
>  Documentation/subsystem-apis.rst | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)

Applied, thanks.

jon
