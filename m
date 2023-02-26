Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B246A335C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 19:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjBZSGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 13:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBZSGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 13:06:09 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B68EF86
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 10:06:04 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 009CCA6D;
        Sun, 26 Feb 2023 19:06:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1677434762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=00CSQUks6M18SeC37qz8wpq617p3vtaeoW4alDtoTkg=;
        b=NbfjNrzuTNlTH5FhSK4QKNKi4cAUo4RIAgfCkxFpaodShUBCMuYc/W5AerxFK9idv/lgRX
        O/GEPHFS4K5lQpxWTU8GzEP071ktH9LSzGiyM31UdxLJ6CUXCEUb52MM4gBjRIzg8THekM
        FRKluYf/s2+zFr8QnTOWiv85AsPjMvwzzdIgMM2k0sGv7Gbos8bPoNlzJIncxoGUF9L7dq
        FUbL6MflU43ciwlIlqCqqjWWYhzeELCffQDtEwsxvYYJZGP1+ygKu22GqYuMi4e4Gul/hd
        wi+t31zmDz80zoMi4jM/UejJ1QLYpZpC3oS5+y94s3BbMN3mFDRPVDj9Q0s86A==
MIME-Version: 1.0
Date:   Sun, 26 Feb 2023 19:06:01 +0100
From:   Michael Walle <michael@walle.cc>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 3/8] gpio: GPIO_REGMAP: select REGMAP instead of depending
 on it
In-Reply-To: <20230226053953.4681-4-rdunlap@infradead.org>
References: <20230226053953.4681-1-rdunlap@infradead.org>
 <20230226053953.4681-4-rdunlap@infradead.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <8846de19ead73575ad4f1f0d9f731405@walle.cc>
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

Am 2023-02-26 06:39, schrieb Randy Dunlap:
> REGMAP is a hidden (not user visible) symbol. Users cannot set it
> directly thru "make *config", so drivers should select it instead of
> depending on it if they need it.
> 
> Consistently using "select" or "depends on" can also help reduce
> Kconfig circular dependency issues.
> 
> Therefore, change the use of "depends on REGMAP" to "select REGMAP".
> 
> Fixes: ebe363197e52 ("gpio: add a reusable generic gpio_chip using 
> regmap")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Michael Walle <michael@walle.cc>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: linux-gpio@vger.kernel.org

Acked-by: Michael Walle <michael@walle.cc>

Thanks,
-michael
