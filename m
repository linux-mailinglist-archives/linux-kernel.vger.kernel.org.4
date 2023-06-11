Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A51372B258
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 16:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjFKOt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 10:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjFKOtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 10:49:55 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795E3D2;
        Sun, 11 Jun 2023 07:49:52 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f644dffd71so4076023e87.1;
        Sun, 11 Jun 2023 07:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686494991; x=1689086991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1906mKgeCYanoMO1G8TOrxbKSD0ibOzetQNq9L6r6Mg=;
        b=THZjIIera9alBZPdSKz/hSJwZzuNrSUzFM08KE6sb5UWzK32dHSUdARGQNxnBKPLSb
         jhme7FIiVGVc7Elz0lB6eUtWTWGcixMlZHrNTTki1M4stqteLc7F8VQJlZCTP8fYQ87Y
         NzXHgZQHB3s+Fed76QMwjsKv2k2Mg65c1mQoGw9HioM4dU0Iqp4DlcsTk+qL3gzaMiM2
         DF13PNLcm3wgG1YGj2ROCG5uE1rBhkxwMvwVvQNE7VAOmTt3pOkHpn0QbVMA1yzNX/l9
         8dF92sD0fLWmG5qkXJsE8IXOhMYOo07xDpN8atuCxhCFMNowcAlq6OnJib+jFKxCKU3e
         xKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686494991; x=1689086991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1906mKgeCYanoMO1G8TOrxbKSD0ibOzetQNq9L6r6Mg=;
        b=hDcwClGx6HLZ27SDdnErGnn2lwe+G28niFKJTBbhWzJSH84kUO54KeNEH323zPoljY
         Od+hNVQ/WqdU2DBIvyxSQ8SLDqIgmX+gxnjJ+5fpxH84W6TdUBmXdl3FUdoYBjnly+0H
         Ul4HS4XUS2Rq9kzAxgux8YuH7eUc1tXQuKwNZni1TF5IPZ8/yAjPr2SuTK5sjHBhdXrp
         Q69rymuMhaWIhNMkzXaREAqytlsWxUfoyeW2x9VyMfaX9GTUfAXmLDvHj74aqD/113hE
         Wd/nVU11DsM/XBDA7B+RSEOv5+hMKbII5yWmetLffWl6m5+peGaqfbXWYHtpV+ThXdQH
         jq0A==
X-Gm-Message-State: AC+VfDyeUoPosdOk46to11VvNwI+xupMMaFodbfPpfiSto06ZshM/egs
        Lojhoj/sQ2seo1EY6EYMtmF7YR57JqCtGGEkPQ==
X-Google-Smtp-Source: ACHHUZ6DzhDPr6mRW/dRWjDarWeMJA0yjjZLskh65T9elHYEI8cOUdnqguMOAzN3gZ88cq0B0iLUIwdd99xtcXaNjQ4=
X-Received: by 2002:a2e:8795:0:b0:2ac:819f:f73f with SMTP id
 n21-20020a2e8795000000b002ac819ff73fmr1554337lji.20.1686494989928; Sun, 11
 Jun 2023 07:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230610021553.1213-1-powen.kao@mediatek.com> <20230610021553.1213-2-powen.kao@mediatek.com>
 <0367b612-b6a5-8fb1-9cee-28de04b7ce81@acm.org>
In-Reply-To: <0367b612-b6a5-8fb1-9cee-28de04b7ce81@acm.org>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Sun, 11 Jun 2023 22:49:37 +0800
Message-ID: <CAGaU9a_D_KUstcQkPXsxepCdcvn3Knv-mzBh_kJDoYHwP-ndVQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] scsi: ufs: mcq: Fix the incorrect OCS value for
 the device command
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Po-Wen Kao <powen.kao@mediatek.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        stanley.chu@mediatek.com, alice.chao@mediatek.com,
        naomi.chu@mediatek.com, chun-hung.wu@mediatek.com,
        cc.chou@mediatek.com, eddie.huang@mediatek.com
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

Hi Bart,

On Sun, Jun 11, 2023 at 10:04=E2=80=AFPM Bart Van Assche <bvanassche@acm.or=
g> wrote:
>
> On 6/9/23 19:15, Po-Wen Kao wrote:
> > From: Stanley Chu <stanley.chu@mediatek.com>
> >
> > In MCQ mode, when a device command uses a hardware queue shared
> > with other commands, a race condition may occur in the following scenar=
io:
> >
> > 1. A device command is completed in CQx with CQE entry "e".
> > 2. The interrupt handler copies the "cqe" pointer to "hba->dev_cmd.cqe"
> >     and completes "hba->dev_cmd.complete".
> > 3. The "ufshcd_wait_for_dev_cmd()" function is awakened and retrieves
> >     the OCS value from "hba->dev_cmd.cqe".
> >
> > However, there is a possibility that the CQE entry "e" will be overwrit=
ten
> > by newly completed commands in CQx, resulting in an incorrect OCS value
> > being received by "ufshcd_wait_for_dev_cmd()".
> >
> > To avoid this race condition, the OCS value should be immediately copie=
d
> > to the struct "lrb" of the device command. Then "ufshcd_wait_for_dev_cm=
d()"
> > can retrieve the OCS value from the struct "lrb".
>
> Since with this patch applied ufs_dev_cmd.cqe is always NULL, please
> remove the 'cqe' member from struct ufs_dev_cmd.

This patch removes the 'cqe' member from the struct ufs_dev_cmd, as
shown in the code section below. Please let us know if anything else
has been missed. Very appreciated.

diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 9b2d1859f885..602615e6d1bf 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -225,7 +225,6 @@ struct ufs_dev_cmd {
        struct mutex lock;
        struct completion *complete;
        struct ufs_query query;
-       struct cq_entry *cqe;
 };

Thanks,

Stanley
