Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7B5625005
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 03:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbiKKCMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 21:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKKCMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 21:12:07 -0500
X-Greylist: delayed 39272 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Nov 2022 18:12:06 PST
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FE15F852
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 18:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1668132722;
        bh=82J7uPAMpKs7w0oDQIxCFpHB5WzqsMfzFOp0NbuF7oo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=DavMGdS6TO16YFZJEtCzai/T96HDvCHhuA7FKhXOzynYu6u76Mz8QFRQ5krk1GdE1
         hBN/6crPGCb0xDSujDSnBIktJxj+9EuZArnIj8jjL8utBY0eTujEd6DpDB6zXGVMqn
         vOe9zGFLpE7WKBhdC2ByBbfatN31gsBBYNWRMUeg=
Received: from localhost.localdomain ([111.199.191.46])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id 2FB97000; Fri, 11 Nov 2022 10:11:59 +0800
X-QQ-mid: xmsmtpt1668132719twidrsxes
Message-ID: <tencent_519E5994970A2AB5AF9DA329881206814208@qq.com>
X-QQ-XMAILINFO: N7h1OCCDntujuAp5mqx8XHHF1MsbjBl9JoEPVTt0IrsgG7kV1nlKu55acBntGH
         iGIYxEBS7Am2mZrfHPvi/xPR8ZmZw9danRkrZUpGFJwG+BgdUt+b6rb9WB1GTEd91KlrPry2yK5+
         R8SR31BxAOhxsRwIPxQg6VDSJWBiEs2dUK+bOgtRFt2dUdJOrj789M/tacA2H+InMakqWdRlKra8
         A+X/gjiOACWHdjdNvVy9mGoPApmHA783iekzVKgPYaK84r2UtRQ0GNzw1bI1qCaw0iciy0KfyDlH
         O8VCOhcqV46OsimkSn267DQfE7Me4BxHHoS8Op29St2Xtiqccu0EF8ZtbpZncLivNoDbHQkFNWao
         TifxVptyaQk1pvPh/ER1o9KRghm0YNTGwrqI7uhszSF7isegGT3r0HNkgslEwzNqfq3ekDY9GpSA
         W1HR/x7sr/MiR32MRogHx3AK70f5mcEUOHo5fA6mm81bj3m3DR51xF+tee6Nsx5lyE/Wiw0GMVIS
         M3by4YeqyfvEHOixApcE4rm/dPwKJPp+iyNIrtb8C+Y23rkyVY8aX+pTPi0yrvE7Z4zXXvdAt6XH
         oChwwaTAziBBUvH32HE5Oi9pKSYNooRSGQUGeqtIiamh7pYa7BIa9e90UAFRj+xHzlCZbrJYjD6k
         ziXCEhwQScYIUrAXs7L2PSJuMGLiJFtjNk9lBblATLzHViwMHxNQbwUk47L5KER7v2KA2qfbRzaz
         TtUOt+WTceJKJn2vB+r2miZjD6lnK8ejElwnELAwIBDZWKPlP/BODVXh+rzZqmMIwZ2kX4Xq5LQc
         A/Pc8fzSke+f/CnFHDppnf8oLhOxBO3aClzMPdTRMEbaalVtme71RmAOaPV5uVVTLCkUfeDWzYFB
         PTWa0tq6FSnB9uvlxzpgp37LdC+V8RBgBdkW4FvaEw12Fabmb+x/O4K6NVf56mmDyewrH+2vypa1
         w8O7+C5M1pF4qrfK1vufKCbRafBSmhbpEXIic5l08=
From:   Rong Tao <rtoax@foxmail.com>
To:     willy@infradead.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rongtao@cestc.cn, rtoax@foxmail.com,
        wuchi.zero@gmail.com
Subject: Re: Re: [PATCH] lib/radix-tree: Fix uninitialized variable compilation warning
Date:   Fri, 11 Nov 2022 10:11:59 +0800
X-OQ-MSGID: <20221111021159.11989-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <Y20hkocEEoSNcSvZ@casper.infradead.org>
References: <Y20hkocEEoSNcSvZ@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your reply, actually, at first time, i just want to fix the
compile warning, and i don't really know about the radix tree code,
i'm sorry, i hope i can do it better next time.

Rong Tao.
