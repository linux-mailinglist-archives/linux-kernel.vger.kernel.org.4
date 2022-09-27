Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FAD5EC909
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbiI0QH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbiI0QH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:07:29 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5DE43320;
        Tue, 27 Sep 2022 09:06:12 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id 6EF592CD;
        Tue, 27 Sep 2022 16:06:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6EF592CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1664294771; bh=cpEaxdavHFj4y7lVK+KQLP5v0STRabx9CP3VXBZcckA=;
        h=From:To:Cc:Subject:Date:From;
        b=fVlk5enq6NLM3PLOX23ewLcpw5rzr3aKDkkpKOYNlqKZUbgcU0HkzQmgQf2241UiZ
         MmQpU/Io/yK8Zef/05LIqxe2K0AiHAftmoelabbEspuvz7ucYl5G3uLbtRoK+JJHMK
         Leo7IO9yExITVV38L9xpnPufHdXGdtjwzK7fp9i26oqh5V+3OerbUokJO641YLuN3z
         33dxf4p7ayugD8t1sqvRxx9L6lWqni3YT377yR58Bo8t5XVKiFXfRTRHTzscPwChgS
         l+ASrWPPXnOBuULJ3YLeK/U36z98EBDCxBit6vb/7AlXlD/iKPWFMQkoBU32HoN6oJ
         c9gpPUxcRKdiw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joe Perches <joe@perches.com>,
        David Vernet <void@manifault.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 0/7] Rewrite the top-level index.rst
Date:   Tue, 27 Sep 2022 10:05:52 -0600
Message-Id: <20220927160559.97154-1-corbet@lwn.net>
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

This time around I've rendered the pages using the "Read The Docs" theme,
since that's what everybody will get by default.  That theme ignores the
directives regarding the left column, so the results are not as good there.
I have a series proposing a default-theme change in the works, but that's a
separate topic.

This is only a beginning; I think this kind of organizational effort has to
be pushed down into the lower layers of the docs tree itself.  But one has
to start somewhere.

CHANGES from v2: now with less sloppiness.  I've tried to respond to all of
the review comments.  scripts/checkpatch.pl has been updated to match the
new location of asm-annotations.rst.  There is also now a link to the man
pages in the user-oriented documentation section.

CHANGES from v1: I've tried to address the comments from v1, further
cleaning up the front page.  I've added the "reporting issues" and "kernel
testing" documents there, and done a bit of cleanup.  There is plenty more
yet to be done.


Jonathan Corbet (7):
  docs: promote the title of process/index.rst
  docs: Rewrite the front page
  docs: reconfigure the HTML left column
  docs: remove some index.rst cruft
  docs: move asm-annotations.rst into core-api
  docs: put atomic*.txt and memory-barriers.txt into the core-api book
  docs: add a man-pages link to the front page

 Documentation/conf.py                         |   3 +-
 .../{ => core-api}/asm-annotations.rst        |   7 +-
 Documentation/core-api/index.rst              |   4 +
 .../core-api/wrappers/atomic_bitops.rst       |  18 ++
 Documentation/core-api/wrappers/atomic_t.rst  |  19 +++
 .../core-api/wrappers/memory-barriers.rst     |  18 ++
 Documentation/index.rst                       | 156 ++++++------------
 Documentation/process/index.rst               |   1 +
 Documentation/staging/index.rst               |  42 -----
 Documentation/subsystem-apis.rst              |  58 +++++++
 scripts/checkpatch.pl                         |   2 +-
 11 files changed, 175 insertions(+), 153 deletions(-)
 rename Documentation/{ => core-api}/asm-annotations.rst (97%)
 create mode 100644 Documentation/core-api/wrappers/atomic_bitops.rst
 create mode 100644 Documentation/core-api/wrappers/atomic_t.rst
 create mode 100644 Documentation/core-api/wrappers/memory-barriers.rst
 create mode 100644 Documentation/subsystem-apis.rst

-- 
2.37.2

