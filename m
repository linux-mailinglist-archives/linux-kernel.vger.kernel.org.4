Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429BA63D223
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235183AbiK3Jid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235747AbiK3JhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:37:21 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A4E5F5B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:34:12 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NMYtn6cmPz4xw2;
        Wed, 30 Nov 2022 20:34:09 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org,
        Deming <wangdeming@inspur.com>, paulus@samba.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20220413105507.1729-1-wangdeming@inspur.com>
References: <20220413105507.1729-1-wangdeming@inspur.com>
Subject: Re: [PATCH] powerpc/xive: remove unused parameter
Message-Id: <166980022275.3017288.3470395462590066759.b4-ty@ellerman.id.au>
Date:   Wed, 30 Nov 2022 20:23:42 +1100
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

On Wed, 13 Apr 2022 06:55:07 -0400, Deming wrote:
> From: Deming Wang <wangdeming@inspur.com>
> 
> the parameter xc balongng to xive_cleanup_single_escalation is unused,so we
> need to remove it.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/xive: remove unused parameter
      https://git.kernel.org/powerpc/c/932c6dea4f32f7d71488137c475b60a77e56bb2a

cheers
