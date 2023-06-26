Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C5F73E139
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjFZN4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjFZN4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:56:34 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22B010E7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:56:23 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-510d6b939bfso4606312a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687787782; x=1690379782;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YNkTRN3dLJhfF0fBZPrManul45eQh1TTTEwrKXf8yYU=;
        b=Z1BCZ31HKQWwBvbjnZz67uqPsh9x2HEvtfVGCv8Ee8ytcZ2Wm+PPwYgeqU8eXfKx/w
         +gSOBCPOMzsHCpCR7tkhtaL3lvE8NhDsV3/mJK5M5msv30o8lp9sVfjr7hhxvm8mBFY0
         DbARrA5owQEodKdVMpFyz6n8eRik6pd1SQ3EnCNF5UPg0GRZiIZT0Ub7plI/4r62SLPh
         /qnMIpo5QH2an7TT7bbnX4I7+PsBdckXGbclhaHvJc2/E0VEhT4LTG0C9NCGVA8Roar8
         Woylb5OlTDGTSmUPWWSfKv/PujbxqxIpaUrjXgaUzI85O6nVSWYehtM8z49QSbOY32xY
         upcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687787782; x=1690379782;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YNkTRN3dLJhfF0fBZPrManul45eQh1TTTEwrKXf8yYU=;
        b=V1wRJl4tQxpnA+i/IULd4R2IJc5raGXvZN8Qmc4Oi1c9Y0LG4YXXEVDf7o5xXt1mPT
         p2b6O+uj0NNx8HFRDrY34yTG5DOwJ9gh6nfFVB/sDZMSTjskBG6LPe7DNZFR4SxMauY1
         ZVz6HNw/5zu1Yj1JT/RMJ8r+z456U7oL1bXmPUjUst63j0zACuNculr/9J0X+zwEW5Qs
         CmFZg1Owg3rPpRXx7g5YXuQhxtEROHLAu8wmEp0zwRiL9tJ0zMjaUHKsmQvMdkR0T9XM
         y/9SHXcru9A01xfOBOysM5ZoTB4PSbbb6u41ZBxGvSAsv/p85wIAaqJ+byqArpem9Ajb
         lAEA==
X-Gm-Message-State: AC+VfDwF92GICYwr2LQSMeGQ1w2bwFzVWJNjCEHiXCT28PNxIplJQUQ7
        FBiuwGKePPElZqe8rK3vgYw=
X-Google-Smtp-Source: ACHHUZ4KoP8kqWYMGEF9Tr3EJ0dUwAsYN7Tt5F+nB4vaav5UvJ2zcYEXr3hvrG2w3kZ3suqFCHPmPw==
X-Received: by 2002:a05:6402:517:b0:51a:53e0:843e with SMTP id m23-20020a056402051700b0051a53e0843emr18375500edv.23.1687787782184;
        Mon, 26 Jun 2023 06:56:22 -0700 (PDT)
Received: from [10.100.102.18] ([83.136.201.74])
        by smtp.gmail.com with ESMTPSA id s22-20020aa7cb16000000b0051bed498851sm2945751edt.54.2023.06.26.06.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 06:56:21 -0700 (PDT)
Message-ID: <030a99f7-98f3-a24d-612c-d460859fc276@gmail.com>
Date:   Mon, 26 Jun 2023 16:56:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC v4 07/13] regulator: find active protections during
 initialization
Content-Language: en-US, en-GB
To:     Benjamin Bara <bbara93@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     support.opensource@diasemi.com,
        DLG-Adam.Ward.opensource@dm.renesas.com,
        Martin Fuzzey <martin.fuzzey@flowbird.group>,
        linux-kernel@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
References: <20230419-dynamic-vmon-v4-0-4d3734e62ada@skidata.com>
 <20230419-dynamic-vmon-v4-7-4d3734e62ada@skidata.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230419-dynamic-vmon-v4-7-4d3734e62ada@skidata.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/23 23:03, Benjamin Bara wrote:
> From: Benjamin Bara <benjamin.bara@skidata.com>
> 
> It can happen that monitors are activated before the kernel is started,
> e.g. by bootloader or by OTP. If monitoring workarounds are active on a
> regulator, the core shouldn't perform the state changes without applying
> the workaround to the regulator. Therefore, warn the user already during
> initialization that the device-tree should be adapted.
> 
> Warning can be fixed by enabling (or disabling) monitoring in the DT,
> e.g.:
> regulator-uv-protection-microvolt = <1>;
> or
> regulator-ov-error-microvolt = <0>;
> 
> Constraints regarding the monitoring of a regulator can usually be found
> in the docu.

I am not entirely sure if this is the right thing to do. Should we 
expect the hardware state to be what is described in DT at Linux boot-up 
- or, should we silently accept the fact that for example boot can alter 
things.

 From the 'code pov' I have no complaints though. I just can't say if 
warning is the right idea. I'll leave this for bigger brains to decide :)


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

