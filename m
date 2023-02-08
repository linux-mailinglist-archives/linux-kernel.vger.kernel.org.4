Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D84668E6DA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 04:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjBHDyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 22:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjBHDyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 22:54:31 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D31F3EC58
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 19:54:30 -0800 (PST)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3183s7LV029345;
        Wed, 8 Feb 2023 04:54:07 +0100
Date:   Wed, 8 Feb 2023 04:54:07 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     chris.chenfeiyang@gmail.com
Cc:     paulmck@kernel.org, Feiyang Chen <chenfeiyang@loongson.cn>,
        chenhuacai@kernel.org, jiaxun.yang@flygoat.com, arnd@arndb.de,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] selftests/nolibc: Add support for LoongArch
Message-ID: <Y+Mc37ACt0PUBRAQ@1wt.eu>
References: <cover.1675734681.git.chenfeiyang@loongson.cn>
 <2d77fe4e895847ae1ea09088dcfa411ce2f57f5f.1675734681.git.chenfeiyang@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d77fe4e895847ae1ea09088dcfa411ce2f57f5f.1675734681.git.chenfeiyang@loongson.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 10:09:42AM +0800, chris.chenfeiyang@gmail.com wrote:
> From: Feiyang Chen <chenfeiyang@loongson.cn>
> 
> Add support for LoongArch (64 bit) to nolibc selftest.

Please also mention in this one that the makefile was reindented with
no other change than adding entries for loongarch, this will save
those reading this patch later from checking that the rest was not
changed.

Thanks!
Willy
