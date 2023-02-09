Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5601468FE05
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 04:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjBIDgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 22:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjBIDgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 22:36:09 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD668A8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 19:36:07 -0800 (PST)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3193ZbDm007908;
        Thu, 9 Feb 2023 04:35:37 +0100
Date:   Thu, 9 Feb 2023 04:35:37 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     chris.chenfeiyang@gmail.com
Cc:     paulmck@kernel.org, Feiyang Chen <chenfeiyang@loongson.cn>,
        arnd@arndb.de, chenhuacai@kernel.org, jiaxun.yang@flygoat.com,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Add LoongArch support to nolibc
Message-ID: <Y+RqCcaS6pJ+W9+N@1wt.eu>
References: <cover.1675907639.git.chenfeiyang@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1675907639.git.chenfeiyang@loongson.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Feiyang,

On Thu, Feb 09, 2023 at 11:24:11AM +0800, chris.chenfeiyang@gmail.com wrote:
> From: Feiyang Chen <chenfeiyang@loongson.cn>
> 
> Add statx() and make stat() rely on statx() if necessary.
> Add support for LoongArch (32 and 64 bit) to nolibc.
> It was tested on LoongArch64 only.
> 
> The latest QEMU support full-system emulation of a LoongArch64
> machine, but for the moment we need to specify the firmware manually.
> https://github.com/loongson/Firmware/tree/main/LoongArchVirtMachine
> 
> QEMU_ARGS_loongarch  = -M virt -bios edk2-loongarch64-code.fd ...
> 
> v2:
> - Mention that statx() will also benefit other architectures.
> - Make stat() rely on statx() when available.
> - Put the whitespace changes into one commit.
> 
> v3:
> - Add #if defined(__NR_statx) guard.
> - Keep the check for statx() from the first version.
> - Mention that we may use statx() everywhere in the future.
> - struct statx stat -> struct statx statx.

I'm personally fine with this one. I'll give it a try with all supported
archs to make sure we don't have any unexpected side effect, and unless
anyone has any other comment, we'll queue this series.

Thank you!
Willy
