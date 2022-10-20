Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3BC6059DD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiJTIdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiJTIdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:33:22 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25AF18D472
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666254774; bh=uGJOECvwfecP73hjHqlzR9cNSPgQFEOXZh8iGxXlhK4=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=VvBzD7UnofAdVZBvHTdVje69l0ptJIVbzwQxNQ1w5v8CV80HndQ2zYvb65Obmkvwv
         +nLKKQyE+nFO1aXlIXOgRfxomp7yIZ/07LXgv6rcmjNSysH9hszk88cxl6yuvY9p5+
         KZq+aX6AIl9AFmsc4cM0UhPoH094jquBJi3Xrrv0=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via [213.182.55.206]
        Thu, 20 Oct 2022 10:32:54 +0200 (CEST)
X-EA-Auth: ijwdOOfmZqwZyS0vGc/OQ3+uaqZHbCqE/oag4KaC7DzGRAKkSd8aRAUbI2pDVef5kL0Gx/gReKkA8q+s/9lR0JHQPUBYizlB
Date:   Thu, 20 Oct 2022 14:02:49 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, paskripkin@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, kumarpraveen@linux.microsoft.com,
        saurabh.truth@gmail.com
Subject: Re: [PATCH v3 05/10] staging: r8188eu: correct misspelled words in
 comments
Message-ID: <Y1EHsXYlgukZIkaC@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1666249715.git.drv@mailo.com>
 <3235c0f681d817f7f89dd80537f36e1f9686fa24.1666249716.git.drv@mailo.com>
 <Y1EFMt6fjLdRirnA@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1EFMt6fjLdRirnA@kadam>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 11:22:10AM +0300, Dan Carpenter wrote:
> On Thu, Oct 20, 2022 at 01:25:16PM +0530, Deepak R Varma wrote:
> > diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
> > index 55e6b0f41dc3..1de808832ed8 100644
> > --- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
> > +++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
> > @@ -287,7 +287,7 @@ u8 rtw_set_802_11_infrastructure_mode(struct adapter *padapter,
> >
> >  		if ((*pold_state == Ndis802_11Infrastructure) || (*pold_state == Ndis802_11IBSS)) {
> >  			if (check_fwstate(pmlmepriv, _FW_LINKED))
> > -				rtw_indicate_disconnect(padapter); /* will clr Linked_state; before this function, we must have chked whether  issue dis-assoc_cmd or not */
> > +				rtw_indicate_disconnect(padapter); /* will clr Linked_state; before this function, we must have cheked whether  issue dis-assoc_cmd or not */
>
>
> s/cheked/checked/

ahhh... That's insane. I must have overlooked the code-spell indication. Thank you for
catching it Dan. I will wait for feedback on other patches and accordingly send
in the revised version.

./drv

>
> >  	       }
> >
> >  		*pold_state = networktype;
>
> regards,
> dan carpenter


