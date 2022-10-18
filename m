Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DA960243E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 08:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiJRGVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 02:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiJRGVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 02:21:16 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE9168CD4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 23:21:14 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Ms3Zz0YxtzJn2G;
        Tue, 18 Oct 2022 14:18:35 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 14:21:12 +0800
Subject: Re: [PATCH V3 1/1] x86/sgx: Add code to inject hwpoison into SGX
 memory
To:     Thomas Tai <thomas.tai@oracle.com>
References: <20221017223305.578073-1-thomas.tai@oracle.com>
 <20221017223305.578073-2-thomas.tai@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
CC:     <tony.luck@intel.com>, <dave.hansen@linux.intel.com>,
        <jarkko@kernel.org>, <reinette.chatre@intel.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <naoya.horiguchi@nec.com>
Message-ID: <4a7c4187-5df3-f153-189b-62fae7de4cd2@huawei.com>
Date:   Tue, 18 Oct 2022 14:21:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20221017223305.578073-2-thomas.tai@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/18 6:33, Thomas Tai wrote:
> Inspired by commit c6acb1e7bf46 ("x86/sgx: Add hook to error injection
> address validation"), add a similar code in hwpoison_inject function to
> check if the address is located in SGX Memory. The error will then be
> handled by the arch_memory_failure function in the SGX driver. After
> injection, the action_result() will print out the page type and the
> action taken.
> 
> Signed-off-by: Thomas Tai <thomas.tai@oracle.com>

Many thanks for your work. The patch looks good to me.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks,
Miaohe Lin


