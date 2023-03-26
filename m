Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5245B6C945C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 14:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjCZMzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 08:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjCZMzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 08:55:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A517ED0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 05:55:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F713B8074C
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 12:55:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365A6C433EF;
        Sun, 26 Mar 2023 12:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679835313;
        bh=0b6LuPA20/cTjat7T/vMrk9FzqwkJo2HORoQjjdpRwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T1ggRYYBga+fmXn67xo0uUzWBMVk2L3qfzmpZEGvDGoizT2JPMrnGAEAl/uFJOyic
         8TlWjLsruuh9s4b/tXQTfhTodm9XLeSPW/2MNfFtK0CGViQyw8FsEvQzuFCgWL/OvT
         1sMxt/jkR97/7NgHUrTTtZkRv1NoCl4ntWGC/HiA=
Date:   Sun, 26 Mar 2023 14:55:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nam Cao <namcaov@gmail.com>
Cc:     Tom Rix <trix@redhat.com>, nathan@kernel.org,
        ndesaulniers@google.com, artur.bujdoso@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] staging: rtl8723bs: remove unused pHalData variable
Message-ID: <ZCBArurFCc7Pae+T@kroah.com>
References: <20230326122321.1352337-1-trix@redhat.com>
 <ZCA+vIjUFHZFUFPC@nam-dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCA+vIjUFHZFUFPC@nam-dell>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2023 at 02:46:52PM +0200, Nam Cao wrote:
> On Sun, Mar 26, 2023 at 08:23:21AM -0400, Tom Rix wrote:
> > clang with W=1 reports
> > drivers/staging/rtl8723bs/hal/hal_btcoex.c:1182:23: error: variable
> >   'pHalData' set but not used [-Werror,-Wunused-but-set-variable]
> >         struct hal_com_data *pHalData;
> >                              ^
> > This variable is not used so remove it.
> > 
> > Signed-off-by: Tom Rix <trix@redhat.com>
> > ---
> >  drivers/staging/rtl8723bs/hal/hal_btcoex.c | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/hal/hal_btcoex.c b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
> > index e36f8c369a04..0cb2adcc1f78 100644
> > --- a/drivers/staging/rtl8723bs/hal/hal_btcoex.c
> > +++ b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
> > @@ -1179,10 +1179,6 @@ bool hal_btcoex_IsBtDisabled(struct adapter *padapter)
> >  
> >  void hal_btcoex_SetChipType(struct adapter *padapter, u8 chipType)
> >  {
> > -	struct hal_com_data *pHalData;
> > -
> > -
> > -	pHalData = GET_HAL_DATA(padapter);
> >  }
> 
> If this function doesn't do anything, does it not make more sense to
> just remove this function entirely?

This function is already removed in linux-next, so it doesn't matter :)

thanks,

greg k-h
