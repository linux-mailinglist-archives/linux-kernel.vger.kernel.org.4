Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B2B738BB5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjFUQkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbjFUQjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:39:55 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25A51BCA
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:39:30 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-987c932883bso739803166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687365568; x=1689957568;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5y48c1wpF6+Mt2hNg3vBn4NH1hPD+Xn2/odxxkX/bS4=;
        b=myEgp1LtAS76zbgSyQbj/EadEI1S6v7AhAdFppSTkzQGol8cFF9Yi6WqvHyFsnqAMb
         2+9/TDpSREMD1KYMvTj1wI1VxSm1AByydiU0Qwet03iktVYztjke1sdQetFeB8y0C0Zl
         6kk/0ozUP8KHYofh0hKQiOMwSJcX9K3cRA7cuPZEModdREvksBMTtwh1UVi37y184BCM
         ubcWgWBrkbS6AuBd1EfFKuv91UGp5rSLXGfWpPtTXGhF75ArGbj4E2Om5oYznBeQ5+vd
         95d2z9Qn3Go2TBqk/eFY91f2nRrdIw/tPZs2Qw1FAIquFDF+CjVCfFAPvsp5hxPTXhhj
         Ieyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687365568; x=1689957568;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5y48c1wpF6+Mt2hNg3vBn4NH1hPD+Xn2/odxxkX/bS4=;
        b=A+bdjqF+IlOqYwhoLnX3pgUhOIo1+/zwWqEtgsSO2PXncyJmWP1MItEBxyV8LsX1g0
         N5wTDbLue2dWPgX7cI1my2NsZ5cC5CiPNuVTs9DYKe/HCq/BI51ZMug187oUxYWPyV6m
         ubNpb8uU25h+PL+Cm3ZTo9YVS5/NLbc7nIBGotkqQPMWZRhYImjG87FNope+GwvagMPu
         NCMkL7iNBGSRGnmPnEFAWAjKSbo+5y1l5zrXwbNphg0jnBdSfqlvQvR9oloUNz5g5rBV
         WKUsOKjnVSPZUeT/jjUfMnKFgHSdSF1nGmmbgnuvY6tUWS1KutQqDqvtstmNxd+J7QY5
         httQ==
X-Gm-Message-State: AC+VfDxpNnDBe2kn5kYIK//W+g/dq5cWoI8MJJA+7iptHfTNDSrxWfJ7
        QSgSjFWxibNxqnG4YCqivuSZJg==
X-Google-Smtp-Source: ACHHUZ6qpdEWlOv74pmH4mmnpmMJfoU5Nu2hjjfpNN7zraQ14UmDv0ENsrB8eBMs/eimeAmgY/1XwA==
X-Received: by 2002:a17:907:7ba4:b0:977:ecff:3367 with SMTP id ne36-20020a1709077ba400b00977ecff3367mr16818253ejc.40.1687365568223;
        Wed, 21 Jun 2023 09:39:28 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id g4-20020a17090670c400b00988aff89806sm3473027ejk.14.2023.06.21.09.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 09:39:27 -0700 (PDT)
Message-ID: <aa5c6184-4b64-4dfb-4d3c-93d44cbfd11e@linaro.org>
Date:   Wed, 21 Jun 2023 18:39:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/3] power: supply: Introduce MM8013 fuel gauge driver
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230621-topic-mm8013-v1-0-4407c6260053@linaro.org>
 <20230621-topic-mm8013-v1-3-4407c6260053@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230621-topic-mm8013-v1-3-4407c6260053@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/2023 17:39, Konrad Dybcio wrote:
> Add a driver for the Mitsumi MM8013 fuel gauge. The driver is a vastly
> cleaned up and improved version of the one that shipped in some obscure
> Lenovo downstream kernel [1], with some register definitions borrowed from
> ChromeOS EC platform code [2].
> 

...

> +
> +static struct i2c_driver mm8013_i2c_driver = {
> +	.probe = mm8013_probe,
> +	.id_table = mm8013_id_table,
> +	.driver = {
> +		.name = "mm8013",
> +		.owner = THIS_MODULE,

Drop owner.

Best regards,
Krzysztof

