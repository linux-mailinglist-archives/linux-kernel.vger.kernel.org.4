Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB036B8925
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 04:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjCNDp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 23:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjCNDp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 23:45:57 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7DD559C1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 20:45:54 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id i3so15233163plg.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 20:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678765554;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vWfZOB/vp5s9CQfk70psxpuLfStVwAPuG8vm3AXMbVw=;
        b=A03pzeGi/87a/CEGd3BSGBnVCHjVSIdVFN+Y9dTEyPE/i9Pa10dPsNKQlQSHTq2dCj
         n5e42F9zsyGnyNOo7rHjtUuOWTFndoq0Y5DDkWkY4DxmmQo6yA+29YRuftpzgzFRlEDb
         QM6BTlbBh+NqHj8d9DbH2s24m/CWUvFc1Mf046Pwm9V2+tM+eW5FvguW6b7CQJ46IISr
         B7CoJJXGvhu7tHC62xJeQ0PkgNSEpF1YFok5FF6AMvVvuXn5yeyDLCr5vA7dC0/YpMWi
         isxD+FrtKUL68lF8oM0IAqlBR9ZwX466SC8vXxyrR3CQbOt1/DSxSN+TLolb/1BGwRvJ
         Sh1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678765554;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vWfZOB/vp5s9CQfk70psxpuLfStVwAPuG8vm3AXMbVw=;
        b=ApkxS12k0F71KjIIs8VC1vk9BHxy8logQ+UysBrKzjaDV0DDV85UMtZwPJUHqyGaFO
         OdIXzzL7uvr7KpscGzYz21WOn7qc+ONk1XLB6IdzIEhaogNJhmdz2rctnPrYiFAajGY5
         qr1cznbuMkaYSnsnwAs/l5UF5WUS7CQr5r4R/DjmpnvOPn89vykMdN3QqD/eYS+JQUyO
         s3DMqJzE1m2mGxIIcWo2bn896jzjhy4LBi54cLDzyJ0D+Ep4FTYvYpNFkTYDJF21yD0j
         JXm0p3ixv2W/OM12T7Zpuufg7WQwxafbpa7yCxjHXYe5LEueeJ0DzGcTk+1RM8dH0n//
         sorw==
X-Gm-Message-State: AO0yUKWaRyaa4bINT6d8L+Hn7+UsWZjfsb5dKSt2aidJuVwKTgDHusid
        YRNcthusfnRiWQjHnHXjjjADW0n/2efD+bXZj0A=
X-Google-Smtp-Source: AK7set90GKcN+w/4U0AuRg6iPs6d/KGH/W2GMNH+vKFp9MJfkZOgAGYBvq4hKrg93Y9OMQ8+BoXuTg==
X-Received: by 2002:a05:6a20:1609:b0:cc:d44a:bec2 with SMTP id l9-20020a056a20160900b000ccd44abec2mr42619757pzj.1.1678765553966;
        Mon, 13 Mar 2023 20:45:53 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c5e:4a3e:15d0:d540:3861:ef0e? ([2401:4900:1c5e:4a3e:15d0:d540:3861:ef0e])
        by smtp.gmail.com with ESMTPSA id k2-20020aa792c2000000b0056bc5ad4862sm452123pfa.28.2023.03.13.20.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 20:45:53 -0700 (PDT)
Message-ID: <55cb151e-b97f-43ee-e06f-63aaa376d6a4@linaro.org>
Date:   Tue, 14 Mar 2023 09:15:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] arm64: dts: qcom: sm6115: Add remoteproc nodes
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, linux-remoteproc@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
References: <20230128054256.2100501-1-bhupesh.sharma@linaro.org>
 <5922cd55-060c-d1b1-0eb2-0875439e4268@linaro.org>
 <4b6df5f4-d5e5-30f4-dc1e-a8e5f8c66363@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <4b6df5f4-d5e5-30f4-dc1e-a8e5f8c66363@linaro.org>
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



On 3/14/23 2:33 AM, Konrad Dybcio wrote:
> 
> 
> On 13.03.2023 21:58, Bhupesh Sharma wrote:
>> Hi Bjorn,
>>
>> On 1/28/23 11:12 AM, Bhupesh Sharma wrote:
>>> Add the adsp, cdsp and modem remoteproc nodes to sm6115.
>>>
>>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>>> ---
>>> - Depends on the dt-binding and driver change submitted via [1].
>>> [1]. https://lore.kernel.org/linux-arm-msm/20230128053504.2099620-1-bhupesh.sharma@linaro.org
>>
>> Gentle Ping. Since the dependencies (dt-bindings and driver changes) have already been merged into linux-next, this patch can now be applied.
> Not really, it won't apply as-is. I suggest applying the version below
> which was rebased, the reg was adjusted for 64bit addressing and the
> -names were turned into vertical lists, I've been carrying it downstream
> for a while and can confirm it works - I even got Wi-Fi up on the Tab P11!
> 
> https://github.com/SoMainline/linux/commit/a34e0bf410318b573820254bd241fef0ea013ea1.patch
> 
> (this is a git am-able plaintext patchfile)

Please send out your version for review, without which remoteproc is 
currently not functional on SM6115 / SM4250 SoC based boards.

Thanks,
Bhupesh
