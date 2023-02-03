Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12F26898E0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 13:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbjBCMfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 07:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbjBCMfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 07:35:11 -0500
X-Greylist: delayed 2487 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 03 Feb 2023 04:34:55 PST
Received: from wp126.webpack.hosteurope.de (wp126.webpack.hosteurope.de [80.237.132.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8062279D;
        Fri,  3 Feb 2023 04:34:54 -0800 (PST)
Received: from p5098d998.dip0.t-ipconnect.de ([80.152.217.152] helo=hermes.fivetechno.de); authenticated
        by wp126.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1pNudA-0000Ie-1R; Fri, 03 Feb 2023 12:53:24 +0100
X-Virus-Scanned: by amavisd-new 2.12.2 using newest ClamAV at
        linuxbbg.five-lan.de
Received: from [192.168.34.144] (p5098d998.dip0.t-ipconnect.de [80.152.217.152])
        (authenticated bits=0)
        by hermes.fivetechno.de (8.15.2/8.16.1/SUSE Linux 0.8) with ESMTPSA id 313BrLdN012523
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 3 Feb 2023 12:53:22 +0100
Message-ID: <f66f01d0-372a-1c22-3005-9c5bc65d8fa5@fivetechno.de>
Date:   Fri, 3 Feb 2023 12:53:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 5/9] ARM: dts: exynos: move exynos-bus nodes out of soc in
 Exynos4412
Content-Language: de-DE
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     replicant@osuosl.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?Q?Martin_J=c3=bccker?= <martin.juecker@gmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        Chanwoo Choi <cw00.choi@samsung.com>
References: <20230125094513.155063-1-krzysztof.kozlowski@linaro.org>
 <20230125094513.155063-5-krzysztof.kozlowski@linaro.org>
 <CGME20230129104220eucas1p15b70f73be86fa5600cfe170d22869836@eucas1p1.samsung.com>
 <29841f64-360b-1426-e1fd-dd4c64ee5455@linaro.org>
 <b3f31e71-fa1a-e0c0-fdfa-f65674ccc5cd@samsung.com>
From:   Markus Reichl <m.reichl@fivetechno.de>
Organization: five technologies GmbH
In-Reply-To: <b3f31e71-fa1a-e0c0-fdfa-f65674ccc5cd@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;m.reichl@fivetechno.de;1675427695;5089a882;
X-HE-SMSGID: 1pNudA-0000Ie-1R
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

Am 03.02.23 um 12:45 schrieb Marek Szyprowski:
> Hi Krzysztof,
> 
> On 29.01.2023 11:42, Krzysztof Kozlowski wrote:
>> On 25/01/2023 10:45, Krzysztof Kozlowski wrote:
>>> The soc node is supposed to have only device nodes with MMIO addresses,
>>> as reported by dtc W=1:
>>>
>>>    exynos4412.dtsi:407.20-413.5:
>>>      Warning (simple_bus_reg): /soc/bus-acp: missing or empty reg/ranges property
>>>
>>> and dtbs_check:
>>>
>>>    exynos4412-i9300.dtb: soc: bus-acp:
>>>      {'compatible': ['samsung,exynos-bus'], 'clocks': [[7, 456]], 'clock-names': ['bus'], 'operating-points-v2': [[132]], 'status': ['okay'], 'devfreq': [[117]]} should not be valid under {'type': 'object'}
>>>
>>> Move the bus nodes and their OPP tables out of SoC to fix this.
>>> Re-order them alphabetically while moving and put some of the OPP tables
>>> in device nodes (if they are not shared).
>>>
>> Applied.
> 
> I don't have a good news. It looks that this change is responsible for
> breaking boards that were rock-stable so far, like Odroid U3. I didn't
> manage to analyze what exactly causes the issue, but it looks that the
> exynos-bus devfreq driver somehow depends on the order of the nodes:
> 
> (before)
> 
> # dmesg | grep exynos-bus
> [    6.415266] exynos-bus: new bus device registered: soc:bus-dmc
> (100000 KHz ~ 400000 KHz)
> [    6.422717] exynos-bus: new bus device registered: soc:bus-acp
> (100000 KHz ~ 267000 KHz)
> [    6.454323] exynos-bus: new bus device registered: soc:bus-c2c
> (100000 KHz ~ 400000 KHz)
> [    6.489944] exynos-bus: new bus device registered: soc:bus-leftbus
> (100000 KHz ~ 200000 KHz)
> [    6.493990] exynos-bus: new bus device registered: soc:bus-rightbus
> (100000 KHz ~ 200000 KHz)
> [    6.494612] exynos-bus: new bus device registered: soc:bus-display
> (160000 KHz ~ 200000 KHz)
> [    6.494932] exynos-bus: new bus device registered: soc:bus-fsys
> (100000 KHz ~ 134000 KHz)
> [    6.495246] exynos-bus: new bus device registered: soc:bus-peri (
> 50000 KHz ~ 100000 KHz)
> [    6.495577] exynos-bus: new bus device registered: soc:bus-mfc
> (100000 KHz ~ 200000 KHz)
> 
> (after)
> 
> # dmesg | grep exynos-bus
> 
> [    6.082032] exynos-bus: new bus device registered: bus-dmc (100000
> KHz ~ 400000 KHz)
> [    6.122726] exynos-bus: new bus device registered: bus-leftbus
> (100000 KHz ~ 200000 KHz)
> [    6.146705] exynos-bus: new bus device registered: bus-mfc (100000
> KHz ~ 200000 KHz)
> [    6.181632] exynos-bus: new bus device registered: bus-peri ( 50000
> KHz ~ 100000 KHz)
> [    6.204770] exynos-bus: new bus device registered: bus-rightbus
> (100000 KHz ~ 200000 KHz)
> [    6.211087] exynos-bus: new bus device registered: bus-acp (100000
> KHz ~ 267000 KHz)
> [    6.216936] exynos-bus: new bus device registered: bus-c2c (100000
> KHz ~ 400000 KHz)
> [    6.225748] exynos-bus: new bus device registered: bus-display
> (160000 KHz ~ 200000 KHz)
> [    6.242978] exynos-bus: new bus device registered: bus-fsys (100000
> KHz ~ 134000 KHz)
> 
> This is definitely a driver bug, but so far it worked fine, so this is a
> regression that need to be addressed somehow...
> 
> Best regards

the exynos-bus devfreq driver is not so solid on exynos-4412-boards.
On my 24/7 odroid-x2 I need
echo performance > /sys/class/devfreq/soc:bus-leftbus/governor
to avoid random hangs.

Gruß,
-- 
Markus Reichl
