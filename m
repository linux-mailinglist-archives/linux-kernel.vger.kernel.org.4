Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91D65B8678
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 12:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiINKgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 06:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiINKgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:36:37 -0400
X-Greylist: delayed 1463 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 14 Sep 2022 03:36:36 PDT
Received: from gateway23.websitewelcome.com (gateway23.websitewelcome.com [192.185.48.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015BF53D01
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 03:36:36 -0700 (PDT)
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 8241227F37
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 05:12:12 -0500 (CDT)
Received: from 162-215-252-169.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id YPNLoslfBgeGqYPNMosndF; Wed, 14 Sep 2022 05:12:12 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ttYh+Qjcpm764F1HotUg308tg5syECwL71pQ0RbAGH4=; b=apWdl7nxIjaVLstrQsqLqHeZAf
        kFPmvU1CBzx7LlOlIHeGSH8S3C8vpYpqZ9Z88/YWtuiozvZOx97WPemAjUxcgTTKr5Nd//83b/IT/
        9Zx+go1dZhQ3vXq/uaWh7NRyGUiD4BCM7JCtuxxvDwLXm4b0Kzxo/D9bi/hlWnvjoE4Bp6sQGwQmW
        lqt8kZQsg+p/06hai6jSmIHELisTpu+30IpFOsAkvg5PEZCLB9FE3yd4bGfDP2A3j3tnMyEWg339E
        rl14pYtxFmwOnAqh+C18/thEYAl8PZUk7WOa8Qt5xVQs41EnnEzaQBDstGNWLKpRhTIGb//RLfm3G
        kjVfuCyA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:56638 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <linux@roeck-us.net>)
        id 1oYPNL-003s8B-B5;
        Wed, 14 Sep 2022 10:12:11 +0000
Date:   Wed, 14 Sep 2022 03:12:07 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mathew McBride <matt@traverse.com.au>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        jdelvare@suse.com, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] hwmon: add Microchip EMC230X fan controller driver
Message-ID: <20220914101207.GA938301@roeck-us.net>
References: <20220914053030.8929-1-matt@traverse.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914053030.8929-1-matt@traverse.com.au>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1oYPNL-003s8B-B5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:56638
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 1
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 05:30:27AM +0000, Mathew McBride wrote:
> The Microchip EMC230X (formerly made by SMSC) family of fan controllers
> provide PWM control for up to 5 fans (in the EMC2305). The EMC230X is
> capable of maintaining (closed-loop) a target RPM speed through PWM.
> 
> This driver has been tested with the EMC2301 (on our Traverse Ten64
> appliance) and with the EMC2305 demo board (ADM00879).
> 
> The driver is by no means complete, for example, further work would
> be required to support the different PWM output frequencies for
> voltage-based fan speed control. (So far this driver has only been
> tested with direct PWM capable fans, like the 4 pin fans found
> in recent PCs)
> 
> The emc230x driver also has thermal subsystem integration which allows
> the emc230x-controlled fan(s) to be used as cooling devices.

I just accepted a driver or emc2301/2/3/5. Please submit improvements
on top of that driver if needed; we won't have competing drivers
for the same chip in the kernel, and replacing a just accepted driver
smply does not make any sense.

Guenter
