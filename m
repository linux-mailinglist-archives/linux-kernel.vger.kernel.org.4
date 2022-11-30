Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0409563D229
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbiK3Ji5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbiK3Jha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:37:30 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83933748C6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:34:18 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NMYtx0P3Vz4yFl;
        Wed, 30 Nov 2022 20:34:17 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     benh@kernel.crashing.org, Li zeming <zeming@nfschina.com>
Cc:     linuxppc-dev@lists.ozlabs.org, kernel@nfschina.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220707015949.3733-1-zeming@nfschina.com>
References: <20220707015949.3733-1-zeming@nfschina.com>
Subject: Re: [PATCH] macintosh/windfarm_pid: Add header file macro definition
Message-Id: <166980022736.3017288.3449497203584355891.b4-ty@ellerman.id.au>
Date:   Wed, 30 Nov 2022 20:23:47 +1100
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

On Thu, 7 Jul 2022 09:59:49 +0800, Li zeming wrote:
> I think the header file could avoid redefinition errors.
>  at compile time by adding macro definitions.
> 
> 

Applied to powerpc/next.

[1/1] macintosh/windfarm_pid: Add header file macro definition
      https://git.kernel.org/powerpc/c/e3e528d29d13c01289f382a0d3ddb5312ac3dae3

cheers
