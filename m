Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E8F638373
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 06:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiKYFZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 00:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKYFZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 00:25:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A1C2B623;
        Thu, 24 Nov 2022 21:25:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F6D8B82900;
        Fri, 25 Nov 2022 05:24:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2576C433C1;
        Fri, 25 Nov 2022 05:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1669353898;
        bh=92ZE+0jZ/3VIAbePthX8zFCKWwwtT5HDCwKLh/apn1I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mkF/rCa56Rop3mvKk2BR1pzZgPHTSdfczRX3ioQZOtbWHMlzSJ2Qp8AoNmuog1/wG
         Ab9DZg8Uu/ANOhYPV1OtX3Uh+cxXicwjB6CuBjWaqgrG9xkjRxDA9k0m4XELXGM/DZ
         R6T7gvVRC1Fohxv/pZhCSj43F6RyQvwAZoPoVEQ4=
Date:   Thu, 24 Nov 2022 21:24:57 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Juergen Gross <jgross@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "kernelci.org bot" <bot@kernelci.org>
Subject: Re: linux-next: build failure after merge of the mm-hotfixes tree
Message-Id: <20221124212457.06a9928d931d00ad98d7d454@linux-foundation.org>
In-Reply-To: <20221125121051.311beecd@canb.auug.org.au>
References: <20221125121051.311beecd@canb.auug.org.au>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Nov 2022 12:10:51 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> After merging the mm-hotfixes tree, today's linux-next build (arm
> allmodconfig) failed like this:
> 
> mm/vmscan.c:4090:9: error: implicit declaration of function ‘pmd_young’; did you mean ‘pte_young’? [-Werror=implicit-function-declaration]
> 
> Caused by commit
> 
>   3f85e711d5af ("mm: introduce arch_has_hw_nonleaf_pmd_young()")
> 
> This error was found by the kernel.ci bot and so is still int today's
> tree.

Thanks.  Did that tree include "mm: add dummy pmd_young() for
architectures not having it"?
