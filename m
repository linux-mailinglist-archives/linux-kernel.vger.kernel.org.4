Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAB76BA165
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 22:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjCNVXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 17:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjCNVXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 17:23:40 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B5F4FF13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 14:23:38 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id h7so9345426ila.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 14:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678829017;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lxuM4RGN6BlLke1o4GIxUxY3khRpRz3CJd1nnGUC+3c=;
        b=FQ3JQEtyeqZauYAWSK1zzIDKfI5c6KIdkTPO3eB2R9jABliTfilvQdFVO3RvBjG+vB
         wOlvWgoUwrgGixBowbFjPQ9TH+gaZkZSs1UXYEdCHYtBDRiQbaVv9GXEq5vPq7I1YBW7
         kmgQfUmFDDdkZWkIuXcojy/3Tgq/t6zRld/2fgBiOWyF0FyLUmd/kMJKHVX+ax2o/RG/
         sVTD5lm9LQg0HyoX/+2cTbyUYZIe3C7pqqrRf4LEXW/2Yknxwv9gHwehQThpF8zLIhMs
         NfNmWpITjxg5aWwj6+sUO3yULhtJMY/bOuGOA6Fglz6Pg7PfWZdwr3CXM36gKTGt2MXF
         yu6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678829017;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lxuM4RGN6BlLke1o4GIxUxY3khRpRz3CJd1nnGUC+3c=;
        b=2zidZuf+vkSwJAiddWHTO0WbyoMqqtxx/mEgXSLD9kUhTGCm625NVSY3D9YYPhDWMG
         BqaprP6P+2C1kcFKeL66bcjw2wVdY8vMgOQV8Xzc8CxMH5vYqTuxfKFQlZgUaL8Me24Y
         8AbyNpWCkouxB+MVy9dKONvCYtOpw7QFBj1L2+vttL15s9zrLqkx4qehQYLFuFRN0PGp
         OXS5yR0cAB3L6VfiwWHYzjYNBUrMy4tmCQBo9NcqQj12BqYw2v67D0GPjJa+6WewRJs2
         7Ck+2vHIsEUOTzmUz197BGWSgUQZKLOw/4m8x6tTCg07P5oJzZImATjepxDny74PXBCF
         kKhw==
X-Gm-Message-State: AO0yUKVo6HYMLhe8St/LU96He0mxQJ1zGUd1zN1m+nkELY18h9il49AT
        NO4quh0+nJmmPtcB+yyaNL5C9w==
X-Google-Smtp-Source: AK7set8iZsqHi6RtunD35UZRzSvRrd+rfXSMR3j/iUIMcRv6g1q8OZiJse+/unht3pdTFOIRHw4woA==
X-Received: by 2002:a92:d5c5:0:b0:315:7fec:f1f0 with SMTP id d5-20020a92d5c5000000b003157fecf1f0mr2887363ilq.7.1678829017479;
        Tue, 14 Mar 2023 14:23:37 -0700 (PDT)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id r13-20020a92ac0d000000b003230b8aa2d6sm1071935ilh.57.2023.03.14.14.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 14:23:37 -0700 (PDT)
Message-ID: <b134781b-f28f-57c0-3ebc-9dba28d51074@linaro.org>
Date:   Tue, 14 Mar 2023 16:23:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH net 0/4] net: ipa: minor bug fixes
Content-Language: en-US
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     caleb.connolly@linaro.org, mka@chromium.org, evgreen@chromium.org,
        andersson@kernel.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230314203841.1574172-1-elder@linaro.org>
In-Reply-To: <20230314203841.1574172-1-elder@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/23 3:38 PM, Alex Elder wrote:
> The four patches in this series fix some errors, though none of them
> cause any compile or runtime problems.
> 
> The first changes the files included by "drivers/net/ipa/reg.h" to
> ensure everything it requires is included with the file.  It also
> stops unnecessarily including another file.  The prerequisites are
> apparently satisfied other ways, currently.
> 
> The second adds two struct declarations to "gsi_reg.h", to ensure
> they're declared before they're used later in the file.  Again, it
> seems these declarations are currently resolved wherever this file
> is included.
> 
> The third removes register definitions that were added for IPA v5.0
> that are not needed.  And the last updates some validity checks for
> IPA v5.0 registers.  No IPA v5.0 platforms are yet supported, so the
> issues resolved here were never harmful.

Sorry, it seems I used the wrong hashes in some
of my "Fixes" tags.  I will post v2 of this series
tomorrow.

					-Alex


> 					-Alex
> 
> Alex Elder (4):
>    net: ipa: reg: include <linux/bug.h>
>    net: ipa: add two missing declarations
>    net: ipa: kill FILT_ROUT_CACHE_CFG IPA register
>    net: ipa: fix some register validity checks
> 
>   drivers/net/ipa/gsi_reg.c |  9 ++++++++-
>   drivers/net/ipa/gsi_reg.h |  4 ++++
>   drivers/net/ipa/ipa_reg.c | 28 ++++++++++++++++++----------
>   drivers/net/ipa/ipa_reg.h | 21 ++++++---------------
>   drivers/net/ipa/reg.h     |  3 ++-
>   5 files changed, 38 insertions(+), 27 deletions(-)
> 

