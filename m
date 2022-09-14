Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190675B861C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 12:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiINKU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 06:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiINKUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:20:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355391F62E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 03:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L9z2sWrZFpokxsnnYfIrgul/SSM9pIG5YuJ1FrDbZ6A=; b=XHE1YuJpF/XBiZvxZ6zm4SfEGS
        YpXr7MLDXWtv7gu6SrlhrLggtgXn3KpD3Sw3c+PVcN04VtEW+vnjPuwXBSO5sJr3laq6QA3l/VuzS
        UxdbSuAEt7WOQnR05Rj6dxHJ9I9bi/hCU3EpYPgLwtsvzte7PD9Pk8Z4+K6yVtkPQ2X5z/uCIoSlx
        CV4GRM4UEPk4mD81CZVvkfLsd3Mvs3on+TyU82JdhyfTeJlZQsoOwnxZVmKlQP/34DG8LgywKjHnv
        Dc4owYteBeksmTcI7b+m43mRgCcYLo/EMOvdhFubLYH56hN64n8e1jTMH7An3th6XETUSmMORJkEU
        lRYqn5cA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYPVV-0005SJ-T4; Wed, 14 Sep 2022 10:20:37 +0000
Date:   Wed, 14 Sep 2022 11:20:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Liam.Howlett@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] Maple Tree: Remove unused functions mte_set_full and
 mte_clear_full
Message-ID: <YyGq9enhR3W2/MFi@casper.infradead.org>
References: <20220914101829.82000-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914101829.82000-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 06:18:29PM +0800, Jiapeng Chong wrote:
> mte_set_full and mte_clear_full are defined in the maple_tree.c file,
> but not called elsewhere, so delete these unused function.
> 
> lib/maple_tree.c:330:20: warning: unused function 'mte_set_full'.
> lib/maple_tree.c:335:20: warning: unused function 'mte_clear_full'.

They're not used now, but they will be in a release or two.  They're
static inline functions; keeping them as part of the orthogonal API
costs nothing when they're not used.
