Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2468E5B6899
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 09:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiIMHZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 03:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiIMHZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 03:25:01 -0400
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192B31183D;
        Tue, 13 Sep 2022 00:24:59 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id E92C91267;
        Tue, 13 Sep 2022 09:24:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1663053897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xYKen7ro0WeyWG0QGOSfe5xsMopHFLu2s8gOjMJQbWM=;
        b=epf8LMoDn0XR1iVdPbO0eBeQ1MQSM1rlVaFqP16xiiIiJudnbygCaeTl13U5FidSUn7PwN
        Vmlzftb2+JJOgTb8JXCenM6GMt/c1ir+C6ngMKZKAf2YMdkhkqK/P9g8QRarI5tmAF+Cpr
        jWWTthGXau0b35KXrZs708UUTujq3UfiTnGGDE9+CpaUMjZIR5Bje/sXcNR55f5Kl63Ufm
        EtnDwhVM915m5jPkgHTphmRNWxy8QYKbvj5dbKn2iTGbhjNO+ZcERNosbQUOXvu2noj1Ka
        /GrIs5HJBj4tq+Yn5RDxJE7znIEWSDU6f9u92MENNxwCN5cL59ep/yn3RiwQzw==
MIME-Version: 1.0
Date:   Tue, 13 Sep 2022 09:24:56 +0200
From:   Michael Walle <michael@walle.cc>
To:     Claudiu.Beznea@microchip.com
Cc:     Horatiu.Vultur@microchip.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Nicolas.Ferre@microchip.com
Subject: Re: [PATCH] ARM: dts: lan966x: Fix the interrupt number for internal
 PHYs
In-Reply-To: <51e33996-3ff8-69cd-392d-9d5d6298fe31@microchip.com>
References: <20220912192629.461452-1-horatiu.vultur@microchip.com>
 <51e33996-3ff8-69cd-392d-9d5d6298fe31@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <4c87e84176a8aaddbf906668b02fb1bc@walle.cc>
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

Am 2022-09-13 09:18, schrieb Claudiu.Beznea@microchip.com:
> On 12.09.2022 22:26, Horatiu Vultur wrote:
>> According to the datasheet the interrupts for internal PHYs are
>> 80 and 81.
>> 
>> Fixes: 6ad69e07def67c ("ARM: dts: lan966x: add MIIM nodes")
>> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> 
> Applied to at91-fixes, thanks!

I'm not sure the fix is correct, though.

-michael
