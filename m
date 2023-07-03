Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA66745C37
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjGCM2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjGCM2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:28:32 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010E4198
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 05:28:31 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-992acf67388so407058866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 05:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688387309; x=1690979309;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+6M152gdY/lBTJnlZGUQ74XMgASY/+UfhDS7moIYzgc=;
        b=ueP9DH+RCuR7d/Eb3Tl6FM81FNi5B+ZGthqHlULhWOQEW4GACtYosybTXU8F1WjCOm
         XMnSL6j4JyMNQZ285JysTI7LbK1xjsBVJCKcqwmlXZa7Rtgine/lxt/vTZv2cSY9NPO7
         1t/uVFiNDaadc4l4nESKqIPgL7jdS7Sb1IXwolrrAVwGNvQXIf9kFbaJLAAuJqVnCUgc
         x9WRMCL+zGDOajscVz5gVa8x5aeakL2SgKUU0VziTk7CMSeNliAQy+3e8lcJtK0TYY//
         Wng/lEgJnOHJP020f/CQQiytbwFCAdgZcNkZUgMmdTQDD2qAy94Vk5gWAVEk2Om+VD4I
         8VOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688387309; x=1690979309;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+6M152gdY/lBTJnlZGUQ74XMgASY/+UfhDS7moIYzgc=;
        b=WWqxRDX0Jibs18dp/OtkriYE9f3yx8pnbBG1XdgnJC5aP2gA86IvepIIZrX6YXWAAE
         c+ZHpVYJBU2chAzt88zPfrKIrbUbD6wMf9JnHEFzMgHSJEDTfW62ZsDeZTri10rubW1z
         s9We0khw7kNFXD0PLYU9a/3Klird5EyBdYtMC3cLvoOjuLS/DV0IFHai7Su4DfKq2QEW
         AnjezmHJ0WNC2pPZ1/MNLymgt4Aya6ADhmFtGV7Nuu7dHnGKfnNQNRBXowq3YND65zSs
         sNImlF4Zd/3x019nxxyV8jtgDtpeIUQaGH2Ekr9Xmz0ESrgGtCbxbWPoy8N2s0CZdu3m
         gEVg==
X-Gm-Message-State: ABy/qLYd7kHPABXS+FpQv5FK1Gwtzxa52IQxrQn7dx2sPWSF4oJwvmoH
        Qb32PQcXfMZy0v+JFx0L04/x6A==
X-Google-Smtp-Source: ACHHUZ5z9X4wnEecRoQBccdRRk1O19p3dtkMCjmwrIO1xJ1bN3Oa+qfbZPRY1w6NaUL14nbysKhzZg==
X-Received: by 2002:a17:906:4a91:b0:98e:26ae:9b07 with SMTP id x17-20020a1709064a9100b0098e26ae9b07mr5185183eju.35.1688387309422;
        Mon, 03 Jul 2023 05:28:29 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id x26-20020a1709064a9a00b009786ae9ed50sm11848089eju.194.2023.07.03.05.28.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 05:28:29 -0700 (PDT)
Message-ID: <9d0ce727-6473-e326-6b75-f8415fdb85b9@linaro.org>
Date:   Mon, 3 Jul 2023 14:28:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 01/15] genirq/devres: Add error information printing
 for devm_request_threaded_irq()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     miquel.raynal@bootlin.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        mmayer@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, thara.gopinath@gmail.com,
        heiko@sntech.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        srinivas.pandruvada@linux.intel.com,
        DLG-Adam.Ward.opensource@dm.renesas.com, shangxiaojing@huawei.com,
        bchihi@baylibre.com, wenst@chromium.org,
        hayashi.kunihiko@socionext.com,
        niklas.soderlund+renesas@ragnatech.se, chi.minghao@zte.com.cn,
        johan+linaro@kernel.org, jernej.skrabec@gmail.com,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <20230627101215.58798-1-frank.li@vivo.com>
 <20230627110025.vgtplc6nluiiuvoh@pengutronix.de> <87h6qpyzkd.ffs@tglx>
 <247a8166-f131-2d07-ec2b-479a4c19297f@vivo.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <247a8166-f131-2d07-ec2b-479a4c19297f@vivo.com>
Content-Type: text/plain; charset=UTF-8
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

On 03/07/2023 13:54, Yangtao Li wrote:
> Hi Krzysztof,
> 
> On 2023/6/30 19:11, Thomas Gleixner wrote:
>> On Tue, Jun 27 2023 at 13:00, Uwe Kleine-König wrote:
>>> On Tue, Jun 27, 2023 at 06:12:01PM +0800, Yangtao Li wrote:
>>>
>>> While I assume changing to dev_err_probe is a result of my concern that
>>> no error should be printed when rc=-EPROBEDEFER, my other concern that
>>> adding an error message to a generic allocation function is a bad idea
>>> still stands.
>> I agree in general, but if you actually look at the call sites of
>> devm_request_threaded_irq() then the vast majority of them print more or
>> less lousy error messages. A quick grep/sed/awk/sort/uniq revealed
>>
>>       519 messages total (there are probably more)
>>
>>       352 unique messages
>>
>>       323 unique messages after lower casing
>>
>>           Those 323 are mostly just variants of the same patterns with slight
>>           modifications in formatting and information provided.
>>
>>       186 of these messages do not deliver any useful information,
>>           e.g. "no irq", "
>>
>>       The most useful one of all is: "could request wakeup irq: %d"
>>
>> So there is certainly an argument to be made that this particular
>> function should print a well formatted and informative error message.
>>
>> It's not a general allocator like kmalloc(). It's specialized and in the
>> vast majority of cases failing to request the interrupt causes the
>> device probe to fail. So having proper and consistent information why
>> the device cannot be used _is_ useful.
>>
>> Yangtao: The way how this is attempted is not useful at all.
>>
>>      1) The changelog is word salad and provides 0 rationale
>>
>>         Also such series require a cover letter...
>>
>>      2) The dev_err() which is added is not informative at all and cannot
>>         replace actually useful error messages. It's not that hard to
>>         make it useful.
>>
>>      2) Adding the printks unconditionally first will emit two messages
>>         with different content.
>>
>>         This is not how such changes are done.
>>
>>         The proper approach is to create a wrapper function which emits
>>         the error message:
>>
>>         wrapper(....., const char *info)
>>         {
>>              ret = devm_request_threaded_irq(....);
>>              if (ret < 0) {
>>                 dev_err(dev, "Failed to request %sinterrupt %u %s %s: %d\n,
>>                         thread_fn ? "threaded " : "",
>>                         irq, devname, info ? : "", ret);
>>              }
>>              return ret;
>>         }
> 
> 
> Here.
> 
> V3 was modified according to tglx's suggestion, if there is any problem, 
> please point out.

The comment was about request_thread_irq, not about devres alloc. Don't
mix the places. Really, since when do we print any errors on ENOMEM?

Best regards,
Krzysztof

