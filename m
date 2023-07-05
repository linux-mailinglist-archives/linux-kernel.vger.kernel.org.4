Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F42B74914D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 01:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjGEXEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 19:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbjGEXEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 19:04:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716CC102
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 16:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1688598267; x=1689203067; i=aros@gmx.com;
 bh=etdIaVUvvD4UD6hlF8eKDN8D7NeHcllLCWU01AZ90Bs=;
 h=X-UI-Sender-Class:Date:To:From:Subject;
 b=YERS8SwRVG3KPGue8Qg+T10Z3NDlobOTnQRrBWv/LTAHuH2B3pr6ucWlHDrEtp2g17CNkkf
 8JMQKevGTdqDpGxvHasyPq1dJXQ9mtxcKwQMhpUHFMYHz45BuS2nEfBdJkKNycOkds+gPJ/Hj
 0DQHcpREJBdq2XJwAEvd/+ezKwWaFXjFYNabn8fQUA78yeJOLPByolwkG52/r4ZTd1vil54p+
 CM9Xk2dm1NDMMsrrS67QI2YcFwGFA/NF2hUyp0v49ufV/aGx0Go2hRwho0iJH2A1OknL9o+M1
 7f9ceGaOzaWncT0Feex+yji/tWfIdMw99nyM9quVqFtZKx3ZnxvA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.29.110.26] ([98.159.234.158]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MSKy8-1qS5cB2YC8-00ShEa for
 <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 01:04:27 +0200
Message-ID: <b1fbcb74-6ce9-3d0e-123b-7a8c5ddd2094@gmx.com>
Date:   Wed, 5 Jul 2023 23:04:26 +0000
MIME-Version: 1.0
To:     LKML <linux-kernel@vger.kernel.org>
From:   "Artem S. Tashkinov" <aros@gmx.com>
Subject: Disable IO accounting inheritance in the Linux kernel
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AlkjjB/ZbnqyQUJkbBiTumZVyrFG9I5+Plnh8nZbbQkg9aamZhO
 M6UuTSv/YtuBU3O3sdC1tDbDJb5mPrVdCkcWIy/XcoUByosP2jo/JKjgV0Uwy8jhseXUU4P
 f/K1SObeChtlv3KcvTBHAJvOmNUmzBVwXSi2u0f6D+dqaMoiJoJtDj8r+CGOwYxvRXsgIqo
 HhH1mHEXX5rS4uTTyECTw==
UI-OutboundReport: notjunk:1;M01:P0:A0Jox4HcNl0=;mFkQdubirF/j5Pja1He8Fp3yJg0
 dhl3ORrM2aSopkSqartB7y+8H3wblZGIodIkHX9TF7KHPX1n6wbwSi3FEz165slV+Cr4BrXLS
 Qihn4HRL7TGQeu0OzW119ynzG5o1Wl0ArFuRKtAAp/J3I4jADHzHcfrWYQI3Gz+aHdbh2V8Zt
 rm5YjUTb2h844xcH/W1pv52Q78s7zpNR2j2ALni02sJhhRvUGEUPgI/VPk0vO2HP23V9LsMIT
 3AAELr8L8r5xpJnO07msm22Qdi0ikjmkknhFke7RNZjb9MSJ5mnwhIWxqm4YhmWncDEewWZgt
 jeFKjtK0+UuTRlp4vB9U2N6Cw7eRiwQYV5L0TqaA12Hyn7pOOo7PVGaJI6NUXAkoZCBtfbtPX
 oJN6eexNrUJQlHTSFEYSyRy21TB2eRKE+i9IyJCbCpEI2zILxkHpNrQNd9j94U+1OZRZBVzGP
 Xbu+FHN+IOKWD1BemfMVAAlMO0NxJV9E/8MgLTo8j77gUfdc7arMaMymd1fxkM3Q7/frIQuU9
 Ghtw2TmabhkRY4mv213bTfIgCw+8bUkKRwjqXNEy96A5qkfl47eFXlzVd7SMG6BqmhAAXSDVP
 xaYceceIdwU3s28ctmLn/Rwo4LD0ebiwG/sDJzoWxq6HaEj+xr2gdWhdiZCMeCjmAF0+RdkOf
 ztgemqILCOG4X4xohdzvdiTh6ELVV2APT2KFsz3wg1QlzvEg9qnUjUrBTHmXdKRFtXdSOD/K4
 y6nQ3doywmSyhPTEtXljpt/zSS1e+YNPN7jcT2OdXHUUpOuNcMNUBgS9GRiG97EA5aauudDFm
 hTh7ajcBw4PGH/HDAfOAq0shWBKY2uYyCmwqhD+DZhKhkYnguBlC60r9ZtHrbtPbQNg19pZ63
 /IxvhynwD88qbMR1TImpRrgZhbP8mVN8Q9CmWRXM8HytjgmkNrZCFtvB72SYlwGsHr3ypCxAf
 /6NdDQ==
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

The Linux kernel does IO accounting, it calculates how many pages of
data the process has read and written (IO_READ/IO_WRITE).

Here's the issue: when an application launches another application which
does IO and the latter application exits, the former application
inherits (adds) the exited application IO read/write stats.

This could make sense for multiprocess applications like e.g. Chrome or
Firefox.

However it doesn't make any sense for e.g. your desktop environment.

Here's an example: I'm under XFCE. I launch an application from my
desktop. It exits. Now the xfce-session process has added all the IO
stats of the exited application. I do not want that or I want to have an
option of enabling this behavior only for certain applications.


Artem
