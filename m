Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78585FA011
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 16:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiJJOSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 10:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiJJOSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 10:18:10 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B2872FD9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 07:18:08 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id n18-20020a17090ade9200b0020b0012097cso8619489pjv.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 07:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYF5XS2JRFV9RPZlZQCkeQ7ajMqkoP9Kb8xnQ89udwg=;
        b=fAa2MreMKKkd1H1c0EFMeRSx66lm2KgySkNtomiIctPKLFYqhflzFtRQAtBSFdzAUm
         TekKZCVMsTgzyqdlfzljUDWlnOuvumJLkC4mZTYcPYCjk2y0PrPuCK7smn9Vbl+mIATD
         61+Rnkeg5yyh2iLOW8llDxwkC/SAdmiKhv93C68NsmBNraNYBDWPCrEVZAks2JZLlyg5
         i0XFcf60Tc/k5GNHwVNHLIKDB6P7XLcFh7ISPipmV8ocKSBUPXICn/0gFpyN6T13yXzM
         g9OWanMfxhDad/haH6p3bn/3EVj8mgiuV4P537sz6zcLMS3CuhG4oCs1cFYUc5SNZ1HT
         3wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYF5XS2JRFV9RPZlZQCkeQ7ajMqkoP9Kb8xnQ89udwg=;
        b=lbZndeuJ4X1odoAo4BPQotGmH+WPH02E67qfK3POV6af6jPi+7Jp6/oW9vA5tZK8cd
         i58OjRelyxywzXjAyvr5kgmT8RDDI6M3Mnkx82wwVdHYMJuAc+A25s4pvvYzMPNPummb
         7+s7D5D4GxMFe6qo31j9De05uQ1OWXdB6GbH7q2tWDmOpPjRmFkYRi7+AamQmPSKRcQf
         t1+BZ1y/QtupgAfxyWq64LPBP8Vi9UwyFWR0Mp6Kp/qFAXjLS2TEzv1xKE8YHJJxj/EA
         F3H49Z0GlQLWepS3DoBX2vKj454Ze8FoqICFkihkmUdDC6LbRyvmGog2Io9HYxPuQ+gM
         DOeg==
X-Gm-Message-State: ACrzQf2TnbyJOophxEqpJEV1nuodqcoomFEakeUPfdxO1QUa50xfoJLX
        VnRKhVvKZO6VytksTvKBbePApv9b1yQY45g1GARZdw==
X-Google-Smtp-Source: AMsMyM4cUhV2VK+DCH3t4qIVuINv2HYwLfI0bQXnnILy2R1uC12MfGL19P8PiNkYgdiH3TS7uOCOjOJ8aStP8SpR6GU=
X-Received: by 2002:a17:902:d714:b0:17f:5813:1df4 with SMTP id
 w20-20020a170902d71400b0017f58131df4mr20026551ply.148.1665411488088; Mon, 10
 Oct 2022 07:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <0d0ef6651ed44fc780e95c8797294708@hyperstone.com>
In-Reply-To: <0d0ef6651ed44fc780e95c8797294708@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 10 Oct 2022 16:17:30 +0200
Message-ID: <CAPDyKFrxDBnOZXD_e086ODRFthKVrsTTU9jgsWayXXkHby2RLQ@mail.gmail.com>
Subject: Re: [PATCHv3 1/2] mmc: block: Remove error check of hw_reset on reset
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Oct 2022 at 16:03, Christian L=C3=B6hle <CLoehle@hyperstone.com>=
 wrote:
>
> Before switching back to the right partition in mmc_blk_reset
> there used to be a check if hw_reset was even supported.
> This return value was removed, so there is no reason to check.
> Furthermore ensure part_curr is not falsely set to a valid value
> on reset or partition switch error.
>
> Fixes: fefdd3c91e0a ("mmc: core: Drop superfluous validations in mmc_hw|s=
w_reset()")
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>

This looks good to me, however I am awaiting and ack from Adrian
before applying, to make sure we are all aligned with the approach.

Kind regards
Uffe

> ---
> -v3: Ensure invalid part_curr on error
> -v2: Do not attempt to switch partitions if reset failed
>
>  drivers/mmc/core/block.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index ce89611a136e..45a44edcc31a 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -134,6 +134,7 @@ struct mmc_blk_data {
>          * track of the current selected device partition.
>          */
>         unsigned int    part_curr;
> +#define MMC_BLK_PART_INVALID   UINT_MAX        /* Unknown partition acti=
ve */
>         int     area_type;
>
>         /* debugfs files (only in main mmc_blk_data) */
> @@ -991,29 +992,27 @@ static int mmc_blk_reset(struct mmc_blk_data *md, s=
truct mmc_host *host,
>                          int type)
>  {
>         int err;
> +       struct mmc_blk_data *main_md =3D dev_get_drvdata(&host->card->dev=
);
> +       int part_err;
>
>         if (md->reset_done & type)
>                 return -EEXIST;
>
>         md->reset_done |=3D type;
> +       main_md->part_curr =3D MMC_BLK_PART_INVALID;
>         err =3D mmc_hw_reset(host->card);
> +       if (err)
> +               return err;
>         /* Ensure we switch back to the correct partition */
> -       if (err) {
> -               struct mmc_blk_data *main_md =3D
> -                       dev_get_drvdata(&host->card->dev);
> -               int part_err;
> -
> -               main_md->part_curr =3D main_md->part_type;
> -               part_err =3D mmc_blk_part_switch(host->card, md->part_typ=
e);
> -               if (part_err) {
> -                       /*
> -                        * We have failed to get back into the correct
> -                        * partition, so we need to abort the whole reque=
st.
> -                        */
> -                       return -ENODEV;
> -               }
> +       part_err =3D mmc_blk_part_switch(host->card, md->part_type);
> +       if (part_err) {
> +               /*
> +                * We have failed to get back into the correct
> +                * partition, so we need to abort the whole request.
> +                */
> +               return -ENODEV;
>         }
> -       return err;
> +       return 0;
>  }
>
>  static inline void mmc_blk_reset_success(struct mmc_blk_data *md, int ty=
pe)
> --
> 2.37.3
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>
