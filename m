Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91C16F6C18
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 14:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjEDMgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 08:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjEDMgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 08:36:45 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC80618C
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 05:36:43 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-50bc3088b7aso784177a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 05:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683203802; x=1685795802;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y8fhO9f4/3QMxyB39Gth5phqAprNLUMtKiWtdq2EDmY=;
        b=zqy7x41oYxHtB4FPo4QvbEkLbekpnOuhNqC+C2+U4OeMKOcYoBy1rXCduDsbM4xOLb
         GRaCmKfqYNsiF0CctP9vLAybQBjmSOjBJItt1bk5tA8rYvbz1WmONUu8HYPm7YoIyyWT
         wz7QMxOhMkKsKkkxdGfpmC0Xtp5IDrVoGbVPlReigGgMp2+oc3c719tm5qZpu4pyPCFj
         ZdTvAEESVZlkTfrIG+vClZDF6M5enb664SX/WaKld4Wo6QPvV5OS8ciGsaUAHQIcbyWf
         ejkoie5lnhYlZuaibb2axTrvl12UAy+ieCgP+Veto6gvfPVk2qw5YRtX8IGqd0q1XR/5
         ZcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683203802; x=1685795802;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8fhO9f4/3QMxyB39Gth5phqAprNLUMtKiWtdq2EDmY=;
        b=XLuUjP8zMqnDJeEw5AprI2g7Or+xkHW0J01NSn9HHgOmnotLcAtHy4H9HCRHpGKTMs
         RRRFKpLCXEsDKqBnAiprs8cWkrNw25j8CYEB33NNmFTAVK7q2XApJ4abH/MPWyToowKM
         VqZpOVpgsHcS1a7zrMwQnA/h1qZ4pAql7Nqw3agyIuLjrJAwgD6fv4JcmWQKvQyoU8sM
         ScxxaZqP7Y3L3qrg5VzqUSEb8c8hpVhAS4SZQfMnyahAZmtufLyvi5kJJey8k/3PjTmW
         O1BvtVUaGoMWCzR3WBkarBrhXbrml3XolWr+qJ1OSkyfbqaoFSkrOq6bhs4VBiKKcjrh
         1SGg==
X-Gm-Message-State: AC+VfDzu1tro8OmH7GOfH+ZEgEhGGBBRwUAcyrXEEyqs5GQYpPLPnlfo
        SWuZP9VHI+gZOxtNHHaI9zeIrg==
X-Google-Smtp-Source: ACHHUZ4TgHr5uaxaFriyo68W2I/lTAseWQIQdQvWxYGrr6CF7hqo+PlqPbDD5a12w2V0MfNr/S0GPw==
X-Received: by 2002:a17:907:3ea1:b0:952:b51d:5086 with SMTP id hs33-20020a1709073ea100b00952b51d5086mr7127949ejc.57.1683203802006;
        Thu, 04 May 2023 05:36:42 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:cbf1:e7ef:fb81:e912? ([2a02:810d:15c0:828:cbf1:e7ef:fb81:e912])
        by smtp.gmail.com with ESMTPSA id jx14-20020a170907760e00b009655eb8be26sm2121765ejc.73.2023.05.04.05.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 05:36:41 -0700 (PDT)
Message-ID: <1a4f4b55-6284-6149-4c7b-7b45fa1de291@linaro.org>
Date:   Thu, 4 May 2023 14:36:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 02/18] remoteproc: qcom: Move minidump specific data to
 qcom_minidump.h
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, corbet@lwn.net,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        catalin.marinas@arm.com, will@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        srinivas.kandagatla@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
References: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
 <1683133352-10046-3-git-send-email-quic_mojha@quicinc.com>
 <fe94ed5c-c444-436d-720a-c96538c1026d@linaro.org>
 <e69862cc-4185-a7a2-07b2-15e331c4678a@quicinc.com>
 <659a9637-f82c-054b-99a8-dc25416c8e13@linaro.org>
 <33ea7c3b-4317-5aff-5e6a-af6e093d45a0@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <33ea7c3b-4317-5aff-5e6a-af6e093d45a0@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 14:26, Mukesh Ojha wrote:
> 
> 
> On 5/4/2023 5:33 PM, Krzysztof Kozlowski wrote:
>> On 04/05/2023 13:58, Mukesh Ojha wrote:
>>>
>>>
>>> On 5/4/2023 5:08 PM, Krzysztof Kozlowski wrote:
>>>> On 03/05/2023 19:02, Mukesh Ojha wrote:
>>>>> Move minidump specific data types and macros to a separate internal
>>>>> header(qcom_minidump.h) so that it can be shared among different
>>>>> Qualcomm drivers.
>>>>
>>>> No, this is not internal header. You moved it to global header.
>>>>
>>>> There is no reason driver internals should be exposed to other unrelated
>>>> subsystems.
>>>>
>>>>>
>>>>> There is no change in functional behavior after this.
>>>>
>>>> It is. You made all these internal symbols available to others.
>>>>
>>>>>
>>>>
>>>> This comes without justification why other drivers needs to access
>>>> private and internal data. It does not look correct design. NAK.
>>>
>>> Thanks for catching outdated commit text, will fix the commit with
>>> more descriptive reasoning.
>>>
>>> It has to be global so that co-processor minidump and apss minidump can
>>> share data structure and they are lying in different directory.
>>>
>>
>> Then you should not share all the internals of memory layout but only
>> few pieces necessary to talk with minidump driver. The minidump driver
>> should organize everything how it wants.
> 
> These are core data structure which is shared with boot firmware and the
> one's are moved here all are required by minidump driver .

I am not sure if I understand correctly. If they are all required by
minidump driver, then this must not be in include, but stay with
minidump. Remoteproc then should not touch it.

I don't understand why internals of minidump should be important for
remoteproc. If they are, means you broken encapsulation.

> 
> If you follow here[1], i raised by concern to make this particular one's
> as private and later to avoid confusion went with single header.
> But if others agree, I will keep the one that get shared with minidump
> as separate one or if relative path of headers are allowed that can make
> it private between these drivers(which i don't think, will be allowed or
> recommended).

Let's be specific: why MD_REGION_VALID must be available for remoteproc
or any other driver after introducing qcom minidump driver?


Best regards,
Krzysztof

