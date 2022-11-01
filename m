Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2C06142C7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 02:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiKABeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 21:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKABd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 21:33:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCC3CE19
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 18:33:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA8AC614E1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 01:33:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE12C433D6;
        Tue,  1 Nov 2022 01:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667266438;
        bh=1R3A4+upFlOaH18G4yyoWXKeSFf2q/c4z0/lwtbysmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NSfLskmumJp9AjcOGMOvoEQw4NX7iCsvt7olesdh2gdY/9LsMbVok4jQ+zcFDvXmV
         DnmGqK3IsNN+w6B3mpG85vtyxgUJRarj/PhQYT3M7V+WXsgeiKfJ1Ux52wrXpci5G7
         zc7VhLHYAhxHF294bxbTL+2gP39CEIP+MZIixOFMvkHI0HcUs/UskMM5QzOhspjFNv
         rDzbsDF2RaOz6QJ5jrTXjcBHt/3DVyIk79+iEGw4Q20tbg6IH8q0XyPWWcCfuIqPfn
         XUy/YVEgNg1kNZl7Z+jVH35XLAT5S2Tvi4gDr0wPUPa8PKR+yohhdX9TbphW3AYId/
         BldctNqbhHaJQ==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     damon@lists.linux.dev, linux-damon@amazon.com,
        linux-damon-trial@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: DAMON Beer/Coffee/Tea chat series
Date:   Tue,  1 Nov 2022 01:33:56 +0000
Message-Id: <20221101013356.52287-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220810225102.124459-1-sj@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, 10 Aug 2022 22:51:02 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hello,
> 
> 
> In short, I'd like to start an open, regular, and informal virtual bi-weekly
> meeting series for DAMON community.
> 
> Important links and dates
> -------------------------
> 
> Location: https://meet.google.com/ndx-evoc-gbu
> Agenda: https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing

Next instance of the chat series was scheduled on 2022-11-15 (Tue) 09:30 PDT.
However, as the daylight saving time finishes before the date, I updated the
time to the same time but in PST.  Please refer to the updated Agenda Google
doc.  Sorry for late update, and looking foraward to see you in the next
meeting!


Thanks,
SJ
