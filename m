Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCB46EB266
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 21:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbjDUTpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 15:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbjDUTpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 15:45:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DC2198B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 12:45:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33EF06528E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 19:45:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321FCC433D2;
        Fri, 21 Apr 2023 19:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682106328;
        bh=LVD0h2MtRQCLv9fYsPYzBh7vUpnhSB9kiT4aJ/lcBb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bVmb4l0Cx3p3Qxeaw2ncyf3e8Kq1WYdBBcgoCJFvQXRLas9GNORBD0ly8URnWiULT
         nSntdG0AnVlkUaZrsqQC2BgW2vAv75KaaRkh2Ll/+soE6XU1rrp7+Pj4Fv3MZ0RDg+
         StOGYeyV5kxFTJjQ7DrWuGjE4z8hJNcTAKJ1AuwooLJdHQs9P6lbOrtrfGJVI+w78D
         RDxywFgLb+qhbfBzHd/6E5964j7AIEo/8j6JDr2VqvX/z/3qmYkYxbSThgfXbMrHY+
         J0q3V0on9kslCS4GaUdQD0RUVYvVRPOojH6AisJVOTE1nN5SQGFIhcFwmsRcHMpjUZ
         kdxNdWAIeBfVA==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     damon@lists.linux.dev, linux-damon@amazon.com,
        linux-damon-trial@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: DAMON Beer/Coffee/Tea chat series
Date:   Fri, 21 Apr 2023 19:45:26 +0000
Message-Id: <20230421194526.81736-1-sj@kernel.org>
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

The last instance was scheduled for Tuesday of this week, but I forgot the
schedule by my mistake.  Sorry if you wanted to join.  I therefore schedule
another instance for next Tuesday.  Please check the agenda doc for the updated
schedule.

Sorry again.


Thanks,
SJ
