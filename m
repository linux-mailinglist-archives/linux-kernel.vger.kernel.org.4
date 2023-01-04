Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E128765CE9C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 09:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbjADIqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 03:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbjADIpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:45:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FC81A823
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 00:45:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3CA9B81440
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 08:45:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CDEC433F0;
        Wed,  4 Jan 2023 08:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672821919;
        bh=8hocUuWWasyP5ATR86FZNJuCPicwzIw4Gka8O+mb7pE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dCIxLhZ4PiGyU2kJ/PeK5kv5dlDHHaPzno4Dz/MQo4zoV+23V+XtqPUAF/BYgiHA/
         PNpGWAZ9efU1rDOeDCaqPsAufN9yl4EX0GJOqyLEBnJaS34L7tgrWgBB1FLCJhCqOh
         Dx3+MJjI2zN7psei+eI4O4xbQZ62hg5ZgTDhDnbdUpv2pM80ZxQhHloIH6wVDnR1lh
         tU+FsyWHsnbNyBLG7Kw9ZQfa8CGNUHGzm8ocTcgbMBbvjv4aNZ1+ABqwfly1HYFOq/
         usc1HKBFnrss/18hITpoCMePHkQrAhGai27X/jJ1d6EkdOLRCYQ3kLE/NRlfCWP5Ti
         BIrMQJzUSrh2w==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Xim <chenguokai17@mails.ucas.ac.cn>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "liaochang (A)" <liaochang1@huawei.com>
Subject: Re: [PATCH v5 0/9] Add OPTPROBES feature on RISCV
In-Reply-To: <A8ECFC78-661F-405D-8222-F8D1A73EA732@mails.ucas.ac.cn>
References: <20221224114315.850130-1-chenguokai17@mails.ucas.ac.cn>
 <87y1qkvmpf.fsf@all.your.base.are.belong.to.us>
 <A8ECFC78-661F-405D-8222-F8D1A73EA732@mails.ucas.ac.cn>
Date:   Wed, 04 Jan 2023 09:45:17 +0100
Message-ID: <87edsasn6q.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xim <chenguokai17@mails.ucas.ac.cn> writes:

> Hi Bj=C3=B6rn,
>
> Thanks for your detailed review! I made tests mainly on some syscall/time=
r related
> functions where these issues were not triggered. I will check all these i=
ssues as well
> as comments that spread per-patch before a new version of patch set is se=
nt.
>
> FYI the 32b support is included and was tested with mostly same cases as =
the 64b one.

Ok! Thank you for clarifying!


Bj=C3=B6rn
