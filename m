Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A9460C613
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 10:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiJYIIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 04:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJYIIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 04:08:07 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BD22733D2;
        Tue, 25 Oct 2022 01:08:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A1DA180B0;
        Tue, 25 Oct 2022 07:58:48 +0000 (UTC)
Date:   Tue, 25 Oct 2022 11:08:03 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/10] ARM: omap2: assorted cleanups
Message-ID: <Y1eZY/WRA+WYeDhH@atomide.com>
References: <20221024153814.254652-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024153814.254652-1-arnd@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Arnd Bergmann <arnd@kernel.org> [221024 15:29]:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> While going through the removal of board files on some other
> platforms, I noticed a bit of outdated code on omap2+ that
> was left behind after the platform became DT only.
> 
> I can put this into the same cleanup tree as the omap1 patches,
> or you can merge these into your omap2 tree if there are likely
> conflicts with other patches.

Nice, looks good to me. A lot off stuff has moved to drivers
over the years.

As long as you have some immutable branch I can base patches on
as needed please just go head and apply them to your branch:

Acked-by: Tony Lindgren <tony@atomide.com>
