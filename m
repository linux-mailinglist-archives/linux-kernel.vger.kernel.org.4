Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4D0680542
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 05:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235766AbjA3Etr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 23:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235685AbjA3EtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 23:49:09 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3751CCC18;
        Sun, 29 Jan 2023 20:48:59 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 30 Jan 2023 13:48:57 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id EA8022086DE8;
        Mon, 30 Jan 2023 13:48:57 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 30 Jan 2023 13:48:54 +0900
Received: from [10.212.156.20] (unknown [10.212.156.20])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 83A73A855D;
        Mon, 30 Jan 2023 13:48:57 +0900 (JST)
Message-ID: <69c26585-a5b7-5c94-a64c-2ba95c14ea82@socionext.com>
Date:   Mon, 30 Jan 2023 13:48:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/5] mmc: uniphier-sd: Add UHS mode support
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230125010201.28246-1-hayashi.kunihiko@socionext.com>
 <CAPDyKFreuJhwsw3ECvhW+rdM9pouja8wttsRntbwvUR-5haPHw@mail.gmail.com>
Content-Language: en-US
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <CAPDyKFreuJhwsw3ECvhW+rdM9pouja8wttsRntbwvUR-5haPHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

On 2023/01/27 19:57, Ulf Hansson wrote:
> On Wed, 25 Jan 2023 at 02:02, Kunihiko Hayashi
> <hayashi.kunihiko@socionext.com> wrote:
>>
>> The uniphier-sd controller needs to control some siginals from the SD
>> interface logic to transition to UHS mode.
>>
>> This series adds UHS mode support to the controller driver
>> to refer to and control the interface logic registers, which include
>> mode selector and SDR speed selector.
>>
>> Kunihiko Hayashi (5):
>>    dt-bindings: mmc: uniphier-sd: Add socionext,syscon-uhs-mode property
>>    mmc: uniphier-sd: Add control of UHS mode using SD interface logic
>>    mmc: uniphier-sd: Add control to switch UHS speed
>>    ARM: dts: uniphier: Add syscon-uhs-mode to SD node
>>    arm64: dts: uniphier: Add syscon-uhs-mode to SD node
>>
>>   .../bindings/mmc/socionext,uniphier-sd.yaml   | 10 +++
>>   arch/arm/boot/dts/uniphier-ld4.dtsi           |  3 +-
>>   arch/arm/boot/dts/uniphier-pro4.dtsi          |  3 +-
>>   arch/arm/boot/dts/uniphier-pro5.dtsi          |  3 +-
>>   arch/arm/boot/dts/uniphier-pxs2.dtsi          |  3 +-
>>   arch/arm/boot/dts/uniphier-sld8.dtsi          |  3 +-
>>   .../boot/dts/socionext/uniphier-ld20.dtsi     |  3 +-
>>   .../boot/dts/socionext/uniphier-pxs3.dtsi     |  3 +-
>>   drivers/mmc/host/uniphier-sd.c                | 83 +++++++++++++++++--
>>   9 files changed, 102 insertions(+), 12 deletions(-)
>>
> 
> Patch 1 to 3 applied for next (I fixed up the comments from Krzysztof
> when I applied), thanks!

Thank you for fixing up and applying. I'll send patch 4 and 5 (related to
the devicetree sources) as other requests for the SoC.

Thank you,

---
Best Regards
Kunihiko Hayashi
