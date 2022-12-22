Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47145654692
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 20:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiLVT1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 14:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235460AbiLVT1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:27:21 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBC916497;
        Thu, 22 Dec 2022 11:27:19 -0800 (PST)
Received: from [192.168.1.139] ([37.4.248.22]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MWR6x-1pOhbD3gC3-00Xt8l; Thu, 22 Dec 2022 20:27:00 +0100
Message-ID: <a84537e0-0413-5d46-c37a-504480270548@i2se.com>
Date:   Thu, 22 Dec 2022 20:26:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 0/4] staging: vchiq: Rework child platform device
 (un)register
Content-Language: en-US
To:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adrien Thierry <athierry@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <error27@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20221222191500.515795-1-umang.jain@ideasonboard.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20221222191500.515795-1-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Ap+FkWHcNYNWYt1CpGgPE3HsUQXbFmR0jDqZcSozQNGHMZhYxJ+
 NzXHxFQTLt9WxBkZa50yuuYyr20NqiVD4+r5WMppsJxsr9lMg7/JcGYUsOEPLEpbmLB8gtc
 kt3jvTvR9soniLxfyM5RVQ2vQuAuw3i3mKYYJABdz8U+RZNka3ySyKNffEkTX76gspQERBg
 zkWhI6kaTM77fxJXOc59Q==
UI-OutboundReport: notjunk:1;M01:P0:7KilMkushd8=;wAAjO6Vqda0+dMhep/IXtPIhdjc
 D2RF5bA82mE/Niw1pL/77BGkASFqBMjdXMZDNtzV8+HOrIPYhYmOZwv07Ezw6Wg1FT+9bgv48
 2U05t5JofDj64ti7PuzZb4MGoAqWaexx7kXg+YxxFJy3YMFCMzSIGhiyu04jgfUtZfHh/j86D
 Q0A6XG1IvrOtPr9G3lswSPUOzUw9lDlNbPHoUtFK2Nsfn5TKtWpN1F7yrFSlSpvyD/XLpCYKj
 HBW2ZpW7Y52r5dGfxGWQHQIPSOkgFv4Vj/cT4qojgn5HPofepDNCI9gkeapq0O5CTVtLoqorq
 O0OJEQt0kIBzjExHAOHCAQnzf/Cs/cbnzkA8kuquO+oW/7gdsccwrT1VX1Z15AlCx7Oo5XkkY
 ZIfGbLLnT2AG8nTCFCB31uCVa/UXdtERWntd03ViRWO3u8PATdxxo02HQ3u/Q4Y7z8Te/XcF0
 q7YDhpY2TU0ry/ESpfOMqkjD+fdtjRy2UDiANJmH4k4PY9TTkszeG99iCj/u9hTF/PXEivsLT
 ppuyKzKH1yf9rbK6I9FPENcG54wSvr+ma5OTZPkcaVM+a7fV36Z5T1/ZsBvOWydORP//64lkY
 mIKfN+63LAPm2vYnZRjUkgPDV8oLGO33Y9Lmo69RiwRpYd668IkiD1YyKVr3dlaWN8QY2TU1y
 ZMe1j6DsjjOnexGkCW0jMrIqBsgH9zJxPJSE36syUw==
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

Am 22.12.22 um 20:14 schrieb Umang Jain:
> V2 series for addressing the TODO item:
>          "Get rid of all non essential global structures and create a proper
>           per device structure"
> This series:
> - Fixes a platform device leak (1/4)
> - Simplifies vchiq_register_child (2/4 and 3/4)
> - drops global references for child platform devices and prepares for
>    addition of new child devices in future (4/4)

the whole problem i see with this series is that kernel module support 
is broken. So i'm not able to test everything.

Did you did just test driver removable?

>
> v1: https://lore.kernel.org/all/20221220084404.19280-1-umang.jain@ideasonboard.com/
>
> Umang Jain (4):
>    staging: vc04_services: Stop leaking platform device on error path
>    staging: vchiq: Do not assign default dma_mask explicitly
>    staging: vchiq: Simplify platform devices registration
>    staging: vchiq: Rework child platform device (un)register
>
>   .../interface/vchiq_arm/vchiq_arm.c           | 40 ++++++++++---------
>   1 file changed, 21 insertions(+), 19 deletions(-)
>
