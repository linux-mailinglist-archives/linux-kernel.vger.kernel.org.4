Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EECE653C4E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 07:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235176AbiLVGrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 01:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234973AbiLVGr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 01:47:29 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8774CE9F;
        Wed, 21 Dec 2022 22:47:28 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id z12so742171qtv.5;
        Wed, 21 Dec 2022 22:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D+ihXgDkeg4pVKq7FuFaMDZy+mecm/Oqo0hFC0OXH2w=;
        b=Yponx0/suKNA+Qo3mfMuMNxBvOCHq0U7moWdM77a+oj6XxWZV9j6cjmrxknQMZaDhu
         gSpWWNLF81MFHd4kpbk1liLzqMb1xjiUq6Vy+bQkw4gVnpEAUqfIm5iqOC+m6hszwxNy
         GKRA0dWuc/uUVrLzJInViLfOd4ruUoSLchF/ARKHapHNJBBAfd+OnxgiZDlWK1Cmn6XV
         8HInSMvGFjlN03VpZvr5Zrj9yAGFOj6SWga3+42Ftn5xD8VeVuNPQmmt4h8LHcSzx9s9
         ojKiZyiQmb+ueZiQ1jTq2H1cEEpsgIdaA3pka5/F004t0/gOzZ5+J8VIxutmcpQXttmS
         IZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D+ihXgDkeg4pVKq7FuFaMDZy+mecm/Oqo0hFC0OXH2w=;
        b=OyG0fYiXfyXQXPfXv96G3kvV6YYmTuMQZCPob4Z9ca+ImpUOkPJv+C2gCfZjZOMNYn
         oJgwjawyGCnTs3lMvfCYjgHnSqPCnzo3VuNjx8XKLHJoB6I64Npmml9CX0A8OyXqUnA0
         x2yX+wXNOB70foM+qQ0bBFdZh3pb8coYkKcu5sD/PVIvmrTgVzZ1JE5kTvu7p0W/zKvf
         bAHNL9/efgKi5R5T2Nbnuysm7flj/3+RKb4BoHLgF+bux3rLcFSiBBVaczeOcrjtA9mG
         0qt9ljZr5N0lmSZwSONswE04YASVXix2540TdIJY1e86ary8LPT4N4GFRljiPBCQHhiX
         I0mg==
X-Gm-Message-State: AFqh2kq151G6LDCs6er194YTdz1MtqIVsOKlyFNxdiRnsafBa6axqPyI
        sE47yOZ99JfbwDppNYN49qyLiJo+IP26wKyrZLP2IbF5lN+2ZOO1TcA=
X-Google-Smtp-Source: AMrXdXsXsHRB8rtOtpDDjfCZumj8MlPYiw1k+gIQ37C/1e2To5Qysz3bDb3cW5jnZ0xHLA3iHM3TzhkoL2kj8A2IYL8=
X-Received: by 2002:ac8:4412:0:b0:3a8:2d2d:3944 with SMTP id
 j18-20020ac84412000000b003a82d2d3944mr114901qtn.519.1671691647514; Wed, 21
 Dec 2022 22:47:27 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsMEnQd=gYKTd1knRsWuxCb=Etv5nAre+XJS_s5FgVteYA@mail.gmail.com>
 <678adc67-9e46-3eef-f274-c951b121570f@nbd.name> <CABXGCsMUbs+bf=tWnx98r4v_JzVmYdVyOos9EhcGJ6jnEwathA@mail.gmail.com>
 <a30d8580-936a-79e4-c1c7-70f3d3b8da35@nbd.name> <CABXGCsNJKy2SQffeU+uaua5SM_77YiGKdPLRdzSF3F+ShpF+5w@mail.gmail.com>
 <3cb53fbd-0bee-22f9-bba2-6ac4a87db521@nbd.name>
In-Reply-To: <3cb53fbd-0bee-22f9-bba2-6ac4a87db521@nbd.name>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Thu, 22 Dec 2022 11:47:16 +0500
Message-ID: <CABXGCsOarWTb9+ofcd14bLGuWEQOTqRQQ0bXP57mhVjnpjcEQQ@mail.gmail.com>
Subject: Re: [6.2][regression] after commit cd372b8c99c5a5cf6a464acebb7e4a79af7ec8ae
 stopping working wifi mt7921e
To:     Felix Fietkau <nbd@nbd.name>
Cc:     lorenzo@kernel.org, sujuan.chen@mediatek.com,
        Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
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

On Wed, Dec 21, 2022 at 10:17 PM Felix Fietkau <nbd@nbd.name> wrote:
>
> Sorry, I worked on a tree that had other pending fixes applied.
> Please try this:
>
>
> --- a/drivers/net/wireless/mediatek/mt76/dma.c
> +++ b/drivers/net/wireless/mediatek/mt76/dma.c
> @@ -205,6 +205,52 @@ mt76_dma_queue_reset(struct mt76_dev *dev, struct mt76_queue *q)
>         mt76_dma_sync_idx(dev, q);
>   }
[cutted]
>   EXPORT_SYMBOL_GPL(mt76_rx_token_consume);
>

I confirms after applying this patch the issue was gone (wifi works as
before commit cd372b8c99c5a5cf6a464acebb7e4a79af7ec8ae).

Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

-- 
Best Regards,
Mike Gavrilov.
