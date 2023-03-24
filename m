Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344106C81DF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjCXPyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjCXPyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:54:05 -0400
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027DD15147;
        Fri, 24 Mar 2023 08:54:03 -0700 (PDT)
Received: from mail.panix.com (localhost [127.0.0.1])
        by mailbackend.panix.com (Postfix) with ESMTPA id 4PjmwV5V7Vz48TK;
        Fri, 24 Mar 2023 11:54:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1679673243; bh=cpWNQV1BBSDO58L8+KL5nGd6M14YxtXoIXU6SBKTF5U=;
        h=In-Reply-To:References:Date:Subject:From:To:Cc;
        b=m7rcBRod9vU/C2TwISSn57ePAR/arM7FJD9tn29MqQLATz5TNBd91uWPJ7SAOWE11
         QDw/m04U/qAzy04x9it3bq3d6Mtmt3fJGG4j5dbpyA35kjxe7y/nWWIzj413pi0Ij6
         Nqy40AsAuj6+3l1EjV+1MS+bx3lny+8JXk3H5paQ=
X-Panix-Received: from 166.84.1.3
        (SquirrelMail authenticated user pa@panix.com)
        by mail.panix.com with HTTP;
        Fri, 24 Mar 2023 11:54:02 -0400
Message-ID: <11fab8f24f976112aa4d025d03f0f322.squirrel@mail.panix.com>
In-Reply-To: <5687037.DvuYhMxLoT@kreacher>
References: <5687037.DvuYhMxLoT@kreacher>
Date:   Fri, 24 Mar 2023 11:54:02 -0400
Subject: Re: [PATCH v1] ACPI: bus: Rework system-level device notification
 handling
From:   "Pierre Asselin" <pa@panix.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Linux ACPI" <linux-acpi@vger.kernel.org>,
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

Rafael, the patch is good for 6.3-rc1 (boots to early userspace).
I'll try a full install now.

--PA

