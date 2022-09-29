Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915455EF1EC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbiI2J0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235463AbiI2J0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:26:35 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BB91432AD
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:26:26 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id a3so1330073lfk.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=cy4HLrPiJ3E3sRN+8XfSOCGDodK7p+NbDocY1NUhoQs=;
        b=lJVqoe0X4K61NyudnSBz1RagA5ipIvekyLLoO8Wblt/ahqNt4EAntW2rM9+zJQ2iq3
         437uSvb3291xysdCGaBReaa5UbBS7RzhyGZBOobOlt0r8b2pPu6te4mwDrmz6xAMTQsa
         zHbjRndNzcfnIZnt9w5UH+ZNt1OYMOOljr56JPv7mT/+789Q6kH/M6fh2d9z66U5sxjV
         n+KFx9s1SaNN2ImYb94uLHmQhxxYJLLhLoQwz0QX5gKr3/WCFlak2tGh+7c75/QsUFgo
         5QYjRAamFBDDeOlZNd3/UdvP+EF6/S+CnI8+XhB2bqQRrttmbF+FpT2l75FugMJWv5M+
         f1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=cy4HLrPiJ3E3sRN+8XfSOCGDodK7p+NbDocY1NUhoQs=;
        b=reTDJWZybWbN7wKev3DQ7Y1wtO0XO+R9GjeLFpmtRZ9GZfQ28YTPBk1aYlznyM4amF
         UFh8dguUXf9C9Dq+KkCYp5BhOpISkE34tgiV3e/SGxwBIIz1A+v+GHLRI8HLoLkbMMRr
         clZ5HjEpB/H8Dyc06ufBif802RomMvmKNSPv5rMTrq+oQI4lfvWl10vQlS6BHn09/1nx
         diu5g4kLAOkzePbDwEwfx5feI2lrp85oOxk+pdNywS8pmfQsvcebwapUlWv6km6p6Qzn
         m9kEUgOaaDQI24g/zXf9lDWWaIivV4Lx9S6QyIPp/xdDyRHuim2bF9OH86qf568M4J6g
         j40Q==
X-Gm-Message-State: ACrzQf3ca03ya5/0NbWxyLcdC7JC46OITzdw+M8HN2OG4EJeBZMPD/mh
        IAewQHsnORSjqn/poXXKhVrXTw==
X-Google-Smtp-Source: AMsMyM5prXJF82xthLRMf3JgrfAIv1iGL2nstoBcJrtbntTyE6BY3xw916ARY9uDXlqciFKm08DPRA==
X-Received: by 2002:a05:6512:c18:b0:49a:d44b:435 with SMTP id z24-20020a0565120c1800b0049ad44b0435mr940345lfu.468.1664443585053;
        Thu, 29 Sep 2022 02:26:25 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id e17-20020a05651236d100b0048ae518364dsm729086lfs.148.2022.09.29.02.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 02:26:24 -0700 (PDT)
Message-ID: <767a2edd-e0f1-29dd-76fc-1d41269687b9@linaro.org>
Date:   Thu, 29 Sep 2022 11:26:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v5 4/4] arm64: dts: qcom: msm8916-samsung-j5-common: Add
 Hall sensor
Content-Language: en-US
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        devicetree@vger.kernel.org
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>,
        Julian Ribbeck <julian.ribbeck@gmx.de>,
        Josef W Menad <JosefWMenad@protonmail.ch>,
        Markuss Broks <markuss.broks@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20220928184155.186632-1-linmengbo0689@protonmail.com>
 <20220928184325.186866-1-linmengbo0689@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220928184325.186866-1-linmengbo0689@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 20:44, Lin, Meng-Bo wrote:
> Samsung Galaxy J5 2015 and 2016 have a Hall sensor on GPIO pin 52.
> Add GPIO Hall sensor for them.
> 
> Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

