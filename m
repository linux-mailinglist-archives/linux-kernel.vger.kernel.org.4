Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9523639694
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 15:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiKZOmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 09:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiKZOmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 09:42:39 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09938BD0;
        Sat, 26 Nov 2022 06:42:34 -0800 (PST)
Received: from [192.168.1.139] ([37.4.248.27]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MiJhQ-1oUqQd2vmY-00fQ6v; Sat, 26 Nov 2022 15:42:13 +0100
Message-ID: <fc2fb888-7742-123c-69c9-cdb156ff2d9f@i2se.com>
Date:   Sat, 26 Nov 2022 15:42:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 00/14] staging: vc04_services: bcm2835-isp support
To:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Naushir Patuck <naush@raspberrypi.com>,
        David Plowman <david.plowman@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20221121214722.22563-1-umang.jain@ideasonboard.com>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20221121214722.22563-1-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:8slHj8WkDJRsqxXk3QgZmn+S+i3YLVteMlITc3PvYqzk28jedC4
 rj+rgBgwyecIyhEY4Efl+Zfh71iJxNfpynuMMa2KESZQD17AFit04t2abBWBCsfPtUHGl0e
 6uH8OtSC1EzFomt97H52CLwfecfNMdCB0RMWx0yX/1/EYq22l5kuU98K6nekJY6pw5PsViJ
 UJpNLSKyHBWqQ09sF1UlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iN8eChRQexM=:3hd2ZDNNSqzS7KHNr8NdqF
 LQ/eFh9Fti6fu91n8lVXq0EOySvmQcpWmhNU/LC7XxpOoqCkWNsXuM/wZ75+puxH8ekhsaVG2
 oRCt4Ir84rExF11FFCnSHBkoHpTazm7tmUnaZalBcJIC2zOJfZHUdy4SLgu0Q00fa4ZIrIPhS
 qQa9sGtYfbkuBqTVAcT+xXjdJteXbYtAyfkjNy3NoBHQZfBgHCguKmhNmeFqwwdtcb1S16Y5k
 qZc3pu6zoWKHwWoOQkdcKa2WQ7xjatRyWmrxZsjE0DpQoyTeRlO9PZNjIrTUs9vYQWjEN+DFG
 Hzh2JK+SMckmUUGb1E5s/qJQPBdV21ZwgyY8zqehK71NZ8czVB/uNZXwoa+pqivKvCOVW87tz
 etzKXvISd0JF5TdSA960dS5ydQf7YQMZGoaMlr2pH0BRRiYVzVwJZQFjFqtLKVWVUIC6LYeXo
 tRHdCvbU9+UhB6v0dGphWRCcM1dwuVNuMrRtyH1s8jMudszKh+9KKu6GtL+njuOtPnCdlmXwG
 LNOjeKF+ynPBWpy8rCa8bTwKKHUGNKO8ZR5/faASSaeGqzz8j+Ha53RDoDomXdladzw/Cd8Kg
 jTrMAm1/KaUtCWd36d7/3ys2sgywHIc0Cm7UL32NhtwtokEETFpHAbGiKWCRW/7Dj/gd4jWOA
 R26SPQEU/SsLsqDPPdAFE4x70CE+BtnvnMyRr9G62OTjNe+m4g3ggLE/NNZGK6PlSB3qCDD2r
 29y5mlmFZK+5RHFemcVNxZvewO5N3Zr92kfXCuM2rYAY3htcZFJOXpOCZEdjHcdqPAUGmMf3y
 pDcqGpJUlrlx2sQyo0is3Xaj/lufg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

Am 21.11.22 um 22:47 schrieb Umang Jain:
> This series aims to upport bcm2835-isp from the RPi kernel [1] and is a
> independent subset of earlier series [2] posted to upport CSI-2/CCP2
> receiver IP core("Unicam) + the ISP driver found in BCM283x and compatible
> SoCs (namely BCM2711). Unicam is still under active development to work
> with multistream support to get into mainline. Hence only the ISP driver
> will remain the primary area of this series.

thanks for working on this. But honestly i would prefer that vchiq comes 
out of staging before adding more features. As Greg said some time ago 
staging is not a place to "dump code and run away". These new files are 
in the same bad shape as the rest of vc04 before the clean-up here in 
staging started.

I agree that VCSM is on the TODO list for vchiq, but this driver is not 
necessary for making bcm2835-audio & bcm2835-camera leave staging. It 
just binds more resources on a new feature.

Unfortuntately i hadn't much time to work on vchiq by myself.

Just my two cents
Stefan

