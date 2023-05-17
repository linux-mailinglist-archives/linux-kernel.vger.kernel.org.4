Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0A0705DDC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 05:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjEQDPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 23:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjEQDPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 23:15:49 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77728F;
        Tue, 16 May 2023 20:15:48 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4efe8b3f3f7so358479e87.2;
        Tue, 16 May 2023 20:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684293347; x=1686885347;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0PlbG7oZLmtVb12Gg7ERnW/Xq208fNCur2NiP9XTlwk=;
        b=lXzMx1J4qGInp6vVq0qmEgHuNX8WCg8nkG3vy1CajAemLCednyJgQ7PymQJXdLaaI9
         xGzBjLZlEBRAHgf3UaitI+X4Exl4Zjk+ipQfvptld1+J+OChyNqwsuIUjyUuJQKyv/OG
         zNzoWvpQpjDRPV5kVwWezwnkRbj6Rv/iu8IUUaMczCsZrxnDfv+tTvFPRKNW8AWZd6pC
         OaVonEAW0xu78gxUNenm1QmMThjbz6fx5h5tAVrw2rOlekjhuhvqXFWANG+o3Iz8iFw6
         is6/Z4N8/GkYm1HWxT/VUZJlys8QRcsrL869mdgI/SgNMoxeMo6STZ4z0RQJa4PcCNN3
         EOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684293347; x=1686885347;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0PlbG7oZLmtVb12Gg7ERnW/Xq208fNCur2NiP9XTlwk=;
        b=H9hEfQ3L+yCVHJHkcvGc8Rg6AxokjPZMo04exw1mj2LEjFQHspJ4x0AFaaUQQf8N5H
         4kl4LW7dG+r6FoGHkduQm6SiO55IQ6KCDHfIE8ZeK3cow2Oz0evdmnNtlatnLWVbf0Xh
         sS/016ME+eYDONJE19Eh6Fa3BJhE/TP7OmT7pDWVMoJjO58fhder0ygrtluUR2lxOunj
         lISbjHlPE93G8Z/U4YBz6E/O5zf0dZfvDg5bZnAkUrPTVHviQFfhscx3gWOOo+roGgc/
         WeX4X3jGAxBHNGQDsboWCATLylL3tKli5cu0C0IQ/MmVOZ4N2eNT6T9qh2XtHxPVDWUD
         rpNQ==
X-Gm-Message-State: AC+VfDxu9ohcOiHinCej7X9vMrdtSWurx/Ex3GFsQUlA63AXonESAh8c
        YUgrXh74jsR4CnaVOpPcWti9ZzjeB92l6InUKg==
X-Google-Smtp-Source: ACHHUZ4FB2Foel5V0WwDjmVcgOnkOwYDFaUtc73xStMbdmqe2TzX2HGUxqwPGJOYQ98KkrgkYFVPL9xQZmz/bbTgbVw=
X-Received: by 2002:a05:6512:906:b0:4f0:81c:73e5 with SMTP id
 e6-20020a056512090600b004f0081c73e5mr6688330lft.40.1684293346408; Tue, 16 May
 2023 20:15:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683872601.git.quic_nguyenb@quicinc.com> <45743dac476e3b2bffb17eaf915fe7f48f87bbac.1683872601.git.quic_nguyenb@quicinc.com>
In-Reply-To: <45743dac476e3b2bffb17eaf915fe7f48f87bbac.1683872601.git.quic_nguyenb@quicinc.com>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Wed, 17 May 2023 11:15:34 +0800
Message-ID: <CAGaU9a_EVkPa0eVMFmqmJ2fEkTy+XD7nKezMX0S0uQDeWkr10Q@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] ufs: mcq: Added ufshcd_mcq_abort()
To:     "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
Cc:     quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        bvanassche@acm.org, mani@kernel.org, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Alice Chao <alice.chao@mediatek.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bao D.

> @@ -7562,6 +7561,12 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
>         if (is_mcq_enabled(hba))
>                 goto release;

Should we remove the above lines because the code below will not be
executed in the MCQ path?

>
> +       if (is_mcq_enabled(hba)) {
> +               /* MCQ mode. Branch off to handle abort for mcq mode */
> +               err = ufshcd_mcq_abort(cmd);
> +               goto release;
> +       }
> +
>         /* Skip task abort in case previous aborts failed and report failure */
>         if (lrbp->req_abort_skip) {
>                 dev_err(hba->dev, "%s: skipping abort\n", __func__);
> --
> 2.7.4
>
