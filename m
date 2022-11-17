Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70EE62E4B8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240685AbiKQSqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240121AbiKQSqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:46:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D32C79925
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 10:46:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0B1BB82177
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 18:46:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B4DC433D6;
        Thu, 17 Nov 2022 18:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668710761;
        bh=1B+BwC+vAlINE65t387MrQuVJvPq2RKRPkIoo8oLUb8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oo7oCp7G+dQTyW+q6rmqRNRDYtB3SKZgvFnizPPXJIwb623xtfrbEcRtmvjEIMR65
         3pzGJH326pMYiCg3liACw+Mu1LY7RUizeILqTFGhzJlU2WR9HSWkxaRE0X0+iKY3gQ
         H8ZnprRr3DqFv4FZVo2dXQqPK17RsCtja/F5bZe0=
Date:   Thu, 17 Nov 2022 19:45:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH v3] staging: vt6655: change the function name
 s_vFillRTSHead
Message-ID: <Y3aBW9QAB0nGiWBv@kroah.com>
References: <Y3KJBdUue5otWgOT@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3KJBdUue5otWgOT@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 06:29:25PM +0000, Tanjuate Brunostar wrote:
> Remove the use of Hungarian notation, which is not used in the Linux
> kernel. Reported by checkpatch
> Add indentation to the affected function to follow the Linux kernel
> coding style. This improves visibility
> 
> Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> ---
> v2: corrected confusing changlog message on this patch
> v3: removed unnecessary function prototype

Does not apply to my tree:

checking file drivers/staging/vt6655/rxtx.c
Hunk #2 FAILED at 85.
Hunk #3 succeeded at 567 (offset 12 lines).
Hunk #4 succeeded at 920 (offset 12 lines).
Hunk #5 succeeded at 939 (offset 12 lines).
Hunk #6 succeeded at 953 (offset 12 lines).
1 out of 6 hunks FAILED

