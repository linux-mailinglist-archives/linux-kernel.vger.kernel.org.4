Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9202A5E73E4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 08:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiIWGVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 02:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiIWGVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 02:21:45 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521F7126B55
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 23:21:45 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id A492F201342;
        Fri, 23 Sep 2022 06:21:42 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 845ED80607; Thu, 22 Sep 2022 16:24:41 +0200 (CEST)
Date:   Thu, 22 Sep 2022 16:24:41 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia: remove VR41XX PCMCIA driver
Message-ID: <YyxwKdqf+FUHxksB@owl.dominikbrodowski.net>
References: <20220715135431.134844-1-tsbogend@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715135431.134844-1-tsbogend@alpha.franken.de>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fri, Jul 15, 2022 at 03:54:31PM +0200 schrieb Thomas Bogendoerfer:
> Commit d3164e2f3b0a ("MIPS: Remove VR41xx support") removed support
> for MIPS VR41xx platform, so remove exclusive drivers for this
> platform, too.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Applied to the pcmcia tree.

Thanks,
	Dominik
