Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B385FCB74
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 21:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiJLT0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 15:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJLT0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 15:26:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A339BFF24A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 12:26:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A5D3615AA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 19:26:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DE6C433C1;
        Wed, 12 Oct 2022 19:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1665602773;
        bh=iSRGfQJnsRYIVrHraP74VVurOvIrTvQynI5zhoB5rJ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hm1vrENpJsnlcYTiKC66wOkHIJHSwmlfPgHeG7DtKOFtqw5C9BiqAtAJxPXIp9gg3
         Ba4XqLSH9CtzuxyUVOjtJ2oYlPIoEOmV40YqR791cLN3rVVlsZv7VWgmUNfyiIN16x
         hhzjVuuozK0UL/3VoTVH0S3tq4ca//By3wFw52XU=
Date:   Wed, 12 Oct 2022 12:26:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kernel test robot <yujie.liu@intel.com>
Cc:     Jiebin Sun <jiebin.sun@intel.com>, <lkp@lists.01.org>,
        <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
        "Tim Chen" <tim.c.chen@linux.intel.com>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        Alexey Gladkov <legion@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Dennis Zhou" <dennis@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Shakeel Butt <shakeelb@google.com>, Tejun Heo <tj@kernel.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <zhengjun.xing@linux.intel.com>, <fengwei.yin@intel.com>
Subject: Re: [ipc/msg] 72d1e61108: stress-ng.msg.ops_per_sec 262.8%
 improvement
Message-Id: <20221012122611.3ab2deb4a00c92ef45be5872@linux-foundation.org>
In-Reply-To: <202210121629.587ff60f-yujie.liu@intel.com>
References: <202210121629.587ff60f-yujie.liu@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Oct 2022 16:30:20 +0800 kernel test robot <yujie.liu@intel.com> wrote:

> FYI, we noticed a 262.8% improvement of stress-ng.msg.ops_per_sec due to commit:
> 
> commit: 72d1e611082eda18689106a0c192f2827072713c ("ipc/msg: mitigate the lock contention with percpu counter")

Awesome, thanks!
