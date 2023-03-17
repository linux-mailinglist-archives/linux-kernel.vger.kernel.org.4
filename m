Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441E96BED5D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 16:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjCQPyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 11:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjCQPyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 11:54:53 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E775CC6DB8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:54:51 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id eh3so22135187edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679068490;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a6MfDM7+OPKEruVq5Qw+tL9foQplTG2gH4LeyrZ6K0I=;
        b=J3OI5NGj9npu+foP+NF4EKylYoqNwBGWTTFoaBFl/rtJptvgmBqbgaaNwy0O7xtBZV
         OoRN0BmTI0Vf421lNAAHbcxY37muIyEDCYlutZBnnT5RsycZvFq/PuFUBlELpOocRsuJ
         K0xbCzcc3REibeoG9AcCeLCc+b1sQocdX11eHVM8JkPs4x/rdJcow6Ii+OL2asqAn6zf
         rFPh/33gn2hrfP6UFSb8aYJBRoSxMyXd5IrQNX/xxa37k91f2ZMBbsDpnJJM7Oepr39r
         v3SYngKEeCsRngXiYqXXSOEwTxlT71jNY/ehg8AgbVg5CxUKjNiBr60b6cJpnHThX7pf
         CoKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679068490;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a6MfDM7+OPKEruVq5Qw+tL9foQplTG2gH4LeyrZ6K0I=;
        b=HaxKOFPOshLr8kHRODGGGFWJyDuNdGSTti5gmu4m3MrO9sK4ehdRl/ipLkjQHYPedO
         2Xam9KQF70VRMJ348VnXOaPLgQ0vM3OCheOuCJlVRLdJmopidy+iGNHuLbP7PE2k3W6o
         WHMD2/BO7vE1TpZUm9tRK7eAps6t2KpzHiM+Fe5gl5kBe68jTniFQwdXSrGlfpKxHCeF
         WkM7dxJFlSX/iIz/JQ0HhIl2vUdVEWkWzm57KQ/93Cf92zPWIYKdDVq8+D65Y/mzgESF
         2TaqOHHNYSiH+9AgWc7gGT5+IqBhvMXWD0C9xq1Xe3788Yaah8Zu0ikzgHoMDKmCBcot
         WnlQ==
X-Gm-Message-State: AO0yUKWpfSN1jymy1MVUeeY8guPHzYjR/uVBVS/EmmPYFU9CzcD0R59T
        BdtHtYzW7S4c5/IJC3hDdOS1Bw==
X-Google-Smtp-Source: AK7set+MZ5pmlFpN+w8RxZMV5gSssYKuD9NQ8ZrDbPdbH6ontcivRAhcm8upFtI00t/Upa7xjOUp1Q==
X-Received: by 2002:a17:907:cf88:b0:92f:7c42:8631 with SMTP id ux8-20020a170907cf8800b0092f7c428631mr10502230ejc.16.1679068489976;
        Fri, 17 Mar 2023 08:54:49 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d013:3eeb:7658:cec? ([2a02:810d:15c0:828:d013:3eeb:7658:cec])
        by smtp.gmail.com with ESMTPSA id kx1-20020a170907774100b0091fdd2ee44bsm1112929ejc.197.2023.03.17.08.54.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 08:54:49 -0700 (PDT)
Message-ID: <80796828-7b38-184a-2e8e-3cfe9158b67f@linaro.org>
Date:   Fri, 17 Mar 2023 16:54:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 02/11] dt-bindings: serial: snps-dw-apb-uart: Relax
 dma-names order constraint
Content-Language: en-US
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Drake <drake@endlessm.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org, kernel@collabora.com
References: <20230315114806.3819515-1-cristian.ciocaltea@collabora.com>
 <20230315114806.3819515-3-cristian.ciocaltea@collabora.com>
 <3679f2d0-55f0-1710-abc2-b268b6fc6969@linaro.org>
 <8ae57fe3-56aa-7e50-3eaa-a12a40657baf@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8ae57fe3-56aa-7e50-3eaa-a12a40657baf@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2023 11:21, Cristian Ciocaltea wrote:
> On 3/17/23 10:31, Krzysztof Kozlowski wrote:
>> On 15/03/2023 12:47, Cristian Ciocaltea wrote:
>>> Commit 370f696e4474 ("dt-bindings: serial: snps-dw-apb-uart: add dma &
>>> dma-names properties") documented dma-names property to handle Allwiner
>>> D1 dtbs_check warnings, but relies on a strict rx->tx ordering, which is
>>> the reverse of what a different board expects:
>>>
>>>    rk3326-odroid-go2.dtb: serial@ff030000: dma-names:0: 'rx' was expected
>>>
>>> A quick and incomplete check shows the inconsistency is present in many
>>> other DT files:
>>
>> Why not fixing the DTS? The properties should have fixed order.
> 
> I was initially concerned about the risk of a potential ABI breakage, 
> but I think that's not really a problem since dma-names is not directly 
> accessed in the driver and DT Kernel API doesn't rely on a particular order.
> 
> If there are no objections, I would switch the order in the binding to 
> tx->rx, since that's what most of the DTS use, and fix the remaining ones.

Since we added the order recently, I rather assume it is the correct or
preferred one.

Best regards,
Krzysztof

