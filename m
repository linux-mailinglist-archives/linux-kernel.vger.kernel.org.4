Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786CA70FBB1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 18:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjEXQaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 12:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjEXQaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 12:30:14 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 492DB123
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 09:30:12 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 34OGUCX1024803;
        Wed, 24 May 2023 18:30:12 +0200
Date:   Wed, 24 May 2023 18:30:12 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: s390: disable stackprotector in _start
Message-ID: <ZG47lJR+mRwtTfeQ@1wt.eu>
References: <20230524-nolibc-stackprotector-s390-v1-1-5044d42230cc@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230524-nolibc-stackprotector-s390-v1-1-5044d42230cc@weissschuh.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 06:27:06PM +0200, Thomas Weißschuh wrote:
> s390 does not support the "global" stack protector mode that is
> implemented in nolibc.
> 
> Now that nolibc detects if stack protectors are enabled at runtime it
> could happen that a future compiler does indeed use global mode on
> and nolibc would compile but segfault at runtime.
> 
> To avoid this hypothetic case and to align s390 with the other
> architectures disable stack protectors when compiling _start().
(...)

Queued, same branch. Thanks Thomas!
Willy
