Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6380D5B8F5C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 21:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiINTwT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 14 Sep 2022 15:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiINTwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 15:52:18 -0400
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531105E32C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 12:52:17 -0700 (PDT)
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id 608F8C09E1;
        Wed, 14 Sep 2022 19:52:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id 5E0632002D;
        Wed, 14 Sep 2022 19:52:14 +0000 (UTC)
Message-ID: <70435cc384259c78afc52dc90a7b7f4953083824.camel@perches.com>
Subject: Re: [PATCH v1 1/1] kernel.h: Split the hexadecimal related helpers
 to hex.h
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
Date:   Wed, 14 Sep 2022 12:52:13 -0700
In-Reply-To: <20220914170809.34651-1-andriy.shevchenko@linux.intel.com>
References: <20220914170809.34651-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 5E0632002D
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Stat-Signature: inm37xcu8ux5uxsw9z17m3a9d11uxmbz
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19yQQBRQqcuuJP3HlrxrBsXr8NfUTxDWV4=
X-HE-Tag: 1663185134-507885
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-09-14 at 20:08 +0300, Andy Shevchenko wrote:
> For the sake of cleaning up the kernel.h split the hexadecimal
> relted helpers to own header called 'hex.h'.

related

> diff --git a/include/linux/hex.h b/include/linux/hex.h
[]
> +bool mac_pton(const char *s, u8 *mac);

This one should likely stay in kernel.h unless and until
a more suitable place is found for it.

