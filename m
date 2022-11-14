Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3A9628B74
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237499AbiKNVlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235836AbiKNVlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:41:16 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD8C183AE;
        Mon, 14 Nov 2022 13:41:14 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id ECF5F60006;
        Mon, 14 Nov 2022 21:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668462073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hx5GrKCG7MQPSnkftUYI8UaEdV1v45IfDRg1jBXihzo=;
        b=mEn9+mssWZKqjXEJ+Wx1tKsXy8qGJs+aUrmT46waVEOSWESi/K//pV2nF/CSImkAuPhL9N
        dUlyno/gryW4ZPbZai7kKaqVjCk1bZsuKIU2ZaAzirYfo3EbgKnWQ/PhK5QRfq6XpZlvYs
        4fK3INoMlmUkfo0fUkO6pahPahTNuSftH/hf7eTRqcxHbQy/OLTdujoUWWLic+H5s4Cr1g
        8amJCcsVDHBHHGGFVVDOpV/WWi1oRBDXLfhWcFJdCvsSDN5r7jkXJRe/BlnVRrZsEPAif1
        c/22ozU5UDeeOjeBbtthaTf6TCOvhFYEl5kCuOUgDL0iSla+D3ROvgFp+9H0Og==
Date:   Mon, 14 Nov 2022 22:41:12 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-rtc@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] rtc: isl12022: add support for temperature sensor
Message-ID: <166846204427.2116966.8513792337305780689.b4-ty@bootlin.com>
References: <20221026133847.1193422-1-linux@rasmusvillemoes.dk>
 <20221104110225.2219761-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104110225.2219761-1-linux@rasmusvillemoes.dk>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2022 12:02:25 +0100, Rasmus Villemoes wrote:
> The isl12022 has built-in temperature compensation effective over the
> range -40C to +85C. It exposes the average of the last two temperature
> measurements as a 10-bit value in half-Kelvins. Make this available
> via the hwmon framework.
> 
> 

Applied, thanks!

[1/1] rtc: isl12022: add support for temperature sensor
      commit: 1087656c079ddd3bb240a3c1f108c37b9b8f1457

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
