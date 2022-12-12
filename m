Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E393D64ABC7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 00:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbiLLXtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 18:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbiLLXsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 18:48:20 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC60618340;
        Mon, 12 Dec 2022 15:47:56 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id F049720004;
        Mon, 12 Dec 2022 23:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670888872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AGtfQjLte51Ra95Qt9Ehjvv/TTAURJR9cA+jiCJJjQ4=;
        b=FQwtGQrGgppgLpq+FqN66h5uX22r9cdtUbvS76mGD+Jk2ExGYGJoMO5HyHgSrnlWNeHrfc
        QIqaf/DVK1W9WyzupvdrKAxaFv/oQt5yI5zYA4ajAX/Qb2lXkc7gm82LEqUDuMZUz+Xolg
        Fykt4m6cxNnK8/YswKltcfOTNRa1uYCmt5DZDwSGxRy6+BBx2lYzya9FpShqAbfEMRP52y
        RXHO+7nRHLzakgUkO62w4XMHGHypVUCBPrrpR4eTYa1zugMDnvMEVxDTK8Dyouep6hkONf
        G9uMYtDADmgzLYHlbt/wemjxlz2XYtvdYmTGEJRwpy4k3UoN0HTuHTCrshwcUw==
Date:   Tue, 13 Dec 2022 00:47:51 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.de>
Cc:     Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH] rtc: isl12026: drop obsolete dependency on COMPILE_TEST
Message-ID: <167088884105.311452.6765041987681570335.b4-ty@bootlin.com>
References: <20221124154359.039be06c@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124154359.039be06c@endymion.delvare>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Nov 2022 15:43:59 +0100, Jean Delvare wrote:
> Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
> is possible to test-build any driver which depends on OF on any
> architecture by explicitly selecting OF. Therefore depending on
> COMPILE_TEST as an alternative is no longer needed.
> 
> It is actually better to always build such drivers with OF enabled,
> so that the test builds are closer to how each driver will actually be
> built on its intended target. Building them without OF may not test
> much as the compiler will optimize out potentially large parts of the
> code. In the worst case, this could even pop false positive warnings.
> Dropping COMPILE_TEST here improves the quality of our testing and
> avoids wasting time on non-existent issues.
> 
> [...]

Applied, thanks!

[1/1] rtc: isl12026: drop obsolete dependency on COMPILE_TEST
      commit: 28e93c214af6af9f5a8d5d4d0de0e36668708a4b

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
