Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F525730233
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244677AbjFNOrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244633AbjFNOrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:47:20 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1845F1981;
        Wed, 14 Jun 2023 07:47:16 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 8130C92009C; Wed, 14 Jun 2023 16:47:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 7B62192009B;
        Wed, 14 Jun 2023 15:47:15 +0100 (BST)
Date:   Wed, 14 Jun 2023 15:47:15 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     baomingtong001@208suo.com
cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Octeon: remove unneeded variable
In-Reply-To: <ce48e2d625bdd4766496d44ae089e9de@208suo.com>
Message-ID: <alpine.DEB.2.21.2306141535060.64925@angie.orcam.me.uk>
References: <20230614023829.23752-1-luojianhong@cdjrlc.com> <ce48e2d625bdd4766496d44ae089e9de@208suo.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023, baomingtong001@208suo.com wrote:

> fix the following coccicheck warning:
> 
> arch/mips/cavium-octeon/executive/cvmx-spi.c:152:5-8: Unneeded variable:
> "res".

 Have you actually tried to rebuild with your "fix" applied?  Please 
always do before submitting patches.

  Maciej
