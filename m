Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73116761AD
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 00:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjATXkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 18:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjATXkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 18:40:21 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B907ED69;
        Fri, 20 Jan 2023 15:40:15 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id v5so8540440edc.3;
        Fri, 20 Jan 2023 15:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YlFQs5uK1REKCJrhOvImfAktaMDFYnGI105SvemPmlY=;
        b=RRiBdw8uKBYsQzBGG11bH8QpnGKO+OrOgFZgbwJ0LEsEIPHcP7NIdCOplfvqJq8Gcn
         IDtizdX6lIF3alkc+hWGOqX8r13i2qRyNZp9JDHxXCaqxMbK9x5OKjof6i4tFgOSr3r5
         tjuYBJAMeg/FMtfXejJCJ9r6vFrvi65I7Itw6TiKTUVIyLJegXEgLmgksKWfK+PqzEsi
         H9P7nID/+0DuRX9/GhZ2wmEOfsmc0xKQsQrdu1EA/dnpRuFBVRaPndkx4OiPgtazlxEn
         VdJXWiQveKeHn4g4HKUvrrTXj7UwfzR9tISQR/41dRU/sSQfgY1fuiSQQE0ogA67JIO/
         uUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YlFQs5uK1REKCJrhOvImfAktaMDFYnGI105SvemPmlY=;
        b=BORCqbLvsxnYN9NJ+5cH+jyyR4sfGNUuorW+FIDsk0X4gjGHnkhZKXgUdL7QFw4qL0
         PayXEwDFi9ErJ8Oa4hqEG6waXcP7Aa8BuMTKaiP/68BGRqjUuKHmq4jq7Bc2GnEs8ZvA
         LkPinfVsxDEeogexzPxIPkRELgbIx1sywJNcQNl+pn9WeGm2Ps2d/PTxenwn2j0KVh0o
         46VKqpOy6Ycljh7LXmI4so3FyTw4ehikAsmLx77KPRwDCBnBVUIgiMJPzsNYv+3cR3OW
         /r4oxprsJx/wNGVR9OMl2uTAlrxM4R7N8UuEJOYxBfJTIH1rBkYghiWzH6z/sdijyQvZ
         t9qw==
X-Gm-Message-State: AFqh2kotMapyYq4Iawv5Wij9h+kiimWD6QMZVJh1SJK1EZJblGppTBi9
        mCGz4aT4H7URrTnfhMU6FZwRZucMfrY=
X-Google-Smtp-Source: AMrXdXuVuW4WzQPRX+Id1GCwSM7qs0K6dzLXuAUos1Todbd5RBeS68VoXDFF+todOBUIwUvJl8vzWQ==
X-Received: by 2002:aa7:c44d:0:b0:46c:b919:997f with SMTP id n13-20020aa7c44d000000b0046cb919997fmr7738082edr.17.1674258014332;
        Fri, 20 Jan 2023 15:40:14 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id ec49-20020a0564020d7100b0049e249c0e56sm7066080edb.56.2023.01.20.15.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 15:40:13 -0800 (PST)
Message-ID: <be193659-e97f-23b9-b89c-d02205705db6@gmail.com>
Date:   Sat, 21 Jan 2023 00:40:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 2/2] dt-bindings: usb: rockchip,dwc3: Move RK3399 to
 its own schema
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230118193056.673514-1-robh@kernel.org>
 <20230118193056.673514-2-robh@kernel.org>
 <4eca2695-cb73-eaad-4c8a-82dec923825e@gmail.com>
 <CAL_JsqKqiRbBJErkh2Hch+XZyLggGyjYo1rvKWPhxb99pA8mAA@mail.gmail.com>
Content-Language: en-US
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <CAL_JsqKqiRbBJErkh2Hch+XZyLggGyjYo1rvKWPhxb99pA8mAA@mail.gmail.com>
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



On 1/20/23 21:30, Rob Herring wrote:
> On Wed, Jan 18, 2023 at 3:05 PM Johan Jonker <jbx6244@gmail.com> wrote:
>>
>> Hi,
>>
>> Some alignment at the examples and the unknown extcon property.
>>
>> usb@fe800000: 'extcon' does not match any of the regexes
> 
> Does that go in the wrapper or dwc3 node?:
> 
> arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dtb: usb@fe800000:
> usb@fe800000: Unevaluated properties are not allowed ('extcon' was
> unexpected)
>         From schema:
> /home/rob/proj/linux-dt/Documentation/devicetree/bindings/usb/rockchip,rk3399-dwc3.yaml
> 


> That's the dwc3 node, but the majority are in the wrapper node, so I'm
> going with the majority and leaving this one.

In wrapper code for rk33899 in dwc3-of-simple.c I don't see no extcon activity I think.

In core there's recently made some changes:
https://github.com/torvalds/linux/blame/master/drivers/usb/dwc3/core.c#L1710

usb: dwc3: Don't switch OTG -> peripheral if extcon is present 
https://lore.kernel.org/all/20221017233510.53336-1-andriy.shevchenko@linux.intel.com/

Binding status update for that is unknown for me.
Do whatever suites you best.

Johan
> Rob
