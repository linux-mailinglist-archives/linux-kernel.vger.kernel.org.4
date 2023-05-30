Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3ACF715BCC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjE3Kam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbjE3KaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:30:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFE1198;
        Tue, 30 May 2023 03:29:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA5B26232F;
        Tue, 30 May 2023 10:29:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CA3C433EF;
        Tue, 30 May 2023 10:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685442582;
        bh=yaQ1s4zqJX+CR6dLRA+UZTtmUpMxJSpY3TwJ7NIb7pw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=MtphMf9fx4Ckf8MUWsnOC2+KfKZgeU0ZtAT6Nhi/dHL1UBFE+4IIHm3yj1wmROfkS
         gRMBm/TWmoBooKy7de9GhOr1U5is9vKttU35U12v+0JWKDL9Zi6qQt0Uvf2GyxF3PZ
         41o1dB1Ge0DR/YSgun68lWzlnKm4fR8fJXCDGPCW+y8D0D2pVJ8TaPDqZghvc3Zc/c
         tBOe/l/s/uwLrQ11oJlUhIhILhvTbFAYfuY8PYn8n2AfVRNkCXdDboUOSNvkokQQfL
         KZ+WAZ6KN8V7iYyfwgyrEPaNUXpeAdm0OlXQwBZ53o9Pxva9DZ7gmdbS1Oh52kYMz4
         WLyLk7FAXqC5g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Osama Muhammad <osmtendev@gmail.com>
Cc:     nbd@nbd.name, ryder.lee@mediatek.com, lorenzo@kernel.org,
        shayne.chen@mediatek.com, davem@davemloft.net,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs.c: Fix error checking for debugfs_create_dir
References: <20230524160352.19704-1-osmtendev@gmail.com>
Date:   Tue, 30 May 2023 13:29:37 +0300
In-Reply-To: <20230524160352.19704-1-osmtendev@gmail.com> (Osama Muhammad's
        message of "Wed, 24 May 2023 21:03:52 +0500")
Message-ID: <87v8gajeni.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Osama Muhammad <osmtendev@gmail.com> writes:

> This patch fixes the error checking in debugfs.c in
> debugfs_create_dir. The correct way to check if an error occurred
> is using 'IS_ERR' inline function.
>
> Signed-off-by: Osama Muhammad <osmtendev@gmail.com>

The title is wrong, please see the wiki page below how to create titles.

Also no need to say "This patch fixes..", saying "Fix..." is enough.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
