Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF07615E3E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 09:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiKBIsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 04:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiKBIsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 04:48:07 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DA727DC3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 01:48:04 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h9so23495328wrt.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 01:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7Fsdl5KhjqGKQP2QnpOdJy/pvqM2iIVhcnFcFTUrO8A=;
        b=DtUC+ogPgNq55gImpxgwl/g1PNaHgnSJcUcH3ey02Bg+UHOPn61NGgUQUYKxBUOm0o
         6j55cZK0uUFkIxNtb+53CsWK1Qemz2HFYEVNxcPQv0r7mtLb2RXImhJTAH9IsAo+1z9q
         7G1N1lvRgIsbn5JRW5ZN520ZMYXPAl0pU7SP4BuUHUJXQ8pLqmOtdGSongttbwoxl4gD
         UCRERlPPo6ROhX89ISBcJigfQ/WWviTE5pg5Sy9EA81RzurzZR4FBrz+FkJ7VlMQlk/r
         Kf0hzD4noFjzvmELW/qh3UcYV9e2WT9ndb5muF24MVZXZC5g3GERl9eZ0sUFk5IVZOFg
         gSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Fsdl5KhjqGKQP2QnpOdJy/pvqM2iIVhcnFcFTUrO8A=;
        b=pnUZLyqyR/CGR2jiU/lS1lQPsk/mosmC2HDZvTjeLjq6fXBXMivgQHOKmda22LxyX/
         M2F/1Le7WyKPQMue2pwGncBh606dpH+JThYENVPuxiZxQIFHYbRUNT2mr9a4/7j2IR/v
         DQ+XNmTyj+DKtBXmNvJ6Slljvw4F4E9eJRoMa1Ux/1NVldwtbIfWW3BnYRqQxaSkMnoW
         PH98w56UNEGi9ocZ9TPTKfEz4uBOv7Jb1QlTlY4kNKNH1sgVaXvGtMXDK7vDrIYDu+gU
         4e6EgnkLYjAXDXHFf+Fau64C+p1USMfMz4HfV6L/zYTuHg2FafX7nfWNP7DTwj6fz6Cp
         cubw==
X-Gm-Message-State: ACrzQf1KPKzm9sFQJv9SFs5z0iqeYJsD7hb2cD/OHYGix+hhKIK2abCx
        jln6I5HUoIn3qEWMIzbUejV8Ig==
X-Google-Smtp-Source: AMsMyM5eXnSYYlsc2nkRMQQBb/aW4z9lnVUJTRZ031AFqmay+F47F4Osg205pLQkXyK71S4ukrEHUA==
X-Received: by 2002:a5d:4c52:0:b0:236:60e8:72e with SMTP id n18-20020a5d4c52000000b0023660e8072emr14434036wrt.573.1667378883428;
        Wed, 02 Nov 2022 01:48:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:6bae:ac40:a798:cbb4? ([2a01:e0a:982:cbb0:6bae:ac40:a798:cbb4])
        by smtp.gmail.com with ESMTPSA id ck1-20020a5d5e81000000b002366553eca7sm12328632wrb.83.2022.11.02.01.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 01:48:03 -0700 (PDT)
Message-ID: <9499a56d-fb74-16cd-46c1-27b3fcfdcd7e@linaro.org>
Date:   Wed, 2 Nov 2022 09:48:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/4] power: reset: add Odroid Go Ultra poweroff driver
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org
References: <20221031-b4-odroid-go-ultra-initial-v1-0-42e3dbea86d5@linaro.org>
 <20221031-b4-odroid-go-ultra-initial-v1-2-42e3dbea86d5@linaro.org>
 <20221031222918.knzv3lotfn3sp7bl@mercury.elektranox.org>
Organization: Linaro Developer Services
In-Reply-To: <20221031222918.knzv3lotfn3sp7bl@mercury.elektranox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 31/10/2022 23:29, Sebastian Reichel wrote:
> Hi,
> 
> On Mon, Oct 31, 2022 at 05:47:26PM +0100, Neil Armstrong wrote:
>> The Hardkernel Odroid Go Ultra poweroff scheme requires requesting a poweroff
>> to its two PMICs in order, this represents the poweroff scheme needed to complete
>> a clean poweroff of the system.
>>
>> This implement this scheme, and overrides the PSCI pm_power_off.
> 
> Please use devm_register_power_off_handler() or
> devm_register_sys_off_handler() for new drivers.

Thx, will update.

Neil

> 
> Thanks,
> 
> -- Sebastian
> 
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> [...]

