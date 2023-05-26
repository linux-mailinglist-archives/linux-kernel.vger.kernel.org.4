Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B330F7127AD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 15:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243752AbjEZNgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 09:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237082AbjEZNgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 09:36:41 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F8EF3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 06:36:40 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A4D3D6732A; Fri, 26 May 2023 15:36:37 +0200 (CEST)
Date:   Fri, 26 May 2023 15:36:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Phillip Lougher <phillip@squashfs.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>, hch@lst.de,
        linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH mm-nonmm-unstable 1/2] squashfs: fix page update race
Message-ID: <20230526133637.GB8803@lst.de>
References: <20230526-squashfs-cache-fixup-v1-0-d54a7fa23e7b@axis.com> <20230526-squashfs-cache-fixup-v1-1-d54a7fa23e7b@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526-squashfs-cache-fixup-v1-1-d54a7fa23e7b@axis.com>
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
