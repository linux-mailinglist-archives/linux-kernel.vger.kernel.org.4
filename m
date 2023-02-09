Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E77C6914DB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 00:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjBIXqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 18:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBIXqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 18:46:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED90655BA;
        Thu,  9 Feb 2023 15:46:43 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675986401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FYDEIuO1mtsV7b7F/mr19JQ3UrN1v1jfGwEp53SxXaE=;
        b=DNuv0E2kOSb31S6oAy23kMaaeBLtb6QMLTgIvUFAqtkWsR/lyn0kK8X8fbiOhqTWOx549P
        AiUUPPkAmUF36D/3Nv1BP740g7ezpZxkjKEGXS/iQUCQgEMx+ZEzMTS6P7zcUfhi+xDqSN
        a0dErTxrYRf6N5C8BXJBTVk9VynZAZkG+Apmp7+cQs8z8nv0TJ1vN7jS6vB19/TT++wZ+r
        tGb27d4SEbO3otPqIBXEQi0hmtFDGtMYA12/l+aSMYrPTvZzP9tcjab3D1dglppTDLRL4i
        tMvGT8AQ+vW0+p6HwdEF4musp8oOrA4+RaKxSTO8O93ZFW2+YOfXSXm17d30RA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675986401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FYDEIuO1mtsV7b7F/mr19JQ3UrN1v1jfGwEp53SxXaE=;
        b=DDxzsy+zoAI0dErtR7dMChTr9h/UjmS42iGTb9Q1dL4nZ1aMjZXrBaTn3nZeqjr/nVhwbE
        +PLJvey6VTBmVqAA==
To:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, oleg@redhat.com, avagin@gmail.com,
        peterz@infradead.org, luto@kernel.org, krisman@collabora.com,
        corbet@lwn.net, shuah@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH v8 1/1] ptrace,syscall_user_dispatch: checkpoint/restore
 support for SUD
In-Reply-To: <87edqy1jzf.ffs@tglx>
References: <20230131144458.1980891-1-gregory.price@memverge.com>
 <20230131144458.1980891-2-gregory.price@memverge.com>
 <87edqy1jzf.ffs@tglx>
Date:   Fri, 10 Feb 2023 00:46:41 +0100
Message-ID: <87bkm21jxa.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10 2023 at 00:45, Thomas Gleixner wrote:
> I'm neither impressed by this patch nor by the reviews.

I just noticed that this is V8. I'm truly impressed now.
