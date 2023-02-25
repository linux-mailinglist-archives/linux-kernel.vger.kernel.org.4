Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9706A2791
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 07:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjBYGgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 01:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBYGgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 01:36:20 -0500
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0539C58B47
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 22:36:17 -0800 (PST)
Received: from 8bytes.org (p5b006afb.dip0.t-ipconnect.de [91.0.106.251])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 7BF14223E49;
        Sat, 25 Feb 2023 07:36:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1677306976;
        bh=fINj1L/2N/K34tvWL4lOCuHLc/Au0lnD8D8hQA8Fx/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LpUIrqBQHyU0lARI5wVll2WEC9NpecnTYoxYpSHtmdXA0ausjLdaqrJcJUr5XIcav
         S4Mp4JLWYeXzRspDBvMYQ9pEikVSbl3l7p+jSlLpsTt5FdUSYKrohqW+BEpi6EMxFW
         OJTcq3WKx5UpApjpcXdiSRla1EJvo8flca4MiN2IU05fYXWCMO8BLn3lGe4oYgPiOV
         plJuG6t/VS14brV2yYSyUCJfNMXpFhxh8azE+jb6a/Ch/OmtPlQDLCcUY8tibPqWBa
         UKYR3qO3hiyS1WP2zn3CT4oHlagglUW/Trlxp+Qjepc0SzaFgWcp+P7lJRxENQZM4V
         8CHi4vrLxH4tw==
Date:   Sat, 25 Feb 2023 07:36:15 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Subject: Re: [git pull] IOMMU Updates for Linux v6.3
Message-ID: <Y/msX5PwHtvg3Jnv@8bytes.org>
References: <Y/SGAafMEGBn4fWy@8bytes.org>
 <CAHk-=wg71g9S0F8V-=97XQsaf6Edbxhfx-xS+x894w8sMZW+=w@mail.gmail.com>
 <Y/k1pGjjRIznCIu2@8bytes.org>
 <CAHk-=wg__gUh4gSVzCJqoCFMDiiQRDRuBaX=Yhra3=mxb7uSHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg__gUh4gSVzCJqoCFMDiiQRDRuBaX=Yhra3=mxb7uSHA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 03:14:21PM -0800, Linus Torvalds wrote:
> I suspect you mean rpmsg, not rdma. Because I just pulled the latter
> with no conflicts that I can tell.

Right[1], it was rpmsg and not rdma.

Regards,

	Joerg

[1] https://lore.kernel.org/all/20230127180226.783baf07@canb.auug.org.au/
