Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB416268F4
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 11:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiKLKsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 05:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbiKLKsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 05:48:51 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442041704A
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 02:48:50 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id a13so10916502edj.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 02:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T1KbWBlZBhM2Kq75dZ0wOhP1yyovyscLgSDKPYowZgA=;
        b=MHGvQpjeKWITiMA2BGsw56dD/TYI6pGz1+NBgLHUgJq1FVAFQ5BM2w59CtK2Wv3N9v
         HPIyqB1VEQdE0otfzH2RqOd8AF+Ino/X9W700mCt/YqkQp+NomeOpmfAxTCAArA9i4ox
         s5F9PqDrCKqvzj3GGlwToMvPRjdx1yMNdqR6yKs2Hl5h/pZfhFYtCf8FQc/TvDZErHSw
         C9vn2PFyUPxNlgb0mJXAY/vJa4I1+zOpPlcRuh7tfXTPqrk9d6mtfkDlmhp166YNrz0P
         V1Scwa1xSQV9TZPxbtqQY2aWZtVriT6+3Au/Jtk3UhAukFsN3ULcP55y+WdlFySvM4yy
         aMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T1KbWBlZBhM2Kq75dZ0wOhP1yyovyscLgSDKPYowZgA=;
        b=DuQh9z65TQ/L5atYYHN0Akpshq55d3erq8BK6v7VuyERU4ofyXIL0ypMrRvQUD5Qtb
         ovsxSw73/HeS0/K94sRRiNBt6IsuOEkBR3ZcCq4IV2es2NOdx5j3j3THjSsaU/rdsMvr
         6qQO4P8aBaHtpw/41SsZAKMBXPI8kR8IEputrZJgDZcZsnFx40VVw+woSjzL1qSRGQfN
         5cj8mQKqbejZ7fgKWjDh0NtMkrgGkeGDDdsnFRA76elQnIsB03MSknU6HJEbF5vF30qh
         wP4vxb+VqI+E0AX5pR9lvwTTMSHarPqDuMosC/qUusjIhgoHlhJWl3S23rVoHzMkNdOx
         9lXw==
X-Gm-Message-State: ANoB5pk5iemWfgysFvV1NrIrKwAx3l+xx6NddHsP4izlAk5Kcp61gsVS
        ouWOFV720/LYLzKQFZInO0L0cw4JCPFTa8AJC+tiIfvcPLk=
X-Google-Smtp-Source: AA0mqf5Q6sNMuZbNFbbMcNPnTcBq0N+GZooXozdmjyKQRKuLsUxZEaUCTizZwzfu2OdAdBTCQKP1CvCBiDn5d7Fb3UI=
X-Received: by 2002:a05:6402:538b:b0:461:abcc:328 with SMTP id
 ew11-20020a056402538b00b00461abcc0328mr4824003edb.318.1668250128856; Sat, 12
 Nov 2022 02:48:48 -0800 (PST)
MIME-Version: 1.0
References: <CAOM0=dbwNs1XcnD0i+SrC1S-SNFEGXM5G8QrVCqAxaz=YkAEFg@mail.gmail.com>
 <20221112074759.GA5111@1wt.eu>
In-Reply-To: <20221112074759.GA5111@1wt.eu>
From:   A <amit234234234234@gmail.com>
Date:   Sat, 12 Nov 2022 16:18:37 +0530
Message-ID: <CAOM0=daopCt=LthGStL2zHYxgQ6iphLLfKZjxcPS07yCvyq42Q@mail.gmail.com>
Subject: Re: Setting variable NULL after freeing it.
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> It depends. What's important is not to let a pointer exist to a freed
> location, so if you're doing:
>
>     kfree(card->pool);
>
> then it's usually important to follow this by:
>
>     card->pool = NULL;
>

I checked in kernel but at many places this is not being done. I can
change all that code. But, will the patch be accepted?

So, if someone is doing -

kfree(x)
._some_code_
._some_code_
._some_code_

Then I can change it to -

kfree(x)
x = NULL;
._some_code_
._some_code_
._some_code_

But, will the patch be accepted for this change?

Please let me know.

Amit
