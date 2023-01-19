Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F3C674480
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 22:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjASVcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 16:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjASV3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:29:39 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F2FA6C5E;
        Thu, 19 Jan 2023 13:24:17 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 42C0B2C0;
        Thu, 19 Jan 2023 21:24:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 42C0B2C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1674163449; bh=OXBuHSjhREkhVOFMFvVgcVeotLkhxzqh+RcIxz5mpjY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=RFe47zp7zE5uaFV/o/DeenmzYwBRmxX1uRk/Jyp9jXEA9mUWoa/UnR3xOyS/0AZNI
         rIdci9w8LeXE8s5OgAL8VzvYUTNhNId2PQwWhqOqY1LABBMeBTD9y/y1ORnYDFlg9t
         ZRDJN/Y2cFH6lohlRa2lCgE1dzZhO1Uzx+1naIoniW4sz6n//uVsPeYF9A8/66iDhj
         lNs8wL3svK8a9eH5XCsRisnGGYQkT6D9wKm9MA+AYLCHFr7IQg7ItasrsPxrJhIASl
         O97tCg1CHXudKkoE82a58cIiQwb2Lyx6BRIc1OEiWUf/ITNPXqkND11EtKMhiL6M2Y
         /HkmWmeInJNTg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Sohil Mehta <sohil.mehta@intel.com>, linux-doc@vger.kernel.org
Cc:     Sohil Mehta <sohil.mehta@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/vsyscall: Fix documentation to reflect the default
 mode
In-Reply-To: <20230111193211.1987047-1-sohil.mehta@intel.com>
References: <20230111193211.1987047-1-sohil.mehta@intel.com>
Date:   Thu, 19 Jan 2023 14:24:08 -0700
Message-ID: <87v8l26ww7.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sohil Mehta <sohil.mehta@intel.com> writes:

> The default vsyscall mode has been updated from emulate to xonly for a
> while. Update the kernel-parameters doc to reflect that.
>
> Fixes: 625b7b7f79c6 ("x86/vsyscall: Change the default vsyscall mode to xonly")
> Cc: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
> Do documentation fixes typically get backported to stable? I haven't included
> a stable cc assuming they do not.
>
>  Documentation/admin-guide/kernel-parameters.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

jon
