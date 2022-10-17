Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F6B601B42
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 23:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiJQV1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 17:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJQV1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 17:27:39 -0400
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28947C1FB
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 14:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666042044; bh=b9ULDUrojjL+uZiL3TYIu4hGVxgJh3rS+Pz8e6u/JQw=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=U/c+7btF2DhN8jAnp81xiHmRRHvYuQrPc+X9bjD1cHVR0d6FBF79OQne+Fxprl2u/
         bdY6z4Xy1AGRe91f0nOW18JeoZ7mo8PFvAkxb3Fi2B8YMbqO+0IMaqAxDN+2YW0IZ/
         hlgY7583ZVeYyh4mkkNvSl1s17bwQCoE7w123URk=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via [213.182.55.206]
        Mon, 17 Oct 2022 23:27:24 +0200 (CEST)
X-EA-Auth: S0Z0h4mr5xFE7csjHWF9ygvAyNgZrjehOT6h9Zf7qZaeNUCqLayC5HU6eUsRBw55jnaOxjrH+O5aX02I7npqFrCauzNqwIzF
Date:   Tue, 18 Oct 2022 02:57:17 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, paskripkin@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, kumarpraveen@linux.microsoft.com,
        saurabh.truth@gmail.com
Subject: Re: [PATCH v1 0/4] staging: r8188eu: trivial code cleanup patches
Message-ID: <Y03ItcNzH6FBUF8N@lion2204>
References: <cover.1666021212.git.drv@mailo.com>
 <da0daaa7-8e2c-103e-0261-8685739e297d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da0daaa7-8e2c-103e-0261-8685739e297d@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 11:06:19PM +0200, Philipp Hortmann wrote:
> On 10/17/22 17:56, Deepak R Varma wrote:
> > Address different kinds of checkpatch complains for the staging/r8188eu module.
> > The patches are required to be applied in sequence.
> >
> > Changes in v1:
> >     1. Improve language / grammar for the patch descriptions
> >     2. Further improve code reformatting
> >
> > Deepak R Varma (4):
> >    staging: r8188eu: use Linux kernel variable naming convention
> >    staging: r8188eu: reformat long computation lines
> >    staging: r8188eu: remove {} for single statement blocks
> >    staging: r8188eu: use htons macro instead of __constant_htons
> >
> >   drivers/staging/r8188eu/core/rtw_br_ext.c | 122 +++++++++++-----------
> >   1 file changed, 62 insertions(+), 60 deletions(-)
> >
> > --
> > 2.30.2
> >
> >
> >
> >

Hello Philipp,
Thank you for testing the patch set and the following feedback. Much appreciate.

>
> I think this patch series should be v2 as the first one was a v1. The next
> one should be the v3.

Okay. I will switch it to v3 if there is opportunity for another revision of
this patch set.

>
> Please do variable changes driver wide and not only limited to a file.
> Example:
> This line contains the old variable:
> void *scdb_findEntry(struct adapter *priv, unsigned char *ipAddr);
>
> But in this line you have already changed ip_addr.
> void *scdb_findEntry(struct adapter *priv, unsigned char *ip_addr)
> {
> 	unsigned char network_addr[MAX_NETWORK_ADDR_LEN];
> 	struct nat25_network_db_entry *db;
> 	int hash;
> ...

Since this is my first patch set, I wanted to be small and manageable. I also
made changes only to function parameters and local variable. I am now
comfortable to make similar change for the other files and symbols such as
functions and structures. I will send in a separate patch set for the remaining
files of this driver.

>
>
> Please change all networkAddr and not only some.

For this file, I changed all networkAddr definitions except those that are part
of global structure definition. I will include those changes in the next patch
set.

>
> Is it possible to changing __constant_htons as well in the entire driver?

Sure, in the next patch set.

>
> Driver can be applied and compiled.
> Tested device.
Thank you again.

./drv

>
> Thanks
>
> Bye Philipp
>
>


