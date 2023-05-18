Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A0C708809
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 20:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjERSxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 14:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjERSxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 14:53:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8480C7
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 11:53:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64FBA614CA
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 18:53:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CEDC433EF;
        Thu, 18 May 2023 18:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684436014;
        bh=thqrSXP2BC4DJH528QS5GyiNrs8cMPzkwGyIFD1nCJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J5diEBTFWPRmnysYUv7xoYJby573VfnCZMCzKJqPQjQvhPcDvP/omE39ca3hW/UWR
         qELgAtdtA/F95wW/eszgom61yzzy1jE0kU1PNHbd+tYS+5sk+MSP7HvaT3KVCbxopa
         UGU0nErFkIlBLPTsWvrp2G97V2kQnNnwaL8T3b+7NaPCtTRJimeuJzFufVAaFAmOSV
         tjvTZczt5ek+xcz4tRYEbq+Erhtkqsihmgd+5vVKRERtwYrBmDeuUyQsHFt6GplBKc
         pbgjFquYxtd4Zg423XCF2SESfsrpCFmumjjAqBJ6Z+OOxgcleo8rcoumwM9NbVzRjs
         Q9e40buk8enLA==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     damon@lists.linux.dev, linux-damon@amazon.com,
        linux-damon-trial@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: DAMON Beer/Coffee/Tea chat series
Date:   Thu, 18 May 2023 18:53:32 +0000
Message-Id: <20230518185332.84180-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220810225102.124459-1-sj@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

The next instance was originally scheduled ror 2023-05-29.  But I realized it's
a holiday in USA.  So I rescheduled it to 2023-05-30.  Please refer to the
Agenda doc whenever you unsure the schedules.


Thanks,
SJ
