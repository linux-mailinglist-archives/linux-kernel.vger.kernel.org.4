Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647D05FDE57
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 18:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiJMQhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 12:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiJMQhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 12:37:40 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FA6147079;
        Thu, 13 Oct 2022 09:37:38 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1FF7F7DE;
        Thu, 13 Oct 2022 16:37:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1FF7F7DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1665679058; bh=MPnAEr/uKZleldeAslfNMPix687dnUHgUseD/nzIDaM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=rpueZBUUc+RL/2ZVpZX/jvpJgi9ENHtBYPnOJWxH3jEXAxLHOAu8B3khSVkAr22HL
         2tRGlCFSIkXHeykTQbLzXGwYenqYjwC7vv0x2QERklYsSiIU1+VOlwCSGPTnXXm+p7
         dAuGnB6KvkmHFSyVnSFQkgYV+xC11+isAI2u5WEJivxEod4M7KvUqtidF+W1UbQQMv
         7KNk69ZVWiaPUBDt+U/HjiDKnQztBszL7lqWM4UvBsmQvOri5bFVjoRqxGTFe0OErU
         SM+l0HxzLdNZcDeZ+h2p7/0/GiE/jpejen59G+xKCw3d7wXJnUSgzgTvIFdRM/Npv5
         k0gH3VuSvgTtA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: rtla: Correct command line example
In-Reply-To: <20221006084409.3882542-1-pierre.gondois@arm.com>
References: <20221006084409.3882542-1-pierre.gondois@arm.com>
Date:   Thu, 13 Oct 2022 10:37:37 -0600
Message-ID: <87tu47isry.fsf@meer.lwn.net>
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

Pierre Gondois <pierre.gondois@arm.com> writes:

> The '-t/-T' parameters seem to have been swapped:
> -t/--trace[=file]: save the stopped trace
> to [file|timerlat_trace.txt]
> -T/--thread us: stop trace if the thread latency
> is higher than the argument in us
>
> Swap them back.
>
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  Documentation/tools/rtla/rtla-timerlat-top.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/tools/rtla/rtla-timerlat-top.rst b/Documentation/tools/rtla/rtla-timerlat-top.rst
> index 1c321de1c171..7c4e4b109493 100644
> --- a/Documentation/tools/rtla/rtla-timerlat-top.rst
> +++ b/Documentation/tools/rtla/rtla-timerlat-top.rst
> @@ -39,7 +39,7 @@ higher than *30 us*. It is also set to stop the session if a *Thread* timer
>  latency higher than *30 us* is hit. Finally, it is set to save the trace
>  buffer if the stop condition is hit::
>  
> -  [root@alien ~]# rtla timerlat top -s 30 -t 30 -T
> +  [root@alien ~]# rtla timerlat top -s 30 -T 30 -t
>                     Timer Latency

Applied, thanks.

jon
