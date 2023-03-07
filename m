Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7416AE84C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjCGRPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjCGROd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:14:33 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697C1911C3;
        Tue,  7 Mar 2023 09:09:18 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3209B10000C;
        Tue,  7 Mar 2023 17:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678208956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wKTxcXraR76Y5r9+YplRylhvukCb5ywkGhpumsLDoPE=;
        b=hfL7Q4MWNW6MQkkcWKlFAGBMhvPi8XdKdndsDr4lvxNDyzLZQZYWD2yPKg5ruePlRtGgMs
        2sMslRs2ub0/c3rgFn/yi+jB9cAd/v0VTyhsRpfe6nQ4KwzpbC6hbWMMBKPHwItX6A4N1B
        PlTZYERuYcZ4DxBv1pfwokA0Asv/R9OuOcHUh4NQOm8QqbNtctG6xrVWnwe7YefhTHwcvZ
        IfyJmafed7gWjSk1eGBY1udh8YEzunqzd9ZTep0Wffd0cVNQN48/CXx9+97YA1EfuPCT6C
        IxrxKhyCkt/qCpty68gX7D//9v48NFMpOsL4fqIsW09eiX/DDPm5Ja8x2y6Pjw==
Date:   Tue, 7 Mar 2023 18:09:09 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sebastian Reichel <sre@kernel.org>,
        Wolfram Sang <wsa@kernel.org>, Mark Brown <broonie@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2 00/21] nvmem: Layouts support
Message-ID: <20230307180909.3a722948@xps-13>
In-Reply-To: <20230307165359.225361-1-miquel.raynal@bootlin.com>
References: <20230307165359.225361-1-miquel.raynal@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

miquel.raynal@bootlin.com wrote on Tue,  7 Mar 2023 17:53:38 +0100:

> Hello,
>=20
> This is a fully featured series with hopefully all what is needed for
> upstream acceptance, ie:
> * A bit of OF cleanup
> * Full nvmem layout support merging Michael's and my patches
> * Only the fixes not applying to this series have been kept "un merged"
> * Support for SL28 VPD and ONIE TLV table layouts
> * Layouts can be compiled as modules

Unfortunately that is not gonna fly, I of course messed with the base
branch. Please ignore this, I will update, make everything fit and
resend.

Sincere apologies for the noise.

Thanks,
Miqu=C3=A8l
