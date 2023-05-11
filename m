Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D282C6FEE96
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236438AbjEKJVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjEKJVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:21:47 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF0C1A6;
        Thu, 11 May 2023 02:21:46 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1px2UX-0002A5-NX; Thu, 11 May 2023 11:21:41 +0200
Message-ID: <6c1f853b-b051-c390-267e-1ea1741e8537@leemhuis.info>
Date:   Thu, 11 May 2023 11:21:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To:     Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rong Tao <rtoax@foxmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Zhangfei Gao <zhangfei.gao@foxmail.com>,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230510183423.never.877-kees@kernel.org>
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH] docs: submitting-patches: Discuss interleaved replies
In-Reply-To: <20230510183423.never.877-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1683796906;6a8a3a56;
X-HE-SMSGID: 1px2UX-0002A5-NX
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.05.23 20:34, Kees Cook wrote:
> Top-posting has been strongly discouraged in Linux development, but this
> was actually not written anywhere in the common documentation about
> sending patches and replying to reviews. Add a section about trimming
> and interleaved replies.

Thx for doing this.

> [...]
> ---
>  Documentation/process/submitting-patches.rst | 23 ++++++++++++++++++++
>  1 file changed, 23 insertions(+)

For some reason we have duplicate code^w documentation for this, hence
I'd say the same or a similar text should also be added to one of the
filed in Documentation/process/[0-9].*rst ; from a quick
Documentation/process/6.Followthrough.rst might be the best one.

Maybe in fact the text should move there and submitting-patches.rst
should have a much shorter version, as it's meant to be the terser of
the two docs about this.

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

s/discusions/discussions/

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

Nitpicking, feel free to ignore: maybe "s/replies/responses/" or
something like that, as at least my stupid brain accidentally thought of
the email reply (as whole) when reading this for the first time.

> +space. For more details see: http://daringfireball.net/2007/07/on_top
> [...]

Ciao, Thorsten
