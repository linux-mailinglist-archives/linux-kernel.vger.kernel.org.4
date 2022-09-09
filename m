Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9E05B333D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbiIIJRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbiIIJRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:17:01 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683B1128C36
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 02:16:56 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id p5so1059569ljc.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 02:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=HwSPkOLsB3PaeJ/979fVd6W4oSX7MjdZh6/4vBoMvj8=;
        b=fLLK6hOWnY1NKt2/9ajJcBXVBawXcP/rjqy5sIzCV2fC6BSP2GyZMCrq/Oe2XtVHHc
         0UdYW+rQP1P51uENHMtg4PZ45PX+IlMOYfA9fn2iRzihWA1IyM0UxzL3xT7TZsikSicy
         RVAz8bl5sLqfVAHDPBGjvlsyo61vlc+3OOHFW+UTEaLIzbr8md3sxfF3hRIZWe1cKYg9
         85mdXqUmtYGjcNBYCt4gW4MfB8J3awgA2aY1Oz0EWC/Awy40MCebQDkPhLypHjCOc/LN
         lVKIaazrD26h2zV4qxX7aL/CXHhME8xJOekIwykOKFW2Gj5OKG7b9Xscwv8MLskBvm4O
         AWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=HwSPkOLsB3PaeJ/979fVd6W4oSX7MjdZh6/4vBoMvj8=;
        b=aiQtrsXf2hQhZrL2AeNH1z6Xy5z+PMrMPHEg8516eSV7vsmEoKyBFFGcBv5ewk5ssE
         5+8GgMdF3BAGR7/xxrP9lmhxNqb+oPRENqg8W1cyepXKiYn4LLbzyzfTSw30VmCyfgfp
         4fv91QKLu2bljRpNFsuDwFVc6jYUHK43LD6KVmAhrVPsydm+2Gsgb2rysLC8vPGkxLxT
         xQZ+vrtRPKno19C9cWiAA2G/EbjKCSGgqM81f3xqhuwNt0VwH0jScMFRirfo5GnEGmWm
         EV/Y4pTyIlHmkfGSbwI37g9bSX5H98vtMupOYcFPtFv14gkLcEOVIejoGWqUx2vhJaKK
         ZtTg==
X-Gm-Message-State: ACgBeo0ThkoohrK5z+c8zmNqoyvgFH7tc0NeqwmmJnBbs34i4Mojc3yJ
        zJvDB+txyQ5ueG5vflb6jkP6qQ==
X-Google-Smtp-Source: AA6agR5tI6dxeZKZCdHy9EBG+L1v4GYsDaaX6M/D1VJQjaAot1Jq+s3AYRya/65TCVY4znvdNajeOQ==
X-Received: by 2002:a2e:804a:0:b0:26b:66d3:4d51 with SMTP id p10-20020a2e804a000000b0026b66d34d51mr2396991ljg.293.1662715014841;
        Fri, 09 Sep 2022 02:16:54 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id v9-20020a05651203a900b0049476261c30sm3305lfp.113.2022.09.09.02.16.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 02:16:54 -0700 (PDT)
Message-ID: <47066467-bab6-2f68-2924-cc93cf0c803f@linaro.org>
Date:   Fri, 9 Sep 2022 12:16:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 2/3] phy: qcom-qmp-pcie: shorten function prefixes
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220906074550.4383-1-johan+linaro@kernel.org>
 <20220906074550.4383-3-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220906074550.4383-3-johan+linaro@kernel.org>
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

On 06/09/2022 10:45, Johan Hovold wrote:
> The driver function prefix has gotten unnecessarily long and hurts
> readability.
> 
> Shorten "qcom_qmp_phy_" to "qmp_" (which likely stands for "Qualcomm
> Multi PHY" or similar anyway).
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 137 +++++++++++------------
>   1 file changed, 63 insertions(+), 74 deletions(-)
> -- 
With best wishes
Dmitry

