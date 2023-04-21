Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0B76EABF2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 15:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjDUNnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 09:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbjDUNnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 09:43:14 -0400
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33461387E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 06:42:46 -0700 (PDT)
Received: from mail.panix.com (localhost [127.0.0.1])
        by mailbackend.panix.com (Postfix) with ESMTPA id 4Q2wgj4dRTz48Zd;
        Fri, 21 Apr 2023 09:42:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1682084546; bh=ilKSAXYbb2I3tPDKY5tTE2ROdSFgRHhDclUFKT6+ApU=;
        h=In-Reply-To:References:Date:Subject:From:To:Cc;
        b=W0XJKCS1EOMytKJyx//xVUT6RCVCk8urGcWwzNCNZo6FHURPscK52TThLWj4C36S4
         ActEb0SHiKjBRi1sqqNHfZAvFTMxV1355G792EvHdEd3+PRHipOcJpWBF+d1u4JVW8
         IZBMD1YO0W+VtLPEQeD3LXULPCuSGFHiuUixjI5g=
X-Panix-Received: from 166.84.1.2
        (SquirrelMail authenticated user pa@panix.com)
        by mail.panix.com with HTTP;
        Fri, 21 Apr 2023 09:42:25 -0400
Message-ID: <40075ac685423d46663dd6a4038add90.squirrel@mail.panix.com>
In-Reply-To: <d8d22c77-1bde-774f-aa6e-41234ffa6e8d@suse.de>
References: <20230420155705.21463-1-pa@panix.com>
    <c4c09a67-6897-751c-c091-6e33f48542cc@leemhuis.info>
    <d8d22c77-1bde-774f-aa6e-41234ffa6e8d@suse.de>
Date:   Fri, 21 Apr 2023 09:42:25 -0400
Subject: Re: [PATCH v3] firmware/sysfb: Fix VESA format selection
From:   "Pierre Asselin" <pa@panix.com>
To:     "Thomas Zimmermann" <tzimmermann@suse.de>
Cc:     "Linux regressions mailing list" <regressions@lists.linux.dev>,
        "Pierre Asselin" <pa@panix.com>, dri-devel@lists.freedesktop.org,
        "Daniel Vetter" <daniel.vetter@ffwll.ch>,
        "Javier Martinez Canillas" <javierm@redhat.com>,
        linux-kernel@vger.kernel.org,
        "Hans de Goede" <hdegoede@redhat.com>,
        "Ard Biesheuvel" <ardb@kernel.org>
User-Agent: SquirrelMail/1.4.23-p1
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zimmerman writes:
>
> Am 21.04.23 um 13:32 schrieb Linux regression tracking (Thorsten
> Leemhuis):
>>
>> Pierre, Tomas, Javier, et. al: how many "legacy BIOSes" do we suspect
>> are affected by this?

So far, two:
1) my Gateway laptop (Intel(R) Core(TM) Duo CPU,
   Phoenix BIOS 83.08 Revision: 131.8 Release Date: 03/06/07)
2) my Dell Precision T3610 (Intel(R) Xeon(R) CPU E5-1650,
   Dell BIOS A19 Revision: 65.19 Release Date: 09/11/2019)

I don't know how to give a more precise description.

>> might it be worth asking Linus to merge this patch directly[1]?
>
> IMHO it's a fairly obscure bug and certainly not a release blocker. I'll
> send it through the regular channels of the DRM subsystem.

I agree.  Even when the regression bites, it's not a blocker.  The screen
is strange but readable.

--PA

