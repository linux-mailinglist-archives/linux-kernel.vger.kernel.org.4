Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3F66CD114
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 06:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjC2ENI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 00:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjC2ENG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 00:13:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324CB3AA8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 21:13:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7383619C4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:13:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CFF2C4339B;
        Wed, 29 Mar 2023 04:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680063184;
        bh=ulo/KOO1DX4ComF6xsesEjdZhezIFqB5xY3hlPwEF+g=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=cL9aRM1Vmi/20AbydvC54npxkBuz/fsUQKhTHVnMx052oySLmBGcxw+LuVLZ6Un6b
         3Sps9hJRRp6rbblDJwyzQwFwURNlVBGXDCgMAscKONEuAsJFz+dN5A8TaIs1Lx2d7T
         pmNA4YsXUgjSgUHBMnkss/s5ZNRd7D6ZOoHqBBu3dg4nv0BJWcmKc0pHA25WcPeKWc
         WLCN79vXgRbcRDk9p3SY5RaoXzpxwzeXQRVjA/1hXG+RQA5U2+K+I2cIL4ZNm9z3Ss
         28D8UScR6ELEtKvONIBV2s4JNT3mT97gznNVQDec/0DQJUkfFU6h7+T90HLzc7zUaz
         uyZIwJLB/PSxg==
Message-ID: <ba0552a36a25dd9a438933dc6bb6272e.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230306073446.2194048-2-u.kleine-koenig@pengutronix.de>
References: <20230306073446.2194048-1-u.kleine-koenig@pengutronix.de> <20230306073446.2194048-2-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/3] spmi: hisi-spmi-controller: Convert to platform remove callback returning void
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Date:   Tue, 28 Mar 2023 21:13:02 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Uwe Kleine-K=C3=B6nig (2023-03-05 23:34:44)
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
>=20
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---

Applied to spmi-next
