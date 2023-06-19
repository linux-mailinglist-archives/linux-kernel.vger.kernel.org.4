Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B82734BB3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 08:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjFSGVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 02:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjFSGV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 02:21:27 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A5B10E
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 23:21:18 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-970028cfb6cso519964466b.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 23:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687155676; x=1689747676;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XCyRXi13d15locPh0YhgRlxibJEXWHIKmgD2226akmI=;
        b=RgxwUt7+gSg/BlHKxAzEhgqIh2aBIWg49ttnDchnnGCLPsOJHyLL2QeTEsgQNlv4yU
         ZQJUn9B54m4Df/FtZwy25yiGAyWGAvu1aW/whOJ/hWvPZm5VgPMBCW7XJSPcCfu+B3wi
         IkHo5HBZq23ta2hyS5+vI6fiO+sQYLvym83IKMsUzxBKTjQ0xDKj7GV1dIMrGBo1+R8C
         Rpo9mnShBYr+F2bqF6vARBLZdbxDYDJABO5YNGpyFYxF4FEn+o6a2+3YmVvlRsrZxHYz
         wfi+0mXR0smM7AR2XpMrb5Y1DfP5QY8YQsOruDG/M9aC0qo9mVw1ha4OymsayNV88oz/
         Kk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687155676; x=1689747676;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XCyRXi13d15locPh0YhgRlxibJEXWHIKmgD2226akmI=;
        b=U1EPPB73DqD7ypxGmECDCH6RtF/b0das9mEea5DSgPa5wO8UsoF3Ur1slA/ZCAw1BM
         S3lyywW38YA2j9PoiLtUPFE2dwNBqo5JbguXlCOUZVNZ4xDc1IBGfyu5Zg2w4XlrUeqj
         vU69LONhHtYX/Gcn0eJHaW1pWdg5NZGmhx5k7jIH1rrTEn76tUCgLVzEMz3nRNF3vFYz
         ta1im+1W3N4WTma/fmXWiJVcch15eggSmsNQ0oGnAL/ytlrPqM87HAmVU6luOWc/FmGy
         Yh95g3BJoKBL/56IXzx/WtHmflQSIrcGfhc13z5wNQa7wCg164HTADnXo09JU9qa8hQH
         8hsQ==
X-Gm-Message-State: AC+VfDwUC7+ucxLiPXalGOUkN7N1y0lcjWm6xA/K4V5ry4ZDM/ZmG1rL
        LI1nchxu/ZClKlpZUoeH2CpZbA==
X-Google-Smtp-Source: ACHHUZ6pJ9gBRmaoQa6XLm1cGGaP5iB2F8OjL2WeiUytTr/r2tPTGvceaK3m91xt6SNlQrtgYgPuTg==
X-Received: by 2002:a17:906:9749:b0:97d:2bdb:aa67 with SMTP id o9-20020a170906974900b0097d2bdbaa67mr9618810ejy.70.1687155676650;
        Sun, 18 Jun 2023 23:21:16 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id k9-20020a170906128900b00965ffb8407asm14090042ejb.87.2023.06.18.23.21.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jun 2023 23:21:16 -0700 (PDT)
Message-ID: <9c638204-7c42-cb43-e925-f0d0e3cc8eae@linaro.org>
Date:   Mon, 19 Jun 2023 08:21:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 4/4] ASoC: dt-bindings: Add tas2781 amplifier
Content-Language: en-US
To:     Shenghao Ding <13916275206@139.com>, broonie@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com
Cc:     kevin-lu@ti.com, shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, x1077012@ti.com, peeyush@ti.com,
        navada@ti.com, gentuser@gmail.com, Ryan_Chu@wistron.com,
        Sam_Wu@wistron.com, tiwai@suse.de
References: <20230618122819.23143-1-13916275206@139.com>
 <20230618122819.23143-4-13916275206@139.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230618122819.23143-4-13916275206@139.com>
Content-Type: text/plain; charset=UTF-8
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

On 18/06/2023 14:28, Shenghao Ding wrote:
> Create tas2781.yaml for tas2781 driver.
> 
> Signed-off-by: Shenghao Ding <13916275206@139.com>
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

