Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CE465D1FD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 13:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239177AbjADMDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 07:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239170AbjADMDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 07:03:06 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0DF1EEFB
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 04:03:06 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 79so22043245pgf.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 04:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gbKqkFsN4hQeaKGBwT0swWYlTLMQd/HhdjuV7OkFZck=;
        b=mHVGqX8H91pzBJ3DqpDdUa8q5l+Xnziz+IY+I893b//GyPfrcaV4LyEnL5N7W5orqd
         KhjDg2DKRkhNeg7kPMi5/Dhy3WkN7600cWS/0Yu9rxCpyqo6ycTsVO0NN2JpLSH8kMyK
         vXORpTS7mvElXy7DsHenbpJaJVvGFX/hjwlGlF0eg94KlhEZgBDawY7WE2dRw3ar+b2i
         KCiH4TGS/ukHVvhsiEvXeIHB87DmZkltPYIzUeRllH6xEgLaT6NJ0QPl9TZhB2tEE4Ex
         wsFb6n+q+5/6hA8Q+vPZ5CnnwLwj2nu7jw2G2lKejRqy5shn0+KKHYefSNm2sZ/Hxh65
         xfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbKqkFsN4hQeaKGBwT0swWYlTLMQd/HhdjuV7OkFZck=;
        b=IMEO26jPJRtWlKv64MaDw973pDZ3HSsmEv1MPPXkvZ/F+R0ErkucrZfHqK78msL7BF
         SvHP1jLJcL3F8rlhTR19uQ1fHbLC7LLn518r0MH/KEbU1cmn9LPuSq7kfG7VMAL3OM42
         xjLYXzknQSlByXSi89IrRRPb6K0IhSInidMc5o0Xbv0J9BhcxNy7JCj6uGfeh1REXOoX
         wgT69mNuaPDlMN4ig9EjpeDUZGYLlrc4anvwYLGqNodf3PRppV9srmhYta1w6M+j0eZI
         Z3gyKPMU+kpcDqqPVKogrPuUa6DtCiBBUFPgOSiCJ9CnaMbaBmZupgkknSHgjhb0pBce
         T1Nw==
X-Gm-Message-State: AFqh2koHP2SKNZCzIYrD86EItFtiyOI4ngJjljU19vJlPhbEg5j3egEI
        lyiRizCmnueBLuL2R2Ug3l2qa7sHwXU5dACIyxk=
X-Google-Smtp-Source: AMrXdXvLlycQwR2yfcSSdIDuT8mAhKbn5aH7b2zhWOcV7RFoNEz+oc6njRkxGsmdCSs+xOoNDXJDDQ==
X-Received: by 2002:a62:e317:0:b0:581:4297:362f with SMTP id g23-20020a62e317000000b005814297362fmr33459797pfh.13.1672833785678;
        Wed, 04 Jan 2023 04:03:05 -0800 (PST)
Received: from redecorated-mbp ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id d18-20020aa797b2000000b0058251b6e0e8sm6856527pfq.188.2023.01.04.04.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 04:03:05 -0800 (PST)
Date:   Wed, 4 Jan 2023 23:03:00 +1100
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     marcan@marcan.st
Cc:     asahi@lists.linux.dev, axboe@fb.com, hch@lst.de, kbusch@kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, sven@svenpeter.dev, ushankar@purestorage.com
Subject: Re: [PATCH] nvme-pci: Add NVME_QUIRK_IDENTIFY_CNS quirk to Apple T2
 controllers
Message-ID: <20230104230300.66b4a581@redecorated-mbp>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
In-Reply-To: <20230104101641.12215-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This mirrors the quirk added to Apple Silicon controllers in apple.c.
> These controllers do not support the Active NS ID List command and
> behave identically to the SoC version judging by existing user
> reports/syslogs, so will need the same fix. This quirk reverts
> back to NVMe 1.0 behavior and disables the broken commands.
>
> Fixes: 811f4de0344d ("nvme: avoid fallback to sequential scan due to transient issues")
> Signed-off-by: Hector Martin <marcan@marcan.st>

On T2 macbookpro16,1 with 6.2.0-rc3-00010-g69b41ac87e4a I had this in
dmesg:

nvme nvme0: 1/0/0 default/read/poll queues
nvme nvme0: Identify NS List failed (status=0xb)

And in /dev only nvme0 existed (no nvme0n1*).

This patch fixed that and /dev/nvme0n1p* existed.

Tested-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
