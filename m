Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA716248F4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbiKJSCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiKJSBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:01:50 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716694B997
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 10:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lohu.info;
        s=biln2210; t=1668103301;
        bh=SlKZRS1lnV0KZqSIMONQPMQ+02L/0r0w2Czs81QGpOA=;
        h=From:To:Subject:Date:Message-ID:MIME-Version;
        b=AOZdFXH9VC8W13oLlIRa8q7kLnvmw6SdLHvt3kdpib6wdL6GjDp9vxWRh2ZPkUu7R
         Jgzt2VGOjU4/yjPzcEEuYks3pLzBBYpahOe6dP360A9tQZuPxeTckW9dj/nrr67vm/
         UQIgrGt+nznbKxU8vqi+pZtAs7k/qBsiZ8qgAlYc=
X-QQ-mid: bizesmtpipv602t1668103299teab
Received: from SJRobe ( [255.71.210.0])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 11 Nov 2022 02:01:38 +0800 (CST)
X-QQ-SSF: 01100000000000G0Z000000A0000000
X-QQ-FEAT: 6/K5pWSRdGpR3UVf1JxOSnQkX/poCupQgKpREd4A5pADjU64IITefWvTphgrl
        5fVIyLcwfNiYPbYv+X5q4LWya9md6TQgGtwXRgbZSQyH8Sv7/Tt36PZ+qBCu6i4NlJNMgGW
        zojol2zXra88TajMc0pVLgfeP6X8dI/QCVoMdKB4gR+cVehIWeKmE279OZVyAnOG1GI4xAw
        9GVL3jFZLJaRW2u7y+PsrxIVZSSDSXAO4oNeeqQIRDDVimKerL/MRZr1bTD7zIGp9ARnnxp
        I8rFx0L29ougzPQGCvhXtZ/uqtw1Ndd80Z8fetENGNwgqxGTdgRUBIFfzR9QfrkIoXFspGY
        Jlw8ty3LOMjgm7Xv9qpnVijwyywSg==
X-QQ-GoodBg: 0
From:   "Soha Jin" <soha@lohu.info>
To:     "'Greg KH'" <gregkh@linuxfoundation.org>
Cc:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Wende Tan'" <twd2.me@gmail.com>
References: <0E39B15006ADC205+02a601d8d4f8$a00a09e0$e01e1da0$@lohu.info> <F789F6E98A6F9BF5+1d8501d8dc56$74036f70$5c0a4e50$@lohu.info> <Y0O5//6A3VvT7S5Z@kroah.com> <07EF40D2C259BC45+249601d8dc76$f05f03c0$d11d0b40$@lohu.info> <Y207JTskpwEUTD7X@kroah.com>
In-Reply-To: <Y207JTskpwEUTD7X@kroah.com>
Subject: RE: PING: [PATCH] platform: use fwnode_irq_get_byname instead of of_irq_get_byname to get irq
Date:   Fri, 11 Nov 2022 02:01:37 +0800
Message-ID: <B5F141EF604E5616+288101d8f52e$7ac2d800$70488800$@lohu.info>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGbqugtR3NtpzGFsVDN54JrNGFkNwLyBvmkAZL2edUBiUCZaQIrCAGurnE7meA=
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

Hello Greg,

> -----Original Message-----
> From: 'Greg KH' <gregkh@linuxfoundation.org>
> Sent: Friday, November 11, 2022 1:56 AM
>=20
> Your patch is corrupted and can not be applied :( You could have =
tested this
> by picking it up from lore.kernel.org and verified that it worked.
>=20
> Please fix your email client and send a new version.
>=20
> thanks,
>=20
> greg k-h

I sent a PATCH v2* several days before. This patch's format should be
good and I removed a meaningless if-branch.

Regards,
Soha

* https://lore.kernel.org/all/20221028164120.2798-1-soha@lohu.info/

