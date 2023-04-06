Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C108D6D9934
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238971AbjDFOLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239055AbjDFOKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:10:54 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C28BB456;
        Thu,  6 Apr 2023 07:10:21 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 6AEF885FC3;
        Thu,  6 Apr 2023 16:10:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1680790218;
        bh=s6xuCqJPjrHfzij4jwuDcUSO2ximmQ324zKXo9GQvHE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VK1shHpnqs3RLPmS1V5Z8CYYekbMhPAyORPpmfk18+AwI8ZUN8vHBVCrjyCIZOYRj
         tEw4W0N9dDXJr0c17g8EzshcVfDFihvI3yWj4QGOCi4bPF/A1kezhEDsUB00fvFfHa
         PX4g5rjINTR6L3ajm/2VVGs41UJCy5E2a4W9R8juNFeKeBwo6CYRCaEJJ8eDfXrFtp
         2XY6DBsbhWJSMt5Nntpn3e3xvGit9KVm4MUK3uAVr3f0hxCcS/ON7XOGprcidsSTFl
         jayB8ejcyOsL86RctaoTpyZ/GN5VupNf011CDyVJcj79lRHXAKF0RFkdQKrk7CEcBK
         Ba79x/PybLb7Q==
Message-ID: <50c88cc4-e046-6c43-2d35-116d1d4ea2f8@denx.de>
Date:   Thu, 6 Apr 2023 16:10:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] ARM: dts: imx6ull-dhcor: Add Marantec maveo box
Content-Language: en-US
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        kernel <kernel@dh-electronics.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20230405160258.46998-1-cniedermaier@dh-electronics.com>
 <20230405160258.46998-2-cniedermaier@dh-electronics.com>
 <05fa147c-116b-59b4-d14b-760bbefd7602@denx.de>
 <e7aa3b3220e148ee96f5a1c361721845@dh-electronics.com>
 <42737c19-698f-8cc8-45b2-8ff08a274f87@denx.de>
 <531df359744f4bdb9fd34eafc864d2bc@dh-electronics.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <531df359744f4bdb9fd34eafc864d2bc@dh-electronics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/23 10:37, Christoph Niedermaier wrote:
> From: Marek Vasut [mailto:marex@denx.de]
> Sent: Wednesday, April 5, 2023 8:47 PM
>> On 4/5/23 20:24, Christoph Niedermaier wrote:
>>> From: Marek Vasut [mailto:marex@denx.de]
>>> Sent: Wednesday, April 5, 2023 6:25 PM
>>>> On 4/5/23 18:02, Christoph Niedermaier wrote:
>>>>
>>>> [...]
>>>>
>>>>> +/ {
>>>>> +     model = "DH electronics i.MX6ULL DHCOR on maveo box";
>>>>> +     compatible = "dh,imx6ull-dhcor-maveo-box", "dh,imx6ull-dhcor-som",
>>>>> +                  "fsl,imx6ull";
>>>>> +
>>>>> +     aliases {
>>>>> +             /delete-property/ mmc0; /* Avoid double definitions */
>>>>> +             /delete-property/ mmc1;
>>>>> +             mmc2 = &usdhc2; /* eMMC should be mmc2 */
>>>>
>>>> Why not mmc0 ?
>>>>
>>>> Use root=PARTUUID= when booting to avoid any dependency on
>>>> root=/dev/mmcblk2pN enumeration.
>>>
>>> This is due to software interchangeability with the DHCOM
>>> i.MX6ULL, where the eMMC is always mmc2.
>>
>> +CC Ulf , I vaguely recall some discussion about this enumeration and I
>> am not sure one can really depend on that.
> 
> That why I think it good to have a defined number for mmcblk devices
> on an embedded system. An excerpt from [1]:

I might be misremembering this, but could it be that, if any non-OF 
SDMMC controller probes early and hogs the /dev/mmcblk2 before the OF 
ones have a chance to probe, then the OF ones would fail to probe ?

> Alternative solutions like PARTUUIDs do not cover the case where multiple
> mmcblk devices contain the same image.

I agree, this is indeed a downside of PARTUUID .

> This is a common issue on devices
> that can boot both from eMMC (for regular boot) and SD cards (as a
> temporary boot medium for development). When a firmware image is
> installed to eMMC after a test boot via SD card, there will be no
> reliable way to refer to a specific device using (PART)UUIDs oder
> LABELs

This can be solved by the installer updating the PARTUUID on the eMMC 
however.

> [1] https://patchwork.kernel.org/project/linux-mmc/patch/20200825134441.17537-2-matthias.schiffer@ew.tq-group.com/
> 
> So far I have never had a problem with numbering mmcblk devices via aliases.

Based on the above, I don't think either the aliases or PARTUUID is a 
perfect solution, but the aliases should be fine for mx6ull at least?
So I think we can conclude this discussion thread ?
