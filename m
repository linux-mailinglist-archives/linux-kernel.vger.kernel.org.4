Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AAC647001
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 13:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiLHMuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 07:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiLHMt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 07:49:57 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FAD8D64A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 04:49:52 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NSYrv36sgz4xvS;
        Thu,  8 Dec 2022 23:49:51 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Zhang Jiaming <jiaming@nfschina.com>, benh@kernel.crashing.org,
        mpe@ellerman.id.au, paulus@samba.org
Cc:     renyu@nfschina.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, liqiong@nfschina.com
In-Reply-To: <20220623102031.15359-1-jiaming@nfschina.com>
References: <20220623102031.15359-1-jiaming@nfschina.com>
Subject: Re: [PATCH] KVM: Fix spelling mistake
Message-Id: <167050315544.1457988.12211386518984944248.b4-ty@ellerman.id.au>
Date:   Thu, 08 Dec 2022 23:39:15 +1100
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

On Thu, 23 Jun 2022 18:20:31 +0800, Zhang Jiaming wrote:
> Change 'subsquent' to 'subsequent'.
> Change 'accross' to 'across'.
> 
> 

Applied to powerpc/next.

[1/1] KVM: Fix spelling mistake
      https://git.kernel.org/powerpc/c/392a58f1eaab0c90b80d7ba4a03dbf6eaaeabe60

cheers
