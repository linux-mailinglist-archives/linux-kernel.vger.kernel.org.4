Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0075F35BE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 20:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJCSmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 14:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJCSl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 14:41:59 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEE433A3F;
        Mon,  3 Oct 2022 11:41:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 69F77CE0B4F;
        Mon,  3 Oct 2022 18:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A977C433C1;
        Mon,  3 Oct 2022 18:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1664822511;
        bh=iv49xGC0NzD9ClJKm6B6FSdwct9N2gigG6wLOtM0xFs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NvhqHntCIoiXJSQQJC5xZWYxMKTkT3tECa6/bOJlGQ6JGwGaO++IAoyHbTEP04IUA
         eR0U90lYJDSNz0xUbUO42ptYz9Qk5RkZaE4oqPARqeygEHyGAFVLa6XaCRL2Psn+ZG
         OH/PEq5vVlcaGQO/qS5WzsvXzaYo9l/PPSFqctZs=
Date:   Mon, 3 Oct 2022 11:41:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH v4 0/2] kexec, panic: Making crash_kexec() NMI safe
Message-Id: <20221003114150.d4b34df6f56e8ebfec897688@linux-foundation.org>
In-Reply-To: <xhsmho7ut2gcs.mognet@vschneid.remote.csb>
References: <20220630223258.4144112-1-vschneid@redhat.com>
        <Yszgzwnk2Y+4ki58@MiWiFi-R3L-srv>
        <xhsmh35f68tz4.mognet@vschneid.remote.csb>
        <20220713103933.e7510daa1c1f6ccde32f4d42@linux-foundation.org>
        <xhsmho7ut2gcs.mognet@vschneid.remote.csb>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Oct 2022 14:20:51 +0100 Valentin Schneider <vschneid@redhat.com> wrote:

> > I'll stash it away for consideration after -rc1.
> 
> I've seen them in linux-next for a while, am I right in assuming they'll be
> part of a 6.1 PR?

yup.
