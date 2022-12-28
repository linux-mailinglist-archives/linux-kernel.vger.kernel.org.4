Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C94065717F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 01:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiL1Avt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 27 Dec 2022 19:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiL1Ava (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 19:51:30 -0500
X-Greylist: delayed 399 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 27 Dec 2022 16:51:30 PST
Received: from orthanc.ca (orthanc.ca [208.79.93.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2113565AE;
        Tue, 27 Dec 2022 16:51:29 -0800 (PST)
Received: from orthanc.ca (localhost [127.0.0.1])
        by orthanc.ca (OpenSMTPD) with ESMTP id c95c0320;
        Tue, 27 Dec 2022 16:44:49 -0800 (PST)
From:   "Lyndon Nerenberg (VE7TFX/VE6BBM)" <lyndon@orthanc.ca>
To:     oss-security@lists.openwall.com
cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [oss-security] [patch] proc.5: tell how to parse /proc/*/stat correctly
In-reply-to: <Y6TUJcr/IHrsTE0W@codewreck.org>
References: <Y6SJDbKBk471KE4k@p183> <Y6TUJcr/IHrsTE0W@codewreck.org>
Comments: In-reply-to Dominique Martinet <asmadeus@codewreck.org>
   message dated "Fri, 23 Dec 2022 07:03:17 +0900."
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <93771.1672188289.1@orthanc.ca>
Content-Transfer-Encoding: 8BIT
Date:   Tue, 27 Dec 2022 16:44:49 -0800
Message-ID: <1a1963aa1036ba07@orthanc.ca>
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_20,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dominique Martinet writes:

> But, really, I just don't see how this can practically be said to be parsable...

In its current form it never will be.  The solution is to place
this variable-length field last.  Then you can "cut -d ' ' -f 51-"
to get the command+args part (assuming I counted all those fields
correctly ...)

Of course, this breaks backwards compatability.

--lyndon
