Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92AE16C04D3
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 21:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjCSUcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 16:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjCSUcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 16:32:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D611D939
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 13:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t6/r69L34vrSHro7UHhqaRgF/9ggcCTfKHU/uJKhI8Y=; b=o1vfuGhY1QY1h3VMG/z2xg9wey
        /h8IFnNe1LEfw97qw1YXGZxUPuVvLDEdwmiA5iWelJ/clnKl++QH2nlAY8WXde3O1szjZBSyAVL0f
        nAx5/6Nmt21YzsOOZb+xEDxDld15MfSA6weUB/Hg7QqdO1ZFK6VzLYKjEqVvwoBytm4tRic/SAfGu
        cXOx24V3a41YcGn3YWNDcviVQzeUDk+XoDtO7ohqaJkz1gcwm9GfGiZIR4SMpT2da0F6s+tTjdb2g
        AY7AwfHscfz9QkkAVTpRGaRycttUeOjWSvR4Bx65i9Ho9Q1j8DX/dRadU/qJ3vB+sTsEC8sXgtavS
        wSxDfCGw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pdzha-007OSE-1I;
        Sun, 19 Mar 2023 20:32:26 +0000
Date:   Sun, 19 Mar 2023 13:32:26 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     haoxin <xhao@linux.alibaba.com>
Cc:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, linux-mm@kvack.org, p.raghav@samsung.com,
        da.gomez@samsung.com, a.manzanares@samsung.com, dave@stgolabs.net,
        yosryahmed@google.com, keescook@chromium.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] tmpfs: add the option to disable swap
Message-ID: <ZBdxWsrYfPgBG6NX@bombadil.infradead.org>
References: <20230309230545.2930737-1-mcgrof@kernel.org>
 <e1de614b-25e1-5c21-933a-880412ac7421@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1de614b-25e1-5c21-933a-880412ac7421@linux.alibaba.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 10:46:28AM +0800, haoxin wrote:
> All these series looks good to me and i do some test on my virtual machine
> it works well.
> 
> so please add Tested-by: Xin Hao <xhao@linux.alibaba.com> .
> 
> just one question, if tmpfs pagecache occupies a large amount of memory, how
> can we ensure successful memory reclamation in case of memory shortage?

If you're disabling swap then you know the only thing you can do is
unmount if you want to help the VM, otherwise the pressure is just
greater for the VM.

  Luis
