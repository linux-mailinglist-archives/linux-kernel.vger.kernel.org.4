Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9F162A37C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 21:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238581AbiKOUyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 15:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238534AbiKOUyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 15:54:09 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4E3F19;
        Tue, 15 Nov 2022 12:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rgefBHoSiK+EXXSu5hLiDgMbY02EErMFZqCWCQbOdYk=; b=lIv8xG2p/ovF7cvN7dCczlQ2lk
        qnexkYZCZuATKDbhNtaDPeQq1hDLThWO3XPZWCFL9l4aEL34D0r/ESnm42D0YoOvyg1+CoJkdhlIU
        czdpBf/PBY0yX86TxibDXBV19MsdHJFV9oNQWn2Rx8467FN62/UN4Rw0e7nE+qKYB0QQbZX1SD9oy
        ymQ+Ad4YqhHb6tq4bXuoJWtTSi9wbpicICXQPhaBim+RT6xt4+xQ/LS4hSnIqkbiXoIo4Gwkm0FiN
        8T4bMk+QbzWmzs07wcJVeAV5zEEbCjLxgNjiktIfBbF9H3f8tMLoRWv73113ee1swqGMTGrVRgtYD
        /gO454ng==;
Received: from [179.232.147.2] (helo=[192.168.0.5])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1ov2wV-001Qsy-4W; Tue, 15 Nov 2022 21:54:03 +0100
Message-ID: <5c00c1a5-5ba3-f9bd-1ffa-e57f4deba043@igalia.com>
Date:   Tue, 15 Nov 2022 17:53:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: RCU stall on 6.1-rc4 (and some previous releases) related to
 ftrace
Content-Language: en-US
To:     paulmck@kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>
References: <1ef5fe19-a82f-835e-fda5-455e9c2b94b4@igalia.com>
 <20221110191651.3a177417@rorschach.local.home>
 <20221111033712.GO725751@paulmck-ThinkPad-P17-Gen-1>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20221111033712.GO725751@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2022 00:37, Paul E. McKenney wrote:
> [...]
>> This isn't where I would put it. I would add it after the if statement.
>> That is, at the end of the loop.
> 
> I am good either way.  Though one could argue for putting it at the
> beginning of the loop in case every element takes that "continue" above...
> 
> 							Thanx, Paul

Thanks Paul and Steve - submitted an official version here:
https://lore.kernel.org/lkml/20221115204847.593616-1-gpiccoli@igalia.com
