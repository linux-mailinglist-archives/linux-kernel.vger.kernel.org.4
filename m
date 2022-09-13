Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1A95B6923
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 10:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbiIMIAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 04:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiIMIAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 04:00:12 -0400
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EBE240B7;
        Tue, 13 Sep 2022 01:00:10 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 8F3B7135F;
        Tue, 13 Sep 2022 10:00:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1663056008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yVtB/VJEfqHZoKPwgwxIul/sPitJMz3rz7VeLQrdCpk=;
        b=O8jLzS5Gmcb8l6dbfs+w/rpJXtZ/yp2o/NXEZIkfR3M43rISCrVAp0+S0sGE20Npg1KUWp
        9PW2Rv3L6Ux6Wzf4IC0DJILnCi3+NrKbmvia517IsaYsoqnBQzBMVXoF1ZOV5+TVd4S0pC
        lBiLgqnlP8RPykM/rpIp2hWVmMzERr52IsC8r5SPPUPUHNqhiAXAX0P8o9KnTbig1cnXO9
        iXfGstMhkzx+ANdS8AOO55NwER9t0f6S046TKu6rgyeIjEqlKwhFPMunTqkY0r97pCVtho
        +o4MbS+lmedILV8wt9krA8FCWF08nr0ITFK8xYij3kySvXJMnxXUfxAkcKc+VQ==
MIME-Version: 1.0
Date:   Tue, 13 Sep 2022 10:00:08 +0200
From:   Michael Walle <michael@walle.cc>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        claudiu.beznea@microchip.com, nicolas.ferre@microchip.com
Subject: Re: [PATCH] ARM: dts: lan966x: Fix the interrupt number for internal
 PHYs
In-Reply-To: <20220913075719.y63uvvwzquk435ht@soft-dev3-1.localhost>
References: <20220912192629.461452-1-horatiu.vultur@microchip.com>
 <caf34bf663601404df4021bc14297eeb@walle.cc>
 <20220913075719.y63uvvwzquk435ht@soft-dev3-1.localhost>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <1f9ea2607ea1d8e0d4a2530a4c7dab41@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-09-13 09:57, schrieb Horatiu Vultur:
>> Accoring to Table 3-155: Shared Peripheral Interrupts
>> There are ID47 and ID48 listed as "MIIM controller 0 interrupt".
>> Whatever that is, because the internal PHYs are on MIIM
>> controller 1.
>> 
>> But 80 and 81 would be ID48 and ID49. Did you test the
>> interrupts?
> 
> Looking the same table (3-155) in the documentation that I have these
> interrupts correspond to ID112 and ID113 (Embedded CuPHY port 0/1 
> interrupt).
> And because these are shared peripheral interrupts, it is required to
> substract 32. Therefore I got the numbers 80 and 81.

Ahh, I need more coffee :) Yes you are right.

> As the internal PHYs don't have yet interrupt support, I have sent a
> patch here [1] and I have tested it with this.
> 
> [1] https://www.spinics.net/lists/kernel/msg4511731.html

Thanks for the pointer!

-michael
