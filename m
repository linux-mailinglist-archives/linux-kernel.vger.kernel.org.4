Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A3C605BC8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiJTKCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiJTKCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:02:41 -0400
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E34CDBE53
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 03:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666260128; bh=PMZ5O0pXLfBj3FVZGJgvSf4d9uot3HnLI2rEzfbprUg=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=F5RClkqjd4Ho5/l48GGKejUTYmfZmG48f9//ihkRl9RCoRYJ5BNLP0KORF5MouWlR
         pElvaci439uwFB0lrXPnNE+Z2Av0WhAwMHrkWvrfdiCl8dw7qdUlj9JVwcz/+G0EA2
         xOyrD+a1DmHc70pHTgjFVSj7DCPSFgmMKhk32mmY=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via [213.182.55.206]
        Thu, 20 Oct 2022 12:02:07 +0200 (CEST)
X-EA-Auth: zFy64hILC+i7bB8QTgin2nFo2Qz5ZqqbH7+TB7JlPeTeUAdjnYMXgGF0nuOITrzkzCcGgdelScgqScT4Yr9X0TxqALK/sffP
Date:   Thu, 20 Oct 2022 15:32:02 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, paskripkin@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, kumarpraveen@linux.microsoft.com,
        saurabh.truth@gmail.com
Subject: Re: [PATCH v3 06/10] staging: r8188eu: Add space between function &
 macro parameters
Message-ID: <Y1EcmphZyExVVttR@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1666249715.git.drv@mailo.com>
 <79e0aa96b1c8b2bc0c0f8ef9e651ab254629c7a8.1666249716.git.drv@mailo.com>
 <114d7521-a15-9569-cb38-69f4bb8990f7@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <114d7521-a15-9569-cb38-69f4bb8990f7@inria.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 11:17:21AM +0200, Julia Lawall wrote:
>
>
> On Thu, 20 Oct 2022, Deepak R Varma wrote:
>
> > Space required between function and macro parameters to improve code
> > readability. This Linux kernel coding style guideline resolves following
> > error reported by checkpatch script:
> > 	ERROR: space required after that ',' (ctx:VxV)
> >
> > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > ---
> >
> > Changes in v3:
> >    1. Patch newly added to the patch set.
> >
> >
> >
> > -u8 rtw_gettssi_cmd(struct adapter  *padapter, u8 offset,u8 *pval);
> > +u8 rtw_gettssi_cmd(struct adapter  *padapter, u8 offset, u8 *pval);
> >  u8 rtw_setfwdig_cmd(struct adapter*padapter, u8 type);
> >  u8 rtw_setfwra_cmd(struct adapter*padapter, u8 type);
>
> Strange double space.

Agreed, made a note.

>
> >
> > @@ -751,7 +751,7 @@ u8 rtw_dynamic_chk_wk_cmd(struct adapter *adapter);
> >  u8 rtw_lps_ctrl_wk_cmd(struct adapter*padapter, u8 lps_ctrl_type, u8 enqueue);
> >  u8 rtw_rpt_timer_cfg_cmd(struct adapter*padapter, u16 minRptTime);
> >
> > - u8 rtw_antenna_select_cmd(struct adapter*padapter, u8 antenna,u8 enqueue);
> > + u8 rtw_antenna_select_cmd(struct adapter*padapter, u8 antenna, u8 enqueue);
>
> Missing space before *.

Agreed, made a note.

>
> >  u8 rtw_ps_cmd(struct adapter*padapter);
> >
> > diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
> > index 925c7967ac04..87fcf6c94ff3 100644
> > --- a/drivers/staging/r8188eu/include/rtw_io.h
> > +++ b/drivers/staging/r8188eu/include/rtw_io.h
> > @@ -209,7 +209,7 @@ struct io_priv {
> >  };
> >
> > -#define PlatformEFIOWrite1Byte(_a,_b,_c)		\
> > -	rtw_write8(_a,_b,_c)
> > -#define PlatformEFIOWrite2Byte(_a,_b,_c)		\
> > -	rtw_write16(_a,_b,_c)
> > -#define PlatformEFIOWrite4Byte(_a,_b,_c)		\
> > -	rtw_write32(_a,_b,_c)
> > -
> > -#define PlatformEFIORead1Byte(_a,_b)		\
> > -		rtw_read8(_a,_b)
> > -#define PlatformEFIORead2Byte(_a,_b)		\
> > -		rtw_read16(_a,_b)
> > -#define PlatformEFIORead4Byte(_a,_b)		\
> > -		rtw_read32(_a,_b)
> > +#define PlatformEFIOWrite1Byte(_a, _b, _c)		\
> > +	rtw_write8(_a, _b, _c)
> > +#define PlatformEFIOWrite2Byte(_a, _b, _c)		\
> > +	rtw_write16(_a, _b, _c)
> > +#define PlatformEFIOWrite4Byte(_a, _b, _c)		\
> > +	rtw_write32(_a, _b, _c)
> > +
> > +#define PlatformEFIORead1Byte(_a, _b)		\
> > +		rtw_read8(_a, _b)
> > +#define PlatformEFIORead2Byte(_a, _b)		\
> > +		rtw_read16(_a, _b)
> > +#define PlatformEFIORead4Byte(_a, _b)		\
> > +		rtw_read32(_a, _b)
>
> Could these be inline functions?

I am actually not seeing these macros being used anywhere. These macros were
added recently [commit ID: 7884fc0a1473c2721f496f1d1ddc9d2c91aefa53] in 2021. I
am unsure if they are intended to be used in the future or can removed entirely.

Making these inline functions can be done, however, will we need to measure
performance impact? I will need help and time for this evaluation.

Let me know what you think is right thing to do here.

Thank you,
./drv

>
> julia


