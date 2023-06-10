Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD8D72AEBC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 22:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjFJUk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 16:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjFJUky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 16:40:54 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708E226B2;
        Sat, 10 Jun 2023 13:40:53 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 462AD320005D;
        Sat, 10 Jun 2023 16:40:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 10 Jun 2023 16:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1686429648; x=1686516048; bh=SKMdRs57+W2fpRqekdSA2J6KD
        xjMwUiujtGE7TR4ltw=; b=iWSZtvr/wOJi0wlhO3pBcPbc+O5csKxNy6ZbBr6/z
        sQuqXbv5mfP0nj9uydkrJEq4GNZ+AxtBqM/XymTVq27Kdibbg/owykCcv2gYWewB
        feBmyp1jWsd3nkXfusn5kg4Xcmp7M1BAqpaymmOe0MTJOXGLXXfz8FKTYc7oheOo
        taQ5XDo0EIWBmHvd2CA6OjrxBqSEmPjU8JyPzREcdXBZZl5R+aMRBDRgAAmSdgEs
        YyZz/bo/SvXLUYg7leX96R0SxnuazEe6FFgvF0ebzXF7zl0Z76fjkKbKW7H2La7k
        GR5HBBfHmKEb92JHZAvTA97AUpglt5ii8fyEJMOOyKakw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1686429648; x=1686516048; bh=S
        KMdRs57+W2fpRqekdSA2J6KDxjMwUiujtGE7TR4ltw=; b=fXqsplFSR3vCtQ1Du
        ZRvZCdC67ZvOFOo8dxrJS/LitSkCOqrS2Bwb1GD+RXO8dpwBNlP+aizdvyTmHkGA
        Wwu4ydoBuAEptGbMW9mpArx5tJ6fw3m50wSk0TpwHmjQe5AylLx13Ywah7pBMjm6
        sdIuyg1FU6djI3vFdK2FnC9l9FpYyDltVZKzdT13Lcg9Nzp0mtnjIHBIAxDB9wLq
        vNuZjUyY0GB4WOr+WfZ5UAyajb5FuLWLmDlHpnDUScGqFu6yTw0r5+KW15MJxRNy
        49Ns03EpS3wS59qnR3WdZaTF6CTsIM0nMlfTHM1flevecgOkEhQ+XrGUmLBzLskm
        bt+tg==
X-ME-Sender: <xms:0N-EZHE28bKOS_BDZcTjrI9xzTY8_XVqw7j4O_-wIKFwuLGAAqx8vw>
    <xme:0N-EZEXQv120A19dUqz1BCo0_Wp-KR46xw4aRcXnPaABTL9q13w-B0U0NLyH6d9G7
    Q5PUlyuRidk4ZU>
X-ME-Received: <xmr:0N-EZJIDxgyleXZnSjojmQp4pbMXm0w9SWoQa05YmDO2t0XIJLFlo0W_MgCMu9VNsDh5W85N3o0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedutddgudehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhephfeggfeiiedtieejgedutdekgfet
    geehheegteekvefhfefgudehtdevleegueegnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:0N-EZFEdAIMpkoYOZPDwOxPXRYu3Efr0FabEfN_gX5zR5xVVxLMW8Q>
    <xmx:0N-EZNUFU2I3xGNMMpRyUBeepQMk9IMYbTyHo1CiFv708Tb9F1f-rQ>
    <xmx:0N-EZAN22QtxcPAU5fhgVVgxhOe0k3sL0CyRZpP75dgNKF2jisGtEA>
    <xmx:0N-EZEMSXPqId6b1xaUr-sV7wuz4AWCS4ZOEVjfCTdWySqPWoVu9yA>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Jun 2023 16:40:47 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Lee Jones <lee@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH v3 0/4] Make sscanf() stricter
Date:   Sat, 10 Jun 2023 16:40:40 -0400
Message-Id: <20230610204044.3653-1-demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Pau Monné suggested making xenbus_scanf() stricter instead of
using a custom parser.  Christoph Hellwig asked why the normal vsscanf()
cannot be made stricter.  Richard Weinberger mentioned Linus Torvalds’s
suggestion of using ! to allow overflow.

Changes since v2:

- Better commit messages.
- Fix a compile error in simple_strtoll() (found by 0day bot).
- Fix an uninitialized variable (found by Dan Carpenter).

Changes since v1:

- Better commit messages.
- Use ! to explicitly opt-in to allowing overflow.
- Treat overflow as a conversion failure instead of returning ERANGE.
- Drop the first patch (removal of simple_strtoll()) as it breaks
  bcache.
- Stop skipping spaces in vsscanf() instead of adding a separate
  vsscanf_strict() function.

Demi Marie Obenour (4):
  limits.h: add UCHAR_MAX, SCHAR_MAX, and SCHAR_MIN
  vsscanf(): Integer overflow is a conversion failure
  vsscanf(): do not skip spaces
  Reject NUL bytes in xenstore nodes

 .../hive_isp_css_include/platform_support.h   |  1 -
 drivers/xen/xenbus/xenbus_xs.c                | 17 +++-
 include/linux/limits.h                        |  1 +
 include/linux/mfd/wl1273-core.h               |  3 -
 include/vdso/limits.h                         |  3 +
 lib/vsprintf.c                                | 98 +++++++++++++------
 6 files changed, 86 insertions(+), 37 deletions(-)

-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

