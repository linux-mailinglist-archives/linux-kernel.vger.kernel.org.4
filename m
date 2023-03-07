Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453916ADD24
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 12:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjCGLUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 06:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjCGLUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 06:20:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E22A7D8C;
        Tue,  7 Mar 2023 03:20:39 -0800 (PST)
From:   Bastian Germann <bage@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678188036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fjU0RRsv7TsEJsNWRtNsfcewJtMWB2CYOxvOiRR9HvM=;
        b=17xEKT9OuHgdtQstFPiyp6fSl3ZlGibcexGgHDAKNwvTMMIGXDxkQ9gPpD2eSWbb0wT+nu
        c2aqldLfL8zenD5JlhiZxx2Kjg07aLBhlSJKBFwtrynQIYMBDuYTMtB+P9t3XAOBs57E25
        kzrugp9yxM4YHxLRhPNSzosKFZ+afzJpOPDQKwxUA/FA6dP0kDCB1FNEczarZ1UlJIdxoo
        hlwZeH+oBvLI5v7ZMWRHlwA97IZQ4VULbcugtbg+TnUj//kZ9uZT8XKXstZNJefe37hwEi
        b5+BFN/V7fIUlDZXBQws3wpA4HOK/57dWixL3hD5vwqeqTopBOX0D7fo3sH+nQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678188036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fjU0RRsv7TsEJsNWRtNsfcewJtMWB2CYOxvOiRR9HvM=;
        b=QX83x/w/aZKnoVl14WLp4M0p7i6HBlzKuefpyHj4jajoRcQobfRLMWt45CSkG1uINhU2hz
        6JRSg7kvH8shTnAA==
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Cc:     Bastian Germann <bage@linutronix.de>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] kbuild: deb-pkg: default dpkg-buildpackage --build
Date:   Tue,  7 Mar 2023 12:20:27 +0100
Message-Id: <20230307112028.14190-1-bage@linutronix.de>
In-Reply-To: <CAK7LNASjiAB93mu0igQsiwgu=zrgu3gArMJZ+6CXHuJ+kG_ELg@mail.gmail.com>
References: <CAK7LNASjiAB93mu0igQsiwgu=zrgu3gArMJZ+6CXHuJ+kG_ELg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

deb-pkg's dpkg-buildpackage invocation was changed in v6.2, unnecessarily
adding the --build parameter explicitly. Revert the change.

Changelog:
v2:
 * Rephrase the commit message not to misrepresent the build options

Bastian Germann (1):
  kbuild: deb-pkg: default dpkg-buildpackage --build

 scripts/Makefile.package | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.39.2

