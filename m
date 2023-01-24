Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BED67A6A4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 00:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbjAXXGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 18:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjAXXGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 18:06:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0994AA63
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 15:06:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4AF3B81717
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 23:06:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED762C433EF;
        Tue, 24 Jan 2023 23:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674601610;
        bh=s7pIW0jia0g5VIFzcKgT/jLZ3jSOURjQa383hJ8aYqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fg1YSiGUjN1zndovtoikiu0vqfEKGhRoqrNvGkbdoMwNlVXslB0X9fhYdmjB060pP
         ucdwamaTozqkicBefjY1B865QF7EJ3BE+wIe0dao1RUWbnAb7UxO8mldV739t5HlwX
         SyHqp1ltDgVhntqGkVlqwkURt4ywFhFKyvDu6lOwFtwREiXGa4wgYABxmU6gX59cID
         VI/7V2kZxb6cDAVb+Fzh90sucX8kqvMFZGUhoX6HBiKhwouYhaGg1R9vIf1BHdYBzN
         Hd/1YX1zGc/ua5r3MbE8sNG5bsR4Zt5TtVriUELvhyd/jMSfL6YIZi1WPphLSiMEPk
         ZeBLuMbs+EWug==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     damon@lists.linux.dev, linux-damon@amazon.com,
        linux-damon-trial@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: DAMON Beer/Coffee/Tea chat series
Date:   Tue, 24 Jan 2023 23:06:48 +0000
Message-Id: <20230124230648.113669-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230124014421.112436-1-sj@kernel.org>
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

On Tue, 24 Jan 2023 01:44:21 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hello,
> 
> On Wed, 10 Aug 2022 22:51:02 +0000 SeongJae Park <sj@kernel.org> wrote:
> 
> > Hello,
> > 
> > 
> > In short, I'd like to start an open, regular, and informal virtual bi-weekly
> > meeting series for DAMON community.
> > 
> > Important links and dates
> > -------------------------
> > 
> > Location: https://meet.google.com/ndx-evoc-gbu
> > Agenda: https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing
> 
> This is a reminder for the next instance of the chat series.  Next instance
> will be 2023-01-23 (Tue) 09:30 PST.  You can show proposed agendas for the
> chat, or propose your own using the above Google doc.  Looking forward to see
> you after about 15 hours for the first time in the new lunar year :)

If you tried to but couldn't join today meeting, that's not you or system's
fault but mine.  I was out of mind this morning due to some other urgent things
and therefore couldn't attend, sorry.

Let's have yet another one instance for next Tuesday morning (PST), so
2023-01-31 (Tue) 09:30 PST.


Thanks,
SJ

> 
> 
> Thanks,
> SJ
> 
