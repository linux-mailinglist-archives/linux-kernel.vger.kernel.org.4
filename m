Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE0A60497C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiJSOlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiJSOk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:40:26 -0400
X-Greylist: delayed 466 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Oct 2022 07:25:45 PDT
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A3418D44F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:25:45 -0700 (PDT)
Received: from relay3-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::223])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 4AAADCF0FE
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 13:50:05 +0000 (UTC)
Received: (Authenticated sender: kory.maincent@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7409860007;
        Wed, 19 Oct 2022 13:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666187324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jWLdxN+97ap53jrpUC9GjBMEcJ1tDM3CYAcf8zsyORM=;
        b=YiJml/9fVs+YJuiGX4rQXxGEs+coQsQs1xBrSD8b1tUWYrd40E0B12k/jRtGGcIMzvFq2d
        u7NHnO44mmuuxi/AqLPQZDUEX1x2RDr4h6F+fAknfzn3939l1TEBHqwJCxvCg4u1cV321G
        HmAvz87vCCSh67C7UBcfAqxeRmIXdp9NwPEcJn3zecAAG4GBK2e8T187Ilg29aHM9iRxHQ
        VMIlNnSrL+wgHK9kT9f/6UNZ4p0Wre0Qwbq7z7VaVJY2pq0F5dOqYU/WJeLNYMuGj04PNO
        8SnsD6O7X4t43ubUK0O+v52aHDg3OBQZfj+9vp5F6Bym9Zu7LGrMXuEwSbgH8w==
Date:   Wed, 19 Oct 2022 15:48:41 +0200
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>
Subject: Re: [PATCH 3/6] arm: configs: spear6xx: Enable PL110 display
 controller
Message-ID: <20221019154841.1cb2a15a@kmaincent-XPS-13-7390>
In-Reply-To: <5e6858b7-231a-187c-acaf-f82b82a956bf@linaro.org>
References: <20221019133208.319626-1-kory.maincent@bootlin.com>
        <20221019133208.319626-4-kory.maincent@bootlin.com>
        <5e6858b7-231a-187c-acaf-f82b82a956bf@linaro.org>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

On Wed, 19 Oct 2022 09:38:45 -0400
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 19/10/2022 09:32, K=C3=B6ry Maincent wrote:
> > From: Kory Maincent <kory.maincent@bootlin.com>
> >=20
> > Enable the PL110 DRM driver, used by the spear600.
> >=20
> > CONFIG_I2C is dropped from the defconfig as it is selected by CONFIG_DR=
M. =20
>=20
> I2C as a user-selectable option should stay. Don't remove such
> (user-selectable) top-level options just because something else selected =
it.

As the CONFIG_DRM selects it, the "make savedefconfig" removes it by defaul=
t.
Why keeping something that is already automatically enabled by CONFIG_DRM?
