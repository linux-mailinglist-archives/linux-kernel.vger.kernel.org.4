Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D18E5F858C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 16:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJHOJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 10:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiJHOJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 10:09:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954D6491FA
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 07:09:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 735E860B2D
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 14:09:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF22C433C1;
        Sat,  8 Oct 2022 14:09:01 +0000 (UTC)
Date:   Sat, 8 Oct 2022 10:09:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Conor.Dooley@microchip.com, peterz@infradead.org,
        jpoimboe@kernel.org, jbaron@akamai.com, ajones@ventanamicro.com,
        ardb@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, nathan@kernel.org, ndesaulniers@google.com,
        trix@redhat.com, samuel@sholland.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] riscv: jump_label: mark arguments as const to satisfy
 asm constraints
Message-ID: <20221008100902.0bbbc1cc@rorschach.local.home>
In-Reply-To: <20221008100748.1078fb3f@rorschach.local.home>
References: <20221006064028.548-1-jszhang@kernel.org>
        <20221006124144.abaz74g7nxrb5hxj@kamzik>
        <4c8fa16a-8463-ee32-7307-0383fa94403c@microchip.com>
        <Y0GBO77e2Lu/khkI@xhacker>
        <20221008100748.1078fb3f@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Oct 2022 10:07:48 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Link: https://lore.kernel.org/linux-riscv/20220922060958.44203-1-samuel@sholland.org/
> Link: https://lore.kernel.org/all/20210212094059.5f8d05e8@gandalf.local.home/
> 

This way tools can be used to map commits to links relevant to them.
They key off the "Link:" tag keyword.

-- Steve

