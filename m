Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBBD6617F8
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 19:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbjAHSS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 13:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbjAHSSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 13:18:16 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA52662DA
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 10:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673201891; bh=IgoNEV5yFSKde2udFiWluKLPJ7OsKHGGrG8yniFDmj0=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=nOidRUIvUN+iZDj0pPD/4vHl88ihXA7bhBSMXZoW6266vijwv5pIN8dTopgSLU5bI
         D+a868RRIN+5twMOajHYXzywxq4tzcMSwN53ml/LYYvO68t4f2zKHNg6KgRePLLxFV
         0ksX2YGlJo6b9jkEi9iXvbqTbAwfiIlYPxjv1mqU=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun,  8 Jan 2023 19:18:11 +0100 (CET)
X-EA-Auth: uSLRv9qm1A2QZhhWGvwGYiljfDZ+2JdiWqJ2qFwUVf6G/CL13xgh6G4tdbTTguHIluCGKvFQHETRz297YmTXSFuT/a4VFyRv
Date:   Sun, 8 Jan 2023 23:48:07 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     linux-kernel@vger.kernel.org
Cc:     joey.gouly@arm.com
Subject: Re: incorrect git diff output
Message-ID: <Y7sI36KCF8LRP8H0@ubun2204.myguest.virtualbox.org>
References: <Y7qA4o/JoWhfpvfk@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7qA4o/JoWhfpvfk@ubun2204.myguest.virtualbox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2023 at 02:07:54PM +0530, Deepak R Varma wrote:
> Hello,
> I tried to remove an extra semicolon on line number 1153 of this file
> drivers/scsi/qlogicpti.c and attempted a git diff to confirm my edits. To my
> surprise, the diff contained few other unrelated changes that I did not do. I
> tied to set aurocr git attribute in the .gitconfig file, but that did not help
> either.
> 
> Does anyone know about this behavior and how to correct it?


I had a setting in my .vimrc which auto-removes trailing spaces. Joey helped me
identify the same.

Thank you Joey!

Regards,
./drv

> 
> Thank you,
> ./drv


