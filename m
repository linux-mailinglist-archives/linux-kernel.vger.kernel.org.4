Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD14716574
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjE3O7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjE3O7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:59:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCCEE8;
        Tue, 30 May 2023 07:58:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 69F9B1FD85;
        Tue, 30 May 2023 14:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685458716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mjKvAvjKsZhLJii7xKzLSID8lAv9ypsI5HB8i6Xu65o=;
        b=r5txExcrgzRyz58Xo6N9WkUxbsrwqPfxe1aST4QlTmXsD1zC5tSAGwH51buBaNkd/XnUml
        sk8N1gz/7447FO8Zy+ezqwb7uQFTcyzWTnq0g46skj8CciQwezQrmdQKPaOAlF2ahwjvqS
        Sjh1HI7v8HKc5dYuY8sHpV94zZUVS98=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1DBDD2C141;
        Tue, 30 May 2023 14:58:36 +0000 (UTC)
Date:   Tue, 30 May 2023 16:58:34 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        sparclinux@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 08/10] watchdog/buddy: Simplify the dependency for
 HARDLOCKUP_DETECTOR_PREFER_BUDDY
Message-ID: <ZHYPGgmoGNpMPd0v@alley>
References: <20230527014153.2793931-1-dianders@chromium.org>
 <20230526184139.8.I49d5b483336b65b8acb1e5066548a05260caf809@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526184139.8.I49d5b483336b65b8acb1e5066548a05260caf809@changeid>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-05-26 18:41:38, Douglas Anderson wrote:
> The dependency for HARDLOCKUP_DETECTOR_PREFER_BUDDY was more
> complicated than it needed to be. If the "perf" detector is available
> and we have SMP then we have a choice, so enable the config based on
> just those two config items.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
