Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A64B6076F6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 14:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJUMg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 08:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiJUMgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 08:36:24 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3F9208809
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 05:36:22 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id ez6so2355013pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 05:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5y/vcAMtKCVTrh+E/N/2LlgUlrNzauVl3aZ392iU3cU=;
        b=Qbx4MGJiXE25WxekTP+L8fcKpnb7ojaiGvhvo3d6vwji70BKe+eSk5Xy4ztsbEqltX
         JgFv9eOcepuc/9kqg+OMrrzN6GJi6fOMBVHc15DbxP0Ki+5+imQFlNiR7MChQJT+DHLq
         g3VdB2hDAqIMIx1Nv/hPxNvbWZw2mcwkEpX3uaK7kh7Tqa2RytcaKWIQMKaKaj2iRm7e
         lXKGNqWJE2FLTPXTTXenj/Rfhln9ZkivTorvGAgo9/H0GxqNBp/ydevjIwjnbCnYQ7K4
         MhyUXQTtBIrtlv4Mp994DvJ2wwsN+9/K1dtuunw2YDWB70q8sYUq4gHpAOgRUoGcRgju
         famA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5y/vcAMtKCVTrh+E/N/2LlgUlrNzauVl3aZ392iU3cU=;
        b=yJhqdw52Pb8QXzP0Lm00f8x+WBdX5NiWBoOm3WQDb1xxf67Jy/u8D6ECEPM6kSWQGM
         RldjUB53lG9oAedfRwY6T9OW5t40RZz1JPmtebEm5/z5RSC2s+3tCo3V6iKD/7YEljZL
         orYCgv4vQ1gVXBoxjtEZ0TOrypiV89NIbbBSIRvhMytkLgSgauU4AHVxRsH16DnPhL+5
         7rlad4NJm7211nNjYkwHTQskot0sCA+PT+0ISX+jjqTSmC7O4LS5W7C9fm6GLiB+Bf11
         tWXXdkG9+aHJxpOZqUw38xy1aHDGbIMteor0K6NzUJ9+BONdf68EDKGvjv12Q7SUThuP
         q0qw==
X-Gm-Message-State: ACrzQf0VL5wCIsFoxhIbYRNXedqTF0HmoRpTJoiK1Rf5H2+uZLba/6cH
        KdTi6f3vtGWHKSbsFQthBPnJAOM0/nlqFztieqc=
X-Google-Smtp-Source: AMsMyM4PFfgcQnS/E9WHft1H10vtbxT+IX20E8TXQbHHzIHseDMNJJbDOkWxD3q+UVA89SBbO1sNpalqZc/gmECW2m8=
X-Received: by 2002:a17:902:8549:b0:178:6399:3e0f with SMTP id
 d9-20020a170902854900b0017863993e0fmr19363524plo.35.1666355781420; Fri, 21
 Oct 2022 05:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsOeQ7VYm98jRVaYp6KaNsFVsAnSb33ZT8JvZxcTcEGW0w@mail.gmail.com>
 <a67598e8-c826-2740-03bb-33d37c8c8e4b@amd.com>
In-Reply-To: <a67598e8-c826-2740-03bb-33d37c8c8e4b@amd.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Fri, 21 Oct 2022 17:36:09 +0500
Message-ID: <CABXGCsNvFvJz4=N=JKYSGVcd=dKfQ3Nv_zOssMb0Z6oK79xZ7g@mail.gmail.com>
Subject: Re: [6.1][regression] after commit dd80d9c8eecac8c516da5b240d01a35660ba6cb6
 some games (Cyberpunk 2077, Forza Horizon 4/5) hang at start
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 1:33 PM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Hi,
>
> yes Bas already reported this issue, but I couldn't reproduce it. Need
> to come up with a patch to narrow this down further.
>
> Can I send you something to test?

I would appreciate to test any patches and ideas.

--=20
Best Regards,
Mike Gavrilov.
