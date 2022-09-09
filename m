Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050FC5B3A69
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiIIOJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbiIIOHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:07:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555D125D5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 07:07:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97907B824F4
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 14:07:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B021C433C1;
        Fri,  9 Sep 2022 14:07:08 +0000 (UTC)
Date:   Fri, 9 Sep 2022 15:07:04 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     George Pee <georgepee@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        "Kirill A. Shutemov" <kirill.shtuemov@linux.intel.com>,
        Austin Kim <austindh.kim@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Report support for optional ARMv8.2 half-precision
 floating point extension
Message-ID: <YxtIiBvAGs2vAl1P@arm.com>
References: <20220901141307.2361752-1-georgepee@gmail.com>
 <f765da5c-d484-adf2-e1bb-77011780dc0b@arm.com>
 <CAKj0CMv1EY5YCeQ4G6PnGP=XfELJkkN5BaN8W1TGe0fOTXfJBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKj0CMv1EY5YCeQ4G6PnGP=XfELJkkN5BaN8W1TGe0fOTXfJBw@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 08:34:26AM -0500, George Pee wrote:
> Adding the hwcap was part of the diagnosis process-- I added it just
> to make sure that the cpu in question supported the optional
> extension.
> It seems like it could be useful to be able to check for support in
> /proc/cpuinfo.

Ah, I wasn't aware that the feature doesn't work on arm32. I don't think
it makes sense to expose a hwcap bit to user in this case.

-- 
Catalin
