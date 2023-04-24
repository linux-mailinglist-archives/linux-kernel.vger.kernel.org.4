Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F466ED613
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 22:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbjDXUXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 16:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjDXUXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 16:23:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9626A5FDD;
        Mon, 24 Apr 2023 13:23:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 375A062139;
        Mon, 24 Apr 2023 20:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CD0C433D2;
        Mon, 24 Apr 2023 20:23:02 +0000 (UTC)
Date:   Mon, 24 Apr 2023 16:23:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Donglin Peng <pengdonglin@sangfor.com.cn>
Cc:     mhiramat@kernel.org, huangcun@sangfor.com.cn,
        dinghui@sangfor.com.cn, catalin.marinas@arm.com,
        mark.rutland@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        bp@alien8.de, tglx@linutronix.de, aou@eecs.berkeley.edu,
        rmk+kernel@armlinux.org.uk, linux@armlinux.org.uk, will@kernel.org,
        peterz@infradead.org, mingo@redhat.com, zhangqing@loongson.cn,
        chenhuacai@kernel.org, kernel@xen0n.name, dolinux.peng@gmail.com,
        x86@kernel.org, linux-trace-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Florian Kauer <florian.kauer@linutronix.de>,
        dave.hansen@linux.intel.com, hpa@zytor.com, xiehuan09@gmail.com
Subject: Re: [PATCH v11 1/8] function_graph: Support recording and printing
 the return value of function
Message-ID: <20230424162300.67daca4f@rorschach.local.home>
In-Reply-To: <7eabae11-6a65-c51d-ff39-8205057e497a@sangfor.com.cn>
References: <cover.1680954589.git.pengdonglin@sangfor.com.cn>
        <1fc502712c981e0e6742185ba242992170ac9da8.1680954589.git.pengdonglin@sangfor.com.cn>
        <66fe9288-05ff-1bf3-dd40-e7b3cbdf1af9@sangfor.com.cn>
        <7eabae11-6a65-c51d-ff39-8205057e497a@sangfor.com.cn>
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

On Fri, 14 Apr 2023 15:55:05 +0800
Donglin Peng <pengdonglin@sangfor.com.cn> wrote:

> Hi Steve, could you please correct this mistake before merging it into
> linux-next?

Will do.

-- Steve
