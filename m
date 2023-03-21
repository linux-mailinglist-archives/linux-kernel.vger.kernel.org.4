Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA21B6C2C4B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjCUI1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjCUI0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:26:46 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BB443458
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 01:26:33 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y4so56531269edo.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 01:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679387192;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0mTzuTr7Qws+cUrzbSI+C/8BpG+BCY4L1yCujqjQO80=;
        b=F0XMce0naaobBfyCQtabTxdjFlSDXtRsY59OVOruFSmpR9cvkfZ293h2nrTG5pheLb
         mjov15+plh04xZriyDiET4af/BfKT329TO0zZ4SaJ9WBsM6RqZczGF3VhRHnd+ZuO+oy
         gd0q56A62UfbLkchrVvemzOWkVE79g4EMJ5NoAUG4563Dcu4jB3ugwP5iSmX3KGkI9//
         NuEjyIQsXFxucDiGuD3faRv179z5sC1fFVnTfzU+HONr1V72R8uDwRyGkG4UuOYj9UZc
         WfHNAFeRmrZ/wnzOsH1VoKwOlBJAkNTN9ajSkqA/1FiYiAd2rYYHPPS9CqsbeXGUIpV5
         kFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679387192;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0mTzuTr7Qws+cUrzbSI+C/8BpG+BCY4L1yCujqjQO80=;
        b=ycfL6W951Osk9AKP8tsU0BOtVtJFTvBOdE5s/c3U11D0c+49cdh1Jo2P6OlsJIkiQW
         wBC0y3FnNNCEaIwCSPTFMjYzEtfmbJSJPSm6A0xbfO1JJ12uhDHMVsfBMzHgB53v/9Rb
         OYP8Z6qe3Y7SSHybprrAIQi3UaFjTSae6utgRQyMSTgIS8QGmJlujo+ugpxl6TncrlDa
         cY+3PlibcP4RLhf8VnSoPShmv6sA5BArY4cwAuEPKh5I7d2I8NOlJSgcQUCs65HKBGhH
         MhSoL4flZhCHvf5bdtaxnS02riOJAawq7qAIc8r11kZAy3wCWEsIhm2+lLz0Q0etJrgY
         E3SQ==
X-Gm-Message-State: AO0yUKUJvw5FZGZEvPnUj9/jw0Xpbkqb2/zeRL4Q58gjFCgnRW0ITiMq
        HXz+dBG1f/FRrUG1cucMizGSIQ==
X-Google-Smtp-Source: AK7set+Yo3j0orRg0yJ8E1/dJwlIJ3rt2gBjk8VtlpRwTZcxqtlBtQSIoTar3pcg+04BUhx1cgL4AA==
X-Received: by 2002:aa7:d315:0:b0:4ad:738b:6706 with SMTP id p21-20020aa7d315000000b004ad738b6706mr2495618edq.2.1679387192285;
        Tue, 21 Mar 2023 01:26:32 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:2142:d8da:5ae4:d817? ([2a02:810d:15c0:828:2142:d8da:5ae4:d817])
        by smtp.gmail.com with ESMTPSA id z67-20020a509e49000000b00501dac14d7asm534626ede.3.2023.03.21.01.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 01:26:31 -0700 (PDT)
Message-ID: <676cb6ac-84a3-025f-bb05-55dd27c365fe@linaro.org>
Date:   Tue, 21 Mar 2023 09:26:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 20/28] media: platform: jpeg: always reference OF data
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Joe Tessler <jrt@google.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Wenyou Yang <wenyou.yang@microchip.com>,
        Bin Liu <bin.liu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-rockchip@lists.infradead.org,
        oushixiong <oushixiong@kylinos.cn>
References: <20230312131318.351173-1-krzysztof.kozlowski@linaro.org>
 <20230312131318.351173-20-krzysztof.kozlowski@linaro.org>
 <86431868-488b-4a72-944b-231b6d0382b0@app.fastmail.com>
 <8b7816b0-1daa-1c49-6f9d-40769d228a39@linaro.org>
 <b9342459-efec-4e17-aee6-332ee17f44d2@app.fastmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b9342459-efec-4e17-aee6-332ee17f44d2@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2023 09:24, Arnd Bergmann wrote:
> On Tue, Mar 21, 2023, at 09:21, Krzysztof Kozlowski wrote:
>> On 21/03/2023 09:11, Arnd Bergmann wrote:
>>> On Sun, Mar 12, 2023, at 14:13, Krzysztof Kozlowski wrote:
>>>> The driver can match only via the DT table so the table should be always
>>>> used and the of_match_ptr does not have any sense (this also allows ACPI
>>>> matching via PRP0001, even though it might not be relevant here).  This
>>>> also fixes !CONFIG_OF error:
>>>>
>>>>   drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:1890:38: error: 
>>>> ‘mtk8195_jpegdec_drvdata’ defined but not used 
>>>> [-Werror=unused-const-variable=]
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> I see now that we both submitted the same patch, but now Hans
>>
>> We as you and me? I cannot find your patch on lore:
>> https://lore.kernel.org/all/?q=f%3Aarnd%40arndb.de
> 
> This is the one that I sent back in January:
> 
> https://lore.kernel.org/all/20230117172644.3044265-1-arnd@kernel.org

Uh, that's from January! It's still waiting in Patchwork:
https://patchwork.linuxtv.org/project/linux-media/patch/20230117172644.3044265-1-arnd@kernel.org/


Best regards,
Krzysztof

