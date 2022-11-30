Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6104E63D1FA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbiK3Jcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbiK3Jb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:31:56 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79BE663C3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:31:37 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NMYqr2S0vz4xZp;
        Wed, 30 Nov 2022 20:31:36 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Finn Thain <fthain@linux-m68k.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <0c11c0770fc4ec7e80a4b2e0ffce1055b792cfdb.1647854880.git.fthain@linux-m68k.org>
References: <0c11c0770fc4ec7e80a4b2e0ffce1055b792cfdb.1647854880.git.fthain@linux-m68k.org>
Subject: Re: [PATCH v2] macintosh/via-pmu: Avoid compiler warnings when CONFIG_PROC_FS is disabled
Message-Id: <166980022042.3017288.9367198168572746077.b4-ty@ellerman.id.au>
Date:   Wed, 30 Nov 2022 20:23:40 +1100
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

On Mon, 21 Mar 2022 20:28:00 +1100, Finn Thain wrote:
> drivers/macintosh/via-pmu.c:897:12: warning: 'pmu_battery_proc_show' defined but not used [-Wunused-function]
>  static int pmu_battery_proc_show(struct seq_file *m, void *v)
>             ^~~~~~~~~~~~~~~~~~~~~
> drivers/macintosh/via-pmu.c:871:12: warning: 'pmu_irqstats_proc_show' defined but not used [-Wunused-function]
>  static int pmu_irqstats_proc_show(struct seq_file *m, void *v)
>             ^~~~~~~~~~~~~~~~~~~~~~
> drivers/macintosh/via-pmu.c:860:12: warning: 'pmu_info_proc_show' defined but not used [-Wunused-function]
>  static int pmu_info_proc_show(struct seq_file *m, void *v)
>             ^~~~~~~~~~~~~~~~~~
> 
> [...]

Applied to powerpc/next.

[1/1] macintosh/via-pmu: Avoid compiler warnings when CONFIG_PROC_FS is disabled
      https://git.kernel.org/powerpc/c/27f9690a81d7acf185b78be8d03d4b3a243116b1

cheers
