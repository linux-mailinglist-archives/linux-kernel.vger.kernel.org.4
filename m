Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486E65F1BD0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 12:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiJAKhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 06:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJAKhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 06:37:08 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8F831ED3
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 03:37:06 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id n10so10306633wrw.12
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 03:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=UGccuhm9cpmtP9WyN3yJuaVY3UI9eJnTZjoYg0v6920=;
        b=ik1qOwh9yoRWHQfXnGVYeLY9/gjNLCOgtOoa52JqSs8Dd3s305mdkahxiVy2YDHvzy
         R9JV/91hi6VSyt8C/bIvEdUxLSF6dv+w4uMhg0TgTzcMjrNlOD6NBeyOB7hR5vUE2R5e
         91ZzawtedcE0a0wiS4h3xkDmvF/UEWwxguI1kaA10BoPCUTTqbOHLDmidjeA15TbLTfN
         seNnLFrvbMMXFmqesmgMFDNFwB3JAgtKbJXDGLD4qFSYSFPxMWc7UIjdXcT+WtN+JF0M
         AnXn7CilZB3D3IhYDqSq58zx1x6pMwb3TKhjYoYUDii4TU32gZnli+fMIWTCq5U2djwu
         /+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=UGccuhm9cpmtP9WyN3yJuaVY3UI9eJnTZjoYg0v6920=;
        b=bfoxfofl97kuDno6YZysYVnju9D0blTbxmSR9dimqe4ecscioMiNburGHoG4Vzid8x
         eva9BOjRsWAk2GhVY5KUiipCET1LkCtAPE4G2edyv9CQXfpz9jxNLnQNpKJCY4e5jumu
         dmLiwOP0Jl4+eOGMdCuCQgpKBig6fuVJMLLiH8BV1Wq/e43ZFFxmjF4ljZoM0J4uCr4J
         y4JN0Ehu5sy3p75qVhIVwHGNZbC65Hi20VfGvYTlM82mFE6d2Ddt6u+bxI4M8WxsmckT
         DeoMGZLcc/DyreEjM3TX8/EjSTEYcA9Z2j3PsjSRnXHi4hn2xnDHb/WOvEZVw5EeI7Bb
         IpcA==
X-Gm-Message-State: ACrzQf2XfcAvNHRIjSnDWZClms729X5jaO+JC7SYJiDWRvv9qmhKLf5n
        0wQMJvOn2BZzPPo3ffGVyGeYBv0aJhUrwg==
X-Google-Smtp-Source: AMsMyM4ampmRc3jhx66tJ/hyv+StX86HWv/IAG6zE8Wr3UTy0u6bJRZMf01ZPbe0DDfFlyPiyWDPMA==
X-Received: by 2002:adf:dd8b:0:b0:22c:ce50:1841 with SMTP id x11-20020adfdd8b000000b0022cce501841mr7966106wrl.44.1664620624866;
        Sat, 01 Oct 2022 03:37:04 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id s9-20020a5d69c9000000b0022e0580b7a9sm2992945wrw.17.2022.10.01.03.37.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Oct 2022 03:37:04 -0700 (PDT)
Message-ID: <70759d05-2646-57e5-0b87-3a196488f622@linaro.org>
Date:   Sat, 1 Oct 2022 11:37:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3] Documentation/process: Add text to indicate supporters
 should be mailed
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Akira Yokosawa <akiyks@gmail.com>, corbet@lwn.net,
        konstantin@linuxfoundation.org, krzysztof.kozlowski@linaro.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@leemhuis.info
References: <20220930064629.329514-2-bryan.odonoghue@linaro.org>
 <21f8d79a-0ad4-b28b-15d8-f4be0cfd9730@gmail.com>
 <b119fee5-807f-1940-3378-f5ad638794f5@linaro.org> <Yzen4X1Na0MKXHs9@mit.edu>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <Yzen4X1Na0MKXHs9@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/2022 03:37, Theodore Ts'o wrote:
> FWIW, I actually think the output of get_maintainer.pl is pretty
> broken in this regard.  (Then again, I've never thought all that
> highly of get_maintainer.pl,*especially*  because of the bogus git
> fallback, but that's another story.)
> 
> Consider:
> 
> % ./scripts/get_maintainer.pl --file  drivers/acpi/power.c
> "Rafael J. Wysocki"<rafael@kernel.org>  (supporter:ACPI)
> Len Brown<lenb@kernel.org>  (reviewer:ACPI)
> linux-acpi@vger.kernel.org  (open list:ACPI)
> linux-kernel@vger.kernel.org  (open list)
> 
> I'm sorry, but that's just*wrong*.  Rafael is the*maintainer*  of the
> ACPI subsystem, and the term "supporter" is rarely if ever used
> anywhere in our docs.  As I said earlier, trying to treat S: field to
> say anything about the entitles listed under the M: field of the
> Maintainers file is a category error.

I agree, I made exactly this error.

I wasn't sure how people would necessarily feel about having 
get_maintainer produce the string 'maintainer' for both Maintained and 
Supported but, IMO it is more consistent to have it do so, since we 
refer to maintainers all throughout the doucmentation and as you say 
above Rafael is the person you *need* to mail there because he's the 
maintainer.

Lets consider

- maintainer as a string for "S: Supported"
- Documentation update to reflect Krzysztof's point on git-fallback

---
bod
