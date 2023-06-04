Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCE7721559
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 09:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjFDHnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 03:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjFDHnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 03:43:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF49B3;
        Sun,  4 Jun 2023 00:43:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0090660AE3;
        Sun,  4 Jun 2023 07:43:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7AFBC433D2;
        Sun,  4 Jun 2023 07:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685864623;
        bh=nIKvPGvj3JKyqmVRDqzwgCrRbQJXgFGqXqW31E0bgMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AJfNzePihv3KR4lAgZLvP67gWAOcih7tMTSKWq5JOQp1VfTIcZ64+eod8ZGntao58
         ZYWzgJVHtJYo2uvCjBOc5LzX/1MPVYaDH+wZLngLWPAcXw466KPqhUDa2mWmJ9emXe
         cK9vCWC7UqY7KtXLIIMxdNnGLdsTXlcG4wjalYl0=
Date:   Sun, 4 Jun 2023 09:43:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Avichal Rakesh <arakesh@google.com>
Cc:     dan.scally@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        thinh.nguyen@synopsys.com, etalvala@google.com,
        jchowdhary@google.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v3] usb: gadget: uvc: clean up comments and styling in
 video_pump
Message-ID: <2023060434-reveler-twice-d92e@gregkh>
References: <20230602211602.3b7rfa252wliiszp@synopsys.com>
 <20230602220455.313801-1-arakesh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602220455.313801-1-arakesh@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 03:04:55PM -0700, Avichal Rakesh wrote:
> This patch elaborates on some of the edge cases handled by
> video_pump around setting no_interrupt flag, and brings the
> code style in line with rest of the file.

When you say "and" that usually means it should be a separate patch.

But I really don't see what coding style changes you made here, what was
it?

I can't see any logical changes made here, am I missing them?  Or is
this all just a style-cleanup patch?

thanks,

greg k-h
