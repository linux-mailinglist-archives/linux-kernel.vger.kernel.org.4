Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CC6708905
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 22:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjERUG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 16:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjERUG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 16:06:26 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18661E45
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 13:06:25 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-338458a9304so5345ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 13:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684440384; x=1687032384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Llsf50DWFe4C4yt4CKwUU/mwMek/qP2tT3Isdnsoo/E=;
        b=QwXTDrd3SJelts9j+j9UzmNzyhPBsTx2joXvlvK05j+iopzqy0g9YNVbc9veuyqgMD
         qbVeu5jMKxAi/rsKorhn3MvqigHN/I2VcoIXJs5aNs4l+vYlCjbftWTkCxz7vRmY57ES
         1DdYCsLvRAD6/IsVfHo1cS5qvxvdOAIzxkwihEHTLui58+fkSG3dN/p7n7LUdVsT0xpD
         /b2xfk43CpN5V1eIN8EpmA9KcBJE6or8NOBuz7fm/BdSvFOSxA5YnnQlVwI10hCaoyRO
         FTcRnrMxDZBg/ZDevgMwGxAglwWPl/9PBkJ4wGXsPxt8iq20b6C8i1ONFvL8SjRuScx4
         6zEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684440384; x=1687032384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Llsf50DWFe4C4yt4CKwUU/mwMek/qP2tT3Isdnsoo/E=;
        b=BhSi+B+sbkxP1Ue3xmOnN/KY+6iyNgFnU4jB+ic2lbsWkWr2Bumybx3BVnNNQZBZXB
         TDa3mYybrohVyVia9+B3K2XWkYzyakwMsyKjIyjmqQn28zOy+nsCiEzy0/xdJl4wcZkG
         2olIH9hh8RvFlGXRGzlqFCjO9NBxXC6VMVU8foXsq1OYZFtnfeDPu+WqUDJvZmsmFO+e
         WROAtL2vvc+KXePw4lgXemprfDXBdDjX5gVdiRRscvv+tQAcmsjgERtbgiqYr8TntqNe
         NANP3OfWYwxzXGmxo8IpWdqcXhSDV92SBX4elPdjilAJn3umUu/KY1OIaM8ff7JOj3/i
         KK8Q==
X-Gm-Message-State: AC+VfDxnT5e0Flm6zdzLnRhFG2D1xsQqvZQgy2F54yHshO/NHspXKBQF
        bNoHom3uvhl0wpVELqxjJ9Ce7soOoHB7QWAt5iCp1A==
X-Google-Smtp-Source: ACHHUZ7TnKSs1H8nCSexD5mn0PX6Pbdp7GYAtzTugz6CaARe7amjq9yGFwtzRQzLMzOtQyHpMHkr74j3WGyUaTolUEQ=
X-Received: by 2002:a05:6e02:12cc:b0:335:f8e9:2791 with SMTP id
 i12-20020a056e0212cc00b00335f8e92791mr26729ilm.18.1684440384333; Thu, 18 May
 2023 13:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230512235755.1589034-1-pcc@google.com> <20230512235755.1589034-2-pcc@google.com>
 <7471013e-4afb-e445-5985-2441155fc82c@redhat.com> <ZGJtJobLrBg3PtHm@arm.com>
 <ZGLC0T32sgVkG5kX@google.com> <851940cd-64f1-9e59-3de9-b50701a99281@redhat.com>
 <CAMn1gO79e+v3ceNY0YfwrYTvU1monKWmTedXsYjtucmM7s=MVA@mail.gmail.com> <c9f1fc7c-62a2-4768-7992-52e34ec36d0f@redhat.com>
In-Reply-To: <c9f1fc7c-62a2-4768-7992-52e34ec36d0f@redhat.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Thu, 18 May 2023 13:06:13 -0700
Message-ID: <CAMn1gO7t0S7CmeU=59Lq10N0WvrKebM=W91W7sa+SQoG13Uppw@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: Move arch_do_swap_page() call to before swap_free()
To:     David Hildenbrand <david@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        =?UTF-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "surenb@google.com" <surenb@google.com>,
        =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        =?UTF-8?B?S3Vhbi1ZaW5nIExlZSAo5p2O5Yag56mOKQ==?= 
        <Kuan-Ying.Lee@mediatek.com>,
        =?UTF-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        vincenzo.frascino@arm.com,
        Alexandru Elisei <alexandru.elisei@arm.com>, will@kernel.org,
        eugenis@google.com, Steven Price <steven.price@arm.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 1:30=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> >> Would the idea be to fail swap_readpage() on the one that comes last,
> >> simply retrying to lookup the page?
> >
> > The idea would be that T2's arch_swap_readpage() could potentially not
> > find tags if it ran after swap_free(), so T2 would produce a page
> > without restored tags. But that wouldn't matter, because T1 reaching
> > swap_free() means that T2 will follow the goto at [1] after waiting
> > for T1 to unlock at [2], and T2's page will be discarded.
>
> Ah, right.
>
> >
> >> This might be a naive question, but how does MTE play along with share=
d
> >> anonymous pages?
> >
> > It should work fine. shmem_writepage() calls swap_writepage() which
> > calls arch_prepare_to_swap() to write the tags. And
> > shmem_swapin_folio() has a call to arch_swap_restore() to restore
> > them.
>
> Sorry, I meant actual anonymous memory pages, not shmem. Like, anonymous
> pages that are COW-shared due to fork() or KSM.
>
> How does MTE, in general, interact with that? Assume one process ends up
> modifying the tags ... and the page is COW-shared with a different
> process that should not observe these tag modifications.

Tag modifications cause write faults if the page is read-only, so for
COW shared pages we would end up copying the page in the usual way,
which on arm64 would copy the tags as well via the copy_highpage hook
(see arch/arm64/mm/copypage.c).

Peter
