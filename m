Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9FE69E677
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjBURzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234986AbjBURy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:54:57 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D222FCE1;
        Tue, 21 Feb 2023 09:54:35 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id ED7DC68AFE; Tue, 21 Feb 2023 18:54:24 +0100 (CET)
Date:   Tue, 21 Feb 2023 18:54:23 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, tsbogend@alpha.franken.de,
        mpe@ellerman.id.au, paul.walmsley@sifive.com, palmer@dabbelt.com,
        robh+dt@kernel.org, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com
Subject: Re: [PATCH 0/7] MIPS DMA coherence fixes
Message-ID: <20230221175423.GA15247@lst.de>
References: <20230221124613.2859-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230221124613.2859-1-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can you explain the motivation here?  Also why riscv patches are at
the end of a mips fіxes series?
