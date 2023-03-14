Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D3E6B9C03
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjCNQp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjCNQpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:45:55 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80565AB8B9;
        Tue, 14 Mar 2023 09:45:46 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id bp11so3539909ilb.3;
        Tue, 14 Mar 2023 09:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678812346;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=jlTXumnsAyLju3X5wGhezp0gUrPj0Pftji9EY7hYkTE=;
        b=IMbOhb4nSM3i5CqrZuMYQyk4mi0FlTaUhqJ10ufd3Zycg2LInMrGQEru5ClVhMfZiY
         MBTA8wkxYs3c2KYTMoxKnrJ5Kdaoet53INo+0KJbWWMYRADfafbmB+FTNxreih/UUxFP
         sljADlzOvgFOuWq2vKJgWRE6/WfqMDh3/2rgEloxv7hXosmfx0f7oG5pDnBP+HE83aF/
         7QL1yXV2X8K2JtjI8IdwWJtckGXIUdEMPXKHAnfeJSzVfdVsGJdrKJ3b056R+slPWYAZ
         ZiycbkXMVD6nIUVxupHIdiUR4K+B4czNcaiRn6zXjSxrW1ZoSF2r8ENe7PRUrZDJB9Ih
         j9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678812346;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jlTXumnsAyLju3X5wGhezp0gUrPj0Pftji9EY7hYkTE=;
        b=Ms5boDSCwS8BxBBDSNCNolbEZUK+sNAY0vPphoB0T/3l2q61NQCGpyTyX3DrI28Ni8
         IY++0Wtrr/4NOFjBYxKVAUHaw+OX19MZEXx4ZB/uY/Qgkgik6gmn20WEKLKUJzep/cTH
         wUT1rXs+iFJJr7jmEpQyRm4LhGszk+PBy2rQfBzCdGyeH3GGN9IkufdGYt2IfzgBfnEK
         fgsrDW3diNWMGPIP3pDYNgGHoObwRlW3Orx0y4VxCHCWu+b0eE7uBz5iF0bCAIuBuBo3
         XMtXJS/rMA2lQPzNKHpZAhFAY4uo08LcvZBXPd0cSXQw8KlzsZRaG91lArGmWu21NQxH
         ObtA==
X-Gm-Message-State: AO0yUKX9/2r5QeEEfP2Th/ZvlYAzRwcU0RMD/4j+V5f+CdTudsls8HCe
        ycZI0XOzZukN8lL27+uZxhc=
X-Google-Smtp-Source: AK7set9fbVlYa4wCf6eJNIaNXA3YZoUWFsU4AD/JnVhm0i9hauk9yIMD83SJ3S82/ISaFKioIftPGQ==
X-Received: by 2002:a05:6e02:60e:b0:318:aa8a:6455 with SMTP id t14-20020a056e02060e00b00318aa8a6455mr2655484ils.19.1678812345622;
        Tue, 14 Mar 2023 09:45:45 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c22-20020a02c9d6000000b0040380d7c768sm903996jap.106.2023.03.14.09.45.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 09:45:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4a4e0ef5-30f8-39ce-28cf-ade2122e2aa2@roeck-us.net>
Date:   Tue, 14 Mar 2023 09:45:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 01/28] media: cec: ch7322: drop of_match_ptr for ID table
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Joe Tessler <jrt@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
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
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-rockchip@lists.infradead.org
References: <20230312131318.351173-1-krzysztof.kozlowski@linaro.org>
 <b83d6b81-c4ec-4fb8-b626-84af80d1c4a3@roeck-us.net>
 <74ae8afe-c537-1714-77ec-8a80d8ddad69@xs4all.nl>
 <bafa692c-f3a3-d317-278d-2dd3b5ff8af3@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <bafa692c-f3a3-d317-278d-2dd3b5ff8af3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/23 09:32, Krzysztof Kozlowski wrote:
> On 14/03/2023 09:34, Hans Verkuil wrote:
>> On 13/03/2023 23:01, Guenter Roeck wrote:
>>> On Sun, Mar 12, 2023 at 02:12:51PM +0100, Krzysztof Kozlowski wrote:
>>>> The driver can match only via the DT table so the table should be always
>>>> used and the of_match_ptr does not have any sense (this also allows ACPI
>>>> matching via PRP0001, even though it might not be relevant here).
>>>>
>>>>    drivers/media/cec/i2c/ch7322.c:583:34: error: ‘ch7322_of_match’ defined but not used [-Werror=unused-const-variable=]
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>>
>>> FWIW: There is also
>>> https://patches.linaro.org/project/linux-media/patch/20230215214724.3798917-1-linux@roeck-us.net/
>>
>> I superseded that patch in patchwork in favor of this patch since this is part of
>> a larger series.
> 
> I am personally fan of FIFO, so Guenter's patch should go in.
> 

FWIW, I do not care either way, I just wanted to point out that this patch
_is_ both relevant and needed, and that it (or, rather, the original version)
has been reviewed and tested.

Thanks,
Guenter

