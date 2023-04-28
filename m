Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FDF6F1758
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 14:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjD1MQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 08:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjD1MQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 08:16:21 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7256C26BE;
        Fri, 28 Apr 2023 05:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1682684178; i=rwarsow@gmx.de;
        bh=U61VL+R9qXZXz8zEpO5w4R815bB52iRHgSNGMkFPRtc=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=cNmKA5PtjFL9QnPdrqsKdg2GdiUum/kBKyclJhuFJqvee1BuUy9BH+IxDzmsB/EEQ
         WUcGSX435oYu9f53sq6U7GJm/Gvm605U4T1klTpw2U1p2mLmF1FV/EBLLupoDkMvAN
         tkdugy/Rp1kJknw7WcBC183X4am2z/S7Nl+xyEGHHw5qZYArHSgmpiP6RWpHrosV7m
         9bwgKxq3AKoYeVcCp9fTteJsz9MJ639Rj9THekbMw7Tt12jasA0ndVoZ5zTH7xjyVp
         Wtafxxw6zWPAqJzqqRw6PNKcSpZM/yfPX8/d2QkGbLFE33ksYBjr8L1gf96b+jvVvE
         10NjOKk6dyNQg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.34.199]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMofW-1pbwdK2JKm-00IlIf; Fri, 28
 Apr 2023 14:16:18 +0200
Message-ID: <4e68dad2-1be3-a240-43ff-f760bed52c37@gmx.de>
Date:   Fri, 28 Apr 2023 14:16:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Ronald Warsow <rwarsow@gmx.de>
To:     linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.3 00/11] 6.3.1-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ysulilftoIZ+QNOeLlscav8vs1qW6+esAivulp7ndDizkf/avqH
 ih0lYt3HW1nfgHe4FK+PCUwmI3w7noHHaFIKIkeLt6jVBGaFNV/3lN8L4nHvGQWphUGEbCi
 tYyyu2T/ladHDBNHD9h+zhQQvbV+WWbNrjDAkLJIvDBeO7d5e0OZm+6vUCOtSjZG6+psDIo
 q41654hdXWLXEsrfx32Yg==
UI-OutboundReport: notjunk:1;M01:P0:oko3RoHi/4Y=;SfeCfvfYJNp+aDNTctDx568kHht
 P1uqOo9dWxnMbTb6ekTCmFDgzOJkfFTUQc9Ejn7iGYJ8/GJxGHWtADnK2BmBtZpqQiHq7uC/3
 h7Z9GCfEY2TxahV0AbHSWHmFbwSoe0ACVI/JAHhsb5biLFrsdMK1A04z6MzsM8SLhK21OY3rU
 t17SqQVm7v3ROPIrUWB6Na9ZyIxSTh9ZXlSjXbduVxHzkYdBurYXy3iRhUc59XVT9UWBvgjDN
 IdXYtI8wZfPZ8OslaEiLGK5ytVPn5GqE3oc/7brluKxZ6ORjcBvt/sL9mV34XYg/zizAvowSN
 HXo1JTBW7A5dCF2mzyV9kiNOck2VEZ3tN74hTNLXkiEytw0H0SLGWn0lCXpxg8JPhUlEYGtOf
 nAf8zN9FGT2odu8MmJmnjAfnPPUynvfV3ujOwqwUBATqDASxz1yLyMm4ZcItifL8pkjL4sAnN
 Ipsp98Ez6ncJ0CnONyW5AFL3PaMHUljW5iQjQTGLaxObYVeobbqPF1PJoMEwyb9Nbff4A9Tci
 Jn2TqBK6dM7mayjpj7tq0Xv/pZWrtgLvOF/vMgF+7FCdszYiyiq1idj4S5+oTmNLyE6xyLewo
 qQJu/mPzKuCS32+xbUG6XR4+xl3rZ8b2MoznUtXvurSuoeKhMO00damJG42VMIQyTSn1BxQDZ
 zqfzqWPhEJGSwT3clP6s5jkgEMyHxbJtuaWcsHIyARv9DvmvbQMoRqbGAFQt1MmM0O7d2+co3
 qARINgRz+jU8oavDZb1Nmf2Um3iQxvp6wGd+PPbZSSCdRTkOMur+24UbNFoGl+WfFkl3xoDTu
 FdJqvAIOCrg6PQQTA+9tSqkJxxAATW1l++AFHaF2AwAi+9Xj11iQ7L9JVca84Q5rbaS/2Hafa
 n+H6oVmkHTgEWOsSKupx/SKyt4F2UG4BDkmp1KdoUFVMemspotj1PGa2iFgvMdhzdzNql/4tS
 f1gB8RN9AfRFlQo+PEVK2Z6DW/o=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

6.3.1-rc1

compiles, boots and runs here on x86_64
(exactly: Intel i5-11400, Fedora 38)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>
