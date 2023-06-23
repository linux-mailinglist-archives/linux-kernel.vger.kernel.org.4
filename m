Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA9373B3CB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 11:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjFWJjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 05:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjFWJjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 05:39:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B190BC;
        Fri, 23 Jun 2023 02:39:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3C9DE1F390;
        Fri, 23 Jun 2023 09:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687513150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=72hbvKej1iXoVScVh7pfvmvxDYNuBXrKbZOOD3LpqvM=;
        b=BUFHwB9m4AvYTKbcwVSYeNGVx2dHZGDCOEZu9463i+fjqB3WE9eQW4++gKxIhVi6CT2uk7
        CwagT2aVubyAVyXUaOe/RgErIU5juCWmuLHiQMM21ZN123QRrInYPoqRd+laE3gUNMyQ6r
        /VUJHHdszYjktsEstnSOh1FaEpPw8rA=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 09C982C141;
        Fri, 23 Jun 2023 09:39:09 +0000 (UTC)
Date:   Fri, 23 Jun 2023 11:39:06 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog/hardlockup: fix typo in config
 HARDLOCKUP_DETECTOR_PREFER_BUDDY
Message-ID: <ZJVoOm7NXG8OjQwV@alley>
References: <20230623040717.8645-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623040717.8645-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-06-23 06:07:17, Lukas Bulwahn wrote:
> Commit a5fcc2367e22 ("watchdog/hardlockup: make HAVE_NMI_WATCHDOG
> sparc64-specific") accidentially introduces a typo in one of the config
> dependencies of HARDLOCKUP_DETECTOR_PREFER_BUDDY.
> 
> Fix this accidental typo.
> 
> Fixes: a5fcc2367e22 ("watchdog/hardlockup: make HAVE_NMI_WATCHDOG sparc64-specific")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Thanks for catching this!

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
