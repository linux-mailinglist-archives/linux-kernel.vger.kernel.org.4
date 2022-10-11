Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D68A5FACF6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 08:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiJKGjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 02:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJKGjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 02:39:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1A32701
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 23:39:45 -0700 (PDT)
Date:   Tue, 11 Oct 2022 08:39:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1665470383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P4M4Z6LkJSe0TOSPA/aXD3SiGURucta9d1btRgw14nQ=;
        b=WqnO8a2iocJygWu9MwVg8zU/oBEGB0e2XuXW3iBPOSOHGXqJE8jurgQIx5PhsFgPbrkK5w
        tX1G+i4E+Xg+nIO2a1umKt+uwR2+Axf/Uiu828dlZ6hN8v+LKIYbZuJFenemsfQ3i3Ouky
        AF9X45989kGbSEyBBhw/2qZVKBwfRBnppMyzoVXYs1gcv0FdSn+3bqaaaf9qh9YWAjVFsq
        u6114sZLINwL4WR/zgPgV2CTUlg559UafbrMKZ1Bz2wXkiXPuYzrFxvugF35qWyDD67Gna
        CEfJ9zlG+D75AoHLAvi2bReUIaexm+AblC+v6ewtOEzkozvfkyxEiAjZYS/SzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1665470383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P4M4Z6LkJSe0TOSPA/aXD3SiGURucta9d1btRgw14nQ=;
        b=Kpm3EwYaaijD862rWj7eJFFD9z6kC09bbCvBPkuUGZPwajeRBcuWrGqpoGAriXHoFphUvU
        ogFZ3tizHoEHd6Dg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: mm/memcontrol.c:600:9: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <Y0UPrZmNB2BC4CQi@linutronix.de>
References: <202210111422.hzXZGNdz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202210111422.hzXZGNdz-lkp@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-11 14:35:04 [+0800], kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   60bb8154d1d77042a5d43d335a68fdb202302cbe
> commit: e575d401583273a7ac5dfb27520e41c821e81816 mm/memcontrol: Replace the PREEMPT_RT conditionals
> date:   3 weeks ago
> config: loongarch-randconfig-s032-20221010
> compiler: loongarch64-linux-gcc (GCC) 12.1.0
> reproduce:

Did this change with the commit change or was it the case before? IMHO
the whole file isn't sparse clean.

Sebastian
