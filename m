Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D360729F36
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239209AbjFIPwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbjFIPwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:52:39 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E63C3588;
        Fri,  9 Jun 2023 08:52:38 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-30fa23e106bso495906f8f.3;
        Fri, 09 Jun 2023 08:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686325957; x=1688917957;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kjQv+AKpm2A2yuAsyilt/YShNfzL1O/WlL6C0kaj11c=;
        b=Mz9/q2Bz2kxvWcu9mpwFN19bHSabAwti/2J9jRHSp9h6oRXzqvMjEP4Iru7KuP9zzn
         8n43Fgh30mtQPCkybBtMULCToeqJlrbMlrCEi8pPvCbsrdVVzOF+knPUWPFy7hx8XEfz
         94Myx5a9g91HpSCQeSRBDlqdrrbKxd0fCkyOfP3YotYuLmX8443EpVyjeQnj2MrXmjZr
         52pa5HWsF08pyH4SdU4jaNsgNYDqmWbHPOkjC2oqArQWqjBm3RRznNdEIW6nJM/TxloP
         9LAv0EnSsD7UvjMW6Oilm1lqjxP5ln1FzgkzeuOyRE465zke3SM7S+H2OaIQCcmJUBPZ
         CniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686325957; x=1688917957;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kjQv+AKpm2A2yuAsyilt/YShNfzL1O/WlL6C0kaj11c=;
        b=a5WUCO/eAzJ6yX5EJPdA3IChyAoE7C0o/6+S8VOb5KUxAnL4o3k+01vZreJ2/A3wGm
         K3vgu+SWJe7Jh9W9v3D1/je1eOCIvfJIKNw58S+BmqbHV792h4C5Z5Ogcgafa/2Un1k5
         U/HYWKcXWFP2gKZSycq/JY5wvZ8dstZiC3EhcPaewOfGVHTCNIr0AQedd0hLkHrJkxDQ
         4pcoYqpQlx24KTfNrJZDQ6XF7VI8SvqB/MiEvL81wPSorDjf3lA7bcEU8qaxULGw8m17
         I2drwIMBC9UdiQDg/zUCdA/Gc3Nxz5jnCJm0s2/BIjgAgTAQgVtJRJH8vUL2GaFjICus
         L39w==
X-Gm-Message-State: AC+VfDy8IfBKkW79DM21dkdKrzpcVAhvJkEBvPM3sfUIT9p9r9WUa7UN
        azLyHc24wYOnjYlkuyAGRzM=
X-Google-Smtp-Source: ACHHUZ7zQlGBFYBKSby2rJSQtQXAyjtblUs/9IBWEtZL94NL7HTR5NhRWsb/bktjEUiWik5gZEW9lg==
X-Received: by 2002:adf:e0cb:0:b0:30a:d8df:6800 with SMTP id m11-20020adfe0cb000000b0030ad8df6800mr1179872wri.33.1686325956846;
        Fri, 09 Jun 2023 08:52:36 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id o7-20020adfeac7000000b002fed865c55esm4826686wrn.56.2023.06.09.08.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 08:52:35 -0700 (PDT)
Message-ID: <5fb4d78b-05a2-1a31-c1db-878c0a6d0380@gmail.com>
Date:   Fri, 9 Jun 2023 17:52:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 4/9] regulator: mt6358: Drop *_SSHUB regulators
Content-Language: en-US, ca-ES, es-ES
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230609083009.2822259-1-wenst@chromium.org>
 <20230609083009.2822259-5-wenst@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230609083009.2822259-5-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/06/2023 10:30, Chen-Yu Tsai wrote:
