Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4ED63AEC1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbiK1RWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbiK1RVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:21:50 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C18218E2E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:21:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A0A94CE0F99
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 17:21:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFA3C433D6;
        Mon, 28 Nov 2022 17:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669656104;
        bh=TyPpfAWkaDgtWxdnYimbzfMlZJGlJ+ZXmhBXeP2ilQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dHaQJaP9VBsqcBayryYF/HinrdXV7jkLshA+U/eReLNdXc0YWDI4cKSvF6M8mbmDZ
         vc0PXMnO63Tfdjgs3oQFY2CPoADgOeYEv4iYz1h8mq34u4kM6S8m4g0MkwwM9VPOpX
         liEbT0Bg48TfXgCON64oDj88HTbf727TbyIbp+kKszE0fTdz8gTDqddNQTXzKWHyaK
         faJcE0qcTSOGlveMjh1Kqz4Md8X25/xpZR5xIu9cLQF8Xue0TQSg4fnfm25f3HvbzP
         Xt5EChCKhKPVN6uZ4qjVmwH5qm7q6StUILcSNENQlx2qYjh7NOu/hqS53As6p1KUzd
         of+RZNRBaVVTw==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     damon@lists.linux.dev, linux-damon@amazon.com,
        linux-damon-trial@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: DAMON Beer/Coffee/Tea chat series
Date:   Mon, 28 Nov 2022 17:21:42 +0000
Message-Id: <20221128172142.5402-1-sj@kernel.org>
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
> 
> First instance: 2022-08-15 18:00 PDT
> Second instance: 2022-08-30 09:00 PDT

This is a reminder for the next instance of the chat series.  Next instance
will be 2022-11-28 (Mon) 18:00 PST, so about nine hours after now.  You can
show proposed agendas for the chat, or propose your own using the above Google
doc.  Hope to meet some of you :)


Thanks,
SJ
