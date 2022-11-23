Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2FE635337
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236699AbiKWIuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236698AbiKWIuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:50:08 -0500
X-Greylist: delayed 88825 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Nov 2022 00:50:03 PST
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0F3E9325;
        Wed, 23 Nov 2022 00:50:03 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 996501D40;
        Wed, 23 Nov 2022 09:50:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1669193400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4W9RiPaNSvStQHiskQ7zYEFwzOOxCCQ+wsJki7XP6a8=;
        b=rizgvhI92mBrKmoVkSg0nMWWDZJ38eOw4uCvzOskt/Z6NahkJVYao8/9Z02QLSFjcrjdb7
        Skr1b6fpOkCFcp7JdAMCtmjkpF5/p++1auNanObEun3V9WC7XWuCxVk86+htHlrgdMylRu
        kTIX9A/Q/MHiiJNO9r/UYcVERHsa40/Hxze+zxZvnAS4kOyRjmHGAJwms2x9+DiZgCNAxB
        EOy3c1Ngrg3v+DTlP/YBijfvFwtuVh0OLFABsegZeTi3O1tjEAUsn8bsrauJVaLgCROml4
        jadLj57iJeUqgkO2PhtDP07zNTuOfC1hCWuEoWApqd1fUgT3lD7j7JIMGuvs2w==
MIME-Version: 1.0
Date:   Wed, 23 Nov 2022 09:50:00 +0100
From:   Michael Walle <michael@walle.cc>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] serial: atmel: cleanup atmel_start+stop_tx()
In-Reply-To: <20221123082736.24566-1-jirislaby@kernel.org>
References: <20221123082736.24566-1-jirislaby@kernel.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <4b9c474a0b32ffe3725ed1cf9f084fcb@walle.cc>
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

Am 2022-11-23 09:27, schrieb Jiri Slaby (SUSE):
> Define local variables holding information about whether pdc or dma is
> used in the HW. These are retested several times by calls to
> atmel_use_pdc_tx() and atmel_use_dma_tx(). So to make the code more
> readable, simply cache the values.
> 
> This is also a preparatory patch for the next one (where is_pdc is used
> once more in atmel_stop_tx()).
> 
> Cc: Richard Genoud <richard.genoud@gmail.com>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Reported-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Already merged, but:
Tested-by: Michael Walle <michael@walle.cc>

Thanks,
-michael
