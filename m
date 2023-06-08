Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0CD728676
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 19:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbjFHRkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 13:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjFHRkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 13:40:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668A72115
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 10:39:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF45364FDF
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 17:39:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3B9C433EF;
        Thu,  8 Jun 2023 17:39:56 +0000 (UTC)
Date:   Thu, 8 Jun 2023 18:39:53 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>, kvmarm@lists.linux.dev,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 00/14] arm64/sysreg: Convert TRBE registers to
 automatic generation
Message-ID: <ZIISaXnrhDtauY2G@arm.com>
References: <20230602062552.565992-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602062552.565992-1-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On Fri, Jun 02, 2023 at 11:55:38AM +0530, Anshuman Khandual wrote:
> Changes in V2:
> 
> - Renamed each individual TRBE register fields as per auto-gen tools
> - Converted each individual TRBE registers as per auto-gen tools
> - Added new register fields as per DDI0601 2023-03

Mark had some comments about using Enum for some bitfields. While not
essential, it would be nice to have those fixed. It's probably easier to
do an incremental patch fixing those, so please post one (or repost the
whole series, whatever is easier for you).

Thanks.

-- 
Catalin
