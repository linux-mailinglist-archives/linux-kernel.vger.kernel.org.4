Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D91363D1FC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbiK3Jcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbiK3Jbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:31:47 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5D350D6C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:31:36 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NMYqp6M9mz4xZ7;
        Wed, 30 Nov 2022 20:31:34 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Scott Wood <oss@buserror.net>, Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org, Liang He <windhl@126.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <YzNNznewTyCJiGFz@google.com>
References: <YzNNznewTyCJiGFz@google.com>
Subject: Re: [PATCH] powerpc/sgy_cts1000: convert to using gpiod API and facelift
Message-Id: <166980023729.3017288.15906997195440617007.b4-ty@ellerman.id.au>
Date:   Wed, 30 Nov 2022 20:23:57 +1100
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

On Tue, 27 Sep 2022 12:23:58 -0700, Dmitry Torokhov wrote:
> This patch converts the driver to newer gpiod API, and away from
> OF-specific legacy gpio API that we want to stop using.
> 
> While at it, let's address a few more issues:
> 
> - switch to using dev_info()/pr_info() and friends
> - cancel work when unbinding the driver
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/sgy_cts1000: convert to using gpiod API and facelift
      https://git.kernel.org/powerpc/c/4e87bd14e501030619d1bad29b3ec1f947f84fc4

cheers
