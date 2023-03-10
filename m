Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B672E6B4D9F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjCJQvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjCJQue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:50:34 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DCF509A1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 08:47:49 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h14so5644052wru.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 08:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678466867;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U/LKz9Z+i8/pfBTy65hMgjCrFZDTBJvWaBtbp+nH9F8=;
        b=Ji9AJDYh+Ic/SOQplTPaZS0E8a+2hkIiyiOZciKrF1mm7az08TYfoeW0TwPpQYfvf9
         CrHM1x8rQpN9EzLHIWTNNd74wgiFHW8AtTzMhzBbuYEpkiER6QRzG40iytckNsSL+IRV
         Q7hZ3p4XsHi5cDlmf7QLzoXB8jl/wkS2aC0KOGDhhxRzReIssBN28Kee22LW8rulsO6Y
         2/U8T5IAG867JiWk2SYJRVSBJFLqLxZcqp8yvo09KsTGmTn3Ry4EBBRPxkYQvh7lNDev
         d9oYV3P50cqyyskRBbDgi5u4VpJoni3NEVDce3s8W49rxNaw4sGxoKc+3orJ9eIH4pfK
         7TUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678466867;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U/LKz9Z+i8/pfBTy65hMgjCrFZDTBJvWaBtbp+nH9F8=;
        b=fJvbI19QbPxwg94hmG9Qnbn1BzKuGO8CJnCmEdKn9pZCRsMBBJWxu5oGPTkZV6zu6e
         BeT8XQTgvKV+3P9KX6ZoQoSgZ8oEEHByjy8qqhsODu3+2JiFYAos5v9e3Te4433FxG0N
         INBnj9ZwtXle9Vp2SAlWtSS4pjHthZb7afJ8iUiYr1q48LaGBjNOZCRbXgr9HCcWVMaQ
         9PbkhaeiA8dh4QUi9MyRAa6qCXvoLu23CwygonvH6473ADqb6rERY6UhzvEfHzkOg5VG
         +7JAlgtqXl+vkB3+DRZrcfjwBDq09XF00xans20YykeVN+KVp28I+X1S4h3Liv5cVqXM
         LJ+w==
X-Gm-Message-State: AO0yUKVSFozq7AySG5pnrjlh9iq7zYcLoPhpC5ScAOzQK4sT4h+FLHI6
        cHHf7KvSI7qhiassUDHSBoSjhg==
X-Google-Smtp-Source: AK7set/oodN4OVmnyHcGHYwIoEfj4k6WxmAE3DKgRrwUzmL51ZJ0tqbollXaa3GQ+O3mki2sBL4lLw==
X-Received: by 2002:a5d:4b46:0:b0:2cb:72c2:3d12 with SMTP id w6-20020a5d4b46000000b002cb72c23d12mr15591639wrs.68.1678466867480;
        Fri, 10 Mar 2023 08:47:47 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id x4-20020a5d60c4000000b002c6d0462163sm205297wrt.100.2023.03.10.08.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 08:47:47 -0800 (PST)
Message-ID: <67590cd3-5543-59ed-6158-b272103ebd05@linaro.org>
Date:   Fri, 10 Mar 2023 16:47:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 6/9] interconnect: qcom: rpm: Handle interface clocks
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230228-topic-qos-v7-0-815606092fff@linaro.org>
 <20230228-topic-qos-v7-6-815606092fff@linaro.org>
 <50f03895-816f-be8d-d956-d237fb13f5a0@linaro.org>
 <6d10906e-08cd-0380-5f5d-3ac0eec60276@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <6d10906e-08cd-0380-5f5d-3ac0eec60276@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2023 14:26, Konrad Dybcio wrote:
> 
> 
> On 10.03.2023 15:21, Bryan O'Donoghue wrote:
>> On 08/03/2023 21:40, Konrad Dybcio wrote:
>>> Some (but not all) providers (or their specific nodes) require
>>> specific clocks to be turned on before they can be accessed. Failure
>>> to ensure that results in a seemingly random system crash (which
>>> would usually happen at boot with the interconnect driver built-in),
>>> resulting in the platform not booting up properly.
>>
>> Can you give an example of which clocks on which SoC's ?
> See for example 67fb53745e0b
> 
> This was a clock documented downstream under the node-qos clocks here:
> 
> https://github.com/sonyxperiadev/kernel/blob/aosp/LA.UM.5.7.r1/arch/arm/boot/dts/qcom/msm8996-bus.dtsi#L102-L109
> 
> but there are occasions where such clocks are undocumented and downstream
> skips them because it relies on them being on by miracle, such as the case
> of MASTER_IPA and the IPA rpmcc clock on msm8998. Downstream has no
> sync_state, so they would only set the QoS registers when the relevant
> hardware was online, so the clocks were on already.

What switched the clocks on ? Presumably LK.

Is this a symptom of using a bootloader other than LK ? If you use the 
same bootloader, then why hasn't the bootloader/LK already set it up on 
your platform ?

>>
>> Is the intention of this patch to subsequently go through *.dts *.dtsi and start to remove assigned-clocks ?
>>
>> Are we saying that currently there ought to be assigned-clocks for some of these NoC declarations ?
> Not really, assigned-clocks are used for static ratesetting, see
> for example dwc3 nodes where we need it to be fast enough for
> HS/SS operation at all times (though that should have prooobably
> been handled in the driver but it's a separate topic), I don't
> think any of them were used to combat what this commit tries to.

I think you could use assigned-clocks for that ..

So its not part of your series but then presumably you have a follow-on 
patch for the 8998 dts that points your ->intf_clks at these then ?

clocks = <&clock_gcc clk_aggre2_noc_clk>,
          <&clock_gcc clk_gcc_ufs_axi_clk>,
          <&clock_gcc clk_gcc_aggre2_ufs_axi_clk>;

It seems like the right thing to do..

Still not clear why these clocks are off.. your bootchain ?

---
bod
