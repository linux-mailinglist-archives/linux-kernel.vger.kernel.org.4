Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44346DFD3C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjDLSMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDLSMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:12:51 -0400
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D639B211F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:12:48 -0700 (PDT)
Received: from mail.panix.com (localhost [127.0.0.1])
        by mailbackend.panix.com (Postfix) with ESMTPA id 4PxW5q4BRMz47j8;
        Wed, 12 Apr 2023 14:12:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1681323167; bh=DvXrenb9Kgk8Kq1FPp3NAzT+K5TJB88dBKyeYXg0qUE=;
        h=In-Reply-To:References:Date:Subject:From:To:Cc;
        b=Ev4IV7kaTaSnTFw5fwQIMzThRKaAuB3VYooO0MwC9OxuawXKoaJywqR7JYgIrZW5S
         JY0RWMxMiMz5J32Mkp9KkxH32QjDocoLh3g1vXldMTCXnS/QiahFpWoYCo7rD96sSE
         +bLeaEp2FQz22WestWfImV7vx2o8YLRsfg0susfM=
X-Panix-Received: from 166.84.1.2
        (SquirrelMail authenticated user pa@panix.com)
        by mail.panix.com with HTTP;
        Wed, 12 Apr 2023 14:12:47 -0400
Message-ID: <beeff0335ab4cc244d214a7baadba371.squirrel@mail.panix.com>
In-Reply-To: <87jzyhror0.fsf@minerva.mail-host-address-is-not-set>
References: <20230412150225.3757223-1-javierm@redhat.com>
    <2e07f818ccdff7023a060e732d7c4ef6.squirrel@mail.panix.com>
    <87jzyhror0.fsf@minerva.mail-host-address-is-not-set>
Date:   Wed, 12 Apr 2023 14:12:47 -0400
Subject: Re: [PATCH] firmware/sysfb: Fix wrong stride when bits-per-pixel is
 calculated
From:   "Pierre Asselin" <pa@panix.com>
To:     "Javier Martinez Canillas" <javierm@redhat.com>
Cc:     "Pierre Asselin" <pa@panix.com>,
        "Jocelyn Falempe" <jfalempe@redhat.com>,
        "Daniel Vetter" <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        "Hans de Goede" <hdegoede@redhat.com>,
        "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Ard Biesheuvel" <ardb@kernel.org>
User-Agent: SquirrelMail/1.4.23-p1
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Interesting. So you don't have the simplefb output that you had before ?

I do now, after a 'make clean' and "make bzImage'.

In between, I had tried CONFIG_SYSFB_SIMPLEFB=n .  That "works", by
falling back to vesafb in every case.  I restored the .config before
testing the patch, but there must have been leftover dregs in the
build tree.  1024x768x32 is garbled, others are good whether simplefb
or vesafb.

--PA


