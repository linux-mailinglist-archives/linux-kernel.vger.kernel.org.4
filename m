Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8633E60AFA7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 17:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiJXPyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 11:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbiJXPxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:53:42 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFF1857F3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:48:54 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id kt23so16091ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qaWaEd0PTNUwkHSdWBfjQaOKY0U/4iADkLwuX4tjYsI=;
        b=QTLOedLCTWH0jSE73TXFDlpXIEqR6RHh3j3y/2qLMiCJ04s16ps7GqLwvgXl2lHMCR
         QmogwGOsM/BiXf7D4uKAvaqjEXfvhYSXBEnHwAKLLIAkR693vNvKi/G8Wff7DnZiazsn
         RQihbA1f6S6qq+gbrpZjQeISnvRLKUyDw7LBo/LaiQerMEgkc64xZtKkp7lkm6+sep0g
         OGhS1kwhRltDJoXwCHK0nF7Gd0LdRMQBFkL5v2a8BR1GIcLQLgxg8JGz46Ifa7ePwUrs
         7nvgAKnIoYg4sgNmHoBTsTTutjmfdoNR3rAoIFKeLeXKFa1RXF7lE7GI+CCpSvSIPM3v
         Ridw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qaWaEd0PTNUwkHSdWBfjQaOKY0U/4iADkLwuX4tjYsI=;
        b=O6a2sN4+Fu+ONZPlGv0Tst3uNxNJtf4eZF01q5dI5qCHh2zARoGmaCckdigNEL7oFj
         BZbQEs4wh4YNWgZOKy0Iea92wMRlEA1V4vnND1pbrjDLgvlhFKafijBTzcyoWy5Zknn3
         7AHuizHSC5mT3sTRX9erXQ9jptD6izpYJiB3Gx9mOYPmwFArZWLBUNgh7HjSh0lMPmDR
         6zaO92OuO25VdaBv8oSR589FEik4zmKAaEZ9u5J0JK8+zyUZiUPzcWunmjv4m/mhUwIJ
         Dfri2voHMBAd7n8CUQN0KOmSbTd7IOqBCrjlqiJw/o0Gm6SiM+9kadmTvV7awIUO8ML2
         0xGg==
X-Gm-Message-State: ACrzQf1plO53BbQUX618ypu1B8uTK5K/FKN7gvVORmGfEJBLllpElSto
        9hADkWiPoDbsZ7Ux1gq6z3jvEfCHM7XRakDx
X-Google-Smtp-Source: AMsMyM6HpatqnbXqxsA3dpg5mU8rj42wb07sIMKMi3Kr589GIFHjAxaf7FDsiuupdql6gn3KoPVsDA==
X-Received: by 2002:a05:6512:c0d:b0:4a2:4129:366e with SMTP id z13-20020a0565120c0d00b004a24129366emr12771891lfu.328.1666618230554;
        Mon, 24 Oct 2022 06:30:30 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id w25-20020ac24439000000b004a240eb0217sm4522460lfl.251.2022.10.24.06.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 06:30:30 -0700 (PDT)
Message-ID: <65db9e0a-29ae-3584-9dcc-e45d8a8a1cb6@linaro.org>
Date:   Mon, 24 Oct 2022 16:30:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 02/10] phy: qcom-qmp-ufs: merge driver data
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
References: <20221024090041.19574-1-johan+linaro@kernel.org>
 <20221024090041.19574-3-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221024090041.19574-3-johan+linaro@kernel.org>
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

On 24/10/2022 12:00, Johan Hovold wrote:
> The UFS QMP PHY driver only manages a single PHY so merge the old
> qcom_qmp and qmp_phy structures and drop the PHY array.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 171 +++++++++---------------
>   1 file changed, 63 insertions(+), 108 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

