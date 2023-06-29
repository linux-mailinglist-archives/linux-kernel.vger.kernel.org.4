Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288B97420AF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 08:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjF2G5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 02:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjF2G5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 02:57:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E341FC0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 23:57:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73C5F614C4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 06:57:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75660C433C0;
        Thu, 29 Jun 2023 06:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688021819;
        bh=80x9r4LA4LA8BeaDnMdX/U9titGstiwY3o42Eq8vAJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sAkj89fiv0JOyNbijWqEAiU7v1mL0pOvHud315hdN241vw4P9f6eupO0S66jWQXa7
         l698FZJlYwlLqG3KheHBQZp46gaAUmCQtAX+H3/iFM98oIJQbGLp6a2ORMtuNXvfOy
         AnF2JXdy60njlCN5CZ8QIaClf9LXSNzIoKHEJgPg=
Date:   Thu, 29 Jun 2023 08:56:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     liujf628995 <liujf628995@126.com>
Cc:     catalin.marinas@arm.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com, security@kernel.org,
        secalert@redhat.com
Subject: Re: use-after-free in =?utf-8?Q?kmemleak?= =?utf-8?B?X3NjYW7vvJ8=?=
Message-ID: <2023062958-twistable-rut-e684@gregkh>
References: <59a9e693.270f.1890529db99.Coremail.liujf628995@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59a9e693.270f.1890529db99.Coremail.liujf628995@126.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 11:19:36AM +0800, liujf628995 wrote:
> hello,here is a crash from syzkaller,it looks like happened in kmemleak scan.It could not be reproduced by syzkaller because this should not have been caused by syscall fuzz.I don't know what rhe reason for this，please check it.My fuzzed linux kernel is linux-6.2（commit/c9c3395d5e3dcc6daee66c6908354d47bf98cb0c）

If you have a reproducer or a patch, we will be glad to review it,
otherwise just sending syzbot reports like this (especially in html
format which is rejected by the mailing lists), will not go very far as
we have loads of them already.

thanks,

greg k-h
