Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371BD72D411
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 00:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238589AbjFLWFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 18:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238415AbjFLWFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 18:05:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D99E7E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 15:05:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9424617C7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 22:05:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74BAC433D2;
        Mon, 12 Jun 2023 22:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686607528;
        bh=67j+zg7ffLZr8d1DjU5R47Sa/2k7qREoVr6vB5Cd3Ak=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hatKJDtMvsdi7USGKbReD6lLZDJamN3rTvZ/af6LWTc9abHe2bv81ZiFuwsFTvgdV
         WvbJk6hoz3MePv8iMRZjT6erUwQfTAeTOUniXNm7WBUIswCSV4+HQn/PamoS5zHPbj
         9oUBAr7bY3yUJW9zLCdQHp7/LjjpQwppjP/Bwp7WcOsHRl2vbALIPU3Gq1AVkXv53N
         5fWnV4fNE+5/PxWb009SHsqJga4tZbqUzRyRVpvKP3KxlVxmtzS2FKQAJsn4XDNuTI
         THOSvXA1XDbdPG5xE+eqKzOTaU/ySDaAeKYDBL4EDJRvcEYSlO9ZXjQpS0tgUum7WM
         b9QSonWi2YC3w==
Date:   Mon, 12 Jun 2023 15:05:26 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Tree Davies <tdavies@darkphysics.net>
Cc:     anthony.l.nguyen@intel.com, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/e1000: Fix single statement blocks warning
Message-ID: <20230612150526.10ca14ac@kernel.org>
In-Reply-To: <ZIZI5czU2Qv5KrPA@oatmeal.darkphysics>
References: <ZIZI5czU2Qv5KrPA@oatmeal.darkphysics>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jun 2023 15:21:36 -0700 Tree Davies wrote:
> This patch fixes checkpatch.pl warning of type:
> WARNING: braces {} are not necessary for single statement blocks

We don't accept pure checkpatch "fixes" in networking, sorry.
