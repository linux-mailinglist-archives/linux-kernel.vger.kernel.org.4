Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA4C686775
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjBANuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbjBANuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:50:01 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A97446086
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 05:49:52 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id qw12so35654080ejc.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 05:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ACzUjtExd1GIrXZr1vO/BegTBXZjaP/+ZCi6MVW3dcE=;
        b=XqDxeyaONwSMSPBNLF2wQqvVaptIMfUXKIL+odbcSjOEZWz8roz/UWW0pxxPb3rcZr
         XFDmxM9TAigHeKTHQNxt3sps1g+kXk+XspyzHQ5nM5bVtha7xLYeGTaNdb6wdqMkBygt
         WSEV1c7E4T0OUWeGWS+B6KE7T7kIMhklClCadFuGuBww3apkEKZPesqOgZ9QRbiHKG/s
         RhLPhfcLZUjCzjYqLQHasEL3rbrwMn3G0UFhkARdB2BfN7ojuinil2MH8DDWf2Qw7UB2
         ZZJQivmgEIaA59HQPwDukXmfcC2PdEJW/QS3cJCIN/QIrsmdmoW50R6C9Sw/k3AukrL8
         +d3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ACzUjtExd1GIrXZr1vO/BegTBXZjaP/+ZCi6MVW3dcE=;
        b=hP7m7rHGBswfadJmI5DTwd0nXtYhNhOQcR4OIhzaW047bNxfmebTyPR/Pj86LkO1qP
         GcZHgCV8qJ8yBzknS18IkrDrtgivtQZHFnK/0110wQzafeS8NgGnjyzjqmb6CL4Lt5l5
         hS5GWZ1DTMG8sNqBQK3VO/mMvi5jKWfyTWWpgSguenYavYGTQ1FbDQCBFegTMyClAPi7
         kNmA9/OVZimuhdbuz+ypqv6xVgFY1senD0SGbp0gse9v6VckRGyQqvBpqdL9Zadxdhtl
         6obC7hnUK1mVx7QfNuPFn3zf8Y3hXezBABM74MQs7+15pL91jJS4zOBnkjMd/DwIm6ox
         iYGg==
X-Gm-Message-State: AO0yUKWo1I0qa4EKQi6oc7m0CAw+8MoNGW/yLKqkMhD9zPy4bGCw7h71
        ZsLmJfLhseQSVtPN9dXao1anKw==
X-Google-Smtp-Source: AK7set8R0ihVH9gQLKTpTgxDtC0l0P5jQ5GnLv1eb/VCHQJYaBQmNmb6DhTSWztbpqMBqXz4Dg9UCA==
X-Received: by 2002:a17:906:2b0d:b0:877:a9d2:e5e9 with SMTP id a13-20020a1709062b0d00b00877a9d2e5e9mr2588659ejg.42.1675259391045;
        Wed, 01 Feb 2023 05:49:51 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id gt15-20020a170906f20f00b0088bd62b1cbbsm2858318ejb.192.2023.02.01.05.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 05:49:49 -0800 (PST)
Message-ID: <05344ca0-3847-ea55-1e61-04aacc58995c@linaro.org>
Date:   Wed, 1 Feb 2023 15:49:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [v1 2/3] drm/msm/disp/dpu1: add dspps into reservation if there
 is a ctm request
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Kalyan Thota <quic_kalyant@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, quic_abhinavk@quicinc.com
References: <1675092092-26412-1-git-send-email-quic_kalyant@quicinc.com>
 <1675092092-26412-3-git-send-email-quic_kalyant@quicinc.com>
 <20230201111604.htgczy6yvdkywhvl@SoMainline.org>
 <20230201112631.mgwuboehrwdefqnd@SoMainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230201112631.mgwuboehrwdefqnd@SoMainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2023 13:26, Marijn Suijten wrote:
> On 2023-02-01 12:16:05, Marijn Suijten wrote:
> <snip>
>>> +	if (dpu_kms->catalog->dspp &&
>>> +	    crtc_state->ctm && (dpu_kms->catalog->dspp_count >= topology.num_lm))
>>
>> Multiline-if-clause is typically indented with two tabs, not a half tab
>> (4 spaces).
> 
> Hmm, Dmitry requested indent-to-opening-parenthesis in v1 instead; and
> the majority of dpu1 uses the worst version of all: indent with a single
> tab so that the contents line up with the code block below.  Dmitry,
> I'll leave final say to you (and fix it up in my own DPU series
> accordingly too).

Well,

:set cino=(0

> 
> - Marijn

-- 
With best wishes
Dmitry

