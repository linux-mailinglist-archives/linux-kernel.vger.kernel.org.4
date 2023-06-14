Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CCC7127ED
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 16:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243771AbjEZOCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 10:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjEZOCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 10:02:48 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A62194
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 07:02:47 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B28436732A; Fri, 26 May 2023 16:02:43 +0200 (CEST)
Date:   Fri, 26 May 2023 16:02:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Phillip Lougher <phillip@squashfs.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>, hch@lst.de,
        linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH mm-nonmm-unstable v2 2/2] squashfs: fix page indices
Message-ID: <20230526140243.GA11013@lst.de>
References: <20230526-squashfs-cache-fixup-v2-0-6fb7723c3647@axis.com> <20230526-squashfs-cache-fixup-v2-2-6fb7723c3647@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526-squashfs-cache-fixup-v2-2-6fb7723c3647@axis.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
