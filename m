Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1E16322E1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiKUM5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiKUM5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:57:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8925127CEA;
        Mon, 21 Nov 2022 04:56:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47E4CB80E12;
        Mon, 21 Nov 2022 12:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B5FC433C1;
        Mon, 21 Nov 2022 12:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669035416;
        bh=/G6QKes/X8UyFcxejxGfT2znJ4EkFvp7x9NzpUwCL0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b7/c4kml36zi5c1SlvD3v6p2w3OtKCh9j0+AFc09vIB8gY5E1+gyjqIRphozvecf6
         QsB3K5awQYT8bNLVsNg3ZVya6ewZlO4xNTGwRSd3KWN163eugs4n6qis8OEUV1pDAu
         IbRVBMODgve3wt0I6rkjWBOer5O4zLDCtnyNekw9r6gOSoJCBQ9feejQG2xfxfnh2W
         YsCACerx9pN4lLw5qxz+33encEJ/s6NgGKPtk6OfCC7a5HN4RUFtWiFQcjJZc8VnnN
         yIlbLrCDxfWgtLJlkx2oobiu1rWYoWMBzniZR4BNNQ8rNozA1AzLZGt+GoDbCcKOPn
         H87OGo/YaPgCQ==
Date:   Mon, 21 Nov 2022 12:56:50 +0000
From:   Will Deacon <will@kernel.org>
To:     John Garry <john.g.garry@oracle.com>
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, irogers@google.com
Subject: Re: [PATCH] MAINTAINERS: Update John Garry's email address for arm64
 perf tooling
Message-ID: <20221121125648.GB7097@willie-the-truck>
References: <20221121113018.1899426-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121113018.1899426-1-john.g.garry@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 11:30:18AM +0000, John Garry wrote:
> Update my address.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 379945f82a64..2ec6a2709225 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16191,7 +16191,7 @@ F:	tools/lib/perf/
>  F:	tools/perf/
>  
>  PERFORMANCE EVENTS TOOLING ARM64
> -R:	John Garry <john.garry@huawei.com>
> +R:	John Garry <john.g.garry@oracle.com>
>  R:	Will Deacon <will@kernel.org>
>  R:	James Clark <james.clark@arm.com>
>  R:	Mike Leach <mike.leach@linaro.org>

Thanks for doing this, John, and good luck with your new role!

Acked-by: Will Deacon <will@kernel.org>

Will
