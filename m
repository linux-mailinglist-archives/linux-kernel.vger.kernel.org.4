Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA0D6861A0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 09:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbjBAI2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 03:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjBAI17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 03:27:59 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB99710C4;
        Wed,  1 Feb 2023 00:27:55 -0800 (PST)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 35CDC20005;
        Wed,  1 Feb 2023 08:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675240074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5xUTvsFSiDCu842dSP17c/dTVTBthGY1CFm8DLQNqnU=;
        b=SQT1pZRtLetsbc5pJGJLTB+Bf/voWvArOogDiJsacDwFQFsDrWLUGVY1D6FiW7QlCphtN7
        dYaEfMCoYYI8uVGGmtCMM2mXnz7sodFOzdsLww8FxWbOtA5qwGMrm+YtCiybvk0UKwWQn3
        b61gf6f3kPnCWeN1mT7kEBlfEz6+sLVVPoo/6A/JpEwmGhkCIBbNNXoXMJfxeRp0eJ1SuK
        mHexovoag/y/cgTFlhDj94HT1ZVDjkhh+Ay5BynfV+InF2534i2F0Ju6b+4CWhpMWLOove
        LkD3qKEJf5dd1JpNU5blWGnhv3JygTG28fJwTmo6z/Ow5yXgLJDo+YlyUs5CxA==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: marvell: Update Armada 37xx platform bindings
In-Reply-To: <YvJ2HKqMTTyWiNth@lunn.ch>
References: <20220713200123.22612-1-pali@kernel.org>
 <20220809131252.z3mbmiz4duxwlauw@pali> <YvJ2HKqMTTyWiNth@lunn.ch>
Date:   Wed, 01 Feb 2023 09:27:52 +0100
Message-ID: <87edr9bxiv.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> On Tue, Aug 09, 2022 at 03:12:52PM +0200, Pali Roh=C3=A1r wrote:
>> + Andrew, Gregory, Sebastian
>>=20
>> please comment on this
>
> Krzysztof said:
>
>> The change is an ABI break, which looks reasonable, but still
>> platform maintainer should comment on it. Especially on the aspect
>> why the marvell,armada3710 fallback was chosen at the first place.
>
> I was not involved in the armada37xx enablement. I have no idea why
> marvell,armada3710 fallback was chosen.
>
> Gregory might know, he is the author of this file.
>
> It does however seem reasonable. And a grep does suggest this
> compatible is purely cosmetic, it is not matched on anywhere.

This compatible was for the single core version of the Armada 37xx.
I think the idea behind using it as fallback was the fact that if it
works for aramda 3720 then it works for armada 3710.

Gregory

>
> 	   Andrew

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
