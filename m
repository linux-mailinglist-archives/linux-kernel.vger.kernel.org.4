Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD19D70E82F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 23:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238394AbjEWVzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 17:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbjEWVzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 17:55:18 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184EB1B1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 14:55:00 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-25377d67da9so52990a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 14:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684878891; x=1687470891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2Khn/X5BFP35sORRUAalqrCWcCg/ZE1zKWkZK2Ints=;
        b=iH36F7O+tgNNWrXI+fUOzFUcy+LBVneHtL1NhB773zwjkLHUHVcWQdE7N9qZNNuTi9
         CHuiKHqAyBcprmU1Ve7NVB2pXhRqSpuzubz2w6OPMHGO685f/FYAWBysF2S60we9N2D4
         KWsC+9/9+X2ySbPGonXS1ZMdAu8Pe2f0igrRvlXjsFsFg/dc9Dv7wrKajg9T0eX8nGWw
         /m8uF/aPi2wxlI9iAG9TPr0KOZEk4NN7olJG15AruvlShrmqvZ3j9eUuA8KDXJ78NBBv
         l8RBGp333lXdwSJJEZjftJ1DLAGZ1zFmU7/fBrAQLV8kge6j5qXNzreyzOcCJjAcdkTs
         PVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684878891; x=1687470891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2Khn/X5BFP35sORRUAalqrCWcCg/ZE1zKWkZK2Ints=;
        b=djJ4YPKDrExxWBPGKMtjWPZ8bQ16OTDDLDwvW7MI/WXc8z1bdx6QvgjTlX0qQHmVFK
         nHcmIIOvZMj6AZEN6wacqv0mooShIJx2nDO/rdj0rX/oM7mdluf/2yd7ig4YMvNlkoB+
         Fq+bWtePQMUY5XaDlGIDAvOPlGmt6+oY9h8HhcpvoOTfEBLB392XevCFdJIP2mKinFb5
         8QdHr0pF2Fv0cDJ5mGSqc6ib3/muFTzNQWghfEN3DJ4wElqo1/uQHGQ6byPzPg0NBaIN
         008bvDiYfzeTHqXTi0WPMNdxVrUyyHqDPctc2hKvkSb4jNrR7uwi9uR6oULbiS4Rk2RB
         i3Jw==
X-Gm-Message-State: AC+VfDxJxdGPmcAu1pgrP3qgIu4GKzB/imbmqIq2yJoCRtKn1ZkWpVwl
        p2b+8SJKhNZQfZ+Yp0elYmwiSpgTDnM83KATqgE=
X-Google-Smtp-Source: ACHHUZ4Rf2HUpFkfUOAkz248KrmtuMFtd0znC08K7WNg0cw80uvvXFQsyQ8f2KTzRpLSPDzBnHCUxN/StxzZNVJ6BiU=
X-Received: by 2002:a17:90b:1bc1:b0:252:b875:6a57 with SMTP id
 oa1-20020a17090b1bc100b00252b8756a57mr597125pjb.3.1684878890714; Tue, 23 May
 2023 14:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230523212829.2539417-1-otavio@ossystems.com.br>
In-Reply-To: <20230523212829.2539417-1-otavio@ossystems.com.br>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 23 May 2023 18:54:38 -0300
Message-ID: <CAOMZO5CuxATFVYJqpQY1kfFCo9rquLu_P2HvqpUPfoMsy_i1cA@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx_v6_v7_defconfig: Remove KERNEL_LZO config
To:     Otavio Salvador <otavio@ossystems.com.br>
Cc:     shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org,
        Alistair Francis <alistair@alistair23.me>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Hansson <newbie13xd@gmail.com>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Otavio,

On Tue, May 23, 2023 at 6:28=E2=80=AFPM Otavio Salvador <otavio@ossystems.c=
om.br> wrote:
>
> The KERNEL_GZIP is used in most config and is the default, there is no
> clear reason to diverge so let default be used.
>
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>

CONFIG_KERNEL_LZO=3Dy was introduced in 2011 by the following commit below:

06965c39b4c6 ("ARM i.MX5: update defconfig")

imx_v6_v7_defconfig and sdk7786_defconfig are the only defconfigs that
select CONFIG_KERNEL_LZO=3Dy,
so it seems fine to remove it:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
