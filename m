Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F275E73E5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 08:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiIWGV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 02:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiIWGVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 02:21:46 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5237F126B56
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 23:21:45 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id A72F820135C;
        Fri, 23 Sep 2022 06:21:42 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id EDD208052E; Thu, 22 Sep 2022 16:24:14 +0200 (CEST)
Date:   Thu, 22 Sep 2022 16:24:14 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] pcmcia: sa1100: Make sa11x0_drv_pcmcia_legacy_remove()
 return void
Message-ID: <YyxwDmhkqSRzJc2L@owl.dominikbrodowski.net>
References: <20220714214534.63517-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220714214534.63517-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, Jul 14, 2022 at 11:45:34PM +0200 schrieb Uwe Kleine-König:
> sa11x0_drv_pcmcia_legacy_remove() returns zero unconditionally. Letting it
> return void instead makes it easier to see in the caller that there is no
> error to handle.
> 
> This is a preparation for making platform remove callbacks return void.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Applied to the pcmcia tree.

Thanks,
	Dominik
