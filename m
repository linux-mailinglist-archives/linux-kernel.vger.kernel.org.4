Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6F2605FB4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 14:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJTMFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 08:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiJTMFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 08:05:04 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E565C63872;
        Thu, 20 Oct 2022 05:05:01 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id j4so33225261lfk.0;
        Thu, 20 Oct 2022 05:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sSrur7D+PK8q9+Hgf4xggsdAi1Y/zt1lX+qrzO3kT7A=;
        b=JHJx/H7JiRnUidOe2qcDt41THeT9FCFb1QiDfuyvVPmdXnOMgKUp54QdNFKuI1dCXc
         AR5SZvsyvMehMkHLA0IjVyGGbT9b5SOxCCSXyI0KdffG5q/KdLDH/T+kfSozodSLwAqJ
         3TYBsfxTayq02Z3k8CgdM/GoKhmYJR1z27+o9NWf3XOM6ezwx3idc0K/9dMKTeq9OB04
         7TjRERJoivHnxe+WcdwAKZEU5STs59l4CVJOjL+7RJEweofSU7t83yEBiFCTprbdgpU3
         /HbamfHOFwiH2DBzNSo1FnzYeH0b0UGMokLbOpv3Wi3jQPfWRXNV156GLFxtG2HV6Zw9
         E7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sSrur7D+PK8q9+Hgf4xggsdAi1Y/zt1lX+qrzO3kT7A=;
        b=mF/a/Lb8T6VaZFYohji8jraGEB+/HyZBvVtIHHOuOMOvo27OTUZM69nZE2N8cAd1S6
         clyzubnQ8q1RcEuvevXNbEWz39q9qFqIcV0oZzqyiq+Q0U/YJtgxBBXryqbsIe5d5Whx
         KEnhMeCFZry98P06En4pXCcN90nzXGXdIioyFhw+WOc9yxDLPfpYXZT/nSzWzKBUjOnn
         e71uWscmab38Pqu7Vrmrul3S3hotyS5Rk/LdWQuS2/JFOxi+xGKICZDaLz80Ov5mKTmj
         9Yy/oqLu5x9FeKkjlHsWbtl3bxXWfTJlUzSbSXkVJpjz/I69N43PcdYq38PuwiyF7tY1
         en2w==
X-Gm-Message-State: ACrzQf3eXcJxtU3TS04uWh+HjtldlDvOHHMW3PqNbU4kZIC0FnCopk9s
        cEzrnnTWRBsOdqenUwEWrig=
X-Google-Smtp-Source: AMsMyM5AcquzM4nQE3dxkt4JR/xX2RRff6AmdX8xB/8zPG2jTtq/BLkM6xMC4FA49CP0J9bJHyMxJg==
X-Received: by 2002:a05:6512:12c8:b0:4a2:cc20:d51b with SMTP id p8-20020a05651212c800b004a2cc20d51bmr4758797lfg.474.1666267500042;
        Thu, 20 Oct 2022 05:05:00 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::4? (dc75zzyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::4])
        by smtp.gmail.com with ESMTPSA id a11-20020a056512200b00b00497feee98basm2684311lfb.274.2022.10.20.05.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 05:04:58 -0700 (PDT)
Message-ID: <8ac6e29a-8604-e6b0-cb33-e475e57296ac@gmail.com>
Date:   Thu, 20 Oct 2022 15:04:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 0/3] iio: Support ROHM/Kionix kx022a
Content-Language: en-US
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1666263249.git.mazziesaccount@gmail.com>
 <7d8660c4-2f4c-b91e-4e1e-b2dee5cc058f@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <7d8660c4-2f4c-b91e-4e1e-b2dee5cc058f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/22 14:54, Matti Vaittinen wrote:
> On 10/20/22 14:35, Matti Vaittinen wrote:
>> Add initial support for ROHM/Kionix kx022a accelerometer
>>
> Sorry folks! I don't know what happened with my format-patch :(

And now I see it. -EINVALID_USER. I typoed the --base and used 
--base=v6.0-rc1 not --base=v6.1-rc1

Sorry once again - I hope I didn't kill your build scripts / inboxes :(

Yours
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

