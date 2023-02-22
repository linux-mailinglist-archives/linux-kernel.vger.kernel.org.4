Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD6E69FFBA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 00:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjBVXnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 18:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjBVXno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 18:43:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0065B234F2;
        Wed, 22 Feb 2023 15:43:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AA1F615AE;
        Wed, 22 Feb 2023 23:43:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE87CC433EF;
        Wed, 22 Feb 2023 23:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677109422;
        bh=kvjf7YdN3a97l7ASeaGM3aUy2ksXyUSWrHo4iuLbyqg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=sGjlvocIrEbCCQ+5NqB8+0bJfQ8Vdi+3aYQcN0JIBxHVgVNS2ZQDCSYN3BlCX5Eep
         WxnqDx83IwtgEDpqhpNlCcVfCMViiKRUWauLHoU5eS9RX8K0l5dCQbYU+VmVgFcne9
         xgIJw1xkA9SP1YMNrnRcAhcDubVWnI0+P2M1Zc4ho2oZ8lJeFceM6k28Qn1ssJwNa9
         EheoFhTl0IH0gnrvWPYAbS12ePuYcWz95Ak9uKb76d79uxJgaOmei/o9gAEktkCAOv
         wb/EskW7l8y7fc9P3DCh8fKHBHAyktNJA6akxVAB7ERXMygJg3aN7D/JE1qT34H9x5
         SLcbh9SDdtiUA==
Message-ID: <bdac18adf87f3b03104c16b7c0caaf8a.sboyd@kernel.org>
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
Date:   Wed, 22 Feb 2023 15:43:40 -0800
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

Acked-by: Stephen Boyd <sboyd@kernel.org>

Unless you want me to pick this up?
