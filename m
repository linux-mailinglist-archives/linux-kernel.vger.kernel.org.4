Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E1973B933
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjFWN6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjFWN6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:58:16 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21195E52
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 06:58:13 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f86e1bdce5so866991e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 06:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687528691; x=1690120691;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6jndWPX8g/RkMlqUci+O1Pg3iw2GfjP5tf07sb/A2o=;
        b=dKTmAAk1unTaguUb5PRb+mOCEnMd9/Ew/koIQi6g/d9jFBJmpJMQ0RUIvRatEqy/+W
         9kFEK/981cTfEX6zuZu1niWIAXZyJ18FNth13ADJrP1BrvBKEhl+FNyl8m/fo93PAeAV
         NlDinSNZ0+Bu7cX5uxuev5T6uEBRe9UscDjvxZfhZXyFmeJ1+cz511spcHb3JWyGBZDs
         D+Ey/gnhVC3STTr4PM/ArciaypvNjcSufgXbpfuUcoTAb8y4GA3H0AEtzAhjSuzg1JYA
         m6LsKowiV1gPbV7SCEXO6hbo+pyP29UEf4PqHoF/dtZ2GZTivhzyGIdxXIF9jGrFxgby
         2g8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687528691; x=1690120691;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W6jndWPX8g/RkMlqUci+O1Pg3iw2GfjP5tf07sb/A2o=;
        b=BPptSGnz/PvKqlGfswVVpkBYNtAhHXSP5naL2PzTdz/ik4td0yzYD8EfXaN1lCByGD
         cN7h2e4gQOqeYirQvJY3p+TrZxloXtxjLlXKcaWL0pLuvk96xfGTjkzfNyz2ZJzFJX8s
         AVt958VOuGKiGk+Jxbbuh9Ds4oNAwL1+IGlJg7RLWc26ll8J3mTvXVmoqVz3SoOvRYRo
         MAo+J6g61x0EOqKIvVowEcybLajrdZ4OTDSzETzHFsERLg20zmvj50uE4cRPsKLCYfV8
         D1HfTxJsEu4PSUq6lGuJ513Pxh7KSuqIu71PkfDbbfK0hWMmw7m+9AG2kjpCzNKiOhCi
         D7mg==
X-Gm-Message-State: AC+VfDx+qXoICN+zZ/xuHM+V4J49c/SgDyIGurGJk+bddvioCN2ud4QF
        uMOFCELtxuVSdYweV4NoO3AvWQ==
X-Google-Smtp-Source: ACHHUZ4u9yMyuI7mFr8evCNJV8EmOBr8kiJdt1uVnBpthIzjn/dhfH39xVwJwnZHO7+er1/mIsk7Yg==
X-Received: by 2002:a19:e34a:0:b0:4f4:c973:c97d with SMTP id c10-20020a19e34a000000b004f4c973c97dmr12247542lfk.25.1687528691143;
        Fri, 23 Jun 2023 06:58:11 -0700 (PDT)
Received: from [192.168.1.101] (abyk30.neoplus.adsl.tpnet.pl. [83.9.30.30])
        by smtp.gmail.com with ESMTPSA id u24-20020ac25198000000b004eeec1261ecsm1457547lfi.31.2023.06.23.06.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 06:58:10 -0700 (PDT)
Message-ID: <5b68b9ba-157b-067c-3926-9c5ecfecc311@linaro.org>
Date:   Fri, 23 Jun 2023 15:58:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     neil.armstrong@linaro.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Tipton <mdtipton@codeaurora.org>
References: <20230619-topic-sm8550-upstream-interconnect-mask-vote-v2-0-709474b151cc@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v2 0/4] interconnect: qcom: rpmh: sm8550: mask to send as
 vote
In-Reply-To: <20230619-topic-sm8550-upstream-interconnect-mask-vote-v2-0-709474b151cc@linaro.org>
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

On 23.06.2023 14:50, neil.armstrong@linaro.org wrote:
> On the SM8550 SoC, some nodes requires a specific bit mark
> instead of a bandwidth when voting.
> 
> Add an enable_mask variable to be used instead of bandwidth.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
After reviewing this patchset and taking a peek at older downstream,
it looks like ACV should be using 0x8 bmask on *all RPMh SoCs*.

It's worth noting however, that 8350's downstream (the first msm
kernel using the icc framework) did not incorporate that change.
Not sure if intentionally or not. Probably not. Might be worth to
poke Qcom to backport it in such case. If 8350 is still supported.
Probably not.

Check out these snippets:

https://git.codelinaro.org/clo/la/kernel/msm-4.19/-/blob/LA.UM.10.2.1.c25/drivers/soc/qcom/msm_bus/msm_bus_arb_rpmh.c#L556-567

https://git.codelinaro.org/clo/la/kernel/msm-4.19/-/blob/LA.UM.10.2.1.c25/drivers/soc/qcom/msm_bus/msm_bus_arb_rpmh.c#L475-495

Notice how acv is never updated beyond effectively setting =0 or =bmask,
perhaps Qualcomm never implemented something else..

Since this series is fine as-is, I'd be happy to see an incremental one.
Reported-by would be cool as well :D

Konrad
> Changes in v2:
> - Took downstream patch for patch 1
> - Added konrad's reviewed tag
> - Added changes for sm8450 and sa8775p
> - Link to v1: https://lore.kernel.org/r/20230619-topic-sm8550-upstream-interconnect-mask-vote-v1-0-66663c0aa592@linaro.org
> 
> ---
> Mike Tipton (1):
>       interconnect: qcom: Add support for mask-based BCMs
> 
> Neil Armstrong (3):
>       interconnect: qcom: sm8450: add enable_mask for bcm nodes
>       interconnect: qcom: sm8550: add enable_mask for bcm nodes
>       interconnect: qcom: sa8775p: add enable_mask for bcm nodes
> 
>  drivers/interconnect/qcom/bcm-voter.c |  5 +++++
>  drivers/interconnect/qcom/icc-rpmh.h  |  2 ++
>  drivers/interconnect/qcom/sa8775p.c   |  1 +
>  drivers/interconnect/qcom/sm8450.c    |  9 +++++++++
>  drivers/interconnect/qcom/sm8550.c    | 17 +++++++++++++++++
>  5 files changed, 34 insertions(+)
> ---
> base-commit: 47045630bc409ce6606d97b790895210dd1d517d
> change-id: 20230619-topic-sm8550-upstream-interconnect-mask-vote-96aa20355158
> 
> Best regards,
