Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2478B5E6A5C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 20:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbiIVSG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 14:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiIVSGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 14:06:23 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB1CDCCF6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:06:21 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id p5so11894780ljc.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=jeplP4YVAz5AgTFVTwn+jbvvpxdu1UqDPlqQDnM+MlQ=;
        b=rdUpjqWg8CPMq5P7m/0xLiBMIKswvdTJV+dTDMAVFQJ3gtKX1QE2NtDH7xGyouAzkv
         7VR9Q1+bi0KPx2inA8igDm9Cj5telLtNsL+//q49YORlGtkgvrcURq9ERb99W49DkhB9
         oURuGG6wX6YCd6pibqBNYCfu8aYcHdcgPNrRbDB6kBKk6Pl8QoGpxVJN7EQzzfzDT0zV
         8n/9GHtIGezohlUeNq83zR4oIZSqNLdgUW6zBzSREu/XIJbbSHhf2sRtfDy/275C9GnT
         eizmpBlnduCbavALG8kEEHxLKmOAWlP4icLoqwmOgKd8UfeI5EzruTnJiRaYdFS4qmxy
         DjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=jeplP4YVAz5AgTFVTwn+jbvvpxdu1UqDPlqQDnM+MlQ=;
        b=cbRvYy8EpfWUXlcYOoAurcvB0kwX5Cm62kPW/pkXZA8T/4q7xNy64DPmcehyLlZhzV
         RLP7DeK82ppAdPa9mqT7hnzYxiW/d8bspPxYD1CXrGH3rM5royb+DKxxjclTQcA1/rb7
         yBFIA2EYr+ufUkfTprgcHC6x8pPBegXrsrFjGoD90+5+Gm166WqvQ+UCkDzH6sJz/Nqe
         7n/e/fRh65wxHZEQBupEbWwgWiThWs5AbA1I6UySVBLK1Kgb8t7SM0YjOrn5dMvkB9Uu
         kKtbOxyK/3EWEOhFOv2GRVVefxmbnG7JE8o9Yv6w6eNcOFGMME2ofoX+zyBqVkywp1op
         ecug==
X-Gm-Message-State: ACrzQf0povfgNTx6gSo3b5Jkn1R8quqVvJMUyHO+o5oNEp50KE384OGy
        wG8jgTdZoHNXOwwa0inycrzJt0eheeb6wA==
X-Google-Smtp-Source: AMsMyM4ajuzrHOM/Y3XIDWTY6hYESDjwlRUbm17Rxh4w5ANKv2PH3nqgMia9eMOhyimAkvgfvt2lsA==
X-Received: by 2002:a2e:99c2:0:b0:26c:3fb1:4c5a with SMTP id l2-20020a2e99c2000000b0026c3fb14c5amr1504877ljj.460.1663869979615;
        Thu, 22 Sep 2022 11:06:19 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id s16-20020a056512215000b0049493c14b17sm1038854lfr.181.2022.09.22.11.06.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 11:06:19 -0700 (PDT)
Message-ID: <e71b75ea-188c-da22-5216-2c82d9627b64@linaro.org>
Date:   Thu, 22 Sep 2022 21:06:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 12/17] phy: qcom-qmp-pcie: consolidate lane config
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220920073826.20811-1-johan+linaro@kernel.org>
 <20220920073826.20811-13-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220920073826.20811-13-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 10:38, Johan Hovold wrote:
> For legacy reasons, there are two configuration parameters that describe
> the number of lanes a PHY has.
> 
> Replace them both with a new field simply named "lanes".
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 39 ++++++++++--------------
>   1 file changed, 16 insertions(+), 23 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

