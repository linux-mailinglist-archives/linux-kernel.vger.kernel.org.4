Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E68D692B2D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 00:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjBJXb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 18:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBJXb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 18:31:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7505A1B564;
        Fri, 10 Feb 2023 15:31:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19EBA61ECC;
        Fri, 10 Feb 2023 23:31:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4A1C433EF;
        Fri, 10 Feb 2023 23:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676071884;
        bh=mkYfiQ9LU4J5ZjN+xX5Qj4vIXs5RujxS8HqKfLejwME=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ZdeGqePetOd0LEKTv3yuN/8JUUDeAFwXxdbHzvaRU+L+LZscS9OxRGq3/dcTONTOD
         F+FC4TVu2f2K49RWWM9Fmwn5mO3BUF1xKJwfxo6TzOrYEqBmNlAwPCXifTKvyZzYNf
         7kTwuTSC3i9E/78oNEhMBVSdVW6Yo21eng+ijIosK7coWzRl9orL4teZ7AQqzBZhNp
         JKIMX0bgdFbFMH1AaDVSkaoGCGoyhm0wx4jrkdlpoiyFdSjSmJJytcx6FsNwLUlmsq
         onRDUH6UUdYpgGegCkoV8gVrYE3TLgEbIxGw16bPZTl3LrW8PWmVo5CEnjV+Bl0OCZ
         frpr4//2VANKQ==
Message-ID: <a3e6f6038511ad48258627dbf4c335e2.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230210111141.1379645-1-keguang.zhang@gmail.com>
References: <20230210111141.1379645-1-keguang.zhang@gmail.com>
Subject: Re: [PATCH] MIPS: loongson32: Update the clock initialization
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Keguang Zhang <keguang.zhang@gmail.com>
To:     Keguang Zhang <keguang.zhang@gmail.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Date:   Fri, 10 Feb 2023 15:31:22 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Keguang Zhang (2023-02-10 03:11:41)
> The Loongson-1 clock driver is under re-implementation
> to add DT support. As a result, ls1x_clk_init() will be dropped soon.
> Therefore, call of_clk_init() for clock initialization instead.
>=20
> Link: https://lore.kernel.org/all/20230209132614.1079198-3-keguang.zhang@=
gmail.com
> Link: https://lore.kernel.org/all/20230209132614.1079198-4-keguang.zhang@=
gmail.com
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
