Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CED16B055E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjCHLFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjCHLEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:04:55 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C9FB9535
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 03:04:23 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id b13so16172398ljf.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 03:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678273461;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8VV/rTwRnKU6UEDzet7JK45QLgODlSkCmiX3BH1I/DM=;
        b=HQOU5vTycAVVSRYho/hu0pGY10vRB6gem4HEXKnxf+e6Kio8lh9290+DjmqanEo/uR
         SUTVd0ixFCjUXhTI20G0c1OSsRFE7mlHOfggVuhtY/EzovMdj+jiTql//MUHgNnK/RSN
         6++wErjIBKvMsB12VTgOlvoFOOC4mlQuCFexib4jJ50fFEE/Uh10luiQ/wVoV/oOHwrI
         HgZSDpJYAJm6v9ySVAaz76eohfO4qADYgjPuA7zww4CQDB/QbKjeP0d2bQS9s/OFcMv/
         8WRdwNGoiP+q5MFW5HQ8IlSZE8dRZg+nwW7hmz1G+HX7XAbgWu/VXw05s6AXM5LMhvJc
         3cyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678273461;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8VV/rTwRnKU6UEDzet7JK45QLgODlSkCmiX3BH1I/DM=;
        b=dWnfma53Bbi4B44mG9oZD334YFuUvwczvgFkPpnQeLJt7Nlqi/DMDX5yInE/RdY7fg
         B7Km1wOVwHoq/uDbLRQyjuXFT1Dgv0NPEcFwU6cqZtAbKUB3it97axQ81VxWv0bLoeXu
         s45yd1YcE6O9alSSZIW4WSkcOR3Y4CwbK+Ysip/IET2pX6VrtFGT8Lw8CTUpJRJjc3Eq
         Lwcxi5dju5KAZiWAPudJDtzARZk5qHaLWKU6148QiybmvrNilv93x623vjGOH56aSv2e
         D5PcTmvaqVwDCTaD85lyRCgfYAr9zncAaEtsa+Xf0XXlLOp+ZWpZ/vgCZx8oViidwDaU
         b1bw==
X-Gm-Message-State: AO0yUKVg4wIgnO/dkzf+dg+VURNMIHe8obl9kfGGQok7T8KWo+0fEtnK
        kv8N1cR2A6HbmNSxLhC1G+UqQA==
X-Google-Smtp-Source: AK7set8sOg8LE4msTJbUjDfsJsqcsmqcDij63xRlHars6UR3HN5ROaMU5DoLkueW01X5wuMKUb1Q9Q==
X-Received: by 2002:a2e:3002:0:b0:295:a8fa:c627 with SMTP id w2-20020a2e3002000000b00295a8fac627mr5389644ljw.14.1678273461605;
        Wed, 08 Mar 2023 03:04:21 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id k19-20020a2e8893000000b002934fe524d2sm2527508lji.83.2023.03.08.03.04.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 03:04:21 -0800 (PST)
Message-ID: <dff4732c-df1f-0df8-b414-b039ab34c54b@linaro.org>
Date:   Wed, 8 Mar 2023 12:04:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 2/2] drm/panel: Add driver for Novatek NT36523
Content-Language: en-US
To:     Jianhua Lu <lujianhua000@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230220121258.10727-1-lujianhua000@gmail.com>
 <20230220121258.10727-2-lujianhua000@gmail.com>
 <CACRpkdbZCZiMM_qeqMd9=txVvPVHEzM4szOnPR-gCYdiXW_9eA@mail.gmail.com>
 <ZAfasb9aKTgyjbFc@Gentoo>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZAfasb9aKTgyjbFc@Gentoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8.03.2023 01:45, Jianhua Lu wrote:
> On Tue, Mar 07, 2023 at 11:34:55PM +0100, Linus Walleij wrote:
>> Hi Jianhua,
>>
>> thanks for your patch!
>>
>> It appears Konrad is working on a very similar driver, so I suggest merging
>> them into one Novatek NT36523 driver.
>>
>> Possibly we can fix this up first and then add Konrads Lenovo-panel with
>> a patch on top.
>>
>> On Mon, Feb 20, 2023 at 1:13 PM Jianhua Lu <lujianhua000@gmail.com> wrote:
>>
>>> Add a driver for panels using the Novatek NT36523 display driver IC.
>>>
>>> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
>>
>> (...)
>>
>> I like how you abstract the panel with init commands in the panel info.
>>
>>> +enum dsi_cmd_type {
>>> +       INIT_DCS_CMD,
>>> +       DELAY_CMD,
>>> +};
>>> +
>>> +struct panel_init_cmd {
>>> +       enum dsi_cmd_type type;
>>> +       size_t len;
>>> +       const char *data;
>>> +};
>>> +
>>> +#define _INIT_DCS_CMD(...) { \
>>> +       .type = INIT_DCS_CMD, \
>>> +       .len = sizeof((char[]){__VA_ARGS__}), \
>>> +       .data = (char[]){__VA_ARGS__} }
>>> +
>>> +#define _INIT_DELAY_CMD(...) { \
>>> +       .type = DELAY_CMD,\
>>> +       .len = sizeof((char[]){__VA_ARGS__}), \
>>> +       .data = (char[]){__VA_ARGS__} }
>>
>> I have seen this type of reinvented wheels a few times now. Don't do this.
>>
>> Look into other recently merged drivers and look how they do it, for example
>> drivers/gpu/drm/panel/panel-himax-hx8394.c
>>
>> For example:
>>
>> - Use mipi_dsi_dcs_write_seq()
>>
>> - If the delay is just used at one point in the sequence, do not invent
>>   a command language like above for it, open code the delay instead
>>
>> - Try to decode as much magic as possible, if you look in Konrads
>>   driver you clearly see some standard MIPI commands, I bet you have
>>   some too.
>>
>> - Maybe use callbacks to send sequences instead of tables, like in
>>   the himax driver?
> Maybe I should create a wrapper of mipi_dsi_dcs_write_seq() for sync dual dsi mode.
Yes please, it'll come in useful.

Konrad
>>
>> Other than that it seems like something that could also handle the Lenovo
>> display, or the other way around, I don't know which driver is the best
>> starting point, but this one has the right Novatek name at least.
>>
>> Yours,
>> Linus Walleij
