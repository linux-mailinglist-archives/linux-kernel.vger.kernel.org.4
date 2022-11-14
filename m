Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608B7628607
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237245AbiKNQvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236962AbiKNQvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:51:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5A11B784
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:51:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91D46612EE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 16:51:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86792C433C1;
        Mon, 14 Nov 2022 16:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668444674;
        bh=9IOTMhVM4RJc931VeRVmeYbkyluCbLbtzk4jJQ7uS5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GgFZeDFwlznEdaAsXMtQTK3WK4q0RCAVDyjit6rb4A1lKGA6za5RtsvGFGBk73YTn
         iGvBn73Pe6ceKywbyPBQ9Y5q2dQ1tw1YmZggQ4F9lb8et5PQ3XCP+4fXj81bJ/TjhX
         nxuUxPt2JY+Sh49/7iMDPEyfpn8z2SNFlbx4aRegNT224+IhOdFc+GltL7rhprJeIB
         dTWfMfm8t2kR36C4ejS19tSePjpATCb17hYk9g6jMNi1KQ6ATxY4aq6OG+7AIlpi8W
         ZwFFgx5sy2Tza5T0hqovOOGyBIhej5M/cj6ABqhBbQx+/tg5FKowkMzcyGRe0edlA5
         8YgdFv4JXvxag==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     damon@lists.linux.dev, linux-damon@amazon.com,
        linux-damon-trial@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: DAMON Beer/Coffee/Tea chat series
Date:   Mon, 14 Nov 2022 16:51:12 +0000
Message-Id: <20221114165112.21454-1-sj@kernel.org>
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
will be 2022-11-15 (Tue) 09:30 PST.  You can show proposed agendas for the
chat, or propose your own using the above Google doc.  Hope to meet some of you
:)


Thanks,
SJ
