Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0336D617329
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 01:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiKCABM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 20:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiKCABI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 20:01:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B470D2AF5;
        Wed,  2 Nov 2022 17:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1GDFUiaQOnUEwBEjrHMiwUQTpUwTIiBSFbBYYstcP4Y=; b=ATzSz2iz1miGTtiAXaFPJZhr1S
        85kvS2VTjM65koeayNKE48R7xTlB/9ooJ25y/M82JyqGPiGzBR1saFvaIKZeDP+txmwCxWNs11b/B
        oRA0ws0RN6X5yogkPs7nNQYrYXt0IuKdQxdxmR66rZ20ixDFGZztBo2OTegacllOju8DI27roSM+q
        3uI0EYnjQUtf6PeX5KPsD5YBaSkqOGs1j7r+O5Nf7GMxpzFNjloYA9/cIdk+zyAgiuaLzMuLftzxN
        0N3jvGVNQvQVNBY51WVUt/ftaL+Pqp+TltO9Ku3d/7I0aaKfnZjBFlFCc2EKWtZowVYzgCodRx/Dy
        BvjwEUJg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqNfP-00FFwB-DD; Thu, 03 Nov 2022 00:01:07 +0000
Date:   Wed, 2 Nov 2022 17:01:07 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-modules@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v5 0/2] powerpc module arch checks
Message-ID: <Y2MEw6BruH3FnYL/@bombadil.infradead.org>
References: <20221031120733.3956781-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031120733.3956781-1-npiggin@gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 10:07:31PM +1000, Nicholas Piggin wrote:
> Luis if you would be okay for patch 1 to be merged via powerpc or
> prefer to take it in the module tree (or maybe you object to the
> code in the first place).

Looks good to me, and nothing on my radar which would cause a conflict
so happy for you to take it via powerpc or I can take it and apply it
right away to tricke / get tested on linux-next by tomorrow.

Let me know.

  Luis
