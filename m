Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03837454E8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 07:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjGCFev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 01:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjGCFeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 01:34:37 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CA0180;
        Sun,  2 Jul 2023 22:34:36 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QvZP63ptwz4wxv;
        Mon,  3 Jul 2023 15:34:34 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linux-kbuild@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
In-Reply-To: <20230119082250.151485-1-masahiroy@kernel.org>
References: <20230119082250.151485-1-masahiroy@kernel.org>
Subject: Re: [PATCH] powerpc: remove checks for binutils older than 2.25
Message-Id: <168836201908.50010.5927989610628037960.b4-ty@ellerman.id.au>
Date:   Mon, 03 Jul 2023 15:26:59 +1000
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

On Thu, 19 Jan 2023 17:22:50 +0900, Masahiro Yamada wrote:
> Commit e4412739472b ("Documentation: raise minimum supported version of
> binutils to 2.25") allows us to remove the checks for old binutils.
> 
> There is no more user for ld-ifversion. Remove it as well.
> 
> 

Applied to powerpc/next.

[1/1] powerpc: remove checks for binutils older than 2.25
      https://git.kernel.org/powerpc/c/54a11654de163994e32b24e3aa90ef81f4a3184d

cheers
