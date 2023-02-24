Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0442F6A2084
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 18:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjBXRgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 12:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBXRgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 12:36:44 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46F756A78D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 09:36:42 -0800 (PST)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 31OHaejS025901;
        Fri, 24 Feb 2023 18:36:40 +0100
Date:   Fri, 24 Feb 2023 18:36:40 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Valerio Vanni <valerio.vanni@inwind.it>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Bugzilla 217083
Message-ID: <Y/j1qPOZm90d7Oi1@1wt.eu>
Reply-To: linux-kernel@vger.kernel.org
References: <f4d6ddad-90c7-8a59-4f1f-334ae5e38463@inwind.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4d6ddad-90c7-8a59-4f1f-334ae5e38463@inwind.it>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 06:30:27PM +0100, Valerio Vanni wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=217083

Placing a descriptive subject and a summary here will certainly
encourage more readers to read your report. You should repost
with the subject you used there:

   Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00 

and it's useful to mention the version ranges you've spotted (4.19-5.10).

Just my two cents,
Willy
