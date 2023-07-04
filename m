Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1344974664D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 02:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjGDABa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 20:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGDAB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 20:01:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D86A13D;
        Mon,  3 Jul 2023 17:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=HbJg5hLS9q/X87uwXxElmYl7j0ghasP04sbxBMsSOUU=; b=fxjqXZZArozClmaJ0kLcYEsfIq
        Xxc/cNDmD6YpWdiPxOVQIglziSD8wDkBMOFJTvrhLH8+2qHm9k2U8JCeQMr91GB3Fe6C5pz+YOeOx
        kWMRWwoiaMIh6KTpk/RWJ0YMeZkuxA8eHwj60sDV6LL3G+pyKF5obF4Cb+rF1ZgJyb35EmAG0hJON
        A3HjZFVbAXgx6OQqBuKKipVCTmU8ZBZLrcHEwo1wPsbVzj6LIWk44d/0eV/YlE4X4RZZD0EyjBdWY
        YtEdNmOScx/5+bTDUPUn8le65pMq5P7jWsJD0jQzH9peR2DCZ2zQzmintLlAJWG9qtwiJb7QgAZO9
        Cq4tpi+Q==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qGTTu-00BgsX-0J;
        Tue, 04 Jul 2023 00:01:22 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jesse Taube <mr.bossman075@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH] kconfig: docs: mention gconfig at top of kconfig.rst
Date:   Mon,  3 Jul 2023 17:01:20 -0700
Message-ID: <20230704000120.8098-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse mentioned that gconfig is missing from the top of the
kconfig.rst file, so add it for completeness.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Link: lore.kernel.org/r/CAJFTR8QgYykuEq_AkODEWPUYXncKgRBHOncxT=ypZTQODkyarw@mail.gmail.com
Cc: Jesse Taube <mr.bossman075@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/kbuild/kconfig.rst |    2 ++
 1 file changed, 2 insertions(+)

diff -- a/Documentation/kbuild/kconfig.rst b/Documentation/kbuild/kconfig.rst
--- a/Documentation/kbuild/kconfig.rst
+++ b/Documentation/kbuild/kconfig.rst
@@ -10,6 +10,8 @@ The xconfig ('qconf'), menuconfig ('mcon
 programs also have embedded help text.  Be sure to check that for
 navigation, search, and other general help text.
 
+The gconfig ('gconf') program has limited help text.
+
 General
 -------
 
