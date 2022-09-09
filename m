Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B645B373A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbiIIMLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiIIMKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:10:45 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2412812169F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 05:10:13 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MPFDg3xHxz4xG8;
        Fri,  9 Sep 2022 22:10:11 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     paulus@samba.org, christophe.leroy@csgroup.eu, oss@buserror.net,
        Liang He <windhl@126.com>, benh@kernel.crashing.org,
        mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220616132922.3987053-1-windhl@126.com>
References: <20220616132922.3987053-1-windhl@126.com>
Subject: Re: [PATCH] arch: powerpc: platforms: 85xx: Fix refcount leak bug in ksi8560.c
Message-Id: <166272522204.2076816.4551170888225259298.b4-ty@ellerman.id.au>
Date:   Fri, 09 Sep 2022 22:07:02 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2022 21:29:22 +0800, Liang He wrote:
> In ksi8560_setup_arch(), of_find_compatible_node() will return a
> node pointer with refcount incremented. We should use of_node_put()
> when it is not used anymore.
> 
> 

Applied to powerpc/next.

[1/1] arch: powerpc: platforms: 85xx: Fix refcount leak bug in ksi8560.c
      https://git.kernel.org/powerpc/c/64e696af167f612cd1ecba89edfeb2353ca59947

cheers
