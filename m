Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035B36D04CF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 14:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjC3MfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 08:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjC3MfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 08:35:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939FB768A;
        Thu, 30 Mar 2023 05:35:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0E87B828A6;
        Thu, 30 Mar 2023 12:35:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2767C433EF;
        Thu, 30 Mar 2023 12:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680179705;
        bh=y+2gCE8/Cx3zjDhG3ki9NXZfOdNfIYHBd/3JGB6uaN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cp6aBBHtwV3qcj9lLsSRv592j/zDoiXol/xJlrebkCiGucvZc8NaB9TBp+GFWXotV
         0UXL9RsflBhWhnQEO3CtDQD8DuHlAOsN1OrlX16EX0EHLu45mnk4Zfo055ugiLtyVF
         AzbWZAMM7hb/1H/KKx3wGtFg0YS+0AoX2bvifG2tf1ABoIDsNs8uZkCNjlJ51j1PCh
         Kjm0JzTyzTuUkYKUKm+42O/N4vw8mqYTxRHdKNFWTTe+0ePBwfJUio+LyllE33HRCu
         eXohTgchQwJxLUGJlJetQJaard0E6ljRoIZ0WwHSwdkiMxu98BDq+Jrzu1DIfTqqiD
         omBwPg+jlYTtg==
Date:   Thu, 30 Mar 2023 13:35:00 +0100
From:   Lee Jones <lee@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     tony@atomide.com, nathan@kernel.org, ndesaulniers@google.com,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] mfd: twl-core: remove unused add_child and
 add_numbered_child functions
Message-ID: <20230330123500.GG434339@google.com>
References: <20230322115838.2569414-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230322115838.2569414-1-trix@redhat.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2023, Tom Rix wrote:

> clang with W=1 reports
> drivers/mfd/twl-core.c:654:30: error: unused function 'add_child' [-Werror,-Wunused-function]
> static inline struct device *add_child(unsigned mod_no, const char *name,
>                              ^
> add_numbered_child and its only caller add_child are not used, so remove them.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/mfd/twl-core.c | 65 ------------------------------------------
> 1 file changed, 65 deletions(-)

I chopped around the commit message a bit and:

Applied, thanks

--
Lee Jones [李琼斯]
