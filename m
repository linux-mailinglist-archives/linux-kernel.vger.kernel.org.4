Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523A1671298
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 05:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjAREZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 23:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjAREZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 23:25:42 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3621054223
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 20:25:41 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id u19so80252149ejm.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 20:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BGF78K5uxVMcxASRhj9Vo8p8NdJwhzA0eYIuGJGWWLo=;
        b=An6OOmkyPzsKv0oVvpXgPHyn6ro3yRu1a7w/+aP1Np1IVgQMoVWrQBSm0tfkyz/8rP
         fNZxGNcyFUNLXu16dw4UmwldkRfedwRr5dVg1AZ2gOVuwTW4yl0VOVcTxGiOO4JkFAl3
         vGrRD2uws4mOcq1nbF6xFSrM951ioK29FC9/Jvx0nkH/JZDbvQvWMWrp88zS80VyOe0Q
         bJ61fPYfbHjIJKcYCfOcfAO5j5Q/5pp+9b9es/Q9GAEI73JgJa1JWZOo8fcDI29JgMiN
         QlRdqkWyrqi7eXGO1qScLz0+V9ZvG+VWgg2aVic8TKCbjQKcqaXwTJk+5amXDmXSywO2
         l1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BGF78K5uxVMcxASRhj9Vo8p8NdJwhzA0eYIuGJGWWLo=;
        b=eLGY+lFDNvOF/YPM8GonMKsTyk3woOrUBUaP6ICBFRk9ga0n+0bapX47dyOI7Y5ihg
         FXNHq6faZmg/LJWByX59av86DDqIHMHmjSz4le2nd0bNMZejX+pLe3NMj5ICV/jESB+c
         gtA9F6yEICLyeyG2xTIo+9n8By8oewE3etZe2RZGo769MUJrjrkxGA1ZoklaByUcC69q
         B2gU0rBmJDPEFOSxDJTO/nBGMPqIFq9urZQJ15LLrFN1jmzY+itYq5lL+aFwToLfduNV
         ll6zbzFPWs0i2ZoBeSIFXeGvkFHMrVagIrwRUifbd1NK4MJT9/ebGgqXT8jNuo6+nici
         4RZw==
X-Gm-Message-State: AFqh2kqllgfLPySsAmiTjKzTwhW9Wi0rL2rV1FOArVM0EQ61f2qWN6xC
        9llr97qmdkA6Rkd3iBDBBOyE2A==
X-Google-Smtp-Source: AMrXdXsq/bEn5LObZoxUw3gLg5N8OiTmO8Pqyij5vmyAwEwg7B0e+DRwxDk9J85mjR1TosuKEQpI9Q==
X-Received: by 2002:a17:906:29d8:b0:86f:a1fe:237a with SMTP id y24-20020a17090629d800b0086fa1fe237amr5847894eje.54.1674015939829;
        Tue, 17 Jan 2023 20:25:39 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id q21-20020a17090676d500b0086a2e31d1c1sm6241301ejn.28.2023.01.17.20.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 20:25:39 -0800 (PST)
Message-ID: <62b5b6d7-312e-9112-b109-4e42f36445a2@linaro.org>
Date:   Wed, 18 Jan 2023 06:25:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 3/8] phy: qcom-qmp: pcs: Add v6.20 register offsets
Content-Language: en-GB
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>
References: <20230118005328.2378792-1-abel.vesa@linaro.org>
 <20230118005328.2378792-4-abel.vesa@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230118005328.2378792-4-abel.vesa@linaro.org>
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

On 18/01/2023 02:53, Abel Vesa wrote:
> The new SM8550 SoC bumps up the HW version of QMP phy to v6.20 for
> PCIE g4x2. Add the new PCS offsets in a dedicated header file.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h | 18 ++++++++++++++++++
>   drivers/phy/qualcomm/phy-qcom-qmp.h           |  2 ++
>   2 files changed, 20 insertions(+)
>   create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h

I can not verify register offsets, but generally looks good. Thus:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

