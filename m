Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570556A2FF6
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 15:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjBZOdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 09:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjBZOdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 09:33:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096B5B764;
        Sun, 26 Feb 2023 06:33:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8218D60C17;
        Sun, 26 Feb 2023 14:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC50C433EF;
        Sun, 26 Feb 2023 14:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677421992;
        bh=YnxpkmbkG6PzcFyevBigSqi5GniCxlw3dIbgKnEcWt8=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=U3DuBm8ED4PczZm6tJIrICo3o0CiMDJs/JYJdSPCpS0NtAkSmXSQzk7lNXiai09hv
         pf1kE2IMc0V6kunxscDiTdqyu9iVub+ezxpNfGwo7X8O/V5kYEoAZ43XJNqDZPoEE+
         88LBVIv83wfKYZ6Usc4hyCyEhESXElIr8FwFOVkWyzfijHsZfd6RnWqkpMg7fylJdh
         yhJoo65Kh68Fxp/qXpJH2cBein1afGn/NF+mPUfucsqJomFjaV7MDQ0lXAEcp8ydaO
         +pmOjeiBpmXa4iN+m30WpiUGh/zC7ewF0iVptIbEK5t6Ng7Mf2uGHkF0lfV82hPg0S
         d1p07RvrhfS2g==
Date:   Sun, 26 Feb 2023 14:33:07 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>
CC:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Samin Guo <samin.guo@starfivetech.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] drivers: watchdog: Add StarFive Watchdog driver
User-Agent: K-9 Mail for Android
In-Reply-To: <CAJM55Z823iqUqD8enM0qJ_MA3Tw94Mn0mq71fbLT1Qjo2s2J3g@mail.gmail.com>
References: <20230220081926.267695-1-xingyu.wu@starfivetech.com> <20230220081926.267695-3-xingyu.wu@starfivetech.com> <CAJM55Z823iqUqD8enM0qJ_MA3Tw94Mn0mq71fbLT1Qjo2s2J3g@mail.gmail.com>
Message-ID: <CA6686A1-2336-442F-8C7B-7D8EFEEE1940@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26 February 2023 14:14:25 GMT, Emil Renner Berthing <emil=2Erenner=2Ebe=
rthing@canonical=2Ecom> wrote:
>On Mon, 20 Feb 2023 at 09:21, Xingyu Wu <xingyu=2Ewu@starfivetech=2Ecom> =
wrote:
>>
>> Add watchdog driver for the StarFive JH7110 SoC=2E
>>
>> Signed-off-by: Xingyu Wu <xingyu=2Ewu@starfivetech=2Ecom>
>> ---
>>  MAINTAINERS                     |   7 +
>>  drivers/watchdog/Kconfig        |   9 +
>>  drivers/watchdog/Makefile       |   2 +
>>  drivers/watchdog/starfive-wdt=2Ec | 651 ++++++++++++++++++++++++++++++=
++
>>  4 files changed, 669 insertions(+)
>>  create mode 100644 drivers/watchdog/starfive-wdt=2Ec
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 135d93368d36=2E=2E6cbcf08fa76a 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -19933,6 +19933,13 @@ F:     Documentation/devicetree/bindings/reset=
/starfive,jh7100-reset=2Eyaml
>>  F:     drivers/reset/reset-starfive-jh7100=2Ec
>>  F:     include/dt-bindings/reset/starfive-jh7100=2Eh
>>
>> +STARFIVE JH7110 WATCHDOG DRIVER
>> +M:     Xingyu Wu <xingyu=2Ewu@starfivetech=2Ecom>
>> +M:     Samin Guo <samin=2Eguo@starfivetech=2Ecom>
>> +S:     Supported
>> +F:     Documentation/devicetree/bindings/watchdog/starfive*
>> +F:     drivers/watchdog/starfive-wdt=2Ec
>> +
>>  STATIC BRANCH/CALL
>>  M:     Peter Zijlstra <peterz@infradead=2Eorg>
>>  M:     Josh Poimboeuf <jpoimboe@kernel=2Eorg>
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index 0bc40b763b06=2E=2E4608eb5c9501 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -2089,6 +2089,15 @@ config UML_WATCHDOG
>>         tristate "UML watchdog"
>>         depends on UML || COMPILE_TEST
>>
>> +config STARFIVE_WATCHDOG
>> +       tristate "StarFive Watchdog support"
>> +       depends on RISCV
>
>Let's do like the pinctrl and clock drivers and
>
>    depends SOC_STARFIVE || COMPILE_TEST

Or better yet, rebase on 6=2E3-rc1, and use ARCH_STARFIVE and save me a co=
nversion!

Thanks,
Conor=2E
