Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F76362694E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 13:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbiKLMBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 07:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiKLMBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 07:01:12 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBFB8167FC
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 04:01:11 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 2ACC19ug005595;
        Sat, 12 Nov 2022 13:01:09 +0100
Date:   Sat, 12 Nov 2022 13:01:09 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     A <amit234234234234@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Setting variable NULL after freeing it.
Message-ID: <20221112120109.GA5592@1wt.eu>
References: <CAOM0=dbwNs1XcnD0i+SrC1S-SNFEGXM5G8QrVCqAxaz=YkAEFg@mail.gmail.com>
 <20221112074759.GA5111@1wt.eu>
 <CAOM0=daopCt=LthGStL2zHYxgQ6iphLLfKZjxcPS07yCvyq42Q@mail.gmail.com>
 <20221112113410.GA5553@1wt.eu>
 <CAOM0=dbuPP1j7MYkZCxbXQKxUsjeO0QXfE_g-xapFXYSpCAgXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOM0=dbuPP1j7MYkZCxbXQKxUsjeO0QXfE_g-xapFXYSpCAgXw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 05:28:04PM +0530, A wrote:
> I was just thinking that when this is good practice (where its usage
> is genuine), then why is there not a kernel wide macro that would call
> kfree(x) and then set (x) = NULL. So, this will be done automatically
> for everyone and the developer will not have to decide whether to do
> this or not.

Very likely because developers want to decide.

Willy
