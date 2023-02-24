Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CB16A216F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 19:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjBXS1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 13:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBXS1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 13:27:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2624D149AE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 10:27:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AED44B81CA2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 18:27:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A15C433EF;
        Fri, 24 Feb 2023 18:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677263223;
        bh=mlh3Xwhsc7gczURZje1kVVTFKaiBWzy9OB1dcTw+vsc=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=ICEAl0+6QGa/730+fPyDFXgsufGuJQn95kP29eV2scVnVufK8uFO3fwDd8bU+uvIT
         J6LHSgXeM1G75eqLHozoj/sExewJsnjqzBo+8Sv6rWg4UHF8f26+5DgDdLaVyTytfo
         nYLT6islKGUg5Wo1HiHnn1saSDV+vX3s8X2kWzPEzFWjPJOFmc/ZwKBqSRFcsbPOz3
         njWG4MSLYnJhFn1fl0mj1zUk43Yvl/g5VoLFi1TR7UZnORg1jEeneoLlM242r4RGlH
         onGzN/0jcrGb/GI14cslT/ucpCoXUoOeoknOOBs1n/nK5TC6YDfpsHnEzzjrkHUx5P
         RwIK01W9lbiEA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1A1025C0BE7; Fri, 24 Feb 2023 10:27:03 -0800 (PST)
Date:   Fri, 24 Feb 2023 10:27:03 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        kasan-dev@googlegroups.com, elver@google.com, arnd@arndb.de
Subject: [GIT PULL] KCSAN changes for v6.3
Message-ID: <20230224182703.GA635892@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

Please pull the latest KCSAN git tree from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/kcsan.2023.02.24a
  # HEAD: 6ba912f1c081448cf3d1fa9ada9115aae4594ac4: kcsan: select CONFIG_CONSTRUCTORS (2023-02-22 10:28:20 -0800)

----------------------------------------------------------------
Kernel concurrency sanitizer (KCSAN) updates for v6.3

This update fixes gcc-11 errors for x86_64 KCSAN-enabled kernel builds
by selecting the CONSTRUCTORS Kconfig option.

----------------------------------------------------------------
Arnd Bergmann (1):
      kcsan: select CONFIG_CONSTRUCTORS

 lib/Kconfig.kcsan | 1 +
 1 file changed, 1 insertion(+)
