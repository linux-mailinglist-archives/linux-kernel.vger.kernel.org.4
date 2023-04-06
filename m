Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DF96D96EC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 14:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbjDFMRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 08:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237285AbjDFMRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 08:17:21 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9DA30D4;
        Thu,  6 Apr 2023 05:17:18 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id h11so43586034lfu.8;
        Thu, 06 Apr 2023 05:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680783437;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AOMhZA4fW3SZ/fTApq8FgFoqecUHaky/SHKKzAcMU38=;
        b=Kf+kALNjBqOpk+yvYKW3t7zlp8mu+YMEqf4Qe9gKpz/KPEyu+vGtCNrO2OFnuaYX3x
         c+OOj+f9LMJz6ux3wFFTa/U+ZRY03wJiLo5VJnRCTJpy6URr2aqFHd/It9O5CGbpqsgz
         M7X3IKnWIFl72J4XU1kMt1dUMU/0uXEt48CMjtpY4JbplRhNNFxk58ISSwyiAv08sOFZ
         EzSOh4fYb9M1O5evMs6uHJ0HBbOAN/GJ7+sUFz5Me+IEH84gtaWqiuJtkXSaVwc0HWiI
         rg3hQ15uK3cRzDcmJ4kmsXTuTNV0XhZByV7fCJTy4MYxcOVh8exNon4ImDSwR1Ay2bFa
         eA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680783437;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AOMhZA4fW3SZ/fTApq8FgFoqecUHaky/SHKKzAcMU38=;
        b=CjgWD/WVok/8RT70UhC+gZP1HX1ZQec6iqtP5+vMYYrLhgUaUSml5lyTs6NpWzkimo
         w9nvcxG94SyPZx0w4UT9THwresLCilj3dUgqJndcbJxzYsDZ29Evn0IGfWoqcWulPV9Y
         aBTp3MQy3BOIq7f87KVV8YAH7zN4JMGQ041SrgMMrFsRT6XSr4aAqj5Lw+VhWHiKPAkF
         1dPkB3n19ZdfiJ1FVQyNTBtKUBubexHMEQkgcT5mNfZql3GEgdPFc2buKEmBET9Z7+3K
         cbFBjw0Xk5O/992K/sjkKCoDF8p0ab65D5usJ1I5tcsAB/R3pcW3CFc/hGW7vVeDBFC1
         uWtg==
X-Gm-Message-State: AAQBX9d4AM32p95J2rZCsk076tlNts6xqoet0dngcncbGJNdISs98LSX
        9Jtf3HAjJUSJ03jvmGP2TbI=
X-Google-Smtp-Source: AKy350Y98gv4mIJv2tNYkaswwaAdftqngoIs3j2JkbJLnKN32D6DAQSDtt6B5f8JuXYPPeDlUVSIIw==
X-Received: by 2002:ac2:43c8:0:b0:4eb:3faf:58b9 with SMTP id u8-20020ac243c8000000b004eb3faf58b9mr2087863lfl.14.1680783436769;
        Thu, 06 Apr 2023 05:17:16 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id r9-20020ac25a49000000b004db44babad7sm239502lfn.260.2023.04.06.05.17.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 05:17:16 -0700 (PDT)
Message-ID: <17bc6dd1-956e-e90c-4028-8bd3044bcb90@gmail.com>
Date:   Thu, 6 Apr 2023 15:17:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] leds: bd2606mvv: Driver for the Rohm 6 Channel i2c
 LED driver
Content-Language: en-US, en-GB
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     pavel@ucw.cz, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        hns@goldelico.com
References: <20230406060825.103187-1-andreas@kemnade.info>
 <20230406060825.103187-3-andreas@kemnade.info>
 <7d8c558f-0d21-91ed-ecd0-cac079d366ee@gmail.com>
 <20230406134314.25f8d3a0@aktux>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230406134314.25f8d3a0@aktux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/23 14:43, Andreas Kemnade wrote:
> Hi Matti,
> 
> thanks for the review:
> 
> On Thu, 6 Apr 2023 11:57:15 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>>> +	priv->regmap = devm_regmap_init_i2c(client, &bd2606mvv_regmap);
>>> +	if (IS_ERR(priv->regmap)) {
>>> +		err = PTR_ERR(priv->regmap);
>>> +		dev_err(dev, "Failed to allocate register map: %d\n", err);
>>> +		return err;
>>> +	}
>>> +
>>> +	i2c_set_clientdata(client, priv);
>>> +
>>
>> The IC seems to have an enable pin. I think you might add the
>> enable-gpio in dt-bindings and try to (optionally) get and enable it here.
> 
> It has an enable pin. I would prefer to just have the binding as complete as
> possible and have it added later in the driver by someone needing it
> since I cannot test that.

Fair enough. Thanks for working with this!

Yours,
	-- Matti


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

