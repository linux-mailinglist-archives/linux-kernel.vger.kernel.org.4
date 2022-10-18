Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED79A602FC1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiJRPbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiJRPbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:31:42 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A86B2AC3;
        Tue, 18 Oct 2022 08:31:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7D874CE1E56;
        Tue, 18 Oct 2022 15:31:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA86C433D7;
        Tue, 18 Oct 2022 15:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666107098;
        bh=pMThLmUe8JKgBwypU3pW171ZlDw9EFP2zQHNHLDHkNc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aE/lteKLYkpQIaxj+t6CKbzC6+OCv4xdaA+0IvGQ9NWND6iOe1ymAvzXalzcU6re2
         wAoq3Tf2IqepDfU97rdNXKx1wjX79O0ort4Zb5lOhrrO+UaeymThUpqUV/UA6YJwQh
         /pYl3lAU1JwcY+b4/EbgiWthxzUaiKnTaHcENLJArxS5KkJesZ/8gw/8C/pAXbeS8w
         L1YsY0flUH3Da7+Qxl8bvJXfTMD5jURIeEruAVofSY2fGMDiTV1UGAWmqI3mBVHwwS
         4hyJCdvnqJCPwrnAPDvHUjd/GI8p/wz3KLsdkUeqdcvc9/ShTvasCYtyS9kIwY1DxU
         A0wIpCDD/9Zkg==
Date:   Wed, 19 Oct 2022 00:31:34 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     <rostedt@goodmis.org>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH -next] tracing/histogram: Update document for KEYS_MAX
 size
Message-Id: <20221019003134.cc24bd624cc6fca06a05206c@kernel.org>
In-Reply-To: <20221017103806.2479139-1-zhengyejian1@huawei.com>
References: <20221017103806.2479139-1-zhengyejian1@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Oct 2022 10:38:06 +0000
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> After commit 4f36c2d85ced ("tracing: Increase tracing map KEYS_MAX size"),
> 'keys' supports up to three fields.

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Steve, do you this this document fix should go into the stable trees?

Thank you,

> 
> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
> ---
>  Documentation/trace/histogram.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
> index c1b685a38f6b..87bd772836c0 100644
> --- a/Documentation/trace/histogram.rst
> +++ b/Documentation/trace/histogram.rst
> @@ -39,7 +39,7 @@ Documentation written by Tom Zanussi
>    will use the event's kernel stacktrace as the key.  The keywords
>    'keys' or 'key' can be used to specify keys, and the keywords
>    'values', 'vals', or 'val' can be used to specify values.  Compound
> -  keys consisting of up to two fields can be specified by the 'keys'
> +  keys consisting of up to three fields can be specified by the 'keys'
>    keyword.  Hashing a compound key produces a unique entry in the
>    table for each unique combination of component keys, and can be
>    useful for providing more fine-grained summaries of event data.
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
