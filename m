Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119BE738F94
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjFUTDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjFUTDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:03:40 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F136E1A4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 12:03:12 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51a2160a271so7774319a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 12:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1687374189; x=1689966189;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2qJpK3KoDKaGdMPnFBYoOsKrBkC97FAcba3H7MKp0D0=;
        b=nh5zxwadRpoXTQ3BUgU/1BLF6SQhW3sLu/FN0MPW28V6gNaXWgcdK9UVdz0HOC+gPc
         4S5UiiNr7ZAvadn4n7T1ZS5zKHmkKpwJxk22rtwOlcjoups6t2HLOvPnhWnoHX8JLr39
         E8weSpizuP2wRFAhj4DV9xzwN1V8M6lmGWEL0qRE+9Z/FuqeUhwNE1dmiE4o/FJUeeuc
         Pdp9KyY0ekOl4O57j/VZmXeGNCkmRYg8HZr17rzARcWLbg0bMg/aEAK/p0gKdyHsK/kH
         Xmhdbh8wRqYFVkttif54yoWDlDFKcZM0dNugSMrJV31P7SUZqT2ELH9RNLO9iUAB3R78
         2Yng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687374189; x=1689966189;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2qJpK3KoDKaGdMPnFBYoOsKrBkC97FAcba3H7MKp0D0=;
        b=cJdQ+5r2eSb1J9sPBQB+xpGtwYE3wS6VUMMP6326r4ySN3A2IkMaEbWixnihaxFMzj
         BOQUzRdUw8+1Emy2mDmxoOyzT8q5OwwN5sQQq5IyiCiYIL6ELwxKKIrT1FjnYatn92yi
         DYaKfjqG2Pl34vwZvne8NubKpU/XLtXhvYsA4A8mWoUnIDewMK+ygz/UJfUDg4BGfm7g
         KifTB5DOPcI/PnjG6fE/2HlynvxlAe2x+kBrCbh6fO0RVsofU9IMj3d+WzuDbdRDdxkj
         Ho3nuXBnx+uzT3s/cC7k5VVeHRAixKY+0spO/STtGasr+wxNYf5nMUvL2gsGHGWV9V6L
         DB2A==
X-Gm-Message-State: AC+VfDwdch9m6nsuc09G5K29PXBWYL5qYcMRcfyN9IXjNyLIar4KmocM
        9PEbHtyDyg1kfNk3aPlq9avpZNGAosXkKw811wA=
X-Google-Smtp-Source: ACHHUZ7SypqJEY5XWqBQ5BLPLUT82ZBr/MF6PmEhc6Gkt+Akzrao0BrYO+qjY7IUaWCiWD14akrvvIqkCPpk3J1W6Wc=
X-Received: by 2002:a17:907:783:b0:982:79fa:4532 with SMTP id
 xd3-20020a170907078300b0098279fa4532mr14816708ejb.53.1687374188952; Wed, 21
 Jun 2023 12:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230619175703.18826-1-franziska.naepelt@gmail.com>
 <20230619180753.18998-1-franziska.naepelt@gmail.com> <2023062012-regain-vintage-2c6d@gregkh>
In-Reply-To: <2023062012-regain-vintage-2c6d@gregkh>
From:   =?UTF-8?Q?Franziska_N=C3=A4pelt?= 
        <franziska.naepelt@googlemail.com>
