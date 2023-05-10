Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAEB6FD64C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 07:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbjEJFlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 01:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235873AbjEJFlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 01:41:07 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F9B2729;
        Tue,  9 May 2023 22:41:00 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50b8d2eed3dso10396645a12.0;
        Tue, 09 May 2023 22:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683697259; x=1686289259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0TOZqVZCmU3qht+tB0NKfPhexCOFDcSX69LsbtA6KE=;
        b=i1koqZrstKqgNMiiJbwGFTgImnTzEEjYTUpDbJIpxyLRJi8JhEyDSZPif143pwZ4pk
         Xp004b1ESph+dD2hFxscs2axiZHWI1Qh9QdFIbLZSkq5nOSnFZjQbSlAVoOc+2moqsfS
         k2KDhERxh8kgL2yOgDiaK9nOkyYMk8J+WfZrjZ02oOe70Re18OHshxuUIpM7bDdOnJXC
         6CkaiNDRzxsQCa9Bbe1n7veGAsewzfi5/LM/qOaZq2pcg8N+o5dirjFZ50yChkjDtD1J
         urEz53R3FAbTzLg+Ni+lcRrsX7DUqeYMfUVNU0jlmAMhqG3ChSEjhbCSWTty5qzQVMMo
         LykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683697259; x=1686289259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S0TOZqVZCmU3qht+tB0NKfPhexCOFDcSX69LsbtA6KE=;
        b=MkyAOWXZHF9VuHuX1iyYUU8kT0WfFCBeRYkcnkiFB07vKwIMMGmyhIapN7JeAo0n/l
         ii/VaMpEwCJSF3mp+BxgqMJ7UMpOS+yVXFZuYYKWYlE+k8NmKp3+ipUvECuq5LErX5B6
         FjENc7IKnqunBreHVHHOCxZTGViKDgQJ8bhxG9f5itp/D/fwJJXK6ahJychkxzvO2oKl
         pBupe+K7phID2g3cXBcFmYk2S6ix1TVQy7FZwFdsAUohp3i/7bBoxnlhlpT5iRFd4tMw
         X6TM652uLrKkM2bphnxm0vbGZCXkXEQN8XE9bUyCAwMq86N11KLnvINGZbn0qv0+M4qj
         m+9w==
X-Gm-Message-State: AC+VfDyXVLzcr3G9rPVAb6j4A5sfyNjUkyIEBxiZwpP8lq+To+knNJ/b
        1kETipxQXpuIoJqPJLM07rMpOtf4L0mRj2Da+nY=
X-Google-Smtp-Source: ACHHUZ6wHLIoOT7ozikyRiJNHvf5T2+cCkXiiaWiU4DPZmfEUnVuxApD/WHdkBAvuy074Pcq9iXJm8gxh+5xg4rZlzc=
X-Received: by 2002:a17:907:a0c:b0:962:582d:89c8 with SMTP id
 bb12-20020a1709070a0c00b00962582d89c8mr14755282ejc.45.1683697258658; Tue, 09
 May 2023 22:40:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAKXUXMzfKq_J9nKHGyr5P5rvUETY4B-fxoQD4sO+NYjFOfVtZA@mail.gmail.com>
 <8a86ba08-cde4-97a4-d7e2-dc340609381c@huaweicloud.com>
In-Reply-To: <8a86ba08-cde4-97a4-d7e2-dc340609381c@huaweicloud.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 10 May 2023 07:40:47 +0200
Message-ID: <CAKXUXMzA8GfJaWmdaszhrTtjMy5987oZ8AaBcoT6hNVvgCiZ-w@mail.gmail.com>
Subject: Re: Situation of CONFIG_BLK_WBT_MQ after commit b11d31ae01e6
 ("blk-wbt: remove unnecessary check in wbt_enable_default()")
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 5:24=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2023/05/08 12:37, Lukas Bulwahn =E5=86=99=E9=81=93:
> > Dear Yu Kuai, dear Christoph, dear Jens,
> >
> >
> > The commit b11d31ae01e6 ("blk-wbt: remove unnecessary check in
> > wbt_enable_default()") removes the only reference to the config
> > BLK_WBT_MQ in the kernel tree.
> >
> > The commit comes with the statement "If CONFIG_BLK_WBT_MQ is disabled,
> > wbt_init() won't do anything.". The statement "If CONFIG_BLK_WBT is
> > disabled, wbt_init() won't do anything." (note: CONFIG_BLK_WBT vs.
> > CONFIG_BLK_WBT_MQ) is certainly true, but I do not see that "If
> > CONFIG_BLK_WBT_MQ is disabled, wbt_init() won't do anything.", but I
> > believe it would simply do what wbt_init() does with CONFIG_BLK_WBT
> > being enabled.
> >
> > Now, it seems that with this commit applied, the intended switch of
> > the config BLK_WBT_MQ is gone, and the config really now has no effect
> > at all.
> >
> > So, I am a bit puzzled:
> >
> > 1. Either the config BLK_WBT_MQ does have an effect somewhere, but one
> > cannot find its reference with 'git grep -i "BLK_WBT_MQ" .' --- so, my
> > investigation is just incomplete or wrong, or
> >
> > 2. We really do not need this further build config BLK_WBT_MQ beyond
> > the other configs already there --- then this config should just be
> > removed, or
> >
> > 3. the commit unintentionally broke the purpose of the config
> > BLK_WBT_MQ --- then this commit above should be reverted.
>
> Thanks for the report, it's the above case and it's my mistake.
> I will fix this.
>

Kuai, thanks for letting me know. Feel free to add a "Reported-by:
Lukas Bulwahn <lukas.bulwahn@gmail.com>" tag, and to include in the
list of recipients when you send out the fix to the mailing list.

I am glad to see that my investigation of kernel code is finding some
issues that we can fix.

Lukas
