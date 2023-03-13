Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22ACF6B7EFE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 18:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjCMRMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 13:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjCMRMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 13:12:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECD67F016;
        Mon, 13 Mar 2023 10:11:42 -0700 (PDT)
From:   Bastian Germann <bage@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678727442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SKz8d+7WiufJ5aD7Ad8EolzfqgBiIt6hykA9SRo09kg=;
        b=owlgPW4IP9kOcnvtA/Jp/ZOOmtBLx/nQ3La9Z2bss/yQEoGVWsaQkl5hZm6OxtTXZgJMAc
        cwuejCL+1R9QSnAzJEZMeHpnmcLLM3ZUQHdH4xPsOBE3s8zErvyeBxxfHuIAyyqJclL8oh
        Zaqu3AEJF9ZMeV3Rp+jmMymYuwnU1R/nLg5VK22T2QhOh/5C2z2CFyswjbRHv/AgW49Th+
        56D1bTmfdB9O5nU4s7zZMLBPgGjQEX7b7h9fvns+CVdaiVYr7YjtThF1NX0I+2exoMOK6V
        sUcfbzC5Oo4IZdhmdovb5Sav90MipIcOEk4bwT/QEa1zKl27+ZRv6MxT7ZlJ9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678727442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SKz8d+7WiufJ5aD7Ad8EolzfqgBiIt6hykA9SRo09kg=;
        b=rmN1MfKi4cePSPuI0fwznjFAQaGmmL4DkSC+F+GNItpNsB2dCz/jrdiw2Jl/5gsK5hGSMr
        rPZ39w4IOmyI7hDg==
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Bastian Germann <bage@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] kbuild: deb-pkg: Allow parallel build
Date:   Mon, 13 Mar 2023 18:10:35 +0100
Message-Id: <20230313171036.268407-1-bage@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of DEB_BUILD_OPTIONS' parallel option.

Bastian Germann (1):
  kbuild: deb-pkg: Allow parallel build

 scripts/package/deb-build-option | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.39.2

