Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9E96D424F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 12:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjDCKko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 06:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbjDCKkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 06:40:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D1183C1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 03:39:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 858D91FDD6;
        Mon,  3 Apr 2023 10:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680518383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Za7Mw6AhwiXl3SjE2sax9Qu/fK3MG3aPrSrkeX6F63Q=;
        b=GgzUFUtdB02Iast0KzdplKhBzRFuK/3dvWScsjhwaf3iYVYnVqu+rxwDHHKTAoYcXbeySt
        jrrsFkA6YzMOMh0YZpTacwLL664rdQNqM7za7l8/YA0XmqlmH0A0Cm1Cnn15xaI6M4JgDR
        EksN5Zo8CJHuSXwm5ei2XCGzBsOJo14=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 282142C1BF;
        Mon,  3 Apr 2023 10:39:42 +0000 (UTC)
Date:   Mon, 3 Apr 2023 12:39:39 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1 1/1] lib/vsprintf: Use isodigit() for the octal number
 check
Message-ID: <ZCqs6yt3nID5wuqF@alley>
References: <20230327142721.48378-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327142721.48378-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-03-27 17:27:21, Andy Shevchenko wrote:
> Use isodigit() to test the octal number instead of homegrown approach.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

JFYI, the patch has been committed into printk/linux.git,
branch for-6.4.

Best Regards,
Petr
