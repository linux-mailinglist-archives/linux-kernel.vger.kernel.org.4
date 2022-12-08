Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF70647008
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 13:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiLHMur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 07:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiLHMuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 07:50:20 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328D38E5A4
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 04:50:07 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NSYs73wqhz4y3f;
        Thu,  8 Dec 2022 23:50:03 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Deming Wang <wangdeming@inspur.com>, mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
        benh@kernel.crashing.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220703172932.11329-1-wangdeming@inspur.com>
References: <20220703172932.11329-1-wangdeming@inspur.com>
Subject: Re: [PATCH] KVM: PPC: Use the arg->size directly for kvm_vm_ioctl_create_spapr_tce
Message-Id: <167050315620.1457988.17097496914352939243.b4-ty@ellerman.id.au>
Date:   Thu, 08 Dec 2022 23:39:16 +1100
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

On Sun, 3 Jul 2022 13:29:32 -0400, Deming Wang wrote:
> Use arg->size directly may be better for code readability.Because, the
> variable of size has not been found for special purpose  at present.
> Also,We can reduce the use of a variable.
> 
> 

Applied to powerpc/next.

[1/1] KVM: PPC: Use the arg->size directly for kvm_vm_ioctl_create_spapr_tce
      https://git.kernel.org/powerpc/c/6fa1efeaa6671fb7339a6c62ceeec19e8e787963

cheers
