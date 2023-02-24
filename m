Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0329B6A1855
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 09:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjBXI6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 03:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjBXI6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 03:58:07 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC261136DD;
        Fri, 24 Feb 2023 00:58:03 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 7DA1F24E2A1;
        Fri, 24 Feb 2023 16:57:50 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 24 Feb
 2023 16:57:50 +0800
Received: from [192.168.125.82] (113.72.147.165) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 24 Feb
 2023 16:57:49 +0800
Message-ID: <b9b4e45b-eb79-f94f-d96f-764b49ce0471@starfivetech.com>
Date:   Fri, 24 Feb 2023 16:57:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v4 2/2] hwmon: (sfctemp) Add StarFive JH71x0 temperature
 sensor
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
CC:     <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Samin Guo <samin.guo@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
References: <20230207072314.62040-1-hal.feng@starfivetech.com>
 <20230207072314.62040-3-hal.feng@starfivetech.com>
 <20230208162312.GA3062856@roeck-us.net>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <20230208162312.GA3062856@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.147.165]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2023 08:23:12 -0800, Guenter Roeck wrote:
> On Tue, Feb 07, 2023 at 03:23:14PM +0800, Hal Feng wrote:
>> From: Emil Renner Berthing <kernel@esmil.dk>
>> 
>> Register definitions and conversion constants based on sfctemp driver by
>> Samin in the StarFive 5.10 kernel.
> 
> "based on ..." does not belong here. Describe what the driver does,
> not what it is based on. If you want to add a note about the origin
> of the driver, add it in the comments on the top of the driver.

Will reword the commit message in the next version.

> 
> Please add the missing default: statements in the driver,

OK. I will fix it accordingly.

> and explain (for example in the comments at the top of the
> driver) why you don't use continuous mode. The description
> needs to be detailed and compelling enough that no one comes
> back and implements a continuous mode version of the driver.

As we discussed in [1], I will use continuous mode instead.
Thanks.

[1] https://lore.kernel.org/all/2c424d39-3a1d-3c91-d049-c0b941359bc3@starfivetech.com/

Best regards,
Hal
