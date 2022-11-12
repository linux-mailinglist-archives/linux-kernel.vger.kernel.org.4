Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF3F62676D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 07:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbiKLGTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 01:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbiKLGTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 01:19:20 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7617056C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 22:19:15 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id u2so6727356ljl.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 22:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eKvsSc4rxfP6uP1G2yC7UY6Wk+VnQ3+TFfU4MXJqozs=;
        b=gQILM5G24aQArIhNwyPb9mvZqE20fAg3ThlwOOxWrSShnsEe+S0nQXRTSgCgIyIOPB
         Ki3zWg6AViDUYhqOiV+AkSTB08QzkeUNrnu3aYT1fCG1G+6wpzStTUi3DCOdLoenD5AK
         MrUS7UnQeN2GMvHIKHcA87XEECuFr60dDQqhxN2lsZRHvoTad92h5wvhQNBx14awnux5
         bKAGGUu15wG5UBlABYVOm/mDqtKBl8kkW2Ndgj13DI565gH0TsPg7uWjjpjYe84gGT7b
         iCOfmOZGdvx8K39FakF3VekYfHcGwASy5JEuOyAyldymla1oEd+Nw/VOPNI5jVFjzxNM
         asTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eKvsSc4rxfP6uP1G2yC7UY6Wk+VnQ3+TFfU4MXJqozs=;
        b=DqQSYxQwhwjeQwy8PWgSRSm6Zcul42ZGyRqeobMG63glTp0J02iByvr6Lgaq9ozF0K
         VLVP4d+8f2z8CW7csDgASnG1VGVUgR5/1jvlJ6/T0PN3MTqK+9Zty0il+tI/OtghcxKA
         7y9UFX2yiRCdo0JqHiunDdKdOr2PleQmhfK0BE64CwjHR5Pc2qwrMxfxnulhhn3GxzWs
         Yx/FOHWSXFMcFLwV9j5c5m29dJTrJvpVKPz3e6HK9x1iomG97j42if6Ae0+IMNkTiXor
         WfMJosfoSB2PPaPaCPh+9VlzIqu4DGu8TgbV3eWE1Pfz4X+fKwTHlrgiUUHaAOPLUjsS
         nl8w==
X-Gm-Message-State: ANoB5pmh2p+J1kvkMcetVbfqQrVNu5dS9kv1FPDzdi0RS/r8BmseJoAf
        k2nlU/xRtaCq9OVaSQPFK1uYkw==
X-Google-Smtp-Source: AA0mqf4ooqTVhf2Zh5Tzsyi5kSEHZuKZ7t1Dx21WZF9D+CekCkzylKocDhLrsDe5HC2Ut+HyBG/iIw==
X-Received: by 2002:a2e:300f:0:b0:277:7eef:1d97 with SMTP id w15-20020a2e300f000000b002777eef1d97mr1652392ljw.516.1668233953804;
        Fri, 11 Nov 2022 22:19:13 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id p5-20020ac24ec5000000b004acd6e441cesm702806lfr.205.2022.11.11.22.19.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 22:19:13 -0800 (PST)
Message-ID: <fc435f8f-ad8d-fdc0-896b-2a88f31c4a41@linaro.org>
Date:   Sat, 12 Nov 2022 09:19:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 03/22] phy: qcom-qmp-combo: move pm ops
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221111085643.9478-1-johan+linaro@kernel.org>
 <20221111085643.9478-4-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221111085643.9478-4-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2022 11:56, Johan Hovold wrote:
> Move the PM ops structure next to the implementation to keep the driver
> callbacks grouped.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

