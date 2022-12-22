Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D10B65482B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 23:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbiLVWDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 17:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235669AbiLVWDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 17:03:42 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E23527CDF;
        Thu, 22 Dec 2022 14:03:39 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 436A8C01C; Thu, 22 Dec 2022 23:03:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1671746630; bh=J9cbmNLcnEnCzcBsTSDM83r/CZk2MSdV+XdK2UiVhRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yrc8ExY0fLJTTRWHTlch4Cyxv5EtIeitomlHj/m+ith2ighEVLQ6n2zRleruRC6iK
         qZfblkCg9qAB1MZ2kwCJHpAfuvPggLa863smMTButGcD9cRu+sniJ9RDZFT4Tar5j+
         Q3ZajyhrLBW7JKD/HySrXL4tKtMQKDLpTNnzAX+cv4VOJ0aClp2E/N91/ZL6Lr5kz/
         ID7/p/lu7O0czxyVNVwaGDY6hWIqiMA1UO0lw3+/P79cbPGbhf1RLr0RzTsSjgkIcm
         UzmXioU+AKcv9ooLREIlB8SpKxfgakyELc4UNtelHklGoEkuhUWRFH2sKq+wvpVN/G
         b3/zZaoMAL/kQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 3303CC009;
        Thu, 22 Dec 2022 23:03:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1671746629; bh=J9cbmNLcnEnCzcBsTSDM83r/CZk2MSdV+XdK2UiVhRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sN5SexYGLTywPu95AlPDl6xzCCf0WMMlvUROicG3DAfP5QeDpfD3rcxAiY9/y5fK7
         pWLoEi7+tJJftjgsMEDsss8t3v6SGZMPQScgFS2UJzUeSfi/DfEzsos+rzGgkOiZR/
         zhsYkZn+kJHISFOrv2bqWpZra6OeevrzOG0RrtlfQhlTFkSeZmdJpIm2vvtFpC2XbU
         CQ3VCHYcAjs3g1+UsTI5oOYlAPc4xSEVKmx5+PhHHT6ClGjWAEfyBd1VZkA6cYMmVW
         X9TjGhXQqZBr9IeRLFvKBpXMOEfs3a4LT41SunCI2nJACJE9jKRxurz1tE562ICieL
         zrYXBCYgZLijg==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id f1ad2f5f;
        Thu, 22 Dec 2022 22:03:32 +0000 (UTC)
Date:   Fri, 23 Dec 2022 07:03:17 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     oss-security@lists.openwall.com
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [oss-security] [patch] proc.5: tell how to parse /proc/*/stat
 correctly
Message-ID: <Y6TUJcr/IHrsTE0W@codewreck.org>
References: <Y6SJDbKBk471KE4k@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y6SJDbKBk471KE4k@p183>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote on Thu, Dec 22, 2022 at 07:42:53PM +0300:
> --- a/man5/proc.5
> +++ b/man5/proc.5
> @@ -2092,6 +2092,11 @@ Strings longer than
>  .B TASK_COMM_LEN
>  (16) characters (including the terminating null byte) are silently truncated.
>  This is visible whether or not the executable is swapped out.
> +
> +Note that \fIcomm\fP can contain space and closing parenthesis characters. 
> +Parsing /proc/${pid}/stat with split() or equivalent, or scanf(3) isn't
> +reliable. The correct way is to locate closing parenthesis with strrchr(')')
> +from the end of the buffer and parse integers from there.

That's still not enough unless new lines are escaped, which they aren't:

$ echo -n 'test) 0 0 0
' > /proc/$$/comm
$ cat /proc/$$/stat
71076 (test) 0 0 0
) S 71075 71076 71076 34840 71192 4194304 6623 6824 0 0 10 3 2 7 20 0 1 0 36396573 15208448 2888 18446744073709551615 94173281726464 94173282650929 140734972513568 0 0 0 65536 3686404 1266761467 1 0 0 17 1 0 0 0 0 0 94173282892592 94173282940880 94173287231488 140734972522071 140734972522076 140734972522076 140734972526574 0

The silver lining here is that comm length is rather small (16) so we
cannot emulate full lines and a very careful process could notice that
there are not enough fields after the last parenthesis... So just look
for the last closing parenthesis in the next line and try again?

But, really, I just don't see how this can practically be said to be parsable...

-- 
Dominique Martinet | Asmadeus
