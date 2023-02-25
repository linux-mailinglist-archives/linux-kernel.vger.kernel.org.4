Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFE86A28A9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 10:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjBYJv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 04:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjBYJvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 04:51:54 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F3C15C94
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 01:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1677318700; bh=QZa+LEt/cPq+ovYlsNxbLE6A9xjUI1MvFbnWwo3v9PY=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To;
        b=lBxjET/Q9XcCY3gX53+YZ9Hs4Edv1zlQNAHLEigoJdpavPum58coRdyhZZ+6RDNIl
         0lh17a7II1Ygvh10/TV/FGnhh3wkCzb4LUmdKtciUWYaScIXoPmagpY4Eod6swlDwE
         ktLOGiCj5b3jpE3NSQfYsZHnqVID9P4IdJha6nyQ=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sat, 25 Feb 2023 10:51:40 +0100 (CET)
X-EA-Auth: yZz1+C1/MjC5ncrx5wOQgOycezkKrk2hyKt6oIYF6g7zmrY3iw4M3Np10UsU8E/3aCfUX8N8/uuDTK9309JPdpN53zkxLRx6
Date:   Sat, 25 Feb 2023 15:21:34 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     =?utf-8?B?0JvQtdC+0L3QuNC0INCf0LXRgNGI0LjQvQ==?= 
        <leonid.pershin@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <error27@gmail.com>,
        Tong Zhang <ztong0001@gmail.com>,
        Rebecca Mckeever <remckee0@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8192u: remove split in user-visible string
Message-ID: <Y/naJmGeQKtzgG5h@ubun2204.myguest.virtualbox.org>
References: <20230223193559.157880-1-leonid.pershin@gmail.com>
 <Y/hD10Ir9g/On6ME@ubun2204.myguest.virtualbox.org>
 <CABa+115WFC0cJ+-L_rNHy3YPOVuVMxgVDidyCLoNE4xYhsRxZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABa+115WFC0cJ+-L_rNHy3YPOVuVMxgVDidyCLoNE4xYhsRxZg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 10:54:22PM +0300, Леонид Першин wrote:
> On Fri, Feb 24, 2023 at 7:58 AM Deepak R Varma <drv@mailo.com> wrote:
> > Hello Leonid,
> > I was not able to trace the v1 of this patch. Did that have a different
> subject?

The line above broke for me in your response. This could be the email editor
issue on your side.

> >
> > Thank you,
> > Deepak.
> 
> Hello Deepak,
> Sorry, I've sent v1 directly to Greg by mistake. Here it is:

No problem. It is important to record such reasons for the reviewer's awareness.
Also, it is a common practice to give credit to the reviewers by mentioning
their name in the  "Change in vx" section.

Good luck.
Deepak.

> 
> On Wed, Feb 22, 2023 at 02:20:29AM +0300, Leonid Pershin wrote:
> > According to coding style, user-visible strings in printk()
> > function calls cannot be split across multiple lines.
> > Issue found with checkpatch.pl.
> >
> > Signed-off-by: Leonid Pershin <leonid.pershin@gmail.com>
> > ---
> > Changes in v2:
> >   - Replace printk(KERN_DEBUG...) with pr_debug()
> >
> >  drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
> b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
> > index 9bfd24ad46b6..c378bdff453b 100644
> > --- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
> > +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
> > @@ -72,16 +72,14 @@ static void *ieee80211_tkip_init(int key_idx)
> >
> >       priv->tx_tfm_michael = crypto_alloc_shash("michael_mic", 0, 0);
> >       if (IS_ERR(priv->tx_tfm_michael)) {
> > -             printk(KERN_DEBUG "ieee80211_crypt_tkip: could not allocate
> "
> > -                             "crypto API michael_mic\n");
> > +             pr_debug("ieee80211_crypt_tkip: could not allocate crypto
> API michael_mic\n");
> >               priv->tx_tfm_michael = NULL;
> >               goto fail;
> >       }
> >
> >       priv->rx_tfm_michael = crypto_alloc_shash("michael_mic", 0, 0);
> >       if (IS_ERR(priv->rx_tfm_michael)) {
> > -             printk(KERN_DEBUG "ieee80211_crypt_tkip: could not allocate
> "
> > -                             "crypto API michael_mic\n");
> > +             pr_debug("ieee80211_crypt_tkip: could not allocate crypto
> API michael_mic\n");
> >               priv->rx_tfm_michael = NULL;
> >               goto fail;
> >       }
> > --
> > 2.39.2
> >
> 
> Sincerely,
> Leonid


