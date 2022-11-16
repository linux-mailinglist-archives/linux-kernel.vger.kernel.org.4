Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A781A62B39C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 07:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbiKPG7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 01:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbiKPG7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 01:59:50 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6E51400B;
        Tue, 15 Nov 2022 22:59:47 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id E4E3814C1;
        Wed, 16 Nov 2022 07:59:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1668581985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pf6648sW4+rH+5/eipmGEYTOz7XOSfx5Z+DwMk6HmxU=;
        b=I65156MeWDaq3unC5oNISuKARcrsS8wuMQzzhLT+tCqr3Z/fQ5cU8gnxpLiA6gT7hhgRaJ
        TzGtuuianvrmaoea+V2XbX8Dxjrve1LVs0uC10FuooJyczeWED019vdY0uOqHyl+KOqbz3
        1BG6zbl20uBRBjgYZEvIOjlJMRkJE1QjkhKufjEiwqtxx+Lq3FP5IwSrD1Kt39KYT0Wcm9
        K+o0JbB6YUgcqknZJlSgwnwoBKZOzlmAm8oMdP5G9khk+IjAIXiGXWWA66WpRayqBjUkKW
        /WzeLStyVpKbpwBbiP9nsiiV3q/FAAsTExK0WeDcdtNmQVerCSqPwqvOLwc9Ww==
MIME-Version: 1.0
Date:   Wed, 16 Nov 2022 07:59:44 +0100
From:   Michael Walle <michael@walle.cc>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: sl28cpld: Replace irqchip mask_invert with
 unmask_base
In-Reply-To: <20221112152928.42204-1-aidanmacdonald.0x0@gmail.com>
References: <20221112152928.42204-1-aidanmacdonald.0x0@gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <74de8367627d4e84f34089e03722c24d@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-11-12 16:29, schrieb Aidan MacDonald:
> Remove use of the deprecated mask_invert flag. Inverted mask
> registers (where a '1' bit enables an IRQ) can be described more
> directly as an unmask register.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

Sorry for the late response, I was on vacation.

I see that it was already applied, so just for the record:
Acked-by: Michael Walle <michael@walle.cc>

Thanks for taking care,
-michael
