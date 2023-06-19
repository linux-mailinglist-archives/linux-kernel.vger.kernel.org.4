Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791D7735948
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 16:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbjFSOOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 10:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjFSON5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:13:57 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F794E7D
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:13:51 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51a20c744ebso4164962a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687184029; x=1689776029;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jVJ0BYxgwjT3FqtgMQASJ1B7HEopYnAjVGB5hh3e82E=;
        b=M9z4P28nrWagW+IjU4/HCdHHlcaQEqWX7EhrBPn1H9FU9ONO2pp1EL7jsnMEg7I4ll
         8xceJ4/OUlji0kH8mkofXiti0XNSLOkB+0Wf65ZU6tfTxko/+anKk/1IzQtfC9nnhqSn
         v0saRZq6uSUhQLNS5JT3kdhnjZ1/DyphBy0cqE3yW2OKeZHjRnC6OjUVX+4oCtNaiyT0
         nEvPBH35+Sk+tWFKYpqAJs0dpnJouPKSb3L5KOAJ2FDdXEY0jtAzK+tNFs328b615JL0
         /6vKlg8BGmt4r1XepjO9UvUPwEkZC6srmp/+i8Iy9RuuagsWQKejiIk0zVJtpTdvqsaa
         zNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687184029; x=1689776029;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jVJ0BYxgwjT3FqtgMQASJ1B7HEopYnAjVGB5hh3e82E=;
        b=iR30NvplWOC2OMZS1Lp3CTs3L98UxQSkvxLsOJPXZyznhMhwXqy7VPdpykK4gFdAGB
         S5cRPk7NkDrBfvrAcpZesK8iEG3yKG73W7SlxQoTqTDWFPwddUr75UKf2vi7YYphf45B
         nKCMrFH99lahBCdaFehCkHWvB38lF0LqCy42DUKuS+G8mxbiGHe6ebCbOPwxGxg70h08
         3DhV9VHbBwT7Loo6NmGizP1+m/KdMFmJaEERel9z0RoFob/cby+l73oHgvZ7jmBvmw3f
         v4V+UwI66Se+q9zMPRVDjFv7+3vAMBgKFW/d4BCUpFlTt/GrseRWJ/2XV1tFfFyw5zSa
         8bmw==
X-Gm-Message-State: AC+VfDxZdpAMH7vV0nudhsg3u7jiSx72CEthGusmYJDrddUJBR8uVSMT
        6YvVQAWTztXaqqAR5xWmGIefOg==
X-Google-Smtp-Source: ACHHUZ7O2sSAG3s4Vml5tVOvx0rnJQoDa5gdvDzwpYu+SWO687o/I76se/9w1hJ7dH9KrjVmuODOeQ==
X-Received: by 2002:a05:6402:164c:b0:51a:4452:ae0c with SMTP id s12-20020a056402164c00b0051a4452ae0cmr4540560edx.35.1687184029619;
        Mon, 19 Jun 2023 07:13:49 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id p4-20020a05640210c400b005158563be4asm13096759edu.33.2023.06.19.07.13.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 07:13:49 -0700 (PDT)
Message-ID: <158425ec-86e8-ca3e-eed8-e14b37c42730@linaro.org>
Date:   Mon, 19 Jun 2023 16:13:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 01/28] media: cec: ch7322: drop of_match_ptr for ID table
To:     Sakari Ailus <sakari.ailus@iki.fi>,
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
 <98a77653-ec58-56c4-9893-3b424f67c87e@linaro.org>
 <5afcec8b-b8f6-35b0-278a-5de185e4a7a2@xs4all.nl>
 <ZG9XJCD98VWjGjTN@valkosipuli.retiisi.eu>
 <ZG9ger4WE2VWoVEF@valkosipuli.retiisi.eu>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZG9ger4WE2VWoVEF@valkosipuli.retiisi.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/2023 15:19, Sakari Ailus wrote:
> Hi folks,
> 
> On Thu, May 25, 2023 at 03:40:04PM +0300, Sakari Ailus wrote:
>> Hi Hans,
>>
>> On Sat, May 13, 2023 at 11:57:33AM +0200, Hans Verkuil wrote:
>>> On 12/05/2023 18:35, Krzysztof Kozlowski wrote:
>>>> On 12/03/2023 14:12, Krzysztof Kozlowski wrote:
>>>>> The driver can match only via the DT table so the table should be always
>>>>> used and the of_match_ptr does not have any sense (this also allows ACPI
>>>>> matching via PRP0001, even though it might not be relevant here).
>>>>>
>>>>>   drivers/media/cec/i2c/ch7322.c:583:34: error: ‘ch7322_of_match’ defined but not used [-Werror=unused-const-variable=]
>>>>>
>>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>> ---
>>>>
>>>> Hans, Sakari,
>>>>
>>>> Can you pick up the patchset? There was positive feedback:
>>>> https://patchwork.linuxtv.org/project/linux-media/patch/20230312131318.351173-1-krzysztof.kozlowski@linaro.org/
>>>>
>>>> but it seems it was not applied.
>>>
>>> I see it is delegated to Sakari in patchwork and marked Under Review, but I don't
>>> see a corresponding pull request for this series.
>>>
>>> Sakari, did something go wrong?
>>
>> I spotted this as Hans notified me in IRC, I wasn't cc'd. Apologies for
>> this --- I intended to take these but I think I must have missed something
>> important in the process. I'll take them now.
>>
>> Thanks.
> 
> This no longer applied cleanly. Mostly there was fuzz near .of_match_table
> changes as probe_new (and remove_new?) changes have been recently merged.
> There were other issues as well, I marked a few patches in the set "not
> applicable" as other patches had already done equivalent changes earlier.
> 
> There were substance-changing changes in the 20th patch, replied to the
> disuccsion there.
> 
> I've pushed the result here and intend to send PR to Mauro soon if there
> are no issues:
> 
> <URL:https://git.linuxtv.org/sailus/media_tree.git/log/?h=of-match-ptr>

One month later, I still don't see this set in the linux-next.  What's
happening here?

Best regards,
Krzysztof

