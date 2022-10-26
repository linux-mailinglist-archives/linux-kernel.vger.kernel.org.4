Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE51660D849
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 02:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbiJZABq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 20:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbiJZABm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 20:01:42 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7139A870A0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 17:01:38 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-3691e040abaso131329427b3.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 17:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=glCk7ccfJxc5D3gWUfTDEw4pL6+6TVaRUU0ADyBzx3Y=;
        b=Kog/bZ+uBPn7+9myW44bp37FZrD2a9Ch9Uka7Hk+ywdau2jxtw+V7IrEnNza2JTB+N
         qrMxwbVpNcVKqT4VrlA8omoyA3IvT2QY4wtTAv7H+jXfu925awmdqtkphc3Ytwxz5JIR
         W8mRNw6x6Q5/4gs2veKwmagn2sAiWS48XzdodVomUOxO+EhhnNcoItZUqH098sUACSIp
         rXWuIIcjTf2jx5GwE40iBnNrxptTlrM1nHVmdWL2HpflxZJjBTrDz/AWFuzDP31Fyzhj
         s0CKGw2waX2yTTxMLHDvIWiy5F+6Aj9PXFTPkHKng4P9V2sv00mte6JTcFOpwfFeqoyP
         4dtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=glCk7ccfJxc5D3gWUfTDEw4pL6+6TVaRUU0ADyBzx3Y=;
        b=1VJ7iE67uT/SVqKcmu1cp9B8wUIrCIgo/qMrVB4qpP6z2inL4vgV1ha4MPaefyLhKr
         0DzghpoS3V4o64sF8JzFUcAGItwigTIuNcDAN4hXei8R4NT2mpFvg3pHjUPnBDmkeV1J
         8Yq0Kkgx4Q6qORPCDFFnWxStRkejBodKmpqHV+hOAfCU1D8F66amnGDLxxCI4R4X9lGT
         k6CQ26Duqvusk3ZrZHm98pEuwJmQXvjRFZ8FTRcQO80cTQvf/HJcFAWcSugseNWoi7hO
         OjLQVb1FBIP0+w/mUIKKbldW50M0hLsJxExHC6sbLfAMpDI8eYmVkfLdJQlp75daZV1M
         Csuw==
X-Gm-Message-State: ACrzQf28zEUEFZretjQ7riQrrVlAW7CIjZCC7KcWPQcz6wZjyxdAsC8y
        aJU4RZk9eTzPq8gNLvTHwjAcxlWzKmQeg0wgVxKb
X-Google-Smtp-Source: AMsMyM6eEU8DZqvcsFj6FDk+8MLNnpVRhghnsIVultm4g4VuzR6XaTUdzqC1GPzguMlH5DOSnky3KM4hhrh8l2ifB2U=
X-Received: by 2002:a81:138f:0:b0:36a:2ca7:4ec2 with SMTP id
 137-20020a81138f000000b0036a2ca74ec2mr21546509ywt.336.1666742497126; Tue, 25
 Oct 2022 17:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <20221025125744.2393200-1-cuigaosheng1@huawei.com>
In-Reply-To: <20221025125744.2393200-1-cuigaosheng1@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 25 Oct 2022 20:01:25 -0400
Message-ID: <CAHC9VhQpjt9nitmhPrSakhNDFTcn2pX6zLbcmBSwdz5MA-o7yQ@mail.gmail.com>
Subject: Re: [PATCH] LSM: Remove obsoleted comments for security hooks
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     casey@schaufler-ca.com, davem@davemloft.net, lucien.xin@gmail.com,
        omosnace@redhat.com, gnoack3000@gmail.com, mortonm@chromium.org,
        fred@cloudflare.com, cgzones@googlemail.com,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 8:58 AM Gaosheng Cui <cuigaosheng1@huawei.com> wrote:
>
> Remove the following obsoleted comments for security hooks:
>
> 1. sb_copy_data, the hook function has been removed since
> commit 5b4002391153 ("LSM: turn sb_eat_lsm_opts() into a method").
>
> 2. sb_parse_opts_str, the hook function has been removed since
> commit 757cbe597fe8 ("LSM: new method: ->sb_add_mnt_opt()").
>
> They are obsoleted comments, so remove them.
>
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  include/linux/lsm_hooks.h | 13 -------------
>  1 file changed, 13 deletions(-)

Merged into lsm/next, thanks.

-- 
paul-moore.com
