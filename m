Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C2F740C08
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235300AbjF1I52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:57:28 -0400
Received: from [42.101.60.195] ([42.101.60.195]:46008 "HELO mail.nfschina.com"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with SMTP
        id S236204AbjF1Ip0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:45:26 -0400
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id E8A80605F4FBF;
        Wed, 28 Jun 2023 16:45:07 +0800 (CST)
Message-ID: <f69df0a0-dcb4-b4d3-2582-e1c64331b491@nfschina.com>
Date:   Wed, 28 Jun 2023 16:45:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH net-next 07/10] net: hns3: remove unnecessary (void*)
 conversions
Content-Language: en-US
To:     Hao Lan <lanhao@huawei.com>, yisen.zhuang@huawei.com,
        salil.mehta@huawei.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   yunchuan <yunchuan@nfschina.com>
In-Reply-To: <408a4d7b-5dbf-fa3b-357d-1cd736f92e83@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/6/28 15:26, Hao Lan wrote:
> nit: the local variable declarations could be reverse xmas tree
> longest line to shortest line.
> and elsewhere in other patchs.

Hi, Hao Lan,

I am so sorry for this, I will check again and resend them when the 
merge window opening.
Thanks for your reply!

wuych

>
> By the way, the net-next branch is currently closed, and you need to wait for
> the merge window to open before merging patches.
>
> Reviewed-by: Hao Lan <lanhao@huawei.com>
>
> Yours,
> Hao Lan
