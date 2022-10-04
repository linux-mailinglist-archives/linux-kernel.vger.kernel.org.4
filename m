Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1C95F4469
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 15:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiJDNj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 09:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiJDNjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 09:39:01 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816DE4CA0F;
        Tue,  4 Oct 2022 06:38:59 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mhf1Y4xQCz4xGR;
        Wed,  5 Oct 2022 00:38:57 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <20220929101502.32527-1-lukas.bulwahn@gmail.com>
References: <20220929101502.32527-1-lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] powerpc: update config files
Message-Id: <166488998096.779920.14977787717573960548.b4-ty@ellerman.id.au>
Date:   Wed, 05 Oct 2022 00:26:20 +1100
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

On Thu, 29 Sep 2022 12:15:02 +0200, Lukas Bulwahn wrote:
> Clean up config files by:
>   - removing configs that were deleted in the past
>   - removing configs not in tree and without recently pending patches
>   - adding new configs that are replacements for old configs in the file
> 
> For some detailed information, see Link.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: update config files
      https://git.kernel.org/powerpc/c/d210ee3fdfe8584f84f8fdd0ac4a9895d023325b

cheers
