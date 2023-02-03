Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF5968A26E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 20:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbjBCTDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 14:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjBCTDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 14:03:05 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75C22D51;
        Fri,  3 Feb 2023 11:03:00 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id gr7so17976508ejb.5;
        Fri, 03 Feb 2023 11:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=29jIzExya+RWfAW2Qbt80/MjJ8msw/RiyH3xynOp0go=;
        b=oMo2cuU46YEgGPpTn9tuc/nAV/JSYX82IVQ6fcR+rdup7Ro+7QIAvMc7u6RiSGRj8k
         lp9nfSG/RpNEUhNlVlr3aHuBI3aSguVow4NcnE/ewGe34lBGVWV/kqNWsJOy1OnK0t3L
         NZOTslwltVza66DDVjiccIrt9Mj1iqvf0MvFj5aktxMyYaVyCUNmLfbTYpETGvQoZZLl
         Zlo8M52dFVI2lLPRKKBBQ/2yVXzejK05Re6uVMSp9ZwTa2kwn4pNA69mS2AJNWjKeppQ
         bpYZT5kzF3xGiYl5fSPXLPZdkqxZ5TeagP+owJI5o0IjNhddaRbAOFg5AEXmSVoieJpR
         VfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=29jIzExya+RWfAW2Qbt80/MjJ8msw/RiyH3xynOp0go=;
        b=mADOZsRQVImyvq8ySKXVTPvwyibvORlcQ6h8KCBRibTN4pOBTfRfWoSYTw2kM6Ax7I
         Ez4GOs6SltM0qrtZnK2GqwnvDs4hid91/YOWvGq24za//AgI9cQNACWpoYHQGbXdFadQ
         FrF+MhKMgZhV+lvYzzZUKIatFKsvQSt9TOdjyTMTssi9G5W9gxrHJW/qlT8v0HeM4eCQ
         VUVYRXIebwmRjNKDv4d7i0VUR9J6yAej+hi/VWqYse6tAqbD+PIx9SeLP4f1LC7awV8i
         R08eoGRcmtr4AWIANOvm71oHhyuNZqYvJW3zMHjrc49zfs0Dvgk7cakixRq8aMXDaz8G
         5Sww==
X-Gm-Message-State: AO0yUKWFhahNCgA4W5pYwL1T4q31WIPMn2yZdOjvEtUeesiz6ugXLgwt
        ZjzwadSrhwH5uYwGSZmV6WYflrLKSjk=
X-Google-Smtp-Source: AK7set86/Odr/8QqbXvAfvz/JdLTn2GEOFrSEDN8hur+e37l2t1Wm16nqqBVtmjhNt40O7gBxDbSww==
X-Received: by 2002:a17:907:d68c:b0:88f:8ae1:8bca with SMTP id wf12-20020a170907d68c00b0088f8ae18bcamr6189194ejc.62.1675450979058;
        Fri, 03 Feb 2023 11:02:59 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id f17-20020a170906049100b00871f66bf354sm1710990eja.204.2023.02.03.11.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 11:02:57 -0800 (PST)
Message-ID: <87f5097d-1cd0-e09f-e759-8592a9165ea6@gmail.com>
Date:   Fri, 3 Feb 2023 20:02:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v6 01/17] dt-bindings: display: rockchip: convert
 rockchip-lvds.txt to YAML
To:     Rob Herring <robh@kernel.org>
Cc:     heiko@sntech.de, hjc@rock-chips.com,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        airlied@gmail.com, daniel@ffwll.ch, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, philippe.cornu@foss.st.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org,
        linus.walleij@linaro.org, inki.dae@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com,
        alim.akhtar@samsung.com, linux-samsung-soc@vger.kernel.org
References: <67771143-fd83-383d-41b2-68e8707134e8@gmail.com>
 <20230203182119.GA615242-robh@kernel.org>
Content-Language: en-US
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20230203182119.GA615242-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/3/23 19:21, Rob Herring wrote:
> On Thu, Dec 22, 2022 at 03:22:14PM +0100, Johan Jonker wrote:
>> Convert rockchip-lvds.txt to YAML.
>>
>> Changed:
>>   Add power-domains property.
>>   Requirements between PX30 and RK3288
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>
>> Changed V3:
>>   Filename matching compatible style
>>   Drop "Regulator phandle for "
>>   Specify properties and requirements per SoC
>>   Sort order and restyle
>>
>> Changed V2:
>>   Fix title
>> ---
>>  .../display/rockchip/rockchip,lvds.yaml       | 170 ++++++++++++++++++
>>  .../display/rockchip/rockchip-lvds.txt        |  92 ----------
>>  2 files changed, 170 insertions(+), 92 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip,lvds.yaml
>>  delete mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt
> 

> What's the plan for these patches? Don't see them in linux-next still. 
> Do you want me to take patches 1-8?

Hi,

The display patches normally go through the DRM git.
Patch 2 must merge with grf.yaml.
Heiko has merged now 3 PHY related patches to grf.yaml first.

[PATCH v6 02/17] dt-bindings: soc: rockchip: grf: add rockchip,lvds.yaml

See current
https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/log/?h=for-next&qt=grep&q=jonker

Not sure what Heiko's plans are.
Patch 2 replaces  only a description text and some accolades removal, so not "too" important.

I urgent then you could merge without conflict:
1, 3-8

Patch 2 requires some adjusted now depending on the grf.yaml current next state.

Johan







> 
> Rob
