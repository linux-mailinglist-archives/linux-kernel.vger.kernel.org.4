Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0773863D21E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbiK3JiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235732AbiK3JhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:37:20 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3085598
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:34:12 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NMYtn2VYfz4xvs;
        Wed, 30 Nov 2022 20:34:09 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Deming Wang <wangdeming@inspur.com>, mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, paulus@samba.org
In-Reply-To: <20220701094553.1722-1-wangdeming@inspur.com>
References: <20220701094553.1722-1-wangdeming@inspur.com>
Subject: Re: [PATCH] powerpc: Fix formatting problems to make code look more beautiful
Message-Id: <166980022583.3017288.6500427851554298863.b4-ty@ellerman.id.au>
Date:   Wed, 30 Nov 2022 20:23:45 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jul 2022 05:45:53 -0400, Deming Wang wrote:
> Operators should be separated by spaces in tce_buildmulti_pSeriesLP
> 
> 

Applied to powerpc/next.

[1/1] powerpc: Fix formatting problems to make code look more beautiful
      https://git.kernel.org/powerpc/c/14b5d59a261b1947db287b3b52f4bb1dc496dede

cheers
