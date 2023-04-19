Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22166E7151
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 04:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjDSCqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 22:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjDSCqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 22:46:05 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54B59755;
        Tue, 18 Apr 2023 19:45:38 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6a437526b7cso879817a34.1;
        Tue, 18 Apr 2023 19:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681872330; x=1684464330;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E069ZTY6nFYszV+/5FzOjU5LbuCwW8x4gHc3aSQEBg8=;
        b=UhQs5Y/3zpq4zX5sMEGThvciVqiFLBfm1teJcsEZzz5FG1jhGuAJZkW4WWBG0z5odO
         sIXPLrBUHBnj8uidXCrTBCqtfVRG8xeEpmxLVT4wVF5v9L7mSJMNlOrg6HfxAg1TN5dR
         YJlOs7ksl1ob5qSztI2NE/qskge0XjDaEErG7SKNd9xxyH9QG3TH1LBOiA7wf8f4POs7
         agk65MtIa5mBrXA3Yv3GHJazl3hkeLYE/yUpkGWPB8cBiJSR8ViIxrBVPPpkobNj+paK
         XBKV6NG2FlizvxxbwP0GNoFJMjyPLaCxkz7LXDqjCF8abkw55v26qf3Q6kGodaDE5j3z
         vsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681872330; x=1684464330;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E069ZTY6nFYszV+/5FzOjU5LbuCwW8x4gHc3aSQEBg8=;
        b=bLT2Zb2BO41He+ZrGJNW+xuQSm1BQfm2B0q0MhIOB8S9Q9rDA2ZFTeiYFxJfwdSoT2
         0519txWQlYTwPTlv9JR3Lv7yUk6ta5yhxhswtOkvnraJlwuOfXyN76b1PSGPYWafA3PH
         FYv5Cpu/R/+QOIY8oJyb8s26vKg4s+l3BUwdj1NNqDz1PX2Az7LQletXPFUHwj/creyp
         mhRplPjWyUMfpidWAusKCePHyVNS16LrM4+r6tmXz+4KaapP31fEXEQGSC9w/zbvXzLA
         THED22DHMSNy9gyB2MagxpBwPCQ0Mvc28vknTTJviZ2Nr/Q1iSekiR1Shob4HKGZFV/z
         WNSw==
X-Gm-Message-State: AAQBX9fcH7ybEPKVeOUZSUEtOrd2YdlcM1ZqY7xteWU7u0Af0nraGXOq
        4vCQjJVs9vpIHb0AjjfJuD8=
X-Google-Smtp-Source: AKy350b+TpaRh7+IMRxW7bQHLeOF/kqFYVzDURhqDqBXE7Ss1mrHoC4nEcZ4sXwTsyTxEAG+z4Q4EQ==
X-Received: by 2002:a9d:6d0f:0:b0:6a5:cf29:f310 with SMTP id o15-20020a9d6d0f000000b006a5cf29f310mr2239494otp.34.1681872329921;
        Tue, 18 Apr 2023 19:45:29 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id m14-20020a9d644e000000b006a4308f1e2asm6165250otl.54.2023.04.18.19.45.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 19:45:29 -0700 (PDT)
Message-ID: <2fc535da-0d83-049a-53a6-e310d12a884a@gmail.com>
Date:   Tue, 18 Apr 2023 23:45:25 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] .gitattributes: set diff driver for Rust source code
 files
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jean Delvare <jdelvare@suse.de>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
References: <20230418233048.335281-1-ojeda@kernel.org>
Content-Language: en-US
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230418233048.335281-1-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/23 20:30, Miguel Ojeda wrote:
> Git supports a builtin Rust diff driver [1] since v2.23.0 (2019).
> 
> [...]

At this stage in the game such an improvement in diffs is required.

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
