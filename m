Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4C7626926
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 12:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbiKLLbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 06:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiKLLbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 06:31:31 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AEE12D13
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 03:31:29 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id j4so12031703lfk.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 03:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hyF6FkyUHkukwBAE9GVV4YhjtohoXdGwlx3Dp0iejE4=;
        b=ArCIX/n5Z4pVv90yyrB/6VQHqH5YHooQEMvqH4IE7TAcy9/vtmzrMPQqFpy4yWy3B3
         d1Fv737eu2hRTFl8AMHvO045l+APx469fYZcUoflKRJ08SRWz44p140uu3RrZUay6ttN
         l2skMtTnSCLQ484x8V8wMaD+HiJKwhUyFOXAKQQJQCetFvR7ibCnNf+Oz6xqxToQWMJn
         7HQdmHMM+5gk0agt+OZCJ/vOlc5iUUaDo1f+L3daYskuDOnckKAVY/2apY1trDFqWp1+
         t/SoazbX5YhHrbS7Ef31WXnJBbPUBNdiOdbIDWCS+4dX/eos4Y/sQXR39f+ehySifluq
         i00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hyF6FkyUHkukwBAE9GVV4YhjtohoXdGwlx3Dp0iejE4=;
        b=pprE9cwC6cI70mQYHUJQExr1Y95sAJ8Idf0L8VMbbGDz8rJXEYmJ8t6dekgy+t/1p2
         W4JZlcwEsIcbd7vN+ZcRDXbyV2j3S9PjErCLevDdFjX+BioH6Jc4wIrn/73BaBj7YSNM
         BVzRf3gsWssPuJ1VH/lkoIaFDPJyuyy34Z6wXWMeCawJhcM63Ie+kjHuageVLOyrD1xC
         zS4aw8R/A39rq9kNIE4WiuCmTjwZVawsigk1NZCx2XwYuXgBOVvCtV+yvLreEWUIIwsu
         BN/C6cG26p1XqvO7oZPMZjV/ouLLTjNrytkFshY/COP/H0pKGtCBAR0aUR06VKqwGiKY
         AhiA==
X-Gm-Message-State: ANoB5pntr8MCyrnlA1vfpNgW6X/rcbQs7fgBWce8pa4BsOmYKawDpjED
        LPPo9HHpP4ayaXKtqxu1bu0x9A==
X-Google-Smtp-Source: AA0mqf74V0/CUUWbv/npiqfkUCReOUvxvwo/eAL5/b6e4Nh/H+ULAIDj4T6zihNXsIEojUo9x56x+g==
X-Received: by 2002:a19:e30e:0:b0:4a2:5163:f61b with SMTP id a14-20020a19e30e000000b004a25163f61bmr1894854lfh.177.1668252688147;
        Sat, 12 Nov 2022 03:31:28 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id s8-20020ac25fe8000000b00492b0d23d24sm824305lfg.247.2022.11.12.03.31.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Nov 2022 03:31:27 -0800 (PST)
Message-ID: <f3ae781b-2046-e1be-564f-9de74107f000@linaro.org>
Date:   Sat, 12 Nov 2022 14:31:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 12/14] phy: qcom-qmp-combo: rename common-register
 pointers
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221111092457.10546-1-johan+linaro@kernel.org>
 <20221111092457.10546-13-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221111092457.10546-13-johan+linaro@kernel.org>
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

On 11/11/2022 12:24, Johan Hovold wrote:
> The common registers are shared by the USB and DP parts of the PHY so
> drop the misleading "dp" prefix from the corresponding pointers.
> 
> Note that the "DP" prefix could also be dropped from the corresponding
> defines, but leave that in place for now.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 24 +++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Note regarding the last phrase: I'd suggest leaving the DP prefix in 
register names, it makes it easier to visually note & verify the 
register block.

-- 
With best wishes
Dmitry

