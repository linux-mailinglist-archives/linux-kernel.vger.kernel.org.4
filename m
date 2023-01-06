Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEED65F8B7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 02:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236580AbjAFBME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 20:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjAFBMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 20:12:01 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57ED71FC2;
        Thu,  5 Jan 2023 17:11:59 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 4B76424DBC0;
        Fri,  6 Jan 2023 09:11:57 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 6 Jan
 2023 09:11:57 +0800
Received: from [192.168.2.237] (183.27.98.121) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 6 Jan
 2023 09:11:55 +0800
Message-ID: <2286c916-c54c-bdda-b1d9-b704813b6fec@starfivetech.com>
Date:   Fri, 6 Jan 2023 09:11:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1 0/4] Temperature sensor support for StarFive JH7110
 RISC-V SoC
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
 <20230103015601.GB313835@roeck-us.net>
Content-Language: en-US
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <20230103015601.GB313835@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.98.121]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jan 2023 17:56:01 -0800, Guenter Roeck wrote:
> On Tue, Jan 03, 2023 at 09:31:41AM +0800, Hal Feng wrote:
> > This patch series adds temperature sensor support for StarFive JH7110 SoC.
> > The last two patches depend on series [1].
> > 
> > [1]: https://lore.kernel.org/all/20221220011247.35560-1-hal.feng@starfivetech.com/
> > 
> > Emil Renner Berthing (4):
> >   dt-bindings: hwmon: Add starfive,jh71x0-temp
> >   hwmon: (sfctemp) Add StarFive JH71x0 temperature sensor
> >   riscv: dts: starfive: jh7110: Add temperature sensor node
> >   riscv: dts: starfive: visionfive-2: Add thermal-zones
> > 
> 
> The hardware monitoring driver is obviously either the same
> or derived from the previous series at
> https://patchwork.kernel.org/project/linux-hwmon/list/?series=&submitter=&state=*&q=starfive
> 
> Why is this not submitted as v4 of the original series ?
> What has changed, and what is the rationale for (re-)submitting
> it as v1 ?

Sorry for the late reply. I feel sorry to say that I didn't know
the submitting history of this patch series and Emil forgot to
tell me maybe. After comparing with the previous series, I find
the changes between this one and the previous one can be concluded
as below.

Change log:
- Added support for StarFive JH7110 SoC besides JH7100.
- Added clock and reset support in dt-bindings and driver.
- Added two patches for adding nodes in JH7110 and VisionFive 2 dts
  which were being reviewed.

Thank you for your kindly reminding. I will resend this patch
series as version 4 and add the change log.

Best regards,
Hal
