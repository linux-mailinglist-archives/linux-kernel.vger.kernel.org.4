Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BB55FAA73
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 04:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJKCD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 22:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiJKCDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 22:03:20 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B1A7F0AD;
        Mon, 10 Oct 2022 19:03:19 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id l19so8156756qvu.4;
        Mon, 10 Oct 2022 19:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VGL9iA1eU5cRSfFnKKNpXrK9dyHSOHJ0yZSzYyhp9uU=;
        b=cmhVkoms9HBWoRT2ra/pvHPATa5XnR3v1/v64xNqA9d96OlkusGwkkppuvTf5T1mPp
         GjKZfBXg/ni1RRrcHcqI3pPNBycOvYNmOyDAuJowU2/MuIBN5nRRzwBWhTWvaFVD9ETz
         Ycss9xJLT5sjwu8OCU9rPVitHo9HJ/NPGn8c2ZsZR+VyQ3BbgFfjgr59tVhLgdTvrPjR
         OQVfJuxJr0NoF7k3dYAziW4JisAmnApQxe7fIcI3/pSq+TKSRTSZ0Tt1FgQMtZRgOxJZ
         e6ClnI+vpOVFtTduucUheXF/s6A7L1hINOV9Z2Ig4yJwhcqK4FqZXBAOmoxZAmyTgIBX
         n7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VGL9iA1eU5cRSfFnKKNpXrK9dyHSOHJ0yZSzYyhp9uU=;
        b=DsDk/YYhRyNjyIFb3NoCWsbJy02EMNPvfFD6uWsC5upLnjyWcj2VLnG7xCfK4M9pAA
         1kh4gQOq4LbvZDiiJ/ipDW0CqJq3DkTVUMHwYZ0rNzR2Ad0HkBG1X2P2m0rsy1l/DQgp
         cH8WfBxgXaSJ66fBvr8gq2KLfSINT+fK3qA9GufCkh667npch+a38klZs6TQCdbQvxTa
         QWSQ6KI9MtJrgV/OIXC0qnxFkayiRI3M4gN3SgmqMgvYxRrpOe04ETp9Obv7RkObiRxR
         aVCp7mudpNLIISHKMaQT0Sdxg8smm1bWzHL4qr0cqbGf9vCoSE2J+uQxlG1eEMQC5TC2
         Kt8A==
X-Gm-Message-State: ACrzQf3+dwDqtL0OL9Lf/3P8mS2PkKjQRfrlvTgcJ6TYhLl7+79ONaBk
        xIf6sMtvwSrBjuwIpxLS9r8MlO22+KrhgmN3pnU=
X-Google-Smtp-Source: AMsMyM4sskn1qHLEbgtpuqCpTKAmMOFsZykhgopt0w63D6jlQ93xWB+eubSYkKb0Blge9yTSd9Zbu2pKaItAcNTwlBI=
X-Received: by 2002:a05:6214:2a83:b0:4b1:cdc6:821d with SMTP id
 jr3-20020a0562142a8300b004b1cdc6821dmr17207341qvb.36.1665453798548; Mon, 10
 Oct 2022 19:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220922023337.15609-1-renzhijie2@huawei.com> <904af4cb-147f-a7ba-63e3-c27cad0350f2@gmail.com>
 <b725c6eb-1026-a010-1e93-50af9a96a0a4@huawei.com>
In-Reply-To: <b725c6eb-1026-a010-1e93-50af9a96a0a4@huawei.com>
From:   ChiaEn Wu <peterwu.pub@gmail.com>
Date:   Tue, 11 Oct 2022 10:02:42 +0800
Message-ID: <CABtFH5JH3wKXq_ek+gv8ZK2+yuTL5WnniUoxL96qLNbhMQbZTw@mail.gmail.com>
Subject: Re: [PATCH -next] power: supply: mt6370: Fix Kconfig dependency
To:     Ren Zhijie <renzhijie2@huawei.com>
Cc:     sre@kernel.org, andy.shevchenko@gmail.com, chiaen_wu@richtek.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 9, 2022 at 9:34 PM Ren Zhijie <renzhijie2@huawei.com> wrote:

...

> >> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> >> index 591deb82e2c6..62111f4bb093 100644
> >> --- a/drivers/power/supply/Kconfig
> >> +++ b/drivers/power/supply/Kconfig
> >> @@ -623,6 +623,7 @@ config CHARGER_MT6370
> >>       tristate "MediaTek MT6370 Charger Driver"
> >>       depends on MFD_MT6370
> >>       depends on REGULATOR
> >> +    depends on IIO
> >>       select LINEAR_RANGES
> >>       help
> >>         Say Y here to enable MT6370 Charger Part.
> >
> > Hi Ren,
> >
> > Thanks for catching this!
> >
> > Reviewed-by: ChiaEn Wu <chiaen_wu@richtek.com>
> >

Hi Ren,

There is the same patch that Sebastian already applies.
(https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/commit/?h=for-next&id=d8be4fe92433ad905eedc7d877099685eb2eaaa1)

Thanks.

-- 
Best Regards,
ChiaEn Wu
