Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE20762E605
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 21:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238946AbiKQUgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 15:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235060AbiKQUgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 15:36:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3326585A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 12:36:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F4FBB82072
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 20:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321A6C433D6;
        Thu, 17 Nov 2022 20:36:32 +0000 (UTC)
Date:   Thu, 17 Nov 2022 15:36:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Wang Wensheng <wangwensheng4@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <mhiramat@kernel.org>,
        <mark.rutland@arm.com>, <xuqiang36@huawei.com>,
        <weiyongjun1@huawei.com>
Subject: Re: [PATCH -next 3/3] ftrace: Delete unused variable
 ftrace_update_time
Message-ID: <20221117153630.4af6a7da@gandalf.local.home>
In-Reply-To: <20221109094434.84046-4-wangwensheng4@huawei.com>
References: <20221109094434.84046-1-wangwensheng4@huawei.com>
        <20221109094434.84046-4-wangwensheng4@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Nov 2022 09:44:34 +0000
Wang Wensheng <wangwensheng4@huawei.com> wrote:

> ftrace_update_time is not used anywhere else after initialization. So
> delete it together with its initial code.

Thanks for the first two patches. They are definitely fixes and I plan on
testing and adding them to my next pull request.

As for this one, this has been more of a reminder for me to one day (I
know, it's been years!) to export this to see from user space. I sometimes
do it manually with a printk(), but it should probably be always shown.
Perhaps in dyn_ftrace_total_info ?

-- Steve
