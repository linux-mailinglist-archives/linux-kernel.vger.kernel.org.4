Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8385263D221
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbiK3JiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235749AbiK3JhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:37:21 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E23C6D972
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:34:13 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NMYtq1KH2z4xvS;
        Wed, 30 Nov 2022 20:34:11 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1668764429-11540-1-git-send-email-yangtiezhu@loongson.cn>
References: <1668764429-11540-1-git-send-email-yangtiezhu@loongson.cn>
Subject: Re: [PATCH] powerpc: Use "grep -E" instead of "egrep"
Message-Id: <166980026260.3017288.14087410885102368341.b4-ty@ellerman.id.au>
Date:   Wed, 30 Nov 2022 20:24:22 +1100
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

On Fri, 18 Nov 2022 17:40:29 +0800, Tiezhu Yang wrote:
> The latest version of grep claims the egrep is now obsolete so the build
> now contains warnings that look like:
> 	egrep: warning: egrep is obsolescent; using grep -E
> fix this up by moving the related file to use "grep -E" instead.
> 
>   sed -i "s/egrep/grep -E/g" `grep egrep -rwl arch/powerpc`
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Use "grep -E" instead of "egrep"
      https://git.kernel.org/powerpc/c/a9ffb8ee7b65a468474d6a2be7e9cca4b8f8ea5f

cheers
