Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0181F6E9C62
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 21:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjDTTSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 15:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbjDTTS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 15:18:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246813C27
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 12:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UXWoPplg6fSqmEcLz6yYPJoYhlqN+hzIgoCxz5ZOmqg=; b=T8FHT16rGh+NUyf/N4U3ERW0Ws
        SL+ClK2K1rEg3zs1+CaAo0QGdmjyGx2W1nsF7drejdegvpR8rFGILTde+NKVJSsDnVXKt+I/FUzVD
        WxaDoQ1a3zyDseOw5n1R5anZ2YdZobdc0cx3SvfG835AJ2AfjyU8SBFT+/ttIZuycOwOU/evADoDi
        B7IFwuRQxXdr2rGGXpVxcaabrj5n7TF2MiqjXWrz6pXI2BpPrLn5ZZMZHzC6Kd+V/QxiLHGGjDkui
        MvCeiI6grOr3CoWkU6+AdWEezxSNx6lGLoFTt/UNRRPl2/9XX81m12e4saDnaNo+KN2CtAk24C4yZ
        SyV1zHXQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ppZnF-008qZm-0u;
        Thu, 20 Apr 2023 19:18:09 +0000
Date:   Thu, 20 Apr 2023 12:18:09 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Hugh Dickins <hughd@google.com>, akpm@linux-foundation.org,
        willy@infradead.org, linux-mm@kvack.org, p.raghav@samsung.com,
        da.gomez@samsung.com, a.manzanares@samsung.com, dave@stgolabs.net,
        yosryahmed@google.com, keescook@chromium.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shmem: restrict noswap option to initial user namespace
Message-ID: <ZEGP8fLlSDFw52F1@bombadil.infradead.org>
References: <ZD8Q2SzVr3xDmCgY@bombadil.infradead.org>
 <20230420-faxen-advokat-40abb4c1a152@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420-faxen-advokat-40abb4c1a152@brauner>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 10:57:43AM +0200, Christian Brauner wrote:
> Prevent tmpfs instances mounted in an unprivileged namespaces from
> evading accounting of locked memory by using the "noswap" mount option.
> 
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Reported-by: Hugh Dickins <hughd@google.com>
> Link: https://lore.kernel.org/lkml/79eae9fe-7818-a65c-89c6-138b55d609a@google.com
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
