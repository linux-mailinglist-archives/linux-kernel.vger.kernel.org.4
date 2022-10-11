Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2969D5FA92B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 02:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiJKAOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 20:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiJKAOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 20:14:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3A71AD87
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 17:13:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11A9EB810D2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 00:13:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B4EC433C1;
        Tue, 11 Oct 2022 00:13:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="baVHqYzU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665447190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=94ts48M5SS/tRVfqd8nSNQ/13AHlnM6HqjRShHGswCc=;
        b=baVHqYzUL1gentYHvD6fPlG0Rb53MTQ0jrOPGbtJum4eGZHwX4iHRYu7M2+8beK8paCZuO
        IA86oNdZ7QtjjqxfCKesku3xkVm1z7K3oONecZqnI1Ed/5J7SHcHAMk1kzMCd8i8hW1psG
        M6dUNb2cBChpFLE6K78/fPrPMoo82oA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4857d14e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 11 Oct 2022 00:13:09 +0000 (UTC)
Date:   Mon, 10 Oct 2022 18:13:03 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Andrew Donnellan <ajd@linux.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, rmclure@linux.ibm.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        aneesh.kumar@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        christophe.leroy@csgroup.eu, cuigaosheng1@huawei.com,
        david@redhat.com, farosas@linux.ibm.com, geoff@infradead.org,
        gustavoars@kernel.org, haren@linux.ibm.com, hbathini@linux.ibm.com,
        joel@jms.id.au, lihuafei1@huawei.com, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, linuxppc-dev@lists.ozlabs.org,
        lukas.bulwahn@gmail.com, mikey@neuling.org, nathan@kernel.org,
        nathanl@linux.ibm.com, nicholas@linux.ibm.com, npiggin@gmail.com,
        pali@kernel.org, paul@paul-moore.com, ruscur@russell.cc,
        windhl@126.com, wsa+renesas@sang-engineering.com,
        ye.xingchen@zte.com.cn, yuanjilin@cdjrlc.com,
        zhengyongjun3@huawei.com
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.1-1 tag
Message-ID: <Y0S1DxwKCm0aVQjT@zx2c4.com>
References: <87edvhntv0.fsf@mpe.ellerman.id.au>
 <Y0RxpSFyn9m68zIb@zx2c4.com>
 <Y0R6fcvgGA858TQA@zx2c4.com>
 <Y0ScAhqysKK6Hrks@zx2c4.com>
 <d402a6a0a11d84906ecba3909f4c8f880298dc0f.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d402a6a0a11d84906ecba3909f4c8f880298dc0f.camel@linux.ibm.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Tue, Oct 11, 2022 at 11:00:15AM +1100, Andrew Donnellan wrote:
> Thanks for bisecting, this is interesting! Could you provide your
> .config and the environment you're running in? Your reproducer doesn't
> seem to trigger it on my baremetal POWER8 pseries_le_defconfig.

Sure.

.config: https://xn--4db.cc/NemFt2Vs (change CONFIG_INITRAMFS_SOURCE)
Toolchain: https://download.wireguard.com/qemu-test/toolchains/20211123/powerpc-linux-musl-cross.tgz

You can also just run:

  ARCH=powerpc make -C tools/testing/selftests/wireguard/qemu -j$(nproc)

And that'll assemble the whole thing.

Jason
