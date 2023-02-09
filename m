Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A95C691073
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjBISjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjBISjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:39:04 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45766C14A;
        Thu,  9 Feb 2023 10:39:03 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id r8so3875061pls.2;
        Thu, 09 Feb 2023 10:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RPKE8I74KmcfvbAB9W7wcXN11uCSFTgnE2Flitb62ZM=;
        b=EOJs1kkhjifPhGnLGeOobPEF50YTsUIbfUyCEvT6q5WybmHNx53mRj9NV7Hb8wyQIp
         8Ux8R4Pkd/DKkesH7aKzhRepBf8MF6lhlv6+tvw3dBiUd0AM1Bv0BJd+OUTP2wGtOpty
         LpjTMt+YImz1r8e3kQdQ6LE98LcVG/b1lfhfNKixUET7ZJAj/oKuA7ZQbxNRh+Ds+Jt6
         Z7QxKcC4QrWg7SgtIBxZV4eRiOA1LiiU9VvackYRKc3ec+RmdmszQQdNHALUHfuuVL5h
         WTMklrpZnoLItrzphzGTsz5o96Y3PCGIo40mbB3MR3kucRL7FgrX5FCZipWvzneHrmxV
         cfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RPKE8I74KmcfvbAB9W7wcXN11uCSFTgnE2Flitb62ZM=;
        b=SmA6lq/Wok5wVm1OYIiGpprriAh4PQdmOVH7hrFNV49cLuDmJQxmPLYuWTdgLkY9Ll
         wOWgj7GBKYbWlKdDULRuA1tH00R62Ih089LsUhMcA7pAUP91nX3GNGbqds/uZU1zZN0E
         UFPs6sS0/yWechCc0L1Di3r6WRzVfs2a9StKzlbwNoo7EuElboLrBdDaVkP0gcgs/dWo
         BMjkmUp7kuzss9K0ukDbzeVh4gbEoVt9yJmXv2GpSEAv3KjqxZk56rWdXXXU28wRqVdI
         oHx98eMTycjW5ItxxHmAti5XZFZJqYYbdFA4/0cC4tO8V15UHdpC4nbwMSf/WchzmBvE
         f2qg==
X-Gm-Message-State: AO0yUKUK8ByAzldIw/bThgDCTaG8etZ6Pnwd5LdJb4pjCuhPlcRUf6hg
        2wkHR2Bvjh+6ohvt7zqWmuY=
X-Google-Smtp-Source: AK7set/LppshYG8y9o2egxkKV5W3fmYs5pnODYXv05PI+wMMKd/ps8kHMwJ6s2LjZuHkjxKLnGxg6g==
X-Received: by 2002:a17:902:cf08:b0:194:a6e0:3ba with SMTP id i8-20020a170902cf0800b00194a6e003bamr2453021plg.54.1675967942712;
        Thu, 09 Feb 2023 10:39:02 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id l5-20020a170902d34500b00192cf87ed25sm1851177plk.35.2023.02.09.10.39.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 10:39:01 -0800 (PST)
Message-ID: <df7d6a5c-796a-04cc-11b4-a37cee50a341@gmail.com>
Date:   Thu, 9 Feb 2023 10:38:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 00/15] spi: bcm63xx-hsspi: driver and doc updates
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        William Zhang <william.zhang@broadcom.com>,
        kursad.oney@broadcom.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com, dregan@mail.com,
        joel.peshkin@broadcom.com, jonas.gorski@gmail.com,
        tomer.yacoby@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230207065826.285013-1-william.zhang@broadcom.com>
 <167596308461.673456.2324521897149973878.b4-ty@kernel.org>
 <ac6591f3-0420-3cd0-28b5-8b2ea333d723@gmail.com>
 <Y+U9PKGLXSYqnavN@sirena.org.uk>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <Y+U9PKGLXSYqnavN@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/23 10:36, Mark Brown wrote:
> On Thu, Feb 09, 2023 at 10:34:34AM -0800, Florian Fainelli wrote:
>> On 2/9/23 09:18, Mark Brown wrote:
> 
>>> [03/15] ARM: dts: broadcom: bcmbca: Add spi controller node
>>>           (no commit info)
>>> [04/15] arm64: dts: broadcom: bcmbca: Add spi controller node
>>>           (no commit info)
> 
>> Usually we have SoC maintainers pick up the DTS patches affecting the
>> platforms they cover to avoid conflicts... I suppose that is fine.
> 
> Hence the "no commit info" - there's no commit for those changes.

Did not I get tripped over this before, yes I did! OK, I will go hide in 
that corner other there. Thanks!
-- 
Florian

