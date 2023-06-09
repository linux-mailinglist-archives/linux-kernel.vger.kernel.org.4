Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA1A7296AB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241254AbjFIKSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240000AbjFIKRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:17:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F98E2;
        Fri,  9 Jun 2023 03:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686305371; x=1717841371;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sZ+d+XIo8jNJHOQCGSyieJm0cQ0k+03KYRr/z3ZTOCg=;
  b=ND9ROcZOVQDjghWgmrSXJ96WpcpDo/wtff5EhnMlcxVW+9bHAMqgQktw
   SPNBH4CIgmCafgl/tissT0jbXpnpzD6bvVjA0ir2YyRu1R+vBDkuNiaaT
   ctINMQmEQIWqc9BHpCb3z+Kh/umEN/aBF6HBlLXunyBnd0JJLHluKi6I1
   JMVO/H1H8VUfE0awHd+tDsdOOAJU/vX0l+HVvySi/SDDTpi0BZ58PYVM+
   XfRFI/2Ud5HEmthM4+xdl/HXwVRgjkbv4Z3ZmsTqCrxvm5BI06TL6FZRp
   T+iFDu5r24KVWKN0eFOWXoiiiI+X/NwjiVzwvAZkCIRG4fUEV/jNEL/0P
   w==;
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="215332293"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2023 03:09:28 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 9 Jun 2023 03:09:27 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Fri, 9 Jun 2023 03:09:25 -0700
Message-ID: <82f1d66a-b8cf-69bd-4783-e2c867c11828@microchip.com>
Date:   Fri, 9 Jun 2023 12:09:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/4] dt-bindings: power: reset: atmel,sama5d2-shdwc:
 convert to yaml
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>
CC:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <alexandre.belloni@bootlin.com>, <sre@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20230524123528.439082-1-claudiu.beznea@microchip.com>
 <20230524123528.439082-4-claudiu.beznea@microchip.com>
 <20230524-blizzard-hunting-4da815e634e2@spud>
 <20230607204351.GA3984668-robh@kernel.org>
 <20230607-refute-acrobat-3b3f645da71b@spud>
 <CAL_JsqLyLs3Vfsd8LRd5_dUbzjE9LgMNnWa+8uP88Ab+E1oLfw@mail.gmail.com>
 <20230608-tiptop-unfold-66c4b8f4e620@spud>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20230608-tiptop-unfold-66c4b8f4e620@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2023 at 18:49, Conor Dooley wrote:
> 
> On Thu, Jun 08, 2023 at 08:38:10AM -0600, Rob Herring wrote:
> 
>> For reference, anything done by Arm, Linaro or NVIDIA employees is
>> okay to relicense to dual license.
> Ah cool, that's good to know, thanks.
> Perhaps I should try to get a similar edict issued for Microchip ones.
> @Nicolas, does that sound reasonable?

Well, we can work it out internally, indeed. But is there a public 
statement about this somewhere?

Regards,
   Nicolas
-- 
Nicolas Ferre

