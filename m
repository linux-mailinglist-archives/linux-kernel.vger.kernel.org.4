Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE33E6B40A1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 14:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjCJNj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 08:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjCJNjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 08:39:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D682210A289;
        Fri, 10 Mar 2023 05:39:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B95DB82291;
        Fri, 10 Mar 2023 13:39:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E6FC433EF;
        Fri, 10 Mar 2023 13:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678455582;
        bh=17WGgV5qjA36utnoDz1JZD0VFDmk+mTs/Dui4hmyOT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dTqmKtl60ZBo4KNfis5dOBbqPXnBGBZU+76jgZ8vzPAW3qdv6PyAmeGo9Wr49Ge2s
         D/q12gJS/zJLXkLjQZ9DegqGDb2HqkUhvYt1krwbyHt9bNgdTL1oLA8aGxcjmH9oK2
         QJesUO9b/dzwrvq5Gm1mMOzu9hkzmo9BCSEzIc2lq8gc1eUDhdDLOtCQ1tAtHX+YOq
         9g0w8Y/PW9RLrLlBnDRI8morsmnaWBbcEdULV8t/zqzMVOTbugMu7KtkJTxp4FRqtI
         zrQMwebj/7zWiPQ0Z0TXndtSurcWOyX0ngSx903dbbgnbfvFIGcyQebPnUEyQzMDIs
         7ZjWY//AlfT+Q==
Date:   Fri, 10 Mar 2023 14:39:39 +0100
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] spi: mpc5xxx-psc: Remove goto to the unexisted
 label
Message-ID: <ZAszG1wEZJGWdBPz@intel.intel>
References: <20230310111544.57342-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310111544.57342-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Fri, Mar 10, 2023 at 01:15:44PM +0200, Andy Shevchenko wrote:
> The previous cleanup patch had lost one of its parts in a crack,
> Finish the cleanup by removing the leftovers.

I wonder how this was compiling.

> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 9e21720a4958 ("spi: mpc5xxx-psc: use devm_clk_get_enabled() for core clock")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Andi
