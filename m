Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AB86045B0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiJSMrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbiJSMrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:47:14 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B5913330A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:30:12 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id c20so21955441ljj.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L8E8gyXUD2KEx90N6AcvvkieEvFzwXq3d4Azsc6puEA=;
        b=q/IWmWM1tJF9Sxvzi7WUuwFyXDtQ6zTcGg0AiB0rqy+x6NEfGkJkAAAskyM3a4v9u+
         7ttoX7i45MBk+rJt1b84MKtFXSKINFD1LjLiMrxIfJMBuFFhgUMid2IY57CUrxMvI/ba
         FTzWa30gegvtu5VBBaJspw0l2BWL4aWTc0YbSi8x7Dn2j5KAsEZHJ57PuaVow28DAcaD
         DT7F/+RZ1tMH7ih2/r+VaFU8rj6opvNstl45bARoS2Sg4AZg2kGALG44HADNEduPKUWj
         PeU4/OeJ5wNuHu/zusCWN2xonPtbOL2IFMDZbxUPInpTGELJg7gYLIDPJUxzFR875z4V
         NoNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L8E8gyXUD2KEx90N6AcvvkieEvFzwXq3d4Azsc6puEA=;
        b=wSbwcwAiW5snD51WQlPoCQ8+dYYkj5zAtNRhwXB6u6LMjvppSxPIhTGXdY0LtJ1gzg
         7KigPdwXmdWK/gJPTH4+wRj4hOVXi+JGH17LVN5RWXSR5OlUGjYzhLDv0PjH+dgP/OS2
         GQ9OtlkRVzyg+idcitZAkFldYdyePQTQN7y7z0Vul7hwCsOlHVUCkCxpVque+v89W02p
         WGL3sIy0U8HYw6HCyYrI91m+0tSOO5hnGvNE10llPNfLmtelNYuM6vZXnuWTlIb/oUDr
         UZlj6XtdQuQaQHLd7jA62gE1AlZz46nTn6oAqiIFIwiG2/9Ftxc60Aj10zr4L2t4ispa
         PbNA==
X-Gm-Message-State: ACrzQf1kpwWDxDwrsnIO4ewj8HYuBNDuDP0ybCjcf+v7jbnqEUntS9z9
        TKA3iuIjVKNO+AKDJpp2tlslJQ==
X-Google-Smtp-Source: AMsMyM6R8uG1DPCTE/NbEB3JR7+VUI8N1pA82Yk2tAD7hvZ5NMqT5I5v9ALWk4IbX/1TjehYlBibxw==
X-Received: by 2002:a2e:bf0f:0:b0:26d:e258:9ff6 with SMTP id c15-20020a2ebf0f000000b0026de2589ff6mr3037080ljr.356.1666182547159;
        Wed, 19 Oct 2022 05:29:07 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id f18-20020ac25cd2000000b004a01105eea2sm2266332lfq.150.2022.10.19.05.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 05:29:06 -0700 (PDT)
Message-ID: <1fa2f38f-34b2-7902-0157-b483c913f885@linaro.org>
Date:   Wed, 19 Oct 2022 15:29:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 02/15] phy: qcom-qmp-pcie: move device-id table
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221019113552.22353-1-johan+linaro@kernel.org>
 <20221019113552.22353-3-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221019113552.22353-3-johan+linaro@kernel.org>
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

On 19/10/2022 14:35, Johan Hovold wrote:
> Move the device-id table below probe() and next to the driver structure
> to keep the driver callback functions grouped together.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 90 ++++++++++++------------
>   1 file changed, 45 insertions(+), 45 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

