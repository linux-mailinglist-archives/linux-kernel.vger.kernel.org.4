Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB0D5FB3D9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 15:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiJKNvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 09:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJKNvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 09:51:36 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A7276777
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 06:51:33 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id d6so21167059lfs.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 06:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o7V++WRSPzaIDtGPEYYIIiLOO8ku68lRU6L7fLLgI3Q=;
        b=Sea8heNcir0vp/8tNk/nbJMEcljg/b+OQ4OrKIO9cgl39teEP2kb1+RAz/zlL6XlBg
         yVJYQJJv7wixN4//iWeHIS3sfH7V17twJU32hAZKOXAOZ8lFw/GuiOud8Jh/gRkWYH8U
         ix5GPIGkdPYflocYiLcDn9NvqEK0IvEIBwJ2QlCDQGuKezyn6U2xOAIDS2uhZSof9wii
         M5iI5N24h9SXbpk37JtIrRJT1T3VMTs/ljewXxDWzy/U5aTnbWksLqoQNdk4G+FcQVqH
         LXAyXLS67zNhWp82cPngvQShSVjlDWDgBwfW/jRS6ljlsXtpNTnVUpoFRbDw7qO/R1tE
         RhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o7V++WRSPzaIDtGPEYYIIiLOO8ku68lRU6L7fLLgI3Q=;
        b=z3V5Ta2fFHDBaIKH/amVuwtoM0ZyAuPoQTfMttNB6uuro+MMVaWt36vFGmQZXlwERl
         AY+MN2CJoSIyaraYfzGlpOTOTH+mxGmwPP9GE8eTAww+nq3VRT0AcKKjU1/5QvMd2sDj
         jrL0biuQiQwAByd0nhJzfi+EdolUce4Awt3oSdKyQFUshSzjetNHN5wo2vGyzU9tnvrH
         IsGQKk5fKvjFc3MY9fhE4U1enWiZjkQF/r/dI5p/qYr/LSyIg3osRf2ojPaUEYXSM4Mx
         cQrJ3r0sl4JV+Lk0nI74eWw2v3JFtoCjRMvKE7Mlv1GhXCLujdIUkKKRA0bqDydGunDv
         P/dA==
X-Gm-Message-State: ACrzQf3ZnDwXHdnxfqE7EcEwyK12D+CdOPPhsQkPUZ48ZEbx+VYPOuet
        iTVERKcwWgX7+9DGA2DiQHKoEA==
X-Google-Smtp-Source: AMsMyM5+Em2WuyFeI+AHDoe3/21E5mF1yAld+l6gsPiQ+mJCtYUt2LN74Yv02SdFHeaJYgXN8CPMIw==
X-Received: by 2002:a05:6512:3989:b0:4a2:7d73:495a with SMTP id j9-20020a056512398900b004a27d73495amr8616989lfu.492.1665496292251;
        Tue, 11 Oct 2022 06:51:32 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id z2-20020a05651c022200b0026dde66326dsm2097544ljn.109.2022.10.11.06.51.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 06:51:31 -0700 (PDT)
Message-ID: <d6a6c8f9-9404-62c6-e7c9-77c21084c2fb@linaro.org>
Date:   Tue, 11 Oct 2022 16:51:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 03/13] phy: qcom-qmp-combo: drop unused in-layout
 configuration
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221011131416.2478-1-johan+linaro@kernel.org>
 <20221011131416.2478-4-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221011131416.2478-4-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 16:14, Johan Hovold wrote:
> The QMP combo PHY driver does not use the "in-layout" configuration
> macro to configure registers that are typically accessed using
> "regs_layout" arrays (e.g. QPHY_START_CTRL) so drop this unused
> feature.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 54 ++++++-----------------
>   1 file changed, 14 insertions(+), 40 deletions(-)
> 
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

