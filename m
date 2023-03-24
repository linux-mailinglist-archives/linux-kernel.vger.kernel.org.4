Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DAA6C8108
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjCXPUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjCXPTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:19:46 -0400
X-Greylist: delayed 386 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Mar 2023 08:19:45 PDT
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E079E1B307;
        Fri, 24 Mar 2023 08:19:44 -0700 (PDT)
Received: from mail.panix.com (localhost [127.0.0.1])
        by mailbackend.panix.com (Postfix) with ESMTPA id 4Pjm8v4Q9Dz45kY;
        Fri, 24 Mar 2023 11:19:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1679671183; bh=FNHtPVj0Z5TQhGNyWVptjbjyYYLjlLPuMXYY4PpJqAs=;
        h=In-Reply-To:References:Date:Subject:From:To:Cc;
        b=Ux7qKI16iY6oxjNuYfJjdULBSyevcrMdqXsqgltP+GxQbW8MksTujeKUucdP1bqRi
         /nXGZaUJc3bQXn9JbH5b8B6t9oxRoP3koFi76UrOMc2QiwXtFEWNWId3kTOq6FMmtC
         ryv3UCRGSexFsefECGobewDyVJ9zxSvc3N64ScgM=
X-Panix-Received: from 166.84.1.3
        (SquirrelMail authenticated user pa@panix.com)
        by mail.panix.com with HTTP;
        Fri, 24 Mar 2023 11:19:43 -0400
Message-ID: <8bd924c8d60c0e9ebad11495f6ac11ba.squirrel@mail.panix.com>
In-Reply-To: <1d7c19066c9b92aaa50bb06cf3ea539d.squirrel@mail.panix.com>
References: <5687037.DvuYhMxLoT@kreacher>
    <1d7c19066c9b92aaa50bb06cf3ea539d.squirrel@mail.panix.com>
Date:   Fri, 24 Mar 2023 11:19:43 -0400
Subject: Re: [PATCH v1] ACPI: bus: Rework system-level device notification
 handling
From:   "Pierre Asselin" <pa@panix.com>
To:     "Pierre Asselin" <pa@panix.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Linux ACPI" <linux-acpi@vger.kernel.org>,
        "Pierre Asselin" <pa@panix.com>,
        "LKML" <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?=22Uwe_Kleine-K=F6nig=22?= 
        <u.kleine-koenig@pengutronix.de>,
        "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
User-Agent: SquirrelMail/1.4.23-p1
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Rafael, the patch doesn't apply off of 6.3-rc1.

Weird.  All the line offsets are good.  I guess I'll be patching by hand
and checking against git diff.

--PA


