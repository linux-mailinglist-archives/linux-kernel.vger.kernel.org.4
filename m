Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D567D6D23A9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 17:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbjCaPJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 11:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjCaPJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 11:09:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960B56A74;
        Fri, 31 Mar 2023 08:09:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3669AB83043;
        Fri, 31 Mar 2023 15:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6A6C433EF;
        Fri, 31 Mar 2023 15:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680275392;
        bh=BzyVhplOkvkyPf8g+Z7JN0QEIIvXTpOC0UO1K8zE1AE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GZGQG74HnqSoPCJk/nq3e5LxHLnGVw821BjLWe4EePmbQRysepMvPkvXIS093QPcA
         ZDP2iEZdGrVBXcfADLaUNUgojYvcguBtkXtZfW1bPPWnxADdHtfVpM8CfFbnoV4HhV
         gchwwMtJmArGQKBjziT54o7OUmfYyx4TkXU9mjhzbF5jzCv2T2SvwBVckbpomSvU+Z
         6dJp60tERkc92lcYSG5QTM54JgNF2mYhN/jzUjkr77X7UOuH7YGSSfiXWn51tSigZW
         4xVrdfLF2tnDcymOMO54yV7gFuivo31TS/OF7lKVEScsn7nQ5rRx+vsEOmFkx8i6h8
         SHxtHK3ZHPEqw==
Message-ID: <e0631f32-832c-94a1-196c-dbaf41a4e68c@kernel.org>
Date:   Sat, 1 Apr 2023 01:09:42 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V3 7/7] arm64: dts: imx8mp: add interconnect for hsio blk
 ctrl
Content-Language: en-US
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Cc:     peng.fan@nxp.com,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        abailon@baylibre.com, krzysztof.kozlowski+dt@linaro.org,
        festevam@gmail.com, abelvesa@kernel.org, marex@denx.de,
        paul.elder@ideasonboard.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, linux-pm@vger.kernel.org,
        s.hauer@pengutronix.de, robh+dt@kernel.org, aford173@gmail.com,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, djakov@kernel.org, shawnguo@kernel.org,
        l.stach@pengutronix.de
References: <20220703091451.1416264-8-peng.fan@oss.nxp.com>
 <20230327045037.593326-1-gerg@linux-m68k.org> <2678294.mvXUDI8C0e@steina-w>
 <b23a44ab-3666-8a41-d2a0-0d2fbdbd9f00@pengutronix.de>
 <ecd3a92b-ba1e-e7c1-088a-371bd1a2c100@linux-m68k.org>
 <20230328073302.jj64u5hvdpc6axa5@pengutronix.de>
 <426b4776-104c-cb47-c8cc-c26515fcb6e3@linux-m68k.org>
 <20230328134201.yaxrdtetjygkgkmz@pengutronix.de>
 <20230328135100.rbmnfelphe7juhxo@pengutronix.de>
 <c368a0f8-41f0-69ac-04f4-459e5fc8b9d6@linux-m68k.org>
 <20230328151100.msl46qupstwplkgw@pengutronix.de>
 <792028b9-cd4c-4ff4-a7cb-e60c518aa573@kernel.org>
 <2924b1a62f126678870160bdbbf4e5d51aceb8d4.camel@ew.tq-group.com>
 <809d5523-e0b4-cad4-f6ab-ddc0e4fe482d@pengutronix.de>
From:   Greg Ungerer <gerg@kernel.org>
In-Reply-To: <809d5523-e0b4-cad4-f6ab-ddc0e4fe482d@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/3/23 18:11, Ahmad Fatoum wrote:
> On 31.03.23 09:45, Markus Niebel wrote:
>> Am Freitag, dem 31.03.2023 um 15:55 +1000 schrieb Greg Ungerer:
>>> On 29/3/23 01:11, Marco Felsch wrote:
>>>> On 23-03-29, Greg Ungerer wrote:
>>> I agree this is the problem, I don't agree that the boot loader is
>>> the
>>> only place to fix this :-)  I should be able to generate a working
>>> devicetree
>>> blob from the kernel that is good, and ready to use no runtime
>>> changes
>>> required I figure.
>>>
>>
>> Just to point out: the approach of run time fixing in boot loader is
>> used for the other i.MX8M SOC, too. If you know exactly what SOC type
>> is assembled, you could disable non available IP in the board part of
>> your tree.
>>
>>> It is not overly difficult to break out the vpu nodes and have them
>>> only included when you have a board that has the iMX8MP-quad with the
>>> VPU hardware blocks.
> 
> This breaks out-of-tree DTs that include imx8mp.dtsi. Logic should be the
> other way round: imx8mp.dtsi is full-featured SoC and any new includes
> strip away, not add nodes.
> 
>> Depending on the SOC type there is more to look for than the VPU: core
>> count, ISP, NPU - just to mention a few. Current approach allows to
>> keep a single tree for all types.
> 
> +1.
> 
> @Greg, does your board always ship with an i.MX8MPLite? If so, just
> disable VPUs in your board DT.

Yes, it will only ever have the Lite. That is why I only want
to generate a devicetree blob without the VPU nodes.

Regards
Greg


> If it ships with either VPUs available or not and you don't want to do
> bootloader fixups, you may want to check out Kbuild's ability to apply
> DT overlays at build time. This would give you separate DTs for each
> variant while not having an extra file for every combination.
> 
> Cheers,
> Ahmad
> 
> 
>>
>> Regards, Markus
>>
> 
