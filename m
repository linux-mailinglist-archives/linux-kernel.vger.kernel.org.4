Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D176A63D1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 00:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjB1XeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 18:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjB1XeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 18:34:05 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3509522DE2;
        Tue, 28 Feb 2023 15:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eYRPbolxvul9yxCvDcoLXgPD+xvpcvLk1UIxf5oQw38=; b=CdjuAwCupgJ0HlY9J701DbnCrc
        qV4D5k++WihGzn715poV0tBkFmDGbOp7ANAnD02v2ZZ4KuqJU0GQm8QCtMoiypqCFcEk5n6REAcLq
        oCh8gAxM3adhbUUeCfJ154pDUUvBxS55DbAiCqvyDBfi2UyzjFNHhJhVqSb26r45b45pXo8Jz8UKz
        pjMgPQzISd5o0T3kqmVnD/QLx/DKX0tYkKTHMUMGXu/tHKAUbuWDyWyDLLct+Eelvk9kCGwaUtTO2
        sddWQZnTdnoWUn/pSFrNWvBmWeRw25DN/dq7cvD0Li4ryKhuCfQx88gCiOeAAlzp3BQiqyAEwafiK
        dE86TzhQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pX9Ts-00Ea2J-Lz; Tue, 28 Feb 2023 23:34:00 +0000
Date:   Tue, 28 Feb 2023 15:34:00 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Jason Baron <jbaron@akamai.com>
Cc:     jim.cromie@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 2/2] dyndbg: use the module notifier callbacks
Message-ID: <Y/6PaKLz1HlbQm/o@bombadil.infradead.org>
References: <cover.1677612539.git.jbaron@akamai.com>
 <a775dcc14a10d0b3df34e087ee29ddb1d62fb517.1677612539.git.jbaron@akamai.com>
 <Y/5ntkYoKHvfU9S8@bombadil.infradead.org>
 <c0c38c08-a329-9d0a-ca75-0519b589731e@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0c38c08-a329-9d0a-ca75-0519b589731e@akamai.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 04:56:59PM -0500, Jason Baron wrote:
> Ok, I can fix up the commit message and re-post. I'm thinking maybe we
> should separate these patches as they are independent. The 2nd one I think
> makes sense to go through modules-next, but the first one is internal to
> dynamic debug and can be a part of Jim's series. Make sense?

Sure but you may want to take a look at modules-next, does that patch
apply without any issues there? I have yet to rebase as v6.3-rc1 is not
out yet.

  Luis
