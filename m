Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5C862677A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 07:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbiKLGVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 01:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbiKLGVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 01:21:38 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B36725FC
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 22:21:36 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id p8so11253083lfu.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 22:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2rSFBeiLpIbhXAzBv6kMM0mwgnolXzo0jTVnOQbFN7k=;
        b=qU4N+hCQFIRy5XA/OX0P/JQx/yczOKS2TpQi1D1hEA9C3fvp2W5PEy32pMUwpOOBuF
         13IltASk3fDGI1Qp89nCjmRHRUpHUrhY07+RN2gns1vBxuZtQmG/EnjfZo71Wcyf5R69
         a6/O7j3u7ItbsyjzLpO2wXjVgOBYLSZso9IacfSeEV4UsPxT24JhH1ouRqYb4gAxI+1i
         uJMifXwA6Ux7MViKBgJJJhn/FEzTWRL8x2Ory5SDxBvHgdhqHmsIdfhlbiZ4iSg7DmCt
         X5O288yq6Xl3ruYxqBtUNuKSHH3U1Gdopkn0lNL1FVeUY9LI5Fv9sSp7lPoKgXCW/6Yh
         sCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2rSFBeiLpIbhXAzBv6kMM0mwgnolXzo0jTVnOQbFN7k=;
        b=smObAc0EHh+Y+P7YUIrqeAaKxcBk2pr38PYKo5F+w9TVaFCpTWYth957Uss7+xsmdq
         99IlHNko+rtI7vdVVZ8rME9uaoS29i2Gwg7jT31DxsiwbMAAVYkfBUJu647IbugmBBK1
         BL4fqKXc7rm37sE8TAMtYoKS2kOvjjxe72TR0RZZBTau9RhNZXlezDYQxsVseoXfKzjv
         n/WiVKyPCNZlPTJge8T7MqpcIXZoz7PF29T5dPC90DonTjYtoeOfGPU9YGcOwcWEKewF
         vTfE8Nso8XEU+gq8lls4oplUmmmxD4pqg5kyGOEydO4vP8SA/ZvcLCvzBM7Qgjrf6zf2
         mS+A==
X-Gm-Message-State: ANoB5plZpJ68j7bMiInWByAfWD9ZNqzQzrPn2YxyjkCNWsOnZbnMk3BA
        uugPtjHlFUaNrgrcHZ63JC+JlA==
X-Google-Smtp-Source: AA0mqf7kPAbErD3YYgREA03LKEKeJqcZXcvBxxD7ZArWMJ+n07NSzFNg66emGzDF7xLAUg1LZlD5gg==
X-Received: by 2002:a05:6512:10c8:b0:499:d6f9:5b3d with SMTP id k8-20020a05651210c800b00499d6f95b3dmr1605170lfg.69.1668234094699;
        Fri, 11 Nov 2022 22:21:34 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id e10-20020a05651236ca00b00497ab34bf5asm717095lfs.20.2022.11.11.22.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 22:21:34 -0800 (PST)
Message-ID: <ebde04a3-38d6-4a19-7aa3-74fd205e8221@linaro.org>
Date:   Sat, 12 Nov 2022 09:21:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 09/22] phy: qcom-qmp-combo: rename DP PHY ops
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221111085643.9478-1-johan+linaro@kernel.org>
 <20221111085643.9478-10-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221111085643.9478-10-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2022 11:56, Johan Hovold wrote:
> Rename the configure and calibrate DP PHY ops using the common prefix
> for consistency.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

