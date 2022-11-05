Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F27B61D768
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 06:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiKEFW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 01:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiKEFWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 01:22:21 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073E92DABD;
        Fri,  4 Nov 2022 22:22:21 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id t5so6221368vsh.8;
        Fri, 04 Nov 2022 22:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+Qwi7rg0U58xPzwrvVIHIbh9K9ZeQWsTgY/TnvreHo=;
        b=Sq5w5AOO+/cUqQI+Zf5kQA/q+AmvqJoO1HjfWcMNeKhnbdkze0yEchcfHp48clyxn6
         ITgTCwiSyJ1QgY4wqZeqTrMZ0fXAZLO0bMt2nyK6Z06/dbjBdJQ40j76bXpTpPfF8RPw
         icL6bjNgQxTGQDUGI9ZNv6SHXNnm4EOswLUdVBxh0jAeIVCnUNgpm1QTAq48pG9IEEAl
         z+bpQQfzgUi/c+nSAwRaBNaWocgTt/5ehVBqbA3twkEMfS7H+MsdyszU/nidwAjFuXqj
         ZSvzsYjg7p22Wdi4MPNYebnn0KGQSrNS0sn3NAd1bYlbmIcMZFD1rdEwOqxnowOoczFE
         SbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+Qwi7rg0U58xPzwrvVIHIbh9K9ZeQWsTgY/TnvreHo=;
        b=F9n+VflwZF2wZUotH4J7FgF7Yx5lHaMENI5U4C3T1Jw1dnS7ExfcPimIa9PWl2eCtE
         ObgwtYiEp2p7mzkAa0umP7AZDi9LNJ38htg7ikAW1oexhUFUHZXg9rGqDeFx182/3Mv3
         7dAAcLiPi73/c1k54evTUVbdkvgbubRNM1Hb0jV4W+2t+/dn/gZghqLrsrZ27rnKando
         HgFu9pO0uApdmqBOVRNbGYU4DT6ZU0eO43ByvNub1tI5mFsSgNvVnfDYh7hyVTXP3oQh
         pL2ENsAWJNm+Li5loQspBNW4o7Bx47urQ2D3KDNZBqOxPZOlh5i6Md1yT4Yxmc2hvELL
         Jmrg==
X-Gm-Message-State: ACrzQf1tSoP3K1BQq2NdVOcM8tIDNtydTH6dC3yhszxIwJR6gBTSITb7
        lPKQ2hXceFRyxgihoNOEfHhCmgUaBmSKvy+2hck=
X-Google-Smtp-Source: AMsMyM6k1R3PQAK+eTqvhmY7GfQuqGyFz7rP0EaidF9pksUxVlIKsCpK4DdapRarjUZNcj5ut/W/sr+2D7NeBx9UzmY=
X-Received: by 2002:a67:6dc5:0:b0:3aa:415:c0ca with SMTP id
 i188-20020a676dc5000000b003aa0415c0camr21628683vsc.3.1667625739997; Fri, 04
 Nov 2022 22:22:19 -0700 (PDT)
MIME-Version: 1.0
References: <20221102053058.21021-1-lijiaming3@xiaomi.corp-partner.google.com>
 <Y2IuhG8nBJj0F1fd@infradead.org> <c5948336-19fc-ddd3-bc34-aba2d1b02302@gmail.com>
 <878ea44b-9616-e7d0-661c-82eae23b1b35@bjorling.me>
In-Reply-To: <878ea44b-9616-e7d0-661c-82eae23b1b35@bjorling.me>
From:   Juhyung Park <qkrwngud825@gmail.com>
Date:   Sat, 5 Nov 2022 14:22:08 +0900
Message-ID: <CAD14+f3i04piBzjuh9DFnbtbMmgqDLh3JMnTYM5ej=23rxjdtg@mail.gmail.com>
Subject: Re: [RESEND PATCH 0/4] Implement File-Based optimization functionality
To:     =?UTF-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jiaming Li <lijiaming3@xiaomi.corp-partner.google.com>,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijiaming3 <lijiaming3@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 4, 2022 at 9:37 PM Matias Bj=C3=B8rling <m@bjorling.me> wrote:
>
> On 03/11/2022 07.11, Juhyung Park wrote:
> ...
> >
> > Is the idea really an utter madness? Majority of regular files that may
> > be of interest from the perspective of UFS aren't reflinked or
> > snapshotted (let alone the lack of support from ext4 or f2fs).
> >
> > Device-side fragmentation is a real issue [1] and it makes more than
> > enough sense to defrag LBAs of interests to improve performance. This
> > was long overdue, unless the block interface itself changes somehow.
>
> There are ongoing work with UFS to extend the block interface with
> zones. This approach eliminates the mismatch between the device-side
> mapping and host-side mapping and lets the host and device collaborate
> on the data placement.
>
> >
> > The question is how to implement it correctly without creating a mess
> > with mismatched/outdated LBAs as you've mentioned, preferably through
> > file-system's integration: If the LBAs in questions are indeed
> > reflinked, how do we handle it?, If the LBAs are moved/invalidated from
> > defrag or GC, how do we make sure that UFS is up-to-date?, etc.
>
> If using zoned UFS, the file-system can use zones for LBA tracking,
> eliminating the mismatched/outdated LBA issue. f2fs already supports
> this approach (works today with SMR HDDs and ZNS SSDs). It'll extend to
> UFS when zone support is added/implemented.
>

More reasons to have this functionality integrated with the
file-system instead of allowing users to specify random LBA ranges.
