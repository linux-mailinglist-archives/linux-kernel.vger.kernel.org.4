Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B96B609054
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 00:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiJVW4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 18:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJVW4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 18:56:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60C27C751
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 15:56:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0663660B0D
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 22:56:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF06C433D6;
        Sat, 22 Oct 2022 22:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1666479388;
        bh=D4mNyNda84fJ6pyLtCt0adu0b4qEGwhmimfAIHqFxlA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PaC332JbxNVIDT5Uw0lssHRULYKuAk0g1YhQ41wPTKJUDSP29TKzI8s1fZYvg3MEv
         Y4WWkIBVWSi8UXiPYPOw6cSCRd8RUIvexB7v9corh/oI8v3H9qRMgynEg8Q0ERbJ3p
         eny3WIFAmSvzSVbu/Fzbj5uVmi4Cnjf0KjDzvTNA=
Date:   Sat, 22 Oct 2022 15:56:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Phillip Lougher <phillip@squashfs.org.uk>,
        linux-kernel@vger.kernel.org, hsinyi@chromium.org,
        regressions@leemhuis.info, regressions@lists.linux.dev,
        dimitri.ledkov@canonical.com, michael.vogt@canonical.com,
        phillip.lougher@gmail.com, ogra@ubuntu.com,
        olivier.tilloy@canonical.com,
        Marc Miltenberger <marcmiltenberger@gmail.com>
Subject: Re: [0/3] squashfs: fix some regressions introduced in the
 readahead code
Message-Id: <20221022155627.be13b4ea9769f76818e73f81@linux-foundation.org>
In-Reply-To: <4493e774-ff23-e2a1-4aa7-28b190eb909d@alu.unizg.hr>
References: <20221020223616.7571-1-phillip@squashfs.org.uk>
        <4493e774-ff23-e2a1-4aa7-28b190eb909d@alu.unizg.hr>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Oct 2022 03:38:01 +0200 Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr> wrote:

> Please consider crediting Marc Miltenberger, who was first to reproduce 
> and confirm that the
> bug was not in my build but in mainline kernel.

Thanks, Marc.  I've added your Reported-by: to my copies of the
three patches.
