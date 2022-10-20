Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CDF6065CB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiJTQ3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJTQ3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:29:00 -0400
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C65138BAB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666283318; bh=QrbH8ZlnlI+VbcMy6Hlu3J19WCIXjbJ5GTHzbmUSm2g=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=AGwOUilnyB5IDjnY5sVaQFc8Z7/gZ/d71nT18CpZBVJTLD36MCW5hCYNrja/Xu5V5
         MIbjw3uR7GpHGpaH05BpBMeddQdttSmSP1CMxnJLjaN+H3IjhiJwzkxtdlzpI2/bko
         7dk/549VBSpAo/zzulMZaNWYgYqHKw8ChNW/dq+M=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via [213.182.55.206]
        Thu, 20 Oct 2022 18:28:38 +0200 (CEST)
X-EA-Auth: 6Al72bKYPQ7R+pUm09MhmDMG6GnIPgd8P8WfhJUlVlzguoPlasZL+/X6202mxzfGxpNtJsmZvETVMSHGIOl1jfX3T908+M5W
Date:   Thu, 20 Oct 2022 21:58:33 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, paskripkin@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kumarpraveen@linux.microsoft.com, saurabh.truth@gmail.com
Subject: Re: [PATCH v3 01/10] staging: r8188eu: use Linux kernel variable
 naming convention
Message-ID: <Y1F3MTzzq1axUyec@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1666249715.git.drv@mailo.com>
 <5226d30242be78ab1ee32bfdd87239ca82569642.1666249716.git.drv@mailo.com>
 <Y1Ftx/Q69AHVR4oZ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1Ftx/Q69AHVR4oZ@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 05:48:23PM +0200, Greg KH wrote:
> On Thu, Oct 20, 2022 at 01:22:50PM +0530, Deepak R Varma wrote:
> > Follow the Linux Kernel coding style variable naming convention instead
> > of using camelCase style. Issue reported by checkpatch script for
> > these variables:
> >         tagLen, tagType, networkAddr, ipAddr, macAddr
> >
> > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > ---
> >
> > Changes in v3:
> >    -- None
> >
> > Changes in v1 [actually v2]:
> >    1. Improve patch description per feedback from julia.lawall@inria.fr
> >
> >
> >  drivers/staging/r8188eu/core/rtw_br_ext.c | 112 +++++++++++-----------
> >  1 file changed, 56 insertions(+), 56 deletions(-)
> >
> > diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
> > index 4c5f30792a46..79daf8f269d6 100644
> > --- a/drivers/staging/r8188eu/core/rtw_br_ext.c
> > +++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
> > @@ -50,17 +50,17 @@
> >  static unsigned char *__nat25_find_pppoe_tag(struct pppoe_hdr *ph, unsigned short type)
> >  {
> >  	unsigned char *cur_ptr, *start_ptr;
> > -	unsigned short tagLen, tagType;
> > +	unsigned short tag_len, tag_type;
> >
> >  	start_ptr = (unsigned char *)ph->tag;
> >  	cur_ptr = (unsigned char *)ph->tag;
> >  	while ((cur_ptr - start_ptr) < ntohs(ph->length)) {
> >  		/*  prevent un-alignment access */
> > -		tagType = (unsigned short)((cur_ptr[0] << 8) + cur_ptr[1]);
> > -		tagLen  = (unsigned short)((cur_ptr[2] << 8) + cur_ptr[3]);
> > -		if (tagType == type)
> > +		tag_type = (unsigned short)((cur_ptr[0] << 8) + cur_ptr[1]);
> > +		tag_len  = (unsigned short)((cur_ptr[2] << 8) + cur_ptr[3]);
> > +		if (tag_type == type)
> >  			return cur_ptr;
> > -		cur_ptr = cur_ptr + TAG_HDR_LEN + tagLen;
> > +		cur_ptr = cur_ptr + TAG_HDR_LEN + tag_len;
> >  	}
> >  	return NULL;
> >  }
> > @@ -111,32 +111,32 @@ static int  __nat25_has_expired(struct nat25_network_db_entry *fdb)
> >  	return 0;
> >  }
> >
> > -static void __nat25_generate_ipv4_network_addr(unsigned char *networkAddr,
>
> As others have said, just make "networkAddr" be "addr" and then it will
> be a lot cleaner and smaller overall.

Sounds good. Noted for next revision.

Thank you.
./drv

>
> thanks,
>
> greg k-h


