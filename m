Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0322F6BA17A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 22:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjCNVeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 17:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjCNVeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 17:34:09 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106922B636
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 14:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=c8YKNDOulGKBFkU6e30QFajptaOddYDXD4U1msaMvSc=; b=jfiT6/wGCSK4hJok38JRVdriQ0
        kztgeKUrgiK4sYFC7JXYut9VLbKNx8k3I/WebyWdMA/0Kq/wx8nY0TXO5UafpUQxE8TjbL44EAuBy
        Nsa4dwr3WcWkP1AY+aKp7VEtUmeX0tI7xZ81iQlsNgVLNEJ6lscUsI5q9BhHQW0HqUDaIeichYGis
        iMnv5pjr0FFsKfiWH7XkFuqviVYKirGYozwcmxR1fMH7jmXbaEH/2yzRDnT7y3a+Mx9gxvchtk50N
        2trLrsH/RcC8PAPGF8bm+rx95Jyi7VegWMU82AgXpTUlncpHoU+b+tqT2mwSLZ2NTQHqnV86PRtcv
        JMvJ/8rg==;
Received: from [152.254.169.34] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1pcCHP-00AVBj-83; Tue, 14 Mar 2023 22:33:59 +0100
Message-ID: <de338659-8346-db8c-f0a8-0d68661ebfd6@igalia.com>
Date:   Tue, 14 Mar 2023 18:33:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4] notifiers: Add tracepoints to the notifiers
 infrastructure
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        bhe@redhat.com, pmladek@suse.com, xiyou.wangcong@gmail.com,
        dmitry.osipenko@collabora.com, rafael.j.wysocki@intel.com,
        bigeasy@linutronix.de, valentin.schneider@arm.com,
        kernel-dev@igalia.com, kernel@gpiccoli.net,
        Arjan van de Ven <arjan@linux.intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Xiaoming Ni <nixiaoming@huawei.com>
References: <20230314200058.1326909-1-gpiccoli@igalia.com>
 <20230314135015.789369cd9f71b39a5b7eb291@linux-foundation.org>
 <2d1ad49c-d38e-ef06-8737-766ab0566251@igalia.com>
 <20230314141846.d801ae3dafb6fd2faa7206ac@linux-foundation.org>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230314141846.d801ae3dafb6fd2faa7206ac@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2023 18:18, Andrew Morton wrote:
> On Tue, 14 Mar 2023 18:08:37 -0300 "Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:
> [...]
>> Hi Andrew, thanks!
>>
>> Do you want me to re-submit? I see some emails of the patch getting
>> added to "mm-nonmm-unstable" (and also a checkpatch fixes you added on
>> top of that). Lemme know how should I proceed.
> 
> I changed it, thanks.

Tnx a bunch =)
