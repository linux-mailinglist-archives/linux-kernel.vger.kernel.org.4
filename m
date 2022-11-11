Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A72C62570D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbiKKJmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiKKJmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:42:14 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBDA6F359
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 01:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lohu.info;
        s=biln2210; t=1668159728;
        bh=6TWfla3heOtAprsw1myku4WcdbdDiEILx+Sip2tFN5M=;
        h=From:To:Subject:Date:Message-ID:MIME-Version;
        b=h8iopr6mToAUhrv11EuHUgegzKS7U13FsYBbgPi9LxwKEt+jr7RHazC4NIAaCmXmr
         cE124CHr6/JgORc7B4dKHSZX1Hg+0b+zvGUAH50JItdFA8GWI7Ko5SU9FkYXJM84Ot
         EUyeAlkNO0jvBZfCfGlsoC3kIA2BXh+fT2fHaLq8=
X-QQ-mid: bizesmtpipv602t1668159725tvip
Received: from SJRobe ( [255.89.210.14])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 11 Nov 2022 17:42:04 +0800 (CST)
X-QQ-SSF: 01100000000000G0Z000000A0000000
X-QQ-FEAT: abxxcdK0JW6BtgDzVuCGZnsCqsggIbWc3Y3lIq3i1ZJ66NVpVK1fPjRF0Crcc
        wYIkq6W/sKjSmZL0DCTTh6AixzzXED1nlHMlKSjBoP8q8dzMSVyPktvdzDOVu4VTBK5rNz/
        Rs/e51iPrCiqmT6/DJY+8RDizSVX4qEDoHpqfd1OY8lzTsiyUVEhaYPWqrZeFhMclsMJhqI
        bDCrNVcW9cBSzWtPoIhD4fVptJ5nwMGKzRGRQXjQO/nG+0MrK0ciStqJv7tHkXqMV4wUU/7
        hTR9mfcTaud7OEb8jthwX7/lP8S8iwdrfDIZtXWuaThi4tZ22wfMPVEhFMNC/t6vky6Qih+
        1/VUftuyeom/e7mEi2WKULqN0IDHaDDe9UFhNuUanX6wahWthU=
X-QQ-GoodBg: 0
From:   "Soha Jin" <soha@lohu.info>
To:     "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>
Cc:     "'Rafael J. Wysocki'" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, "'Wende Tan'" <twd2.me@gmail.com>
References: <20221028164120.2798-1-soha@lohu.info> <DS0PR05MB95440932459F31AA76618A75DA009@DS0PR05MB9544.namprd05.prod.outlook.com> <Y24NPPF+6CM6b/d2@kroah.com>
In-Reply-To: <Y24NPPF+6CM6b/d2@kroah.com>
Subject: RE: [PATCH v2] platform: use fwnode_irq_get_byname instead of of_irq_get_byname to get irq
Date:   Fri, 11 Nov 2022 17:42:04 +0800
Message-ID: <0DC3B09947627421+033401d8f5b1$dbcd48f0$9367dad0$@lohu.info>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJW0/kaaJVFezSz0P9aVK3IkiqSVAJJO/DOAr0N53CtFYjowA==
Content-Language: fr
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpipv:lohu.info:qybglogicsvr:qybglogicsvr3
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_ILLEGAL_IP,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Friday, November 11, 2022 4:52 PM
> 
> Please submit a fixup patch, sorry, I can't rebase that branch now.
> 
> greg k-h

Got it, I withdraw this patch.

Soha

