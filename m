Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B794C63D1E2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbiK3Jb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbiK3Jb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:31:26 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565F0537C8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:31:25 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NMYqb58Wmz4xN3;
        Wed, 30 Nov 2022 20:31:23 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Haowen Bai <baihaowen@meizu.com>, masahiroy@kernel.org,
        benh@kernel.crashing.org, adobriyan@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1647485822-16717-1-git-send-email-baihaowen@meizu.com>
References: <1647485822-16717-1-git-send-email-baihaowen@meizu.com>
Subject: Re: [PATCH] macintosh: windfarm_pm121: Fix warning comparing pointer to 0
Message-Id: <166980021876.3017288.242041030903365720.b4-ty@ellerman.id.au>
Date:   Wed, 30 Nov 2022 20:23:38 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Mar 2022 10:57:02 +0800, Haowen Bai wrote:
> Avoid pointer type value compared with 0 to make code clear.
> 
> 

Applied to powerpc/next.

[1/1] macintosh: windfarm_pm121: Fix warning comparing pointer to 0
      https://git.kernel.org/powerpc/c/a823307bf0a3b79b27eea916bf6499ba4377cdf9

cheers
