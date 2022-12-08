Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B120A647007
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 13:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiLHMuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 07:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiLHMuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 07:50:10 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1AB8C458
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 04:49:59 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NSYrx530Kz4xvX;
        Thu,  8 Dec 2022 23:49:53 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     npiggin@gmail.com, christophe.leroy@csgroup.eu, mpe@ellerman.id.au,
        Laurent Dufour <ldufour@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221110180619.15796-1-ldufour@linux.ibm.com>
References: <20221110180619.15796-1-ldufour@linux.ibm.com>
Subject: Re: [PATCH v2 0/2] Consider the size of the added CPU nodes in the kexec FDT
Message-Id: <167050321905.1457988.13607875299113419626.b4-ty@ellerman.id.au>
Date:   Thu, 08 Dec 2022 23:40:19 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2022 19:06:17 +0100, Laurent Dufour wrote:
> When adding CPUs to an already big system (test show it seems to start with
> more than 256 CPUs), the kernel is showing error messages when building the
> FDT for the kexec kernel (kdump or kexec).
> 
> It's worth to mention that the kdump kernel is reloaded after a CPU add
> operation.
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc: export the CPU node count
      https://git.kernel.org/powerpc/c/e13d23a404f2e6dfaf8b1ef7d161a0836fce4fa5
[2/2] powerpc: Take in account addition CPU node when building kexec FDT
      https://git.kernel.org/powerpc/c/340a4a9f8773e102cc5ef531665970a686dfa245

cheers
