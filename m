Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC536C04AE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 21:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjCSULi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 16:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjCSULa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 16:11:30 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D8DD166F1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 13:11:26 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 32JKBJ7L000367;
        Sun, 19 Mar 2023 21:11:19 +0100
Date:   Sun, 19 Mar 2023 21:11:19 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] tools/nolibc: always disable stack protector for
 tests
Message-ID: <ZBdsZ61bt7aLdbSo@1wt.eu>
References: <20230319135100.31952-1-w@1wt.eu>
 <5c2fdd86-4e6a-4f48-ab57-95a223f39e94@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c2fdd86-4e6a-4f48-ab57-95a223f39e94@paulmck-laptop>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Sun, Mar 19, 2023 at 11:05:15AM -0700, Paul E. McKenney wrote:
> Queued and pushed, thank you both!

Thank you!

> Just to make sure I understand, you would like me to add this to the
> serieses from Vincent, yourself, and Feiyang that are set up to go into
> the next merge window, correct?
> 
> If you instead would like me to push it to Linus directly into the v6.3
> release as a regression fix late this coming week, please let me know.

It would indeed be preferable for 6.3 as it fixes issues, but it's not
critical at all, just an annoyance for some developers. So if you have a
series of fixes pending to be sent soon, it would be nice to add it there.

Thanks!
Willy
