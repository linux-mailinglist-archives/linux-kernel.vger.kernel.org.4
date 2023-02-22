Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B4C69ED56
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 04:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjBVDMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 22:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjBVDMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 22:12:22 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2932E82D;
        Tue, 21 Feb 2023 19:11:54 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id x41so6581240ljq.13;
        Tue, 21 Feb 2023 19:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zNaFMBMYjszLIMNwm9nfdvrGjZqm6B4tt+On23nJyTc=;
        b=fmfGqAOsDB60738L285br04P8DANes2K/Tv98hhNfH3Xs5XYRBCUc2p+WQDyOS5tQo
         Q+LWEA8OJ2xn3yfgz18qSC/ZAD5nDWnuOCxLcXfubd3Knyj3P/zbTYWN6EEaCETRQaAt
         Oc2/tbx1ayiJYK+arqS9gtbTnEIkREJTY37nFJtMWc/h7ur+5VfPHd4aI7sVKBhhQ83o
         napzGAEQZxOmhuEL7mFEiQv4vQpk1uE4P6gUDvzx/rShM1AlMplgP9FF0R+DBm7sqXqA
         /fD42bR1jdlJp1ALlwfRva4IooQa+7i89t0crvWVXIcGJ6wQU2d7ALhE6kgDuIwFHuhb
         KvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zNaFMBMYjszLIMNwm9nfdvrGjZqm6B4tt+On23nJyTc=;
        b=G0gY7ZEgtEHJCWFMYH6eTu3zitDYvHxIvEVwzh+998qu3P1ycINHYMLXEKSQQh1jFd
         KcoPSY2NkynTFqhHobdoOypkXIBwF4eGD4aOeZW7T6tqyTkXhGTgWBLNTiWG/Ac/hOj9
         YXujsKySqI7TzpimSSBSTfDJpHWFEQX5e8lEgK+34rDyvaHIMC0UV7J0OAhZxm5noeYE
         WHhQCCijeIS0MtjGUoQCAoCZF/gE9nyCFqb1leVq3ibRv+eXbpPNrQQih2R/LUzSsinL
         KuD8zxO7edGt7gnSyuAGOZxBx79KpC6Ka8lRuWNYJGFZ9tm6pvFJsvfpjqZ6bdxJEZ1I
         hW8A==
X-Gm-Message-State: AO0yUKV0tdjh8yzkJAPBGfYK5jKJP1zdULydi43wHuIAFyhFc9ckob3E
        TftipOkEFSzPBKNFk8X/BqA+qCvYIAIMae7JSQ==
X-Google-Smtp-Source: AK7set98faJfc/hSpvMVcieQV5UmQYC3dAwOgPi+RRqhZzy/3dex8rxO+fMeXVTDfPdZNOSWUNfwACMIBCXfugtSlOc=
X-Received: by 2002:a05:651c:488:b0:293:4b99:f883 with SMTP id
 s8-20020a05651c048800b002934b99f883mr2205922ljc.8.1677035511982; Tue, 21 Feb
 2023 19:11:51 -0800 (PST)
MIME-Version: 1.0
References: <20230222030427.957-1-powen.kao@mediatek.com> <20230222030427.957-3-powen.kao@mediatek.com>
In-Reply-To: <20230222030427.957-3-powen.kao@mediatek.com>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Wed, 22 Feb 2023 11:11:40 +0800
Message-ID: <CAGaU9a9Yx6DAGpoULJ7j19i+KKAw9iUjeXucH8o3XdHAqDNamw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] scsi: ufs: core: Rename symbols
To:     Po-Wen Kao <powen.kao@mediatek.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        stanley.chu@mediatek.com, alice.chao@mediatek.com,
        naomi.chu@mediatek.com, chun-hung.wu@mediatek.com,
        cc.chou@mediatek.com, eddie.huang@mediatek.com,
        mason.zhang@mediatek.com, chaotian.jing@mediatek.com,
        jiajie.hao@mediatek.com
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

On Wed, Feb 22, 2023 at 11:05 AM Po-Wen Kao <powen.kao@mediatek.com> wrote:
>
> To avoid confusion, sizeof_utp_transfer_cmd_desc() is renamed to
> ufshcd_get_ucd_size().
>
> Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
