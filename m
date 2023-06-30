Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56D1744537
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 01:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjF3XZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 19:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjF3XZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 19:25:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68EB3C35
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 16:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6n50wQmLLr/60tciF4ygjN3NjqhKMnhsbNe3akrHYr0=; b=RbPQtWwyTZDhpllF4fVtZPAdKV
        YDElJWzQiQzBKnfbcEc0wa2KJ8CCd7cgo0In0cHXNfa+1Y4h+YzEKiyO7KMHm6O5ZsTeBoniLWbV7
        0T0xNZugJ/50090az6Hz7y/Y2Zt5tyKk9NJmRnCKHJLyAux68EmziW5T2hkvTfn30/NG9mXaahQp6
        yRk8EcYVQ0HE4ItX6xJsEiwyjSUZtY9fHZAsSuVlc28xoZfz4O2I2Kcompx2nPn+FeCWGT3xOCX6P
        kG1w6cYvN4b1aW3QPDiaVNyg4N5GgfoFg3RMu8XXxRDqnaVB6xaWjMI7wXM+xzZN2o8/fxeHTegRu
        0PspFapA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qFNUI-004lEU-1M;
        Fri, 30 Jun 2023 23:25:14 +0000
Date:   Fri, 30 Jun 2023 16:25:14 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kthread: Rename user_mode_thread() to kmuser_thread()
Message-ID: <ZJ9kWqhRCWkLcYyv@bombadil.infradead.org>
References: <20230615121016.3731983-1-chenhuacai@loongson.cn>
 <CAAhV-H49AyrG-sH2SXLNg_cX-Wv8vS4Qno_2N4v6ccGGciv-+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H49AyrG-sH2SXLNg_cX-Wv8vS4Qno_2N4v6ccGGciv-+A@mail.gmail.com>
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

On Sun, Jun 25, 2023 at 04:55:33PM +0800, Huacai Chen wrote:
> Friendly ping?

You want to cc the folks who Nacked your patch. Until then, this
probably can't go further.

  Luis
