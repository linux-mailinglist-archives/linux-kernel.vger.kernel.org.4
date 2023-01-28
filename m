Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7699767F710
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 11:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbjA1KVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 05:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjA1KVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 05:21:48 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE16CA250
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 02:21:46 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d14so7040387wrr.9
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 02:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KyK61PIIynqyzfMBCuw7rB8JAyotjQ6xTZX0sXTvwv4=;
        b=aKI/K7Rv941xqFlZ19JayXGiBsYMAlSpyJe9VmKmlpQNAInd1AjU1VlLuYYmCym/b5
         n7FEjWHH1hzLXKNB4BGFKA950L3HNQco+O0B7TmUI8zQSOmeXc8895k41hLsrQU34krD
         khQt2o05MdDWqYHgeanECTDWS1akJMh0GPMFDAix8uf09zGnk1YFW4+UcQcLGWil3B95
         nC9Piu/KtnLRVm5fPvqTXf+64WaBSiQHc56ti19SrN2IPRE5h+gPuYi/ELXRU5+LVIPx
         yCP87txSIyvuPME3WExIWG/TkRzoVAhMc0ZsGCbDp1NVuQp/ErSKcOZjFvIuWdN0lqXE
         hqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KyK61PIIynqyzfMBCuw7rB8JAyotjQ6xTZX0sXTvwv4=;
        b=LOJvcItwOShwrOuYx4vy4brksB9mSH3tO4N3Qs3M15bKAWmgVyx+Z9hnT0LfQTX3zE
         1oIE7B5Lz/7GRelzo9On3YVgAh1G7JozjzhBNjBiNUq64+pA670lOl+NGGZo2JKx4gVk
         VaEM8o8p8zmsouQSlEjlJQf8R3pYXpPWkmEOuEvVrBARH+R3OJrvjRzl6EYJFsP6oS/j
         xA2l94Ebnj8Ig2A0aT0aOssFfoYtJhXTuzJtBU0wIyKvLj6/bRIaXccZWRmhdMPfxq3n
         SR5GlKMX1saoMVtLpRq50idEobEOw37/hwjsa2L+eXiirraXj6nayukkDYlArbpJuiU7
         Hw+A==
X-Gm-Message-State: AO0yUKWNn5V8s9b204+/NyJjiAjGrlcpLqvbfzfxu/xARWqtaTrG6M9E
        mIhyv2J/DsS4CegwrF69QfGlqw==
X-Google-Smtp-Source: AK7set//WJfcsdQmnDUXUYzjIqHvzDXemfS6nhNxgE7JDvSqI2eYOResaLvFmYGXsKvGS1vDDCYfKQ==
X-Received: by 2002:a05:6000:1814:b0:2bf:c851:bf8c with SMTP id m20-20020a056000181400b002bfc851bf8cmr8363720wrh.48.1674901305408;
        Sat, 28 Jan 2023 02:21:45 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p17-20020a056000019100b002bddaea7a0bsm6148579wrx.57.2023.01.28.02.21.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jan 2023 02:21:45 -0800 (PST)
Message-ID: <3ecfbb0a-6c24-6d72-f9f7-5c9dc4a080b4@linaro.org>
Date:   Sat, 28 Jan 2023 11:21:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] dt-bindings: remoteproc: qcom: Add sm6115 pas yaml
 file
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     mani@kernel.org, mathieu.poirier@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
References: <20230128053504.2099620-1-bhupesh.sharma@linaro.org>
 <20230128053504.2099620-2-bhupesh.sharma@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230128053504.2099620-2-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/2023 06:35, Bhupesh Sharma wrote:
> This documents the aDSP, cDSP and MPSS DSPs present
> on the SM6115 SoC.

This should be patch #1 - before you start using compatibles.

Subject: drop second/last, redundant "yaml file". The "dt-bindings"
prefix is already stating that these are bindings and their expected format.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

