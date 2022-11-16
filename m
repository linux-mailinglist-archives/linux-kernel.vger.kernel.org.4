Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A56862CD77
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 23:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238754AbiKPWOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 17:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238665AbiKPWNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 17:13:46 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1081F24080;
        Wed, 16 Nov 2022 14:13:43 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A6EB6100004;
        Wed, 16 Nov 2022 22:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668636822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HbsJ+Y08EQLASOdtyUuuzbvV1Ei3Wpv7tnXwmPZNGP8=;
        b=bSvBBzuizOa9e+soJ3rOHJjqMKnQRexFw8pyqST2Lqk+wL39xGKdFEwdO/v8IiNdkM/oWK
        ga1XBaBIWxx5oL6m9tIedWSaKkTwew9CVosQLA0mfPWZsBVSa1tV3lSoDTZ83mFVxynP+Q
        xM5P4xDhE674nWwkiFFJkKh2fx/VCF1jfUr7TW7cA7xS4x23CnBfF0YKMcZ/NzjL21m0gh
        eXzkFtszS12DBTQFvZ07Fi2EpoDy0gRsV6DpXwEto/ZHdZcOSHR2Xf/pbMOXuMcWEZEPE7
        pFnHBhDGnn+2XkIqXa2rZzEI52bVnWJRy0OBnWBYEwGU2HcX6gKVdD9OAvWhYw==
Date:   Wed, 16 Nov 2022 23:13:41 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com
Subject: Re: [PATCH] rtc: pcf8563: clear RTC_FEATURE_ALARM if no irq
Message-ID: <166863678725.2504087.10277347266415780715.b4-ty@bootlin.com>
References: <20220301131220.4011810-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301131220.4011810-1-vincent.whitchurch@axis.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Mar 2022 14:12:20 +0100, Vincent Whitchurch wrote:
> If there is no IRQ hooked up, clear RTC_FEATURE_ALARM to make the core
> ensure that userspace is made aware that alarms are not supported.
> 
> 

Applied, thanks!

[1/1] rtc: pcf8563: clear RTC_FEATURE_ALARM if no irq
      commit: 60cfac17d0a1c28cd41959e95ba1e0ecc47165e7

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
