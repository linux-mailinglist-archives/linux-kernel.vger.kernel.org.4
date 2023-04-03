Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE25A6D4489
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 14:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjDCMgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 08:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjDCMgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 08:36:09 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B05B1A7
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 05:36:08 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id n125so34500601ybg.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 05:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680525367;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HTdGFGo72jT0G2z3qfuhKe8NQ7sFzB56HywL+T9phf0=;
        b=n//QZ4XWVxmdZdtfcxtWZQfogUQH8NZ1n30agZwN8PvCKA7JF1tTnlxPKNBSvQUapS
         NGdK3ZPoAzF9sLfhlJOlVEdMM/1ZGqM8zB88fVnIWa9uFcSHP1nEdWGwmTMpZ7DzJn7z
         01vkKnSI4g/jiF4j7qcT2UD9py0cyfh35S+gy/5/tQIgm86dYQj6VOiL93xHLqIPZy1t
         cd0Z9A4SI+XhNjCW6H+7xiyjvfCrONXKa5xV3RT3eKtqQaQ8VnIQ0h+eICzxYiyZs+th
         c1EDkx66f29BX5o9rujrr/uhOSC0/MCIKwKvoFqIRXDUVys9ZlSpIij8wWHRBvTVXLpW
         YZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680525367;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HTdGFGo72jT0G2z3qfuhKe8NQ7sFzB56HywL+T9phf0=;
        b=OGLDSi9ZRA8Q0MU8J9Qlfa97TNbe0EoPVJu4SYU5XSQz3srUQMdk5RgglNjfJI1uKM
         gXQihw+3FrGO/6ToM+BSL0hVKIFgfEy4vFqcQJWqP1ywDvMLoUD6IlPDLInVXH+aJaoX
         /h6BNT/XYmXMaA3pdqrrWFxv51dOx69aR0lykx3ZtHhroAPMg3OyObatblSuaqLRT7eR
         T0wgwRwTyq4JEwVkJV2ir0SbHQ8L15W9WlMebqXIWT3voIyiuKJ8nGsGGw/FicG7R5d3
         Utenf6zvw72H/SgjOv2pJBvakxDNCLRm4uUwQbIc0ZpAef47HHkTpb5eOtnJy7w3+NP7
         P4gA==
X-Gm-Message-State: AAQBX9cIV+rQvtuTJrowg/87X9XDysvInEVY6EpsvQbQd/MVuO911cvH
        btOp1rScy28NdUKIymn7jrSwTeay2N2sjiefBTSObg==
X-Google-Smtp-Source: AKy350aGB0ahI/fUaNW0BoHgcBvb/iADnkkKxVOCPgr2PYtuEuuF3boDBTjSZywA5BVAHNPv6R6cANKREHNU8ivW9Sc=
X-Received: by 2002:a25:344:0:b0:b27:4632:f651 with SMTP id
 65-20020a250344000000b00b274632f651mr17084702ybd.3.1680525367299; Mon, 03 Apr
 2023 05:36:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAPDyKFrVuQwLfQZKx9x3PNKTYctWi7=e=vnUsdJgJLJ6=1o2iA@mail.gmail.com>
 <03265187-6336-9b1f-ea0d-ecbc3c8546f2@nfschina.com>
In-Reply-To: <03265187-6336-9b1f-ea0d-ecbc3c8546f2@nfschina.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 3 Apr 2023 14:35:31 +0200
Message-ID: <CAPDyKFrap_T3B6k=kUqfXCyJaW87sdEfsymmNm_pYRFLeX3n+A@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: core: remove unnecessary (void*) conversions
To:     Yu Zhe <yuzhe@nfschina.com>
Cc:     adrian.hunter@intel.com, quic_sayalil@quicinc.com,
        quic_luliang@quicinc.com, m.szyprowski@samsung.com,
        wsa+renesas@sang-engineering.com, yebin10@huawei.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, liqiong@nfschina.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Apr 2023 at 14:13, Yu Zhe <yuzhe@nfschina.com> wrote:
>
>
> > On Tue, 28 Mar 2023 at 05:11, Yu Zhe <yuzhe@nfschina.com> wrote:
> >> Pointer variables of void * type do not require type cast.
> >>
> >> Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
> >> Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Did Marek give his reviewed-by tag offlist? I couldn't find his reply,
> > just to make sure this is correct?
> >
> > Kind regards
> > Uffe
>
>
> Sorry, it may be a misuse of "reviewed-by" tag,  "Marek Szyprowski" gave the error
> report at the previous patch, so, i put the name at reviewed-by tag.

Yes, you shouldn't put his tag like this, unless he explicitly has said so.

For bug reports we use "Reported-by:", but in this case I decided it
was better to drop the offending commit, which means this isn't
applicable here.

Anyway, there is no need to resend, I will just drop the tag when applying.

Kind regards
Uffe

>
> >
> >> ---
> >>   drivers/mmc/core/debugfs.c  | 2 +-
> >>   drivers/mmc/core/mmc_test.c | 6 +++---
> >>   2 files changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> >> index fe6808771bc7..2c97b94aab23 100644
> >> --- a/drivers/mmc/core/debugfs.c
> >> +++ b/drivers/mmc/core/debugfs.c
> >> @@ -246,7 +246,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(mmc_err_state, mmc_err_state_get, NULL, "%llu\n");
> >>
> >>   static int mmc_err_stats_show(struct seq_file *file, void *data)
> >>   {
> >> -       struct mmc_host *host = (struct mmc_host *)file->private;
> >> +       struct mmc_host *host = file->private;
> >>          const char *desc[MMC_ERR_MAX] = {
> >>                  [MMC_ERR_CMD_TIMEOUT] = "Command Timeout Occurred",
> >>                  [MMC_ERR_CMD_CRC] = "Command CRC Errors Occurred",
> >> diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
> >> index 156d34b2ed4d..0f6a563103fd 100644
> >> --- a/drivers/mmc/core/mmc_test.c
> >> +++ b/drivers/mmc/core/mmc_test.c
> >> @@ -3045,7 +3045,7 @@ static LIST_HEAD(mmc_test_file_test);
> >>
> >>   static int mtf_test_show(struct seq_file *sf, void *data)
> >>   {
> >> -       struct mmc_card *card = (struct mmc_card *)sf->private;
> >> +       struct mmc_card *card = sf->private;
> >>          struct mmc_test_general_result *gr;
> >>
> >>          mutex_lock(&mmc_test_lock);
> >> @@ -3079,8 +3079,8 @@ static int mtf_test_open(struct inode *inode, struct file *file)
> >>   static ssize_t mtf_test_write(struct file *file, const char __user *buf,
> >>          size_t count, loff_t *pos)
> >>   {
> >> -       struct seq_file *sf = (struct seq_file *)file->private_data;
> >> -       struct mmc_card *card = (struct mmc_card *)sf->private;
> >> +       struct seq_file *sf = file->private_data;
> >> +       struct mmc_card *card = sf->private;
> >>          struct mmc_test_card *test;
> >>          long testcase;
> >>          int ret;
> >> --
> >> 2.11.0
> >>
