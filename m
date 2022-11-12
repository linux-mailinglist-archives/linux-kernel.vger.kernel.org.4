Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5F8626918
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 12:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbiKLLSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 06:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiKLLRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 06:17:55 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170C723BFB
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 03:17:46 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id b3so11939587lfv.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 03:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a9/j7JZy19eS+PBrwwIX6icmMNg1umYgfu8PqBTGqlU=;
        b=IA9PI0oH+xolk2+oKu6YLAJEFZQE6CC9vCwb3K4oUnqvf8b5zIUkrS7ljqP5lKK+6C
         sE47n3eTAKBEk7ijQzBDVYNlBrbInB067/p1uTEdDc+cYqP6Pm/+c5N16xmT1Rvrr/ze
         EoRyzMYOd8HEViNfwq8xq1ysuDUDsJsxPWohqBixMfaOQlzohk0vl0DgktyaLKfOUpRc
         txZAR2kjZUL4VRa+RuFU71DIOAIOUjRRQLu9e+j9M4dCWpsi3xqBwHlAX+8j1LyC3Gdg
         ILVQal/7pveVY6Mrrt1Gnw2v+hRKwfvUT4BroqCosrOUfk4VQfazh7ees3v5u63aAFko
         MMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a9/j7JZy19eS+PBrwwIX6icmMNg1umYgfu8PqBTGqlU=;
        b=XPTpEIAqmxVu0ll1iUWrWyg1sb2cfl65o9m1trZmKKfTvJpkQOLhGmtu0HydZc+fih
         Gg3xLuPUnjrrJ8eIttrAYESO+MF5zb/uJABvX/vz/RtyDgd/4o1PEn9DYqnCXEbDuEev
         qTnkwg6YBqb2yZYpe+CHPashttUrr1gYR85qymU3oWnSkNG8qzMvIG0eB4ep5xjs86R6
         AfRVdf5tngWKNa+i4LB3djAGevozrhdCReZHL/OUooBeZg2qNruRgAAdedTmGoLyZpHw
         OCmdryjCY4vmwp1ElWC0my2YIgg99G2+VnWZABN0zbz6+9yu4Tii8X9VAbhpPOo83Vue
         PEtA==
X-Gm-Message-State: ANoB5plwY2F3Go7J2PozM1wZEnDrHOuJiA2r6Hh0cfoAB1fztvO2oPdg
        F/hSGIAcFF/XlMPozKmjnR3tKg==
X-Google-Smtp-Source: AA0mqf5WR59psQF+ZKKE8lacjvMnXGhpXVifJY7jWFEezqckxEMKjxzVoBQiy73/qdltB+LriTECpw==
X-Received: by 2002:a05:6512:b8c:b0:4a4:5f2e:49b3 with SMTP id b12-20020a0565120b8c00b004a45f2e49b3mr1907346lfv.148.1668251865058;
        Sat, 12 Nov 2022 03:17:45 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id z7-20020a056512370700b004a03fd4476esm816659lfr.287.2022.11.12.03.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Nov 2022 03:17:44 -0800 (PST)
Message-ID: <75e188ce-99ea-7511-a561-5b0fef9feeaf@linaro.org>
Date:   Sat, 12 Nov 2022 14:17:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 08/14] phy: qcom-qmp-combo: drop redundant clock
 allocation
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
 <20221111092457.10546-9-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221111092457.10546-9-johan+linaro@kernel.org>
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

On 11/11/2022 12:24, Johan Hovold wrote:
> Since the QMP driver split, there is no reason to allocate the
> fixed-rate pipe clock structure separately from the driver data.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Note: it would be nice to port these two patches to USB & PCIe QMP PHY 
drivers.

-- 
With best wishes
Dmitry

