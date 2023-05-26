Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DCD71239D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 11:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243144AbjEZJ2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 05:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243117AbjEZJ23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 05:28:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F55198
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 02:28:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4D8D64E92
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:28:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32468C4339C;
        Fri, 26 May 2023 09:28:25 +0000 (UTC)
Date:   Fri, 26 May 2023 10:28:22 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Prathu Baronia <quic_pbaronia@quicinc.com>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/cpucaps: increase string width to properly format
 cpucaps.h
Message-ID: <ZHB7tvDa7d6T6SEq@arm.com>
References: <20230517100452.382174-1-quic_pbaronia@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517100452.382174-1-quic_pbaronia@quicinc.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 03:34:50PM +0530, Prathu Baronia wrote:
> The lengthiest capability is `WORKAROUND_TRBE_OVERWRITE_FILL_MODE` and
> its length is 35 characters so increase the width of left justified
> strings to 35 and adjust the tab space for `ARM64_NCAPS` accordingly.
> Now the generated cpucaps.h is properly formatted.
> 
> Signed-off-by: Prathu Baronia <quic_pbaronia@quicinc.com>

Why not make it larger, say 40, just in case.

-- 
Catalin
