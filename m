Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3A35ED3EF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 06:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbiI1EfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 00:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiI1EfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 00:35:06 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D774CA11;
        Tue, 27 Sep 2022 21:35:02 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1odOmh-0001yO-F7; Wed, 28 Sep 2022 06:34:59 +0200
Message-ID: <9df735b7-2963-9fca-aa7e-6ae993e8b948@leemhuis.info>
Date:   Wed, 28 Sep 2022 06:34:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US, de-DE
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, corbet@lwn.net,
        konstantin@linuxfoundation.org, krzysztof.kozlowski@linaro.org,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20220928003006.230103-1-bryan.odonoghue@linaro.org>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH] Documentation/process: Add text to indicate supporters
 should be mailed
In-Reply-To: <20220928003006.230103-1-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1664339703;3afc7d27;
X-HE-SMSGID: 1odOmh-0001yO-F7
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.09.22 02:30, Bryan O'Donoghue wrote:
> Recently when submitting a yaml change I found that I had omitted the
> maintainer whose tree the change needed to go through.
> 
> The reason for that is the path in MAINTAINERS is marked as Supported not
> Maintained. Reading MAINTAINERS we see quote:
> 
>            Supported:   Someone is actually paid to look after this.
>            Maintained:  Someone actually looks after it.
> 
> The current submitting-patches.rst only says to mail maintainers though not
> supporters. When we run scripts/get_maintainer.pl anybody who is denoted a
> paid maintainer will appear as a supporter.
> 
> Let's add some text to the submitting-patches.rst to indicate that
> supporters should similarly be mailed so that you can't do as I did and
> mail every maintainer get_maintainer.pl tells you to, without actually
> mailing the one supporter you need to.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

Looks good to me, but while at it, one quick question: Would
Documentation/process/5.Posting.rst (which sadly covers exactly the same
topic) benefit from a similar clarification, even if it doesn't mention
get_maintainers explicitly?

Which leads to two other question: Are there any other places that might
benefit from such a clarification? Or would it be even make sense to
change the format of MAINTAINERS to avoid the problem in the first
place? Maybe something like "Maintained(v)" (Someone volunteered to look
after it in spare hours.) and "Maintained(p)" (Someone is actually paid
to look after this.). Ahh, no, that doesn't look good. But you get the idea.

> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index be49d8f2601b4..5f97379da41da 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -227,9 +227,11 @@ You should always copy the appropriate subsystem maintainer(s) on any patch
>  to code that they maintain; look through the MAINTAINERS file and the
>  source code revision history to see who those maintainers are.  The
>  script scripts/get_maintainer.pl can be very useful at this step (pass paths to
> -your patches as arguments to scripts/get_maintainer.pl).  If you cannot find a
> -maintainer for the subsystem you are working on, Andrew Morton
> -(akpm@linux-foundation.org) serves as a maintainer of last resort.
> +your patches as arguments to scripts/get_maintainer.pl).  You should mail
> +everyone who appears as "maintainer" or "supporter" in the
> +scripts/get_maintainer.pl output.

Side note and bikeshedding: Not sure, I wonder if the 'in the
scripts/get_maintainer.pl output' can be dropped to make things shorter.
Or maybe even shorter along the lines of 'Mail everyone listed as
"maintainer" or "supporter"'?

Whatever, not that important.

>  If you cannot find a maintainer for the
> +subsystem you are working on, Andrew Morton (akpm@linux-foundation.org) serves
> +as a maintainer of last resort.
>  
>  You should also normally choose at least one mailing list to receive a copy
>  of your patch set.  linux-kernel@vger.kernel.org should be used by default

Ciao, Thorsten
