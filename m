Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44A5717160
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbjE3XLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbjE3XLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:11:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A98EC
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:11:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58968634F7
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 23:11:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9920DC433EF;
        Tue, 30 May 2023 23:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685488260;
        bh=X/pbSDuZtQNTgQquV+aA9wODPdYEn492ZnYb6itX4Fw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LJ8dRp6k82rMbU7wmXdSH6mnbM+xGTQznN5BwlBkgyP+mapBR8z5hetXSBAksidLX
         SICyMRmHBhYh2Vxzye/OSStHhxaLzhuCK8qv2VaeyTWlhJZcLbTrJFIN27+MjsPhsX
         6q49S7EpHo4EeuVRUxp07OrPM/IBOggm/uXUKnhcWNpvYWupbRTUm6AJ4IA6vH6Y+3
         osoPJ2+CxTeDEp6H7DJQOuU2DqX1US8ncfc3dLjVO+FuD7KAiy5eA43Lzv7lOoqn1g
         5uq7K9Xqi50ij0NpQJrnC2trIO/MYgHCCdQ8mqJzRFp7Qe5RXtvlBiY1s814fnmiup
         9ZCmfizn3ay7Q==
Date:   Tue, 30 May 2023 16:10:58 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Lu Hongfei <luhongfei@vivo.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Subject: Re: [PATCH] tools: Remove unnecessary variables
Message-ID: <20230530231058.6mosjz7pl7nwcswr@treble>
References: <20230530075649.21661-1-luhongfei@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230530075649.21661-1-luhongfei@vivo.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 03:56:49PM +0800, Lu Hongfei wrote:
> There are several places where warnings variables are not needed,
> remove them and directly return 0.
> 
> Signed-off-by: Lu Hongfei <luhongfei@vivo.com>

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh
