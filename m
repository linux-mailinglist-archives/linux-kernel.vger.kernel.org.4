Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7856F32D4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 17:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbjEAPZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 11:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjEAPZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 11:25:52 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3350171E;
        Mon,  1 May 2023 08:25:44 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6273044A;
        Mon,  1 May 2023 15:25:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6273044A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1682954744; bh=qwrk/iCFWd7ftOXBVRMr0yxgfCZkKwbi0RzzkBvHVIA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Z3L5EkF8jIFDKTIxRbei/aDiWMmZojPgRLsawzlOq5N8sSraEBTrQ7wYNGn4hIFxQ
         CEqssQmReCn/X8DkCgZd7TJ/xWVwf8LPM2WbftqLB7fpv4LFq6Tm8A8PDubcZddr3E
         FGzawb5aBQPVSY1neqSAHu4uIA/Yxw34jLExeTYpBKfXFMB5U4AyGfqCnjDUlxomF4
         g2nfNyhaobi3t0mX9Z8YNmjBnNqsk3Wmd8OnhpxA9D3MIPzLKsdEg7sQxaeG40Mg/y
         PYx9V7b8BLuW1U06QoOM75xdVUAwLiaLE3BE32R1pdHeZRTJGnU9UFsQWonr2u7ZTB
         pFx/O+vwyP5vg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Costa Shulyupin <costa.shul@redhat.com>, linux-doc@vger.kernel.org
Cc:     Costa Shulyupin <costa.shul@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] docs: consolidate human interface subsystems
In-Reply-To: <20230501150111.274666-1-costa.shul@redhat.com>
References: <20230501150111.274666-1-costa.shul@redhat.com>
Date:   Mon, 01 May 2023 09:25:43 -0600
Message-ID: <87h6sw9iq0.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Costa Shulyupin <costa.shul@redhat.com> writes:

> to make the page more organized as requested
>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  Documentation/subsystem-apis.rst | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/subsystem-apis.rst b/Documentation/subsystem-a=
pis.rst
> index b51f38527e14..287799ee2419 100644
> --- a/Documentation/subsystem-apis.rst
> +++ b/Documentation/subsystem-apis.rst
> @@ -10,6 +10,18 @@ is taken directly from the kernel source, with supplem=
ental material added
>  as needed (or at least as we managed to add it =E2=80=94 probably *not* =
all that is
>  needed).
>=20=20
> +Human interaces

This is the kind of thing that suggests that not a lot of attention is
being paid to the work you are doing.  This might be a worthwhile
change, but let's not introduce obvious typos while we're at it, please?

Thanks,

jon
