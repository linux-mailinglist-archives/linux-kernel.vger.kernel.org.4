Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A040D6C8214
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 17:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjCXQD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 12:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbjCXQD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 12:03:28 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A72946B3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 09:03:25 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id F3B29FF80B;
        Fri, 24 Mar 2023 16:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679673804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e/Ot0XeBt4bh9S+cBPdCZ8iwvY0dcGmED6USv22SRnM=;
        b=BN22IGMZfMTPJUAD9JudirnCVZS8EtGHY8K8BBURZujAXY/BvR54yys/qrYZIVCxyYflSP
        AikEEJ4YmqmlZbNOMemXEdao26esr6xDfEmVdFz+KufTp8PQoHKUVNBYvdzzHU/hadKb1n
        rJzyQwdn75aimiV0tljZA6qnou0wBE06O3hApQj6gYT1QRn+MAmFrNbqHW8Bs/MvUaLBNi
        7MO4Hzpik1h27xB8Q1Ugzn/kyTe44hWlD+zhz1y2ARNpqq76PBoYJ0jZNg2XJ0HHHAHzla
        SsEwmYFrxf+m345laNq4FEbaPEJM0oO8DGAl1Ii8K7HvoaqDetBZ1lJRYYf39w==
Date:   Fri, 24 Mar 2023 17:03:20 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe Kerello <christophe.kerello@foss.st.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>,
        <krzysztof.kozlowski@linaro.org>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH 0/2] depends on ARCH_STM32 instead of MACH_STM32MP157
Message-ID: <20230324170320.5087c223@xps-13>
In-Reply-To: <20230324155105.826063-1-christophe.kerello@foss.st.com>
References: <20230324155105.826063-1-christophe.kerello@foss.st.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

christophe.kerello@foss.st.com wrote on Fri, 24 Mar 2023 16:51:03 +0100:

> To be able to compile the driver on all STM32MP SOCs, we move the
> "depends on" on ARCH_STM32.
>=20
> Christophe Kerello (2):
>   memory: stm32-fmc2-ebi: depends on ARCH_STM32 instead of
>     MACH_STM32MP157
>   mtd: rawnand: stm32_fmc2: depends on ARCH_STM32 instead of
>     MACH_STM32MP157

I don't see issue with taking these two patches in independent trees so
if nobody disagrees I will take the second one through the mtd tree and
let Krzysztof take the first one through mem-ctrl.

>=20
>  drivers/memory/Kconfig       | 2 +-
>  drivers/mtd/nand/raw/Kconfig | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20


Thanks,
Miqu=C3=A8l
