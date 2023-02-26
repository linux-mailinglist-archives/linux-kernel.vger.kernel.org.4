Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2396A33A8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 20:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjBZTfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 14:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjBZTfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 14:35:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9EFFF1B
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 11:35:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E68E3B80C82
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 19:35:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37519C433EF;
        Sun, 26 Feb 2023 19:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1677440116;
        bh=KanthtavbaTElqnrhLtx2la6P52pYyOcpsYV7O0BfT0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YmvmAV8s9B1S7J1cy5wRwKamJ6c/g92oCcQWkdWEVwMWLxdi5IcnBaIUs3h2ExkGB
         3FqIZhVMgsDGS6wgJapoPX3wyvSiwrvc9AZMha1bvj0CrtrCW2GbEXRbh/0Q693LPR
         sQvJ7B23pnaG4zPhBNlYsNEVgJNs072zLvDG8H/g=
Date:   Sun, 26 Feb 2023 11:35:15 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     development@efficientek.com
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-um <linux-um@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Johannes Berg <johannes@sipsolutions.net>,
        Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Subject: Re: [PATCH v2 0/2] GDB: Support getting current task struct in UML
Message-Id: <20230226113515.841f43730e4842f6c20b5999@linux-foundation.org>
In-Reply-To: <20230226004503.1856e58d@crass-HP-ZBook-15-G2>
References: <cover.1676532759.git.development@efficientek.com>
        <20230223131402.6d6a662f76348b14574121d3@linux-foundation.org>
        <20230226004503.1856e58d@crass-HP-ZBook-15-G2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Feb 2023 00:47:19 -0600 Glenn Washburn <development@efficientek.com> wrote:

> Would you like me to resent the series rebased onto v6.2?

Yes please ;)  Against current linus tip if possible.
