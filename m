Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082C26CD111
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 06:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjC2EMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 00:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjC2EMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 00:12:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA08C4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 21:12:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3039161A15
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:12:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C1BC433EF;
        Wed, 29 Mar 2023 04:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680063156;
        bh=icLG33L+aXZCxB6Pjd8R7v/hZ1TiNA0H5dBAH3ntmfs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Hr1oQv8od8A8DZBU0QatNWBpPw0bezLkJM45zOTsSYQS2Iy8rq3sDKdZxSfhlM64T
         bEqMTyZ6V+C8QdWo7epRWbmGKRBdNpNZHQQ7mxElVC9OrKDWHZ5aPpih3vjYk63q/l
         K5EE1G3nHOPpGap+OtIuCpOOe161L52SiZQmgW8o4G57nXH6A1EHwWX56OOplDogSY
         ChZ+eRdycLColrlob0lHr7NXpNXYZwl0TxHpfrZxOUZinv9yKIVEOo3veMQiG9VDsr
         m1yuNwF/fUEORfTlch+UOLGiaciiqgefvZkwfRKxiKFvOFE3HZXR6q8FsF4sshHZNF
         U3coMiEHtxzqA==
Message-ID: <68dff3033e46b89691fea06ce8c3754a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230306073446.2194048-4-u.kleine-koenig@pengutronix.de>
References: <20230306073446.2194048-1-u.kleine-koenig@pengutronix.de> <20230306073446.2194048-4-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 3/3] spmi: pmic-arb: Convert to platform remove callback returning void
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
To:     Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Date:   Tue, 28 Mar 2023 21:12:34 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Uwe Kleine-K=C3=B6nig (2023-03-05 23:34:46)
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
