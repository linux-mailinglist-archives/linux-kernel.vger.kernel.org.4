Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E39605FEF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 14:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiJTMQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 08:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiJTMQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 08:16:18 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5EB1645CB;
        Thu, 20 Oct 2022 05:16:16 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 674681C09DA; Thu, 20 Oct 2022 14:16:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1666268174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UETEyythYJwSfqKA2WGuDN9V57KqBhfyFfz8g5NHVJM=;
        b=E1CFfEzgFnS8JGKtZOp7rGe7NBGnphs/wm1GMt7TQCY/MqlqPFfBq4ZzkDX9v9IXqaH+j/
        ndk8Jc9HeCD7+wE7a7M/g2VeKsAb8WViB5w+RCZfI/6HaNqWPe5N6w5p+kTOCe9Ik6AGJV
        vpRAXIiNcEXGOFtXw5nvQXCdQ94rbqY=
Date:   Thu, 20 Oct 2022 14:16:08 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, arnd@arndb.de,
        f.fainelli@gmail.com, krzyszccf.kozlowski+dt@linaro.org,
        nsaenz@kernel.org, olof@lixom.net, robh+dt@kernel.org,
        soc@kernel.org, stefan.wahren@i2se.com, william.zhang@broadcom.com
Subject: Re: [PATCH] ARM: dts: Add Raspberry Pi Compute Module 4 CANOPi Board
Message-ID: <20221020121608.GA1774@bug>
References: <20220916153156.30412-1-ariel.dalessandro@collabora.com>
 <e652ad18-3a35-e8a0-939c-5f2a59cfc3d0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e652ad18-3a35-e8a0-939c-5f2a59cfc3d0@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > +		led-pwr {
> > +			label = "PWR";
> > +			gpios = <&expgpio 2 GPIO_ACTIVE_LOW>;
> > +			default-state = "keep";
> > +			linux,default-trigger = "default-on";
> > +		};

NAK on the label, see/modify well-known-leds.txt.

