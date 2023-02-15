Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3694697B95
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 13:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbjBOMRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 07:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbjBOMRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 07:17:05 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD332B62C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 04:17:02 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PGxs575mQz4x5Z;
        Wed, 15 Feb 2023 23:16:57 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20230204172206.7662-1-rdunlap@infradead.org>
References: <20230204172206.7662-1-rdunlap@infradead.org>
Subject: Re: [PATCH] powerpc/kexec_file: fix implicit decl error
Message-Id: <167646340183.1415779.1023703853117043648.b4-ty@ellerman.id.au>
Date:   Wed, 15 Feb 2023 23:16:41 +1100
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

On Sat, 4 Feb 2023 09:22:06 -0800, Randy Dunlap wrote:
> kexec (PPC64) code calls memory_hotplug_max(). Add the header declaration
> for it from <asm/mmzone.h>. Using <linux/mmzone.h> does not work since
> the #include for <asm/mmzone.h> depends on CONFIG_NUMA=y, which is not
> set in this kernel config file.
> 
> Fixes this build error/warning:
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/kexec_file: fix implicit decl error
      https://git.kernel.org/powerpc/c/97e45d469eb180a7bd2809e4e079331552c73e42

cheers
