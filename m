Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDBA6796CF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 12:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbjAXLli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 06:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbjAXLlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 06:41:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC3F2884B;
        Tue, 24 Jan 2023 03:41:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FEF4B81178;
        Tue, 24 Jan 2023 11:41:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68F6C433EF;
        Tue, 24 Jan 2023 11:41:28 +0000 (UTC)
Date:   Tue, 24 Jan 2023 11:41:25 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <mricon@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Anton Blanchard <anton@linux.ibm.com>,
        Trilok Soni <tsoni@codeaurora.org>,
        James Morris <jamorris@linux.microsoft.com>, corbet@lwn.net,
        javier.gonz@samsung.com, linux-doc@vger.kernel.org,
        a.manzanares@samsung.com, dave@stgolabs.net,
        darren@os.amperecomputing.com, ndesaulniers@google.com,
        gost.dev@samsung.com, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof.c@samsung.com>
Subject: Re: [PATCH] docs: embargoed-hardware-issues: add embargoed HW
 contact for Samsung
Message-ID: <Y8/D5dOdyfuN9MbO@arm.com>
References: <20230123183926.249601-1-mcgrof@kernel.org>
 <Y87X6tFlevIebcc6@kroah.com>
 <Y88Ak8K5mD7tFItG@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y88Ak8K5mD7tFItG@bombadil.infradead.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 01:48:03PM -0800, Luis Chamberlain wrote:
> The below email addresses do not have any PGP
> key associated on the pgpkeys tree as of this day.
[...]
>   * Catalin Marinas <catalin.marinas@arm.com>

FWIW, this one does have a key: keys/6BD6B12D00C85EF1.asc

-- 
Catalin
