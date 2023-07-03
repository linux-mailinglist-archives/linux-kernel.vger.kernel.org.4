Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4039574551C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 07:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjGCFxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 01:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjGCFww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 01:52:52 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE236BF
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 22:52:50 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QvZpB3fk7z4wy8;
        Mon,  3 Jul 2023 15:52:50 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     arnd@arndb.de, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        Tom Rix <trix@redhat.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230428221240.2679194-1-trix@redhat.com>
References: <20230428221240.2679194-1-trix@redhat.com>
Subject: Re: [PATCH] powerpc: remove unneeded if-checks
Message-Id: <168836201880.50010.12319548059181473411.b4-ty@ellerman.id.au>
Date:   Mon, 03 Jul 2023 15:26:58 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Apr 2023 18:12:40 -0400, Tom Rix wrote:
> For ppc64, gcc with W=1 reports
> arch/powerpc/platforms/cell/spu_base.c:330:17: error:
>   suggest braces around empty body in an 'if' statement [-Werror=empty-body]
>   330 |                 ;
>       |                 ^
> arch/powerpc/platforms/cell/spu_base.c:333:17: error:
>   suggest braces around empty body in an 'if' statement [-Werror=empty-body]
>   333 |                 ;
>       |                 ^
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: remove unneeded if-checks
      https://git.kernel.org/powerpc/c/da5311a4b852eaf2c0feac8b28884a8d8a801dfc

cheers
