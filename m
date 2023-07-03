Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA75E7455F0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 09:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjGCHYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 03:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjGCHYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 03:24:35 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E14CE60
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 00:24:30 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbc244d386so42542385e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 00:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688369068; x=1690961068;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KgMnJ8CKfBislhp1HG0z8FmS5BLcV5+cmaj4jvnhxWQ=;
        b=lKrkHVcsQngHENPpMshxYINgAv/o3G4zjF9clGaCwoFrRmttkUWr4CBrogdvxNzMS3
         VBP86BoCy3AKClMFDF9HKPnJtmGpdmiipRLgTXgdGNS4e85wXCTHXgQTmURXCy5fNf5m
         LxexEPRA7cwPlrcsXz+F1rXEQI1sP8laktduTFkvWEbrgg/jMuTHCuPebIqG1ozPUTdZ
         IUYsdmpolDS8JvoAktsNi9dCycog7boyCBWaDP3PYwLu4lolTKdY5ehvy7aTMVfkLHfK
         R07BeDK6M+Dv1Kr+KwncWpguMs+6Gv792dGNu4Jf1DKoHce2DPoWYH74hji1yCmqMA4W
         sEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688369068; x=1690961068;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KgMnJ8CKfBislhp1HG0z8FmS5BLcV5+cmaj4jvnhxWQ=;
        b=Veig5nly59NEFLPURP1eCvKwwVWYJGYU3OczAAMIwhEedXKNJQNNu3/81b2gDWTQjG
         5SlA+jFQNXNF33tIvjlHLzk0h5wtV/BE2S9t4XdYanLZGqPJK9zuP8W8/kgRl1p22/BW
         WCZvesMuUApQb25nJ0G8tzPIO/RYyyHtO891ppxlwcqjYA3GeCace/3TO7IizmXNQCtU
         TCZ9NTr1cElIqZ6cBv0Rv398Pg62rj8ffsMJphBGJ4dcwPL2imQIAMNiFo3neBFST4gl
         yNbbGfizZDNHQpp4lDFYYK6lLr4z7Iv25wPLdha+F3uvCI9N7FoAsJtEuFgbaneo1LBa
         pugA==
X-Gm-Message-State: ABy/qLbUToKoHV3TLLxasGK8pCCJ8QvWYalQCzyttzcm1hHPhFeaV3BG
        H1kect9/SrRIIoobYlWBWlBk2w==
X-Google-Smtp-Source: APBJJlErVoF0iApuPq86HVOvO0iLKPOR8uT2faeOcndYld3NEwBM2GZKbdz/+srhnFDYERI4fgA7tQ==
X-Received: by 2002:a5d:6349:0:b0:313:e48a:d173 with SMTP id b9-20020a5d6349000000b00313e48ad173mr6657516wrw.68.1688369068512;
        Mon, 03 Jul 2023 00:24:28 -0700 (PDT)
Received: from [192.168.7.21] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id u11-20020adfdd4b000000b003143765e207sm1899030wrm.49.2023.07.03.00.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 00:24:27 -0700 (PDT)
Message-ID: <65d78d07-be4f-8ea0-b322-353b5c23fcb0@linaro.org>
Date:   Mon, 3 Jul 2023 09:24:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v6 5/9] drm/meson: gate px_clk when setting rate
Content-Language: en-US
To:     George Stark <gnstark@sberdevices.ru>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Nicolas Belin <nbelin@baylibre.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org
References: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v6-0-fd2ac9845472@linaro.org>
 <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v6-5-fd2ac9845472@linaro.org>
 <c487ed03-0ab2-74fb-91bc-4a773bfdfc5b@sberdevices.ru>
Organization: Linaro Developer Services
In-Reply-To: <c487ed03-0ab2-74fb-91bc-4a773bfdfc5b@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2023 20:10, George Stark wrote:
> Hello Neil
> 
> On 6/30/23 19:29, Neil Armstrong wrote:
>> Disable the px_clk when setting the rate to recover a fully
>> configured and correctly reset VCLK clock tree after the rate
>> is set.
>>
>> Fixes: 77d9e1e6b846 ("drm/meson: add support for MIPI-DSI transceiver")
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/gpu/drm/meson/meson_dw_mipi_dsi.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c b/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c
>> index 57447abf1a29..dc63d2d813a9 100644
>> --- a/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c
>> +++ b/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c
>> @@ -94,6 +94,7 @@ static int dw_mipi_dsi_phy_init(void *priv_data)
>>           return ret;
>>       }
>> +    clk_disable_unprepare(mipi_dsi->px_clk);
>>       ret = clk_set_rate(mipi_dsi->px_clk, mipi_dsi->mode->clock * 1000);
>>       if (ret) {
>> @@ -102,6 +103,12 @@ static int dw_mipi_dsi_phy_init(void *priv_data)
>>           return ret;
>>       }
>> +    clk_prepare_enable(mipi_dsi->px_clk);
> probably should be:
> ret = clk_prepare_enable(mipi_dsi->px_clk);

Indeed, thx for noticing :-)

>> +    if (ret) {
>> +        dev_err(mipi_dsi->dev, "Failed to enable DSI Pixel clock (ret %d)\n", ret);
>> +        return ret;
>> +    }
>> +
>>       switch (mipi_dsi->dsi_device->format) {
>>       case MIPI_DSI_FMT_RGB888:
>>           dpi_data_format = DPI_COLOR_24BIT;
>>

