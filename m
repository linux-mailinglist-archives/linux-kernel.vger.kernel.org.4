Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE4E6DA3AD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239801AbjDFUmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240337AbjDFUla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:41:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5DFB45D;
        Thu,  6 Apr 2023 13:38:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC10860F77;
        Thu,  6 Apr 2023 20:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9211FC433D2;
        Thu,  6 Apr 2023 20:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680813488;
        bh=3Cznac5B+3sy6hB9DB3/iijT0kNRLGM0krGAPHIjwzU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XFJOGBaUci1k2qda+64OPr7W9hnUOcTeNhu8CRqtWNtPwUevBZwT16jGG3OVwhyt6
         AuNgxgN1jYEMc5w6gdtT9yJkiZucj+V/TNA30stBeFypoEk7ngGvA6hqr02fwi5Aez
         GHIbpj6mPZOr3k79jsZDKz8U4hCkRCsxNRrSyrRO+wsrPoD+BVL8nkL8cgyQi8KOCn
         dERdf/af6ZVxFtDuA+E7sSDkjuZjomZO80b6DxcjawKGW1SgxcO7nPGGFoR+oMlhid
         NBMfqT6f5zCbIiEtVmuoanCXWzgnXbMAvqboU/k95P4EGkmZtrMa7LljcY1ea7YzzI
         TCri2M0SRZ1vg==
Message-ID: <8353399f-c6de-8da7-78f1-d6a558c462d0@kernel.org>
Date:   Thu, 6 Apr 2023 22:38:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V2 3/3] ARM: dts: imx6ull-dhcor: Add Marantec maveo box
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        kernel <kernel@dh-electronics.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230406154900.6423-1-cniedermaier@dh-electronics.com>
 <20230406154900.6423-3-cniedermaier@dh-electronics.com>
 <5478133e-7772-1db9-3473-1ec86fa2aae2@linaro.org>
 <a7fcfe695623491da96639079eb14c8f@dh-electronics.com>
 <f6c8586f-a5d1-875f-b2c0-7871112cf1b1@linaro.org>
 <ff95314402a349a5a2998c1b5e2b13a2@dh-electronics.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <ff95314402a349a5a2998c1b5e2b13a2@dh-electronics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 21:57, Christoph Niedermaier wrote:
>>>>> +     aliases {
>>>>> +             /delete-property/ mmc0; /* Avoid double definitions */
>>>>
>>>> I don't understand it. What is "double definition" of aliases?
>>>
>>> Otherwise I end up like this:
>>> mmc0 = &usdhc1;
>>> mmc1 = &usdhc2;
>>> mmc2 = &usdhc2;
>>>
>>> Is "Ensure unique allocation" a better comment here?
>>>
>>>>
>>>>> +             /delete-property/ mmc1;
>>>>> +             mmc2 = &usdhc2; /* eMMC should be mmc2 */
>>>>
>>>> Why? How is this labeled on the board (physically or on schematics)? If
>>>> you answer here "for booting", then the answer is NAK. Don't add
>>>> software policies to Devicetree.
>>>
>>> The name in the schematics is "SD2".
>>
>> Answering also to above - then likely the aliases should be dropped from
>> SoM. I doubt that Som calls it SD1 and your board SD2...
> 
> Maybe I don't quite get it, but the hardware starts counting at 1. The first
> interface is SD1 and it is used as WiFi. The second one is SD2 which is the
> eMMC. So with this aliases it should match SD2 to mmc2.
> Do you want me to delete the aliases in the include file "imx6ull-dhcor-som.dtsi"

Yes, because it incorrectly calls eMMC as mmc1. You said it is SD2, right?


Best regards,
Krzysztof

