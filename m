Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2500B6D84A6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 19:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjDEROW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 13:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjDEROU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 13:14:20 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B37A9B;
        Wed,  5 Apr 2023 10:14:19 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pk6i9-0003OV-71; Wed, 05 Apr 2023 19:14:17 +0200
Message-ID: <fdffc009-47cf-e88d-5b9e-d6301f7f73f2@leemhuis.info>
Date:   Wed, 5 Apr 2023 19:14:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/3] ARM: dts: meson: Fix the UART compatible strings
Content-Language: en-US, de-DE
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?Q?Ricardo_Ca=c3=b1uelo?= <ricardo.canuelo@collabora.com>
References: <20211227180026.4068352-1-martin.blumenstingl@googlemail.com>
 <20211227180026.4068352-2-martin.blumenstingl@googlemail.com>
 <20230405132900.ci35xji3xbb3igar@rcn-XPS-13-9305>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20230405132900.ci35xji3xbb3igar@rcn-XPS-13-9305>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1680714859;c2d3ee1d;
X-HE-SMSGID: 1pk6i9-0003OV-71
X-Spam-Status: No, score=-1.4 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05.04.23 15:29, Ricardo Cañuelo wrote:
> Hi Martin,
> 
> On lun 27-12-2021 19:00:24, Martin Blumenstingl wrote:
>> The dt-bindings for the UART controller only allow the following values
>> for Meson6 SoCs:
>> - "amlogic,meson6-uart", "amlogic,meson-ao-uart"
>> - "amlogic,meson6-uart"
>>
>> Use the correct fallback compatible string "amlogic,meson-ao-uart" for
>> AO UART. Drop the "amlogic,meson-uart" compatible string from the EE
>> domain UART controllers.
> 
> KernelCI detected that this patch introduced a regression in
> stable-rc/linux-4.14.y on a meson8b-odroidc1.
> After this patch was applied the tests running on this platform don't
> show any serial output.
> 
> This doesn't happen in other stable branches nor in mainline, but 4.14
> hasn't still reached EOL and it'd be good to find a fix.
> 
> Here's the bisection report:
> https://groups.io/g/kernelci-results/message/40147
> 
> KernelCI info:
> https://linux.kernelci.org/test/case/id/64234f7761021a30b262f776/

Wait, what? A patch (5225e1b87432 ("ARM: dts: meson: Fix the UART
compatible strings")) that was merged for v5.17-rc4 and is not in the
list of patches that were in 4.14.312-rc1
(https://lore.kernel.org/all/20230403140351.636471867@linuxfoundation.org/
) is meant to suddenly cause this? How is this possible? Am I totally on
the wrong track here and misunderstanding something, or is this a
bisection that went horribly sideways?

Ciao, Thorsten

> Test log:
> https://storage.kernelci.org/stable-rc/linux-4.14.y/v4.14.311-43-g88e481d604e9/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-meson8b-odroidc1.html
> 
> Thanks,
> Ricardo
> 
> #regzbot introduced: 5225e1b87432dcf0d0fc3440824b91d04c1d6cc1
> #regzbot title: no serial output in KernelCI tests on meson8b-odroidc1
> for stable-4.14
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
