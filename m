Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C04671FC29
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbjFBIes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbjFBIep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:34:45 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2598BA;
        Fri,  2 Jun 2023 01:34:41 -0700 (PDT)
Received: from [192.168.0.2] (unknown [95.90.235.244])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id E4A8861E4052B;
        Fri,  2 Jun 2023 10:33:48 +0200 (CEST)
Message-ID: <a5d2fffb-e624-83f4-2f40-bc81d605bf5d@molgen.mpg.de>
Date:   Fri, 2 Jun 2023 10:33:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 1/2] md/raid10: fix incorrect done of recovery
Content-Language: en-US
To:     Li Nan <linan666@huaweicloud.com>
Cc:     song@kernel.org, neilb@suse.de, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com
References: <20230601062424.3613218-1-linan666@huaweicloud.com>
 <20230601062424.3613218-2-linan666@huaweicloud.com>
 <2e36d874-4dd3-080c-3499-44f2f09b9169@molgen.mpg.de>
 <917d7c23-eefc-efc5-1b12-949a684900bc@huaweicloud.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <917d7c23-eefc-efc5-1b12-949a684900bc@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Li Nan,


Am 02.06.23 um 08:57 schrieb Li Nan:

> 在 2023/6/1 15:06, Paul Menzel 写道:

>> Am 01.06.23 um 08:24 schrieb linan666@huaweicloud.com:
>>> From: Li Nan <linan122@huawei.com>
>>
>> Unfortunately, I do not understand your commit message summary “fix 
>> incorrect done of recovery”. Maybe:
>>
>> Do not add sparse disk when recovery aborts
> 
> "recovery fail" is better?

I think the grammar is incorrect, and it should be fail*s*.

[…]


Kind regards,

Paul
