Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE19C5F973A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 05:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJJDq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 23:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiJJDq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 23:46:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCF63DF2C
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 20:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0RvipzyCwcwCdOuCNQFfFNwYNR5sm1Uw9mApVKX+WO8=; b=MZdqDSH4EfjD25C0qM1EJoYWQM
        lv2CiLKsO1p4L6g73V9Y45cuO3XMDkMQb5yD411PSkYm3rrEYCHwVI8BoOSw2fXSTnMcmbt/hv2oS
        rAsAxj3Kjjwk7JQCsAvQIA0G4FfdEkcJ9rqGqhJwRQXxzKFAWGuaKWCkN+V/+ptngFjKKBvfZVr3h
        2TF9u1g1h0xLA6UgYv1XEXhlA7kJKFSCL5yMOdEpaLOMMNfuediK/e0n+pglh0s6y5aNOiUiIuYTZ
        YU2bO10QT5yW9X4nS/JpXZt5DA72ZYA6X1ThO7RVvIgbk6nJPu/SSfUQ0ttovkPHt3apbVYCWwP5J
        kvSkcnzA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ohjkE-003v8q-5p; Mon, 10 Oct 2022 03:46:22 +0000
Date:   Mon, 10 Oct 2022 04:46:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     XU pengfei <xupengfei@nfschina.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm/mmap_lock: Remove unnecessary 'NULL' values from
 Pointer
Message-ID: <Y0OVjpAMT0OD1q1D@casper.infradead.org>
References: <20221010034238.3604-1-xupengfei@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010034238.3604-1-xupengfei@nfschina.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 11:42:38AM +0800, XU pengfei wrote:
> Pointer variables allocate memory first, and then judge. There is no
> need to initialize the assignment.

This seems worse to me.
