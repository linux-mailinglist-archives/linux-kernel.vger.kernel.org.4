Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0936C7069D8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjEQN3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 09:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjEQN3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:29:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38893768A
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:29:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D50564768
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 13:29:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51C6C433D2;
        Wed, 17 May 2023 13:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684330156;
        bh=rckeJFNJmvcbGCr4vovE1O/hrf3AXgSnOIF5W9XOzL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kVZUAUSqoy7so6ltYtzhNF85dvBROZaPAeGuF4ukARVF9KHpshU+m2VBLJK/EZYrb
         BZES6B4ArfFV1k5xM6D7OuQnUAxfeLYsGOnvZu+ZNe0HKF/EZk6giz1EuttOI0E/24
         +IbML8AoIS8YBojb5FEGJcpLsdJghh2lpx+fwo8XWZ605G+tKUNas9Ah8QeqUi5IrS
         orXxdtTexz4klAs3NWwaIv6ygRbW8EVGaKCMOeL9IxpqnctL9TS/6jkWwbwapG5R81
         55wM974k/bWByJBED1wy/DWNDAOnA8aBQBmDJUgsBi/mGIP+tiiRwiojUwSqJpcFyB
         PiSE3bwv925Mg==
From:   Christian Brauner <brauner@kernel.org>
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>, anton@tuxera.com,
        linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, akpm@linux-foundation.org
Subject: Re: [PATCH v2] ntfs: Add myself as a reviewer
Date:   Wed, 17 May 2023 15:29:07 +0200
Message-Id: <20230517-aufspaltung-fahren-0e4314f3fe13@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517070739.6505-1-linkinjeon@kernel.org>
References: <20230517070739.6505-1-linkinjeon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=761; i=brauner@kernel.org; h=from:subject:message-id; bh=rckeJFNJmvcbGCr4vovE1O/hrf3AXgSnOIF5W9XOzL0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSkXJu9pvnxj+4HHAy6s3YvZcmb3/fpNnP0Ft31epyrjOVj ZzrpdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEmoPhn0af2vSpL5UtxP9x5G3qeH t0XqBwwtTCgypTNNa6dS9pSWf4p326QJ8rx7rT/LCp9NRuUe/IijXlLkbH8xOfiQiY6aswAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 16:07:39 +0900, Namjae Jeon wrote:
> I'm volunteering to help review patches for current unmaintained
> ntfs filesytem.
> 
> 

Applied to the vfs.misc.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.misc.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc.fixes

[1/1] ntfs: Add myself as a reviewer
      https://git.kernel.org/vfs/vfs/c/48524463f807
