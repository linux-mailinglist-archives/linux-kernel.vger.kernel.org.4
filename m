Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CFB6837A3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 21:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjAaUi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 15:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjAaUi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 15:38:56 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94D959243;
        Tue, 31 Jan 2023 12:38:45 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4D7EB31A;
        Tue, 31 Jan 2023 20:38:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4D7EB31A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1675197525; bh=opNOf0bwZz0Eg6scZHkYbncLARrd3D/2ZOxCiFrK0hA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=hfXGurOVD63Ye4OdgH2ghZ1IY4t/vqsYxd9x/00gnbcHd9AGaEMBpic8O9k3UyVgB
         kPGgkWEvLsYFbK7+y1iY9vEMPQs+PafQkXBbGQinMb2azM9qTlCG/ddFefYrJrozmY
         L2bENgwydRZP+xU4x/nlofLwMNrD6msixRSxF/4eqSWPNTLayZGjs/M93xvTmRw271
         EKSGJwmFL2bxgMlc9InFicVRE68bYDJ9tKcF1lcQLgVs197obD38A/kdgj8dCBdzmn
         45tyrQz1pSGVdirVdcZO4BZDqelMZfysatH2c+AHediuwbsJcBZuddk8U1s6AtM2Wk
         CunEF9sipdt6w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-doc@vger.kernel.org
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: coccinelle: Escape --options to fix
 Sphinx output
In-Reply-To: <20230129151408.1525324-1-j.neuschaefer@gmx.net>
References: <20230129151408.1525324-1-j.neuschaefer@gmx.net>
Date:   Tue, 31 Jan 2023 13:38:44 -0700
Message-ID: <87tu0630dn.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> writes:

> Without such escaping, -- is rendered as =E2=80=93 (en dash).
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---
>  Documentation/dev-tools/coccinelle.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

jon
