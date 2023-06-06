Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FD9724EC7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 23:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239711AbjFFV1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 17:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbjFFV1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 17:27:12 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA6F10D1;
        Tue,  6 Jun 2023 14:27:10 -0700 (PDT)
X-GND-Sasl: alexandre.belloni@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686086829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BR43p4vFQutMyYXqBIKO62/tUgmD0zV23thmYuRjMzw=;
        b=FlWU8qKRmx/dIllvOWX2F9qZORCGEDXh0A11c8Pl/5ZGcyNHuvcZF6d0n7pX09zO+pmfzW
        popQUbiaWVgrSdr5ajFNRYuUlo4EmednQ9QLagpg0TTVXmnukwEFAs+DLVYS0gbojMysds
        /kJG7lK0WxUqhdLQlNyp+6jBe+5LK/2dspv7VlFr+XYVpymgMt1qJ8Bm2F+/j2xagFYluE
        0d1TImHdIJBpNKgU6Nk0gIFwIfnkwZkpQXCV45xhYe7CSAQol983qKzoiVWgAPc+Dkno1y
        zosYoIEzOJmwPTlfVgqAx/Q7IipZuVY3/PC5Tzc8DgfRg18tk9/OXNUdMP/Avw==
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 218AC240004;
        Tue,  6 Jun 2023 21:27:09 +0000 (UTC)
Date:   Tue, 6 Jun 2023 23:27:08 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [RESEND PATCH 1/4] rtc: ab-eoz9: constify pointers to
 hwmon_channel_info
Message-ID: <168608680172.26438.4791232990703685081.b4-ty@bootlin.com>
References: <20230511175609.282191-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511175609.282191-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 11 May 2023 19:56:06 +0200, Krzysztof Kozlowski wrote:
> Statically allocated array of pointers to hwmon_channel_info can be made
> const for safety.
> 
> 

Applied, thanks!

[1/4] rtc: ab-eoz9: constify pointers to hwmon_channel_info
      commit: 973ef08456f8c6aea4672ae986dfe907b9e4fdc3
[2/4] rtc: ds3232: constify pointers to hwmon_channel_info
      commit: d00caa55cecd3e833c21c9372fc558cb9f40a07f
[3/4] rtc: isl12022: constify pointers to hwmon_channel_info
      commit: 303b1e894470421f7c5b6452937fc8c1f0f89075
[4/4] rtc: rv3032: constify pointers to hwmon_channel_info
      commit: b19118965778da3ba9fbeeca39bdf24738d229b4

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
