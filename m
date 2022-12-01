Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8E163EABC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 09:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiLAIAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 03:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiLAH73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 02:59:29 -0500
X-Greylist: delayed 577 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Nov 2022 23:58:40 PST
Received: from smtp1.rz.tu-harburg.de (smtp1.rz.tu-harburg.de [134.28.205.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B54163D65
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 23:58:39 -0800 (PST)
Received: from mail.tu-harburg.de (mail4.rz.tu-harburg.de [134.28.202.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.tu-harburg.de", Issuer "DFN-Verein Global Issuing CA" (verified OK))
        by smtp1.rz.tu-harburg.de (Postfix) with ESMTPS id 4NN7Vy6CD5zxSK;
        Thu,  1 Dec 2022 08:48:58 +0100 (CET)
Received: from mailspring.rz.tuhh.de (mailspring.rz.tuhh.de [134.28.202.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ccd5802@KERBEROS.TU-HARBURG.DE)
        by mail.tu-harburg.de (Postfix) with ESMTPSA id 4NN7Vy5f1tzJrFd;
        Thu,  1 Dec 2022 08:48:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuhh.de; s=x2022-48;
        t=1669880938; bh=DUdudZw64Gb6hkXkWx5ri1/AJvVqw2R3o6BjZY7I9Es=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
         Content-Transfer-Encoding;
        b=SPaXVYLMn59nD4ExZ2uqb8dbRrsjbQPtZ2I9ElNBk+2AQkeQvGIW8pobX2GXDhZ2+
         iqHsxhRx1MCmZUp1tXuhpjNhK89FLN+YVYgsvJrSiH1GZUSavUoLqm1iTyh4FTDxy+
         rukgWzdC64gCfeDOjdtSxhfcmAVILO4tHHLkY2j4=
From:   Christian Dietrich <christian.dietrich@tuhh.de>
To:     linux-kernel@vger.kernel.org
Subject: Advent(2) - The System-Call Advent Calendar
Organization: Technische =?utf-8?Q?Universit=C3=A4t?= Hamburg
X-Commit-Hash-org: d826f5ff8b6302d14bbad59532622974549f4d93
X-Commit-Hash-Maildir: c1d302decc9270ad3d63b967faa9a449d66c9e69
Date:   Thu, 01 Dec 2022 08:48:57 +0100
Message-ID: <s7bv8mvlg2e.fsf@dokucode.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Advent(2) -- The System-Call Advent Calender
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Winter is coming and the ELFs have a lot of work to do in Santa's
Christmas village. And the ELFs, as the name suggests, are big fans of
Linux to get this work done in time. However, until now they only know
about those old a crusty interfaces that we inherited from UNIX/POSIX.
So, they require your help! On the way, you can learn something about
old and new system calls of Linux.

https://osg.tuhh.de/Advent/

The Operating System Group at the Hamburg University of Technology
perpared a System-Call Advent calendar with 24 strace-filled doors for
you. On every day of December, you will find a system-call, a concept or
an interface of Linux that you might or might not yet know. Behind the
door, there is a short article and a small programming exercise, for
which we provide a commented solution on the following day.

https://lists.tuhh.de/sympa/subscribe/osg-advent

So come, join the mailinglist, and have some fun!

chris
--=20
Prof. Dr.-Ing. Christian Dietrich
Operating System Group (E-EXK4)
Technische Universit=C3=A4t Hamburg
Am Schwarzenberg-Campus 3 (E), 4.092
21073 Hamburg

eMail: christian.dietrich@tuhh.de
Tel:   +49 40 42878 2188
WWW:   https://osg.tuhh.de/
V=C3=BCro:  https://meeting.rz.tuhh.de/b/chr-2y9-1ge-rxr


