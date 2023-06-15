Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4678B73102A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243116AbjFOHIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjFOHHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:07:50 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE46297B
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:07:30 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b517ee9157so2193595ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686812849; x=1689404849;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/XYFZNhQhLPndaLiIE3HiydrBYKKYSw5+7Q2Iga72GE=;
        b=QffQjV5jdnIxPDfXyY+XAo4ikT59dZOrHS8Ci9EpL3ZVmwHVbRrlDq0uOoaqbQX0Ue
         HDZdI0yQ3l3fhvEbgOyROCSY3+q553kB7qLI7mmo+quJhpu0JR95SfUlNOzIxvs/5tXE
         ayDjDKtE1dbzRoK43PRcNM9xR96+DKZHc6gBrk3/2xFPl+evWDTGLvRfUSH2k7qtqkvU
         I8NDJDlJzp8X3YoQY3nWYnSKueyaAYbU5WhgSENyeq8mlPeXVO4v3qRS9IpbBeaOw9Xb
         Row6srUPosBQroYqRoQ+Mu7r6ck4g7YI8outObv7p/uA+cMuSZ/8PUYLDG3XvDTx50Pe
         5U4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686812849; x=1689404849;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/XYFZNhQhLPndaLiIE3HiydrBYKKYSw5+7Q2Iga72GE=;
        b=jxiPaAJoXf7dH9fXh79Od2AiF/PWtLSu6oSMz0+0FIpd9Ap2aZbQP+vcwnts+JcbsO
         vuyNiWX2lLT7VkIFEGQ21mP5ihBXUiwS1izq4IRwQNn3QZC32q5iWKVuRSc5eCokv6AL
         dA6/Hb9lEOb+4yldS6SzrV7S+GoDEw4WGDm9zo40XrYQdWnvmHJwMR7vkOwIN6ovC49j
         GE8RKCDypGGuVjgBhcUfAuhWHtoR6A2Y2rEOrv/yJsng8O8nTBwrsvZSw9Wp6ErQR2EY
         KzteanQKFZ/bIkncTwhuKn5hyYy9UYu51dNai9lCPKwXFgpnHRF8synXyj+v6htQ31dG
         cJEw==
X-Gm-Message-State: AC+VfDwNNkCfQJNSfyG1fiV/3HL+TLPT+8RDCDVzYwZY9dCZeVRQJYAO
        4cdMXAfcIaQcleaSGP0jwoo=
X-Google-Smtp-Source: ACHHUZ5KArXvwmpPvjWJRsoIdcMTJrLgfD8jhLDG9rWLArrFTfLpS19d0IHExAAscENLa5ipZ/+sgg==
X-Received: by 2002:a17:902:930c:b0:1ab:19db:f2b with SMTP id bc12-20020a170902930c00b001ab19db0f2bmr12869315plb.36.1686812849397;
        Thu, 15 Jun 2023 00:07:29 -0700 (PDT)
