Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF9D74E7C4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 09:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjGKHQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 03:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjGKHQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 03:16:49 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBEA8A9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 00:16:48 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 36B7GiaC030699;
        Tue, 11 Jul 2023 09:16:44 +0200
Date:   Tue, 11 Jul 2023 09:16:44 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     linux-kernel@vger.kernel.org, Zhangjin Wu <falcon@tinylab.org>
Subject: Re: [PATCH v2] tools/nolibc: completely remove optional environ
 support
Message-ID: <ZK0B3Ekik+rKEyDj@1wt.eu>
References: <20230710-nolibc-environ-v2-1-78b0c465338f@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230710-nolibc-environ-v2-1-78b0c465338f@weissschuh.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 08:01:34PM +0200, Thomas Weißschuh wrote:
> In commit 52e423f5b93e ("tools/nolibc: export environ as a weak symbol on i386")
> and friends the asm startup logic was extended to directly populate the
> "environ" array.
> 
> This makes it impossible for "environ" to be dropped by the linker.
> Therefore also drop the other logic to handle non-present "environ".
> 
> Also add a testcase to validate the initialization of environ.

Thank you Thomas, now pushed to the same branch.

Willy
