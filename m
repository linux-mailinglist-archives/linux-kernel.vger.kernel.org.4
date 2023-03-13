Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C2C6B74D5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 11:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjCMK5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 06:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjCMK5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:57:20 -0400
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB6658494;
        Mon, 13 Mar 2023 03:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1678705036;
        bh=IPc5NyxVVTlDZKlelVa22MZ0Y0RkYiQXIKb0cIaOS7I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gvQ3iNJHZ0GUNQeKO4kUbl5xLLp27lLhIUPr0UB3ZqKm5PnzyGEzpjCIdpUN7hdTq
         uG5N06rwWnpLvvTLOuHpwp15flbm7wA8PsUnhffZ8d2Ua9+doyKPwvO4JyrJxStUnQ
         RtmjSiMIXW+emOzz54ce1H0hmoLCYmjYWh2nCZKI=
Received: from [10.0.29.154] (unknown [10.0.29.154])
        by uho.ysoft.cz (Postfix) with ESMTP id EBA95A0522;
        Mon, 13 Mar 2023 11:57:15 +0100 (CET)
Message-ID: <028f0434-eb66-2481-9576-5d6c312eb81a@ysoft.com>
Date:   Mon, 13 Mar 2023 11:57:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/6] ARM: dts: imx6dl-yapp4: Change LED channel names
 according to dt-binding
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230210154855.3086900-1-michal.vokac@ysoft.com>
 <20230210154855.3086900-3-michal.vokac@ysoft.com>
 <20230313082834.GO143566@dragon>
 <ea652d10-d910-40d8-9eae-39f2ba722466@linaro.org>
Content-Language: en-US
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
In-Reply-To: <ea652d10-d910-40d8-9eae-39f2ba722466@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13. 03. 23 9:48, Krzysztof Kozlowski wrote:
> On 13/03/2023 09:28, Shawn Guo wrote:
>> On Fri, Feb 10, 2023 at 04:48:51PM +0100, Michal Vokáč wrote:
>>> The lp55xx LED controller binding was converted to schema and dtbs_check
>>> now complains:
>>>
>>>    led-controller@30: 'chan@0', 'chan@1', 'chan@2' do not match any of the regexes
>>>
>>> Use correct names to fix that.
>>>
>>> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
>>
>> It's been address as part of this commit:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4b0d1f2738899dbcc7a026d826373530019aa31b
>>
> 
> Which is mainline, so it raises the question on what old tree this was
> based on...

The whole series is based on v6.2-rc7-11-g05ecb680708a which was
linux-stable tree master branch from February 6th. I was not aware
of the referenced commit as it was merged later into v6.3-rc.

Good that it is fixed already, this patch can be skipped.
It is just unfortunate that I was not Cc'd back then.

Thanks,
Michal


