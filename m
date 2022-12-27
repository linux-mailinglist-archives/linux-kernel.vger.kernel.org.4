Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E32656D17
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 17:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiL0QsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 11:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiL0QsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 11:48:11 -0500
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DF5DDC;
        Tue, 27 Dec 2022 08:48:07 -0800 (PST)
Date:   Tue, 27 Dec 2022 16:47:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1672159683; x=1672418883;
        bh=wtoco/5MxVglB9TMggmrpENeQZoOWyeOEtN5OxMDVRk=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=SekKAk3P1lN0qxIGh5VIoFIfyj93uYBQocRHrHTtXlI0Pl83hQ41mG05NZgjV1HRg
         ygaHSo+/QCwUaBHqcVBd3egL5cEcocQQEkb2U1EijU2FMSvyaHJHwhWa4hrukfUiAl
         6ygaF6c6Qi+TfWLz3nCfrjZCx1jnt4a/BE4b//+1QcxtEK4WlpavjCXqGkXLIx/xbc
         ePYNs/pSG0YVdwtX2wonoBqpgFN0qkCDCEAxSQ7ypxXKuNL+epGXSan7gw4VGdKSYf
         B0zbrZWJnA6ecPGwU25b1NEg+coEKPctH54NRHLmu+6pp3iXxnp3ms55jfIuJIkfy5
         LPJo6pBA4bMKg==
To:     Lee Jones <lee@kernel.org>
From:   Joseph Strauss <jstrauss16@proton.me>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, jansimon.moeller@gmx.de,
        christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH RESEND] Add multicolor support to BlinkM LED driver
Message-ID: <20221227164748.r7ouwpptb4lxbdxq@libretux>
In-Reply-To: <Y6Wb1+VrutfKtGIo@google.com>
References: <20221214222428.7518-1-jstrauss16@proton.me> <Y6Wb1+VrutfKtGIo@google.com>
Feedback-ID: 52406082:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/12/23 12:15PM, Lee Jones wrote:
> On Wed, 14 Dec 2022, Joseph Strauss wrote:
>
> Would you mind composing your mails such that my Key Manager doens't ask
> me for a password in order to view them please?
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
I would be happy to, but I am not sure how to diagnose or fix the
problem. I used git send-email to send the patch. I have no such problem
when viewing the email from my own client. I looked at the email headers
and did not see anything out of the ordinary, and the thread shows up
fine on lore.kernel.org. Is there any other information you can provide
about the problem? Has it happened before?

Best Regards, Joe

