Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E475D6E777A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 12:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjDSKde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 06:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjDSKdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 06:33:12 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78706A67;
        Wed, 19 Apr 2023 03:33:10 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4ec8143400aso2822847e87.0;
        Wed, 19 Apr 2023 03:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681900389; x=1684492389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvLb/u1JwQ2n19UD3ml4wjcIxBqkWQ62Ba39f3PCh9k=;
        b=Rl0o3mPxIkuFJjGAT0ILvSEQkqd9zy56WMx/GSwv7s0zfEZuWVJ8pRbN/v2AIEmmDQ
         nIpy0kDTBQzp+W9Tg2wDq/mw5FeGpr/9xaBPG1B3XHuGp5HEAH6utnfujbIIXbz3Z3YL
         RF4kLqL6sRHoWdtVjCZWrL1hgvrxAlbszGz0D6GHWhAj0aCoXj15SL1XHRS2f0ywhCWc
         qOzFQMqZIiBgVEjNscJVA+RTWF54YqzWr0JgLOqpcnNOiY99hb6h+U4D/PN4NZQ/KexJ
         sycm5onqkO0qZ6GIw1I0OrZFkQeD5NyDSd/kNvNXMqLLDM4PhnqyXSmlwyyCpK+T7RzY
         lYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681900389; x=1684492389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GvLb/u1JwQ2n19UD3ml4wjcIxBqkWQ62Ba39f3PCh9k=;
        b=bN6Gi8Me2pHTb5dMWDRptZLZF8hlB8qgW+lSWYmrPtjHQ18hsRnUh51+6mGEK5Q8Ef
         5flLg9mNPKio4iltLWdY2n6oWIbEDR6sLo/XS7rJ9Atecb9bik8J3Fyc2Cx4EX8xIqRl
         hfCHPT+ffHFd/9T4igRgD57tKnomcYIjnpCcr5QwlopoAg+ll6BtAIR8qd0VchrG6wqb
         qgfgSXqY2G/q9V6wxa/C59WW7Mwq9iu+hZ0kXzkt8wep9ie/mzPU3DVi/1YWUNZTuVjg
         ew3Yy1w07JY33HzAwfxA06dfii0WDb9xTgXEaF/rfkSq0n/0VSfJX4es38sAJNC3mQis
         Wziw==
X-Gm-Message-State: AAQBX9d7wAZt6hPQjiOqWWWvl0UtVhp4s5BmlgabtJ5zo2VFT5rJFY/5
        b78QP0iXQrjD5B4T47BO/y4DpPGey54jmiUMkw==
X-Google-Smtp-Source: AKy350Y0WmlKtXWJo6+dE9Y88ByibDuA0FvyqEVPYq3jIm1enxs7AUeolkhn/qHUjzbY38OaPrJJr6iMj0wvFu9T7zs=
X-Received: by 2002:ac2:4e4d:0:b0:4eb:eaf:aa00 with SMTP id
 f13-20020ac24e4d000000b004eb0eafaa00mr4130120lfr.4.1681900388701; Wed, 19 Apr
 2023 03:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230419094754epcas2p3901ad6f3171a2be1a144d957c2e0d8ad@epcas2p3.samsung.com>
 <20230419094838.136349-1-hy50.seo@samsung.com>
In-Reply-To: <20230419094838.136349-1-hy50.seo@samsung.com>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Wed, 19 Apr 2023 18:32:56 +0800
Message-ID: <CAGaU9a-k9iDUNeT0s85o0GEeXSWsi98_QC+nK=jT9Yb1V=-SZA@mail.gmail.com>
Subject: Re: [PATCH v1] scsi: ufs: mcq: add 1 to the max Queues value
To:     SEO HOYOUNG <hy50.seo@samsung.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com, bvanassche@acm.org,
        bhoon95.kim@samsung.com, kwmad.kim@samsung.com, sc.suh@samsung.com,
        quic_nguyenb@quicinc.com, Po-Wen Kao <powen.kao@mediatek.com>,
        peter.wang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

SEO HOYOUNG <hy50.seo@samsung.com> =E6=96=BC 2023=E5=B9=B44=E6=9C=8819=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=885:56=E5=AF=AB=E9=81=93=EF=BC=9A
>
> If read the MAXQ field value verbatim, can use a value
> that is one less than the supported Queue.
> So read the MAXQ field value and incremented it by one
>
> below is the specification
> Maximum number of Queues (MAXQ):
> Maximum number of Queues this controller can support.
> In this version of specification, maximum value is 31.
>
> NOTE To support 1:1 topology, the Host HW controller must support
> HW resources for MAXQ number of Completion Queues too.
> Host SW may use less number of completion queues for N:1 topology..:1 Que=
ue
> 0: 1 Queue
> 1: 2 Queues
> =E2=80=A6
> 31: 32 Queues
> 32-255 : reserved
>
> Signed-off-by: SEO HOYOUNG <hy50.seo@samsung.com>
> ---
>  drivers/ufs/core/ufs-mcq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> index 31df052fbc41..a1ee3318c605 100644
> --- a/drivers/ufs/core/ufs-mcq.c
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -150,7 +150,7 @@ static int ufshcd_mcq_config_nr_queues(struct ufs_hba=
 *hba)
>         u32 hba_maxq, rem, tot_queues;
>         struct Scsi_Host *host =3D hba->host;
>
> -       hba_maxq =3D FIELD_GET(MAX_QUEUE_SUP, hba->mcq_capabilities);
> +       hba_maxq =3D FIELD_GET(MAX_QUEUE_SUP, hba->mcq_capabilities) + 1;
>
>         tot_queues =3D UFS_MCQ_NUM_DEV_CMD_QUEUES + read_queues + poll_qu=
eues +
>                         rw_queues;
> --
> 2.26.0
>

This seems to be the same patch uploaded by Powen:
https://patchwork.kernel.org/project/linux-scsi/patch/20230307065448.15279-=
4-powen.kao@mediatek.com/
