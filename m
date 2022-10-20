Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86E9605AB6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 11:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiJTJM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 05:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiJTJM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:12:57 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3AE18DA86
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 02:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=A2OD/3lXR+n8/xF7zMwneo+Y64iQCKSfGS8WUfo7cmM=;
  b=DSC40wcEcg6nyMHFSfwrSXX0ufvWBEcYlz7+hySs91kMYO7DDvZhUGdg
   jgfqmCdsLM9m/Lzjt+PzxOdXn6fPdalBKI1r/tp7yeMOfuwgCGpuR+Ns7
   D7cGIgzaIsokpkq0cFiTQWq4g4VIQisFwJvpNeF+1dQGZrYJlwsIOE0Xo
   A=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.95,198,1661810400"; 
   d="scan'208";a="66128175"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 11:12:54 +0200
Date:   Thu, 20 Oct 2022 11:12:54 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Dan Carpenter <dan.carpenter@oracle.com>
cc:     Deepak R Varma <drv@mailo.com>, outreachy@lists.linux.dev,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        paskripkin@gmail.com, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kumarpraveen@linux.microsoft.com, saurabh.truth@gmail.com
Subject: Re: [PATCH v3 05/10] staging: r8188eu: correct misspelled words in
 comments
In-Reply-To: <Y1EFMt6fjLdRirnA@kadam>
Message-ID: <72b89e31-20b8-ab7c-a447-ff2d216da8de@inria.fr>
References: <cover.1666249715.git.drv@mailo.com> <3235c0f681d817f7f89dd80537f36e1f9686fa24.1666249716.git.drv@mailo.com> <Y1EFMt6fjLdRirnA@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Oct 2022, Dan Carpenter wrote:

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

There is also a strange double space before issue.

julia

>
> >  	       }
> >
> >  		*pold_state = networktype;
>
> regards,
> dan carpenter
>
>
