Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241A0701AD8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 01:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjEMXao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 19:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjEMXam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 19:30:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FDC270F;
        Sat, 13 May 2023 16:30:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EA5B614F1;
        Sat, 13 May 2023 23:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB2EC433D2;
        Sat, 13 May 2023 23:30:37 +0000 (UTC)
Date:   Sat, 13 May 2023 19:30:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        YehezkelShB@gmail.com, USB list <linux-usb@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: make localmodconfig doesn't work for thunderbolt
Message-ID: <20230513193035.6bbf08e3@rorschach.local.home>
In-Reply-To: <20230513192821.34ca93fd@rorschach.local.home>
References: <4cb758c7-f4f5-820c-c7e7-5b900ccc2534@kernel.org>
        <CAK7LNATQeT8MaQr450x0SpHJV=QU7nrfWfDO1ZRKimppVZG4KA@mail.gmail.com>
        <20230513192821.34ca93fd@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 May 2023 19:28:21 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Thanks Jiri and Masamhiro!

That should have been "Masahiro". Sorry for the misspelling. I type
"Masami" so many times, that the "m" after "Masa" is pretty much
automatic :-/

-- Steve
