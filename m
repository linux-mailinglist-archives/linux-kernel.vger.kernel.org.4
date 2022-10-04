Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B2C5F445D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 15:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiJDNjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 09:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJDNit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 09:38:49 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0FC50538
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 06:38:49 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mhf1L4JMQz4xGm;
        Wed,  5 Oct 2022 00:38:46 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     cgel.zte@gmail.com, mpe@ellerman.id.au
Cc:     nathanl@linux.ibm.com, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>, linuxppc-dev@lists.ozlabs.org,
        haren@linux.ibm.com, ye xingchen <ye.xingchen@zte.com.cn>,
        nick.child@ibm.com, christophe.leroy@csgroup.eu,
        Julia.Lawall@inria.fr, npiggin@gmail.com, wangborong@cdjrlc.com
In-Reply-To: <20220825072657.229168-1-ye.xingchen@zte.com.cn>
References: <20220825072657.229168-1-ye.xingchen@zte.com.cn>
Subject: Re: [PATCH linux-next] powerpc/pseries/vas: Remove the unneeded result variable
Message-Id: <166488995937.779920.17176528386276511230.b4-ty@ellerman.id.au>
Date:   Wed, 05 Oct 2022 00:25:59 +1100
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

On Thu, 25 Aug 2022 07:26:57 +0000, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Return the value vas_register_coproc_api() directly instead of storing it
> in another redundant variable.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/pseries/vas: Remove the unneeded result variable
      https://git.kernel.org/powerpc/c/91986d7f0300c2c01722e0eac5119bb0946fe9b5

cheers
