Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE025644C93
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 20:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiLFTfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 14:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiLFTfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 14:35:51 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D624387D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 11:35:50 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id l11so21861543edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 11:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WponI/OPvT2mcKk8dSrH3qaEn42D5K3v3G8XrPmRpsk=;
        b=OdxbijA70i9J53/AspRFrAMIP/Z5xK9PGlFLF0FzSq3QZT9PV2KYfAE930hMWeIZRE
         QzDCA7oDOSltTWxshuGDkFcazRCrz2KreOhBWPPtj0PUgqp2IqKs6jZjKyeO1Mu3I9Er
         0cFpOoIiiywnNgfvTRRHnHgCpnA3/U2W8Jl6ST+EENwQa1uXxNvyKcGgvatjCK+cPzIc
         FKOP2AstKicp8cKUq1/ZK1AC1B0/WpvQ1Gj0jj9CC3xmARgUD44Vvr+iQVVrUCa6XVeD
         A3tzoR+3Ns2F3JuBlhgAzFdpV1jy6b1DtvknWoz2k6InjjOIgFu7ExGlFuGvBZVev3OS
         Mi3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WponI/OPvT2mcKk8dSrH3qaEn42D5K3v3G8XrPmRpsk=;
        b=1C9tcZticI3b8zoByYngSY0l8TAE65lf5fpX4VGhpB4/zDuS8x3FIg1AfsdKjB4xvj
         uQrCQT/lozB0j383BKasT0SRDAVdglDxjTCjnmYP/UFNoezn3/j4oY0xNZDqQOzsVyC9
         0gr+k5nyzERewpx4CjTAI1pGNyIJP7WWqlQU0CDEKZVGxHbmzFtL8J7eqOQP8Jabnupy
         rTMekOlTUTSYhd99Ap2uYj+ETRedhLRkxe0LbsuvYLLVCtKK/dPzAZFcMdlijVQsE//H
         69xJd/AEfczKSKTDlCWlF+QKBJhY1ElwcPXjBEqKCQ0yR1hv90jaLweKTmO+SjZ/QFY0
         R8Uw==
X-Gm-Message-State: ANoB5pljkiI23sz3pfnuEbgfwrMXopf5JXWj0l1H/20W7ZF5F7n2nzJo
        0LdrjiGUzLRyi6Eue94UKtTTeA==
X-Google-Smtp-Source: AA0mqf5WbHP6QRYexxGulOL+ronjmWrCEU5oYEOi/Z9KlvjMcSc8JQ4FERp6VhWuHCGGbcTT1fL4wQ==
X-Received: by 2002:a05:6402:248e:b0:461:e2ab:912d with SMTP id q14-20020a056402248e00b00461e2ab912dmr63906605eda.93.1670355348784;
        Tue, 06 Dec 2022 11:35:48 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id dn18-20020a05640222f200b00463b9d47e1fsm1326366edb.71.2022.12.06.11.35.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 11:35:47 -0800 (PST)
Message-ID: <c338d813-dbcd-776b-3c46-d3779bfea522@linaro.org>
Date:   Tue, 6 Dec 2022 20:35:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH 0/2] Add SM4250 RPM power domain support
To:     Bjorn Andersson <andersson@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bhupesh.sharma@linaro.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        bhupesh.linux@gmail.com, agross@kernel.org
References: <20221127112204.1486337-1-bhupesh.sharma@linaro.org>
 <167035076344.3155086.2883117402843264050.b4-ty@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <167035076344.3155086.2883117402843264050.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/12/2022 19:18, Bjorn Andersson wrote:
> On Sun, 27 Nov 2022 16:52:02 +0530, Bhupesh Sharma wrote:
>> Add RPM power domain support for SM4250.
>>
>> Cc: Bjorn Andersson <andersson@kernel.org>
>> Cc: Rajendra Nayak <rnayak@codeaurora.org>
>> Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/2] dt-bindings: power: rpmpd: Add SM4250 support
>        commit: 45ac44ed10e58cf9b510e6552317ed7d2602346f
> [2/2] soc: qcom: rpmpd: Add SM4250 support
>        commit: 5b617b1b10c1c6a4365d8f956032e95c53b8e388
> 
> Best regards,
This may deserve a revert.. it's a 1:1 copy of 6115, which, well..
is the same SoC, lower binned. And they share a common dts.

Konrad
