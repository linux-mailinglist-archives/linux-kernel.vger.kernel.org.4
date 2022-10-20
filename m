Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7444C605FF3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 14:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiJTMQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 08:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiJTMQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 08:16:37 -0400
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CA115CB37;
        Thu, 20 Oct 2022 05:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NXisTPS0jjjvtpkKKzNomaefNbAzVqlaK/nCgzXTANs=; b=fi9Ieb0+KFO0zN7vKavd9vXnic
        XDb+w5UfwM0jZuT8H0iTHeKdsbpaoL5Q+kYqgVv17AFnEeAP1QCVi3rmDShtUh0Sx35/WONxib2zu
        lKqkyHvfTsBh2LIFfbx+HcVPctpsGGhiF7cyeCCrlNrPKhydWhz9ciTks9x9bvdxv3Iw3GwlR6uqv
        +Qph9Y4Z/LcC2aCeQNCezPGGlQ+M+cI+aOwR3yIS+U9FzUGS1BYx34gxOFm2YiefYi2O2xJgVU0lV
        dAZvNoB93NTJ+kh+9QAEsiVhDMk2ztA4MA4UOi8vm4onjzS75umkVvj+HJnSwHZh2woNjrNZseRIK
        bhjEFv2A==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:44048 helo=[192.168.69.85])
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <andrej.picej@norik.com>)
        id 1olUTM-00Dn70-AD;
        Thu, 20 Oct 2022 14:16:28 +0200
Message-ID: <825ad7f9-7f8b-9670-afdf-91df0ead8773@norik.com>
Date:   Thu, 20 Oct 2022 14:16:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 0/3] Suspending i.MX watchdog in WAIT mode
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-watchdog@vger.kernel.org
Cc:     shawnguo@kernel.org, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-imx@nxp.com, festevam@gmail.com,
        kernel@pengutronix.de, s.hauer@pengutronix.de,
        wim@linux-watchdog.org, robh+dt@kernel.org
References: <20221019111714.1953262-1-andrej.picej@norik.com>
 <5bf984f4-681c-7001-281f-f35bb7fdfc8b@linaro.org>
 <7b3bc437-6b92-4691-fd95-08e408b1c962@norik.com>
 <77b2cb61-2a31-39aa-69fe-a323a5e91b8d@linaro.org>
From:   Andrej Picej <andrej.picej@norik.com>
In-Reply-To: <77b2cb61-2a31-39aa-69fe-a323a5e91b8d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20. 10. 22 14:04, Krzysztof Kozlowski wrote:
> On 20/10/2022 01:49, Andrej Picej wrote:
>> Hi Krzysztof,
>>
>> On 19. 10. 22 17:46, Krzysztof Kozlowski wrote:
>>> On 19/10/2022 07:17, Andrej Picej wrote:
>>>> The i.MX6 watchdog can't be stopped once started. This means that
>>>> special hardware suspend needs to be configured when the device enters
>>>> low-power modes.
>>>> Usually i.MX devices have two bits which deal with this:
>>>> - WDZST bit disables the timer in "deeper" low power modes and
>>>> - WDW bit disables the timer in "WAIT" mode which corresponds with
>>>> Linux's "freeze" low-power mode.
>>>>
>>>> WDZST bit support is already in place since 1a9c5efa576e ("watchdog: imx2_wdt: disable watchdog timer during low power mode").
>>>> WDW bit is not common for all imx2-wdt supported devices, therefore use
>>>> a new device-tree property "fsl,suspend-in-wait" which suspends the
>>>> watchdog in "WAIT" mode.
>>>>
>>>> Andrej Picej (3):
>>>>     watchdog: imx2_wdg: suspend watchdog in WAIT mode
>>>>     dt-bindings: watchdog: fsl-imx: document suspend in wait mode
>>>>     ARM: dts: imx6ul/ull: suspend i.MX6UL watchdog in wait mode
>>>>
>>>>    .../devicetree/bindings/watchdog/fsl-imx-wdt.yaml          | 5 +++++
>>>
>>> Please use scripts/get_maintainers.pl to get a list of necessary people
>>> and lists to CC.  It might happen, that command when run on an older
>>> kernel, gives you outdated entries.  Therefore please be sure you base
>>> your patches on recent Linux kernel.
>>
>> I thought I did. I run that script on linux-watchdog.git, master branch.
>> I thought I should base my patches meant for watchdog subsystem there?
> 
> Maintainer's tree should be fine, but then the issue is somewhere else,
> because your CC list was not complete.
> 

Ok I see that two email addresses were not added. Sorry for that. I will 
make sure that the CC list is complete next time.

Thanks,
Andrej
