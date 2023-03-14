Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B917D6B9B86
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjCNQbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjCNQbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:31:43 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BAA52F43
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:31:35 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r11so12772198edd.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678811494;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Z20n8EovjQK6WWHRBaG09kppsRVXiyp2olQcDL0XJ8=;
        b=JK44/SsDXBuPDZzc56hUjt+1W7VutqTow1gDp4b7GRufbuYANwBW3zJWk/Fdr5oy1V
         5NvGdMpCt9KdMMZ0wXSMshyMmavoyRhfXn4dByC3Ra59ZWEliXiB8mN8v7xyWYoY+EKx
         9NbExJxy4XW5gsNpzG0e2gSwtq/3tG8E45K4EBifKcy720nyV6KKjD8tKWWC0RxYMvI4
         CZgvENMmgS4n83pA7Klyg+owq9LWy3TuivG7ClIC6BZPRDK/whWULBNFJTPomgpe6M8U
         PpRFx1/qm8hUiI8BU9FhfgfI7bFQIDM024dDiYyf9bSQQj+BqJ/PDrxtzbJWxOGY3L03
         zCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678811494;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Z20n8EovjQK6WWHRBaG09kppsRVXiyp2olQcDL0XJ8=;
        b=vaJTqGx/k/XBX2EZ1V+uFFgLjrv03fLqW4v44EMk9Kr7b3St/y7myzh+BBYUFZlUyq
         r+F9MpTST7UDL0MIgtMQf89bQ5/wHtWBX+MEW8iYR//JtcKP2zLy1b7I0UE6i3km8pz0
         ClQfKcc0IWLQJFH6pXYF7bJl8NYWN6WBQjQZ4Vqp3rXLvqdrA62dURM7hqo7pSd9rPED
         WLBb3iVVVrPzHRijoiXBnOZI7LHHhPYGJZzoJWeuVE27lgjR1epat/G44y8o1D376s8X
         q4WGP1566X6LQmtWNxiOlpc2RcJatvzvS8ETst0dqXe2bO4EJYKlCkL4ix+VOnvg4iKa
         m/bA==
X-Gm-Message-State: AO0yUKUCiLFDJJ3/Weo6+PZK1lC6myKL6qPAg5kLhEioL3zKLBgIN6ad
        2KzT/q5Nu8wom+UDaZN9V9m9WA==
X-Google-Smtp-Source: AK7set/vSQlRu82Czuk12ElmMiD/0af+VwTO3KMyjJOjl9VfNhfnYkq0M4g5zeFFPauB5KWKj9oZYg==
X-Received: by 2002:a17:907:31c1:b0:92d:6078:3878 with SMTP id xf1-20020a17090731c100b0092d60783878mr2427954ejb.33.1678811493961;
        Tue, 14 Mar 2023 09:31:33 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:59be:4b3f:994b:e78c? ([2a02:810d:15c0:828:59be:4b3f:994b:e78c])
        by smtp.gmail.com with ESMTPSA id 18-20020a508e12000000b004fa380a14e7sm1281024edw.77.2023.03.14.09.31.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 09:31:33 -0700 (PDT)
Message-ID: <5092a0b0-6a31-f984-e28c-ca11bafef6bb@linaro.org>
Date:   Tue, 14 Mar 2023 17:31:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 01/28] media: cec: ch7322: drop of_match_ptr for ID table
Content-Language: en-US
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Joe Tessler <jrt@google.com>,
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
 <4ee5e059-6e9f-0804-30ec-ff073f436780@xs4all.nl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4ee5e059-6e9f-0804-30ec-ff073f436780@xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2023 12:46, Hans Verkuil wrote:
> On 12/03/2023 14:12, Krzysztof Kozlowski wrote:
>> The driver can match only via the DT table so the table should be always
>> used and the of_match_ptr does not have any sense (this also allows ACPI
>> matching via PRP0001, even though it might not be relevant here).
>>
>>   drivers/media/cec/i2c/ch7322.c:583:34: error: ‘ch7322_of_match’ defined but not used [-Werror=unused-const-variable=]
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> 
> I assume you want to take this series, but if you prefer to have us do it, then
> just let me know.

I prefer if you to take it. Please grab it! :)

Best regards,
Krzysztof

