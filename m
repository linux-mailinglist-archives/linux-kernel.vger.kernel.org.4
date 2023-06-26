Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6C873E203
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 16:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjFZOWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 10:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbjFZOWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 10:22:07 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0052B10F4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 07:21:18 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b69ff54321so17595211fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 07:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687789250; x=1690381250;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BK5tyLiExltIUFYV71NbilB0KUxdUAvXW4sOeYJQVs4=;
        b=v7ms8/4HiPgDXCGhcnzpzr6wpvOpoJB7cWdNJLFCQUxBAZta8PMnQpPx6f5p1w9lC/
         NKEk9zsHKp0AKUOG8+4sbGhgPcVYzOI7PKbNGQuL08U3gIaqDkvqw2j7lsoRq86Kl/y6
         urfyd5O4dKS7Rr2Jtf2z+hrHN0aSNhbL8gnt4WouN42kKyX3jaFBBZoyW58+VCUoj0qi
         BJsaFYAP1Hdc/JAJHV7cy35ibVpuXUI7foyLeXUv/wyZ+XfehQlFivn0dEx/Jo9udZIQ
         5GYZMyI5V2QEuiYSmcJRUC39+rzGkmYY84MT08W9jCkAlasYvJeCzBM2POR/ZSIDJDFO
         A0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687789250; x=1690381250;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BK5tyLiExltIUFYV71NbilB0KUxdUAvXW4sOeYJQVs4=;
        b=D4vy2odwqkyNyqo8AVfueYMR6V/Nw2jcp3GKemqifvFdQdXbLnnJvZ21Rx8zrbFSdj
         wCY7+NCppfLbV//LD9yMz/1ccnsuLsxTOw1B0nHunBSZRDju9NRDjuEb1XA5Zd0gr4ar
         eEJZI4Ho3V+n+r2IOnXlMuYeKCb/gE/3UJumy3NNb7RXRqg0Camcso0cFV62Z3p1EaDO
         SYR0FYYVwUjSZlbylHqG+ySh3FVQJnRLLyT5WD5MUvVRr3Y8+z+IjgEyrPGS9TvG+dEc
         QqIPX7TUWnS8cmlFO6qctODxmTJt35c1z7EI03uA/LjSMxaCqVMvwCUKewDSuLBtrl92
         6/Fw==
X-Gm-Message-State: AC+VfDxFuBqE7zNlnHC6Is6Uwwzp9M/0yG2pcBldjTX4PJiqHDLMJUem
        J4mdKfnOq6mbD5BBDrRRxAQIMw==
X-Google-Smtp-Source: ACHHUZ6BMDnWC7ITgKLp9Dk7eCjYutCbFasmjDj6TxuVFzh4Zeh5b7xqhNk+WSOU3/bH4mAoiY1Qrg==
X-Received: by 2002:a2e:8559:0:b0:2b6:9fdf:d8f4 with SMTP id u25-20020a2e8559000000b002b69fdfd8f4mr1900728ljj.29.1687789250054;
        Mon, 26 Jun 2023 07:20:50 -0700 (PDT)
Received: from [192.168.1.101] (abyk179.neoplus.adsl.tpnet.pl. [83.9.30.179])
        by smtp.gmail.com with ESMTPSA id l3-20020a2e9083000000b002adb6dd5a97sm1245694ljg.27.2023.06.26.07.20.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 07:20:49 -0700 (PDT)
Message-ID: <ea0e1283-8f0e-0524-176d-ce2726151f22@linaro.org>
Date:   Mon, 26 Jun 2023 16:20:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 00/15] drm/msm: Add SM6125 MDSS/DPU hardware and enable
 Sony Xperia 10 II panel
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Lux Aliaga <they@mint.lgbt>
References: <20230624-sm6125-dpu-v1-0-1d5a638cebf2@somainline.org>
 <035ffdd2-27e3-99bc-f8a4-41e66685db09@linaro.org>
 <i5xxzhfhlwzoxlnezzgg42hzwzwfcgxv5gopqhb6vd3udz252b@wpznuvoleeta>
 <701916b3-388e-8216-f7ae-1837d5895d87@linaro.org>
 <jllpsyveqvxco3ihclqypwnfhac2g3gdm6ukd3x3fjsr6z54xy@2xwh5fixpprh>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <jllpsyveqvxco3ihclqypwnfhac2g3gdm6ukd3x3fjsr6z54xy@2xwh5fixpprh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.06.2023 16:17, Marijn Suijten wrote:
> On 2023-06-26 11:41:39, Konrad Dybcio wrote:
>> On 25.06.2023 21:18, Marijn Suijten wrote:
>>> On 2023-06-24 03:42:46, Konrad Dybcio wrote:
>>>> On 24.06.2023 02:40, Marijn Suijten wrote:
>>>>> Bring up the SM6125 DPU now that all preliminary series (such as INTF
>>>>> TE) have been merged (for me to test the hardware properly)
>>>> We should not repeat the same mistake in the future.. Finding a
>>>> balance between releasing early and releasing what we can declare
>>>> working and tested code is hard, but we waaaaaaaay overstayed on
>>>> this one..
>>>
>>> I don't understand what you mean by "mistake" at all.  Yes the DPU
>>> catalog portion of this series sat in my local branch for a very long
>>> time.  Yes it had to be rebased on top of conflicts many many times.
>>>
>>> However, that time has also been used to fix and extend DPU where
>>> necessary, instead of submitting a half-broken or half-incomplete
>>> catalog entry...
>>>
>>> Re "we overstayed": you could have asked to clean up and send my patch,
>>> so I don't take this as a mistake on my part as you are completely aware
>>> of my time schedule ;)
>> I didn't mean to pick on you. I just wanted to emphasize that a more
>> upstream-forward approach would have saved us quite some time on the
>> rebasing and cleaning-up front.
> 
> That is how it comes across ;) - our dream is all about upstream-first
> but as you know this becomes a mess really quickly when things are
> blocked on dependencies and you're working on 5 different features and
> testing across ±8 different Sony platforms on ±14 different devices at
> once... all in a limited portion of free time.
> 
> Fwiw cleaning-up would have had to happen either way, and would have
> taken the same amount of time regardless of whether this series is
> submitted now or two months ago.
> 
>>>> Konrad
>>>> , and most
>>>
>>> Also here, don't forget to re-quote my message if you break half-way in
>>> the line.
>> Ugh. All the time I've been doing this I thought thunderfox was smart
>> enough to do it for me. Apparently not and you're the 1st one to point
>> that out.
> 
> You're welcome!
> (Though I thought it should be visible in Thunderburd, unless you're not
>  in plaintext mode?  Does it still show the "this is quoted" line in
>  front of the broken sentence?)
It doesn't, but the text stays blue (as if it was)

Konrad
> 
>  - Marijn
