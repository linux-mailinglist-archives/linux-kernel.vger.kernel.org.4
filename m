Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB53963D1EB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbiK3Jbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbiK3Jb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:31:28 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B08E4F18E
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:31:27 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NMYqc69sCz4xN8;
        Wed, 30 Nov 2022 20:31:24 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Haowen Bai <baihaowen@meizu.com>, masahiroy@kernel.org,
        benh@kernel.crashing.org, adobriyan@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1647484953-15249-1-git-send-email-baihaowen@meizu.com>
References: <1647484953-15249-1-git-send-email-baihaowen@meizu.com>
Subject: Re: [PATCH] macintosh: windfarm_pm91: Fix warning comparing pointer to 0
Message-Id: <166980021800.3017288.6852877951128523618.b4-ty@ellerman.id.au>
Date:   Wed, 30 Nov 2022 20:23:38 +1100
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

On Thu, 17 Mar 2022 10:42:33 +0800, Haowen Bai wrote:
> Avoid pointer type value compared with 0 to make code clear.
> 
> 

Applied to powerpc/next.

[1/1] macintosh: windfarm_pm91: Fix warning comparing pointer to 0
      https://git.kernel.org/powerpc/c/88316944c3b3aa3ce3249c51689ef1621049df9d

cheers
