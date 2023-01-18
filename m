Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D72367259D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjARRzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjARRzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:55:17 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18814DE0A;
        Wed, 18 Jan 2023 09:55:15 -0800 (PST)
Received: from [192.168.1.139] ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MLR5f-1p1UqQ3tIZ-00IXeC; Wed, 18 Jan 2023 18:54:58 +0100
Message-ID: <b1a26368-3753-0d32-434b-e220dd9c06b4@i2se.com>
Date:   Wed, 18 Jan 2023 18:54:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH 0/4] Drop custom logging
Content-Language: en-US
To:     Umang Jain <umang.jain@ideasonboard.com>,
        Phil Elwell <phil@raspberrypi.com>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rpi-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org
References: <20230118115810.21979-1-umang.jain@ideasonboard.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20230118115810.21979-1-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:PPbgUQZFNUodbOa/IggBR+CuQHji8sAXXNDLVRn1143oRxT7xED
 oBPVjhAXF+2WpKzkRm4MQNfrIjnzaJebYqOE/6rYL3j6lOz5jmJWSxyrAjaj1sGD2m0ETY6
 iTe9JYVwS+M0pEMCx1zuHc0xGHJbUiNWQPjjosOz3DSRySOI1stuI/RuwSxOjSHMG6me5lq
 /2JUSPHLjD+GAtFhwLEAg==
UI-OutboundReport: notjunk:1;M01:P0:DWEOI3VL3Ug=;wI/vhD4uuwEVFEsH0pX9CDJFtYa
 uWnuMR4vZvcCph2wMaDVAeHGw7tutiLNnsXoaL5wEC7Xhrweux6VyrbZbeuxPcBTWuO9Ia2f2
 emFeNBgDNzxBxFLkxJyLCGyQtdJ83JFU0x0CGxRbicdQGU2/XnxX1zYeddRCna7ExVYdnUaaA
 AnakOEj3ayX7pxKcV7zh1fZ8O8Sb6YWRUOWwkJpPTAmgVO6qtRRc8cBSZDlijQLG2FQ4r47lP
 ASkwsgmhksnQyf+cngn4hCvCvQP6cuvicELX7j1VU+5tpyKocbq01niWMcP5bRghBserJxb+P
 Wz6wtTInBxyrzi7zi+TNl29U7CnNEXIS4aY7a7Aa62ejUbE21aZymKOl5qKiWpRNXwR4K7AMn
 zdJ6ApGksqEJg+Fx1ZXSAr9SUE5PsZcuJfx3PSVO+9VdCTrUy0JMYHVakQOeflkiTi5JjVVST
 ygfk9iNGBqmSV7BJA7y18L9yyoKEDWk7dfndWoVf+w6FayYSiDWNUB1CMglSIpGbQ0NFS2P32
 DyNRQSF5pk1ZOL1jtayWI/PoLJ5HizakEiXlc7k8u8YuDzYLDSJTOa3snLfkoj1P8KERwFnyl
 nfvbJhxQNM6L3+//JEdBiUnZ07wHv0dhPz1fy3FXGOkY9nbCCuS+mHICw6hkCN9tbW/2K2MMJ
 BOd33NuDl/1/K2RMP6zncYFLkebgxHvpjAL7Dibfrw==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

[add Phil]

Am 18.01.23 um 12:58 schrieb Umang Jain:
> Drop custom logging from the vchiq interface.
> Mostly of them are replaced with dev_dbg and friends
> and/or pr_info and friends.
>
> The debugfs log levels (in 4/4) are mapped to kernel
> logs levels (coming from include/linux/kern_levels.h)
> Would like some thoughts on it as I am not sure (hence
> marking this is RFC)
>
>  From drivers/staging/vc04_services/interface/TODO:
>
> """
> * Cleanup logging mechanism
>
> The driver should probably be using the standard kernel logging mechanisms
> such as dev_info, dev_dbg, and friends.

i don't have any experience with vchiq logging/debug. So i'm not sure if 
it's acceptable to lose the second log level dimension (like 
vchiq_arm_log_level) completely. Complex drivers like brcmfmac have a 
debug mask to avoid log spamming [1]. Maybe this is a compromise.

Btw some loglevel locations has already been messed up during 
refactoring :-(

[1] - drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.h

> """
>
> Umang Jain (4):
>    staging: vc04_services: vchiq_core: Drop custom logging
>    staging: vc04_services: vchiq_arm: Drop custom logging
>    staging: vc04_services: Drop custom logging
>    staging: vc04_services: Drop remnants of custom logging
>
>   .../interface/vchiq_arm/vchiq_arm.c           | 151 +++---
>   .../interface/vchiq_arm/vchiq_connected.c     |   5 +-
>   .../interface/vchiq_arm/vchiq_core.c          | 479 ++++++++----------
>   .../interface/vchiq_arm/vchiq_core.h          |  39 --
>   .../interface/vchiq_arm/vchiq_debugfs.c       |  26 +-
>   .../interface/vchiq_arm/vchiq_dev.c           |  78 ++-
>   6 files changed, 329 insertions(+), 449 deletions(-)
>
