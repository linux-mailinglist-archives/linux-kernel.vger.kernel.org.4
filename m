Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D350719C28
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 14:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbjFAMaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 08:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjFAMao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 08:30:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209C3129
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 05:30:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A93A3643A4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 12:30:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAAC4C433EF;
        Thu,  1 Jun 2023 12:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685622643;
        bh=gTMQMs7eqCI3v3mq/ZVpgXSp08AegxTA6cQ/ZEMUIYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j/x6wxc78rRIraVEtc0nT4AOKuF1MzPgfMYMQsI3xJaK2obbxuJ4yO4XLq612TAZ8
         lrNkfAMhMMXZGQ3k0FKP7e8arV4arqYWc51uxT3y1Co9nNHP5zWSUvpSf+8gnr3F9i
         ZTGIUXeV+0qsMN7ctMSDI3mYHnTPeke9EF8wufYPyHJhV065PLAKKQ44V5V024r5lL
         zJ4EnYDjsWql2DmCA+Vs9ITX5vqvIjAbzilawn/uzwgekO3/AerXhWbTIycJGmXZ/o
         XCciByM1yXRYa0dYDshbaWjS+tyamA/Ri3T9mv76t6WTK9XSM9XezV8rlMFQzTlLRG
         oKVrMAKky+abw==
Date:   Thu, 1 Jun 2023 14:30:40 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [patch 14/20] posix-timers: Document nanosleep() details
Message-ID: <ZHiPcLs1GYd/XBnT@lothringen>
References: <20230425181827.219128101@linutronix.de>
 <20230425183313.567072835@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425183313.567072835@linutronix.de>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 08:49:17PM +0200, Thomas Gleixner wrote:
> The descriptions for common_nsleep() is wrong and common_nsleep_timens()
> lacks any form of comment.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
