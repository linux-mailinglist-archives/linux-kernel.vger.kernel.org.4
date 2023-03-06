Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3645A6ACE1D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjCFTaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjCFTaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:30:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13706E6A8;
        Mon,  6 Mar 2023 11:30:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30323B810CB;
        Mon,  6 Mar 2023 19:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD916C433D2;
        Mon,  6 Mar 2023 19:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678131000;
        bh=hCveUPTHfPlfd4ckjlJ+h3qtXYHgC0QYnx+BbTyXMjI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=LrhrxY/V1SwrNdgraCO6Bs1NZMyDpSOsvOEZ+opYk8NgYUYkAjV0zyInHnQ3lrP5k
         X2tGx75cKEQ+zzNKBHmI//i0VIznb6u2ACEq+815kVC8ZWZssS/r/dEaP3DxqCQnMX
         JUt0ERw2LjVEvXtaoTaZsaj5y+ncmgBsNbtNdzlcMIs/OmkJCnw2E+sE87Firfr+hM
         maTOtEW6p77FT8CfM/1L4yIWAzysbpxFOjiv+gD2aKdFnm+bMWK2ncJe98jDEgtmEW
         toRRq/TQ3aRRnCL+qMKKiwkbIzCHC1wuPzIPbncBP+csjE1TxmGuIAiUABxm6VgHdw
         tqb2JHsPbBZzA==
Message-ID: <b9aa323e25fa083d78be6dcfbf7dd727.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230222121453.91915-12-nick.alcock@oracle.com>
References: <20230222121453.91915-1-nick.alcock@oracle.com> <20230222121453.91915-12-nick.alcock@oracle.com>
Subject: Re: [PATCH 11/27] kbuild, clk: bcm2835: remove MODULE_LICENSE in non-modules
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-clk@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
To:     Nick Alcock <nick.alcock@oracle.com>, mcgrof@kernel.org
Date:   Mon, 06 Mar 2023 11:29:57 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nick Alcock (2023-02-22 04:14:37)
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
>=20
> So remove it in the files in this commit, none of which can be built as
> modules.
>=20
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-rpi-kernel@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> ---

Applied to clk-fixes
