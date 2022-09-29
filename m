Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4235EEF04
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbiI2HaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbiI2H35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:29:57 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1F61EAFA
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:29:51 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id p5so566393ljc.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=JPYvy93CWgU2khSZYKN1aQzD3T4YNwYIBEs2RfQWO6s=;
        b=eflHmrY61qGstkuuycwzkkokq1KLWpHwYjIMMlKpXiQ8GqSNY+CEOoVDZXH8Dee3Ai
         kGXlIJZ6FoR35MldQu5RlYEHE1SEl9muYv9gU75bTZytOVlCCmTzHr7UkyXWsdo6Z7sg
         GpgwIM6kvLDGICTMggA5vL/0eyYL/lQS0tdAtDsVLyEVqL/4cGMmIqQO29eKV0JKXVd7
         cxl2swx7EYJNb3cq8YQDG+l/N6KHirAjHs7HiBwX+a60rypw5/S6WWOXdPZhw0SLbWHL
         YZBnk8I2GJKpDWnnU/N18yWjd1cycSfkylV18XBS5xInDdx2jLOdKBymyEtgfx7dr7kQ
         +4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=JPYvy93CWgU2khSZYKN1aQzD3T4YNwYIBEs2RfQWO6s=;
        b=Lt4X70V2MFNxBqyVTDtubIeXt3XZQbg/eVV/UktYOyD5/TtUlsHeOY/CTFEnKTPf/7
         BtPLiyHZXy9CawtKRBY5TNAEk+OiqWDZDRfMycUUBcn3euuE9hOJICmw1/JCGddmNBqC
         8o1n84+GY0v4hYXCLYfxmV3STLz4WtR5WiA5MJU3/jfwIZOksG5idIYc9Y+P/WpkKOa7
         nvtmFlMAbNpoTS+I551a7yCcP5odW4We1kahoKJDrv664S6W+y+Jca+WFzCZkYWiP4/l
         fAacptWmXL1oOW1DssLX8tn0R+Zjpgp6a7cBOkgp63czDSKaTDdK1oKcsA4YGWAwf/1H
         sOXQ==
X-Gm-Message-State: ACrzQf29A0KpIBl/Q9F7kUu2n1F53arYidz+U0JXJC+crQhR3GXYzVr8
        ox3+xMHuXP/vR21qYd1oF0sxuuBxvzwgNw==
X-Google-Smtp-Source: AMsMyM6yXJn7Jim8QVPeAMyRjqVkElY9pE5G2ZV9AlrnuwNiIJ7ihQSMZWBVmIMkk6jjwxJhA1+nNw==
X-Received: by 2002:a2e:9d94:0:b0:26b:de12:7c9 with SMTP id c20-20020a2e9d94000000b0026bde1207c9mr634387ljj.244.1664436589835;
        Thu, 29 Sep 2022 00:29:49 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id e2-20020ac25462000000b0049fe6f36880sm706195lfn.51.2022.09.29.00.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 00:29:49 -0700 (PDT)
Message-ID: <54a19490-aa0d-2dcd-8407-319d6167add4@linaro.org>
Date:   Thu, 29 Sep 2022 09:29:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 2/2] Documentation/process: Add text to indicate
 supporters should be mailed
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, corbet@lwn.net,
        linux@leemhuis.info, konstantin@linuxfoundation.org,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20220929002500.283481-1-bryan.odonoghue@linaro.org>
 <20220929002500.283481-3-bryan.odonoghue@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220929002500.283481-3-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2022 02:25, Bryan O'Donoghue wrote:
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
> ---
>  Documentation/process/submitting-patches.rst | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index be49d8f2601b4..aabccaea93375 100644
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
> +everyone who appears as "maintainer[volunteer]" or "maintainer[supporter]" as

As I said before, this still ignores reviewers. I don't think it is
going to good direction. The submitter is expected to CC
everyone/everything which is pointed by get_maintainers.pl except the
Git-fallback entries.

Best regards,
Krzysztof

