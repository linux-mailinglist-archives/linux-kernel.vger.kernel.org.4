Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A863A6AC37A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjCFOiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjCFOiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:38:22 -0500
X-Greylist: delayed 290 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Mar 2023 06:37:53 PST
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BFC199;
        Mon,  6 Mar 2023 06:37:52 -0800 (PST)
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
        by mail.avm.de (Postfix) with ESMTPS;
        Mon,  6 Mar 2023 15:30:07 +0100 (CET)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPA id 82C5480652;
        Mon,  6 Mar 2023 15:30:07 +0100 (CET)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
        id 762A11818DC; Mon,  6 Mar 2023 15:30:07 +0100 (CET)
Date:   Mon, 6 Mar 2023 15:30:07 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Bastian Germann <bage@linutronix.de>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] kbuild: deb-pkg: default dpkg-buildpackage --build
Message-ID: <ZAX47xq+eQX41htE@buildd.core.avm.de>
References: <20230305232536.19528-1-bage@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230305232536.19528-1-bage@linutronix.de>
X-purgate-ID: 149429::1678113007-66594088-70B9AE5C/0/0
X-purgate-type: clean
X-purgate-size: 720
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 12:25:34AM +0100, Bastian Germann wrote:
> deb-pkg's dpkg-buildpackage invocation was changed in v6.2, unnecessarily

v6.3

> adding the --build parameter explicitly. Revert the change.
> 
> Bastian Germann (1):
>   kbuild: deb-pkg: default dpkg-buildpackage --build
> 
>  scripts/Makefile.package | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> -- 
> 2.39.2
> 

Masahiro prepared a patch [1] for explicitly introducing a 'srcdeb-pkg'
target, but scheduled its inclusion for v6.4.

Kind regards,
Nicolas

[1]: https://lore.kernel.org/linux-kbuild/CAK7LNAR82ZgvKof9VMXRM4A_h22ZNCyoaKoHW-ONJ+4vctCu_A@mail.gmail.com/T/#m59cc003498dab9b7246198ac3172527256bd1304
