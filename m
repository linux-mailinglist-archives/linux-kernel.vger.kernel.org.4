Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B585F8589
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 16:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiJHOHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 10:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiJHOHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 10:07:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA88481C1
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 07:07:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3EFD7B807E6
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 14:07:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B9EC433C1;
        Sat,  8 Oct 2022 14:07:47 +0000 (UTC)
Date:   Sat, 8 Oct 2022 10:07:48 -0400
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
Message-ID: <20221008100748.1078fb3f@rorschach.local.home>
In-Reply-To: <Y0GBO77e2Lu/khkI@xhacker>
References: <20221006064028.548-1-jszhang@kernel.org>
        <20221006124144.abaz74g7nxrb5hxj@kamzik>
        <4c8fa16a-8463-ee32-7307-0383fa94403c@microchip.com>
        <Y0GBO77e2Lu/khkI@xhacker>
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

On Sat, 8 Oct 2022 21:55:07 +0800
Jisheng Zhang <jszhang@kernel.org> wrote:

> > >> [1]https://lore.kernel.org/linux-riscv/20220922060958.44203-1-samuel@sholland.org/
> > >> [2]https://lore.kernel.org/all/20210212094059.5f8d05e8@gandalf.local.home/  
> > 
> > 
> > Could you please make these normal link tags.?  
> 
> How to make these link tags? I just used the permalink in
> lore.kernel.org

Link: https://lore.kernel.org/linux-riscv/20220922060958.44203-1-samuel@sholland.org/
Link: https://lore.kernel.org/all/20210212094059.5f8d05e8@gandalf.local.home/

-- Steve
