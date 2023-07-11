Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E594074E9C1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjGKJDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbjGKJDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:03:11 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6194C93;
        Tue, 11 Jul 2023 02:03:10 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 476B661E5FE03;
        Tue, 11 Jul 2023 11:01:25 +0200 (CEST)
Message-ID: <237f5cac-5696-93ea-1ab4-f5da4ea790a9@molgen.mpg.de>
Date:   Tue, 11 Jul 2023 11:01:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Intel-wired-lan] [PATCH net-next v2 00/10] Remove unnecessary
 (void*) conversions
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Su Hui <suhui@nfschina.com>
Cc:     andrew@lunn.ch, irusskikh@marvell.com,
        kernel-janitors@vger.kernel.org, jesse.brandeburg@intel.com,
        edumazet@google.com, iyappan@os.amperecomputing.com,
        anthony.l.nguyen@intel.com, quan@os.amperecomputing.com,
        qiang.zhao@nxp.com, linux@armlinux.org.uk, xeb@mail.ru,
        intel-wired-lan@lists.osuosl.org, kuba@kernel.org,
        pabeni@redhat.com, yisen.zhuang@huawei.com, wg@grandegger.com,
        steve.glendinning@shawell.net, keyur@os.amperecomputing.com,
        linux-can@vger.kernel.org, mkl@pengutronix.de,
        salil.mehta@huawei.com, GR-Linux-NIC-Dev@marvell.com,
        uttenthaler@ems-wuensche.com, rmody@marvell.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, yunchuan@nfschina.com,
        linuxppc-dev@lists.ozlabs.org, skalluru@marvell.com,
        hkallweit1@gmail.com
References: <20230710063828.172593-1-suhui@nfschina.com>
 <f1f9002c-ccc3-a2de-e4f5-d8fa1f8734e3@molgen.mpg.de>
In-Reply-To: <f1f9002c-ccc3-a2de-e4f5-d8fa1f8734e3@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc: Remove mostrows@earthlink.net (550 5.5.1 Recipient rejected - 
ELNK001_403 -)]

Am 11.07.23 um 10:53 schrieb Paul Menzel:
> Dear Su,
> 
> 
> Thank you for your patch.
> 
> Am 10.07.23 um 08:38 schrieb Su Hui:
>> From: wuych <yunchuan@nfschina.com>
> 
> Can you please write the full name correctly? Maybe Yun Chuan?
> 
>      git config --global user.name "Yun Chuan"
>      git commit --amend --author="Yun Chuan <yunchuan@nfschina.com>"
> 
> I only got the cover letter by the way.
> 
> 
> Kind regards,
> 
> Paul
> 
> 
>> Changes in v2:
>>     move declarations to be reverse xmas tree.
>>     compile it in net and net-next branch.
>>     remove some error patches in v1.
>>
>> PATCH v1 link:
>> https://lore.kernel.org/all/20230628024121.1439149-1-yunchuan@nfschina.com/
>>
>> wuych (10):
>>    net: wan: Remove unnecessary (void*) conversions
>>    net: atlantic: Remove unnecessary (void*) conversions
>>    net: ppp: Remove unnecessary (void*) conversions
>>    net: hns3: remove unnecessary (void*) conversions
>>    net: hns: Remove unnecessary (void*) conversions
>>    ice: remove unnecessary (void*) conversions
>>    ethernet: smsc: remove unnecessary (void*) conversions
>>    net: mdio: Remove unnecessary (void*) conversions
>>    can: ems_pci: Remove unnecessary (void*) conversions
>>    net: bna: Remove unnecessary (void*) conversions
>>
>>   drivers/net/can/sja1000/ems_pci.c             |  6 +++---
>>   .../aquantia/atlantic/hw_atl2/hw_atl2.c       | 12 ++++++------
>>   .../atlantic/hw_atl2/hw_atl2_utils_fw.c       |  2 +-
>>   drivers/net/ethernet/brocade/bna/bnad.c       | 19 +++++++++----------
>>   .../ethernet/hisilicon/hns3/hns3_ethtool.c    |  2 +-
>>   drivers/net/ethernet/hisilicon/hns_mdio.c     | 10 +++++-----
>>   drivers/net/ethernet/intel/ice/ice_main.c     |  4 ++--
>>   drivers/net/ethernet/smsc/smsc911x.c          |  4 ++--
>>   drivers/net/ethernet/smsc/smsc9420.c          |  4 ++--
>>   drivers/net/mdio/mdio-xgene.c                 |  4 ++--
>>   drivers/net/ppp/pppoe.c                       |  4 ++--
>>   drivers/net/ppp/pptp.c                        |  4 ++--
>>   drivers/net/wan/fsl_ucc_hdlc.c                |  6 +++---
>>   13 files changed, 40 insertions(+), 41 deletions(-)
