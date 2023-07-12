Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD64E7503DC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbjGLJui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbjGLJue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:50:34 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62D01711
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 02:50:28 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3110ab7110aso7318117f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 02:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689155427; x=1691747427;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SDLl7N6iOSv4y2UNRlUrhwDMQ6zi5QYkOLDM/VqBWRY=;
        b=w9d5GrFLFCoTstxsHOxlhqo/yha4f4p32y9TXodqZSSxwDujNRDl5umxgBzfoGdiSI
         yNC0iHAB4Xk4CAMQZo0z9ylUrvOAf4sw7UR8NHQPdKmpYSk3iKhN+ffjR3VJo3yfQd1d
         2qC73ay2slCOhXYPuwdgOz7GGhrdXBK4UBt9peU+pR1HwYSsiRG49zSPBtUb9be2vQYa
         N2+axpGwyrkDdrATsnaxJNN+I14W5Q42DxyYSdyDT/wgVvqs348MZuuAaFkwCn6g8wTc
         RDYOjGCRPF41ip7MLlJwv0yLMf1zDtATdc6HvFsVy/uq9sE+FCcnFm0DeXCTIixry7eh
         Wvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689155427; x=1691747427;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SDLl7N6iOSv4y2UNRlUrhwDMQ6zi5QYkOLDM/VqBWRY=;
        b=f2t8jApXCzbv0VNGIi8oQuTI48pkTXM5gq59+EuBCgznQ4tULjRae7RrLZakiM1QMl
         IO8+6LAFS3XKZNt7J+Icr4HqsAFzuk8LlbptpwyPrtq7D6euyyDIPwysbyKw/5Ia/wSW
         5mrD1mGf/DgZ/2qdCJO1q0F6231PBRaYiORb01sU3Iy1YI2zLBBtdTP7sXahMxuaczqm
         jDAYVPdr9WhgwS+mdoefXWOp6KHzpCpKsl4Twq6suYAkL1UofSd1k8fktOUBCOMc76ny
         /uBTE+JJqyAYvH20EwBk2JPG6wbpZ73PC11onmOABC/DdE827nlvWtQjMSkwjTXbtdUI
         JZAA==
X-Gm-Message-State: ABy/qLY5Mo4MocpigI2jvK2YG5n/eRJBMW6ow9iTdM1+hJScDvRVqOAF
        BP5w5jL2IwaAgqi0co33HraoPw==
X-Google-Smtp-Source: APBJJlGiavtnYkAOBeJMkeW+URsKlQtTYOUF8TITqpkgTcPLRi8xCUl4VRxsbeG91n1Qvbnds+IwTg==
X-Received: by 2002:adf:fe01:0:b0:315:ac1b:91e with SMTP id n1-20020adffe01000000b00315ac1b091emr1931523wrr.53.1689155427018;
        Wed, 12 Jul 2023 02:50:27 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id c3-20020a5d4f03000000b00311d8c2561bsm4554831wru.60.2023.07.12.02.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 02:50:26 -0700 (PDT)
Message-ID: <2abbae30-f92e-33e4-5509-8979129da665@linaro.org>
Date:   Wed, 12 Jul 2023 10:50:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] media: venus: Fix firmware path for sm8250
Content-Language: en-US
To:     Patrick Whewell <patrick.whewell@sightlineapplications.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        William Gray <william.gray@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230711185330.10106-1-patrick.whewell@sightlineapplications.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230711185330.10106-1-patrick.whewell@sightlineapplications.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2023 19:53, Patrick Whewell wrote:
> The firmware path for the sm8250 resources is incorrect. This fixes the
> path to address the firmware correctly.
> 
> Signed-off-by: Patrick Whewell <patrick.whewell@sightlineapplications.com>
> ---
>   drivers/media/platform/qcom/venus/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 2ae867cb4c48..348085f8fc9c 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -814,7 +814,7 @@ static const struct venus_resources sm8250_res = {
>   	.vmem_size = 0,
>   	.vmem_addr = 0,
>   	.dma_mask = 0xe0000000 - 1,
> -	.fwname = "qcom/vpu-1.0/venus.mdt",
> +	.fwname = "qcom/vpu-1.0/venus.mbn",
>   };
>   
>   static const struct freq_tbl sc7280_freq_table[] = {

Is the policy not to stick with .mdt for existing platforms but use .mbn 
for new platforms.

https://lore.kernel.org/all/CALAqxLU1gjTY95+phBt=WksyguZuKpNKa6aYaJTe0GeCAg6WrA@mail.gmail.com/T/

Its a symlink for me but, is it a symlink for everybody ?

root@linaro-gnome:~# ls /lib/firmware/qcom/vpu-1.0/ -l
lrwxrwxrwx 1 root root       9 Dec  2  2022 venus.mdt -> venus.mbn

---
bod
