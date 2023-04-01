Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18046D2DA6
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 04:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbjDACPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 22:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjDACPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 22:15:38 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7C2173F;
        Fri, 31 Mar 2023 19:15:37 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id l7-20020a4abe07000000b0053e1205c84bso3442248oop.9;
        Fri, 31 Mar 2023 19:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680315336;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q/8ymO10OrcPxy/DHt31x8jIOet/Tm3AwxwojOGkYto=;
        b=ph6ADDDnoaOjNUjFFidGxTStn8uMQf5BO3PYpXCo7BVeL0Uq+zdM81h6UqNEcQfnl4
         9i8jzFXX05E6wj3bGVeUcg2SyFNXQSsfBrLEHwetQjTv2EJI4XZDRTKvFGqDVMRrJgTQ
         +yLHpXMq6Wnwid5IDYaC1JoGSleN6d2MdCUA2giRUGRyVJ8hGV5xFivE2vC6JiClTZKf
         2A4AozBA69I/SxzEPIaH3yTfq3MhpK4rDmx4FqK9aYRT5r881Cqezyb92IQBN9nRYxek
         E9lBtofYFdrgWTdoe9hYM+0zF38ePlQX153l7+jBCrrsd2peJ7DWnoaOP1MYQKC7dcg/
         TGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680315336;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q/8ymO10OrcPxy/DHt31x8jIOet/Tm3AwxwojOGkYto=;
        b=hO9/mCl8AJRI1TmVYwaEBnwbMgYRRDV9tS8bA8MtZjRmB8WGO+AZzAp+fXEfh9KI+F
         7IjdaF4YBA+tx7cvWIjGRGTGgPYWO8kxTfVPkaZcyFJwVF6wcgYlJpbDuCMj8eMnjPOw
         CoYIpaQpJYbaC3SE1gQYsPpA60bT0Bnd0/O2YNcG6NfWz3A8Laz8WHbxovmrYQDDQvEm
         iD+f/3nV35CqZVzx/io2x2Ylz1djKuDG+oYELSKrLHfTvFdJpHADZf0JFAtPfli5sKvw
         Z0SrmqxB28IvqiwMV/OKOLj7zybp8votKX3a/LyjKpnpcX43p85t+hQln22nSM6xb35J
         jsFw==
X-Gm-Message-State: AO0yUKVuMMYX+A4b+kDVl+DoSinIdUKvPJIpIT4qiteqSw6d5gisY08M
        ILqVqhMkTIGBVAdXH+fbDfw=
X-Google-Smtp-Source: AK7set/3X0UzE4r/LU1M6wlPxrr/tc4E5y7l+AWtSHmUMu9/UvwZ5HyWLlFHItScb3EgBaGftdUmoA==
X-Received: by 2002:a4a:498a:0:b0:525:129c:6165 with SMTP id z132-20020a4a498a000000b00525129c6165mr14533749ooa.6.1680315336770;
        Fri, 31 Mar 2023 19:15:36 -0700 (PDT)
Received: from [192.168.0.116] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id v184-20020acadec1000000b003871471f894sm1612227oig.27.2023.03.31.19.15.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 19:15:36 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <3e3d0ea7-4c85-f432-6e34-1d90b991c53c@lwfinger.net>
Date:   Fri, 31 Mar 2023 21:15:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: Memory leaks in Bluetooth and btusb
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am running kernel 6.3.0-rc4-00041-g45a74775bbcd, and noticed the following 
memory leaks:

unreferenced object 0xffff9c8157f32800 (size 640):
   comm "softirq", pid 0, jiffies 4303340208 (age 1378.908s)
   hex dump (first 32 bytes):
     6c 69 62 75 64 65 76 00 0e 0c 02 01 10 00 08 6b  libudev........k
     ab 08 5d 00 5c 70 00 00 05 77 c5 e5 b1 02 47 65  ..].\p...w....Ge
   backtrace:
     [<ffffffff90103df9>] kmalloc_reserve+0x89/0xf0
     [<ffffffff90105a43>] __alloc_skb+0x83/0x190
     [<ffffffffc11111d1>] btusb_recv_intr+0x131/0x190 [btusb]
     [<ffffffffc11112ca>] btusb_intr_complete+0x9a/0x150 [btusb]
     [<ffffffffc0325321>] __usb_hcd_giveback_urb+0x91/0x110 [usbcore]
     [<ffffffffc03254f4>] usb_giveback_urb_bh+0x94/0x110 [usbcore]
     [<ffffffff8f8a66e8>] tasklet_action_common.isra.0+0xb8/0x130
     [<ffffffff90302721>] __do_softirq+0xc1/0x298
unreferenced object 0xffff9c811cb9e800 (size 224):
   comm "kworker/u9:1", pid 15177, jiffies 4303340208 (age 1378.908s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<ffffffff90108da5>] skb_clone+0x55/0xd0
     [<ffffffffc126978f>] hci_event_packet+0xcf/0x550 [bluetooth]
     [<ffffffffc124e9e6>] hci_rx_work+0x2a6/0x570 [bluetooth]
     [<ffffffff8f8bfdf1>] process_one_work+0x201/0x410
     [<ffffffff8f8c004a>] worker_thread+0x4a/0x3b0
     [<ffffffff8f8c8587>] kthread+0xd7/0x100
     [<ffffffff8f802dbf>] ret_from_fork+0x1f/0x30

The Bluetooth device in question is from Realtek, and is part of a Realtek 
RTW8822BU wifi/BT combination device.

Thanks,

Larry
