Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9261D706C92
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjEQPXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjEQPXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:23:36 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8871FEB;
        Wed, 17 May 2023 08:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684337015; x=1715873015;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x3HywKEO5SlEh8RBttF9/yC/oF5FRqtOb660S3ftba4=;
  b=AruQl0yZ8FWTOc3McgvL9RunB8/CzKXpAMc0Uq9vfJOn1aXMmv0HEZ0x
   Awpky197FIEp+aDj0MM3gKmAxUCNvR+qhMAoMfcdQgpvIzYjvjN0pjv4t
   lrcop4d2rsWZ+LqRAgQNk5Rh4HAir5Sofn4PmuA2F65hNdcAZ2Tj9ZPbh
   0BQs7TD3KE70Fi/Xk405ZTvXHyomQSR0mS1I3FBVV2089NcLU6fDhgbzN
   7djbTNDpegzeu9pdyoWfse7irgG/zS+jEYs4RlHEVPfI8QU5817gUpZyu
   785tVP3hkIAK3m1i5WCRDr/9VOnJSOMZIE8rNuL0nAYgaE0fYbIn820H2
   A==;
X-IronPort-AV: E=Sophos;i="5.99,282,1677567600"; 
   d="scan'208";a="215915236"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 May 2023 08:23:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 17 May 2023 08:23:09 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Wed, 17 May 2023 08:23:07 -0700
Message-ID: <ef188e83-07e6-102a-9cb6-3966ab31fe79@microchip.com>
Date:   Wed, 17 May 2023 17:22:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: dts: microchip: add missing cache properties
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230421223155.115339-1-krzysztof.kozlowski@linaro.org>
 <151169f7-dcdb-47f1-9616-67c3c388a233@linaro.org>
 <7772a5981d9a3d46056a53997162d1d75d22a701.camel@microchip.com>
 <41c72642-7d46-d7d1-d49a-6bef685f934c@linaro.org>
 <20230517-crop-limeade-73369ac8594d@wendy>
 <67bf21d4cf9573233fc8154ae73b966adba6df09.camel@microchip.com>
 <20230517-revivable-scuba-dc7ece33723c@wendy>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20230517-revivable-scuba-dc7ece33723c@wendy>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2023 at 14:58, Conor Dooley wrote:
> On Wed, May 17, 2023 at 02:46:38PM +0200, Steen Hegelund wrote:
>> On Wed, 2023-05-17 at 13:37 +0100, Conor Dooley wrote:
>>> On Wed, May 17, 2023 at 02:10:53PM +0200, Krzysztof Kozlowski wrote:
> 
>>>> For future (and all previous patches), please think what do you
>>>> (you=Microchip) want to do with it. If you do not handle the patches,
>>>> then someone should or the platform should be marked as "Odd fixes".
>>>
>>> If noone is set up to actually be the maintainer of the tree, and the
>>> patch volume is low, it might be a good idea to combine its maintenance
>>> with some of the other microchip trees.
>>>
>>> I've added Nicolas to CC here, since he is the main maintainer for the
>>> 32-bit ARM Microchip stuff. For some context, I maintain the RISC-V
>>> Microchip bits and a few other things like dt-bindings and some
>>> non-microchip RISC-V platforms.
>>>
>>> If you like, I could easily pick up patches for
>>> arch/arm64/boot/dts/microchip/* as I am already sending PRs to Arnd for
>>> other trees and another branch would not be much overhead!
>>>
>>> Clearly I do not know the hardware at all, and reviewing the patches
>>> would still be up to you, but I could handle the "administrative" side
>>> of things (applying the patches & sending PRs) if that would be helpful?
>>>
>>> Otherwise, Nicolas & I could probably help you through setting things up
>>> to send PRs without taking up Krzysztof's time?
>>>
>>> Either works for me!
>>
>> It would be preferable for me if you (Conor) would handle the
>> arch/arm64/boot/dts/microchip/* tree as you suggested.  It is not often we
>> update it, so it will hopefully be low overhead for you.
> 
> Okay. I will send a patch for MAINTAINERS then - although I'll give
> Nicolas a change to look at it this thread first ;)

Yes, sure thing that I can be added as maintainer of the arm64 part of 
Microchip, you can add me to a MAINTAINERS entry taking care of this and 
use our group git tree for this purpose, we'll add branches for that.

> If the mpu32 guys ever decide to become mpu64 then we can perhaps
> re-visit things.
> 
>> Thanks to both of you for the assistance.
 >
> No worries chief.

Thanks Conor for the heads-up. Best regards,
   Nicolas

-- 
Nicolas Ferre

