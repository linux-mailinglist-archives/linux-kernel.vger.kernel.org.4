Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037B16FF107
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 14:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238050AbjEKMF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 08:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238043AbjEKMFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 08:05:11 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4E2DD88
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 05:03:51 -0700 (PDT)
Date:   Thu, 11 May 2023 12:02:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pen.gy;
        s=protonmail2; t=1683806546; x=1684065746;
        bh=86/i7IChbmfl8+8EyoMdZEJ+YeBfSZDsg+eZHOe/304=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=cg3xwNPEU07udb0b+q0BOz/QqBeREAEAO5qekw6E+ZM+pM5b3PB69UAbGgh9ZN7+J
         QbQQTFmF9zLzOdBxyx8FXOrj7qMeCKsKkmona/JPQV1Tid2BogZZmZO02V/4ZNxUyj
         +KCQplJF0PXhic4cidB5SX6Iiv83nO1SZXw3val/RzpuXBp9qTnFRtsiZj7sx2FesU
         2tXFdtLr16q1dYSRtBoyLGZU6TWZwayE/2qgENvSNO/LrHOrxmNKs2XyIR4X3TdzeD
         rD78xgubMHeNc6QS6bJnr8yXPok4U3fGu39faOqycZQKr3/5JGo4EqtJexulH5g1Oh
         xpry07ei9/D6g==
To:     Georgi Valkov <gvalkov@abv.bg>
From:   Forst <forst@pen.gy>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: net: usb: ipheth: add CDC NCM support
Message-ID: <C1lCmpZY7M2QToZGt4ihBCKBHAjyQ4MssYLUheV7tyHA66LovXU1XvE0UAQEyF1Znoy2CAa_XamQm41fa3Eh0r3cVC19qTbavOhesrSX0fc=@pen.gy>
In-Reply-To: <0A1C2108-75F2-46B7-8712-616FE6464294@abv.bg>
References: <0A1C2108-75F2-46B7-8712-616FE6464294@abv.bg>
Feedback-ID: 31160380:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> I added the author Foster Snowhill to this mail, as well as a link to his=
 Github [1].
> If needed, we can ask him to add the tag Signed-off-by:

I do not mind my patch being reviewed and included in Linux kernel if it is=
 deemed of good quality. I would like to point out that I wrote it for pers=
onal use and may have cut some corners, so I likely missed some places when=
 it comes to code style and data validation. The latter is important from a=
 security standpoint, so extra attention to that would be appreciated.

If I need to resubmit it myself, and maybe to a different mailing list, ple=
ase advise on the appropriate procedure.

Thank you!

/ Foster
