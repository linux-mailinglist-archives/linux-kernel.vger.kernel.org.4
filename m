Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D906E822E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 21:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjDST4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 15:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjDST4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 15:56:33 -0400
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D96526C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 12:56:30 -0700 (PDT)
Received: from mail.panix.com (localhost [127.0.0.1])
        by mailbackend.panix.com (Postfix) with ESMTPA id 4Q1s4D5cR2z48Rj;
        Wed, 19 Apr 2023 15:56:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1681934189; bh=+fFGEN80heOFvMCfA1mGu8Lh0yeXbVFuWYiQrtdEiBI=;
        h=In-Reply-To:References:Date:Subject:From:To:Cc;
        b=fbBVOXffQL4DH5rHXTQjy+kN0stC8gnZWluumsN5sDK9enf/B8NFDB6Y3pqzJcPL6
         LxjhVUNWX5afQJJwb/NI7BE7EeXDzN6+Z76UxAV2QzdEtqPJtTkDpxxwXaqYyE1srj
         ijBcSPgbHJpqMcx5TvF5vb6dWCZI1tszBIBE2sAg=
X-Panix-Received: from 166.84.1.1
        (SquirrelMail authenticated user pa@panix.com)
        by mail.panix.com with HTTP;
        Wed, 19 Apr 2023 15:56:29 -0400
Message-ID: <daef19bc1a59c0bb19fc78b2cdedf07d.squirrel@mail.panix.com>
In-Reply-To: <87bkjki8p8.fsf@minerva.mail-host-address-is-not-set>
References: <20230419044834.10816-1-pa@panix.com>
    <87bkjki8p8.fsf@minerva.mail-host-address-is-not-set>
Date:   Wed, 19 Apr 2023 15:56:29 -0400
Subject: Re: [PATCH v2] firmware/sysfb: Fix VESA format selection
From:   "Pierre Asselin" <pa@panix.com>
To:     "Javier Martinez Canillas" <javierm@redhat.com>
Cc:     "Pierre Asselin" <pa@panix.com>, dri-devel@lists.freedesktop.org,
        "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Daniel Vetter" <daniel.vetter@ffwll.ch>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        "Hans de Goede" <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
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

Javier Martinez Canillas <javierm@redhat.com> writes:
> Pierre Asselin <pa@panix.com> writes:

>> Fixes: f35cd3fa7729 [firmware/sysfb: Fix EFI/VESA format selection]
>
> The convention is f35cd3fa7729 ("firmware/sysfb: Fix EFI/VESA format
> selection")

>> +		bits_per_pixel= max(bits_per_pixel, (u32)si->lfb_depth);
>
> You are missing a space here.

OK.  I'll fix that.  Thanks.

--PA

