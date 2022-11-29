Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACF063C8F4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 21:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237211AbiK2UId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 15:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiK2UIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 15:08:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703AC58BED;
        Tue, 29 Nov 2022 12:08:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A5DEB818BE;
        Tue, 29 Nov 2022 20:08:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05EAC433C1;
        Tue, 29 Nov 2022 20:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669752507;
        bh=f1gq4ohUujseo9cnRHV3gkS6655KrFsXkNePMpOcDjw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=TdXJjWeKUJXU58GbLYMvx6CL5IqiPSqfBEnNOykBHio0cGBO9DdQ1sRooKx5eD9Nv
         +1jLrkz4AFO1OVJsx+4FZxH4HG7ko8xwpyS5Pg+6Q834DC8GJUK0I5GIq5Dsvo7FM3
         ZxcCNAcIeOaG+CUUn1N6EGLBlJ/WDGcz3zeDb4eLUK84sioK9qOWduvkM9YY3eAvyH
         V2/F9d6rtPUWU33RdivmIbhYsWRb30JbDRYiR4HlY59gbzUU9DAVaDTtPwan5SzxWK
         1EToo9Ix7DqYRqFPdGDxasPOFIzG8IlaN/z5eBL4ceOQ9mRxZikSzbrKYekJ03hVcj
         ldzE1y1wULUow==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221128094952.667315-1-abel.vesa@linaro.org>
References: <20221128094952.667315-1-abel.vesa@linaro.org>
Subject: Re: [GIT PULL] clk: imx: Updates for v6.2
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>
Date:   Tue, 29 Nov 2022 12:08:25 -0800
User-Agent: alot/0.10
Message-Id: <20221129200827.C05EAC433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2022-11-28 01:49:52)
> The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc7=
80:
>=20
>   Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/ tags/=
clk-imx-6.2
>=20
> for you to fetch changes up to 8178e245fa953f793670147368642717fcdb302e:
>=20
>   clk: imx: rename imx_obtain_fixed_clk_hw() to imx_get_clk_hw_by_name() =
(2022-11-25 11:22:15 +0200)
>=20
> ----------------------------------------------------------------

Thanks. Pulled into clk-next
