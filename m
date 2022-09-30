Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F135F09BE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbiI3LQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiI3LPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:15:39 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405B14DF06
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 03:57:49 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id a8so6263586lff.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 03:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=lbb5B+qeP0c49eKSYxVRJmj2eG8kfdi5AdwAAZCocVw=;
        b=C8kLnO4QnhIFyv+/jARRnADkAYjc2jY6H5O+7yw7D56BX3QqcGRouGcNmiCLCdC48s
         JX33APu1UjW6/aQ5J7eNz7Jw4RMm+APw62SOcrOyEyxFVw6OPT9euLNedNhZfW2tp+po
         kiCWR16PFmB3UZNV33SUyrIWHuIS0LqzCu0cjbPrW3cjPueAWTBeyG273rInW20ThF3D
         6qkhAS6J+MkRuiVvVSz5JFtBmaUB/0fdsysltrvRfIM8jMCZFXbUwOMoCa1adCSNYvv+
         L+n8dd0rWPPLVRau4o3JWGnMexItw7ixlzu5u39Vhbm4AC7LwCAPZ6ReUwJzpC/5z7Dc
         ivQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=lbb5B+qeP0c49eKSYxVRJmj2eG8kfdi5AdwAAZCocVw=;
        b=ToO5Wiga8WLfCneI2Tu4iQny6SQRz9ascX14ofxTkbZKOJEFiVDCXrifM0LwWMup7L
         lxWAw3XSeNqaiVX8up6JKEYpT7mAHx6UjLgVnMmIx4ViM5X9V2GlKXDofv3uHboMzS6D
         l1Cn/sdylbJG7JWQzaqGP9IMs+CbeBXaEnPa5tv3cj5gVhaspo/LrgsIgNohx5rRRTfm
         K7rPrgjhpSggi/f5tFb62Hv2oD2TC88cjc3MPGa2/2mbV8QLqHylpy7VNLD9XgBzqT5b
         iHe7OJWoZRbgb0zILoJWqtyOs1PtSOgAazUWiESCww6xcE3U1CFRjweycgTbOpropqQE
         vPMw==
X-Gm-Message-State: ACrzQf29dAUn4079pTI0nh9Ej6sA9pRNNmye3U8ozGlSgtkeCOaOLMv3
        9XNLnQKg+7sf1caguC4oUmnCHg==
X-Google-Smtp-Source: AMsMyM78vR+NBhU6krFftu7B3Dla2vzFMTBXOHhSPjgKD9zG1t6cjHvQ3NsmqRd1d3xQ3/WOQTHtRg==
X-Received: by 2002:ac2:4d2b:0:b0:498:fbf0:4f89 with SMTP id h11-20020ac24d2b000000b00498fbf04f89mr3039758lfk.500.1664535467632;
        Fri, 30 Sep 2022 03:57:47 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id a5-20020a2e88c5000000b0026c41574790sm127366ljk.30.2022.09.30.03.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 03:57:47 -0700 (PDT)
Message-ID: <d82b0c09-194d-9357-a887-f0c8f81fb6ab@linaro.org>
Date:   Fri, 30 Sep 2022 13:57:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 11/11] phy: qcom-qmp-pcie: drop bogus register update
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220929092916.23068-1-johan+linaro@kernel.org>
 <20220929092916.23068-12-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220929092916.23068-12-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2022 12:29, Johan Hovold wrote:
> Since commit 0d58280cf1e6 ("phy: Update PHY power control sequence") the
> PHY is powered on before configuring the registers and only the MSM8996
> PCIe PHY, which includes the POWER_DOWN_CONTROL register in its PCS
> initialisation table, may possibly require a second update afterwards.
> 
> To make things worse, the POWER_DOWN_CONTROL register lies at a
> different offset on more recent SoCs so that the second update, which
> still used a hard-coded offset, would write to an unrelated register
> (e.g. a revision-id register on SC8280XP).
> 
> As the MSM8996 PCIe PHY is now handled by a separate driver, simply drop
> the bogus register update.
> 
> Fixes: e4d8b05ad5f9 ("phy: qcom-qmp: Use proper PWRDOWN offset for sm8150 USB") added support
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> #RB3


-- 
With best wishes
Dmitry

