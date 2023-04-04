Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB246D5C75
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 11:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbjDDJ4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 05:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbjDDJ4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 05:56:16 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6B9269A;
        Tue,  4 Apr 2023 02:56:09 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 25B0C60017;
        Tue,  4 Apr 2023 09:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1680602167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gE5GYSD/Jv/st14bR6vIpX3+m96fdd5PsjXiDdC37SA=;
        b=Qb8y+NXnhI916wxrPrrocRr3unVcblsLe1mz0RJTB8FDeOtGM5RpElRsW3EMpEZcNmFpij
        COypw/LZJ8p5m+YGp7U5t4ulla6RC0QimLNAjJyCA0JZ6YmGv2ddXU3Jq76mcugf4H2vGD
        WNuty7fU80FH3BYiMguCG8r4eN7eosXb6YB1nboZmWf+LXC0t1Yir3Wv0jstl0o95uipHI
        1o86YUw6qcfFDcDNKeh0Y1a5wSeUoQ+zlNQO6Nq9oLbJIr93ps+xN7qIW2sFCNZnRc7C8o
        q30cJIJseTBNMq4+Pn6UEcZ1iulpbmK69QOOTvIHjgBtVejV71qcVpR365E1tw==
Date:   Tue, 4 Apr 2023 11:56:05 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>, a.zummo@towertech.it,
        jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org,
        Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
Subject: Re: [PATCH v5 2/2] dt-bindings: rtc: add max313xx RTCs
Message-ID: <202304040956056c59af98@mail.local>
References: <20230403154342.3108-1-Ibrahim.Tilki@analog.com>
 <20230403154342.3108-3-Ibrahim.Tilki@analog.com>
 <dd6f0842-519f-1bc9-f7f5-459863dc3dcd@linaro.org>
 <202304040710049c9cc01a@mail.local>
 <996b49ab-5e2e-76bc-efb1-38c6384871f6@linaro.org>
 <2023040407444619bf5596@mail.local>
 <0fd972bd-c5e7-65cc-6992-09c4c3e88f95@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fd972bd-c5e7-65cc-6992-09c4c3e88f95@linaro.org>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2023 10:14:33+0200, Krzysztof Kozlowski wrote:
> On 04/04/2023 09:44, Alexandre Belloni wrote:
> >>
> >>> charging will always
> >>> enable a diode, select a resistor and then have or not an extra diode.
> >>> Figure2 of the MAX31329 datasheet is great.
> >>
> >> So the diode is in the max313xx? Then why enabling it is a property of
> >> DT? Either this should be inferred from compatible or is even a policy,
> >> not a DT property. Just because device has a register for something, is
> >> not an argument that "something" should be in DT.
> > 
> > Well, it depends on the battery that is installed on the board so it
> > makes sense to have it in DT.
> 
> OK, that would be a good reason, but I wonder why? Why choosing diode or
> not depends on the battery? Wouldn't you always want to have the diode?
> 

It limits the maximum current used to charge the battery or supercap to
not exceed what is allowed.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
