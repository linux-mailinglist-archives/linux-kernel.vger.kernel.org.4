Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0213C727B88
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbjFHJfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236135AbjFHJey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:34:54 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1911730
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 02:34:53 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-30ae61354fbso269216f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 02:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1686216891; x=1688808891;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6orbtq17lQKjI9Icb5c6jZzUdG10XE40HYo5IhwyFNQ=;
        b=WrlC02M0T6mrZAv6GxmUy2UCBV9sf40gKGoNcw+gAKVsv+UVlMfBfPLqHGTgiUbUGA
         15Si5VnX3hMyAurhjup1Ff8JtS6/xS/zgwJ7AkOi//bMZ+Csu63ck6Uu80HkFVzMCPlq
         +mMi0PPRDhm2lzgAqfy47HkaqxRFnZk7cClWhBYDUANdyAdWU1oibYUQkw5+IgKyRh2g
         SitroCQ8lkHaw13o6uv/LW/hseTspMkBvei2ACbHKGFh9uKNsSklgUY4LDbRo2NSqctv
         SCBpxGRrBb56OSOrJGpKyEA+2YqMpw1JxQxHK79K97MkQ8YpobUgj4BNHSSnX9TCqtUH
         5Tng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686216891; x=1688808891;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6orbtq17lQKjI9Icb5c6jZzUdG10XE40HYo5IhwyFNQ=;
        b=UtCVibsiDpcY5/OaRT+M4SP2QmSBE+DJD1wwCTkQrUqnvOcTiIzeB5xozNHuQMuq/S
         adtj3Ld44YQwfe291N78h95guG3EjNGEUGqVgb5kDeAQiu3pRjw+9kdjXIettqApZrp1
         Geppiakec7/izXSbK1gW4iyr6FHArDN8rENiwgu2R1SKGOnl+kqb7faZ0mPlJPnRnTD0
         OxY+mKNKsd271tGhnjXVkt+6hGm44Xzuw6RrfJmR0iA3KDqGy2AUSfxTA7xHrhYrvzkW
         8pIla8dbR9HQBTHTZb/NmoLJah6G0f6bd8gronki9YXBkrz28bm6oKySQwMRAp6Yx4II
         7Meg==
X-Gm-Message-State: AC+VfDyTcsW3XOXQX076D6ez+umir138M6q+i+sxFmx1E8qlrQuqq6+W
        imuwXH3qNCHS1ZmnMxxsJeZeOA==
X-Google-Smtp-Source: ACHHUZ5UVQSczbkfardAghLYw8rGvYBCqD9G/YSIbOG+ijQ2ZPpGa/a32Zq9oHH2OrmLw0nLnbDPMA==
X-Received: by 2002:a5d:684e:0:b0:30e:5b63:7487 with SMTP id o14-20020a5d684e000000b0030e5b637487mr3188877wrw.58.1686216891475;
        Thu, 08 Jun 2023 02:34:51 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id bf3-20020a0560001cc300b003063a1cdaf2sm1025954wrb.48.2023.06.08.02.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 02:34:51 -0700 (PDT)
Message-ID: <578cc882-527f-5367-942a-d3d187786780@baylibre.com>
Date:   Thu, 8 Jun 2023 11:34:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/5] ASoC: mediatek: mt8188-mt6359: Clean up log levels
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        matthias.bgg@gmail.com, trevor.wu@mediatek.com,
        dan.carpenter@linaro.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20230608084727.74403-1-angelogioacchino.delregno@collabora.com>
 <20230608084727.74403-5-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230608084727.74403-5-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2023 10:47, AngeloGioacchino Del Regno wrote:
> Change some dev_info prints to dev_err() and some to dev_dbg(),
> depending on the actual severity of them.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre

