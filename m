Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B884465DFFA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 23:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbjADW3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 17:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjADW3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 17:29:11 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2833FA12
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 14:29:09 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id m3so17843082wmq.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 14:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KqEImEb3zxFSZLJK5O28PW5QmA8rmOHB2VVdmPKgTSM=;
        b=nc2poSArYIkrQ9l7v8cc3glR6yoUpg0wzCRnHEeAW1jw5rZKve3Hf4XVvYWcL+2Aj8
         uIayBj1Xt7oKb7rooG/M+EIFXmPl3ad2RRuj99IB/S3PZDzrw67vGNGl1aKKVE5itRAv
         QA/eft6/1JfkusHMmTjnFE/xXSBOjzVWD53S0EKSgTwBJLYM7YbREXcJt0/PrQXt4G4J
         qIVS4kar4A1TJR9eifi6N/0kbTFbC0tM7Zsakh9IOGmAtS0+yjMXm6i+jaO/IBTtSyPa
         YnDRLSJMYsYLhexVmeiBk0qNgH2FEozlsQiDjh/895jyh2Qtz+Huum3RdVjssGdHs4td
         lGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KqEImEb3zxFSZLJK5O28PW5QmA8rmOHB2VVdmPKgTSM=;
        b=6MIFgLLubH7lhTd4wwbq9FOUwH2+F4cAuHRtJqg4o7eAdvc9RNir8vlz1LToIRgPMC
         MJ6AH27b+7Xwc35K+1PsrLpOxKwQQbmrSkGWKZUGvZYNV2+UbJX7uFnkJAGG2rdE3NRK
         fxtROYnN8KEJGBwJ5vf7xanHocxrMcQ8SEahakey8CX5r2kqiskhR2p173fMIbHR/utt
         Q9Hkz/6rYB16siITpRY0Qos2EPon6mKTtYKO3dFh91eWY6jOLinLVtaUwLEy1ZkgH3/r
         iNwvYMWdc/hfqbsd1K/IMi9jm4rpaiMxFoCzBfBvinxSU7lUPuDCT8VOb7Y5WIUa5Rtp
         y4MQ==
X-Gm-Message-State: AFqh2krSWS9kz4WhtWGE5kZOtP/gh/dKWI7slRz2Z7c+k2AHiDMFHBSt
        RG4HFWq4i3vWgms9xWzwmryMWaSgcATebaCv
X-Google-Smtp-Source: AMrXdXvosSW2IMXk+/+QjecXpbDsWIG5+bgibat8r06Du8mLR1UfEgwY7dPUUYm2db8dJYYS1As+5g==
X-Received: by 2002:a05:600c:34d1:b0:3d7:72e3:f437 with SMTP id d17-20020a05600c34d100b003d772e3f437mr35584965wmq.21.1672871348065;
        Wed, 04 Jan 2023 14:29:08 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id bg41-20020a05600c3ca900b003d1e34bcbb2sm236756wmb.13.2023.01.04.14.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 14:29:07 -0800 (PST)
Message-ID: <a9dba647-b307-e60f-c31a-3ef7f949d23e@linaro.org>
Date:   Wed, 4 Jan 2023 23:29:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] clocksource/drivers/riscv: Increase the clock source
 rating
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Prabhakar Lad <prabhakar.csengg@gmail.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20221228004444.61568-1-samuel@sholland.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221228004444.61568-1-samuel@sholland.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/12/2022 01:44, Samuel Holland wrote:
> RISC-V provides an architectural clock source via the time CSR. This
> clock source exposes a 64-bit counter synchronized across all CPUs.
> Because it is accessed using a CSR, it is much more efficient to read
> than MMIO clock sources. For example, on the Allwinner D1, reading the
> sun4i timer in a loop takes 131 cycles/iteration, while reading the
> RISC-V time CSR takes only 5 cycles/iteration.
> 
> Adjust the RISC-V clock source rating so it is preferred over the
> various platform-specific MMIO clock sources.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

