Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2F964AD59
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 02:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbiLMBwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 20:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234221AbiLMBwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 20:52:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C638C1D324
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 17:52:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69CB8612FC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 01:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BCAC433EF;
        Tue, 13 Dec 2022 01:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670896352;
        bh=JUFHz4G5BIAlnJM6ImqLTsfHZswsJfOF1/964nJvH/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XjXHx894XlOK6zJbIPyoIeyLCh6k1UpwDBgP+ZsPaQLlqSy/kK003WUEVvl6QaqY6
         4x02NlRCc/MmEuYj3+No43znqYGu7hVIrwW5xP7a/KuPf76OmsmSddDMlAdq6GAetw
         H6DA/hhyXWaHDCNvt3jAD1DiqvrbaKtHen2azV+WOAc65QQPPH7JPdNYSwdQNBMAAa
         OmscaRevzmmhh9XFtVXOuJ6rO90bewwNKUnsX5HuZBaBQ/d+3d3HayLqCTF4cR318/
         H7vOyVVaZF1m7jJEPpnjdgbaEdIEDSeG1saWvkDMizTElU61jPkC5xYLCneQ4/cpS1
         DzgarKsSQU/Hw==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     damon@lists.linux.dev, linux-damon@amazon.com,
        linux-damon-trial@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: DAMON Beer/Coffee/Tea chat series
Date:   Tue, 13 Dec 2022 01:52:30 +0000
Message-Id: <20221213015230.3010-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220810225102.124459-1-sj@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

This is a reminder for the next instance of the chat series.  Next instance
will be 2022-12-13 (Tue) 09:30 PST.  You can show proposed agendas for the
chat, or propose your own using the above Google doc.

According to the original scheduling, the one after next instance would be
2022-12-26.  Because the day is during the holiday season, I've canceled it.
So, the tomorrow one will be the last instance of this chat series for 2022.
Hope to meet some of you :)


Thanks,
SJ
