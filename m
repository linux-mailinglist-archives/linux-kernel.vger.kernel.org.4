Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A82F665586
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 08:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbjAKHzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 02:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjAKHzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 02:55:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB09B81
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 23:55:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B799B81B32
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 07:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBB1C433EF;
        Wed, 11 Jan 2023 07:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673423713;
        bh=QAUoBiQrPpx40h8K8YX98H2l7tJgXLzCYCWBOQxuwHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S/sbZEoIIfe8OMX+uc9bAsmau3zzvJkl4U7TOUCJn/TcPHLMKksGgy0SAS3aV45Nw
         e3opo/DfNFnCE++RrAhGXZRLfcc9RyiDNQfPK6nqIo+GhZiI28+HkqKoCgOxHN7WQE
         OvMIJbtQuF5Tk4BdpXzKO6dA6pLwZr4/WRMnOxqWHegFesYAroBSHNkmI3i/V2WDzy
         X5YjdTE26vf7pTT9ipqVwfoSADKj8yYOPLPJCg3p5VwOL+qSZ6xEQF/HphE0qbIpgf
         Dm3Bz/rMwQBlCq1G4YyZV21IyCGnnUXTkd3sO/jBasHJ1UpGzGmguN+6idog4yfFqM
         l5BG4J8hmdFzA==
Date:   Wed, 11 Jan 2023 13:25:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-phy@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] phy: ti: fix Kconfig warning and operator precedence
Message-ID: <Y75rXeTK7m/uAE9I@matsya>
References: <20230110062529.22668-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110062529.22668-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-01-23, 22:25, Randy Dunlap wrote:
> Fix Kconfig depends operator precedence to prevent a Kconfig warning:
> 
> WARNING: unmet direct dependencies detected for MUX_MMIO
>   Depends on [n]: MULTIPLEXER [=m] && OF [=n]
>   Selected by [m]:
>   - PHY_AM654_SERDES [=m] && (OF [=n] && ARCH_K3 || COMPILE_TEST [=y]) && COMMON_CLK [=y]
> 
> Fixes: 71e2f5c5c224 ("phy: ti: Add a new SERDES driver for TI's AM654x SoC")
> Fixes: 091876cc355d ("phy: ti: j721e-wiz: Add support for WIZ module present in TI J721E SoC")
> 

Please no blank line here

Applied, after fixing this

-- 
~Vinod
