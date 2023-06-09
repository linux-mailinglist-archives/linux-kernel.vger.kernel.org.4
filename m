Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD1F7296AA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240939AbjFIKSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238770AbjFIKRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:17:34 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C8B4C22
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 03:09:21 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-510d6b939bfso2882822a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 03:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686305360; x=1688897360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eqc/GRalmOX/Cpkh1a/xoLsbg/daV5DaountlO/f1vQ=;
        b=wcaRhO6QN3tlsf2JnM+ZSo4mJKsailFT6iJfYjD1OZQ5iiap5M5MjbJgrvfNZkHecK
         ZKaulST6j9eHS2TQCqqSRw3DlrfwhrOLJJcOf/cxKzo8WX0EDox2vEmotE3J/sqTGUOX
         22e85cfTh3qhRQyCeP+5yvECj4CCUWF/gcGMrdeoLRxy+uVIsTuO9Gcx+wYjihA23yqA
         Y91jofWfATzguUDEDZEjDTYLjihWEiy72KLl0gwn1vh0dBXXNi+P1zyJOYPIlkZvtxrK
         2ncGFKj1HM18q+ZBovngL/zzClFjsI87iFzpDqNktj00aDMBlRT4XSlHB9vpIkyOVqKr
         wMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686305360; x=1688897360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eqc/GRalmOX/Cpkh1a/xoLsbg/daV5DaountlO/f1vQ=;
        b=IqaTO3M9QIZjNA1TazFMWTdABBFs9OXLTny07DF42Gd0zKW77pGEZ5pd/aemgmTTI1
         0mO+UcX/nZZdPL1fvxamnQmSM4RqOjFi2INM2J+ChRKiqKL5aaUK5jhk59JEzCqaulY7
         OL0ksNqYSsBL7Ar71hHJ/wn2Y83FfHORsg3DHuuZM56zgdlaKNJCOQ/OO2yh45+/2pns
         XOj1W91HgcUKqkksXr2krYwA2gKFF3sL1PVKELtfZaaLIhqFog9hc2MGqIU2Nm0hlalS
         BPgrg8uCV96y2TWIofc/gueoniHhu1jTQG3VCissCDouMlTNy+ubZrhByGUXNAogeRlb
         VG8A==
X-Gm-Message-State: AC+VfDyLdS8ghd6dlLeWmQliwmdSzHLbeqeksnF/ApacSvLfwcNGMMGm
        EzdU6iY0XjQ9/rpX7a0psxFjWg==
X-Google-Smtp-Source: ACHHUZ5I+iWpj0MgD+gxarDbhhgIyHddx5lvZA28//Cy2f9fowQOYHaXvbmPuMlGFSt4g6l+CusWNQ==
X-Received: by 2002:a17:907:94ca:b0:973:ad8f:ef9b with SMTP id dn10-20020a17090794ca00b00973ad8fef9bmr1385977ejc.5.1686305359815;
        Fri, 09 Jun 2023 03:09:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id z8-20020a170906240800b0096b1206aa3fsm1096744eja.89.2023.06.09.03.09.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 03:09:19 -0700 (PDT)
Message-ID: <d5bbc7ea-43c2-77fe-3d58-251e2488ad64@linaro.org>
Date:   Fri, 9 Jun 2023 12:09:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/8] pinctrl: qcom: qdf2xxx: drop ACPI_PTR
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230601152026.1182648-1-krzysztof.kozlowski@linaro.org>
 <CACRpkdZaj6FWLszvBid3C9LwVpiwhK=WsuJrcbMgppx80NbgjA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CACRpkdZaj6FWLszvBid3C9LwVpiwhK=WsuJrcbMgppx80NbgjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2023 09:12, Linus Walleij wrote:
> On Thu, Jun 1, 2023 at 5:20 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> 
>> Driver can bind only via ACPI matching and acpi_device_id is there
>> unconditionally, so drop useless ACPI_PTR() macro.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Patches applied!
> 
> I had to manually update patch 7/8 to account for the IPQ5018 driver that
> I just applied, but I think I figured it out, check the result!

Thanks, looks good!

Best regards,
Krzysztof

