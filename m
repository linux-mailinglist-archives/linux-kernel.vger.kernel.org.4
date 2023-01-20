Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC73674E1A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 08:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjATH1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 02:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjATH1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 02:27:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E874DBF2;
        Thu, 19 Jan 2023 23:27:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 360A9B8206F;
        Fri, 20 Jan 2023 07:27:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E22C433D2;
        Fri, 20 Jan 2023 07:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674199639;
        bh=Mlc2J2YgHPqi71yIqxS6cS+b60mmMYMPWTVv7dhv0DQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=095QucUQ5kikj0eGT5vw6sPZQ3rV9acWiNpUZqcpndvJQDdwMx/f6tuhIszKWxzaV
         bbUVW7Peu/uqAK2L/XWtaG6HfBnPNVggrANZxKk3T3eS1PmFo5Dqr9oTrfoZ6KRhKX
         Edd09CwofQscK2zWTx3quuRBwe+rnH9gv8n54Z5A=
Date:   Fri, 20 Jan 2023 08:27:17 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/9] pktcdvd: Get rid of pkt_seq_show() forward
 declaration
Message-ID: <Y8pCVWoJ4et91THU@kroah.com>
References: <20230119220809.5518-1-andriy.shevchenko@linux.intel.com>
 <20230119220809.5518-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119220809.5518-4-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 12:08:04AM +0200, Andy Shevchenko wrote:
> The code can be neater without forward declarations.
> Get rid of pkt_seq_show() forward declaration. This
> will also allow futher cleanups to be cleaner.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
