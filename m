Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171346B04DB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjCHKop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCHKom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:44:42 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8083B9CBE2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:44:41 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id t11so20755977lfr.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 02:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678272279;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30MEqz3ekoK9YrvibKSzcjJnUJXtLtERwbSpRRNxC10=;
        b=jZ11m4Ek6uQmMhCrEbnw8WqWxDHzr40K21uTTyT/b99ifrq6mNEDR+ivYcK0ffVrwU
         ClggEht8mHzBnhjcMBFUa7TQbFOvmb/1UWKf90q+mw9pWBMiURYKcHthW81fqH8+1XIc
         icfKYw63IBcyoIUhYISsMmLNeUTcNs4eehLZKQZLZWqDMaxNUUEyldda72G9VSpc3YVV
         FXJFzLocy+n3alonU0ZVBhWpMXxqMqUZPrvokkSiJFdVJ4aRSIMQAjnpSz09ZNucevmX
         I6OUqxKY/7lKcOSmXOt5WetN4W4PhdtF+5qesAz904Rc6IufNE3bJI+Nyv7Lf1eCLud2
         C6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678272279;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=30MEqz3ekoK9YrvibKSzcjJnUJXtLtERwbSpRRNxC10=;
        b=1IB8ZIoiC38Y4XDy8SfNqxMsKFgbr48fEaeIgWU0ohRJ4RHDuCn4sHLc54gMg5s7c7
         BdbFZiROL99pU1+wAgTefugD4bpDAvl+lvxds6f4XsCPao2+50uRVDxVBq4jZyItNcMk
         vx3SJjj4QtTeQsWy1hLb5FvK6B3VsdjBvVxa+0UWVhKjmCYD7cZr7PxkhauduPtU+gDS
         4EPc4Ys6ZXOVAaBy4LyIq1HkEcSKbA3BEmBlfMxWqivTPkXolbbMhP6yqO6UpNZrxSK/
         /3YC+eLoZo4bKqrMQ8zR2kj5Ya3fQTykyJiP0kjrIhPqzCn2ay6OKEpo3TQN8ZfXtW8q
         6YSg==
X-Gm-Message-State: AO0yUKXiJfi9fzrJNcGhRzVG0QBGvEUn3aamsyQ/wqDhN84WTGYVCQ9N
        TjUgAj6luhxX5MKoJsQ89rj/fAo5xpcKtLpPOpA=
X-Google-Smtp-Source: AK7set9zvECOfCfy9i7ALwKCer+9dc6UCIzzQBu3X9/3XlfC5cbM+uHHqv8H6QiPk5rCZbI8gASXTA==
X-Received: by 2002:a19:c501:0:b0:4bb:8d56:d859 with SMTP id w1-20020a19c501000000b004bb8d56d859mr4868010lfe.6.1678272279559;
        Wed, 08 Mar 2023 02:44:39 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id u3-20020a2eb803000000b00295733a3390sm2465537ljo.101.2023.03.08.02.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 02:44:39 -0800 (PST)
Message-ID: <197ea188-c59d-6c53-77fd-3a0551ef8e70@linaro.org>
Date:   Wed, 8 Mar 2023 11:44:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     lkml <linux-kernel@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Qualcomm Kryo core compatibles
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I was recently debating what to do about Qualcomm Kryo compatibles.

There are basically 3 cases:

1. Falkor/"real Kryo" - the (never shipped?) server platform & MSM8996

This one's easy, it's actually Kryo so it should stay Kryo.


2. Fake Kryo ("customized" Arm Cortex cores) (MSM8998-SM8x50)

This one's tough.. Qualcomm marketing material seems to sometimes say
Cortex, sometimes Kryo, sometimes "customized Cortex".. They do use
their own arm IMPLEMENTER_ID in the MIDR_EL1 register and their
PART_NUM values are not Arm-stock, but these cores don't seem to be
any special.. Maybe some irq lines are routed differently? Not sure.

My proposition here is to do:

"qcom,kryoXXX", "arm,cortex-ABC"

or

"qcom,kryoXXX-PQR", "arm,cortex-ABC"

where PQR is one of:
- silver (LITTLE cores)
- gold (big cores)
- gold_plus (prime core(s))


3. Arm cores modified within Arm implementation-defined allowance (SC8280XP+)

These cores report Arm IMPLEMENTER_IDs and actual Arm PART_NUMs, which would
suggest they're bone stock Arm Cortex cores, with some Qualcomm-iness coming
as part of implementation details which are.. expected since Cortex allows for
some IMPLEMENTATION DEFINED things. The only non-obvious part here is that
the REVISION field they report does not always seem covered by the Arm TRMs.

In this case I think going with

"arm,cortex-ABC"

is fine.. I already did this for 8550 and 8280xp and Rob seems to have liked it.

So, I suppose the real question is what to do about 2., should they stay as
they are, or maybe my proposition seems attractive?

Konrad
