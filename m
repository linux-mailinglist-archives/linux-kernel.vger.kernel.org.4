Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C106B9D10
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 18:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjCNRbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 13:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjCNRbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 13:31:37 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B191AA189B;
        Tue, 14 Mar 2023 10:31:34 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1E87E44A;
        Tue, 14 Mar 2023 17:31:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1E87E44A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1678815094; bh=gYung32wzcYpcSnwNv3MGdrXpgDOHF4vq1SMadpeIsk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=QyUiFDLvX+lQjLi+JBSZF5E+D8pdb2jLETCOkDYoDtDQA7sYbroRHY9xAUAJrlLpf
         7/Vg3Mf2XUAwL2drzu5qcIN2Ps+Zg8unCZPJitXDCsVJmdn1EzmFA2Et8jQNQxFMEZ
         yqzbjcQ3DvmpP1IPpVvzaM5OeQdwnhwcHiTm5BJBLT89XN47kZqbmliOyRzroiYQai
         QtbwmvGTcKhZQvfokE0q8ckBTzZALhypon214ox+HCL+WlAyGdCjRuJVHQtTcEYWo3
         9GG4S6lL8rjDowSPP2sb9Xjew4L78ht6vsjwU5mFG2Ezs964ZeLZTmdUuGXlgWYX38
         hrHXj2Os3V+hA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Xujun Leng <lengxujun2007@126.com>
Cc:     linux@leemhuis.info, lengxujun2007@126.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: process: submitting-patches: fix typo in section
 "Respond to review comments"
In-Reply-To: <20230312071423.3042-1-lengxujun2007@126.com>
References: <20230312071423.3042-1-lengxujun2007@126.com>
Date:   Tue, 14 Mar 2023 11:31:33 -0600
Message-ID: <87cz5btf2i.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xujun Leng <lengxujun2007@126.com> writes:

> In the second paragraph of section "Respond to review comments", there is
> a spelling mistake: "aganst" should be "against".
>
> Signed-off-by: Xujun Leng <lengxujun2007@126.com>
> ---
>  Documentation/process/submitting-patches.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index eac7167dce83..69ce64e03c70 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -320,7 +320,7 @@ for their time.  Code review is a tiring and time-consuming process, and
>  reviewers sometimes get grumpy.  Even in that case, though, respond
>  politely and address the problems they have pointed out.  When sending a next
>  version, add a ``patch changelog`` to the cover letter or to individual patches
> -explaining difference aganst previous submission (see
> +explaining difference against previous submission (see
>  :ref:`the_canonical_patch_format`).

Applied, thanks.

jon
