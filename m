Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F88563D21D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbiK3Jht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235617AbiK3JhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:37:15 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B29C8BD27
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:34:09 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NMYtk6q3lz4xvp;
        Wed, 30 Nov 2022 20:34:06 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     studentxswpy@163.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     Hacash Robot <hacashRobot@santino.com>
In-Reply-To: <20220802074148.3213659-1-studentxswpy@163.com>
References: <20220802074148.3213659-1-studentxswpy@163.com>
Subject: Re: [PATCH] mm: check the return value of ioremap() in macio_init()
Message-Id: <166980022967.3017288.12712189262010498821.b4-ty@ellerman.id.au>
Date:   Wed, 30 Nov 2022 20:23:49 +1100
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

On Tue, 2 Aug 2022 15:41:48 +0800, studentxswpy@163.com wrote:
> From: Xie Shaowen <studentxswpy@163.com>
> 
> The function ioremap() in macio_init() can fail, so
> its return value should be checked.
> 
> 

Applied to powerpc/next.

[1/1] mm: check the return value of ioremap() in macio_init()
      https://git.kernel.org/powerpc/c/dbaa3105736d4d73063ea0a3b01cd7fafce924e6

cheers
