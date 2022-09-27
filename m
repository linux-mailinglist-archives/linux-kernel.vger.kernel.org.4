Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06105ECC9B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 21:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiI0TD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 15:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiI0TDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 15:03:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627A11CEDCA;
        Tue, 27 Sep 2022 12:03:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 000D761B44;
        Tue, 27 Sep 2022 19:03:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D8EC433D7;
        Tue, 27 Sep 2022 19:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664305403;
        bh=I8bCAI3GcknRsGWFi5y4kb0GXANrzOyH5tFRETHYIpc=;
        h=From:To:Cc:Subject:Date:From;
        b=Ls7LIYi6mlIW2fL6r3rmqh9Jz+48o4mONAIpixPMaKQ6J2Hya1jqdTmSWGnhmxecy
         Q0W8hjNcGUJNmI5V7KpISQnjxoGUByQJ3eHNITXlx4IYKwGqxtsiY5N2j2qv3ec+pJ
         hXrYhs0rImoMV5tq4zgzxG1FDONef2OpUxFgrmifnDNbxM4Z/Bx+wsBJBaxF3EJ/m8
         ZxCrpTkSpXqXoFWSlHWU25EjgIcvriKvw2x6pAGneHjura+a+plZtIro8mVD/PWYAo
         thl/3HF1UlUzgNBCOH+9hd48F2N+xRHbucAScvk0/8v01DYit3zJ14J/ZDZXwLwOZM
         CEj6stT3FgkyA==
From:   broonie@kernel.org
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>
Subject: linux-next: manual merge of the kspp tree with the arm64-fixes tree
Date:   Tue, 27 Sep 2022 20:03:18 +0100
Message-Id: <20220927190318.513999-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the kspp tree got a conflict in:

  include/asm-generic/vmlinux.lds.h

between commit:

  13b0566962914 ("vmlinux.lds.h: CFI: Reduce alignment of jump-table to function alignment")

from the arm64-fixes tree and commit:

  89245600941e4 ("cfi: Switch to -fsanitize=kcfi")

from the kspp tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc include/asm-generic/vmlinux.lds.h
index ae63dd8a3a2cf,7501edfce11ea..0000000000000
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h

[The block updated in Will's commit is just plain removed with no
equivalent in kspp]
