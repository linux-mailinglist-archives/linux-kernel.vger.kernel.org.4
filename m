Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A961F6428FA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiLENLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiLENLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:11:15 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D75DF62
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 05:11:14 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id h28so11270850pfq.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 05:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:in-reply-to:references
         :thread-topic:message-id:cc:to:from:subject:date:user-agent:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5nMGbrXGhiB4HhM2ObWO+aQ3wI1+eF07URsd7WNtM24=;
        b=DncO5p0pU7swZj9TY8hDwpgM6IAwHfAvqOdCHNyviwn2S/yFTQHi6Zjd0VDKzPCbyn
         Xd7Wdfiy/6AHcRt9jBbuPpcMYSGwwAanxbukVUYklGkg+JKrFA5scFfBTynu53q9x6XJ
         kQ4DoYbawrCK413XOJvk3xdEMAz2n9pxkT7x9zr0WNYR4l9RYBvrsUS4HvbSgBGDg/4a
         GtCkXwbvxsxbpCP+7zAwSx4WZzJjVPv4zd1AbWbRIVNIlwDzbPZsJygwcfM+AUVFber6
         Th6kEHpoN+Nlva3IncSgACB+W1QfZXxCednFuGbPoECvhsyMG4/5wBHARN7QC8Og+9Ni
         1RCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:in-reply-to:references
         :thread-topic:message-id:cc:to:from:subject:date:user-agent
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5nMGbrXGhiB4HhM2ObWO+aQ3wI1+eF07URsd7WNtM24=;
        b=EsNyss3o2w6BebnfdGdWtobKu1e+ES4iVAfMPIPjdoBPgr8PDemdxikbDoOr3+8UtQ
         vfkriiJ1HJmeQgDA4IebsYhnKGSUNzlHix/goB7vRqB1BKCj+Rvu5HtddN2+yD3t998I
         yPLHUZRoawKaS1BuRHMVHtPtzrWORAnXtkNWTlXB5MECGJq6nz6uzK1tIzi5ySz+Ficl
         NI6IGWqIY3cIkhvagxRJHyo4UX7fbq6fFbz3LYB3nszDZJ8PeoM5N4zAVKGGwiZXUBat
         fshjUZb01/g7VEIS91DvvD+7A+aXO3zR73kI5aQInUTYYvrdm8kOfPj732c7TBH9H6uq
         1Ovw==
X-Gm-Message-State: ANoB5pmGoeTIBeou+9cASnymsgbXBxiTfESbd0lbuYw6vv/H8AcbW2FD
        lsUhNQ/Qnc5Li6wbbT2EZ+0=
X-Google-Smtp-Source: AA0mqf4Fw9H8urJb4u5255XB0j6dp4JZ1HDpEIUtTR+NLigc5OiABlHz7vFWIJ56BzghnFtBFB9dow==
X-Received: by 2002:a63:4643:0:b0:477:751a:4169 with SMTP id v3-20020a634643000000b00477751a4169mr57149906pgk.300.1670245873763;
        Mon, 05 Dec 2022 05:11:13 -0800 (PST)
Received: from [30.20.53.28] ([43.132.98.43])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001766a3b2a26sm10535133pli.105.2022.12.05.05.11.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Dec 2022 05:11:13 -0800 (PST)
User-Agent: Microsoft-MacOutlook/16.67.22111300
Date:   Mon, 05 Dec 2022 21:11:10 +0800
Subject: Re: [PATCH] checkpatch: Add the backport commit format check
From:   Xinghui Li <korantwork@gmail.com>
To:     Joe Perches <joe@perches.com>, <apw@canonical.com>,
        <dwaipayanray1@gmail.com>, <lukas.bulwahn@gmail.com>
CC:     <alexs@kernel.org>, <linux-kernel@vger.kernel.org>,
        Xinghui Li <korantli@tencent.com>
Message-ID: <E4ACC146-581D-4D38-81F5-873BBCC61A9B@gmail.com>
Thread-Topic: [PATCH] checkpatch: Add the backport commit format check
References: <20221205094826.44844-1-korantwork@gmail.com>
 <b0194f880b217e905a9ce571e5b86b974beaef0b.camel@perches.com>
In-Reply-To: <b0194f880b217e905a9ce571e5b86b974beaef0b.camel@perches.com>
Mime-version: 1.0
Content-type: text/plain;
        charset="UTF-8"
Content-transfer-encoding: quoted-printable
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        MALFORMED_FREEMAIL,MIME_QP_LONG_LINE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2022/12/5 20:46=EF=BC=8C=E2=80=9CJoe Perches=E2=80=9D<joe@perches.com> =E5=86=99=E5=85=A5:
>    nak.
>
>   I don't believe this should be an accepted style.

Sorry for my confusion between LTS and mainline.

Thanks for your reply.


