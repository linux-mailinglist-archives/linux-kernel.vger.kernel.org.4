Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540D66267D0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 08:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbiKLHvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 02:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbiKLHu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 02:50:56 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A63340455
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 23:50:55 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id t10so6897884ljj.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 23:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a+UsEcMcNcwswMPlSrExlKrjtrGQnEDikWAfx7fSc14=;
        b=F8YQav2VqC9G/pMCy1ay6dcHQpohaoCsguqJCq1ux1FKgDK6q/F8x7L1FWCoemvRJo
         p4B7GLYT/kONcA7ztts82fMUcFTDKNdjf2u57/7xFjVSSHXxaDSWeEpkhCs3a+nu3LRt
         h/JXAqweBzv0HygVS7IZC1Ust4XIHUoiRW8NMh7HQtdkfRwDXe17aRner4dQdACviwvC
         jBdhbn4YqCidoONOmYigVYgDeSKfSJdPVtdPA+lo9O7a1H5cyuVgcvdSuJaDDxQ8H6E8
         VJ6QOMGGMC71ZFFWDFc88Qoeaq9GrjMY7sCREOFSU1Ze/8mpAvfEqV5+aFYaI0IgYfo5
         8e+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a+UsEcMcNcwswMPlSrExlKrjtrGQnEDikWAfx7fSc14=;
        b=18BobTmU2N6H/6W2PmaJ8BwocH6n2J+GgyZf6+IRk7JqTLXkpd1zdNaR9gXEyKOb8/
         e3a9rtw8aSsYCOBG3HfTMQPI49Gl6HLQNhqIkdLi/FfN2IcBX/dmo14xOk8PVdP5s9Ov
         03wzaT7VL35K7+oPY3Bx6T+GyFoNAQPuCxgIKg+k35njAY8MPjZ0QHDrNvXrcIihzOz6
         LVjHO1vxabCx02YQhlW7Qy0Nlt4gbdYU5TszBcrwQvvEK+ykbP23LaIhvWH29SX2Povb
         5AZp3Tn84G43zuOJzlKiZvWV5EZeB2KA6cMR4Ug3sK2YfSel+Qba8a8XY6VJkcM4NB8z
         Hkrw==
X-Gm-Message-State: ANoB5pkvM29qI/NGwTPTwl6hNNHCGKw5RAE2aDB36PpIOlG3WMcNkkBO
        EQkrXx9xfHHHfuX+mCkAmqZusKQ9qsuqN1kg
X-Google-Smtp-Source: AA0mqf7htDhPrt3ZavGZ+yqvxoI7/xMhVWSiC+npni4LfAPjxuywVVj37dbf4XQB6kpQV5yLfR41Ug==
X-Received: by 2002:a2e:b623:0:b0:278:f073:d3c0 with SMTP id s3-20020a2eb623000000b00278f073d3c0mr676510ljn.357.1668239453642;
        Fri, 11 Nov 2022 23:50:53 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id h8-20020ac24d28000000b004afac783b5esm736430lfk.238.2022.11.11.23.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 23:50:53 -0800 (PST)
Message-ID: <8e211b4a-f102-5bbd-0b74-17e41734157a@linaro.org>
Date:   Sat, 12 Nov 2022 10:50:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 12/22] phy: qcom-qmp-combo: separate USB and DP devicetree
 parsing
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221111085643.9478-1-johan+linaro@kernel.org>
 <20221111085643.9478-13-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221111085643.9478-13-johan+linaro@kernel.org>
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
> Separate the devicetree parsing of the USB and DP child nodes in two
> dedicated helpers in preparation for merging the driver data.
> 
> Note that only the USB part of the PHY has a pipe clock and that the DP
> implementation only uses the tx/tx2 and pcs register regions.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 81 ++++++++++++++++-------
>   1 file changed, 58 insertions(+), 23 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

