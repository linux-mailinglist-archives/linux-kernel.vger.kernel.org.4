Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B022F5B3773
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbiIIMMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiIIMLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:11:02 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A301395B9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 05:10:31 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MPFF03wppz4xt1;
        Fri,  9 Sep 2022 22:10:28 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Jilin Yuan <yuanjilin@cdjrlc.com>, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220831005109.38314-1-yuanjilin@cdjrlc.com>
References: <20220831005109.38314-1-yuanjilin@cdjrlc.com>
Subject: Re: [PATCH] powerpc/mobility: fix repeated words in comments
Message-Id: <166272525378.2076816.824475469977194239.b4-ty@ellerman.id.au>
Date:   Fri, 09 Sep 2022 22:07:33 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Aug 2022 08:51:09 +0800, Jilin Yuan wrote:
> Delete the redundant word 'the'.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/mobility: fix repeated words in comments
      https://git.kernel.org/powerpc/c/4c73cadcdc64b53248bca85baa8a19e7384701ec

cheers
