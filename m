Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8045368E6D1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 04:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjBHDtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 22:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjBHDs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 22:48:58 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEEC6E83;
        Tue,  7 Feb 2023 19:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1675828122;
        bh=c4Ns5sTtRUOLfYsSbg4uDoMp4emFarBXyp4YoadLNBE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NbzMzf7JB3H5JzUfsCG/bjURPchuFMT5qSJ8Zxwswuhvv8sUMpal3mi5BvKNzSplM
         2+N4BL843u4L2IJ5ErEefBK7fp9FIhN9kFZaJiik+N5lysAoK5csj09O2dW+t93Bg4
         jcjAtJ5ucnFuukxp3EgP6ZkMgVv6XVYK7fE78WbbSu+jtiVOAJir1PO66bD8UsM12J
         dK2N7CJOQuBgCaqZHPGJUGIeuir1DSj3loWnCyNCkptDubPSl0+mXVBql649Q0Nzcm
         KjXNwNPj0LnMa0A0JixXhloLTL8ymJqY4AlEEG+1GF0TVG06/jL/9CQGCbal4I7qUV
         fkS/LM5zYzXMg==
Received: from [10.1.0.205] (192-222-188-97.qc.cable.ebox.net [192.222.188.97])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4PBQvt52MjzkYH;
        Tue,  7 Feb 2023 22:48:42 -0500 (EST)
Message-ID: <51b1d566-2a5a-763e-fb0f-cc3eb387b917@efficios.com>
Date:   Tue, 7 Feb 2023 22:48:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4] srcu: Clarify comments on memory barrier "E"
Content-Language: en-US
To:     paulmck@kernel.org, Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, akiyks@gmail.com
References: <20230128035902.1758726-1-joel@joelfernandes.org>
 <20230128182440.GA2948950@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTK1ejOcuNyAqJ3ibKKyfR21UYHRNa7jpWS_H71xpnTpg@mail.gmail.com>
 <20230129050904.GD2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230208033831.GA3160511@paulmck-ThinkPad-P17-Gen-1>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230208033831.GA3160511@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-07 22:38, Paul E. McKenney wrote:
[...]
> 
> Except that it was pointed out to me that the Co-developed-by tags also
> need Signed-off-by tags.  If there are no objections to the update shown
> below, I will fix this on my next rebase.

No objection from me, thanks!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

