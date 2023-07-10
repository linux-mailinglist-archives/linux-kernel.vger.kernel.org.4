Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596DA74D9F7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjGJPg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjGJPgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:36:25 -0400
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1471BD1;
        Mon, 10 Jul 2023 08:36:25 -0700 (PDT)
Received: from [10.0.0.209] (unknown [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id E93171618E3;
        Mon, 10 Jul 2023 17:36:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1689003383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aldkW5insQMnvy0Y42XMjzcK11QX2z9owPRPKOsSeRU=;
        b=Icqowe1lGpco59Hi8siUgWjApLT14iKGbHvEtlaXD0lhyfwpM0TaR8vV1rfzBs7J3oe381
        AO7OsyLVeTgK2jC2WqQkr37G04bsuzt+5VP8eFaVAVq5KJFR13aNp3JQLAGZQIUFRuVJz1
        fQcPJld/bo/1oWUKVhLh2oaEc2JwXNE=
Message-ID: <d117e562-424f-d128-fa81-41ec9022409f@ixit.cz>
Date:   Mon, 10 Jul 2023 17:36:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: Drop invalid
 regulator-init-microvolt property
Content-Language: en-US
To:     Mark Kettenis <mark.kettenis@xs4all.nl>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     d3adme4t@gmail.com, macromorgan@hotmail.com, jbx6244@gmail.com,
        f.kardame@manjaro.org, amadeus@jmu.edu.cn, robh+dt@kernel.org,
        linux.amoon@gmail.com, aurelien@aurel32.net, anarsoul@gmail.com,
        wiagn233@outlook.com, frattaroli.nicolas@gmail.com,
        strit@manjaro.org, luiz.von.dentz@intel.com, zonyitoo@gmail.com,
        wens@csie.org, jensenhuang@friendlyarm.com, lasstp5011@gmail.com,
        frank-w@public-files.de, pgwipeout@gmail.com, conor+dt@kernel.org,
        leo@nabam.net, andyshrk@163.com, krzysztof.kozlowski+dt@linaro.org,
        michael.riesch@wolfvision.net, jonas@kwiboo.se, festevam@denx.de,
        tobetter@gmail.com, jagan@amarulasolutions.com, cnsztl@gmail.com,
        cristian.ciocaltea@collabora.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
References: <20230707162217.675390-1-cristian.ciocaltea@collabora.com>
 <168899855919.1747213.9998138836668928892.b4-ty@sntech.de>
 <87wmz7q1fr.fsf@bloch.sibelius.xs4all.nl>
From:   David Heidelberg <david@ixit.cz>
In-Reply-To: <87wmz7q1fr.fsf@bloch.sibelius.xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_DYNAMIC,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2023 16:35, Mark Kettenis wrote:
>> From: Heiko Stuebner <heiko@sntech.de>
>> Date: Mon, 10 Jul 2023 16:16:16 +0200
>>
>> On Fri, 7 Jul 2023 19:22:17 +0300, Cristian Ciocaltea wrote:
>>> The 'regulator-init-microvolt' property is not currently supported by
>>> any driver, it was simply carried on from downstream kernels.
>>>
>>> The problem is also indicated by the following dtbs_check warning:
>>>
>>>    rk3588-rock-5b.dtb: pmic@0: regulators:dcdc-reg4: Unevaluated properties are not allowed ('regulator-init-microvolt' was unexpected)
>>>
>>> [...]
>> Applied, thanks!
>>
>> [1/1] arm64: dts: rockchip: Drop invalid regulator-init-microvolt property
>>        commit: 4d08b19629495b29601991d09d07865694c25199
> This property *is used* by the drivers in U-Boot.  Dropping this from
> the Linux DTBs will likely result in broken boards the next time the
> U-Boot DTBs are synched again from Linux.  At least that is what
> happened before...
Well, if u-boot uses these properties, u-boot folks should document them 
in bindings ;-)
I found some u-boot mentions reviewing this patch, but only the DTS 
files copied from Linux poped-up.
>
> I think the right solution is to add this property to the DT binding
> instead.

Sure, it should be sent together with the revert.
DT binding property description could also note that the bootloader(s) 
use the value.

David

-- 
David Heidelberg
Consultant Software Engineer

