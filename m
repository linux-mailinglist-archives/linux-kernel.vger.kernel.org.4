Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02DD5F9A4E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 09:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbiJJHoz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Oct 2022 03:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbiJJHo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 03:44:29 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69B058DF3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 00:41:16 -0700 (PDT)
X-QQ-mid: bizesmtpipv602t1665387660th2k
Received: from SJRobe ( [255.42.121.1])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 10 Oct 2022 15:40:59 +0800 (CST)
X-QQ-SSF: 01100000000000G0Z000000A0000000
X-QQ-FEAT: D6RqbDSxuq6cwC8cDpk6J6w/9heWeBE4QoTLi01heGfYsefY/8uPDjbVX0Gne
        LQ7U4LO1pW2xuL7QruX7v/fsjH8iE35+kUsl+aoDV5n5Y8WnE8n3dwJPD7NpUNToij6PVhZ
        +PQM5cyF1DPFR/mPQwsXXUG6EIIlntIb9gAxcvFNX7fvjWx8Gf5v0zaSAlRJOrl+a6Nk3mS
        B0CaSxCovYMtW8ruohBlJZbD35zkXm+SmmnK0DzeTubbW8ld1qQnMiGwGlI0takORkbMlCH
        Wqpt4ttOtz5IoIRbWwDdnQYpMNu/2aVrizJZ9tq0F6nxFUcxUCVA+PGgPLJr0wnid+h0YGh
        RrqjKm1TGBRoyN8ocMy4+MYam1DQgaVQQ3KqAFLFPGKecwBbbjnxmXSuSg2RQ==
X-QQ-GoodBg: 0
From:   "Soha Jin" <soha@lohu.info>
To:     "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>
Cc:     "'Rafael J. Wysocki'" <rafael@kernel.org>,
        "'Andy Shevchenko'" <andriy.shevchenko@linux.intel.com>,
        "'Daniel Scally'" <djrscally@gmail.com>,
        "'Heikki Krogerus'" <heikki.krogerus@linux.intel.com>,
        "'Sakari Ailus'" <sakari.ailus@linux.intel.com>,
        <linux-kernel@vger.kernel.org>
References: <20221009162155.1318-1-soha@lohu.info> <Y0MRxgKhRVbyrTz2@kroah.com> <1BF643A9A697B323+1bc601d8dc55$65ae1cf0$310a56d0$@lohu.info> <Y0O7AOUgCbjPYOAt@kroah.com>
In-Reply-To: <Y0O7AOUgCbjPYOAt@kroah.com>
Subject: RE: [PATCH 0/3] Case-insensitive match_string and fwnode_is_compatible()
Date:   Mon, 10 Oct 2022 15:40:56 +0800
Message-ID: <ED2C9279F05693A0+270501d8dc7b$a2ae7520$e80b5f60$@lohu.info>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ3YxYd+FPcuiJVmWEOx+0wAFDAtAKnp80RAkNI4u8CQ+wZC6yQuOtg
Content-Language: fr
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpipv:lohu.info:qybglogicsvr:qybglogicsvr3
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_ILLEGAL_IP,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> From: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
> Sent: Monday, October 10, 2022 2:26 PM
> 
> On Mon, Oct 10, 2022 at 11:07:13AM +0800, Soha Jin wrote:
> > Hi Greg,
> >
> > This is the first time I submit patches to kernel, I am sorry for
> > anything wrong I did.
> >
> > I am just thinking these patches and the driver patches are in
> > different trees, so I split the patches into different parts. The
> > driver patch is at
> https://lore.kernel.org/all/20221009162247.1336-1-soha@lohu.info/.
> 
> As you can see, the kernel test robot reported that these changes are broken
> as it does not know about this separate series you submitted.
> 
> Please make them all one series so we can properly review them together
> and the testing infrastructure can correctly run.

I see. I will put this patch series into that thread as patch v2 after the
letter case problem is settled.

Regards,
Soha

