Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C456217CA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbiKHPOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbiKHPOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:14:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F266271C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 07:14:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB0F761620
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 15:14:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAAA1C433C1;
        Tue,  8 Nov 2022 15:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667920460;
        bh=UwGvGkskwck3rVTxWfnG1rG6Cix751U5AsQ6BVkQU8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L5N6NfxRtdPv3FT7DDBTuv8QquDWbDARFSRmIrIYeS6mksdEoDT7sT09fqlAXnA53
         aKjnyO7pfTQYBJzeQvnIJYL5KfTn5nHV0VSRS532/51r3fvb9b8eQj+h69Kzs/WH9h
         7tp+m3UJhtl/jgN52iqjYjSMm6gSSl6KjLPJdgag=
Date:   Tue, 8 Nov 2022 16:14:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] staging: rtl8192u: unused code cleanup
Message-ID: <Y2pySMu0kBgh3xFh@kroah.com>
References: <cover.1667398621.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1667398621.git.drv@mailo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 08:07:52PM +0530, Deepak R Varma wrote:
> Remove unnecessary or unused code.
> 
> Changes in v3:
>    Patch-1:
>       1. Already accepted and applied to the stating-testing tree. Hence not
>          included in this patch set now.
>    Patch-2:
>       1. The patch caused staging tree build to fail due to EXPORT_SYMBOL
>          conflict. Fixed the issue caused due to deletion of 2 macros.
>          Correction and re-submission asked by gregkh@linuxfoundation.org

But now this patch set looks like it is missing a patch, which confuses
everything.

Please just send a new patch, v4, 1/1, and all will be better.

thanks,

greg k-h
