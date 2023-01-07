Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905F5661185
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 21:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbjAGUPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 15:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjAGUPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 15:15:33 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89041C757;
        Sat,  7 Jan 2023 12:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673122522; bh=bKvF6XExzpo3tcJFGudrK7bxCVIytgLcfpKjdb6b1QA=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=hh6pKazAq12vT2zUTST3nlwysEicp8c9P9I2aphc24cMn/r7jRB3k6j5JysAwUN7s
         ozkUpTPK1b6K9Bkr1I6McswLcFlPasdKfgOMEi2kgAddOPZ68RMzS1zfWqAzlkyfKK
         Nm+wNKoQlV9+3ek9SlzNS4GuEUdwKIi/isCnDPZY=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sat,  7 Jan 2023 21:15:22 +0100 (CET)
X-EA-Auth: 4UjjkrvfeD6qjgZdzzR81CZATUZCbhLGQGkkS3hP1MhWCYBT2rnPHF837zWj8vAPGNpeOTr137d7A0iDFINztbF9DaRuUydl
Date:   Sun, 8 Jan 2023 01:45:13 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH] scsi: qla4xxx: Use sysfs_emit in show function callsbacks
Message-ID: <Y7nS0fxWvWnAqRJ4@ubun2204.myguest.virtualbox.org>
References: <Y5RF+PGBuiXu7UrX@qemulion>
 <Y6DPMipC0V00uUu0@qemulion>
 <Y6wXX9X7TkpnoXZC@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6wXX9X7TkpnoXZC@qemulion>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 03:45:59PM +0530, Deepak R Varma wrote:
> On Tue, Dec 20, 2022 at 02:23:06AM +0530, Deepak R Varma wrote:
> > On Sat, Dec 10, 2022 at 02:10:24PM +0530, Deepak R Varma wrote:
> > > According to Documentation/filesystems/sysfs.rst, the show() callback
> > > function of kobject attributes should strictly use sysfs_emit instead
> > > of sprintf family functions.
> > > Issue identified using the coccinelle device_attr_show.cocci script.
> > >
> > > Signed-off-by: Deepak R Varma <drv@mailo.com>
> >
> > Hello,
> > May I please request a review and feedback on this patch?
>
> Hello,
> Requesting a review and feedback on this patch proposal please.
>
> Thank you,
> ./drv

Hello,
Any comment on this patch proposal please?

Thank you,
./drv

>
> >
> > Thank you,
> > ./drv
> >


