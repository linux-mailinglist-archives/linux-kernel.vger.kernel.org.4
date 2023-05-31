Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16F0717605
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 07:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjEaFMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 01:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjEaFMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 01:12:05 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 285B593;
        Tue, 30 May 2023 22:12:04 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 704198164;
        Wed, 31 May 2023 05:12:03 +0000 (UTC)
Date:   Wed, 31 May 2023 08:12:02 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Bo Liu <liubo03@inspur.com>
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: ti-sysc: convert sysfs sprintf to sysfs_emit
Message-ID: <20230531051202.GS14287@atomide.com>
References: <20230504085522.2635-1-liubo03@inspur.com>
 <20230531050458.GR14287@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531050458.GR14287@atomide.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [230531 05:05]:
> * Bo Liu <liubo03@inspur.com> [230504 11:55]:
> > Follow the advice of the Documentation/filesystems/sysfs.rst
> > and show() should only use sysfs_emit() or sysfs_emit_at()
> > when formatting the value to be returned to user space.
> 
> Thanks applying into omap-for-v6.5/ti-sysc.

Oh but these are currently only used with dev_dbg() on init.
There's no specific sysfs support needed so far. So dropping this
patch.

Regards,

Tony
