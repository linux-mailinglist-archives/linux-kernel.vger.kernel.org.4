Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9E96B83CD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 22:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjCMVMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 17:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjCMVMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 17:12:16 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393B68F70F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 14:11:45 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id h9so14030165ljq.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 14:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678741902;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ne8t/EiBvW0vN7e00XtbUoK+necbXV5F7cPmVrqdNM=;
        b=V2h2U+d+Dex99u0OVHypIVA9yi1R24KgZ7AScDuvenlrLmxii7Q1cqzK+VOj0FXGpS
         1RGzB0M5xnK4uvE5SuVFxMtTJPLp33C1AQKKc09Fl4M66bjdkU+vCUJxduSGRTQ5gP2e
         Y8djXinS36evWOyVEKwwjdFz84tZqZwB5T3Ldqm0YUIhM2JuGWKbq8km1H8Rmd4KqNxp
         Wkmu9hywCPreCD3MPmTGDUdO9dqiEVomgladMm6aOIPF7HllSEZmalSsgsQ5+1uG8WCS
         Ix9eXiBkhEabNz3aNBNg8tl2+e0Y2bNDVNyx9qTyZ6Pily6Xzsbj4P1Ghg4qeR0g7+mp
         5eCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678741902;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ne8t/EiBvW0vN7e00XtbUoK+necbXV5F7cPmVrqdNM=;
        b=4b2egQruWjlEomKS+cgYwbJzzPLQwM8rp+7idrATEG6jdJRwEa6rfxqesQIRZC9lc8
         El5XPeQCbe5jeGC4Y6t24kfYYkp9MBXHlygPrOgJRVMaYCEQEZp+OFbwU/xel1hY0n9a
         4Q0/JCrYxhXmZHOM1tQNwRdhrXUMPyqfd+ScCrX6+cVwBjOzHUFqASInAiwDEMrd4eAK
         JnLSAsPBNQv/Km9v1OXMy39bi+C7EjUlbr0tEG0TsFIAlXeooboUeitpRAqRWnyKXYvC
         4g4vIvNwl032L+3MD2dFvs7Y5/7QOcQi6xXBC9lNMZif+Zn9mDTKCXzbI2LEbu/qxnqM
         VaUA==
X-Gm-Message-State: AO0yUKWI3YfTp4YQWa4ink8ozKKkg7wWA1Mkz7dYv66lQXTCVxMloqHz
        47bd/H5JNsiDWo/8Y4IyXZyeeJ85l7ZUdHglRXM=
X-Google-Smtp-Source: AK7set+4+MDDr8Imm37JZRDfAWvvfr51MtYpj0mcq32Kq6EuEp70Ub2edl/UE0Wce4DElwi6S/mfAA==
X-Received: by 2002:ac2:44b4:0:b0:4db:1e4a:74a1 with SMTP id c20-20020ac244b4000000b004db1e4a74a1mr9472348lfm.0.1678741425726;
        Mon, 13 Mar 2023 14:03:45 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id g22-20020a19ee16000000b004d61af6771dsm101299lfb.41.2023.03.13.14.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 14:03:44 -0700 (PDT)
Message-ID: <4b6df5f4-d5e5-30f4-dc1e-a8e5f8c66363@linaro.org>
Date:   Mon, 13 Mar 2023 22:03:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] arm64: dts: qcom: sm6115: Add remoteproc nodes
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, linux-remoteproc@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
References: <20230128054256.2100501-1-bhupesh.sharma@linaro.org>
 <5922cd55-060c-d1b1-0eb2-0875439e4268@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <5922cd55-060c-d1b1-0eb2-0875439e4268@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.03.2023 21:58, Bhupesh Sharma wrote:
> Hi Bjorn,
> 
> On 1/28/23 11:12 AM, Bhupesh Sharma wrote:
>> Add the adsp, cdsp and modem remoteproc nodes to sm6115.
>>
>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>> ---
>> - Depends on the dt-binding and driver change submitted via [1].
>> [1]. https://lore.kernel.org/linux-arm-msm/20230128053504.2099620-1-bhupesh.sharma@linaro.org
> 
> Gentle Ping. Since the dependencies (dt-bindings and driver changes) have already been merged into linux-next, this patch can now be applied.
Not really, it won't apply as-is. I suggest applying the version below
which was rebased, the reg was adjusted for 64bit addressing and the
-names were turned into vertical lists, I've been carrying it downstream
for a while and can confirm it works - I even got Wi-Fi up on the Tab P11!

https://github.com/SoMainline/linux/commit/a34e0bf410318b573820254bd241fef0ea013ea1.patch

(this is a git am-able plaintext patchfile)


Konrad
