Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531766C9CBF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbjC0HuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbjC0HuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:50:00 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF001BF2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:49:58 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2D8171EC06D7;
        Mon, 27 Mar 2023 09:49:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1679903397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6TAc2PmDLCbssysBwDJCT7u3Tv4D2oy1/BJvRSp/Xjg=;
        b=AYcNtwmlwCMwg5zL7ZWs2yKrdTyYSf+g3vfKX8lb73Utbsfo5h2ngZEMqHufT8EHajJ90F
        EEiQrw3UOZHvWp0Jp6EBQOEwNswdiFUlULKUDhQEeJSRgWZNh+YMl/daYMjRJxdEYhr5ic
        mdVjZmNMFVcJBAgXry4yiJjMD6vo8Es=
Date:   Mon, 27 Mar 2023 09:49:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     David R <david@unsolicited.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Panic starting 6.2.x and later 6.1.x kernels
Message-ID: <20230327074952.GAZCFKoDOiJUdtse2H@fat_crate.local>
References: <943d2445-84df-d939-f578-5d8240d342cc@unsolicited.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <943d2445-84df-d939-f578-5d8240d342cc@unsolicited.net>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 07:43:52AM +0100, David R wrote:
> I have the following panic after upgrading my kernel. Working version is
> 6.1.10, so something has happened after that. 6.2.x kernels crash in the
> same way. Attached config.

Please send dmesg from 6.1.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
