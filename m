Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176C360EE87
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 05:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbiJ0D1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 23:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbiJ0D04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 23:26:56 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A020F6811
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 20:26:55 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id a24so280066qto.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 20:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFwHYUjzDN0mA8IGZNoSPKemBRIs93alZhFx20gRWys=;
        b=Anhhj6NTYg1jyE2HEZEZfZMqb1yqAzPlKURqUCFgAcrETyPW2IK+4H6VPipcS3Cixq
         suRBtJsu1AMhkyH5hkQ6hdOlu2xzVv0bTRLVEg3ytIfKMEjAlvJxEEUKuYJNHxP9XNSt
         3o9nRLtWMg767KdsgKe/Zau4DLe6auk0mBFdFkEZUcANgo7veSDziJqHQ5Uld4UB21so
         KhUga6sXWvZFcd7PFLNji4y3nXE6KKxq7f40MMOd+7e+ebQ11S6WqaIbGuBJN2geplT4
         F2Z8EEwpkk0HNTKvlSunySmC1ZK/3cUelPgE0CM50vhHxhcf+WbblS+DM1eHeHlqNZXB
         YkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFwHYUjzDN0mA8IGZNoSPKemBRIs93alZhFx20gRWys=;
        b=0D2+rEvqsAj03eEqOAVLA++73uoi6YiYp5L1mzOYxVP38Q3f+cSV11PsdzRWjQH65S
         bQf15s57jfJL8IcdJhgKmdMA5xg9wxtRKIh+7BY2GF1/rw/u1Ws1TFteLAJ8/iI93kdX
         /y6V3YFCAPn/L2YjX5UtOHB3EmXzMB+mM4PW/p7UNbr5/NUqsqOae8YvTv+2pblGYFaM
         /59tCROj5HiQ3hJPPFa5T6ekbjbgD5TaMsZz/8Z6WpQdpWLT/7SGCfZul1tEU0qYzk7+
         RItsRXHO+HGpTB6JHEJtR2P8F2Y11pZGCJze01FfvX2hes/6d2hkBorQEKhKDCQu1NGk
         oidg==
X-Gm-Message-State: ACrzQf0XNsIA6Qd45HXBZzFowiGSjetLseGyi5YX4IgKNLn7DTKAI+mg
        Ta2abRNjOJCyGlUcwmICAGWlp8LCDOszr8XJ25Q=
X-Google-Smtp-Source: AMsMyM6lkWL6L97VUy56JRV/rFHo27hEgmw1FhlvQz7pf7xoMcR1o+Z02FIxZfB8r3eUwq1pjdDgqcovxLypi4j43v0=
X-Received: by 2002:a05:622a:38d:b0:39c:c94d:a887 with SMTP id
 j13-20020a05622a038d00b0039cc94da887mr40343997qtx.272.1666841214253; Wed, 26
 Oct 2022 20:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <Yz8rIxV7bVCcfZb0@kroah.com> <20221007013708.1946061-1-zyytlz.wz@163.com>
 <CAPM=9ty0+ouf+rQWhM=9XSKFOA2zxKfa00MsNBvwrQGPQm2uPQ@mail.gmail.com>
In-Reply-To: <CAPM=9ty0+ouf+rQWhM=9XSKFOA2zxKfa00MsNBvwrQGPQm2uPQ@mail.gmail.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Thu, 27 Oct 2022 11:26:41 +0800
Message-ID: <CAJedcCwxioxr+4TBTdrEjAZh97J3oroSHSgax+bxSNRXCBvkRg@mail.gmail.com>
Subject: Re: [PATCH v3] drm/i915/gvt: fix double free bug in split_2MB_gtt_entry
To:     Dave Airlie <airlied@gmail.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>, gregkh@linuxfoundation.org,
        alex000young@gmail.com, security@kernel.org, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, 1002992920@qq.com
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
=A5=E5=91=A8=E5=9B=9B 08:01=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, 7 Oct 2022 at 11:38, Zheng Wang <zyytlz.wz@163.com> wrote:
> >
> > If intel_gvt_dma_map_guest_page failed, it will call
> > ppgtt_invalidate_spt, which will finally free the spt.
> > But the caller does not notice that, it will free spt again in error pa=
th.
> >
> > Fix this by spliting invalidate and free in ppgtt_invalidate_spt.
> > Only free spt when in good case.
> >
> > Reported-by: Zheng Wang <hackerzheng666@gmail.com>
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
>
> Has this landed in a tree yet, since it's a possible CVE, might be
> good to merge it somewhere.
>
> Dave.
>

Hi Dave,

This patched hasn't been merged yet. Could you please help with this?

Best Regards,
Zheng Wang