Received: from [192.168.0.103] ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id m4-20020a1709026bc400b001ac5896e96esm1181351plt.207.2023.06.15.00.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 00:07:28 -0700 (PDT)
Message-ID: <1326a6e4-758d-3344-d90c-8a126748b034@gmail.com>
Date:   Thu, 15 Jun 2023 14:07:19 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Atheros 11K <ath11k@lists.infradead.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: ath11k: QCN9074: ce desc not available for wmi command
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> Hello, 
> 
> We are trying to connect 2x QCN9074 together (one as AP, the other as client). 
> 
> Using Ubuntu 22.04 hwe 5.19 generic kernel allows to pair both units in 800.11ac 80MHz only. Any other combinations of 802.11ax or ac/ax with 160MHz bandwidth does not work. The client kernel freezes when associating to QCN9074 AP without specific logs and requires reboot. I'll post another bug once I can get more logs. 
> 
> Since quite some patches came through since 5.19 - some of them related to 160MHz bandwidth. I tried multiple newer mainline kernels without success and usually the same error. 
> 
> Building kernel from latest ath master branch: 6.4.0-rc4-wt-ath+ gives the following dmesg output:
> 
> [  353.587072] ath11k_pci 0000:04:00.0: BAR 0: assigned [mem 0xa4200000-0xa43fffff 64bit]
> [  353.587180] ath11k_pci 0000:04:00.0: MSI vectors: 1
> [  353.587186] ath11k_pci 0000:04:00.0: qcn9074 hw1.0
> [  353.741799] mhi mhi0: Requested to power ON
> [  353.741806] mhi mhi0: Power on setup success
> [  353.912479] mhi mhi0: Wait for device to enter SBL or Mission mode
> [  354.007221] ath11k_pci 0000:04:00.0: chip_id 0x0 chip_family 0x0 board_id 0xff soc_id 0xffffffff
> [  354.007225] ath11k_pci 0000:04:00.0: fw_version 0x2403072e fw_build_timestamp 2021-06-06 23:27 fw_build_id 
> [  355.333791] ath11k_pci 0000:04:00.0: leaving PCI ASPM disabled to avoid MHI M2 problems
> [  355.729786] ath11k_pci 0000:04:00.0 wlp4s0: renamed from wlan0
> [  358.960477] ath11k_pci 0000:04:00.0: ce desc not available for wmi command 36866
> [  358.960481] ath11k_pci 0000:04:00.0: failed to send WMI_STA_POWERSAVE_PARAM_CMDID
> [  358.960484] ath11k_pci 0000:04:00.0: could not set uapsd params -105
> [  358.960485] ath11k_pci 0000:04:00.0: failed to set sta uapsd: -105
> [  362.032472] ath11k_pci 0000:04:00.0: ce desc not available for wmi command 90113
> [  362.032477] ath11k_pci 0000:04:00.0: failed to send WMI_REQUEST_STATS cmd
> [  362.032479] ath11k_pci 0000:04:00.0: could not request fw stats (-105)
> [  362.032480] ath11k_pci 0000:04:00.0: failed to request fw pdev stats: -105
> [  365.104479] ath11k_pci 0000:04:00.0: ce desc not available for wmi command 20482
> [  365.104483] ath11k_pci 0000:04:00.0: failed to submit WMI_VDEV_DELETE_CMDID
> [  365.104485] ath11k_pci 0000:04:00.0: failed to delete WMI vdev 0: -105
> [  365.104487] ath11k_pci 0000:04:00.0: failed to delete vdev 0: -105
> [  368.176472] ath11k_pci 0000:04:00.0: ce desc not available for wmi command 16387
> [  368.176476] ath11k_pci 0000:04:00.0: failed to send WMI_PDEV_SET_PARAM cmd
> [  368.176479] ath11k_pci 0000:04:00.0: failed to enable PMF QOS: (-105
> [  371.248474] ath11k_pci 0000:04:00.0: ce desc not available for wmi command 16387
> [  371.248478] ath11k_pci 0000:04:00.0: failed to send WMI_PDEV_SET_PARAM cmd
> [  371.248480] ath11k_pci 0000:04:00.0: failed to enable PMF QOS: (-105
> [  374.320393] ath11k_pci 0000:04:00.0: ce desc not available for wmi command 16387
> [  374.320397] ath11k_pci 0000:04:00.0: failed to send WMI_PDEV_SET_PARAM cmd
> [  374.320400] ath11k_pci 0000:04:00.0: failed to enable PMF QOS: (-105
> 
> Both PCs are Intel x86 (same bug for AMD). We have multiple references of QCN9074 that we tested:
> - Sparklan WPEQ-405AX (our preferred one, as they are the only vendor I know that went through FCC certification) - This unit can associate to APs only with the firmware Sparklan provided. Otherwise, link strength is reported low and barely no APs are listed after scanning.
> - Emwicon WMX7406 - has better performances with Sparklan's vendor FW. Works with ath11k-firmware 2.7.0.1 but shows lower TX mostly.
> 
> Tested FW (non exhaustive):
> # ath11k-firmware 2.5.0.1
> 823915206101779f8cab6b89066e1040  /lib/firmware/ath11k/QCN9074/hw1.0/amss.bin
> 668f53050a92db5b4281ae5f26c7e35d  /lib/firmware/ath11k/QCN9074/hw1.0/board-2.bin
> fcca36959c5f56f9f0fb7015083dc806  /lib/firmware/ath11k/QCN9074/hw1.0/m3.bin
> 
> # ath11k-firmware 2.7.0.1
> 465d0a063d049f7e4b79d267a035c6c7  /lib/firmware/ath11k/QCN9074/hw1.0/amss.bin
> 668f53050a92db5b4281ae5f26c7e35d  /lib/firmware/ath11k/QCN9074/hw1.0/board-2.bin
> ad8fafb9c1deab744c972469be916e72  /lib/firmware/ath11k/QCN9074/hw1.0/m3.bin
> 
> # Vendor firmware 
> 1e88ff2e2b5bcf7f130397cb5b21ef39  /lib/firmware/ath11k/QCN9074/hw1.0/amss.bin
> 7b3ce8686713a724946466ec1fefc2f4  /lib/firmware/ath11k/QCN9074/hw1.0/board.bin
> d0a6f7ccd52f9e3886f0bc96309f7b9a  /lib/firmware/ath11k/QCN9074/hw1.0/m3.bin
> 
> 
> Attached dmesg log with ath11k debug_mask=0xFFFF and lspci. 
> 
> Thank you

See Bugzilla for the full thread and attached dmesg.

Manikanta: This regression is apparently caused by a commit of yours.
Would you like to take a look on it?

Anyway, I'm adding it to regzbot:

#regzbot introduced: 13aa2fb692d371 https://bugzilla.kernel.org/show_bug.cgi?id=217536
#regzbot title: Threaded NAPI causes ce desc unavailable error on ath11k

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217536

-- 
An old man doll... just what I always wanted! - Clara
