Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C715FA3A4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 20:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiJJSvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 14:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiJJSvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 14:51:16 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A572D786C6;
        Mon, 10 Oct 2022 11:51:10 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BDFC6299;
        Mon, 10 Oct 2022 18:51:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BDFC6299
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1665427869; bh=+TZRcAwBTYTWC5JRX8AjA6Hqoh2ap6RzLuC/0+B1gD4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=sOSqc6y1icXl+IU4Ip+0/4CEIR/pWCrVf8H8zDIYs8gijze9bxn7v8j873BQl74U8
         cS585CX1XxU/ZP6Jb4ds4tN4R5YN8oEXO8j7Fh3m9S6TObWk20fhsUGQc1S1cZHh3J
         0BGhxTKnweosCLc8IBJOKVjvZOmziw7QRUG10gnA7ew/eDcN86BDea3rJMhllXdAWj
         I9cm/hQxjsnqIldMIcRVz6WdTzfe7NheE9M3nmL99FIaMwli+hfyksphwAFuWaQW/S
         TSzBt1WGuju9w3tWK8OVw/Wk/bu6JYXHBD0bkaUJbPO12GZ4lVuLVZ4XP2moJkiHA9
         AHa340sLPT0zQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Leo Yan <leo.yan@linaro.org>, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH] docs: ftrace: Correct access mode
In-Reply-To: <20221008083250.3160-1-leo.yan@linaro.org>
References: <20221008083250.3160-1-leo.yan@linaro.org>
Date:   Mon, 10 Oct 2022 12:51:09 -0600
Message-ID: <87czazqzqa.fsf@meer.lwn.net>
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

Leo Yan <leo.yan@linaro.org> writes:

> The documentation gives an example for opening trace marker with
> write-only mode, but the flag WR_ONLY is not defined by glibc.
>
> Use O_WRONLY to replace it.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  Documentation/trace/ftrace.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index b37dc19e4d40..60bceb018d6a 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -564,7 +564,7 @@ of ftrace. Here is a list of some of the key files:
>  
>  	start::
>  
> -		trace_fd = open("trace_marker", WR_ONLY);
> +		trace_fd = open("trace_marker", O_WRONLY);
>  

Applied, thanks.

jon
