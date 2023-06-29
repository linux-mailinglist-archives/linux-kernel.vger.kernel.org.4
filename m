Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18121741DFD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 04:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjF2CK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 22:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjF2CKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 22:10:55 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 6ADF61FEB;
        Wed, 28 Jun 2023 19:10:53 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 23C4C604D34EE;
        Thu, 29 Jun 2023 10:10:39 +0800 (CST)
Message-ID: <72784932-8390-4f82-fbaa-5086804025df@nfschina.com>
Date:   Thu, 29 Jun 2023 10:10:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH net-next 00/10] Remove unnecessary (void*) conversions
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Hao Lan <lanhao@huawei.com>, f.fainelli@gmail.com,
        olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, irusskikh@marvell.com,
        yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        steve.glendinning@shawell.net, iyappan@os.amperecomputing.com,
        keyur@os.amperecomputing.com, quan@os.amperecomputing.com,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        mostrows@earthlink.net, xeb@mail.ru, qiang.zhao@nxp.com,
        yangyingliang@huawei.com, linux@rempel-privat.de,
        ansuelsmth@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   yunchuan <yunchuan@nfschina.com>
In-Reply-To: <ecd70c28-1629-4b6c-96fc-a0b8f8713a04@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/28 22:39, Andrew Lunn wrote:
> On Wed, Jun 28, 2023 at 04:37:43PM +0200, Andrew Lunn wrote:
>>> Hi, Hao Lan,
>>>
>>> Sorry for that, I just compiled these patches in the mainline branch.
>>> I know now, it's also necessary to compile patches in net and net-next
>>> branch.
>>> Thanks for your reply!
>> net-next is also closed at the moment due to the merge window. Please
>> wait two weeks before reposting, by which time net-next will be open
>> again.

Hi, Andrew Lunn,

Understand, and thanks for your reminding!

> Your email threading also seems to be broken, there is no
> threading. That might cause pathworks an issue.
Sometimes it doesn't work, but I also receive email from email list.
So I can read your email from email list although something is broken.
Thanks again！

wuych

>
> 	Andrew
