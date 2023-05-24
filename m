Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C38770FDE2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 20:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237137AbjEXS2Y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 May 2023 14:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237272AbjEXS2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 14:28:19 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325A010B;
        Wed, 24 May 2023 11:28:18 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-50d897af77bso321159a12.1;
        Wed, 24 May 2023 11:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684952896; x=1687544896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQCQ7wtjbEXNy+OLVRDNEyNz7R7ia4hhY3Kder7pF6M=;
        b=bw+KeEfEr8m04dyr5mM3qmDQy9NcJlo2g/hyLxoZIsJamo9D3wSHZfc2kpCEgnp77R
         x9NNU/9PIqsDrj+Bh6Un90FJcpnkW9cVFMAfkkKMlhDnkdcFQSTQQlSTwlB1aALyyifx
         VRCRT3B6JhHC8C5+OgJg/XqoCzNrBIs9NM5DKXyWhgref5zxg4fKu/0ZO+xdFnvnv9Up
         leBzj+BhE4x5dVce+M3QtjYdoATsP+Hu7BLtf9oaBBVIGTSV7ITZAOaLWQxDcHRi8+9E
         YnjcOFnV37+Q1jDIRuc4q+gf9Tab+FRNuLfJmLeHE6JBtHRVeRzWPCBThA7XBdO4WZXt
         qVrg==
X-Gm-Message-State: AC+VfDyFrLVKXSxYcT0hLq/lYk4p/0Qc+RN5Bdr3U5d5qv5tooTMXYQo
        wja6IFsB9gMiePhuzoElY2gPHw3fc6kid4uVXIQ=
X-Google-Smtp-Source: ACHHUZ74pXxKlBSWaO1LVd3NfiSQAOR18STmBBOu3O3e4hlndYS5KMLsEZL11CQZzjkWTWJVE3m0mSjkTwEJ/CqNESw=
X-Received: by 2002:a17:906:2218:b0:96f:4c38:4b1a with SMTP id
 s24-20020a170906221800b0096f4c384b1amr16513902ejs.5.1684952896552; Wed, 24
 May 2023 11:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230522200033.2605-1-mario.limonciello@amd.com>
 <20230522200033.2605-3-mario.limonciello@amd.com> <ZGzwCdTO2LptPeQs@surfacebook>
In-Reply-To: <ZGzwCdTO2LptPeQs@surfacebook>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 May 2023 20:28:05 +0200
Message-ID: <CAJZ5v0hO4hq=TLZ=tK5vXv_pA4SsAo5Gqr5K9g=EU6bFRPYU6g@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] pinctrl: amd: Use pm_pr_dbg to show debugging messages
To:     andy.shevchenko@gmail.com
Cc:     Mario Limonciello <mario.limonciello@amd.com>, rafael@kernel.org,
        hdegoede@redhat.com, linus.walleij@linaro.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pm@vger.kernel.org, Shyam-sundar.S-k@amd.com,
        Basavaraj.Natikar@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 6:55 PM <andy.shevchenko@gmail.com> wrote:
>
> Mon, May 22, 2023 at 03:00:32PM -0500, Mario Limonciello kirjoitti:
> > To make the GPIO tracking around suspend easier for end users to
> > use, link it with pm_debug_messages.  This will make discovering
> > sources of spurious GPIOs around suspend easier.
>
> Unfortunatelly this has two regressions.
>
> ...
>
> > -                             dev_dbg(&gpio_dev->pdev->dev,
> > -                                     "GPIO %d is active: 0x%x",
> > -                                     irqnr + i, regval);
> > +                             pm_pr_dbg("GPIO %d is active: 0x%x",
> > +                                       irqnr + i, regval);
>
> Regression 1: The device is now omitted from the output.

Right.

> Regression 2: See https://stackoverflow.com/a/43957671/2511795

Care to elaborate?  I'm not sure what you mean exactly.
