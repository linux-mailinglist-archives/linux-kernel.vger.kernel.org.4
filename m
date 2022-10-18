Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6703060313E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 19:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJRRAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 13:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiJRRAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 13:00:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E91FCA8B8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 10:00:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7196061648
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 17:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5926CC433D7;
        Tue, 18 Oct 2022 17:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666112400;
        bh=j95Pr+nqCm9HQ0/2Y0CWsEer+z/8+6G8uW/jrB6rHD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VnDUTX+2ON+KD9FPoyxYsSYtZt0fFO/i6m06G1aKvu4JKWae9UZR+ArxG3rU/SRc4
         BaNpN739QbHT+utQMFzXnDi6guk6Ofylj1XHK6h+swRz1IWopVlhM2cr68udZSLkhb
         Q9WrvRmOsi5KQosBf86BKsvJSbtpR3Fqe7gX/3Gs63z3rVue0l772VPq6FT7Qhj3nH
         W6g+/LMReottOA8WF9ZJbwuQjEXLQzqLLcVIoZZisOpqSZR1WoL3Xstr7GwlIhK2Zn
         mfT4wkJ/4KI5WhCyghv228sDdn4G86Jz4x7HeFwLwZdLi73v+BiMnpTiWc53BZqz6b
         kGyYW2Hzpa1qA==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     damon@lists.linux.dev, linux-damon@amazon.com,
        linux-damon-trial@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: DAMON Beer/Coffee/Tea chat series
Date:   Tue, 18 Oct 2022 16:59:58 +0000
Message-Id: <20221018165958.82803-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220810225102.124459-1-sj@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

The meeting was scheduled for yesterday 18:00 PDT, but I forgot that.  Sorrry
for my bad memory.  It's very volatile and easily corrupted.  I will try to
sanitize it next time.

For people who prefer the time zone, I will change the time of next meeting
from Tuesday 09:30 PDT to Monday 18:00 PDT.  So, the next meeting will be at
2022-10-31 (Mon) 18:00 PDT, Google Meet (https://meet.google.com/ndx-evoc-gbu).

Sincere apology again.  I may prepare some sweets for you ;)


Thanks,
SJ
[...]
