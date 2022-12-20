Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F18965279F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 21:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbiLTUNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 15:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbiLTUNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 15:13:16 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D581C914;
        Tue, 20 Dec 2022 12:13:15 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id y4so13554755ljc.9;
        Tue, 20 Dec 2022 12:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1I2R1NZ0M+nrKQ/AIqMBDxMCjwYm6eh5zT5Z3Yt5WA0=;
        b=PDYeSRtsu33EXQkhnsspag/LUhaX1lMTn7pNFrzAyj1XFX8wy6YdHaSDAxvVJhXUWn
         qsLIvyUEQ5ZgWVm/cKqAB0R0zeD+1Ln6ilLi4HXKSpHPtyF71c2SDU2mWsD0xd3z1x+M
         maIsV09+EMKAMAH+wea8PkBIlQ4YOuI44dvL2mY+493yStMOr2LxY2ilm+Wqlk2fIgTd
         78F0VOpL4KhrYsMRxvVs1RixpOUEBonPzMFuxgRGBeqAiX2DqzmDGqSQV8r1LkzfT6JU
         AjbdVWrKKLPHWusFE461b39Fsij6mviXAVj6O+x0FVQ/PwtGib4j1RawyAoyA/id+i1/
         e8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1I2R1NZ0M+nrKQ/AIqMBDxMCjwYm6eh5zT5Z3Yt5WA0=;
        b=1HrAHAZTgOE254/sJNVAaiwtRPGeEn/rSFUmnXp50+DKnQWxLxItANbmTGSYTwOyTc
         43x52oGAgcO1C1JGgS9EDvU67kAZz825e9O1TbsXUXCP9fKsI7/cYu1ZoGWPhZyO/5ll
         UUzYtAQguy41rKhUP8mQLKweIjxJrcMUOXaYIEUCqzwUoM24+KB/khGI11B5qQblFOD/
         g+RNLh/ZlTD6F7FuzWwYcNlXWmeC/wVyxMgvGqtpG5u841KBMTwHJrM6sAmyAzxfsH7P
         w9y348qSKItVGpM7+m3HmjbySVN4WdL+pvIS2yeJ7GRc4orolWDqn9ObjKWJpMeACKrf
         1B3g==
X-Gm-Message-State: ANoB5plgna54TKSbj5gdbiP7RZhleDU1B93X0Zhfs+/rwEDWDkncLoOL
        7N7ZDq+0Fb/QZwIgYSQV/u8=
X-Google-Smtp-Source: AA0mqf4TcaS04q2CPdCkB6V3ZtYJQs3DghgWFYP0vVIPsJ3WsKjDKJhXEhWWitXs5pzRNslqXHbBSw==
X-Received: by 2002:a2e:8048:0:b0:279:fe89:fbb5 with SMTP id p8-20020a2e8048000000b00279fe89fbb5mr11873978ljg.32.1671567193388;
        Tue, 20 Dec 2022 12:13:13 -0800 (PST)
Received: from [192.168.2.145] (109-252-113-89.nat.spd-mgts.ru. [109.252.113.89])
        by smtp.googlemail.com with ESMTPSA id e14-20020a05651c038e00b00277025ddc9esm1126484ljp.54.2022.12.20.12.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 12:13:12 -0800 (PST)
Message-ID: <38c7cfe0-62e0-066a-d8dd-4ed4243a552e@gmail.com>
Date:   Tue, 20 Dec 2022 23:13:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 01/21] dt-bindings: display: tegra: add Tegra20 VIP
Content-Language: en-US
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>
References: <20221128152336.133953-1-luca.ceresoli@bootlin.com>
 <20221128152336.133953-2-luca.ceresoli@bootlin.com>
 <20221201231936.GB1660613-robh@kernel.org> <20221202091108.5f492d6f@booty>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20221202091108.5f492d6f@booty>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

02.12.2022 11:11, Luca Ceresoli пишет:
> Hello Rob,
> 
> Thanks for your review.
> 
> On Thu, 1 Dec 2022 17:19:36 -0600
> Rob Herring <robh@kernel.org> wrote:
> 
>> On Mon, Nov 28, 2022 at 04:23:16PM +0100, Luca Ceresoli wrote:
>>> VIP is the parallel video capture component within the video input
>>> subsystem of Tegra20 (and other Tegra chips, apparently).
>>>
>>> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>>>
>>> ---
>>>
>>> Changed in v2 (suggested by Krzysztof Kozlowski):
>>> - remove redundant "bindings" from subject line
>>> - remove $nodename
>>> - add channel@0 description
>>> - add reg: const: 0
>>> ---
>>>  .../display/tegra/nvidia,tegra20-vip.yaml     | 63 +++++++++++++++++++
>>>  MAINTAINERS                                   |  7 +++
>>>  2 files changed, 70 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vip.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vip.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vip.yaml
>>> new file mode 100644
>>> index 000000000000..44be2e16c9b4
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vip.yaml
>>> @@ -0,0 +1,63 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/display/tegra/nvidia,tegra20-vip.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: NVIDIA Tegra VIP (parallel video capture) controller
>>> +
>>> +maintainers:
>>> +  - Luca Ceresoli <luca.ceresoli@bootlin.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - nvidia,tegra20-vip
>>> +
>>> +  "#address-cells":
>>> +    const: 1
>>> +
>>> +  "#size-cells":
>>> +    const: 0
>>> +
>>> +  channel@0:  
>> Kind of odd there is only 1 channel with a unit-address. Are more 
>> channels coming? Please make the binding as complete as possible even if 
>> no driver support yet.
> This was discussed in v1 with Krzysztof and the outcome was that it's
> OK because it's likely that other SoCs have more, but the documentation
> is not public so I cannot add examples.
> 
> Full discussion (pretty short indeed):
> 
> https://lore.kernel.org/linux-devicetree/5292cc1b-c951-c5c5-b2ef-c154baf6d7fd@linaro.org/
> 
> Do you agree that the unit-address should be kept?

It's doubtful that there is a SoC having a VIP with multiple channels.
I'd expect it to be multiple VIPs rather than channels. There are NVIDIA
people to confirm that.

The "channel" itself looks redundant to me, i.e. the reg and ports
should be moved to the vip node.
