Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5827362DC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 06:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjFTEzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 00:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjFTEy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 00:54:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59643A6;
        Mon, 19 Jun 2023 21:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Yc66fUlnmb/kcfRHAutRPTPlR7aOXI92f3ikApgFp7c=; b=j3lCu5xG2URvoqKD7B4juv1hDZ
        1IDDKgwG1Qafw2ZR6npqaKluQHJNtnUesI7a/qsV1KbjlnTt9euutbIhDBqtBzuIDcnHLVTfYWgwD
        byDZzm8ELL5OCK2eiUJ5eUuk+GdKV026uygT45LTgP0n8ePk/VtJO1jcSi0FtaIO9GXRhLH9OwK5U
        ChxFu+xaY6orxxgAySoKMy00ExVKbEHuQpeqFLqsDfY/hio1QPdA/prJyyC8ZppvVHVgleS8ummvL
        sSpuQ4NIGOQV+ra8mJT9VlfWlWbxwG0FOwfY2kwAZB/uO+CVKFoczc2KaW0xjZfRNZVLQeKXBaakx
        OGdVTjRw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qBTO2-00A9fP-2f;
        Tue, 20 Jun 2023 04:54:38 +0000
Date:   Mon, 19 Jun 2023 21:54:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net, christian.koenig@amd.com,
        bskeggs@redhat.com, Liam.Howlett@oracle.com,
        matthew.brost@intel.com, boris.brezillon@collabora.com,
        alexdeucher@gmail.com, ogabbay@kernel.org, bagasdotme@gmail.com,
        willy@infradead.org, jason@jlekstrand.net,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Donald Robson <donald.robson@imgtec.com>,
        Dave Airlie <airlied@redhat.com>
Subject: Re: [PATCH drm-next v5 03/14] drm: manager to keep track of GPUs VA
 mappings
Message-ID: <ZJExDn9tH6ydx2FY@infradead.org>
References: <20230620004217.4700-1-dakr@redhat.com>
 <20230620004217.4700-4-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620004217.4700-4-dakr@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Why are none of these EXPORT_SYMBOL_GPL as it's very linux-internal
stuff?

