Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D31E5F8C43
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 18:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiJIQVr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 9 Oct 2022 12:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJIQVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 12:21:45 -0400
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E0C27140;
        Sun,  9 Oct 2022 09:21:43 -0700 (PDT)
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay04.hostedemail.com (Postfix) with ESMTP id 45D5E1A0930;
        Sun,  9 Oct 2022 16:21:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id 1D92720023;
        Sun,  9 Oct 2022 16:21:13 +0000 (UTC)
Message-ID: <9ff662d738612f0ed2cea39266768a2eff21edc3.camel@perches.com>
Subject: kernel style preference trivia: '* const' vs '*const' ?
From:   Joe Perches <joe@perches.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 09 Oct 2022 09:21:39 -0700
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Stat-Signature: f7kky6c3eq77h4mcji14he9g4r95z8eo
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 1D92720023
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/54rzZQ8/w8+gpKyhVqiTMLzTvdQeQyYQ=
X-HE-Tag: 1665332473-117259
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel uses '* const' about 10:1 over '*const'

coding_style and checkpatch don't care one way or another.

Does anyone care if there should be some kernel style preference?

$ git grep -P -oh '\b(?:char|u8)\s*\*\s*const\b' -- '*.[ch]' | \
  sort | uniq -c | sort -rn
  12450 char * const
   1357 char *const
     41 u8 * const
     17 char* const
      9 u8 *const
      5 char		*const
      2 char      * const
      2 char			*const
      1 char  * const
      1 char	*const
      1 char		* const

