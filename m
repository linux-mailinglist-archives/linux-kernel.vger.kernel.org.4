Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833F172A123
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 19:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjFIRVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 13:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjFIRVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 13:21:09 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D163C22;
        Fri,  9 Jun 2023 10:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1686331246;
        bh=iGqU65SzcVMqTHxBRss8rWagx+IdyHWXV7rKC5hNv7Y=;
        h=Date:To:From:Subject:From;
        b=sw6eVekxbQXJuH5vYS17SVHh0CDz/gNbIZXZxueWj+jv8zXJAB4wmi0Hqs434ubPI
         l4maqWAMQtek8D3gUkQm9dY/p79zceyCYmrigmujSqjUvKqG7pJHf4C9TdyrWbYeXA
         Yc8dXp9ouorWe1wuelO1chIdnGJ/ceLv8iptOM5pTYbjVKFzot8Pv8W4bT21+f086g
         WDlSSqTZUPowZ27qtYkNW0WPG/aMCQNaXd8QmDHo4FrNOpKdUZU2ul5XpWyv29kkt0
         ZZqyONLqkArGU3lc+26qq6/06TtgnnEZJ7vDrTeI7lH1VpCdeO7ulzozqT4KYgj7mz
         KY6+QKLABCvjQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Qd7C25Hp3z173L;
        Fri,  9 Jun 2023 13:20:46 -0400 (EDT)
Message-ID: <ea7e251e-2514-8f81-28e5-3c78317581c6@efficios.com>
Date:   Fri, 9 Jun 2023 13:20:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     tracecompass-dev@eclipse.org, lwn@lwn.net,
        lttng-dev <lttng-dev@lists.lttng.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linuxtools-dev@eclipse.org,
        Diamon discuss <diamon-discuss@lists.linuxfoundation.org>,
        linux-trace-users <linux-trace-users@vger.kernel.org>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Tracing Summit - Last year's 2022 talk recordings are available
 online!
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

The recordings for last year’s 2022 Tracing Summit talks were just
posted to the DiaMon Workgroup channel!

2022 Tracing Summit Talks:
https://www.youtube.com/playlist?list=PLuo4E47p5_7YbvyBpSHh-wO3KUVQ81BQR

If you did not get the chance to attend last year, we invite you to take
a look at the diverse tracing talks that included eBPF and Perfetto
developments as well as updates for the core Linux kernel tracers.


This year, we’re looking forward to hearing about your new tracing
developments and challenging use cases at the 2023 Tracing Summit! If
you’re interested in exchanging ideas with experts in state-of-the-art
tracing, we invite you to submit a talk proposal soon as the deadline is
coming up next week (June 16th).

You can submit your 2023 Tracing Summit talk abstract here:
https://cfp.tracingsummit.org/ts2023/cfp

Best regards,

Mathieu

----

The 2023 Tracing Summit will be held in Bilbao, Spain on September 17th
and 18th, at the Euskalduna Conference Centre, co-located with Open
Source Summit Europe.

To register, you can include the Tracing Summit as an add-on to your
Open Source Summit ticket or use these links to register solely for the
Tracing Summit: https://cvent.me/Gn0nkR (in-person, 80$),
https://cvent.me/xywylX (virtual).

For more info: https://tracingsummit.org/

The 2023 Tracing Summit is sponsored by EfficiOS and organized by Erica
Bugden (EfficiOS), Olivier Dion (EfficiOS), and Mathieu Desnoyers
(EfficiOS) on behalf of the Linux Foundation Diagnostic and Monitoring
Workgroup.

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
