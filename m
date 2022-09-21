Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6907F5BF744
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 09:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiIUHL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 03:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiIUHLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 03:11:17 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21C1165B1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:11:15 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id s6so7684338lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=wiXy5ZIaldVPRdkC0O1dXknFlmQtPsl+IQZh9q4Cgmo=;
        b=BNWeozDy1dKboNi6UK9bXjuRFkSY55U3BDN4+3Qq9dKjQPYnJxKQzyMV9NS9gbfT0Z
         7hjI0sUzfTo8iAhQ/mvIcUwuPsG5nfoDQ3bJXuUH7zUymrDAwlo3qF25z5yxuhnpkfQv
         sz+JtUst9JhzKCNnpVaKaVZulJT8eVGh7IRKbJHjv2TZYOq7vK8lokKDyLFcDduKwBG5
         gwznPs7AshqOMlIcUut0mCwUxZ+91gDbwVCrxaPq1JK6XH+zwfxhjXfXEO5HnoPbk73X
         gc+ouQVeSVZ22tggHhOAtQqHHfxbsrp0m0ch5KqGK4RvqfvlZbFaSI4sv7nFlwKv2HuI
         3SfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=wiXy5ZIaldVPRdkC0O1dXknFlmQtPsl+IQZh9q4Cgmo=;
        b=K/FKh1UuJ7XB10C+YQE+QZshOrbkZTqCf9w5OakMV5lDCOMIH7SA4YyP8WCsH+L5VN
         BsLEIY2mtCtbYWaLRtn4fguqMT6yMVNwTUfYQkU7QEdsXHQKsIYqaFYtHCQYXFkE4nud
         zElxMHh+txTLURBREyI/av1B6uYEQgpRXuvt8mZ9Yenk2QU1bRhw3wvRLwL0xfuiBovH
         2UNgvbCQUA5lOzmvlE4wfyWo/d1qjx0MC3GmQ7exWASWW1P2laC+iuunsYUUiB3HvVDm
         PVdG1UFciy61+q1LTqZ/v9LuCh572+cgwhY22fHYq4eZVbk6xWA/GqtgGXa3TEDxIHbV
         mZVQ==
X-Gm-Message-State: ACrzQf1d2wP8bUz9TIIYJ0G4qcdse+yyw83w+RkPfq1hNvmuRPQcqf7H
        xNTlx4gWsVMyMBcbJOfEya+nYg==
X-Google-Smtp-Source: AMsMyM6S3qg1XzFgFQZ4Arx5bMNo57o7Uhkt5ibKjTwMAKsPl7xPucNJNMl7abyEQ7e0sR6YFidK7w==
X-Received: by 2002:a05:6512:20d2:b0:497:a29f:cada with SMTP id u18-20020a05651220d200b00497a29fcadamr9075345lfr.45.1663744274292;
        Wed, 21 Sep 2022 00:11:14 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w16-20020a05651c119000b0026c18aa8587sm309565ljo.75.2022.09.21.00.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 00:11:13 -0700 (PDT)
Message-ID: <1860b0ff-5544-5e74-ccfc-beda18824927@linaro.org>
Date:   Wed, 21 Sep 2022 09:11:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/4] dt-bindings: pinctrl: Combine MediaTek MT67xx pinctrl
 binding docs
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220919170115.94873-1-y.oudjana@protonmail.com>
 <20220919170115.94873-2-y.oudjana@protonmail.com>
 <4c425cf8-f9ca-969c-f8ed-688410bfb922@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4c425cf8-f9ca-969c-f8ed-688410bfb922@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 10:06, AngeloGioacchino Del Regno wrote:
> Il 19/09/22 19:01, Yassine Oudjana ha scritto:
>> From: Yassine Oudjana <y.oudjana@protonmail.com>
>>
>> Documents for MT6779, MT6795 and MT6797 that currently exist share
>> most properties, and each one has slightly differently worded
>> descriptions for those properties. Combine all three documents into
>> one common document for all MT67xx SoC pin controllers, picking a few
>> parts from each and accounting for differences such as items in reg
>> and reg-names properties. Also document the MT6765 pin controller
>> which currently has a driver but no DT binding documentation. It should
>> be possible to also include bindings for MT8183 and MT8188, but these
>> have some additional properties that might complicate things a bit,
>> so they are left alone for now.
>>
>> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>> ---
>>   .../pinctrl/mediatek,mt6779-pinctrl.yaml      | 207 ------------------
>>   .../pinctrl/mediatek,mt6797-pinctrl.yaml      | 176 ---------------
>>   ...6795.yaml => mediatek,mt67xx-pinctrl.yaml} | 181 +++++++++++----
> 
> Hello Yassine,
> nice cleanup over here!
> 
> There's a catch though: as far as I know, wildcards are not permitted... so you
> should, at this point, merge all of these in mediatek,mt6779-pinctrl.yaml instead.
> 
> Before jumping to that, though... Krzysztof, can you please confirm (or deny)?

Wildcards are not allowed in compatibles. In filename wildcards or
family name could work if they are really going to match the devices. I
have doubts here. 67xx is quite a lot of different devices, so I am not
sure this will cover them all.

I would prefer one name (oldest SoC or lowest number).

Best regards,
Krzysztof
