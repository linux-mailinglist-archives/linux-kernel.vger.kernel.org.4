Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE52740CDC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjF1J16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:27:58 -0400
Received: from [42.101.60.195] ([42.101.60.195]:53662 "HELO mail.nfschina.com"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with SMTP
        id S236728AbjF1JCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:02:20 -0400
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 38A89605F6240;
        Wed, 28 Jun 2023 17:01:59 +0800 (CST)
Message-ID: <734b846f-3235-f2e3-db06-6e852803cd7f@nfschina.com>
Date:   Wed, 28 Jun 2023 17:01:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH net-next 00/10] Remove unnecessary (void*) conversions
Content-Language: en-US
To:     Hao Lan <lanhao@huawei.com>, andrew@lunn.ch, f.fainelli@gmail.com,
        olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, irusskikh@marvell.com,
        yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        steve.glendinning@shawell.net, iyappan@os.amperecomputing.com,
        keyur@os.amperecomputing.com, quan@os.amperecomputing.com,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        mostrows@earthlink.net, xeb@mail.ru, qiang.zhao@nxp.com
Cc:     yangyingliang@huawei.com, linux@rempel-privat.de,
        ansuelsmth@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   yunchuan <yunchuan@nfschina.com>
In-Reply-To: <1f5652f7-7eb2-11f0-4a07-c87f2992e509@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/28 15:41, Hao Lan wrote:
>
> On 2023/6/28 10:41, wuych wrote:
>> Remove (void*) conversions under "drivers/net" directory.
>> According to the suggestion[1] of Jakub Kicinski, send these patches
>> in series of 10.
>>
>> wuych (10):
>>    net: dsa: ar9331: remove unnecessary (void*) conversions
>>    net: dsa: qca8k: remove unnecessary (void*) conversions
>>    atlantic:hw_atl2:hw_atl2_utils_fw: Remove unnecessary (void*)
>>      conversions
>>    ice: Remove unnecessary (void*) conversions
>>    ethernet: smsc: remove unnecessary (void*) conversions
>>    net: hns: Remove unnecessary (void*) conversions
>>    net: hns3: remove unnecessary (void*) conversions
>>    net: mdio: Remove unnecessary (void*) conversions
>>    net: ppp: remove unnecessary (void*) conversions
>>    net: wan: Remove unnecessary (void*) conversions
>>
> Hi wuych,
> Thank you for your patch.
> The following two patches conflict with the net-next branch, and others have modified the related code.
> Please compile your series in net and net-next branch and upload your series again.
>    net: dsa: ar9331: remove unnecessary (void*) conversions
>    net: dsa: qca8k: remove unnecessary (void*) conversions

Hi, Hao Lan,

Sorry for that, I just compiled these patches in the mainline branch.
I know now, it's also necessary to compile patches in net and net-next 
branch.
Thanks for your reply!

wuych

>
> Yours,
> Hao Lan
