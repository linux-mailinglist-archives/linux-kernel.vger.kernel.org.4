Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922D96DBFF9
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 15:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjDINZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 09:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDINZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 09:25:10 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0AD272D
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 06:25:06 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id sh8so6871762ejc.10
        for <linux-kernel@vger.kernel.org>; Sun, 09 Apr 2023 06:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681046704; x=1683638704;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xWwDobpzqGH4vAFVJ50KnVPqjpTUbnMnTFVjovf89kY=;
        b=jsh5LOSfYt2GhCgO/LMCQGuuUlzqPOvswUhF0nM2Uei1IAbYcFKbOaXYh9j6jW4KZo
         suaGk7jLlmuemiUgcupslCSEkoHNIXvV0yh8i/Vq3vrVCInTxb9Mye8518VDZDq/ICRp
         zwCUSrcji2/ySvs8E7ESIfCRK2ARHS4LGQm4MlBgNUmmAHJu6CKOdUDm7Q1+bYemfclM
         Rjtrw1O8x9A2yr1j0iIOjODuBnS421MCbraqS1O9ukyoLNfTtht8eiXqd/79WWazsDsm
         UsRPdCcLxc06h/wTEQD07AsC9NKXNy+O+WxI/IYQrivglI5C0YruMuF6Cd3+FNUNsm/q
         fW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681046704; x=1683638704;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xWwDobpzqGH4vAFVJ50KnVPqjpTUbnMnTFVjovf89kY=;
        b=uNajTjzARKWqk/WMbp6MDAquKvMOb7zG+ZOmi6677p1/FTRcASw85mQMGdzfLSDf/B
         4Epk24qfwV1Vfos2u6+XuW0vb2DNa8aUwdbxYmcE0TpZreXw3frlxQf1LiX4u6v4BghA
         5o2bnM4mqBCULwCN1q5BCOSvmOtcoeGotec4DgFySjg5naicr3w3c8h4zULhW2L3e3Hu
         u+a/h0IdJ3F/8C+AgPRFLnZeazggtS9+momprtRhRwtS9H4APHpby7cACBU8QXoZyqDP
         HVna96S9eue01Voc6pkT5SINFP5CVs+dvAhBgGfUKQxuJTAWOJLUkKigdGVNpsRiLLN4
         lc3g==
X-Gm-Message-State: AAQBX9c8PbXAxfmpmwVN/oP3Ll8jQZTLVirxAB6EntjqlHuxoY2GooFG
        VRcHpUbyyFjSzGMG2aGiPMc=
X-Google-Smtp-Source: AKy350Zit8gKDotocwUs8rxr0mgfHh+mU8MfttC7/Jirk1JoXsnxEwsEkVm+91IaXjdTITZDvZdpHw==
X-Received: by 2002:a17:907:da7:b0:932:c1e2:9984 with SMTP id go39-20020a1709070da700b00932c1e29984mr6385265ejc.58.1681046704468;
        Sun, 09 Apr 2023 06:25:04 -0700 (PDT)
Received: from [192.168.171.122] ([46.211.100.81])
        by smtp.gmail.com with ESMTPSA id hv11-20020a17090760cb00b00946be16f725sm4120609ejc.153.2023.04.09.06.25.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Apr 2023 06:25:04 -0700 (PDT)
Message-ID: <cfcd6736-f822-fdda-a84d-4f4bb91cd653@gmail.com>
Date:   Sun, 9 Apr 2023 16:25:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] regulator: sm5703: Fix missing n_voltages for fixed
 regulators
Content-Language: en-US
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
References: <20230409025529.241699-1-axel.lin@ingics.com>
From:   Markuss Broks <markuss.broks@gmail.com>
In-Reply-To: <20230409025529.241699-1-axel.lin@ingics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good.

Reviewed-by: Markuss Broks <markuss.broks@gmail.com>

On 4/9/23 05:55, Axel Lin wrote:
> Set n_voltages = 1 for fixed regulators.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>   drivers/regulator/sm5703-regulator.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/regulator/sm5703-regulator.c b/drivers/regulator/sm5703-regulator.c
> index 38e66df378a5..702461cf075e 100644
> --- a/drivers/regulator/sm5703-regulator.c
> +++ b/drivers/regulator/sm5703-regulator.c
> @@ -42,6 +42,7 @@ static const int sm5703_buck_voltagemap[] = {
>   		.type = REGULATOR_VOLTAGE,				\
>   		.id = SM5703_USBLDO ## _id,				\
>   		.ops = &sm5703_regulator_ops_fixed,			\
> +		.n_voltages = 1,					\
>   		.fixed_uV = SM5703_USBLDO_MICROVOLT,			\
>   		.enable_reg = SM5703_REG_USBLDO12,			\
>   		.enable_mask = SM5703_REG_EN_USBLDO ##_id,		\
> @@ -56,6 +57,7 @@ static const int sm5703_buck_voltagemap[] = {
>   		.type = REGULATOR_VOLTAGE,				\
>   		.id = SM5703_VBUS,					\
>   		.ops = &sm5703_regulator_ops_fixed,			\
> +		.n_voltages = 1,					\
>   		.fixed_uV = SM5703_VBUS_MICROVOLT,			\
>   		.enable_reg = SM5703_REG_CNTL,				\
>   		.enable_mask = SM5703_OPERATION_MODE_MASK,		\
