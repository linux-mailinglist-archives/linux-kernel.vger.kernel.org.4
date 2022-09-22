Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABD75E6A4D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 20:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbiIVSD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 14:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbiIVSDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 14:03:40 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6971510B598
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:02:52 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id x29so11959901ljq.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=EshXMg3nUCHJe7fYmuvFDupXGZNi3eqDvUI4H5rj+18=;
        b=DVd2fmll2k0DewQswrBXEruZUT0JaLC2YswtGDjFUwXL4v9abfjTOyN0Jx8C1PfzBw
         kbCvqP2/pX8ZdcLDV6se0YoqafGud9kx5sL9nCEa4tBmvE+CiafkYQjM+cHUtlsRxrvI
         cE6hB9Ls876ApMG+R8Pk56OT6XdiHJ8mD5MTUjcQFVhXu07c8shJc8c3GBuT1IKtwrfN
         hCZmZq9FAtPDH/2J66kZLO0NfRK2IOnCcwyOhwWqZYRVIGXgAeRQpnDmTy+SqAXGvBpj
         tRrGjUBqZ+enqxJ62VR3NUFQ893HzB6OHTJAKG2v7XaWwc9pZRIMsYBVZNtTGpJWw87H
         rubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=EshXMg3nUCHJe7fYmuvFDupXGZNi3eqDvUI4H5rj+18=;
        b=q0T+LJ9sBJYzlDGDzq+bnjjJnqZVOwI+7kawFUqRtRqGnHdKVmSyPah7b7gqfd5IVE
         pWYUheNI3XtGG1EDKLHyUklWfPEQ1nHxJ4bisLIhJJYENCZgbhAnplCX5lq/jg7YKR35
         GIc8PxTaanH+02gFXbEvAf/7aVR41q1Dho4mjjGeM8OOpH+38lEkVDGXEZamwVOxDSx/
         efvlugKPc3Hm5WdtlVmXMz/FRAhYQO/NP3r2f2TFI+l0JPz8cV4fSQDvP1LWRWRfDiYm
         0EoyfMz3NmUzQFjWHTcAcXBiQaBJ7SBPGO83+u4HBTh4aGyqk1fzqV4SJcPQ+WQ/Wg1Q
         WpjQ==
X-Gm-Message-State: ACrzQf2NZlri41HpmraU5+lbuetcbMOcd2npvTCPE6ljgr9s3db8nMLT
        kobBfiUKMUFXvG88iG7PGmRUpQ==
X-Google-Smtp-Source: AMsMyM7yUdTtpYylhtYbX4QNSfYH4Dti3r6SyaejRw3rSVmveu8hWLXUMpJ+Zm6ekHuENAp4gGF6+g==
X-Received: by 2002:a2e:1458:0:b0:26c:3b83:e039 with SMTP id 24-20020a2e1458000000b0026c3b83e039mr1642085lju.484.1663869770188;
        Thu, 22 Sep 2022 11:02:50 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id c4-20020ac25304000000b004996fbfd75esm1045483lfh.71.2022.09.22.11.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 11:02:49 -0700 (PDT)
Message-ID: <8de63b63-f88a-7342-d286-8826a55e78ab@linaro.org>
Date:   Thu, 22 Sep 2022 21:02:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 17/17] phy: qcom-qmp-combo: drop redundant DP config flag
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
 <20220920073826.20811-18-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220920073826.20811-18-johan+linaro@kernel.org>
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
> Drop the DP_COM control block flag from the configuration data, which is
> set for all combo PHYs and hence no longer needed since the QMP driver
> split.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 63 +++++++----------------
>   1 file changed, 18 insertions(+), 45 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

