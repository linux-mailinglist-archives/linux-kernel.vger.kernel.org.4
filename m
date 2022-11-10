Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531FF623AC2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 05:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbiKJEBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 23:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiKJEBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 23:01:03 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551F131379;
        Wed,  9 Nov 2022 20:01:01 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N77RK2s3GzmVnn;
        Thu, 10 Nov 2022 12:00:45 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 12:00:59 +0800
Subject: Re: [PATCH v2] wifi: ath10k: Fix return value in ath10k_pci_init()
To:     Jakub Kicinski <kuba@kernel.org>
CC:     <kvalo@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <rmani@qti.qualcomm.com>,
        <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221110031228.247361-1-xiujianfeng@huawei.com>
 <20221109192532.259e4af3@kernel.org>
From:   xiujianfeng <xiujianfeng@huawei.com>
Message-ID: <9ea5ec08-65b3-6c8b-ae64-5114b736e64d@huawei.com>
Date:   Thu, 10 Nov 2022 12:00:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20221109192532.259e4af3@kernel.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.112]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2022/11/10 11:25, Jakub Kicinski Ð´µÀ:
> On Thu, 10 Nov 2022 11:12:28 +0800 Xiu Jianfeng wrote:
>> To: <kvalo@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,  <kuba@kernel.org>, <pabeni@redhat.com>, <rmani@qti.qualcomm.com>
>> CC: <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
> 
> How did you come up with this CC list? If you're CCing netdev
> maintainers you should also CC netdev@vger.kernel.org
> Somehow you managed to CC LMKL but not netdev :S
> .

Sorry, I may missed that, I will resend this patch.
> 
