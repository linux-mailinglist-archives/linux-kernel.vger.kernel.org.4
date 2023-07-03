Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198E77454C8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 07:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjGCFXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 01:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjGCFXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 01:23:35 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015551B0
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 22:23:33 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QvZ8K5xWTz4wxv;
        Mon,  3 Jul 2023 15:23:29 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rob Herring <robh@kernel.org>
Cc:     Darren Stevens <darren@stevens-zone.net>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230505171816.3175865-1-robh@kernel.org>
References: <20230505171816.3175865-1-robh@kernel.org>
Subject: Re: [PATCH] powerpc: isa-bridge: Fix ISA mmapping when "ranges" is not present
Message-Id: <168836167601.46386.17041701491443802315.b4-ty@ellerman.id.au>
Date:   Mon, 03 Jul 2023 15:21:16 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 May 2023 12:18:17 -0500, Rob Herring wrote:
> Commit e4ab08be5b49 ("powerpc/isa-bridge: Remove open coded "ranges"
> parsing") broke PASemi Nemo board booting. The issue is the ISA I/O
> range was not getting mapped as the logic to handle no "ranges" was
> inverted. If phb_io_base_phys is non-zero, then the ISA range defaults
> to the first 64K of the PCI I/O space. phb_io_base_phys should only be 0
> when looking for a non-PCI ISA region.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc: isa-bridge: Fix ISA mmapping when "ranges" is not present
      https://git.kernel.org/powerpc/c/79de36042eecb684e0f748d17ba52f365fde0d65

cheers
