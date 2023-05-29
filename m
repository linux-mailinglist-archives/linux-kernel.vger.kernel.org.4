Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E83714A2F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjE2NWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjE2NWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:22:02 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEC4C4
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:22:00 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f6da07feb2so33938565e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685366518; x=1687958518;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zQPnGID00Brxksr1LEFVX3pOkofF35RoN55bi7pgARE=;
        b=gDWZdNkikMtW4jwWJdMwNzOTeQk4XvTMscX5BPzfte6VLW360lle6e8nAPlUk9g/o8
         xd8wZgiMFPhfztetNazQ8wsnZQFaI88+oW4POxwsz+1GQuVs/DmN/acHJycNy6r+Ps7f
         fF3/keTavialx5OmeiHTOF6Ui4Uf7eEq9tMAVBM8km/Sd8ZuwJ85Q97IBqXr6/x+sjbE
         S3pGNhIqb4ct/ZeUSH6toXAJnGCgK5x4qhD7ueiq8QiYUL0B20fbb4yYJ7ERWOT2A0Pn
         gYxOZK/+sK82Nno81ex8nMHW0dQtNdc+u/9T/T7/QTYrHhCVMclfHrp3J+MHeQdik3RB
         Sokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685366518; x=1687958518;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zQPnGID00Brxksr1LEFVX3pOkofF35RoN55bi7pgARE=;
        b=V6iAfGzIIxFgiKgvZk0nryuS0UvpWtYivJvGmGVx5RMjBKX7WIMC0t7r4lz6j3uzHs
         /HfGxIYGrtUb3v2tkDUJK4EauBaOLs28mQV9+zBLbAxHdNvlyXZrvmH3UqYCAw0n8BdO
         bmzMPGAJyVPmqMrqzOhXJMQmS5wojBfyHsuejqgOFJPj4QrpM4kHnMLAUhJLfbhFjtIb
         igSAuKNUsNfzcYOgL6slXKIWd6W1U4KsTN1mEawe/3m12/qrir89t716/TsfLc7f0itV
         fld57gcjzfpWFRivvqqP46k64S32jKFuj+ex5xTVpKFrf6CAGzo9/ROyIxKtHyVe1RaU
         jY1g==
X-Gm-Message-State: AC+VfDzcmEvpYn0WSK/kbGGIfk468/3sBkP5NdpFbIiX4MFBUIjokk60
        Vpemk6KIKtbR8ubORS+vVkfifQ==
X-Google-Smtp-Source: ACHHUZ7I186EtiGbOGB/RbLAQfHQJKOuhNb282Woas7dhrX98jASbnMChjEDiPUjYpdc2Fh5m03Dlw==
X-Received: by 2002:a7b:c01a:0:b0:3f6:11e9:de8e with SMTP id c26-20020a7bc01a000000b003f611e9de8emr8649611wmb.4.1685366518607;
        Mon, 29 May 2023 06:21:58 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c214700b003f4f89bc48dsm17990815wml.15.2023.05.29.06.21.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 06:21:58 -0700 (PDT)
Message-ID: <cf8f746f-93d2-8ddc-7e6d-6324322e46e4@linaro.org>
Date:   Mon, 29 May 2023 14:21:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/6] arm64: dts: qcom: msm8916/39: Rename &blsp1_uartN ->
 &blsp_uartN
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230525-msm8916-labels-v1-0-bec0f5fb46fb@gerhold.net>
 <20230525-msm8916-labels-v1-2-bec0f5fb46fb@gerhold.net>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230525-msm8916-labels-v1-2-bec0f5fb46fb@gerhold.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/2023 13:46, Stephan Gerhold wrote:
> For some reason the BLSP UART controllers have a label with a number
> behind blsp (&blsp1_uartN) while I2C/SPI are named without (&blsp_i2cN).
> This is confusing, especially for proper node ordering in board DTs.
> 
> Right now all board DTs are ordered as if the number behind blsp does
> not exist (&blsp_i2cN comes before &blsp1_uartN). Strictly speaking
> correct ordering would be the other way around ('1' comes before '_').
> 
> End this confusion by giving the UART controllers consistent labels.
> There is just one BLSP on MSM8916/39 so the number is redundant.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

