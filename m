Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F166531C5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 14:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiLUNaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 08:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbiLUN3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 08:29:42 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E4AD631B;
        Wed, 21 Dec 2022 05:29:11 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2ADE2F4;
        Wed, 21 Dec 2022 05:29:51 -0800 (PST)
Received: from [10.57.11.16] (unknown [10.57.11.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 908273F703;
        Wed, 21 Dec 2022 05:29:08 -0800 (PST)
Message-ID: <38c75f44-02ef-4501-ad68-2b9896c3b6b0@arm.com>
Date:   Wed, 21 Dec 2022 13:29:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3] Documentation: sched: Document util clamp feature
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>, Wei Wang <wvw@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>, Paul Bone <pbone@mozilla.com>
References: <20221216235716.201923-1-qyousef@layalina.io>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20221216235716.201923-1-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais,

On 12/16/22 23:57, Qais Yousef wrote:
> The new util clamp feature needs a document explaining what it is and
> how to use it. The new document hopefully covers everything one needs to
> know about uclamp.
> 
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> ---
> 
> Changes in v3:
> 
>    * Addressed various readability and style comments from Bagas, Jonathan and
>      Lukasz. Thanks all!
> 
>   Documentation/admin-guide/cgroup-v2.rst      |   3 +
>   Documentation/scheduler/index.rst            |   1 +
>   Documentation/scheduler/sched-util-clamp.rst | 741 +++++++++++++++++++
>   3 files changed, 745 insertions(+)

LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
