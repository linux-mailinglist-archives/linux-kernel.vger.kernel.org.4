Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4AE63D1F2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbiK3Jb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbiK3Jbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:31:31 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46C137231;
        Wed, 30 Nov 2022 01:31:30 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NMYqj38mfz4xQr;
        Wed, 30 Nov 2022 20:31:29 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <7b8b5915a2c7c1616b33e8433ebe0a0bf07070a2.1665312579.git.christophe.jaillet@wanadoo.fr>
References: <7b8b5915a2c7c1616b33e8433ebe0a0bf07070a2.1665312579.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] powerpc/sysdev: Remove some duplicate prefix in some messages
Message-Id: <166980024656.3017288.14591621572057347121.b4-ty@ellerman.id.au>
Date:   Wed, 30 Nov 2022 20:24:06 +1100
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

On Sun, 9 Oct 2022 12:49:50 +0200, Christophe JAILLET wrote:
> At the beginning of the file, we have:
>    #define pr_fmt(fmt) "xive: " fmt
> 
> So, there is no need to duplicate "XIVE:" in debug and error messages.
> 
> For the records, these useless prefix have been added in commit
> 5af50993850a ("KVM: PPC: Book3S HV: Native usage of the XIVE interrupt
> controller")
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/sysdev: Remove some duplicate prefix in some messages
      https://git.kernel.org/powerpc/c/2cb1dfac6f792f9e4a092793215f0d26e9f8d5b2

cheers