Date:   Wed, 21 Jun 2023 21:02:56 +0200
Message-ID: <CAAUT3iN6r2KHxMO=mF0AjV_7eGvm8ecq3tahvB_yDB+0HQ1Xpg@mail.gmail.com>
Subject: Re: [PATCH 2/5] staging: rtl8723bs: Fix space issues
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     eperi1024@gmail.com, hdegoede@redhat.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        quic_vjakkam@quicinc.com, tegongkang@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Am Di., 20. Juni 2023 um 16:12 Uhr schrieb Greg KH <gregkh@linuxfoundation.org>:
>
> On Mon, Jun 19, 2023 at 08:07:53PM +0200, Franziska Naepelt wrote:
> > Fix the following checkpatch space issues:
> > - CHECK: spaces preferred around that '*' (ctx:VxV)
> > - CHECK: spaces preferred around that '+' (ctx:VxV)
> > - CHECK: spaces preferred around that '-' (ctx:VxV)
> > - CHECK: spaces preferred around that '|' (ctx:VxV)
> > - CHECK: No space is necessary after a cast
> > - WARNING: please, no spaces at the start of a line
> >
> > Signed-off-by: Franziska Naepelt <franziska.naepelt@gmail.com>
> > ---
> >  .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 77 +++++++++----------
> >  1 file changed, 38 insertions(+), 39 deletions(-)
> >
> > diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> > index 1afd1a93bcee..abda4e0f0bf5 100644
> > --- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> > +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> > @@ -95,14 +95,14 @@ static struct ieee80211_channel rtw_2ghz_channels[] = {
> >  static void rtw_2g_channels_init(struct ieee80211_channel *channels)
> >  {
> >       memcpy((void *)channels, (void *)rtw_2ghz_channels,
> > -             sizeof(struct ieee80211_channel)*RTW_2G_CHANNELS_NUM
> > +             sizeof(struct ieee80211_channel) * RTW_2G_CHANNELS_NUM
> >       );
> >  }
> >
> >  static void rtw_2g_rates_init(struct ieee80211_rate *rates)
> >  {
> >       memcpy(rates, rtw_g_rates,
> > -             sizeof(struct ieee80211_rate)*RTW_G_RATES_NUM
> > +             sizeof(struct ieee80211_rate) * RTW_G_RATES_NUM
> >       );
> >  }
> >
> > @@ -126,8 +126,8 @@ static struct ieee80211_supported_band *rtw_spt_band_alloc(
> >       if (!spt_band)
> >               goto exit;
> >
> > -     spt_band->channels = (struct ieee80211_channel *)(((u8 *)spt_band)+sizeof(struct ieee80211_supported_band));
> > -     spt_band->bitrates = (struct ieee80211_rate *)(((u8 *)spt_band->channels)+sizeof(struct ieee80211_channel)*n_channels);
> > +     spt_band->channels = (struct ieee80211_channel *)(((u8 *)spt_band) + sizeof(struct ieee80211_supported_band));
> > +     spt_band->bitrates = (struct ieee80211_rate *)(((u8 *)spt_band->channels) + sizeof(struct ieee80211_channel) * n_channels);
> >       spt_band->band = band;
> >       spt_band->n_channels = n_channels;
> >       spt_band->n_bitrates = n_bitrates;
> > @@ -247,10 +247,10 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
> >               u32 wpsielen = 0;
> >               u8 *wpsie = NULL;
> >
> > -             wpsie = rtw_get_wps_ie(pnetwork->network.ies+_FIXED_IE_LENGTH_, pnetwork->network.ie_length-_FIXED_IE_LENGTH_, NULL, &wpsielen);
> > +             wpsie = rtw_get_wps_ie(pnetwork->network.ies + _FIXED_IE_LENGTH_, pnetwork->network.ie_length - _FIXED_IE_LENGTH_, NULL, &wpsielen);
> >
> >               if (wpsie && wpsielen > 0)
> > -                     psr = rtw_get_wps_attr_content(wpsie,  wpsielen, WPS_ATTR_SELECTED_REGISTRAR, (u8 *)(&sr), NULL);
> > +                     psr = rtw_get_wps_attr_content(wpsie, wpsielen, WPS_ATTR_SELECTED_REGISTRAR, (u8 *)(&sr), NULL);
> >
> >               if (sr != 0) {
> >                       /* it means under processing WPS */
> > @@ -266,7 +266,6 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
> >       }
> >       /* spin_unlock_bh(&pwdev_priv->scan_req_lock); */
> >
> > -
>
> This was an extra blank line issue that you did not mention in the
> changelog :(
>
> Please be more careful.
>
> thanks,
>
> greg k-h

Thanks for the heads up, it's fixed in v2.
https://lore.kernel.org/linux-staging/20230621184635.25064-1-franziska.naepelt@gmail.com/

---
Franziska
