Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6739A6D863A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 20:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjDESqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 14:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbjDESqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 14:46:40 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21156728A;
        Wed,  5 Apr 2023 11:46:39 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id E9A8285D8B;
        Wed,  5 Apr 2023 20:46:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1680720395;
        bh=BethWdbii02lOCXjgcipdByPmIeSpA03KMZKeFipjH0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rcjXNTtjCAOl/pjPBaBw4rkDPtPiIAQMzGYd0xhSDspKIkk8FcxT0qtlEmCUQugiT
         soazzqtNzq2hBCDnxNAMp15gXj6H3nEkOsG7jqbByg1PAuTu3wHTlGF9jD9XESYFO8
         u0hKgkD98zmPuUJ5CPKoAW7QQa4i2C08inYxdEzeO4rCz8hOIwTdBPL4X/4cdNZ8h7
         qlvyNV5HTaC5wX8rae6WLlrp5eJAvSOrjuOhA71EW6YIklEJYKX7IPzoBp11xDy7g4
         GtU5f+UoS3fLjZ0aAskNharw0BC2WiDXrb54OZZ1AYI+uMQYbC5mnW/44fYBJb5hmy
         qI1qyfot8aOGw==
Message-ID: <42737c19-698f-8cc8-45b2-8ff08a274f87@denx.de>
Date:   Wed, 5 Apr 2023 20:46:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] ARM: dts: imx6ull-dhcor: Add Marantec maveo box
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
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <e7aa3b3220e148ee96f5a1c361721845@dh-electronics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-3.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/23 20:24, Christoph Niedermaier wrote:
> From: Marek Vasut [mailto:marex@denx.de]
> Sent: Wednesday, April 5, 2023 6:25 PM
>> On 4/5/23 18:02, Christoph Niedermaier wrote:
>>
>> [...]
>>
>>> +/ {
>>> +     model = "DH electronics i.MX6ULL DHCOR on maveo box";
>>> +     compatible = "dh,imx6ull-dhcor-maveo-box", "dh,imx6ull-dhcor-som",
>>> +                  "fsl,imx6ull";
>>> +
>>> +     aliases {
>>> +             /delete-property/ mmc0; /* Avoid double definitions */
>>> +             /delete-property/ mmc1;
>>> +             mmc2 = &usdhc2; /* eMMC should be mmc2 */
>>
>> Why not mmc0 ?
>>
>> Use root=PARTUUID= when booting to avoid any dependency on
>> root=/dev/mmcblk2pN enumeration.
> 
> This is due to software interchangeability with the DHCOM
> i.MX6ULL, where the eMMC is always mmc2.

+CC Ulf , I vaguely recall some discussion about this enumeration and I 
am not sure one can really depend on that.
