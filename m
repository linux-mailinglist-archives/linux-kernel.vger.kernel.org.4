Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362236CA602
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjC0Ndx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjC0Ndv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:33:51 -0400
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF7840F6;
        Mon, 27 Mar 2023 06:33:39 -0700 (PDT)
Received: from mail.panix.com (localhost [127.0.0.1])
        by mailbackend.panix.com (Postfix) with ESMTPA id 4PlYg55F43z3ylY;
        Mon, 27 Mar 2023 09:33:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1679924018; bh=XICY4RRKygbQi2CVdXFQeV33XyQxJ7V0bluLpAxLDNA=;
        h=In-Reply-To:References:Date:Subject:From:To:Cc;
        b=NMHCBGphWj2m+reulHlyOnuQ0TJi9yFvpAQr/VqpFST6E+oZWJ9CeyLhJXcFL9Vmk
         aUaL6pjGuJowrbRV5sjVQVHH8QM+rzR1tG5u1BSkSgCOMud6t14/XawsfH9wXkryft
         x0YZqb83+QO4rewtqMDlz+rLwi/Tj41jzfyrxPSc=
X-Panix-Received: from 166.84.1.3
        (SquirrelMail authenticated user pa@panix.com)
        by mail.panix.com with HTTP;
        Mon, 27 Mar 2023 09:33:37 -0400
Message-ID: <bd57500b3900e5cce3f1a65de59959bc.squirrel@mail.panix.com>
In-Reply-To: <CAJZ5v0gAyGNAT-t=pQ9wEbNAqzixEfm5dKZuRJVv-YQ=1=LbFw@mail.gmail.com>
References: <5687037.DvuYhMxLoT@kreacher>
    <11fab8f24f976112aa4d025d03f0f322.squirrel@mail.panix.com>
    <CAJZ5v0gAyGNAT-t=pQ9wEbNAqzixEfm5dKZuRJVv-YQ=1=LbFw@mail.gmail.com>
Date:   Mon, 27 Mar 2023 09:33:37 -0400
Subject: Re: [PATCH v1] ACPI: bus: Rework system-level device notification
 handling
From:   "Pierre Asselin" <pa@panix.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Pierre Asselin" <pa@panix.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Linux ACPI" <linux-acpi@vger.kernel.org>,
        "LKML" <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?=22Uwe_Kleine-K=C3=B6nig=22?= 
        <u.kleine-koenig@pengutronix.de>,
        "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
User-Agent: SquirrelMail/1.4.23-p1
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Mar 24, 2023 at 4:54 PM Pierre Asselin <pa@panix.com> wrote:
>>
>> Rafael, the patch is good for 6.3-rc1 (boots to early userspace).
>> I'll try a full install now.
>
> I'm wondering if this has succeeded?

Yes.  I've been running 6.3-rc1 + Rafael's patch for a few days now
and all is well.

(Okay, the simple framebuffer has psychedelic color effects but that too
has a workaround.  One bug at a time.)

Are these emails getting through ?  I see them on patchwork but not
on linux-acpi or regressions.

--PA

