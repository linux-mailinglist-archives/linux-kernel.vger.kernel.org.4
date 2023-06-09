Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFD9729365
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240777AbjFIIir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240625AbjFIIig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:38:36 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E69E30D8;
        Fri,  9 Jun 2023 01:38:11 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1q7Xca-0004UX-00; Fri, 09 Jun 2023 10:37:24 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id A3D56C02EE; Fri,  9 Jun 2023 10:36:29 +0200 (CEST)
Date:   Fri, 9 Jun 2023 10:36:29 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, corbet@lwn.net
Subject: Re: [PATCH 1/3] MIPS: Rework smt cmdline parameters
Message-ID: <20230609083629.GA9563@alpha.franken.de>
References: <20230521223124.21911-1-jiaxun.yang@flygoat.com>
 <20230521223124.21911-2-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230521223124.21911-2-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2023 at 11:31:22PM +0100, Jiaxun Yang wrote:
> Provide a generic smt parameters interface aligned with s390
> to allow users to limit smt usage and threads per core.
> 
> It replaced previous undocumented "nothreads" parameter for
> smp-cps which is ambiguous and does not cover smp-mt.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  .../admin-guide/kernel-parameters.txt          |  4 ++--
>  arch/mips/include/asm/smp.h                    |  2 ++
>  arch/mips/kernel/smp-cps.c                     | 13 +------------
>  arch/mips/kernel/smp-mt.c                      |  3 ++-
>  arch/mips/kernel/smp.c                         | 18 ++++++++++++++++++
>  5 files changed, 25 insertions(+), 15 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
