Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C208E6AD194
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjCFWch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjCFWcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:32:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781BF7298;
        Mon,  6 Mar 2023 14:32:35 -0800 (PST)
From:   Bastian Germann <bage@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678141953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dhqVhyH3ougUB0sDz35TkwMsXROEAMHHdMR9o/LQFO8=;
        b=HafQxU67c5EGh6JFb+jDuyAzL//KzomQ1JkcwhPZR0hDDQ9MuUDXgjwfqRtuzwqZRk/NsP
        IVxx6ky3gu3LjqM874JN/tds/K0ZoA/OVOiq3Cz4QA/opUhSXK3oaaE7/w3wCk6fs95cJx
        DFcww1nPJ3Qhq8dD1C4vp6iIaHZxbZzuhkyO1QdZmlcsdA0dIv1iNNu9fTmi/8YByTFWPB
        oWdEW4eRdR+MHHJwhPT/WTnpa/4WSuBf3Ij4oCWLAR6PyLLV0uf/TVUhjWv+1uvlpFSQsD
        4Gd6TW8jxHJ2inz/uslIvAnTFCF2MI1tbDGHQ1BSRZYynECZD49gWcpaci+ovw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678141953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dhqVhyH3ougUB0sDz35TkwMsXROEAMHHdMR9o/LQFO8=;
        b=hdF8LFtPjqk0HqbvSZCygVt1R/69cewnI81JVFlUIDVkzo2Tef0P1cVdzYH9zRj5IIE1qu
        A9GaXi8S95BH//Bw==
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Cc:     Bastian Germann <bage@linutronix.de>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] builddeb: introduce profile excluding the dbg pkg
Date:   Mon,  6 Mar 2023 23:32:07 +0100
Message-Id: <20230306223208.6277-1-bage@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a Debian build profile to exclude the massive debug package
during build. This was sent the first time as part of a patch series:
<20210411101422.7092-6-bage@linutronix.de>

Most of the patch series is included in the current work on mkdebian
but this is still missing.

Changelog:
v2:
 * Align the profile name with the one that ended up in Debian.

Bastian Germann (1):
  builddeb: introduce profile excluding the dbg pkg

 scripts/package/mkdebian | 1 +
 1 file changed, 1 insertion(+)

-- 
2.39.2

