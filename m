Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455286A6E54
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjCAOZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCAOZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:25:19 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F3C59E9
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 06:25:17 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id o15so51983756edr.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 06:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9jpccmvW5G9g4h1RhMOIsgBhwoVCmPKcSKS3NuKK1yc=;
        b=oohamuWzQpzUCq8y8ob2nKKrFXQbCBbzXUDJdfz7rlzHyfe5+Q18VB7h5FqIXIxO0j
         Z9bTVQE3ul7E9zLr5O3fSkY74VzIs2OPnVDRl2bCCN2kbP57eR0AFJGWStiEemTUrh/u
         S932ryELzTbvHXXRHge5aI3Ib55PAufrnqKP/BCu5znxKW6P2kgfVUles4LIVO9ic8NW
         zcTzLlxTpzVxE3jkULvJT583r1WxVXQvuDazPBvOkU5hc3oxKHaLdk0X6z8DOfHnrHL8
         e2VH9iEezVCFAHzvcGKaSn29PpZet2ZhC8r6YcioW+znWG4HoVLZA+BepNAgsJ9tgW3L
         OStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9jpccmvW5G9g4h1RhMOIsgBhwoVCmPKcSKS3NuKK1yc=;
        b=WuQm0gtuHn7jsnsoBaD1qJ0YlMGyaJtkEe4dAoCD+ab8vanOJJdT26CLTK1U9EctQQ
         LQqFrT7a083iAicsYViTMHQiKHQbujAo1qb7FB86Y6Y1ia+U8UfpwAN7X0qExtE1DGwr
         nmO7Z02V4c9oqtwmb3EjSZP83ctHIQUPVYXnBsV2lqsIKXHrYGI0yVuwKapCvD4Z1/hK
         tv6bdDGooj8vqAMl0GTzJu19H/i4d1fDMwqAsr1yn5OXqgmgAf9FX30yezuFUhlORPXv
         UxgzHykd5nzHBdAUiFP7aXMrCZyC2ezJMvw6YNRl4hsUWdzSaqpsrn6cTWNrDwHfmdSB
         ZxbA==
X-Gm-Message-State: AO0yUKWlBjnpAa9j1f7TIBA+v+ymI3jG8p+0yiwQyyAfxhFiH/d0YvQX
        FtBtHkdvC3X2AnEVquPdAFfcjxP+v1XQhBjEhZ0mRw==
X-Google-Smtp-Source: AK7set+p0Th1ekwsNtNnZd2IB9CHawyC93hZKmPGoH6BMgQtNR23lB/HFgYWfMEyjmQbVNIVQ5/IQq0JaMjDIXDiF4w=
X-Received: by 2002:a17:907:d30d:b0:8f3:9ee9:f1e2 with SMTP id
 vg13-20020a170907d30d00b008f39ee9f1e2mr5546438ejc.5.1677680716414; Wed, 01
 Mar 2023 06:25:16 -0800 (PST)
MIME-Version: 1.0
References: <20230223-virtio-net-kvmtool-v2-1-8ec93511e67f@rivosinc.com>
 <CACGkMEu8JtT9_0YcbmfWCGxbrB1GHnesnspFYgaeVrb2x3o3oQ@mail.gmail.com> <1677578798.8465447-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1677578798.8465447-1-xuanzhuo@linux.alibaba.com>
From:   Rob Bradford <rbradford@rivosinc.com>
Date:   Wed, 1 Mar 2023 14:25:05 +0000
Message-ID: <CABPZdxussbbsqtrKZ8bbxSJYU4xuJphTJtvxV=jHHHWs7cO6+A@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-net: Fix probe of virtio-net on kvmtool
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2023 at 10:08, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> On Fri, 24 Feb 2023 11:11:37 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Fri, Feb 24, 2023 at 3:38 AM Rob Bradford via B4 Relay
> > <devnull+rbradford.rivosinc.com@kernel.org> wrote:
> > >
> > > From: Rob Bradford <rbradford@rivosinc.com>
> > >
> > > kvmtool does not support the VIRTIO_NET_F_CTRL_GUEST_OFFLOADS feature
> > > but does advertise the VIRTIO_NET_F_GUEST_TSO{4,6} features. Check that
> > > the VIRTIO_NET_F_CTRL_GUEST_OFFLOADS feature is present before setting
> > > the NETIF_F_GRO_HW feature bit as otherwise
>
> Here are settings for dev->features and dev->hw_features.
>
>
> > > an attempt will be made to
> > > program the virtio-net device using the ctrl queue which will fail.
> > >
> > > This resolves the following error when running on kvmtool:
>
> Can you talk about it in detail what it did?

In the updated v3 version of the patch I went into a lot more detail,
particularly of why the bit was being cleared and triggering the
control queue reprogramming. Based on that I also adjusted the
conditional check.

Cheers,

Rob
