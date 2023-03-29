Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9FCF6CD04E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 04:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjC2CqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 22:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjC2CqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 22:46:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBFC2D63;
        Tue, 28 Mar 2023 19:46:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A1E9B81E4F;
        Wed, 29 Mar 2023 02:46:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0543C433EF;
        Wed, 29 Mar 2023 02:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680057972;
        bh=uzVpXoYVgwiQ/OtqrXaCGv8Q5Ms14GwgyQzDl8dlBPs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=cD+YUjoLnhnDDR24/kSpmwDdzROIbDGUhjfGVXDHrhROcYGhMkKYP4ggAmv3hyma6
         A8kkbhss98fD5Mr4YYnQ1ZLz4UtYcdxvv5kO5WJAqQoDNWZrQXKz88RFNYmWwIG+NQ
         Q9B3D9f92otsHZrHZI5gngArs0FVZyaJfNo71sK8dQFXmQKxHk4aVf/JXn6ZnVVoeD
         Gskr+bbJqq5dTVJo3DnPAb3+XAzS8kyJApm6qp5j9tIY5KGj7ebtQKjZT1yD75byu9
         AGlYaWxJxFMJrKaHQ7kCJuzTLpACy1mNNZ4LfrwKM/+jaDbGCokFULkYaVWb+h23kB
         5cyluoyLxJfMA==
Message-ID: <e5221cd020bc60513df6a1c1859e1acc.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <129cf4b6-b3b5-2a12-5911-37e70a624812@gmail.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com> <20230328021912.177301-9-ychuang570808@gmail.com> <ab4e0bc8834b7e618e9a88ea6a1c30cc.sboyd@kernel.org> <b7977069-4f82-76a1-10c1-b6400862c2c4@gmail.com> <c37e1f3a40c404acd81c2c9d5b28b340.sboyd@kernel.org> <129cf4b6-b3b5-2a12-5911-37e70a624812@gmail.com>
Subject: Re: [PATCH v6 08/12] arm64: dts: nuvoton: Add initial ma35d1 device tree
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
To:     Jacky Huang <ychuang570808@gmail.com>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org
Date:   Tue, 28 Mar 2023 19:46:10 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jacky Huang (2023-03-28 19:39:36)
> On 2023/3/29 =E4=B8=8A=E5=8D=88 10:19, Stephen Boyd wrote:
> > What do you use the syscon for then? The clock driver must want to use
> > the syscon for something, implying that they are the same device.
>=20
> The register lock mechanism is applied to protect many critical=20
> registers from false written.
> The register lock control register is one register in system controller.
> Some registers of the clock controller are lock protected. Not only=20
> clock controller, but other
> IP such as RTC, PWM, ADC, etc, also have lock protected registers. All=20
> these IP requires
> syscon to access the lock/unlock control register in the system controlle=
r.
> That's why we add a <&sys> to the clock controller.
>=20
> Should we implement a ma35d1-sysctl driver to protect register_lock()=20
> and register_unlock()
> and export to those drivers?=C2=A0 If yes, we can remove the <&sys> from =

> clock controller.
>=20

You can implement the lock and unlock in the hwspinlock framework. See
drivers/hwspinlock.
