Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710486E6DFD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbjDRVWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjDRVWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:22:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39D340C7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x6fCn8oqf/tgVfxgVBRtXPhUANRwOD7q1Hdq1ZO04nw=; b=Bn1i01YpTw/8vTDES1+DSjRPEe
        ApA+UTK7vJj7tF5v36DiK+X+VKABThsuH0+6Xk+G50iWXwXaPGehDNS1m5nWMvZytFqDjWRfgozcE
        rm3ecbYU1KeAZCHYSEKKgXLeMejHGNCvMidPhj9mPh8j/v8B2KPugWm3OW7TzxTLKZqvQ4VzDaQay
        rPprotDvQAeii5e9XnOLLl++IAe8mB4B3C/U4RwqKCyV4EcZO6Z0qsjZArKYDEDdp7FxKkqZVvQYn
        Ka+Pk7gIMeRzVcCyDddjPhsrqGTUbnTF5ElEmLx1+9vKBMub01uEytpS4R/vCEy+msdQopfbsfzwh
        Vj11yMdw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1posm0-003N0h-3B;
        Tue, 18 Apr 2023 21:22:01 +0000
Date:   Tue, 18 Apr 2023 14:22:00 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        linux-mm@kvack.org, p.raghav@samsung.com, da.gomez@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] shmem: add support to ignore swap
Message-ID: <ZD8J+I6uCqfp31sv@bombadil.infradead.org>
References: <20230309230545.2930737-1-mcgrof@kernel.org>
 <20230309230545.2930737-7-mcgrof@kernel.org>
 <79eae9fe-7818-a65c-89c6-138b55d609a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79eae9fe-7818-a65c-89c6-138b55d609a@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 10:50:59PM -0700, Hugh Dickins wrote:
> You'll be sending a manpage update to Alejandro in due course, I think.

Sure thing! Just need a git tree. I can send the updates as we reach
a consensus on where to store / share huge page shmem updates.

  Luis
