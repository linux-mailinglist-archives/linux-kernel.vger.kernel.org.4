Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6704F74DD60
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 20:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjGJSdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 14:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjGJSdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 14:33:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D60AB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 11:33:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B7E461190
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 18:33:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D34C433C7;
        Mon, 10 Jul 2023 18:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689013981;
        bh=Pv/lcySJO1XElAFhqqvd4ig1BMThJRh3ymVy3haiYOc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T0sUysvFq2/EErWjQ6pNbUPnDRkgdK1x4lTcQnGR34CMyvsTAL5fmXjEXuaXW8fEM
         Huky67w2Io4ttbGXWldeTI28Y8CM0q2j+9L7XDh1sDbJ5FJNdZ1YCmvdiUKpMGQWNP
         T1BI98TSuIwjDBpaWp7j7V3CRPxI9nC/Q5MvbCbepE7kGkDR4UH7XHFDOZCFzSbdtu
         Xr5yMBxiE6bF+YVuh+IcJaIh1PuxhS4eYf5xDvK2ya8Vzd5F/wJyGqEdncZAasExqU
         +ySUD0BCGWeAgtVtiY1I4ULCD9881lfq/dANEISJiJpgHPxpmYePOwxBeOvkM7CNkS
         Fu3yC8vLMtwtQ==
Date:   Mon, 10 Jul 2023 11:33:00 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc:     davem@davemloft.net, Liam.Howlett@Oracle.com,
        akpm@linux-foundation.org, david@fries.net, edumazet@google.com,
        pabeni@redhat.com, zbr@ioremap.net, brauner@kernel.org,
        johannes@sipsolutions.net, ecree.xilinx@gmail.com, leon@kernel.org,
        keescook@chromium.org, socketcan@hartkopp.net, petrm@nvidia.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v9 0/6] Process connector bug fixes & enhancements
Message-ID: <20230710113300.10cba1b3@kernel.org>
In-Reply-To: <20230708023420.3931239-1-anjali.k.kulkarni@oracle.com>
References: <20230708023420.3931239-1-anjali.k.kulkarni@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  7 Jul 2023 19:34:14 -0700 Anjali Kulkarni wrote:
> Oracle DB is trying to solve a performance overhead problem it has been
> facing for the past 10 years and using this patch series, we can fix this
> issue.

You sent this when net-next was still closed, please read the first
few sections of: 

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

To be fair towards folks who follow the rules I need to discard this
from patchwork, please repost later this week.
-- 
pw-bot: defer
