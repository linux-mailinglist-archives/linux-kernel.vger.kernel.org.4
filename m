Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036197042EB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 03:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjEPBbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 21:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEPBbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 21:31:49 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D25E76
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 18:31:47 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f24d4900bbso11924498e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 18:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684200706; x=1686792706;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OcXwAN+isoQ/mFzkihbW/wozjleZFihqA4ZCS2Bjuo4=;
        b=zKnXAmMfvexSrZm7W8TMgsPtCn5QEHM5aBJoXPKD4qrX72JMnv2T9AOFwf0aFc7K9C
         gSEauFpNJFoWR6hXeYqQVacHaOLQ4+tFoqQJIasrEvmRJQoWPfRlsJ6afyGsQ8XSPcK/
         /0UuoIlcekhAY6kKVnoQoOKTsJdVXPpcKQ4snBB6RZfk+rkgDKzK4Fga5rCSybB+8G0P
         TOIA+n+O39JO67Dpj5gqEUbMWxeOsFGnrat1jWpKTZiDC5n+LUgME8qDR2SZSuld/ouh
         pdTFhqNhErSuXg8yvjcalR2iKOLHNPQkaExdz6F5InCuETDVtqQt+082+N9hjT+YAD+H
         HyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684200706; x=1686792706;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OcXwAN+isoQ/mFzkihbW/wozjleZFihqA4ZCS2Bjuo4=;
        b=L3cTNzeqPRdCx3u8bsI8PjhjPYIFpo8x5t97kqufGvhHDRUQMV5yVv79ue2ElpEixO
         7mYo8yVka1J2YsdPuHbzu5i1CubrtKAaRHmQPhWze/V0A89Va/U14KSl3FX+fEoDc7Gp
         Ymtz0ak+X1wbz01/DGaaVnQeufjTPtKxkALmG2oW+9RjR35S5334mQwBRS+FS4Zmd+va
         TRhV/cMHbkX45u1l9Br+qbILYFEmLLojdn8Y49I294Y1wF1qvOfNwHqeyfPtJy8HueiF
         FHj3LbCY40Lj3FpKsivKlRMJ4w91cNYohhRqG2Ly4JFZjImJdL/VYFcI4kM3vTBTeqlA
         ataA==
X-Gm-Message-State: AC+VfDxipqGTHzQE7k6/2nFJcMj6QsSOgdwWeOarZXdbfIOq1KyxeZof
        YWkx+X0qjJuQNavRswqgBJKnTo0g9QW93ZwzoGI=
X-Google-Smtp-Source: ACHHUZ4yNX4QWy0thWooKiccgAyqi3lrT98efHiZrzU8iVjPCnQrM5Xx71XXDYz3DeXa5St6j6kQJg==
X-Received: by 2002:a19:550d:0:b0:4ec:a4b4:4731 with SMTP id n13-20020a19550d000000b004eca4b44731mr6949601lfe.68.1684200705829;
        Mon, 15 May 2023 18:31:45 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id b7-20020ac24107000000b004f253f6d4d0sm2813502lfi.223.2023.05.15.18.31.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 18:31:45 -0700 (PDT)
Message-ID: <de735250-5661-0011-0650-a925b528463b@linaro.org>
Date:   Tue, 16 May 2023 03:31:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RESEND PATCH] soundwire: qcom: drop unused struct qcom_swrm_ctrl
 members
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20230515132000.399745-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230515132000.399745-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.05.2023 15:20, Krzysztof Kozlowski wrote:
> Drop unused members from the driver state container: struct qcom_swrm_ctrl.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/soundwire/qcom.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index aad5942e5980..ab1098ec56e6 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -187,12 +187,9 @@ struct qcom_swrm_ctrl {
>  #endif
>  	struct completion broadcast;
>  	struct completion enumeration;
> -	struct work_struct slave_work;
>  	/* Port alloc/free lock */
>  	struct mutex port_lock;
>  	struct clk *hclk;
> -	u8 wr_cmd_id;
> -	u8 rd_cmd_id;
>  	int irq;
>  	unsigned int version;
>  	int wake_irq;
