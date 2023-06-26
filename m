Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F93073DFD3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjFZMvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjFZMvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:51:31 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C81BE74
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 05:49:57 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qDleu-0002pe-MZ; Mon, 26 Jun 2023 14:49:32 +0200
Message-ID: <6a0c3aa0-86a8-8c06-81df-2d7085946cf5@leemhuis.info>
Date:   Mon, 26 Jun 2023 14:49:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: ath11k: QCN9074: ce desc not available for wmi command
Content-Language: en-US, de-DE
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Atheros 11K <ath11k@lists.infradead.org>
References: <1326a6e4-758d-3344-d90c-8a126748b034@gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <1326a6e4-758d-3344-d90c-8a126748b034@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1687783797;e36ddafd;
X-HE-SMSGID: 1qDleu-0002pe-MZ
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
for once, to make this easily accessible to everyone.

Hmmm, there afaics was no real progress and not even a single reply from
a developer (neither here or in bugzilla) since the issue was reported
~10 days ago. :-/

Manikanta, did you maybe just miss that this is caused by change of
yours (and thus is something you should look into)?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

On 15.06.23 09:07, Bagas Sanjaya wrote:
> Hi,
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
>> Hello, 
>>
>> We are trying to connect 2x QCN9074 together (one as AP, the other as client). 
>>
>> Using Ubuntu 22.04 hwe 5.19 generic kernel allows to pair both units in 800.11ac 80MHz only. Any other combinations of 802.11ax or ac/ax with 160MHz bandwidth does not work. The client kernel freezes when associating to QCN9074 AP without specific logs and requires reboot. I'll post another bug once I can get more logs. 
>>
>> Since quite some patches came through since 5.19 - some of them related to 160MHz bandwidth. I tried multiple newer mainline kernels without success and usually the same error. 
>>
>> Building kernel from latest ath master branch: 6.4.0-rc4-wt-ath+ gives the following dmesg output:
>>
>> [  353.587072] ath11k_pci 0000:04:00.0: BAR 0: assigned [mem 0xa4200000-0xa43fffff 64bit]
>> [  353.587180] ath11k_pci 0000:04:00.0: MSI vectors: 1
>> [  353.587186] ath11k_pci 0000:04:00.0: qcn9074 hw1.0
>> [  353.741799] mhi mhi0: Requested to power ON
>> [  353.741806] mhi mhi0: Power on setup success
>> [  353.912479] mhi mhi0: Wait for device to enter SBL or Mission mode
>> [  354.007221] ath11k_pci 0000:04:00.0: chip_id 0x0 chip_family 0x0 board_id 0xff soc_id 0xffffffff
>> [  354.007225] ath11k_pci 0000:04:00.0: fw_version 0x2403072e fw_build_timestamp 2021-06-06 23:27 fw_build_id 
>> [  355.333791] ath11k_pci 0000:04:00.0: leaving PCI ASPM disabled to avoid MHI M2 problems
>> [  355.729786] ath11k_pci 0000:04:00.0 wlp4s0: renamed from wlan0
>> [  358.960477] ath11k_pci 0000:04:00.0: ce desc not available for wmi command 36866
>> [  358.960481] ath11k_pci 0000:04:00.0: failed to send WMI_STA_POWERSAVE_PARAM_CMDID
>> [  358.960484] ath11k_pci 0000:04:00.0: could not set uapsd params -105
>> [  358.960485] ath11k_pci 0000:04:00.0: failed to set sta uapsd: -105
>> [  362.032472] ath11k_pci 0000:04:00.0: ce desc not available for wmi command 90113
>> [  362.032477] ath11k_pci 0000:04:00.0: failed to send WMI_REQUEST_STATS cmd
>> [  362.032479] ath11k_pci 0000:04:00.0: could not request fw stats (-105)
>> [  362.032480] ath11k_pci 0000:04:00.0: failed to request fw pdev stats: -105
>> [  365.104479] ath11k_pci 0000:04:00.0: ce desc not available for wmi command 20482
>> [  365.104483] ath11k_pci 0000:04:00.0: failed to submit WMI_VDEV_DELETE_CMDID
>> [  365.104485] ath11k_pci 0000:04:00.0: failed to delete WMI vdev 0: -105
>> [  365.104487] ath11k_pci 0000:04:00.0: failed to delete vdev 0: -105
>> [  368.176472] ath11k_pci 0000:04:00.0: ce desc not available for wmi command 16387
>> [  368.176476] ath11k_pci 0000:04:00.0: failed to send WMI_PDEV_SET_PARAM cmd
>> [  368.176479] ath11k_pci 0000:04:00.0: failed to enable PMF QOS: (-105
>> [  371.248474] ath11k_pci 0000:04:00.0: ce desc not available for wmi command 16387
>> [  371.248478] ath11k_pci 0000:04:00.0: failed to send WMI_PDEV_SET_PARAM cmd
>> [  371.248480] ath11k_pci 0000:04:00.0: failed to enable PMF QOS: (-105
>> [  374.320393] ath11k_pci 0000:04:00.0: ce desc not available for wmi command 16387
>> [  374.320397] ath11k_pci 0000:04:00.0: failed to send WMI_PDEV_SET_PARAM cmd
>> [  374.320400] ath11k_pci 0000:04:00.0: failed to enable PMF QOS: (-105
>>
>> Both PCs are Intel x86 (same bug for AMD). We have multiple references of QCN9074 that we tested:
>> - Sparklan WPEQ-405AX (our preferred one, as they are the only vendor I know that went through FCC certification) - This unit can associate to APs only with the firmware Sparklan provided. Otherwise, link strength is reported low and barely no APs are listed after scanning.
>> - Emwicon WMX7406 - has better performances with Sparklan's vendor FW. Works with ath11k-firmware 2.7.0.1 but shows lower TX mostly.
>>
>> Tested FW (non exhaustive):
>> # ath11k-firmware 2.5.0.1
>> 823915206101779f8cab6b89066e1040  /lib/firmware/ath11k/QCN9074/hw1.0/amss.bin
>> 668f53050a92db5b4281ae5f26c7e35d  /lib/firmware/ath11k/QCN9074/hw1.0/board-2.bin
>> fcca36959c5f56f9f0fb7015083dc806  /lib/firmware/ath11k/QCN9074/hw1.0/m3.bin
>>
>> # ath11k-firmware 2.7.0.1
>> 465d0a063d049f7e4b79d267a035c6c7  /lib/firmware/ath11k/QCN9074/hw1.0/amss.bin
>> 668f53050a92db5b4281ae5f26c7e35d  /lib/firmware/ath11k/QCN9074/hw1.0/board-2.bin
>> ad8fafb9c1deab744c972469be916e72  /lib/firmware/ath11k/QCN9074/hw1.0/m3.bin
>>
>> # Vendor firmware 
>> 1e88ff2e2b5bcf7f130397cb5b21ef39  /lib/firmware/ath11k/QCN9074/hw1.0/amss.bin
>> 7b3ce8686713a724946466ec1fefc2f4  /lib/firmware/ath11k/QCN9074/hw1.0/board.bin
>> d0a6f7ccd52f9e3886f0bc96309f7b9a  /lib/firmware/ath11k/QCN9074/hw1.0/m3.bin
>>
>>
>> Attached dmesg log with ath11k debug_mask=0xFFFF and lspci. 
>>
>> Thank you
> 
> See Bugzilla for the full thread and attached dmesg.
> 
> Manikanta: This regression is apparently caused by a commit of yours.
> Would you like to take a look on it?
> 
> Anyway, I'm adding it to regzbot:
> 
> #regzbot introduced: 13aa2fb692d371 https://bugzilla.kernel.org/show_bug.cgi?id=217536
> #regzbot title: Threaded NAPI causes ce desc unavailable error on ath11k
> 
> Thanks.
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217536
> 
