Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0E77161C8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbjE3N14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbjE3N1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:27:51 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D93F9;
        Tue, 30 May 2023 06:27:48 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-25692ff86cdso1472048a91.2;
        Tue, 30 May 2023 06:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685453268; x=1688045268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxfP3PRs63IfK4daCw0hIf2KKTRvNqm5thT3Lh4jEBs=;
        b=YB3Q4Sh0Jv4Wtvq1DOES2tNij/vSAOP+HVxYE3XER2pnAGUozxsE0yzqlEwMIHeSJM
         +KjaE9g5n76I8mmwB5m6IncLPjcT2XK5LmIUgZALeKEPw+lGZQZEJ2nBmZ2sJ3tzO79e
         PGigDcqnzwDi8ZndrVO8SxVMKcGxn512HshgjicbCyvjQMMRSzODz7Udh8kXjKVShvNj
         T8QC+Du5t7weH3Qma7/aABfMLJRPGx1rAsKJ3pOFLTA6PWIMjcDVQsibV4DZtHEO1ClW
         KWPhR/IKZy5ZH0I8CWouHfgL0qom3XAKmWsHHo/R+549sspTwiVIpJR+pCICgIEPe9cz
         IASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685453268; x=1688045268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QxfP3PRs63IfK4daCw0hIf2KKTRvNqm5thT3Lh4jEBs=;
        b=Nn6l6ILzNH71keaSDD2wZkyRII6TqucGo0lcIYzQPzXjA0zrNvRChHCbw7cpnh6wp/
         qPpgCyG+2x3NH+k9CkmkxI885lij94eMhpJJh04Ie2e/cFZvUzwEEolK+GbhgXpU6rOS
         LEfsSB4c0E1ShxdM4spfJIm7Pr3bDIraGXcVzDiHsGmD55ayQvr3JDMmv6RDwbCkBF23
         Lf4+vQMVD6VSQpqOni4miB/DMXlZ404ZQXlXkeuiHu4OgEYhr080Ct+MIsVpMLHM0iwZ
         tiEh4gp6Q/PI7uMCsvIm1IPz/j9iFhBRLbqabNGR6tWIX/bbcvjEoi4izrdyfVRtStVG
         JhJg==
X-Gm-Message-State: AC+VfDxmZwZF5YWgyVtktu02huYZEhQBsofOKAZlhEM+Y0qqwZ1rN33A
        gkd2vVFzbZwmPDH9kfc4TLCycN5gOsUZ86XOZtE=
X-Google-Smtp-Source: ACHHUZ74pkLoULS1TARL4X7dp/BnUnF7FpTgEYo8qAGdbKvxisWrv3SU6MUtPs+aDDqrSkEYDvifCM0ppIYRqcEw0wM=
X-Received: by 2002:a17:90a:dc06:b0:255:3ab1:df80 with SMTP id
 i6-20020a17090adc0600b002553ab1df80mr2581743pjv.21.1685453267746; Tue, 30 May
 2023 06:27:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230524091948.41779-1-boerge.struempfel@gmail.com>
 <20230524091948.41779-3-boerge.struempfel@gmail.com> <49a6ca72-4958-421d-b83c-a9cd1f68596f@sirena.org.uk>
In-Reply-To: <49a6ca72-4958-421d-b83c-a9cd1f68596f@sirena.org.uk>
From:   =?UTF-8?B?QsO2cmdlIFN0csO8bXBmZWw=?= <boerge.struempfel@gmail.com>
Date:   Tue, 30 May 2023 15:27:36 +0200
Message-ID: <CAEktqcsdYFdCzSVv2gcBBwDC9i6P5JO+wWa=kwgtaTb=J_Uc9Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] spi: spi-imx: add support for SPI_MOSI_IDLE_LOW
 mode bit
To:     Mark Brown <broonie@kernel.org>
Cc:     bstruempfel@ultratronik.de, andy.shevchenko@gmail.com,
        festevam@gmail.com, amit.kumar-mahapatra@amd.com,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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

Am Di., 30. Mai 2023 um 14:46 Uhr schrieb Mark Brown <broonie@kernel.org>:
>
> On Wed, May 24, 2023 at 11:19:45AM +0200, Boerge Struempfel wrote:
> > By default, the spi-imx controller pulls the mosi line high, whenever i=
t
> > is idle. This behaviour can be inverted per CS by setting the
> > corresponding DATA_CTL bit in the config register of the controller.
>
> This doesn't apply against current code, please check and resend.

I wrote this patch against the current master and not the next/master.
I'll upload an adjusted patch version momentarily.
I'm sorry for the inconvenience.

--
Kind Regards,
B=C3=B6rge Str=C3=BCmpfel
