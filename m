Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F17A66A738
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 00:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjAMXrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 18:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjAMXrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 18:47:32 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2934D4B3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 15:47:31 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id g23so9377597plq.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 15:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g2vzzTSH5S57Wrqyr1C9oVjx+on+484XTk68fOM/j/c=;
        b=giYpFdLflye1WI0EUrCinm2NviDsoDh/JcHzHt45N4mNHndm+d5s7Fu6GlJV9wpOI3
         vMzmtTx6riqK8nJpLRxKVnndouHKkq2pE4DG8rwVhQ8xTqX8vDMJJqiONeFlarM8FwfR
         gUUxFdQP9RcTJjLwtIrxhN9jRWOAw6ZjpUEsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g2vzzTSH5S57Wrqyr1C9oVjx+on+484XTk68fOM/j/c=;
        b=UlzmMHST1g8DiLDRLDEwoctw3eL57B2vw50WnfzUcN+CgPSjUqKwj9OrlEAdcCUgUC
         U98W4lKJPrRZuEOZ114OMg5nnDmpWBswjpbwJ9QgfvadaTS6iJHoXaGrIqoEXXnj+K4X
         sISmXkTEYqrhnGOMeBaSF457JLbzhlRgr5Foig/qvdu7VPJHve8wh7V/BCKZ4uPepkKv
         2QJ9VTssPXUhhXx9TLwp4GLU07zKcwdlasUC4d6JmO+INW0Ry6HsXsmGMtiRJUiWlRsp
         sXE/0ivwRxg2THYTIubWsQitC9rbE/ISXKBOxKbsLgXtxJeeRkuQOnBBn1hcuQLspsEd
         pbcg==
X-Gm-Message-State: AFqh2krtsXnvA+YLqfulI72trpf7mp1wuSqCKRFvGU2sMF2MsM109w0/
        lcmOFm9qT3ByANzwLQkeImmr3g==
X-Google-Smtp-Source: AMrXdXua3ahnJrXVTD6N185pH/PtMtbliyTXjbCxzwwcMR7xNlL7XXVlPaA6+SCByiegM8HiaDiCug==
X-Received: by 2002:a17:902:b414:b0:190:fe60:48c4 with SMTP id x20-20020a170902b41400b00190fe6048c4mr11465497plr.21.1673653650812;
        Fri, 13 Jan 2023 15:47:30 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902654c00b00189422a6b8bsm14725368pln.91.2023.01.13.15.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 15:46:47 -0800 (PST)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Fri, 13 Jan 2023 15:46:27 -0800
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: console_prepend_dropped(): Memory - corruptions
Message-ID: <202301131544.D9E804CCD@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This is an experimental semi-automated report about issues detected by
Coverity from a scan of next-20230113 as part of the linux-next scan project:
https://scan.coverity.com/projects/linux-next-weekly-scan

You're getting this email because you were associated with the identified
lines of code (noted below) that were touched by commits:

  Wed Jan 11 15:35:11 2023 +0100
    c4fcc617e148 ("printk: introduce console_prepend_dropped() for dropped messages")

Coverity reported the following:

*** CID 1530570:  Memory - corruptions  (OVERRUN)
kernel/printk/printk.c:2738 in console_prepend_dropped()
2732     		/* Truncate the message, but keep it terminated. */
2733     		pmsg->outbuf_len = outbuf_sz - (len + 1);
2734     		outbuf[pmsg->outbuf_len] = 0;
2735     	}
2736
2737     	memmove(outbuf + len, outbuf, pmsg->outbuf_len + 1);
vvv     CID 1530570:  Memory - corruptions  (OVERRUN)
vvv     Overrunning buffer pointed to by "scratchbuf" of 1024 bytes by passing it to a function which accesses it at byte offset 1998 using argument "len" (which evaluates to 1999). [Note: The source code implementation of the function has been overridden by a builtin model.]
2738     	memcpy(outbuf, scratchbuf, len);
2739     	pmsg->outbuf_len += len;
2740     }
2741     #else
2742     #define console_prepend_dropped(pmsg, dropped)
2743     #endif /* CONFIG_PRINTK */

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1530570 ("Memory - corruptions")
Fixes: c4fcc617e148 ("printk: introduce console_prepend_dropped() for dropped messages")

Thanks for your attention!

Human notes from Kees:

I'm not sure how it got 1998, but I do see that snprintf() should
probably be scnprintf(), otherwise "len" might be a lie (i.e. it'll hold
what it WANTED to write, rather than what it actually wrote).

-- 
Coverity-bot
