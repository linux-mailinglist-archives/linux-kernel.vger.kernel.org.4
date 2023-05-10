Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9390E6FE7F1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 01:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbjEJXHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 19:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjEJXHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 19:07:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCE3102;
        Wed, 10 May 2023 16:07:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75B98635F4;
        Wed, 10 May 2023 23:07:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3AA4C433D2;
        Wed, 10 May 2023 23:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683760067;
        bh=fgE25D1hp4IWtAFkK0USGG1ZKqXkY7wUpEJmfwsr3t8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DN+agf4q5MwKo4DomiNNQD1lQZveu+mTwkOk1NlmTwFSaiKklJNp88Ex+ZvwcwNUp
         TjcQRudm8pl9/bfmKneMPzrDktLsnrkjGkaFV3ofILXTs+cnY7A2cMulTzzQZPumM6
         Wvu6aJc1eCIgJ4gXPhW/UqfPoSdKSs1C+i/w8clI=
Date:   Thu, 11 May 2023 08:07:42 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Rong Tao <rtoax@foxmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Zhangfei Gao <zhangfei.gao@foxmail.com>,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: submitting-patches: Discuss interleaved replies
Message-ID: <2023051132-erratic-reshoot-0cb5@gregkh>
References: <20230510183423.never.877-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510183423.never.877-kees@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 11:34:26AM -0700, Kees Cook wrote:
> Top-posting has been strongly discouraged in Linux development, but this
> was actually not written anywhere in the common documentation about
> sending patches and replying to reviews. Add a section about trimming
> and interleaved replies.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Thorsten Leemhuis <linux@leemhuis.info>
> Cc: Rong Tao <rtoax@foxmail.com>
> Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Cc: Zhangfei Gao <zhangfei.gao@foxmail.com>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  Documentation/process/submitting-patches.rst | 23 ++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index eac7167dce83..3e838da8822f 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -326,6 +326,29 @@ explaining difference aganst previous submission (see
>  See Documentation/process/email-clients.rst for recommendations on email
>  clients and mailing list etiquette.
>  
> +Use trimmed interleaved replies in email discussions
> +----------------------------------------------------
> +Top-posting is strongly discouraged in Linux kernel development
> +discusions. Interleaved (or "inline") replies make conversations much
> +easier to follow. For more details see:
> +https://en.wikipedia.org/wiki/Posting_style#Interleaved_style
> +
> +As is frequently quoted on the mailing list:
> +
> +  A: http://en.wikipedia.org/wiki/Top_post
> +  Q: Were do I find info about this thing called top-posting?
> +  A: Because it messes up the order in which people normally read text.
> +  Q: Why is top-posting such a bad thing?
> +  A: Top-posting.
> +  Q: What is the most annoying thing in e-mail?
> +
> +Similarly, please trim all unneeded quotations that aren't relevant
> +to your reply. This makes replies easier to find, and saves time and
> +space. For more details see: http://daringfireball.net/2007/07/on_top
> +
> +  A: No.
> +  Q: Should I include quotations after my reply?
> +
>  .. _resend_reminders:
>  
>  Don't get discouraged - or impatient
> -- 
> 2.34.1
> 

Yes!!!

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
