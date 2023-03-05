Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3C96AB1ED
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 20:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjCETrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 14:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjCETru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 14:47:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF7011E85
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 11:47:48 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678045666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zPM3qYsnkHfVfSNugo+2iBRQXDGqlC/LOv4FLGuQneY=;
        b=d5j1GhvO4uo4OpycFbDJxXWsar708dWcp6fGZHeXVWXJP4dZQ+CG8+6vcdtN95EcB3kiaB
        pmMBusiHA76Xh3fBE5DqDjlvDSkuSdK5z767IEK0P9PryZ+43HCmTWdR5J4+mkDJ0kZyoX
        sYGswe/CGvsAcSsfBt/hoDT84fNK/QRw5XO//VVnXL5im5Fwh9jR2ukWR6ukS0eoU84LZB
        elmdI7mg2UrcrXcUymShbVYzRWHMrlKGBrTUDe3REocJVw9AkJtP+96Qe0UqBFiKyTcpKA
        wOkFC4S3xigc5OKgDj+jHGKO3JWSBkvVk/Pw0l77wj/rmUXrdOI41IpbsQ2Igg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678045666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zPM3qYsnkHfVfSNugo+2iBRQXDGqlC/LOv4FLGuQneY=;
        b=wpOPFF9vvvqzqvp+h0TreugLdCjoJqgL11KVq0lley7W18Y6cb1RaPMlUcZ4rGSN4bKhHP
        O6WHghLP4iVlNPAg==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [GIT pull] irq/urgent for v6.3-rc1
In-Reply-To: <CAHk-=whr2KrDkMnQ5pKKxn8nCD718ExKAmPE3TLxkWnjtj6OvA@mail.gmail.com>
References: <167800644191.309766.5757985605946414576.tglx@xen13>
 <CAHk-=whr2KrDkMnQ5pKKxn8nCD718ExKAmPE3TLxkWnjtj6OvA@mail.gmail.com>
Date:   Sun, 05 Mar 2023 20:47:45 +0100
Message-ID: <87ttyzhtem.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05 2023 at 11:24, Linus Torvalds wrote:
> On Sun, Mar 5, 2023 at 12:55=E2=80=AFAM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> ...
>>  kernel/irq/msi.c            |   28 +++++++++++++++++++++++-----
>>  kernel/irq/msi.c            |    9 ++++++---
>>  8 files changed, 44 insertions(+), 15 deletions(-)
>
> Funky diffstat you have there, with the same file done twice. I get
> (and would have expected)

Hrm.

>  ...
>  kernel/irq/msi.c            | 37 +++++++++++++++++++++++++++++--------
>  7 files changed, 44 insertions(+), 15 deletions(-)
>
> instead.

That looks more correct. Let me see what my script zoo managed to get
wrong this time.

Thanks,

        tglx
