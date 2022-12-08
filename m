Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E7A646FFB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 13:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiLHMto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 07:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiLHMtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 07:49:41 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD8B27CD1
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 04:49:40 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NSYrc40Kjz4xTx;
        Thu,  8 Dec 2022 23:49:36 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     benh@kernel.crashing.org, XueBing Chen <chenxuebing@jari.cn>,
        mpe@ellerman.id.au, seanjc@google.com, aik@ozlabs.ru, clg@kaod.org,
        paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <13b2c857.beb.181725bad35.Coremail.chenxuebing@jari.cn>
References: <13b2c857.beb.181725bad35.Coremail.chenxuebing@jari.cn>
Subject: Re: [PATCH] KVM: PPC: use __func__ to get funcion's name in an output message
Message-Id: <167050315478.1457988.6983450516071083505.b4-ty@ellerman.id.au>
Date:   Thu, 08 Dec 2022 23:39:14 +1100
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

On Fri, 17 Jun 2022 23:50:19 +0800 (GMT+08:00), XueBing Chen wrote:
> Prefer using '"%s...", __func__' to get current function's name in
> an output message.
> 
> 

Applied to powerpc/next.

[1/1] KVM: PPC: use __func__ to get funcion's name in an output message
      https://git.kernel.org/powerpc/c/61119786de40f61b8843aa57217b678361763d67

cheers
