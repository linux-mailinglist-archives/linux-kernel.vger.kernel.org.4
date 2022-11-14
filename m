Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7ED627A2A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbiKNKNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235824AbiKNKML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:12:11 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C43222
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:11:21 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id b3so18438645lfv.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y6z4FK/tmZmxJSTyX8xf2+6fo2/xZV02PMM8eOejL4k=;
        b=UEjGOHxCzNXAvqgp8GEAnICmcorQAGwrxDndICLdMeWtInhSXoB+5uyg+kwoTaQx+C
         Cxo9bdug3F5S2uIWON0kPOeAd0CxZGZWkk/zLvCyBIs+m0Mggsz+fCh4yb8S747mXM9G
         qBdnUdyuFlYoAIhF4xd5Ak3U4fsY11tJkkfpYagJGHhxKh3WrU0OL5f1im3I81ehIHYi
         3651A6mWBfnGwKI32NExM9CSDdZNbc4Yrc6uIPLiY6RXOwdc/5RqQA4fVWCuO/7iUcXF
         VaLhKiHoqBamMt67x4DSmfq+1kNYcJBlSzNfXSa3ey6qpv0Yimu7ZFDjsYHr3GZuii5T
         5zyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y6z4FK/tmZmxJSTyX8xf2+6fo2/xZV02PMM8eOejL4k=;
        b=gjI8oMDyadbltE67J3wy+bfag2TNA7SUn2afG0opa25H6rSl0XCWyv/dNSbH1s2USx
         JLMtWN6AZGPmSCtZ1s7v2/frXPRAW4Z80qSsW24cwbzZAl4ShDc2/31zBD06rldmiZy3
         sfChC8MzEljlIfOq8OEYTpmsdlow8RuXXnew68sZPfHWKNO/yHMIzdpT2agLdwSkT1gF
         ph6UZ+i5TLnUDlv/Z1Xa5l/JmA0W0UoO1KLvMMq89B3LeNhTej7V0BilGVTLmrYjltOo
         Pt31iMRgUpS91Ja7Dtp0rdD7lhc2VAG4NDkS3qUAdax3ruaBZfpnhf+Y5XkxB5I2xE+z
         ezOA==
X-Gm-Message-State: ANoB5pkgrIA0gfZdrdyEYHVMcUkFlvEPNJggm2PXXxBrlNmJqeJsNW3J
        4mfQqU0jAx+eA23nbatgJiUEQg==
X-Google-Smtp-Source: AA0mqf7f0YPzcEMffsGDIeyyjOtMAH0PqDhvfDdwGDno6CNFCRRE9eT8QHslMDNC5CQabWeuVH9G+g==
X-Received: by 2002:a05:6512:1296:b0:4ac:7d84:cb99 with SMTP id u22-20020a056512129600b004ac7d84cb99mr3716240lfs.412.1668420679229;
        Mon, 14 Nov 2022 02:11:19 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id j21-20020a056512345500b004afd23cf7eesm1765627lfr.168.2022.11.14.02.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 02:11:18 -0800 (PST)
Message-ID: <18966b28-c993-f751-9834-1c06765f2d49@linaro.org>
Date:   Mon, 14 Nov 2022 13:11:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 17/22] phy: qcom-qmp-combo: merge USB and DP
 configurations
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221111085643.9478-1-johan+linaro@kernel.org>
 <20221111085643.9478-18-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221111085643.9478-18-johan+linaro@kernel.org>
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
> It does not really make any sense to keep separate configuration
> structures for the USB and DP parts of the same PHY so merge them.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 182 +++++++---------------
>   1 file changed, 57 insertions(+), 125 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

