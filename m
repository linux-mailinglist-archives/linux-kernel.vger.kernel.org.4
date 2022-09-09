Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4213D5B3466
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbiIIJrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiIIJri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:47:38 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C958108704
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 02:47:37 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id f9so1037784lfr.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 02:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Ake5tgQqILRJG+4KzZg3Srv4ZA/AFZzVW1hkSSSjZjY=;
        b=g2RNyj6bsexsTkubyx+Z7ZyQGJ5PURcgkv1goBeGtYsHs+L25aU7jXwb7T3yIAVX+8
         WtlB5bHVIynC7uF7dnZW4txe7IWChghVAPz4Rt7ZPlYHeHjTf9+2xZyyITTRT6Ru1KvY
         IHO/4EUcRGShrNFSn4yqsh3UGQ3rY8GQisLXWKbwVUeSYrLrTOSlhoQYIhYNH3xe3R05
         i8Bk1Qqgh2RQNnZNrtSmwwDWw3U2AGs3iGppGcH2n3GbdXw5bbdTZYNrKW8Wv9LfjHXC
         BMJAS/bqh8MzYasEL/dr6064yISqfPiTJDvcpPX/beocvwccGi7p33QLe6HHt5/YMb39
         K7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Ake5tgQqILRJG+4KzZg3Srv4ZA/AFZzVW1hkSSSjZjY=;
        b=pFG5iU7CIp8R9uS9LzdPVKnrJJw231ZfA9H4agPROoQBNJGA4AulVZNhcm8vTuvu/j
         4UGQT+VgLqNEXmRSVi7SAS7U3HoJXISHl7Bqx2AqmGKC7z6ZhbveMoz1xG8TQFwl+hg4
         iQF2+5HqyGW5WG/xKPRDYLiwSj1iSitSgAWQ7Yv+8FLte29iWvarKxO9tInosp3c4JAi
         h/OYKcVaLl/qH0Rj2PJ9t0eGyXpzn66d8RmL9nQmC4+6NwdBpBNhdfhggIwwNHF/Zi55
         Dwm13bU8GoicuLvXdzY1vMr6b8UvEaapG1d57zb92hA+tNdSCLQU8+Q++UsIyMiapxIx
         wz3w==
X-Gm-Message-State: ACgBeo3YhEYo+Fqs7/CVC0R/hFpGmfRhVpaC4nQzX+19pXR6N2AlJPba
        6HY7LycAzxPsPZTP7teRa+mABQ==
X-Google-Smtp-Source: AA6agR6xIRiz3h/qc7ldfo5fdSyq9Ly2yfNndxUzi1oYASOsoNu/o8hzGRlKwdn0RR3AOKgcW3z/0w==
X-Received: by 2002:a05:6512:3b06:b0:498:fa72:c24d with SMTP id f6-20020a0565123b0600b00498fa72c24dmr644600lfv.538.1662716855888;
        Fri, 09 Sep 2022 02:47:35 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id bj33-20020a2eaaa1000000b0026bda31c10fsm8604ljb.61.2022.09.09.02.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 02:47:35 -0700 (PDT)
Message-ID: <4d627150-7097-9394-b550-6610dabbf134@linaro.org>
Date:   Fri, 9 Sep 2022 12:47:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 14/16] phy: qcom-qmp-pcie-msm8996: shorten function
 prefixes
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220907110728.19092-1-johan+linaro@kernel.org>
 <20220907110728.19092-15-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220907110728.19092-15-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2022 14:07, Johan Hovold wrote:
> The driver function prefix has gotten unnecessarily long and hurts
> readability.
> 
> Shorten "qcom_qmp_phy_" to "qmp_" (which likely stands for "Qualcomm
> Multi PHY" or similar anyway).
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   .../phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c  | 93 +++++++++----------
>   1 file changed, 46 insertions(+), 47 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

