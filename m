Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E9568C463
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 18:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjBFRQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 12:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBFRQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 12:16:33 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE31A9;
        Mon,  6 Feb 2023 09:16:32 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 0002624E01A;
        Tue,  7 Feb 2023 01:16:30 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 7 Feb
 2023 01:16:31 +0800
Received: from [172.16.16.234] (113.72.145.145) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 7 Feb
 2023 01:16:30 +0800
Message-ID: <f43ec664-4571-b52d-5b8a-48c8f65addce@starfivetech.com>
Date:   Tue, 7 Feb 2023 01:16:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 1/4] dt-bindings: hwmon: Add starfive,jh71x0-temp
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
CC:     <linux-hwmon@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <linux-kernel@vger.kernel.org>
References: <20230103013145.9570-1-hal.feng@starfivetech.com>
 <20230103013145.9570-2-hal.feng@starfivetech.com>
 <20230103221405.GA217696@roeck-us.net>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <20230103221405.GA217696@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.145]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jan 2023 14:14:05 -0800, Guenter Roeck wrote:
> On Tue, Jan 03, 2023 at 09:31:42AM +0800, Hal Feng wrote:
>> From: Emil Renner Berthing <kernel@esmil.dk>
>> 
>> Add bindings for the temperature sensor on the StarFive JH7100 and
>> JH7110 SoCs.
>> 
>> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> 
> The previous version of this bindings document (v3, 
> https://patchwork.kernel.org/project/linux-hwmon/patch/20210726171802.1052716-2-kernel@esmil.dk/
> had been reviewed by Rob Herring. Even though this version is named differently
> (starfive,jh71x0-temp.yaml instead of starfive,jh7100-temp.yaml), the old version
> should be referenced, and there should be a change log.

Will add the Reviewed-by tag of Rob and add a change log. Thank you again.

Best regards,
Hal
