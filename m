Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC5A70ED39
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 07:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239462AbjEXFmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 01:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239466AbjEXFmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 01:42:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75572B3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 22:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=OoxhfjY0Fv2hkH/rbEy3HvO8EO
        mvJnEXF94hjekW6WgoXhJLtc+nE82C1i5R2G1EZV6D+Q8o5glKREb2YKUZ4vihbyvRJRY7Gti7r33
        T6vpZIPA2nrixH2SMxBHQhF4sZWVHYLd4XN8cGTXnI92MK5ZPZRmglWTBvDz7TWyghPL8+7sQQL/6
        ZjxpkEKfSxbgV0OduxKhSiigSCZIckpJn6m6qNLCzzsoxupKiUxSNGehfejo2hzRZLO9Pz3TOOpIw
        z8skkRYcG/aHaavdDudCpd/ivpuTy93saKWU7EK66JB5SW2VeBPHjMHIKXwJnr0vtSdN01COYlR+s
        knPxHsGg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1hGD-00CQJC-0f;
        Wed, 24 May 2023 05:42:09 +0000
Date:   Tue, 23 May 2023 22:42:09 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     hch@infradead.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] freevxfs: Fix some kernel-doc comments
Message-ID: <ZG2jsfgge7tgz6CC@infradead.org>
References: <20230524053753.3573-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524053753.3573-1-yang.lee@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