> The *_SSHUB regulators are actually alternate configuration interfaces
> for their non *_SSHUB counterparts. They are not separate regulator
> outputs. These registers are intended for the companion processor to
> use to configure the power rails while the main processor is sleeping.
> They are not intended for the main operating system to use.
> 
> Since they are not real outputs they shouldn't be modeled separately.
> Remove them. Luckily no device tree actually uses them.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/regulator/mt6358-regulator.c       | 14 --------------
>   include/linux/regulator/mt6358-regulator.h |  4 ----
>   2 files changed, 18 deletions(-)
> 
> diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6358-regulator.c
> index faf6b0757019..946a251a8b3a 100644
> --- a/drivers/regulator/mt6358-regulator.c
> +++ b/drivers/regulator/mt6358-regulator.c
> @@ -505,9 +505,6 @@ static struct mt6358_regulator_info mt6358_regulators[] = {
>   	MT6358_BUCK("buck_vcore", VCORE, 500000, 1293750, 6250,
>   		    buck_volt_range1, 0x7f, MT6358_BUCK_VCORE_DBG0, 0x7f,
>   		    MT6358_VCORE_VGPU_ANA_CON0, 1),
> -	MT6358_BUCK("buck_vcore_sshub", VCORE_SSHUB, 500000, 1293750, 6250,
> -		    buck_volt_range1, 0x7f, MT6358_BUCK_VCORE_SSHUB_ELR0, 0x7f,
> -		    MT6358_VCORE_VGPU_ANA_CON0, 1),
>   	MT6358_BUCK("buck_vpa", VPA, 500000, 3650000, 50000,
>   		    buck_volt_range3, 0x3f, MT6358_BUCK_VPA_DBG0, 0x3f,
>   		    MT6358_VPA_ANA_CON0, 3),
> @@ -583,10 +580,6 @@ static struct mt6358_regulator_info mt6358_regulators[] = {
>   	MT6358_LDO1("ldo_vsram_others", VSRAM_OTHERS, 500000, 1293750, 6250,
>   		    buck_volt_range1, MT6358_LDO_VSRAM_OTHERS_DBG0, 0x7f00,
>   		    MT6358_LDO_VSRAM_CON2, 0x7f),
> -	MT6358_LDO1("ldo_vsram_others_sshub", VSRAM_OTHERS_SSHUB, 500000,
> -		    1293750, 6250, buck_volt_range1,
> -		    MT6358_LDO_VSRAM_OTHERS_SSHUB_CON1, 0x7f,
> -		    MT6358_LDO_VSRAM_OTHERS_SSHUB_CON1, 0x7f),
>   	MT6358_LDO1("ldo_vsram_gpu", VSRAM_GPU, 500000, 1293750, 6250,
>   		    buck_volt_range1, MT6358_LDO_VSRAM_GPU_DBG0, 0x7f00,
>   		    MT6358_LDO_VSRAM_CON3, 0x7f),
> @@ -603,9 +596,6 @@ static struct mt6358_regulator_info mt6366_regulators[] = {
>   	MT6366_BUCK("buck_vcore", VCORE, 500000, 1293750, 6250,
>   		    buck_volt_range1, 0x7f, MT6358_BUCK_VCORE_DBG0, 0x7f,
>   		    MT6358_VCORE_VGPU_ANA_CON0, 1),
> -	MT6366_BUCK("buck_vcore_sshub", VCORE_SSHUB, 500000, 1293750, 6250,
> -		    buck_volt_range1, 0x7f, MT6358_BUCK_VCORE_SSHUB_ELR0, 0x7f,
> -		    MT6358_VCORE_VGPU_ANA_CON0, 1),
>   	MT6366_BUCK("buck_vpa", VPA, 500000, 3650000, 50000,
>   		    buck_volt_range3, 0x3f, MT6358_BUCK_VPA_DBG0, 0x3f,
>   		    MT6358_VPA_ANA_CON0, 3),
> @@ -670,10 +660,6 @@ static struct mt6358_regulator_info mt6366_regulators[] = {
>   	MT6366_LDO1("ldo_vsram_others", VSRAM_OTHERS, 500000, 1293750, 6250,
>   		    buck_volt_range1, MT6358_LDO_VSRAM_OTHERS_DBG0, 0x7f00,
>   		    MT6358_LDO_VSRAM_CON2, 0x7f),
> -	MT6366_LDO1("ldo_vsram_others_sshub", VSRAM_OTHERS_SSHUB, 500000,
> -		    1293750, 6250, buck_volt_range1,
> -		    MT6358_LDO_VSRAM_OTHERS_SSHUB_CON1, 0x7f,
> -		    MT6358_LDO_VSRAM_OTHERS_SSHUB_CON1, 0x7f),
>   	MT6366_LDO1("ldo_vsram_gpu", VSRAM_GPU, 500000, 1293750, 6250,
>   		    buck_volt_range1, MT6358_LDO_VSRAM_GPU_DBG0, 0x7f00,
>   		    MT6358_LDO_VSRAM_CON3, 0x7f),
> diff --git a/include/linux/regulator/mt6358-regulator.h b/include/linux/regulator/mt6358-regulator.h
> index a4307cd9edd6..c71a6a9fce7a 100644
> --- a/include/linux/regulator/mt6358-regulator.h
> +++ b/include/linux/regulator/mt6358-regulator.h
> @@ -47,8 +47,6 @@ enum {
>   	MT6358_ID_VLDO28,
>   	MT6358_ID_VAUD28,
>   	MT6358_ID_VSIM2,
> -	MT6358_ID_VCORE_SSHUB,
> -	MT6358_ID_VSRAM_OTHERS_SSHUB,
>   	MT6358_ID_RG_MAX,
>   };
>   
> @@ -88,8 +86,6 @@ enum {
>   	MT6366_ID_VMC,
>   	MT6366_ID_VAUD28,
>   	MT6366_ID_VSIM2,
> -	MT6366_ID_VCORE_SSHUB,
> -	MT6366_ID_VSRAM_OTHERS_SSHUB,
>   	MT6366_ID_RG_MAX,
>   };
>   
