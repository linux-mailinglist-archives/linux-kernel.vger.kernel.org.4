Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF595FDC51
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 16:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiJMOVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 10:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiJMOVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 10:21:20 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4984F15704
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 07:21:18 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id bh13so1695175pgb.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 07:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEaxIuyCG3WsLoSdoUnVtXPlTNpmJVIanbXAU2uLHoM=;
        b=wBD/RpAnt0c8boN6pfPV8EuZS3PY1Y/elBxsY0mM3M5kHOihhy0vI/C8Ts0SgH110M
         DR4IcTHI4d+QMTSyHQk6H+YkdZ8paq5U+7Z8RHY3SG770VscaZq7BLN5zpePZWJcWnzT
         r2sqW+YTHewzSxLNAYV4AXsrDeEMxAVRKnwakT8YtoGHSZF0U96TS2ABh1/JAxoMjI9n
         3i8LFQ/khfK0F1F1gEWGhKQsM+QnlPBK/wB+qiS1zh2u8dSDzj2wLH7N4TmdChn+bms4
         dRR7QMg9H8DQLIF6So1rXZsNGfvAA9kvEuKq3Gb+JJlJq3Fq0BKO3e7YJEg0E49ygVF/
         fvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEaxIuyCG3WsLoSdoUnVtXPlTNpmJVIanbXAU2uLHoM=;
        b=Fl2LKaFgMoOzNLEKlHwQe5VoaHqiu8uZ03OoYBcAnHp/p2g2YxHiTPBajNRVmDsm+e
         uNnT7py9OFpG3nSXd6u07IdZH2/UfItGGSmQrDwpCJKpCJNKJuTy0AIpQD6Urfw0FJI2
         XSNVYIoeDpqyGYWa5coU7nIBeypsjiIqcIW0EpkGF+oJAbXUwBDPC2Qsp6f1I/4hH0wC
         vnftu0YEyuu5ry1D0jAqIpH2Uq0o1nZj26Ty/8rcA4CHYKL6OZo9C3M7WqhR1kZbSkMb
         nIpwbezldc/bKNRcov6BcIhhiaq3ReNzThTbaiI83/RomypCzigR+Wo0rD4ew48r0YIR
         h1Mg==
X-Gm-Message-State: ACrzQf134GcT0OnbC/84z36OVqELufBo7iJBVuv+zjqL2trs1B0bxcgB
        Z7wIl6geKISYyIBlNyTYmODyks56Ga5kQ8Wf+xpSGqMor/Y=
X-Google-Smtp-Source: AMsMyM41cPwmE7AuNLVf6OZQWB2ATlJ9ZhZWhaWhTkS2i/fhC22M9i/iI2PnRGSPujlJ+rgGAI/xzGWpdCEpKxeJtQc=
X-Received: by 2002:a63:1612:0:b0:461:4180:d88b with SMTP id
 w18-20020a631612000000b004614180d88bmr114831pgl.434.1665670877702; Thu, 13
 Oct 2022 07:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <e91be6199d04414a91e20611c81bfe1d@hyperstone.com>
In-Reply-To: <e91be6199d04414a91e20611c81bfe1d@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 13 Oct 2022 16:20:40 +0200
Message-ID: <CAPDyKFoNJNSsuCDShxUH43v=yjvNEpUq_x7_hFOFO3A4eO+K5Q@mail.gmail.com>
Subject: Re: [PATCHv5 1/2] mmc: block: Remove error check of hw_reset on reset
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
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

On Thu, 13 Oct 2022 at 13:16, Christian L=C3=B6hle <CLoehle@hyperstone.com>=
 wrote:
>
> Before switching back to the right partition in mmc_blk_reset there used
> to be a check if hw_reset was even supported. This return value
> was removed, so there is no reason to check. Furthermore ensure
> part_curr is not falsely set to a valid value on reset or
> partition switch error.
>
> As part of this change the code paths of mmc_blk_reset calls were checked
> to ensure no commands are issued after a failed mmc_blk_reset directly
> without going through the block layer.
>
> Fixes: fefdd3c91e0a ("mmc: core: Drop superfluous validations in mmc_hw|s=
w_reset()")
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> -v5: Remove nested if
> -v4: Only partition switch if necessary and fix one mmc_blk_reset call
> -v3: Ensure invalid part_curr on error
> -v2: Do not attempt to switch partitions if reset failed
>
>  drivers/mmc/core/block.c | 44 ++++++++++++++++++++++++----------------
>  1 file changed, 26 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index ce89611a136e..0be7ab6ce1c8 100644
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
> @@ -987,33 +988,39 @@ static unsigned int mmc_blk_data_timeout_ms(struct =
mmc_host *host,
>         return ms;
>  }
>
> +/*
> + * Attempts to reset the card and get back to the requested partition.
> + * Therefore any error here must result in cancelling the block layer
> + * request, it must not be reattempted without going through the mmc_blk
> + * partition sanity checks.
> + */
>  static int mmc_blk_reset(struct mmc_blk_data *md, struct mmc_host *host,
>                          int type)
>  {
>         int err;
> +       struct mmc_blk_data *main_md =3D dev_get_drvdata(&host->card->dev=
);
>
>         if (md->reset_done & type)
>                 return -EEXIST;
>
>         md->reset_done |=3D type;
>         err =3D mmc_hw_reset(host->card);
> +       /*
> +        * A successful reset will leave the card in the main partition, =
but
> +        * upon failure it might not be, so set it to MMC_BLK_PART_INVALI=
D
> +        * in that case.
> +        */
> +       main_md->part_curr =3D err ? MMC_BLK_PART_INVALID : main_md->part=
_type;
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
> -       }
> -       return err;
> +       if (mmc_blk_part_switch(host->card, md->part_type))
> +               /*
> +                * We have failed to get back into the correct
> +                * partition, so we need to abort the whole request.
> +                */
> +               return -ENODEV;
> +       return 0;
>  }
>
>  static inline void mmc_blk_reset_success(struct mmc_blk_data *md, int ty=
pe)
> @@ -1867,8 +1874,9 @@ static void mmc_blk_mq_rw_recovery(struct mmc_queue=
 *mq, struct request *req)
>                 return;
>
>         /* Reset before last retry */
> -       if (mqrq->retries + 1 =3D=3D MMC_MAX_RETRIES)
> -               mmc_blk_reset(md, card->host, type);
> +       if (mqrq->retries + 1 =3D=3D MMC_MAX_RETRIES &&
> +           mmc_blk_reset(md, card->host, type))
> +               return;
>
>         /* Command errors fail fast, so use all MMC_MAX_RETRIES */
>         if (brq->sbc.error || brq->cmd.error)
> --
> 2.37.3
>
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>
