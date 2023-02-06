Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCB668C67D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 20:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjBFTMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 14:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjBFTMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 14:12:08 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EAB2B0AC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 11:12:05 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id o36so9422899wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 11:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z7TeXUZSUDSF6HYQKz6bhsTXkRAHdJ9pyS5ZC6tmFPI=;
        b=NgFUTRlQYbLYTeTRD3Of8qS5nSQO0qb3dJ1o8dKsyUFGdBMO1OxY2HZZ0w3wNnPT0n
         Bgk0rpi0vqTs47pPAjXLCthSv65D4CnAgr3ry6aejPYzTwJKkDX6qxYQDodu/WphR/nl
         2HuQwuVRMAg2cPEmPcaDgdQ3MzZXaWcuSebyalKpO1XictcReXjkNuFsO6k78OiAJ0zP
         td/N3aGqV4OarT5yCRattp/A8AvFVwM5GA4USh9ltvu2v1EWMjarpDmlwX840Y9/qxVM
         b1Dfu7Es8slXSthDPkdGSUNEtfvhOE62GgkfQ1CfseD9CyCxjS11t9Mw5QZKqaL1Hwt+
         B6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7TeXUZSUDSF6HYQKz6bhsTXkRAHdJ9pyS5ZC6tmFPI=;
        b=Ol3vTk+QeJk7TCsa3nd9Ck1VvoPZs5L1fVzEf0a5zgFxd4uLVXHjJjxGIQiNJgDne+
         64E+PyfLjy8Ov0cC2lHmKct5HZEc9wHWdV7Dk6uljWNhCGgQ+/lSupUF1KkOtFqy9Ew+
         cjcb1cBKqdlaWevadxWJXJK7i72PbenTVk187CQ/ytHGwVGAnYiYgFmVoEkqjJxng69j
         wphN1faFOzZBk2CQ3H3fqvQwX+7fOinftt9IBPUB3Y5VHs6XRINs4MSfGR1T+/2g4XVi
         K2qU3u6n3sNzpUy5ytHyE26Jo0mC8fe9+fp0+Zw74hwfM1JQZiFFfp9o8J8Nw1RbRLd+
         /cxQ==
X-Gm-Message-State: AO0yUKVyxeMI8e195ozZzJqXryYzbqx8co9pzGIlCKm4S2ITFJ4ZSTKv
        4x+hwDRGu/5TfklIfnmALWsMrA==
X-Google-Smtp-Source: AK7set8uZ5B2m9aXDXsHQl3JhF94bRUla/vOWPgrTbzuMopuJzj/areKdz860Av+Y/KvoolzxtJ7yg==
X-Received: by 2002:a05:600c:4484:b0:3de:b1ec:7f95 with SMTP id e4-20020a05600c448400b003deb1ec7f95mr690448wmo.18.1675710724147;
        Mon, 06 Feb 2023 11:12:04 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c4f8a00b003e0010a9f67sm4404639wmq.44.2023.02.06.11.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 11:12:03 -0800 (PST)
Message-ID: <7452928c-f134-8f11-a966-1f3bdc792cb8@linaro.org>
Date:   Mon, 6 Feb 2023 20:12:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 2/7] ASoC: dt-bindings: meson: convert axg tdm
 formatters to schema
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230206153449.596326-1-jbrunet@baylibre.com>
 <20230206153449.596326-3-jbrunet@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230206153449.596326-3-jbrunet@baylibre.com>
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

On 06/02/2023 16:34, Jerome Brunet wrote:
> Convert the DT binding documentation for the Amlogic tdm formatters to
> schema.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

