Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB286E1DD8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjDNIMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjDNIME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:12:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A765B8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 01:12:03 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B53BB219BA;
        Fri, 14 Apr 2023 08:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681459921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b/O0ymfBIYoLmIJ1onnswDyLlhMcwo8UOm63k2V8FeE=;
        b=iwTPtsV5tBGYYv75ZphmWd06rDJZANbTqJQwhPMm38xt1i3EFXvjs801qABTyIB44uCGzD
        BbkpuwPgUyBF417Fl0M9+oSaZelYiYZ1/gtLotlQGy0VMkRVIFQXfVYBfHzrGeRxEWyA0y
        XW/61YNDLG2voE5KHehvIh40ofLMkcU=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E43662C143;
        Fri, 14 Apr 2023 08:12:00 +0000 (UTC)
Date:   Fri, 14 Apr 2023 10:11:57 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Cc:     Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] printk: Export console trace point for
 kcsan/kasan/kfence/kmsan
Message-ID: <ZDkKzQCM1gJnVBdO@alley>
References: <20230413100859.1492323-1-quic_pkondeti@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413100859.1492323-1-quic_pkondeti@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-04-13 15:38:59, Pavankumar Kondeti wrote:
> The console tracepoint is used by kcsan/kasan/kfence/kmsan test
> modules. Since this tracepoint is not exported, these modules iterate
> over all available tracepoints to find the console trace point.
> Export the trace point so that it can be directly used.
> 
> Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>

Makes sense. From the printk side:

Acked-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
