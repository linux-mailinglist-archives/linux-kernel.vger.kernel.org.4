Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BA970EB33
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 04:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239044AbjEXCNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 22:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjEXCNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 22:13:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213A713E;
        Tue, 23 May 2023 19:13:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA0E963760;
        Wed, 24 May 2023 02:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3F0C433D2;
        Wed, 24 May 2023 02:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684894430;
        bh=lQ+RJVQY9YAF2fxnygyHT0XuujcPWCBCVMHk5qLdGYo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IfmFNDPZkEainTVx2Mp4ms2bg9tCoaw2yfQ2vL0CrTQF0FZvJa3DmiJVtMXYY1Ovz
         wJrVehjFX+ZFTGyHf9n2AZahlAkyH4GM+BeIJjcllc32Cn6W3vxogJXvap/LNXoPo1
         SmAZTdmX+0n/6hexL7yenPDR9GTFaHapkQEOlp/rDTpLpMoJTKdcV5AJFacyvyyWLc
         zpjnNRp+xI3j8ZWawwqfvElK4zEwKY4ujPLgyNU9lXVSjaWwgY4xG5K/ZAECOb196q
         bSTxviQ+UCrZPSDUymk3c7mfEGm7LhwHT7yrQ3JHP9V/VZg6emGeVeBCm7V0n98KG3
         rzo/sBabl+SQg==
Message-ID: <df5e3225a82ddceffe3cf3bffc2c14f52d0a0bb1.camel@kernel.org>
Subject: Re: [PATCH] Documentation: module-signing: Mention
 default_x509.genkey template
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Keyrings <keyrings@vger.kernel.org>,
        Linux Kernel Build System <linux-kbuild@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 24 May 2023 05:13:47 +0300
In-Reply-To: <20230511043852.25803-1-bagasdotme@gmail.com>
References: <20230511043852.25803-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-05-11 at 11:38 +0700, Bagas Sanjaya wrote:
> Commit f3a2ba44e93e2c ("certs: check-in the default x509 config file")
> adds default x509 keypair config file template, but forgets to mention
> it in kernel module signing documentation. Update the doc accordingly.
>=20
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

