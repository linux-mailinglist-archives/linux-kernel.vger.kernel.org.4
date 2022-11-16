Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1E062BE7B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbiKPMpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiKPMpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:45:51 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594DE5FF4;
        Wed, 16 Nov 2022 04:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+vEAwydJwZp9V6AqkZZHVVn7NVY+20lO3687ub6KCmg=; b=H2J7NuWII/mwNKhUZXLZfxrwrf
        ik/+CTYwA3BePlVkBhJHkI5X5dSMLhqBUVFeR1/eprfw9cQBLLB3BmxV+llk+9qxRtdWRaAgmmLMu
        w/4LYUICTRKIhfFqAAjM3npIkVY4VjGeEG71ik0vzJmso8WTo0Kn9GkQwY0L2svi5Gf+DJnqSxesu
        DM50ai2FmUvJGZItPIoluIZYxapK/CM8MTukCBU989QQbb0EulHVsXmuBdjzPGPg1ci5nPEJu4tfj
        vO/IPBjzyyCFAN/5/7I7s1spMscvoc+jipnjmttC3pOhRKsnW4eiTTcC8UWEf8Tsz0KDLspMXD4Fd
        WnFWU7Jw==;
Received: from [177.102.6.147] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1ovHnV-001m8I-49; Wed, 16 Nov 2022 13:45:45 +0100
Message-ID: <7e0d7255-a68f-739e-96b0-8911f52e45ef@igalia.com>
Date:   Wed, 16 Nov 2022 09:45:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH] ftrace: Prevent RCU stall on PREEMPT_VOLUNTARY kernels
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        rcu@vger.kernel.org, kernel-dev@igalia.com, kernel@gpiccoli.net,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20221115204847.593616-1-gpiccoli@igalia.com>
 <20221116153620.353819e9c6acb1bf39adeca2@kernel.org>
Content-Language: en-US
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20221116153620.353819e9c6acb1bf39adeca2@kernel.org>
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

On 16/11/2022 03:36, Masami Hiramatsu (Google) wrote:
> [...]
> This looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Thanks!

Thanks for your review/Ack Masami, much appreciated.
Cheers,


Guilherme
