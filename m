Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AA669ED88
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 04:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjBVDeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 22:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjBVDeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 22:34:07 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B5C34F45;
        Tue, 21 Feb 2023 19:33:24 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id by8so1531261ljb.7;
        Tue, 21 Feb 2023 19:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BHFZkmuOI6BBxjehOO7TZF+023IFD6iXS2Qeu1DPdGo=;
        b=BBEgUeGnp+x8jZiqSGBLkg4okUweEOQ507KEEynqmRKEhs+L3RGzD/urFDM6IoduKr
         aYRCnsmCygJhS9iRm762tmUYefxtktzDhpMhAxmf3ufDUyiJoKD5sO4YFzI6xqzu2Fp1
         7zu1LCt1zZ+cLiBnyTXrRi1SutJ2QIsNFr0YyWuejEDTwrfFeyIzA5KAPgeGnThv9ILS
         ubMVlMC6SGdT6GlidnNo/O2syYoqp7cZz/DBQ65Mb1GYWylldnyeTN9RNFDXsrLNia5f
         sk09TuKTfX8q07yx3RDtYTnV6c3bbSDOqxtT6ajB+owjNJ2HbDvgKpFBjmfnDjp8tY6F
         SGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BHFZkmuOI6BBxjehOO7TZF+023IFD6iXS2Qeu1DPdGo=;
        b=KK9+4ka8VL0BE5IJ1F0q6s11etU0JO3LPA+3XjpcXFJAlJC8EaxZbwU98cCGZX103l
         WeRJ4tQu8c9Y7jJXxrmCsmfvPWn90XH/hmCM7dsp9zBqtRsTOznL0E/r6NOOrFO+g4EV
         wXxLvlo+PT2/xUoG/jfL4KfkKephYAKduQR2IvOlM+DEa03aj3tU3fudFiG80rHWKA3e
         WoA7O1HTQ1qthaV8Kxpx4P2Qlr4vK7YD40tyDS0Q6Qc4Hs8RJM5FgafkgYkfxhDjls0D
         roaxTjCml6Nepa/jOznpAf35o2LpUzSFp2d7ACW3ksLdyB5pCtxplGnHRFESf5Zh4Gi+
         yT/Q==
X-Gm-Message-State: AO0yUKXa/gpDyxZ5eLCeKj++FdUfe2E17ukv/TzscwKt29F1eZxc/L6e
        tE/qs7olMmC3qiBt8Jx63SRymN7vrQZr9u1blg==
X-Google-Smtp-Source: AK7set+0L9PPz40Fyy1a4rZ5p7rDYSNtyek52Q67gGpslyDHlhVrpRatkbfM+OW3ZiSQGf6iOf5S+OvWZQt6VdQoNHo=
X-Received: by 2002:a2e:b4a3:0:b0:290:6f84:541 with SMTP id
 q3-20020a2eb4a3000000b002906f840541mr2247736ljm.8.1677036802009; Tue, 21 Feb
 2023 19:33:22 -0800 (PST)
MIME-Version: 1.0
References: <20230222030427.957-1-powen.kao@mediatek.com> <20230222030427.957-6-powen.kao@mediatek.com>
In-Reply-To: <20230222030427.957-6-powen.kao@mediatek.com>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Wed, 22 Feb 2023 11:33:10 +0800
Message-ID: <CAGaU9a-8f6FcnOAnJMJhawR_ijGtc_r71eYzyqyq-PrYuvi86A@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] scsi: ufs: core: Remove redundant check
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
> is_mcq_supported() already check on use_mcq_mode.
>
> Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
