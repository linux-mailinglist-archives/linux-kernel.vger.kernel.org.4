Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D880F612B26
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 16:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJ3PKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 11:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ3PK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 11:10:26 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6EFAE69
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 08:10:22 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id x15so1632180qtv.9
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 08:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBPcSD/HzZ698uiU/GAOnCKnNQsnT1jecZdFGUx2fds=;
        b=a+92KmqAyb9PVVkyT6lvd7snui+1rQq/G1r4l3uEv4hAA81nwtlY9A9IdVeRsm8B1O
         rzmjwzDCJCTmzzlojpbLNHlraYnJn0wz22VnlXA6/kX45DIOPindJVjjmNLTSupBzX5T
         OmDFW8yxZPV2Kd9MkuVlDvvkUZLqK60i94ORMbFrYxBP5u11u2eiCQYrG7t2mCCU5pRK
         +ZBSv+JKvTp37Y0xwzU8lGXrQi+ya2ccf+N7wHTzGAzTIHN8HpLqaBBZIetztTD/0dUA
         gFFiAXcbStXYajaryL73QRyhAzC4lLpQbO2HyRYkhEekWZ2ry1EQwJhfCy3n6YecqesO
         XnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBPcSD/HzZ698uiU/GAOnCKnNQsnT1jecZdFGUx2fds=;
        b=1msmHBR46e+18TH80V6D7pAQGvONNe/OcG5Xl99t/MFovhVSQYhrsdZedcqRkPjt6R
         MEErdhkfTRJeqCWEl0JI5Bo2kJVzSRXlGcYNGptE5rgx3Hc5bkYPg0PrvEvg+718gnXO
         kT+BM+6t/R82MnBfRpz3bO3F8Vbomy0Ol35dRyFyQyY/VEkGXp6WTBddF5wdUO+zNwNr
         Bv1bvDUlGcowBUfANl1cM2BAgfzSCBeEAm3UnSDl5L4w9q1J+U6jLcG/xRJ6hKx6LJfq
         K7GOWHCobegqJEWR7soDYu610G/uCEEaIbt5KP0Y2LO0RI8EdtCfLkILBhSWJ1Bodr32
         Mntg==
X-Gm-Message-State: ACrzQf0e1P3a/7KZnWXXqj9hADJinI5Uf06F/13a9THMv7XgaKzc3boM
        2nQ36wu3e6QIyrg07z6e8LDkJcwRtV3rYgrSRvE=
X-Google-Smtp-Source: AMsMyM6X+/aUfLteqbRVpmJeXDZNgv5HNuJ0Nr1j9VzqTf9TLdPDR1cxInofLJiOQA1E0o65MVDm5GsMepWFpZ9WDtk=
X-Received: by 2002:ac8:58c8:0:b0:3a5:a3e:c651 with SMTP id
 u8-20020ac858c8000000b003a50a3ec651mr7366367qta.340.1667142621091; Sun, 30
 Oct 2022 08:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <Yz8rIxV7bVCcfZb0@kroah.com> <20221007013708.1946061-1-zyytlz.wz@163.com>
 <CAPM=9ty0+ouf+rQWhM=9XSKFOA2zxKfa00MsNBvwrQGPQm2uPQ@mail.gmail.com>
 <CAJedcCwxioxr+4TBTdrEjAZh97J3oroSHSgax+bxSNRXCBvkRg@mail.gmail.com> <CAPM=9twhAL+c8mOLmidY_tEhEKwCh-CTjfs5yryOk8oGjMxuug@mail.gmail.com>
In-Reply-To: <CAPM=9twhAL+c8mOLmidY_tEhEKwCh-CTjfs5yryOk8oGjMxuug@mail.gmail.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Sun, 30 Oct 2022 23:10:10 +0800
Message-ID: <CAJedcCwiyO71aHmgMF=v1qjNRQrL6+ZkiRoGWeqD3RmJMnk6uw@mail.gmail.com>
Subject: Re: [PATCH v3] drm/i915/gvt: fix double free bug in split_2MB_gtt_entry
To:     Dave Airlie <airlied@gmail.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>, gregkh@linuxfoundation.org,
        alex000young@gmail.com, security@kernel.org, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, 1002992920@qq.com,
        intel-gvt-dev@lists.freedesktop.org, zhi.a.wang@intel.com,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Airlie <airlied@gmail.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=8827=E6=97=
=A5=E5=91=A8=E5=9B=9B 13:12=E5=86=99=E9=81=93=EF=BC=9A

> I'll add some more people who can probably look at it.
>
> Dave.

Got it, Thanks Dave.

Regards,
Zheng Wang
