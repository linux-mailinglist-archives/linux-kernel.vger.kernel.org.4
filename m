Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D451707339
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 22:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjEQUkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 16:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjEQUkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 16:40:06 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F69C868F;
        Wed, 17 May 2023 13:40:00 -0700 (PDT)
Received: from darkstar.musicnaut.iki.fi (85-76-146-199-nat.elisa-mobile.fi [85.76.146.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: aaro.koskinen)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4QM4jR4GXgz49Q6Y;
        Wed, 17 May 2023 23:39:55 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1684355997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CHmtUTsdEeyQlJNUwT8f4VfIP2gwGUZiFKPvncr8V5M=;
        b=bG9xV3tPMfBIfq5kp9iKZhHOjIpGM7UcGmuOB83c1LqpdjI2BTgzj27wuAhTkv2QmJThxg
        ywAdX8WT8eSjpWcpBVj+3B7xsYYbJpc6dAdPFjWXNqDQvjQ3rFV5EdJnK/vV3whueRZr/j
        9Gx5jkgJHrLV0zGRY/UNURAqAV3hlybz6hnNAOfsNwtfH0sQA65g+Lvv4fU61bb+65vkeI
        EiMa/p9U4dIDY6c4rcSQt7d1KBsmEEKKQEhrr3BFeDDkLy6VCuvWlIqIwbMAFpHMnF6yyU
        d42dJMDkL8l6svOCEb1S1XE1nFYKOR81b9IQlYH4QNkqXJx9bo1+zts3I/zu0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1684355997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CHmtUTsdEeyQlJNUwT8f4VfIP2gwGUZiFKPvncr8V5M=;
        b=VlCa2vZN9twTTh9Xgi491+M4OEheQFTvCepFDMDfgdwLkoVo9cj7Ap0+mjM29T8qR5hYJB
        m0Wyzm0f/khU51UgeSAqxuJYi+Pf34flwu8EYNWXFsxZi0MI2+MLOQrI3/mH81s3yms3ge
        XH9+UcgieyJW1Kc2VkzCVZGnuyvGnXS1J4LRHkoYhTtOnUxpzFad2mqBagSSrFZWFl86WY
        dmohh/FLN/F8HPtpizqIpVb/dXQ3CNM6sT9bZfeTlcdakZY2hm0S5rU5PKq95xcCDum0xe
        ERb5wRLrwLuD1+NqOFvCseB+XyGPDIjlsNeIMJbOYvicCQJ81GIC27Mrru+H1A==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1684355997; a=rsa-sha256;
        cv=none;
        b=HaYYMZ9P5odR5iaJoG8NTnvDreyJEzg/RU0jQzI/ylJ/hX/ru1v+Lb0gntRUQaVTBN0qSA
        LF5x9kUMxo3piQsgRbz9Or8Knc80OhZ7xXl1o6EP5CnvLqEBj2IUbmCMttVn01/BCfBZjY
        EpD/DuF8z+uRij9Axb2EObhnCQlJ/ijwFGRlrNC2uLahb0/wcHh7B2vBTqQfOru7j8gel+
        gy+0d/CjzyduBtdwCZl0nmPyFNMHrAtMAZsLwaZrNsUTGDfcsXCJUEAAbIscM/4fN2Wk6t
        1JCFy6YwbwbnhLZRbIqWhqeL85rRJ4+F/mrNzrX561jjXD/X6Kflf4AwO95Sew==
Date:   Wed, 17 May 2023 23:39:53 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Helge Deller <deller@gmx.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-input@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH v4 1/4] Input: ads7846 - Convert to use software nodes
Message-ID: <20230517203953.GI271152@darkstar.musicnaut.iki.fi>
References: <20230430-nokia770-regression-v4-0-9b6dc5536b17@linaro.org>
 <20230430-nokia770-regression-v4-1-9b6dc5536b17@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230430-nokia770-regression-v4-1-9b6dc5536b17@linaro.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 08, 2023 at 11:20:06PM +0200, Linus Walleij wrote:
> The CBUS also has the ADS7846 touchscreen attached.

Not sure what this comment means. CBUS is for Retu/Tahvo, and touchscreen
is SPI.

When tested w/gpio-descriptors-omap branch, the touchscreen probe fails:

[    2.378540] SPI driver ads7846 has no spi_device_id for ti,tsc2046
[    2.391906] SPI driver ads7846 has no spi_device_id for ti,ads7843
[    2.405029] SPI driver ads7846 has no spi_device_id for ti,ads7845
[    2.418151] SPI driver ads7846 has no spi_device_id for ti,ads7873
[    2.432556] ads7846 spi2.0: Unknown device model
[    2.443817] ads7846: probe of spi2.0 failed with error -22

I don't know if that's caused by any the patches in the branch or some
other regression. With v6.2 it probes OK.

A.
