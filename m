Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3671E726584
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 18:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241564AbjFGQLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 12:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235773AbjFGQLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 12:11:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE0F1BE2;
        Wed,  7 Jun 2023 09:11:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B1FC6412E;
        Wed,  7 Jun 2023 16:11:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E2DC4339B;
        Wed,  7 Jun 2023 16:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686154269;
        bh=2fAt9/yxXGvJwT/aRPRYmMHAlxFUMVx4hSsAmaXySC8=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=Au9Dn2ZiPNbYTyjU/cbwKktLVPNo2Sk/jAgPFGV31VLUl9xScKUVixmGVqmjuqWl1
         c3pq08cz2oJPp0+klctPvtjy5yU2uDMH8mnjRGXUbSLfjOMCn/cEz8vAlRYLP/vjic
         xoA4/r9w5ZP01uZTPrFIlnYMca9yZZAfMwmmVhQThHm2VsXiqPsxzvFg2FpRi90yUW
         gga4vCAcN2vOZAtQq7YAsGJAsb/X8lP5jfDmAwVvA9u2P+Y+/Y+5PLoy022c/gUhRu
         nZFwVYmnu8qFtOWUyLPMLn7A+kS2pohmXN4oA3PoTFluxi6rKyr/QRm/Zqo6s/mlX2
         WvnLHNrBApZjQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 07 Jun 2023 19:11:04 +0300
Message-Id: <CT6JSVJSSBN6.FDKEQEMESYD7@suppilovahvero>
Cc:     "Bagas Sanjaya" <bagasdotme@gmail.com>,
        "Franziska Naepelt" <franziska.naepelt@googlemail.com>,
        <keyrings@vger.kernel.org>, <dhowells@redhat.com>,
        <dwmw2@infradead.org>, <linux-kernel@vger.kernel.org>,
        "Franziska Naepelt" <franziska.naepelt@gmail.com>,
        "kernel test robot" <lkp@intel.com>,
        "Linux SPDX Licenses" <linux-spdx@vger.kernel.org>,
        "Linux Kernel Janitors" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH v2] certs/extract-cert: Fix checkpatch issues
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Ben Boeckel" <me@benboeckel.net>,
        "Dan Carpenter" <dan.carpenter@linaro.org>
X-Mailer: aerc 0.14.0
References: <20230601190508.56610-1-franziska.naepelt@gmail.com>
 <20230602085902.59006-1-franziska.naepelt@gmail.com>
 <ZH8mhIrjyBvTF4oZ@debian.me>
 <e39efb7f-5d8f-4433-83b3-8eea8a6c0486@kadam.mountain>
 <CT5NH4XXIYQF.5XXJE6JA5FZP@suppilovahvero>
 <e44d03cf-9993-483c-b3d4-6185f5c028cc@kadam.mountain>
 <20230606214350.GA142397@farprobe>
In-Reply-To: <20230606214350.GA142397@farprobe>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Jun 7, 2023 at 12:43 AM EEST, Ben Boeckel wrote:
> On Tue, Jun 06, 2023 at 18:25:24 +0300, Dan Carpenter wrote:
> > I'm looking through the git log to see if it's true the imperative tens=
e
> > commit message are shorter and better and neither one of those things i=
s
> > obvious to me.
> >=20
> > This patch had an imperative subject already so it was already kind of
> > imperative.  Does every sentence have to be imperative or can you just
> > add a "Fix it." to the end?
>
> I don't know about the length argument, but it feels like it reads
> better when skimming summaries with the imperative mood. The way I think
> about it is that the subject should complete the phrase:
>
>     When applied, this patch will=E2=80=A6
>
> The body then gives more context and description as necessary. I don't
> really worry so much about the mood/tense/whatever in the body except
> that I try to use the present tense for anything the patch is doing and
> past for any historical context. I understand that kernel maintainers
> may care a lot more about it though.
>
> Basically, a patch, on its own, does nothing (just like a recipe). It is
> only when it is applied that anything actually happens. I read it as
> "`git apply`, please $summary".
>
> --Ben

+1

BR, Jarkko
