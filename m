Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FA96BA131
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 22:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjCNVJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 17:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjCNVJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 17:09:33 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258B04DE12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 14:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=at3EKPja1uG1hmcCODKYPMrJbShMRNNICkl1wIPJzMY=; b=Qy7k5A1PS+h2KnPWMfTWl6/snU
        9RckXkr3ONay6tR1mB5X3zm5L9qM9SWE+pDq7q6a6Ua5VE6Q4TdK3zSrpW714+Vqbt5Q74uqUp/kU
        yt5qtm+8cg3U/n1Ua+yXObM1k4NDdVF8EuGedxMBf+xpv24BtvtE/QUHvEt0e9ufFiAvSLK3rB+Ex
        mOzygRfap1Tw5wVMDoC6zKski4B8UXm2AEIgmErjD0UWfqeAJ2A6JV1WiUUVtD+oQ4piQku/+MIV2
        vGn7fv64qzJduvcdXEnWj8HKgO5rB65xtddOm1T8/p/81XpLBoi6EMIaWsCKPpG6lLjRbWg4kQ0jV
        042UY5GA==;
Received: from [152.254.169.34] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1pcBtD-00ATZw-UZ; Tue, 14 Mar 2023 22:09:01 +0100
Message-ID: <2d1ad49c-d38e-ef06-8737-766ab0566251@igalia.com>
Date:   Tue, 14 Mar 2023 18:08:37 -0300
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
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230314135015.789369cd9f71b39a5b7eb291@linux-foundation.org>
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

On 14/03/2023 17:50, Andrew Morton wrote:
> On Tue, 14 Mar 2023 17:00:58 -0300 "Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:
> 
>>  include/trace/events/notifiers.h | 69 ++++++++++++++++++++++++++++++++
>>  kernel/notifier.c                |  6 +++
> 
> Perhaps the filenames should match, which means "notifier.h".

Hi Andrew, thanks!

Do you want me to re-submit? I see some emails of the patch getting
added to "mm-nonmm-unstable" (and also a checkpatch fixes you added on
top of that). Lemme know how should I proceed.

Cheers,


Guilherme
