Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CE4732FB0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345346AbjFPLUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345693AbjFPLUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:20:14 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8444F137
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:20:13 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f76b6db73fso2200878e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686914412; x=1689506412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eFIQ3Myqtm7sii87UwaNck4C4nWaVTmZTLsGYbc8xfY=;
        b=p5H768eOWhFiOXeo6YbLCcquIQBlj47ACO+rY67miqdpxnlJ/IqFHaenn+VNH3bKxk
         nAo1kZHye8yRm5jo8tedjoS+cDE6OIu5t7X7qkoUvcBLEDJ5bbaClnJ7yJhlJ+ancDlo
         CvKwrW4C/4bniWBE8O6S425Ujcrdr68Tn+vN4hsFV3cx2/IanLGjv0rzVyufU3lJz9iY
         98MboibzXtqqbmyy+60kIfQozAVrhZ/8wkYzs7zQIuMf+/U5Z/JZ/+o9G5ojtiolC75C
         ja6Grpklor/J9D6Kx88XHcjUwDjp0ZGffaUmrkClb2F7QKvSkhohcrQZ4HhG//zfmeCX
         Pjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686914412; x=1689506412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eFIQ3Myqtm7sii87UwaNck4C4nWaVTmZTLsGYbc8xfY=;
        b=JhWewdKzmno95kqwUIwE5hTsUQI4UompblLzqWya0Br+1SzF3w6cq/B2U2vb2jsLkM
         Jikj5Pokjl6m7ymUhDUIp8Uf/vjOEXEQR4vRc6qGPFZLcY2I19hH2WF8X7Y1jd/XIzAw
         ue03K9boYm00BaoxcIch06L6+8a08eeFEOJaqiuIfeUmZJ5g5NV7CelFJf9mu7RRZ4xX
         /7Pj59RPskObgHaPDEjMHJhyQQAfsgP9iIMC6dmY7dAdbaPa/iSssWOJCg44Fl0oRG2v
         GYpIFYi69zZP5uTLzy4KDMwzELuRWvFpYZhX3ldhdnaPjRE8E30AYDvAKDaksrOHhYpb
         S1Mw==
X-Gm-Message-State: AC+VfDypyQ6ZFb4jKNLMwyBErCEQLa2/anhjY8b5mztwQHz5UUcAUxjz
        /0gpCvMeh48zqBn0lCTSlh3R0w==
X-Google-Smtp-Source: ACHHUZ7arutSzdgQGQWvBda4JAsatKQdrakXgRwiAuDBAmmGtyVaUMmsXXnbB/R3wE+6l6bVkzeDxw==
X-Received: by 2002:a05:6512:2247:b0:4f7:6350:6bee with SMTP id i7-20020a056512224700b004f763506beemr3039168lfu.16.1686914411779;
        Fri, 16 Jun 2023 04:20:11 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id v27-20020ac2561b000000b004f2391fe9a6sm950194lfd.266.2023.06.16.04.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 04:20:11 -0700 (PDT)
Message-ID: <a5605da0-5b6a-cfeb-f095-bbf963551c08@linaro.org>
Date:   Fri, 16 Jun 2023 13:20:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Mark SCM as dma-coherent for
 trogdor
To:     Stephan Gerhold <stephan@gerhold.net>,
        Douglas Anderson <dianders@chromium.org>
Cc:     andersson@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        konrad.dybcio@somainline.org, sumit.semwal@linaro.org,
        Will Deacon <will@kernel.org>, amit.pundir@linaro.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>
References: <20230615145253.1.Ic62daa649b47b656b313551d646c4de9a7da4bd4@changeid>
 <ZIwKzozbXxhQHxma@gerhold.net>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZIwKzozbXxhQHxma@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.06.2023 09:10, Stephan Gerhold wrote:
> On Thu, Jun 15, 2023 at 02:52:54PM -0700, Douglas Anderson wrote:
>> Trogdor devices use firmware backed by TF-A instead of Qualcomm's
>> normal TZ. On TF-A we end up mapping memory as cachable. Specifically,
>> you can see in Trogdor's TF-A code [1] in qti_sip_mem_assign() that we
>> call qti_mmap_add_dynamic_region() with MT_RO_DATA. This translates
>> down to MT_MEMORY instead of MT_NON_CACHEABLE or MT_DEVICE.
>>
>> **Apparently Qualcomm's normal TZ implementation maps the memory as
>> non-cachable.**
> 
> Are you sure about this? From the discussion in the chat the conclusion
> was that we can check easily for TF-A, but we have absolutely no idea
> what Qualcomm's firmware implementation does. It might be "broken" the
> same way and we just have not noticed it yet.
Nikita (+CC) was able to boot Venus (which uses that memory reservation
call, I believe) on next-20230615 with a WP firmware, so it should be okay..

Konrad
> 
> I would perhaps just omit this sentence so we don't risk misleading
> someone with information we're not sure about. :)
> 
>>
>> Let's add the "dma-coherent" attribute to the SCM for trogdor.
>>
> 
> What about sc7280? I guess they use largely the same TF-A firmware?
> 
> Thanks,
> Stephan
