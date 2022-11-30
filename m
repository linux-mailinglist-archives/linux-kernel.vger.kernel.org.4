Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6474463D1E8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbiK3Jbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbiK3Jb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:31:27 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8CD37234
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:31:27 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NMYqY25wxz4x1R;
        Wed, 30 Nov 2022 20:31:21 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Haowen Bai <baihaowen@meizu.com>, masahiroy@kernel.org,
        benh@kernel.crashing.org, adobriyan@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1647484554-13258-1-git-send-email-baihaowen@meizu.com>
References: <1647484554-13258-1-git-send-email-baihaowen@meizu.com>
Subject: Re: [PATCH] macintosh: adb: Fix warning comparing pointer to 0
Message-Id: <166980021723.3017288.15149086182238298951.b4-ty@ellerman.id.au>
Date:   Wed, 30 Nov 2022 20:23:37 +1100
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

On Thu, 17 Mar 2022 10:35:54 +0800, Haowen Bai wrote:
> Avoid pointer type value compared with 0 to make code clear.
> 
> 

Applied to powerpc/next.

[1/1] macintosh: adb: Fix warning comparing pointer to 0
      https://git.kernel.org/powerpc/c/2f59562c140d3119328f869126e8e593a99a392f

cheers
