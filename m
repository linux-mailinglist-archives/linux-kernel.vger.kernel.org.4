Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9356773A97D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 22:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjFVUam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 16:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjFVUak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 16:30:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74DE1FF0;
        Thu, 22 Jun 2023 13:30:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83AAA618D7;
        Thu, 22 Jun 2023 20:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065BDC433C8;
        Thu, 22 Jun 2023 20:30:37 +0000 (UTC)
Date:   Thu, 22 Jun 2023 16:30:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     sunliming <sunliming@kylinos.cn>, mhiramat@kernel.org,
        kelulanainsley@gmail.com, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] selftests/user_events: Add test cases when event
 is diabled
Message-ID: <20230622163036.1e68d25b@gandalf.local.home>
In-Reply-To: <ZJSuvC9bfcTQMWvI@CPC-beaub-VBQ1L.localdomain>
References: <20230621063502.154378-1-sunliming@kylinos.cn>
        <ZJSuvC9bfcTQMWvI@CPC-beaub-VBQ1L.localdomain>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2023 20:27:40 +0000
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> On Wed, Jun 21, 2023 at 02:35:02PM +0800, sunliming wrote:
> > When user_events are disabled, it's write operation should return zero.
> > Add this test cases.
> > 
> > Signed-off-by: sunliming <sunliming@kylinos.cn>  
> 
> I don't have a problem with the chagne to the test, however, the patch
> title has a typo in it for "disabled" that should be corrected. I've
> ACK'd the other 2 patches, so you only need to resubmit this one with a
> correct title.

Ah, I misunderstood when we talked earlier today. I thought the typo was in
the text of the start selftest. That is, it was part of the patch.

For a typo in the subject, I can make that fix when I pulled it in. I just
avoid touching content of the patch itself.

Care to ack it?

Thanks!

-- Steve
