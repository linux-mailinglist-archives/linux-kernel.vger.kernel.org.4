Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917BF6F481F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 18:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbjEBQPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 12:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbjEBQPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 12:15:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD061BD1
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 09:15:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08A6461B76
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 16:15:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA00C433D2;
        Tue,  2 May 2023 16:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683044133;
        bh=HwuNOnMrzsl9/avgqxb8tX0ESDxgIkc2SAgpMsW/7kk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hv+066vuQJxtLl9acRaO2V26ZrunMMKbtc9mE48blzjF6VECQvARON6VhYORisrlp
         Hw6oQ0049hsgahfx1tsZtSN+UXwO+XBku3KOrq3qb2ZZo7HIKZYI8mFzIIRYK303jE
         6UKu0+ao4uIceu//pIUNvTQkRJR1LKg1fyglaHIjhEpfK/BHRgQ0Uf44iO7rh+gD+z
         vTSMC9TJBGwWbOVhrBiB1cPSUHiJ/bCll3ZIV2rQmX2sNK+XSjiJXPnptt61ICfill
         FmGCXX5gKw34m7ezfvQQOeelX9c5H5JFq5MbbC0K/8VaTBarh9hL+fTRsvTWJqRFkT
         RLB1VcyB03lDw==
Date:   Tue, 2 May 2023 19:15:20 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Justin Forbes <jforbes@fedoraproject.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jmforbes@linuxtx.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Revert arm64: drop ranges in definition of
 ARCH_FORCE_MAX_ORDER
Message-ID: <ZFE3GDjmUWpMpmqu@kernel.org>
References: <20230428153646.823736-1-jforbes@fedoraproject.org>
 <ZEv76qfIiJcUvdql@arm.com>
 <ZE1pcwi95nPdlKzN@kernel.org>
 <CAFbkSA3SzjWZ_Q8XC6-_Kzc+jmUN6sG7vzbSD5X1bRvPUaJg3Q@mail.gmail.com>
 <ZE3mdYajdFnvl1by@kernel.org>
 <CAFbkSA0O-4YgNt-7KPhvx+vhvRNc38PO8E--GVAWKVgHK-_9Mw@mail.gmail.com>
 <ZFEZLZHBosQK9xaH@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFEZLZHBosQK9xaH@arm.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2023 at 03:07:41PM +0100, Catalin Marinas wrote:
> On Mon, May 01, 2023 at 04:24:38PM -0500, Justin Forbes wrote:
> 
> Regarding EXPERT, we could drop it and do like the other architectures
> but we'll have randconfig occasionally hitting weird values that won't
> build (like -1). Not sure EXPERT helps here.

AFAIU, randconfig does not randomize int values, it's probably random
people that do ;-)
 
> -- 
> Catalin

-- 
Sincerely yours,
Mike.
