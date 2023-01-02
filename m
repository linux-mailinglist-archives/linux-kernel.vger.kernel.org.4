Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F8665AE54
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 09:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjABIne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 03:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjABInb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 03:43:31 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520562614
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 00:43:30 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id y25so40741839lfa.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 00:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0zgDfc5vV+ks7L9lsOcZvg6/12PB3ixvJBlCk3kqk0Q=;
        b=m6VArfIfjtmP77B3rJq1telzeUnIXzavr34WzBVHrd+i7OsAHS5At8fd+8ggv8jQAT
         PdnefcCroWfDEM29IHQy2tmJaD3fzPE3pIy9pdatukOHg68GC2xhhYt+YIYNrFvJWkiS
         k87ySjNsyiwCPtFOGR2//4oxoKNprbo+J5hlNZxBofD2dPQQTFwPyc+YPpndB/ZjxVdp
         Lnew0QIpkU1Nsh4rBjCpE5Oq5AkJtIsYS3JddKEFL9+OCtUhW3poHJV/ggVDzh/A28aY
         zW4Osbm03QRKzXD4H9qgJ4EfCmseHdiwxWNSqePKvixaPpdshcI/mHn8ojfvmWEN1YCx
         +9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0zgDfc5vV+ks7L9lsOcZvg6/12PB3ixvJBlCk3kqk0Q=;
        b=xRCEf37AceGQNfGwgZgiN/iph1maB0n24RNleaTIuZ8w16uigKgzPQeEhKXhKk7wfx
         ameFBHF7yHPMSZYKGzNFyAG/9GPperd/pq6Rp/McLEXBathcKrgLeNszWGM3KaNH3jwO
         RcTLsJLemR8o9qi52Q/keMEssa35N1z2+MVjXqZD8iBlUhv/nOMQro0qc8CtznRGf/2P
         HK6Il5rR6BW+2f1V4zcco/+3TV/EgcfmzPiPapYaDBUPY4I/jbcSBGR7qRIhMfv/fIR8
         y22n/h9kDJL86YQmDPoYyQB6IqhukyAMP+DlnnL3JGtXDzTTiVrm6YJu+1PxnrxPfLqs
         NwCQ==
X-Gm-Message-State: AFqh2koxEwEwiLFAV/H4nkub+DKoQ7wMpFeWwdU8zWNmKy9OTnDckIZB
        FSki7SF1SMlcDb/lrmW+V/63og==
X-Google-Smtp-Source: AMrXdXsJRgp4g9ne37qy+utK1uQKdWkgqrENKNSScYKNReDAZwe2mrl2oL6m1pZkMokXEM5OZ+Ts+A==
X-Received: by 2002:ac2:58d4:0:b0:4b5:9e70:ca6e with SMTP id u20-20020ac258d4000000b004b59e70ca6emr11259574lfo.17.1672649008669;
        Mon, 02 Jan 2023 00:43:28 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id 8-20020ac25f08000000b00494978b0caesm4378638lfq.276.2023.01.02.00.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 00:43:27 -0800 (PST)
Message-ID: <6ece10ff-cc8c-04b2-4afd-43db216227e1@linaro.org>
Date:   Mon, 2 Jan 2023 09:43:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/7] arm64: dts: qcom: sc8280xp: remove GCC from CX power
 domain
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221230160103.250996-1-krzysztof.kozlowski@linaro.org>
 <9bfe5409-3174-c3be-b0b9-55c5a857e834@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9bfe5409-3174-c3be-b0b9-55c5a857e834@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/12/2022 00:41, Konrad Dybcio wrote:
> 
> 
> On 30.12.2022 17:00, Krzysztof Kozlowski wrote:
>> Bindings do not allow power-domain property in GCC clock controller and
>> documentation does not indicate that GCC is part of VDD_CX.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Maybe the bindings should be fixed? Maybe this was added as workaround?
>> Anyway looking at documentation I do not see such relation, except
>> downstream vdd_cx-supply (which is the same as in other SoCs and we do
>> not represent it in upstream).
> Some clocks scale with _CX, which is annotated on downstream with vdd-levels.
> We take care of that by using opp tables in consumer drivers. Usually if
> power-domains is added to a clock controller, it means that at least one of
> the clocks needs the power domain to be on (which.. should be true for CX
> if the ARM part runs anyway, no?), as for example VDD_MX/VDD_GFX may not be
> on at boot and trying to enable such clocks would result in a big kaboom..
> 
> TL;DR: if nothing exploded, it's fine to remove it

According to Bjorn, we should keep the domain.

Best regards,
Krzysztof

