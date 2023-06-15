Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709D3731EFD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 19:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjFOR24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 13:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjFOR2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 13:28:53 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3B2AC
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 10:28:52 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-62de4cc0172so30234836d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 10:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686850131; x=1689442131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=osliInNk1/bU9RCFmEpWSSuapVy8I/16aX6E/CrvA2U=;
        b=TfS+uE1yKvVXVl+IfYsl3xobG8Dd/xgHVlpu80X7s9BpSwRELd7/sdVF/ZZCUdyyfl
         zrPMInrof6aqrDGnX0SvLh1juhNEmS4Ed6VCcAvg7hqbAOlNEWpHfl3naxtJW7o+RvBn
         OUeMO48Ye35N9sxuDv7KGDAxvZAwKGnHs+fOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686850131; x=1689442131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=osliInNk1/bU9RCFmEpWSSuapVy8I/16aX6E/CrvA2U=;
        b=bHhAml8NrUrGeOF34tlTfuxn3AyPmbNB6ws0ti5WD+DmiwviAz/tc1GHVghUTe0ASQ
         8EbD326sa40OrettxLrMFKLN+5fkReuW3Ur6ElUxF7ASySSDIQJJlg38LFc6tvQQ7XgP
         conrvt5Ll2aZEMrsPGpolV4LJQfY56rcHjPACrdbH/cFU5docWuxmSP8pMTl82mAf3ar
         fdb+0rCXgxTwxtWx0nM9SGSbYux5mZh8qVcxcg5MMD01iW7tspCd6egJuJs4dMszPEfg
         ylqqHYtkE6GaW5XNeGO0Q9ns80BOoRkkpmu6BhRycnhVEvyqtSn6LqhWpZg/qtDNFkNy
         Tyqg==
X-Gm-Message-State: AC+VfDyWIQERHoI/S4eV87eekRldOLX4UMEKHDpf/ippfKZvlqyCmrgW
        HQ6dWB04BUe2UGAs5exXQYULGIM7mHAf6FpB/2NvrseiYjGsbCXmROw=
X-Google-Smtp-Source: ACHHUZ7pe4zCXQ4NLlLiPRFyWNxdw7kGImRkU4IzfMmSI5b4NW36cbEtevkNvNQQ31od0pXQquvWnaQ/NoPg+f070qs=
X-Received: by 2002:ad4:5d4a:0:b0:629:1659:dcc with SMTP id
 jk10-20020ad45d4a000000b0062916590dccmr25254405qvb.34.1686850131319; Thu, 15
 Jun 2023 10:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230605010117.794691-1-utkarsh.h.patel@intel.com> <20230605010117.794691-2-utkarsh.h.patel@intel.com>
In-Reply-To: <20230605010117.794691-2-utkarsh.h.patel@intel.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 15 Jun 2023 10:28:41 -0700
Message-ID: <CACeCKaeVw4UJ8oCj-wmWgf6TCcKYdprqb8Wdu-g2ZC5npgs71g@mail.gmail.com>
Subject: Re: [PATCH 1/2] platform/chrome: cros_ec_typec: Configure Retimer
 cable type
To:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heikki.krogerus@linux.intel.com, bleung@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Sorry, I've been out on leave so haven't had a chance to look at this earl=
ier)

On Sun, Jun 4, 2023 at 6:00=E2=80=AFPM Utkarsh Patel <utkarsh.h.patel@intel=
.com> wrote:
>
> Connector class driver only configure cable type active or passive.
> With this change it will also configure if the cable type is retimer or
> redriver if required by AP. This details will be provided by Chrome EC
> as a part of cable discover mode VDO.
>
> This change also brings in corresponding EC header updates from the EC
> code base [1].

Please separate this into another patch.

>
> [1]:
> https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/mas=
ter/include/ec_commands.h
>
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
> ---
>  drivers/platform/chrome/cros_ec_typec.c        | 8 +++++++-
>  include/linux/platform_data/cros_ec_commands.h | 2 ++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/c=
hrome/cros_ec_typec.c
> index a673c3342470..9c18b1df64a7 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -448,6 +448,9 @@ static int cros_typec_enable_tbt(struct cros_typec_da=
ta *typec,
>         if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_CABLE)
>                 data.enter_vdo |=3D TBT_ENTER_MODE_ACTIVE_CABLE;
>
> +       if (pd_ctrl->control_flags & USB_PD_CTRL_RETIMER_CABLE)
> +               data.enter_vdo |=3D TBT_CABLE_RETIMER;
> +
>         if (!port->state.alt) {
>                 port->state.alt =3D port->port_altmode[CROS_EC_ALTMODE_TB=
T];
>                 ret =3D cros_typec_usb_safe_state(port);
> @@ -522,8 +525,11 @@ static int cros_typec_enable_usb4(struct cros_typec_=
data *typec,
>         /* Cable Type */
>         if (pd_ctrl->control_flags & USB_PD_CTRL_OPTICAL_CABLE)
>                 data.eudo |=3D EUDO_CABLE_TYPE_OPTICAL << EUDO_CABLE_TYPE=
_SHIFT;
> -       else if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_CABLE)
> +       else if (pd_ctrl->control_flags & USB_PD_CTRL_RETIMER_CABLE)
>                 data.eudo |=3D EUDO_CABLE_TYPE_RE_TIMER << EUDO_CABLE_TYP=
E_SHIFT;
> +       else if (!(pd_ctrl->control_flags & USB_PD_CTRL_RETIMER_CABLE) &&
> +                 (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_CABLE))
> +               data.eudo |=3D EUDO_CABLE_TYPE_RE_DRIVER << EUDO_CABLE_TY=
PE_SHIFT;
>
>         data.active_link_training =3D !!(pd_ctrl->control_flags &
>                                        USB_PD_CTRL_ACTIVE_LINK_UNIDIR);
> diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/lin=
ux/platform_data/cros_ec_commands.h
> index ab721cf13a98..c9aa5495c666 100644
> --- a/include/linux/platform_data/cros_ec_commands.h
> +++ b/include/linux/platform_data/cros_ec_commands.h
> @@ -4963,6 +4963,8 @@ struct ec_response_usb_pd_control_v1 {
>  #define USB_PD_CTRL_TBT_LEGACY_ADAPTER  BIT(2)
>  /* Active Link Uni-Direction */
>  #define USB_PD_CTRL_ACTIVE_LINK_UNIDIR  BIT(3)
> +/* Retimer/Redriver cable */
> +#define USB_PD_CTRL_RETIMER_CABLE BIT(4)

Why are we adding this to this host commands interface? Is this
information not available from the Cable (plug)'s
Identity information? We register all of that in the port driver
already [1], so we should just use that, instead
of changing the host command interface.

Thanks,

[1]  https://elixir.bootlin.com/linux/v6.4-rc6/source/drivers/platform/chro=
me/cros_ec_typec.c#L768
