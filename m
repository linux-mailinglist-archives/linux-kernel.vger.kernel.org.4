Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94AC174AE0D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 11:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjGGJsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 05:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjGGJsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 05:48:46 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050ED2125;
        Fri,  7 Jul 2023 02:48:41 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qHi4q-0004Vb-G6; Fri, 07 Jul 2023 11:48:36 +0200
Message-ID: <bf9a48ff-5427-50a5-0ec8-df12734c696e@leemhuis.info>
Date:   Fri, 7 Jul 2023 11:48:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Linux-6.5 iwlwifi crash
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Jeff Chua <jeff.chua.linux@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        lkml <linux-kernel@vger.kernel.org>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
References: <20230429020951.082353595@lindbergh.monkeyblade.net>
 <CAAJw_ZueYAHQtM++4259TXcxQ_btcRQKiX93u85WEs2b2p19wA@mail.gmail.com>
 <ZE0kndhsXNBIb1g7@debian.me> <b9ab37d2-42bf-cc31-a2c0-a9b604e95530@gmail.com>
 <CAAJw_Zug6VCS5ZqTWaFSr9sd85k=tyPm9DEE+mV=AKoECZM+sQ@mail.gmail.com>
 <7fee3284-b9ba-58f4-8118-fe0b99ae6bf7@leemhuis.info>
 <CAAJw_Zu=MPtGPARgCB2fteP+7F793YDFXE9RuzSH8EqYBS-OOw@mail.gmail.com>
 <64b8732f-6319-9f10-b82a-b4a3dd8d4b8e@lwfinger.net>
 <CAAJw_ZvZNQzrFyQizJnKe5PerqqAUOmPYd6cnjAcvs68xNdwSA@mail.gmail.com>
 <ff646259-8ce1-f1fe-4627-cdf99321dba8@leemhuis.info>
In-Reply-To: <ff646259-8ce1-f1fe-4627-cdf99321dba8@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1688723322;1c32058d;
X-HE-SMSGID: 1qHi4q-0004Vb-G6
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.07.23 10:43, Linux regression tracking (Thorsten Leemhuis) wrote:
> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
> for once, to make this easily accessible to everyone.
> 
> Jeff, thx for bisecting. Johannes afaik is unavailable for a while
> (CCing him nevertheless), hence:
> [...]

Just noticed: there is a bug in bugzilla about this issue already. See
here: https://bugzilla.kernel.org/show_bug.cgi?id=217622

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.


> On 07.07.23 03:56, Jeff Chua wrote:
>> On Thu, Jul 6, 2023 at 2:11 AM Larry Finger <Larry.Finger@lwfinger.net> wrote:
>>
>>> Fow what it is worth, my 6.4-git (6.5-rc0?) commit d528014517f2 (pulled today)
>>> is working OK with iwlmvm. Lspci says my device is
>>>
>>> 04:00.0 Network controller [0280]: Intel Corporation Wireless 7260 [8086:08b1]
>>> (rev 73)
>>>
>>> I think you do need to do a bisection.
>>> Larry
>>
>>
>> Larry,
>>
>> I did a bisect and here's what it came up with ... reverted the
>> following and iwlwiifi worked again.
>>
>>
>> 19898ce9cf8a33e0ac35cb4c7f68de297cc93cb2 is the first bad commit
>> commit 19898ce9cf8a33e0ac35cb4c7f68de297cc93cb2
>> Author: Johannes Berg <johannes.berg@intel.com>
>> Date:   Wed Jun 21 13:12:07 2023 +0300
>>
>>     wifi: iwlwifi: split 22000.c into multiple files
>>
>>     Split the configuration list in 22000.c into four new files,
>>     per new device family, so we don't have this huge unusable
>>     file. Yes, this duplicates a few small things, but that's
>>     still much better than what we have now.
>>
>>     Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>>     Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
>>     Link: https://lore.kernel.org/r/20230621130443.7543603b2ee7.Ia8dd54216d341ef1ddc0531f2c9aa30d30536a5d@changeid
>>     Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>>
>>  drivers/net/wireless/intel/iwlwifi/Makefile     |   1 +
>>  drivers/net/wireless/intel/iwlwifi/cfg/22000.c  | 939 +-----------------------
>>  drivers/net/wireless/intel/iwlwifi/cfg/ax210.c  | 452 ++++++++++++
>>  drivers/net/wireless/intel/iwlwifi/cfg/bz.c     | 523 +++++++++++++
>>  drivers/net/wireless/intel/iwlwifi/cfg/sc.c     | 214 ++++++
>>  drivers/net/wireless/intel/iwlwifi/iwl-config.h |   2 +
>>  drivers/net/wireless/intel/iwlwifi/pcie/drv.c   |   3 +
>>  7 files changed, 1206 insertions(+), 928 deletions(-)
>>  create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
>>  create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/bz.c
>>  create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/sc.c
>>
>>
>> My best.,
>> Jeff
>>
>>>
>>>
>>
>>
