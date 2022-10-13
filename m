Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024D55FE434
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJMVbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiJMVbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:31:11 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75763155D83;
        Thu, 13 Oct 2022 14:31:09 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1C8E0240002;
        Thu, 13 Oct 2022 21:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1665696667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jz1vmgauCNwQwVv3M/5PRCJ07YuyA62yMSzMceprsfg=;
        b=CHd9JeaH9Q/7k3cFZkuZHI/QHmSxrkhdWsPcxNdxiH5wRcRrF/3+gM6NsseJ6J37qKFBSL
        CM/49urpoAfYuRfaPs3uAYbRfaGiS/Y+/tmurgVSNn+cvrnFNG6ADj5VHSjASXkfqBPwr/
        jpstuJwJ6hgziqQ4UUkk5oXOgjnE0NTZsc/LiYQnBOaMfFo0w63nQJ1pTD0hP16gvduHbO
        rrFLsviFE2J3wMJvapSGb8PblZp91F9hkFgpYNjaXEYiOLqkuu2wRim04TWWT55buTJGSD
        7a51tzu9E41N8IHYQWEcHj0h+W6MmfF1rb3v0snWpXUVjnQb6WQl41lQlh2EQw==
Date:   Thu, 13 Oct 2022 23:31:06 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-rtc@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/9] rtc: isl12022: cleanups and hwmon support
Message-ID: <166569636074.1226796.14248068876405848319.b4-ty@bootlin.com>
References: <20220830100152.698506-1-linux@rasmusvillemoes.dk>
 <20220921114624.3250848-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921114624.3250848-1-linux@rasmusvillemoes.dk>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2022 13:46:15 +0200, Rasmus Villemoes wrote:
> This series does a few cleanups of the isl12022 driver,
> 
> - removes use of deprecated function
> - removes some redundant code
> - switches to regmap API instead of private helpers
> 
> It also provides range_min, range_max values and finally hooks up the
> temperatur sensor to hwmon.
> 
> [...]

Applied, thanks!

[1/9] rtc: isl12022: stop using deprecated devm_rtc_device_register()
      commit: a35a2ad2b88a66732ac442ad5f86dc49af51673f
[2/9] rtc: isl12022: specify range_min and range_max
      commit: ca03b7a2c0b098321365f69538823d1bcc860552
[3/9] rtc: isl12022: drop a dev_info()
      commit: 43a96b9cf67770d4bb46267e1554d3d8b4cf78ac
[4/9] rtc: isl12022: simplify some expressions
      commit: ca35887186b7c53f26c42aee1285ba213adb4365
[5/9] rtc: isl12022: use %ptR
      commit: 7093b8a471f48d49891da2108f44fd64742408cb
[6/9] rtc: isl12022: use dev_set_drvdata() instead of i2c_set_clientdata()
      commit: 31b108acc50cddf3d16472ead45c4cd0d1337289
[7/9] rtc: isl12022: drop redundant write to HR register
      commit: 0a2abbfd8586d396a8581ebf9b96fd5746f08b14
[8/9] rtc: isl12022: switch to using regmap API
      commit: b1a1baa657c738e8bb0107ce304f5e78b9847f37

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
