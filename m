Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51207615496
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiKAWBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiKAWBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:01:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9401963E5;
        Tue,  1 Nov 2022 15:00:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7330D61645;
        Tue,  1 Nov 2022 22:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C7CC433D6;
        Tue,  1 Nov 2022 22:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667340054;
        bh=gP4LqJrYpXjsL/T9scrG8Q+DRiTrpGTd3NYLkmhHrI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fRYKIiCTh+nt+jwvEtoepcLF1JLG+o+9vufajBuCbph+kwKeCCVkSG9Kn2bwhMYrE
         rhAw4A9JPtAn51/Uy1icFcHgU+8iB1m4GP4U6DpTdESd1Vsemld9fbxWFqryzXFjev
         W1eA34cPWjp1NpNqm649U0yCJmAum92gHpOjbkLZNtDKEFFjiDe4rFPQ+CDiT/LFQb
         GRWplJx71OhFSuJystQEv++gDi9UfSpL/JN+IOn2ezfkwSdDJ4ZtnflP0FQA4DoCLW
         7s4nuhJqkb+orDR85juqFSf2TuqH/M9Y+lB2UDiNgCo4ecdyezNj78XrwxvuyH9t4V
         74TVYCik84+tA==
From:   SeongJae Park <sj@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        damon@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH 20/30] mm/damon: Use kstrtobool() instead of strtobool()
Date:   Tue,  1 Nov 2022 22:00:53 +0000
Message-Id: <20221101220053.95605-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ed2b46489a513988688decb53850339cc228940c.1667336095.git.christophe.jaillet@wanadoo.fr>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Nov 2022 22:14:08 +0100 Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> strtobool() is the same as kstrtobool().
> However, the latter is more used within the kernel.
> 
> In order to remove strtobool() and slightly simplify kstrtox.h, switch to
> the other function name.
> 
> While at it, include the corresponding header file (<linux/kstrtox.h>)
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
