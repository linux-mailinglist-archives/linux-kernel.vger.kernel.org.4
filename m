Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B766775FF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 09:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjAWIBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 03:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjAWIBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 03:01:15 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132BB1CF62
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:01:06 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so9942794wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xgwS1wLKSY/UzsprCjGjz1jf0uYNHHiqTORdSq4h/xs=;
        b=IsuNxvgMqdlvZT3QGtWGnsuF4PY7RvVV499fHpcNx5aM1X7MZ0k5cdDgw9zZlzWR+K
         jVBQpgYP3Fc9W2dLwiUaBZ6UtY7KFBBnDxLMgIYDTHjmE3DBU4MUHgpYeGz47sPIKgcP
         ie+HLMFvjEUpDyYg93WbT5hA6/dT3wXGM76PuYvn+8nNnWc4XMsUvtaQcaUADycAIx3O
         CDnxYR6rYgFdUMJG5xFsPQo0ip2+vfQlBEuTTC+DQQ4BUriARJgmKA/mChWnpSGNGMDL
         EqZD71AB8iDeXKTuZ8JSRMn8nIFo7G1bdrtKehwNJ5huWinE3Pld4T+buE8UIlEcSlt9
         7GJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xgwS1wLKSY/UzsprCjGjz1jf0uYNHHiqTORdSq4h/xs=;
        b=dmDjs7Pu77gdELf+qaZ8ZK1JG5Lw8VNK5tN+pjH8k4RfK2yepNDTVLzo5oNFqaBlT9
         xm8q3XpFvONpYloVGuVTLLd5a/isa5OX15Mtv4vVrdagMRAhR021BYZFqQlyl5e8EqrC
         FL9nsSc5tc7W7yeuykLB0yRI2D/faRHsHeS9FyPAZnw34oilbpT4Feylrv/iqrQo6SYE
         sO5sqFGWBY5I7ZbJFhbi6qdHs2UFhNx7IsYAR0SZOlrY0X9oIqA3Jz6jCAJe3T12fdzA
         JMMfQyOFxg4EEunIm4cCOE4W8ojAz8KAtuTtfwR1NNVxXOIfgV8tIzlq9LrCWhPuL4ML
         o/vg==
X-Gm-Message-State: AFqh2kothHG/QMs2w8b3Oc3C7sc9ooeuHRQvvj+IX3/9HYOaHKiniJ7f
        fncWYEwKeGM9tCjNe+O2bDXQwg==
X-Google-Smtp-Source: AMrXdXtBxcsmF6l5HL2ODsqVwfRUK9XbGKORvubwbbLb1eDRMhP295OnmpH8GomgMdPsglnkk0Vr8w==
X-Received: by 2002:a05:600c:1d0b:b0:3db:88f:996d with SMTP id l11-20020a05600c1d0b00b003db088f996dmr22170395wms.36.1674460865387;
        Mon, 23 Jan 2023 00:01:05 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id c14-20020adfa30e000000b002be50604c81sm8386152wrb.47.2023.01.23.00.01.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 00:01:04 -0800 (PST)
Message-ID: <0c06bfb5-c0b7-c3eb-4c99-8e77280a942c@linaro.org>
Date:   Mon, 23 Jan 2023 09:01:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [RESEND v5 0/6] Add resets for ADSP based audio clock controller
 driver
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        swboyd@chromium.org, agross@kernel.org, andersson@kernel.org,
        robh+dt@kernel.org, broonie@kernel.org, quic_plai@quicinc.com,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@somainline.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com
References: <1674322340-25882-1-git-send-email-quic_srivasam@quicinc.com>
 <030115dd-f489-5d4e-c993-e9fa8b550f04@linaro.org>
 <43bea488-7a71-aec3-508c-6a541d5db508@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <43bea488-7a71-aec3-508c-6a541d5db508@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 06:13, Srinivasa Rao Mandadapu wrote:
> 
> On 1/22/2023 7:21 PM, Krzysztof Kozlowski wrote:
> Thanks for Your time Krzysztof!!!
>> On 21/01/2023 18:32, Srinivasa Rao Mandadapu wrote:
>>> Add resets and remove qdsp6ss clcok controller for audioreach based platforms.
>>>
>>> Changes since v4:
>>>      -- Update Fixes tag in Merge lpasscc into lpass_aon patch.
>>>      -- Revert removal of clk_regmap structure in Merge lpasscc into lpass_aon patch.
>>>
>> Your v5 before resend have build issues. Please fix.
> 
> In v5, one commit missed to amend local changes.Hence resent it.
> 
> on Resent patch series no build issues.

Resend means you send the same patches. If you change patches, it's not
resend but new version.

Best regards,
Krzysztof

