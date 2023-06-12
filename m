Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC0372C9C1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjFLPUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbjFLPUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:20:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69751705;
        Mon, 12 Jun 2023 08:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1686583226; x=1687188026; i=rwarsow@gmx.de;
 bh=CTbSSfxY3kwk/PDnha0lpZWM9kMKcGyyGiwQVSgcCH0=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=rtqklPkTOVWJ3LE2LHT74SDHVQXfvyhcx+WRjT29+/Q1K1HGUqCgtAmPC4EXxJPY9Q7w8eN
 4zL5fvt92QmLLNmpKnP2pARlHF7ccSpVQY5ZNnXDdDktPmc4+UW/taM5m5MUQcjSbc8nWHfMc
 tayz24NiaJk36umT0oFFq7EYfFrMSwz8XJ/8Mlx2gnKGPBOfj8V2aHltwYNao3mEukZEk3tmO
 ItXhxLQG/PGdEoRrbR8gE/VpTl40JnbQyorr2afKii4ajNkuLmRu7sFV5qzGtmM6gzWJGm6ZZ
 LQxuAz0iEWCHXuYvvDujNcJo6VKgUyrSdSpmCNjxuNw73Dtuekzw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.32.67]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGQjH-1qMhpE3YBZ-00GoiK; Mon, 12
 Jun 2023 17:20:25 +0200
Message-ID: <7a55c05b-5ca7-aac9-62c5-7ddc2810ea14@gmx.de>
Date:   Mon, 12 Jun 2023 17:20:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Ronald Warsow <rwarsow@gmx.de>
To:     linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.3 000/160] 6.3.8-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:sDF+geswHiNmH9Gycio8sVRbbwWn9UL6dVJt3nemJKftxkQvKZ7
 cahUgcJWcAKGK4KSz0EVOw3Dc/aII3JhbhYcxrKtge+YN7noTsDkz3r7a8LXZooKJjEIP8k
 B6BtIU+wmO3+5hCgMu9IIcWIK0dsDJ2o64BsTaS9Z7l33z2mIUwGRKA+7bOLaQPGdy7CaCL
 EjxjJGQ3I08WBIMYMyb8Q==
UI-OutboundReport: notjunk:1;M01:P0:8RwaNaZjgpU=;wDa/q+LoKaVKBCr/WOFjQT4ZVoD
 /Z/xoskaKWzfEWgVcDKwQq3KxotXMJz+YAUbhi5VLe4WYZkCCWnqUjVKeavcduTsomniNqQWj
 /thyPQzsMKSZC/3sccZZFQI9sGCRf07v1RLZhp2jjaqu3YeVoJ3vZVignulSAV/9mbFtpvavw
 vDr3PHgi0PmzGpqW3+p/VsrYSnJODraRX4UdyJnes2cRPuM108EydBUehQEl0/0mo915t9DFd
 1G6/5c9EsVPWJo0jzLSWsk5drywO4Nq+oSOzPOCiUptovfXoEM8vcrRmKkJLwM2KCHUARpUkR
 T/Gg7nHMfptUhaX7XHNy8ZBKLh6uSlh5Fn6+v4iqiuY/F5/6bNTEd641CP+I0MOJCeICCps2U
 VUyfRN8/4WqqwVBDtFn+1SVKhhec3PzTl+5W9ud9s0GMkfEjNjmHcpxy6OcxfZIJOB1muIKYf
 /lO4KIyl1oHeNxMkvx2wKr+cGroP2CeVnw14zzt2V/OrCVzzhp8M40+ZcsPIprq/Q3pFu2lJS
 9fWqMKBn2CnO3u9FxvUzDRgmPwJUgzRxp1i7vLauqvI+fpg0rvvxWeTry5PQ2qeA1GkEtANBO
 UL3aQuKf73NypdcD/xsw7XsAP8hZTZAijvyHstedemVmlW35GCpUp+5+wDstVuqtplSYjt8lc
 chQIJOZw24+ECPiu7GrkAeHZV4hu+FbSrCziKrkI0agYWAK0Y6my8Bcydj0Z7Iw3HFZK8bwWS
 s5jp8jby7mQFAPcwo687DzwxO4FX7Uz3Glhm67f1cBvTkONDnr4WAYEDDwmLJi4fY8PXeLSs1
 y3uZQmZG6OXccAJqzRphOJoKuPOc9WtCuszuJ/oo0zcutAbSkdw5BgFZZJejxVYHMZJI4MjHW
 iPM2GbNKG/27MV+RT0cPRB9RppZKfO//D/kAUnIZXoumZ8na9gLuDqCg1EIvTNFzACSlnFAMU
 KDiDbg==
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_A1,FREEMAIL_FROM,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

6.3.8-rc1

compiles, boots and runs here on x86_64
(Intel Rocket Lake)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>
