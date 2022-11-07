Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B3661E9FE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 05:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbiKGEAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 23:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiKGEAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 23:00:25 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5DD12D;
        Sun,  6 Nov 2022 20:00:23 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id t85so5833405vkb.7;
        Sun, 06 Nov 2022 20:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OYmRm7oG51RbUpQkbwP4pUo2C/0pgsAKRA0ejIgXRzc=;
        b=eDWyjimtWuPJKWH1qX2FEfWNE6ve/pF1mSsox+rNfpMI3iIvGdDKpTdQ827vKYOrGC
         UGPkYwQY8QB9UdR+4RoDRYK7QivxJtUJULxId0KC6KtqUKhnfYZqiAuTEWQvgZZ8kvip
         D00EVUwxKDcVJDoYXLQwZ4S8Z6NiuLWG1w6TObgtp+20nneX0YPLICxkjPg5zNPhh9ye
         3RXLnIPzZPKEGV/qbDIo7hzNKGZhYYNqwk1VIYxFW+d6XtsW3GeD2SXKdeSwWImaN6sb
         /+8GZ1rF+IzLa8Vm1bPc+EnN2ZuG4yxZn3nTtnlAwZ0Ehtr0R+ZqJVhC63xELqEtFTcb
         20lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OYmRm7oG51RbUpQkbwP4pUo2C/0pgsAKRA0ejIgXRzc=;
        b=q2QzQXp+IkenCBw9boU6XIkXnp9ZVLzfEXIkyfpKkINLzesRXKLPq+RllHGJbbN5zB
         GhN+ZTwuc8DlufGfu9gOHyK5vjJ5xP1kVhGMM9IGwws/T6mJqKZxLFVtUvJgfq+jKcva
         9iWyelY4xFsgMDUdrTLE7U2jTibLjd+3Vdy41cnmtnR2eCkBzy0iVo8l8O14KP+OSg9c
         29eYUi/KE+2yc4RCf2gS0ZLNbBiodl1/YxtClGK+m9KrSV9lGCb/Od3IqcHnYvGpYtQ+
         lG4Lh1Dwu27gMC1BAnknCOB/ryClu0r75lTm+1XNtINHwqaxe9fwggpZ/XYsMTeWVotY
         RVow==
X-Gm-Message-State: ACrzQf2dFBhu/YrLBspsPqi1sLjkwSEUjs2XNVO3wJ8lKLUk0uHKc7Bl
        XECwDlcXMJ2yd7Mjb8eCKvNLP8w8pl/e9+Is0kTpTOKqBfc=
X-Google-Smtp-Source: AMsMyM7IiGVA9SCS1uAK1ObapKXvMnZtoaCcBznY2DwQxVgjrVhnQv72JWmX9y71CgTz0bgMuYyXKS+LMF7BFdM9Vlo=
X-Received: by 2002:a1f:2356:0:b0:3ab:820:316f with SMTP id
 j83-20020a1f2356000000b003ab0820316fmr7671445vkj.15.1667793622488; Sun, 06
 Nov 2022 20:00:22 -0800 (PST)
MIME-Version: 1.0
References: <20221104033810.1324686-1-milkfafa@gmail.com> <1d770c8e-1ac5-34b5-7c09-f55b8325c9cb@xs4all.nl>
In-Reply-To: <1d770c8e-1ac5-34b5-7c09-f55b8325c9cb@xs4all.nl>
From:   Kun-Fa Lin <milkfafa@gmail.com>
Date:   Mon, 7 Nov 2022 12:00:11 +0800
Message-ID: <CADnNmFqnmEfqzO0QvOXw6FcaMURMKu2JmYz6TBYxH9Dz5s78Lw@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] Support Nuvoton NPCM Video Capture/Encode Engine
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        kwliu@nuvoton.com, kflin@nuvoton.com
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

Hi Hans,

> FYI: you need to CC this series to devicetree@vger.kernel.org so they can review
> the bindings.

Thanks for the reminder. I'll CC devicetree group in next version.

Regards,
Marvin
