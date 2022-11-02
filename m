Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458CE615CDB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 08:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiKBHTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 03:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiKBHTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:19:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BC112D3F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 00:19:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39927617EF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 07:19:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC45FC433D6;
        Wed,  2 Nov 2022 07:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667373586;
        bh=DHrUljguS7CAH73syCaZFep+k5XKR1AQvaMZzp/XqzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c6sgbVUli2pqvWAxGBu9KggqvplAolJEFxL70QiMGKRkBJ1hgzzmC8FrO3A78Be1n
         000/FH5hvO1fr2Ea39a7FzIQOxdQ1UndpxEvULB940abYM5xbaf0yTv767e3QwiRxW
         IIhiPzOLaiouzfHPs5dbSrwoByk4KjRJs4+mNThU=
Date:   Wed, 2 Nov 2022 08:20:39 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH v3 0/2] staging: vt6655: some checkpatch fixes in the
 file rxtx.c
Message-ID: <Y2IaR0jqcaXq2UIA@kroah.com>
References: <cover.1667326000.git.tanjubrunostar0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1667326000.git.tanjubrunostar0@gmail.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 06:17:47PM +0000, Tanjuate Brunostar wrote:
> These fixes are focused on the function s_vFillRTSHead
> 
> v3: changed the function name from fill_rts_head to fill_rts_header as
> head is conventionally used in lists
> 
> v2: changed confusing changelog messages
> 
> Tanjuate Brunostar (2):
>   staging: vt6655: change the function name s_vFillRTSHead
>   staging: vt6655: Join some lines of code to avoid code lines ending in
>     (

Neither of these changes apply to my tree.  Please rebase against the
staging-next branch of the staging.git tree and resend a new version.

thanks,

greg k-h
