Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAB4660567
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 18:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbjAFRPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 12:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjAFRPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 12:15:36 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D877CBE6;
        Fri,  6 Jan 2023 09:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1673025332;
        bh=yYPo0zlsfXstJ4c+0tUc+lF4AleNOUB5lS8dJyCBFGs=;
        h=Date:To:From:Subject:From;
        b=KUXnJY8EeHvaHRdyUqyolPm1jZQvKaaigZZ+pJLlDgiHbeCq8WVqs9goTWaF3ZJPn
         wzPvkIjo5GjvzXVhQ0V3KIrR0QpGF36hRVm3ZvNq3A8phPJv6rrikF8NMVr8Dg1IUD
         IY89iMiKeiSubSSI9d9h4pU9UQI7f5rK1euQN0LpWp28CVHS7nC8b8WZA2vxHWuvj7
         dAiR8AMptQq9S3k4YEjXuk3QlAOeE1LjSH8uUvKO2o4PCQvV9b/+SPAZFRSLDu8XKZ
         opFbruIMCnKUYdyD8yxIb1DZT2wSdXCWT+m3ChxmuOPw8QoViaCNaasqKVg8zek+zD
         r0JGuYUJjVKPg==
Received: from [172.16.0.101] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NpVN4534bzgGd;
        Fri,  6 Jan 2023 12:15:32 -0500 (EST)
Message-ID: <095c479b-baed-9d11-08a1-e698f59763d9@efficios.com>
Date:   Fri, 6 Jan 2023 12:16:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     linux-man@vger.kernel.org, Alejandro Colomar <alx@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, paulmck <paulmck@kernel.org>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: rseq(2) man page
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I would like to contribute a man page for the rseq(2) system call to the
man-pages project. I maintain this system call which appeared in Linux 4.18.
I have done several attempts to contribute a man page for it in the past,
so let's hope we will have more luck this time.

I have just done some improvements to the man page, here is its current
location:

https://git.kernel.org/pub/scm/libs/librseq/librseq.git/tree/doc/man/rseq.2

Please let me know if this is a good time to contribute it, and if I need
to do significant changes before submitting again.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
