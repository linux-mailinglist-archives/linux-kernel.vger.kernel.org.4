Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7B0717BA8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbjEaJUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234937AbjEaJUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:20:31 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CCC10B;
        Wed, 31 May 2023 02:20:27 -0700 (PDT)
X-GND-Sasl: gregory.clement@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685524826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EvigI+q1H/6Yl0g5vJQbIGOBWdGjD8FItEAfhIiEVQY=;
        b=DXBTu7hZhri0qeBhLolZ7ZFpITxTiE0n+8F94W3T1oKEiqnS4h/DPdwQBN/da2Cn9ppxAQ
        dNd3JB7LME2JH4RghSpInASmT7gPdUCqJ7lV5x05Ic7dzncV+CEoQSdcGZgedyLjGb3rzR
        qDP8PRKCsyjoW49u+ez3ZI4sy5zeyPNV9GnquFns8ZS7rjhJdnJNvr21lOQledjNc6CKfE
        Miv1HCvUCjob0jDT81toDUipIG9WZcCWW/RCUzUfARSnSD459w9t6mm5M/2nlNx6ujkb9r
        OUGY03Wkc/+wC2XcZ/G0eteFqzpDlFnMvdpx3BTIbRT/pxbCV2UBZar3N7ETMg==
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 62C1B4000C;
        Wed, 31 May 2023 09:20:23 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Ben Schneider <ben@bens.haus>, Andrew Lunn <andrew@lunn.ch>
Cc:     Linux Arm Kernel <linux-arm-kernel@lists.infradead.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Devicetree <devicetree@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: marvell: Fix espressobin-ultra boot failure
 and wifi
In-Reply-To: <NWhH-xL--7-9@bens.haus>
References: <NWNpfIn--3-9@bens.haus>
 <f8393f75-ff32-4450-b8d6-b08d43240200@lunn.ch> <NWhH-xL--7-9@bens.haus>
Date:   Wed, 31 May 2023 11:20:23 +0200
Message-ID: <877csouaaw.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ben Schneider,

> May 29, 2023, 16:07 by andrew@lunn.ch:
>
>> Please Cc: the maintainers:
>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>
> Sorry! Maintainers cc'd.

I don't see the patch so I can't apply it...

Gregory

>
> Ben
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
