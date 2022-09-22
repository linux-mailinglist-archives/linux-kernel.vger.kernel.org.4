Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4BA5E6D32
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiIVUmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiIVUl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:41:58 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209C32BE00;
        Thu, 22 Sep 2022 13:41:57 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id 61F02383;
        Thu, 22 Sep 2022 20:41:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 61F02383
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1663879316; bh=PZG8nySConFBxhII2ii0HgQoWMF0cqH4FrvUSWi+4tU=;
        h=From:To:Cc:Subject:Date:From;
        b=NPKDyMv11zy6OfWQcGsITdNDqtemY1mYl7kvL9sE2jqN/Kw4Y6xPisraHiQS8KwrN
         SAqtHzPjdqVnvVApFJPprig42xBawYPA4JPOaj67y07iAvGZlSGlONkRC6YUvtYxpS
         lbJOBrG7uB+cP0o5CylWKbvvZytRfgM/7+AnVQZCRr8vr4SkkWXs3YcgD4JUsBT4Rv
         /fBFXUCjq6xDTbH22xYuNfpDRg7TWh9ZaCNVRxl4idxuKfALAx//V9UKp9P/gET9Yk
         BAba4WGORtBQr83w7hnojFxpM4cNmDK0hy83yO9DjSYkFg9E+G8sXa5Mp5G+7rWNCi
         FjNJUDxRytGbw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 0/4] Rewrite the top-level index.rst
Date:   Thu, 22 Sep 2022 14:41:31 -0600
Message-Id: <20220922204138.153146-1-corbet@lwn.net>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The top-level index.rst file is the entry point for the kernel's
documentation, especially for readers of the HTML output.  It is currently
a mess containing everything we thought to throw in there.  Firefox says it
would require 26 pages of paper to print it.  That is not a user-friendly
introduction.

This series aims to improve our documentation entry point with a focus on
rewriting index.rst.  The result is, IMO, simpler and more approachable.
For anybody who wants to see the rendered results without building the
docs, have a look at:

  https://static.lwn.net/kerneldoc/

Those pages are rendered with the "Book" theme, which pays attention to the
html_sidebar directive.  I am not proposing a switch to that theme (I just
picked it at random), but I do think we should reconsider the default theme
at some point - or just create our own theme.

This is only a beginning; I think this kind of organizational effort has to
be pushed down into the lower layers of the docs tree itself.  But one has
to start somewhere.

CHANGES from v1: I've tried to address the comments from v1, further
cleaning up the front page.  I've added the "reporting issues" and "kernel
testing" documents there, and done a bit of cleanup.  There is plenty more
yet to be done.

Unless I get screams I plan to slip this into 6.1.  It is definitely not
the final form of the front page, but I doubt we'll ever get there; we can
change it in whatever ways make sense.

Jonathan Corbet (7):
  docs: promote the title of process/index.html
  docs: Rewrite the front page
  docs: reconfigure the HTML left column
  docs: remove some index.rst cruft
  docs: move asm-annotations.rst into core-api
  docs: Expand the front-page CPU-architecture section
  docs: put atomic*.txt and memory-barriers.txt into the core-api book

 Documentation/conf.py                         |   3 +-
 .../{ => core-api}/asm-annotations.rst        |   7 +-
 Documentation/core-api/index.rst              |   4 +
 .../core-api/wrappers/atomic_bitops.rst       |  18 ++
 Documentation/core-api/wrappers/atomic_t.rst  |  19 +++
 .../core-api/wrappers/memory-barriers.rst     |  18 ++
 Documentation/index.rst                       | 154 ++++++------------
 Documentation/process/index.rst               |   1 +
 Documentation/staging/index.rst               |  42 -----
 Documentation/subsystem-apis.rst              |  58 +++++++
 10 files changed, 172 insertions(+), 152 deletions(-)
 rename Documentation/{ => core-api}/asm-annotations.rst (97%)
 create mode 100644 Documentation/core-api/wrappers/atomic_bitops.rst
 create mode 100644 Documentation/core-api/wrappers/atomic_t.rst
 create mode 100644 Documentation/core-api/wrappers/memory-barriers.rst
 create mode 100644 Documentation/subsystem-apis.rst

-- 
2.37.2

