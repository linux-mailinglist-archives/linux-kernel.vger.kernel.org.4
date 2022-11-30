Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536CE63D200
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbiK3Jcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234480AbiK3Jb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:31:59 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA755686AB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:31:41 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NMYqw1zSKz4xYV;
        Wed, 30 Nov 2022 20:31:40 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     oohall@gmail.com, Bo Liu <liubo03@inspur.com>, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, mpe@ellerman.id.au,
        mahesh@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20221031063706.2770-1-liubo03@inspur.com>
References: <20221031063706.2770-1-liubo03@inspur.com>
Subject: Re: [PATCH] powerpc/pseries/eeh: Fix some kernel-doc warnings
Message-Id: <166980025413.3017288.12453883360878326670.b4-ty@ellerman.id.au>
Date:   Wed, 30 Nov 2022 20:24:14 +1100
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

On Mon, 31 Oct 2022 02:37:06 -0400, Bo Liu wrote:
> Fixes the following W=1 kernel build warning(s):
>   arch/powerpc/platforms/pseries/eeh_pseries.c:163: warning: Function parameter or member 'config_addr' not described in 'pseries_eeh_phb_reset'
>   arch/powerpc/platforms/pseries/eeh_pseries.c:163: warning: Excess function parameter 'config_adddr' description in 'pseries_eeh_phb_reset'
>   arch/powerpc/platforms/pseries/eeh_pseries.c:198: warning: Function parameter or member 'config_addr' not described in 'pseries_eeh_phb_configure_bridge'
>   arch/powerpc/platforms/pseries/eeh_pseries.c:198: warning: Excess function parameter 'config_adddr' description in 'pseries_eeh_phb_configure_bridge'
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/pseries/eeh: Fix some kernel-doc warnings
      https://git.kernel.org/powerpc/c/afa1cda4097077e37639ca7098c2147e1885b2df

cheers
