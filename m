Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CC86C1DFB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbjCTRal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbjCTRaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:30:05 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F525231C1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:26:11 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id i10-20020a05600c354a00b003ee0da1132eso1418045wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679333145;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gNmkCzJZkkv5eOsnKFRe3ayPoUnRqKfsx+CXhmbKgsc=;
        b=aMAhIpaycXv8EPhlZNCvVIlHOP3g8tB/CPSQDobIFEh1LFu1YJNfh/VdwmcuLFNUFP
         9/odcLimBrXIW1ASkqV0tgE1S5ULxgGxlaVOwafLdaaX1SSMkzkWaynKfRgXn00T5W0X
         mMp2Ykh+R0OXL9qTCaoiY8p29OAKrh+/4pMnST7PS9ZtFaXG8U2qg6bwV/Mpaa1KHJQx
         AtmPh7GMttjBTXCChxKQ0cJrfUVLEwg+kMfORg/QwfvJ9xBu8xM43QFOpiLOLOixzeLm
         NUdgdwqFZZNJ9gig3Dq0PSp+OUad5Qkd+Wjb2ouMQes1YtIdeh6Vwpar1M2jpDUHCPs9
         2Q4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679333145;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gNmkCzJZkkv5eOsnKFRe3ayPoUnRqKfsx+CXhmbKgsc=;
        b=WQZ019oE6V9JZAHgeoCTCd9us1MYXS90SWYCFuNkNB3eRKgIdBZvIReBkMxCUx70Ye
         y/rgo3vjKZhKJIsPnxtlTaKsb0eMmzhtt8VOSM8hd3JeIBuWZCJJD9P5gzlIeJKkeIpn
         ZBunlxnDxeCxh+8mXOEONNd1OnH85KGZ6RDyrGLzNm1RTFCoYQ2e3oNM9HrDb79GW3sB
         3EQtSiyd847N4p8ZLyizL8ILuvn5PC56i4opS0LS0hJri+qFPuIDZDJaH1dF+mF+jstz
         CX9J/odQaT8h4H6lZbqcd86B2HGNU4U8Rgn0GXI7bTVFhSWfcttf6boDIneBxbxMAwTC
         y35g==
X-Gm-Message-State: AO0yUKUwFfq7Tgcu4nutMfLytgaiyAQHDvsksctzRabJHV2Lz+ox3syA
        /jSrCsKfR0zZLNDRauESa8dj2crMLyihj0FOl2cPHzdKiIEsBwOm
X-Google-Smtp-Source: AK7set9XA7AYKqq/B7T2mT/zyJ4DhkrotEMXa637CqBXiJSW0WVqyKK5arGq5u1wVs3MNoN9G/snOEwf7UHckOYWzOg=
X-Received: by 2002:a7b:c409:0:b0:3ea:8ed9:5f3e with SMTP id
 k9-20020a7bc409000000b003ea8ed95f3emr76319wmi.4.1679333145280; Mon, 20 Mar
 2023 10:25:45 -0700 (PDT)
MIME-Version: 1.0
From:   Shane Francis <bigbeeshane@gmail.com>
Date:   Mon, 20 Mar 2023 17:25:34 +0000
Message-ID: <CABnpCuAXrbfRNpvESJiGn4fyzK5-zUcqbs7bQQJY=JhTN-w=YA@mail.gmail.com>
Subject: ARM : RK3588S : NET / Ethernet: Not TX traffic from mdio1
To:     linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        "heiko@sntech.de" <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am currently working on enabling a RK3588S SBC (NanoPi R6S) within
mainline Linux

However I am hitting an issue with the mdio attached RTL8211F, the
device initializes correctly
but there seems to be no TX traffic sent from the RTL8211F (confirmed
with TCPDUMP on an attached router)

RX traffic is working as expected (see below)

===============================================
listening on eth0, link-type EN10MB (Ethernet), snapshot length 262144 bytes
00:03:34.282286 ARP, Request who-has 192.168.1.229 tell 192.168.1.154, length 46
00:03:35.648448 ARP, Reply 192.168.1.234 is-at 1c:53:f9:1a:ba:3a (oui
Unknown), length 46
00:03:43.220916 ARP, Request who-has 192.168.1.226 tell 192.168.1.218, length 46
===============================================

I have noticed that the TX irqs seem to be fewer than expected (and
some eee wake errors are seen)
===============================================

     tx_pkt_n: 218
     rx_pkt_n: 1014
     normal_irq_n: 944
     rx_normal_irq_n: 936
     napi_poll: 3044
     tx_normal_irq_n: 8
...
     irq_tx_path_in_lpi_mode_n: 49
     irq_tx_path_exit_lpi_mode_n: 49
     irq_rx_path_in_lpi_mode_n: 2
     irq_rx_path_exit_lpi_mode_n: 2
     phy_eee_wakeup_error_n: 1
==============================================

I have validated that the TX are RX delays for both the phy and gmac
match what the OEM kernels are setting.

This behavior is seen on both 6.1 and latest RC

I am looking for any information on if this behavior can be seen on
other RK3588S devices using the RTL8211F and pointers on where to look
next.

Thanks in advance.
