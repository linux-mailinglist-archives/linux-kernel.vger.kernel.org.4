Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C3060B70C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbiJXTQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbiJXTO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:14:59 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B772B1382CE
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:53:10 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id q9so6968827ejd.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OSNta6j8jc0z097kR/W20x7XcC+vEjgf1CuXPUrIIVQ=;
        b=bFwAabuKfvfo3U65Utz940VlxvhAw5iNnzUpMDWI+bwVrecC6xt0GKHHkdFP16W3wj
         bIDqjnHc0yVwigz04gWitDY5crt9HGGYWrYDSh73A9Qxln/1qFSG32yU3ti2V+WOrsrd
         rq56Q6m/AFnG5umk6imifEdEUE5PGXdVyEJm/iym4bxpgNB4BjcAf/k7ce7YnQomhm84
         aQ30+sTcl1FWn1guGlM5LdrKGp8WLSeo06Utbx48ATzvI6U/tWKiaz19+loy9JIW2Pja
         /juxKuxiRmEbcE9i3dfHDVIma3upkWyOkzOyCzW1zLiSEThXiQ/tXs4QrLJfDKlszOv9
         xapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OSNta6j8jc0z097kR/W20x7XcC+vEjgf1CuXPUrIIVQ=;
        b=n4B56KCB+40W7l1qSmh1pFWQEYuQCl9bQiiAiuuj1jR6UoLWyyv46gLBl1ZkoJAbvo
         Eee2AffEECPSE6Krrv/XDXsfvSOFl07I4jfTkYrsmbA/DcjD82IlbL02QLj58BGK6X/C
         ms/j52NlRguVQN8gk4ohhnbyM+PD7n1VMKtR+XVoDpW1PelmIFQoDoMpIoRntop/Q0FB
         CEN1nCrpUvtgLiPo0xKyFKYjYjJU8UYIZJBhiRo8tQ7uYkL0KF0VgV/BU+S1fEZRJ4sG
         95QSSB58ygRF0GyoMoGDfc+ayjrr2OrCAgbKgi8iMdazOdmUGZur8v5zV8UYnNgwcuhn
         myfA==
X-Gm-Message-State: ACrzQf0f/khi6O9qTz+B4Z1Dmf0BYuZquZX+edlRIqB+YbG9sJKO5yw9
        dIAWsuXw8W5JgzhJ95U8DVnEhHEOGv4MgURU
X-Google-Smtp-Source: AMsMyM51xg81Lcr7zB5TgegVtMIAv0VkQFmi/9Q7RjzyIAWwOc60oiFNKW2WKE+r8fKiZ0uLNOrVRA==
X-Received: by 2002:a05:6512:224e:b0:4a2:5060:55ef with SMTP id i14-20020a056512224e00b004a2506055efmr11755036lfu.412.1666618388371;
        Mon, 24 Oct 2022 06:33:08 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id v6-20020a2ea606000000b0026dcac60624sm4808972ljp.108.2022.10.24.06.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 06:33:08 -0700 (PDT)
Message-ID: <db383c93-89de-d76b-7cb9-00e1bf10fdb2@linaro.org>
Date:   Mon, 24 Oct 2022 16:33:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 02/13] phy: qcom-qmp-usb: sort device-id table
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
References: <20221024100632.20549-1-johan+linaro@kernel.org>
 <20221024100632.20549-3-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221024100632.20549-3-johan+linaro@kernel.org>
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

On 24/10/2022 13:06, Johan Hovold wrote:
> Sort the device-id table by compatible string to make it easier to find
> and add new entries.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 26 ++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

