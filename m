Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E361E678F92
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 06:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjAXFET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 00:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjAXFES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 00:04:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E3610277;
        Mon, 23 Jan 2023 21:04:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 987A7B80F92;
        Tue, 24 Jan 2023 05:04:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA63C433D2;
        Tue, 24 Jan 2023 05:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674536654;
        bh=y9PeVHW940WZgm+ZZc1WLhATQcEvdJJoP74t7XDFf8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ve8eoV/1wHI8cOfS/TdOmE9vY6aETXULCu2rVMwAvnq/8AR+d+zbTkz4ae5xFuLB7
         EWFAT7Wa/aBkVpJ433UcQUP4CPATvHHe1yJRPKtrjaFcnXmHKmfco2piCjeiw/HSjj
         JgFXmG+pRGyKv8pfhvPEX3CERyj1/gfL9zbE9zNg=
Date:   Tue, 24 Jan 2023 06:04:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     corbet@lwn.net, javier.gonz@samsung.com, linux-doc@vger.kernel.org,
        a.manzanares@samsung.com, dave@stgolabs.net,
        darren@os.amperecomputing.com, catalin.marinas@arm.com,
        ndesaulniers@google.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof.c@samsung.com>
Subject: Re: [PATCH v2] docs: embargoed-hardware-issues: add embargoed HW
 contact for Samsung
Message-ID: <Y89myzKiwJEeRNiW@kroah.com>
References: <20230123215255.381312-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230123215255.381312-1-mcgrof@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 01:52:55PM -0800, Luis Chamberlain wrote:
> After discussions internally at the company, Javier has been volunteered
> and is willing to be the embargoed hardware contact for Samsung.

If I didn't know better, that sounds like you are signing someone else
up for something :(

> Cc: Javier González <javier.gonz@samsung.com>

I would need an ack from Javier here, and will discuss this with them
off-list as to the responsibilities here to ensure that you all know
what this actually entails.

Jon, can you not take this, once I get it straightened out I'll take
this through my tree.

thanks,

greg k-h
