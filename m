Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096B463EA35
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 08:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiLAHRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 02:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiLAHRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 02:17:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADE6748F8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 23:17:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E96C61E9D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 07:17:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C057C433D6;
        Thu,  1 Dec 2022 07:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669879022;
        bh=PrKICSTOmcGLJ/BB8PIwEFn3Kaj9T9r7mow24i0Oobc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uumwS904EL9Ut/AAu8n9jhiOls2CBOTQvzu0hnyR0cAO31xm3hko/NVKsSTCM+Qri
         /Cc7twuom20PD8xOUAMwqDjUJGqt67MUVMreuW3Hv+brc1Apb2ZoV02s3+yNx2dBTV
         eZcDodtfONz09kpKl53F8c3xo3pIfOCrGNp1ZRyPW71u4vR73glY6l9x9E9HIbVC6a
         aZ2uVcLyHmXEbSRavTbvnNOzcxpuv0xgmLiijI1GQFgkRZiU961EyCJDE16uoXvJBg
         RBJrU272tG/Ud36bgqhF3QpE3rJfr3MGFp/9YEWHTeI1FOZLuIuPd6jwgTy4IeiSOZ
         iLDe2XM1cr7gQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p0dog-0007lW-Sz; Thu, 01 Dec 2022 08:17:07 +0100
Date:   Thu, 1 Dec 2022 08:17:06 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Jack Schofield <schofija@oregonstate.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] staging: greybus: Cleanups in loopback_test
Message-ID: <Y4hU8oC7H5h6G2ZI@hovoldconsulting.com>
References: <cover.1669872193.git.schofija@oregonstate.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1669872193.git.schofija@oregonstate.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 09:38:49PM -0800, Jack Schofield wrote:
> Correct issues found by checkpatch.
> 
> Jack Schofield (3):
>   staging: greybus: loopback_test: Add blank line after declaration.

Nit: no need for a full stop in the commit summary.

>   staging: greybus: loopback_test: Remove void function return statement
>   staging: greybus: loopback_test: Remove extra blank lines
> 
>  drivers/staging/greybus/tools/loopback_test.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)

Other than that, all of these look good to me:

Reviewed-by: Johan Hovold <johan@kernel.org>

Johan
