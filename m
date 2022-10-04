Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6785F4661
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 17:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJDPRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 11:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJDPRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 11:17:36 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A781D474C6;
        Tue,  4 Oct 2022 08:17:34 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id v186so13399685pfv.11;
        Tue, 04 Oct 2022 08:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date;
        bh=o/Qnk0eNKNJ6ZGt8jGGxdfhWV7waJkX23dqQr5nkoh4=;
        b=OesP8EiHZWCHqFLyRqZ5gjSWyCtvME+s30p0sZ1nRKtCSN1XDV/BQXDDRrA2jrXnGi
         TrkihTY8ai4Ur7YL7bBJ9NW9HQEL2CCGls7On1iQeR6of69/38MUV5arD82wtOC/9lgM
         HACYl2esbgE2Rv3UJvj152PG+sbUR8JfVl5O9PZlr4tgWHhOrHIQGv43Q4b9quyT3brx
         c817hZSxTHsqFT0qSbzpG0v4CwVbF0tcpTL+GQUBDnZ9uXJoYe6mL8hamYrSI0ob/Diu
         UVd9uJR8OW2jVC0nZLjY2H5vJjlJ4yu6+AWO7ZV00lIvMkaIIaQoEwub67P7lo9au8yk
         HCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=o/Qnk0eNKNJ6ZGt8jGGxdfhWV7waJkX23dqQr5nkoh4=;
        b=Z5EBAicRNG73bP8AZsPt2oVV9FIDTh48fwEQmUyGdN8IvlwhUzEpwwaRj/MK3frcFv
         R9HDhBWXCKHbg/ohfbfxBraP/ul/tY91SxGIJDTz+FvbLDnroMkas6kMONlpzB+kpYOe
         1ykxqlPHXbFLaeikkeaGzoXO0VQGGkDSo+UggyFehDAN5GtmfQdAmPOHk76FYxGqMJJY
         BHz7t016PMQOFwlNghP4YfHpGLhlpF2MT1ilzP/FjZMPfsxXbJ6vYb33LUoDWLG0AWPl
         +lZYOnzUVr36tHk8HLmt/lZ2hKdLRSwciY+9NjgUlD+zJCQRrlllykdy1CGo0lJ1ajlR
         PWEg==
X-Gm-Message-State: ACrzQf1NvIBzP4AtSsAk8ohup3d66JVI3I3hAsDIqOAmhnuHFeIBA92B
        q9E1jR8yDeLlk40ghbDCSxc=
X-Google-Smtp-Source: AMsMyM6aMgZnT0KMf3QlhgV81gcW2qAAxEXRSqOLbzoZyMlNVIPIQjEqkWtDdMi88b4lkoYJ2eemCg==
X-Received: by 2002:a05:6a00:b41:b0:52f:59dc:75 with SMTP id p1-20020a056a000b4100b0052f59dc0075mr28090537pfo.33.1664896654162;
        Tue, 04 Oct 2022 08:17:34 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id 66-20020a630945000000b00412a708f38asm8620558pgj.35.2022.10.04.08.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 08:17:33 -0700 (PDT)
Message-ID: <0a154bd0-f380-19ae-00df-5d73c1dc7c8b@gmail.com>
Date:   Wed, 5 Oct 2022 00:17:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v5 1/1] Documentation/process: Be more explicit about who
 to mail on patch submission
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net, linux@leemhuis.info,
        konstantin@linuxfoundation.org, krzysztof.kozlowski@linaro.org,
        linux-doc@vger.kernel.org, joe@perches.com
References: <20221004124858.640349-1-bryan.odonoghue@linaro.org>
 <20221004124858.640349-2-bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20221004124858.640349-2-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bryan,

I'll be silent on the word choice of "supporter" for the time being. :-)

On Tue,  4 Oct 2022 13:48:58 +0100, Bryan O'Donoghue wrote:
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
> supporters. Discussing further on the list the suggestion was made to state
> that the following are the right addresses to mail:
> 
> - Maintainers
> - Supporters
> - Reviewers
> - Dedicated lists
> - LKML as a fallback when there is no dedicated list
> 
> Add in a two sentences to capture that statement.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  Documentation/process/submitting-patches.rst | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index be49d8f2601b4..90fda3367a405 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -227,8 +227,11 @@ You should always copy the appropriate subsystem maintainer(s) on any patch
>  to code that they maintain; look through the MAINTAINERS file and the
>  source code revision history to see who those maintainers are.  The
>  script scripts/get_maintainer.pl can be very useful at this step (pass paths to
> -your patches as arguments to scripts/get_maintainer.pl).  If you cannot find a
> -maintainer for the subsystem you are working on, Andrew Morton
> +your patches as arguments to scripts/get_maintainer.pl).  In the output of
> +get_maintainer.pl the recommendation is to mail every maintainer, supporter,
> +reviewer and dedicated mailing list. If get_maintainer doesn't indicate a
> +dedicated mailing list linux-kernel@vger.kernel.org should be included. If you
> +cannot find a maintainer for the subsystem you are working on, Andrew Morton
>  (akpm@linux-foundation.org) serves as a maintainer of last resort.
>  
>  You should also normally choose at least one mailing list to receive a copy

Quoting subsequent paragraph:

  You should also normally choose at least one mailing list to receive a copy
  of your patch set.  linux-kernel@vger.kernel.org should be used by default
  for all patches, but the volume on that list has caused a number of
  developers to tune it out.  Look in the MAINTAINERS file for a
  subsystem-specific list; your patch will probably get more attention there.
  Please do not spam unrelated lists, though.

The paragraph you updated mentions the maintainers (as persons) to
send patches.

The subsequent paragraph talks about mailing lists.

After this patch is applied, they look mostly redundant except for
an important difference. In your patch, Cc: LKML is recommended only
when a subsystem-specific list can not be found. In the subsequent
paragraph, LKML is recommended to be Cc'd by default, in addition
to subsystem-specific lists. Does my interpretation wrong?

Doesn't the subsequent paragraph (quoted above) work for you?

If it does, you don't need to mention mail lists in your change.
Otherwise, you also need to tweak/remove the subsequent paragraph.

Thoughts?

Lastly, you submitted v5 within 24 hours from v4. Why so hurry,
especially in the middle of the 6.1 merge window? Actually, as v5
is the same as 2/2 in v4, there was no need of v5 in the first
place.

I'm expecting to see v6 of this patch after the docs-next branch
gets ready for the next development cycle. Until such time comes,
let's continue discussing ideas here in this thread.

        Thanks, Akira
