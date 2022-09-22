Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38425E73E3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 08:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiIWGVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 02:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiIWGVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 02:21:45 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBD6126B50
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 23:21:44 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 9DB41201335;
        Fri, 23 Sep 2022 06:21:42 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 9B7F9807B4; Thu, 22 Sep 2022 16:39:42 +0200 (CEST)
Date:   Thu, 22 Sep 2022 16:39:42 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     tony@atomide.com, arnd@arndb.de, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] pcmcia: Removed unused variable control.
Message-ID: <YyxzrjA7hW6gdV5e@owl.dominikbrodowski.net>
References: <20220725012955.4928-1-jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725012955.4928-1-jrdr.linux@gmail.com>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mon, Jul 25, 2022 at 06:59:55AM +0530 schrieb Souptick Joarder:
> From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>
> 
> Kernel test robot throws below warning ->
> drivers/pcmcia/omap_cf.c:127:7: warning: variable 'control'
> set but not used [-Wunused-but-set-variable]
> 
> Removed unused variable control.

From a code-generation standpoint, this is obiously correct, and probably
the compiler removes that omap_readw() already. But, to be honest, I'm not
perfectly sure on what the device expects -- and whether it's required to
write back the control register (or parts of it). Does anyone still have the
hardware (or specs)? If not, I'm tempted to apply this patch on the basis
that the compiler might remove that omap_readw() anyway.

Thanks,
	Dominik
