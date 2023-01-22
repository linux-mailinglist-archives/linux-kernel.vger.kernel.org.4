Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3316B677378
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 00:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjAVXeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 18:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjAVXen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 18:34:43 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D69CC3E;
        Sun, 22 Jan 2023 15:34:41 -0800 (PST)
Received: from [192.168.1.141] ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MGxYh-1pXGEW2C0J-00E4jE; Mon, 23 Jan 2023 00:34:23 +0100
Message-ID: <786df750-221e-82fc-a324-d30261296974@i2se.com>
Date:   Mon, 23 Jan 2023 00:34:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 0/6] staging: vc04_services: vchiq: Register devices
 with a custom bus_type
To:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Elder <paul.elder@ideasonboard.com>
References: <20230120201104.606876-1-umang.jain@ideasonboard.com>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20230120201104.606876-1-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:pwEGleuOvkGVLFNdWT9r9sYPRFmBi28YBzSb3MFzEHeB1TTN5rj
 FM0eWiaEqvlPxR21qTOtFP1AtqZwEyU11wvK3J1XRU0Pn7by/YTj5i0pguOBzYxUHtxTFtF
 Q1RBLA4aWqisAuHIuvKN1p9gdGnXS8mbJvwCBjSDRr5AtFGMuY0yNN77US5cX6J7hLXmT/U
 LBfZAQYeA4IcMe7SKMUGg==
UI-OutboundReport: notjunk:1;M01:P0:plyGRzBlSb8=;cZnlOFBpGjubLlzObuZBDdxpC6x
 SNgLXlBG1bTLzX72skd7WwDTriTVVa0sgFPTKk5bjE6mLZdFiDgiVqrNEn4fJZyYY1BPrnAyL
 wmcDboRjmc+xqCGNbykozpQJDjZkJt2kUV/rn1c56IqKdde/r0+Lm2Koep4VawgxSZHbNRpUM
 R5bPgVaiZDVbYPYLsSGuX74L3bfS3lEva8XHQ6W4MIgtWL+eXeVhBa3TFCvlqrXUrQxR39iqN
 7Cwf5SJ2NbzkU8bs0QUVO1nc4n8ORD+zA9yJFOe+EeR7lTHX+qO4ie5XmjL2NJCL/q4QPESal
 KAICWzeBseL3mugJowfAfrY20NvSX9uvHo6WL5QLMAeQy6MCX1lc0RxYR+4Z5tMaXKPnmgQ0E
 jV+ZZB/f/K2djwt2miAqdBWv4SL6kxs9HSwzk3Ee8QCg/mq954sMXJEbKL5PF+MIe1kOB6AnL
 k/S5514lv160Y7ylYA6IKJpo23AV94CUhpKQX9Jbka4rRhpIfmYOl8T0xNPx5INKu86jtqhRd
 uUhih5OvLvrSgInn/OqbtVzoB6dyFnhvizXiEnGOslxFLQjMmZWqumFwHlgKreP1MQF57PmIe
 xnriMKhwzKqFMWFR6GuHdbBc3zWV++xsioBK9omP64gyg57tOJhAF3BTv3sfefHpcLzo84Ude
 TQUCf3TVdVo3oniguaZ0pn7Xo69HgSfys0D1keB3TQ==
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

Am 20.01.23 um 21:10 schrieb Umang Jain:
> This series just introduces five extra patches for dropping include
> directives from Makefiles (suggested by Greg KH) and rebased.
>
> The main patch (6/6) removes platform device/driver abuse and moves
> things to standard device/driver model using a custom_bus. Specific
> details are elaborated in the commit message.
>
> The patch series is based on top of d514392f17fd (tag: next-20230120)
> of linux-next.

applied this series on top of linux-next and build it with 
arm/multi_v7_defconfig plus the following:

CONFIG_BCM_VIDEOCORE=y
CONFIG_BCM2835_VCHIQ=m
CONFIG_VCHIQ_CDEV=y
CONFIG_SND_BCM2835=m
CONFIG_VIDEO_BCM2835=m
CONFIG_BCM2835_VCHIQ_MMAL=m

and the devices doesn't register on Raspberry Pi 3 B Plus:

[   25.523337] vchiq: module is from the staging directory, the quality 
is unknown, you have been warned.
[   25.541647] bcm2835_vchiq 3f00b840.mailbox: Failed to register 
bcm2835_audio vchiq device
[   25.553692] bcm2835_vchiq 3f00b840.mailbox: Failed to register 
bcm2835-camera vchiq device

