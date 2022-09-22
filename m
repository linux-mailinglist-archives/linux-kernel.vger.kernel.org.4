Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BFD5E6A22
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 19:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbiIVR6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 13:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbiIVR6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 13:58:39 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66331106F5A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 10:58:36 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id a8so15901323lff.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 10:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=7urtu4G9+3Ak/jE04wIYPLZWdmsb75/IHNhSivsn/uQ=;
        b=iqxXiUrrE3kHZfaGB8BG8OSS/w8zsSrquEC5mRDvwrWc6vCLRr43wSBKOwjYbwhTCy
         STGzgZpMGWiDJ6CD5ALcC1pfxMsB9AXcPBErP8G+5bDbGU1qanzKiDYm07D53PxZlmh5
         Eohaed365lKq0g0iGhQHcwNS1vEB8CKpb3XVKaPbNCXaYgGF75YmHRZQofn7REjMbNdj
         x5QFYKfSrrNGY17pzGqifoCSWUaLwt1ifeCcLziiOaA68E0AUoRAdQGk8JZG0TBZOnDt
         9OF60AKWRqK7pGXEOPArzTJk8lm7NpL2OjubQoUYNqFb3dU7pTdgFNqiUSB+47ND4PBi
         4r2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=7urtu4G9+3Ak/jE04wIYPLZWdmsb75/IHNhSivsn/uQ=;
        b=eKehI2/OBo8X77Dm0yYN4zqQVSsc865M6hg8v/m0xUmeW5HYZw36q2M6PShkYhHBEl
         02L+6Ihf4b/hTWvHf+HOZmfwX4HKRS2qXK8omTJjJmSFwobS2z7/Bls0wz2tlGYeZozU
         JeZnajjsbM7zy1Ed/0i9uCoS+QNdY4TN5BruhzV1P/hrGNDgns/8UQLgNZ9FNIYg201u
         PRUevWOWuZuiewpervpB4rNPwqeeVw2NDuKZ8LMqtX+XKsnFMBAQ/E4cjzmHwuTvKJ2c
         iA4F1vDzJEglzlHihmTcfFW6nmkSSY6Bya3qJii7fb9+3K4JrTn5Wt1cb1cZdBeWhhyq
         treg==
X-Gm-Message-State: ACrzQf0N3Q4e0/49mIqu/JBOU9x7cLanxaC9OzAT5iG+BGLwWKpEYuaY
        vnLWFGOgCQZBLFW40Is8ojXHIw==
X-Google-Smtp-Source: AMsMyM7ZjO5nJm77v04L2Hbre+eEX32ZuiywMOxaL5E97/XfzA5Sx5F6MV8frz/5D1j0gdUGUFTSxw==
X-Received: by 2002:ac2:5f84:0:b0:49a:fc43:6213 with SMTP id r4-20020ac25f84000000b0049afc436213mr1717178lfe.150.1663869514716;
        Thu, 22 Sep 2022 10:58:34 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id x15-20020a19e00f000000b00498fc3d4d15sm1038859lfg.190.2022.09.22.10.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 10:58:34 -0700 (PDT)
Message-ID: <1974a260-0922-86b8-5c6b-6fa433d976a7@linaro.org>
Date:   Thu, 22 Sep 2022 20:58:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 08/17] phy: qcom-qmp-pcie-msm8996: drop unused kernel doc
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
 <20220920073826.20811-9-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220920073826.20811-9-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 10:38, Johan Hovold wrote:
> Drop the removed mode field from the struct qmp_phy kernel doc.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

