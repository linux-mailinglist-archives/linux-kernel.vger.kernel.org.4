Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E549B6D1762
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 08:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjCaG1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 02:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjCaG1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 02:27:10 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE148DBC6;
        Thu, 30 Mar 2023 23:26:46 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d17so21267209wrb.11;
        Thu, 30 Mar 2023 23:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680244003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9NP6pUuZ/OlZC1OCVgEcS1WK3w/GckN6kRJCtOVKYXA=;
        b=KzPN8Ixc5cgiFbdV7+cZZP8DAIcN2j1bik1k9Zrr6dWnuO6NoaQJxdVyH6866XwgNL
         tLA6Oj3KoRU1qx5M8r5smGSw+MGLeg7c1XxM1B3zrBgcW6JyTVy0qqV4bPZSeSo5BZJt
         w8/3Q/r/DG2pbtcdJ+mmX87TwZ73yNdWQZzLsHfALAvhHHJsfPJ+2h9xA6+x3ZH0Or7J
         eT6PkSxE4s0Cde94zGUOmUD5rHtCRb55FFrFULIGGRSGz9Ri+BpPY2pG9NW5Z2k8RuvC
         D4CeTl6l6SmnPFYqxW1a7OfOo1VnM0mM1+TI8d+7gPFBywggIDLwmICe3G8SB5VMidhZ
         NuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680244003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9NP6pUuZ/OlZC1OCVgEcS1WK3w/GckN6kRJCtOVKYXA=;
        b=v28pxyQ9N3/eTZV+LR855a2Z66wvNSoqgRMLsfIJ/drt6I0b6ZXO1cBRHw039fCunx
         dXAw8gGYiAlFqrVfiNiUlJEIFYIYNBhN8LF9M4s2yh4Ty6NcmtDqWCAvV5w8nYyi4qc1
         /lkEDl+bmHE+ksg7Dl8vJ2ekhEYsK+9omO5SZ9xKPwm2Yb37vGMXTvHZHdjshamTkghu
         wgPHvg9+tWzhLF5GqMkBjC0bTrV9keSU/pVjFv+QBU6N1aN1Z7mcQTlD6weNzXU43dMy
         LtKBoeRa4HH6+R4nRPTnw4uPoT1JPyNotfMIcVcV9+jtUTGPMpt3sRSKe4vv71DXunSD
         wYcQ==
X-Gm-Message-State: AAQBX9ddeBHQxUuIbUJK2NL8rAWCfR7TaidbzApp04EEY323xeLp+mCU
        PN8OYHix8VXId4ueyblPxqpDH1pZuM5CkF9i
X-Google-Smtp-Source: AKy350Z38Yf7G/69TmQAnHy7RTa7++QkuapuCOJiYIsE+GgExk4g4axsG1ZuTtXa0PqGKwmbfSDrFg==
X-Received: by 2002:adf:fec9:0:b0:2e5:6de5:fe9 with SMTP id q9-20020adffec9000000b002e56de50fe9mr1529106wrs.66.1680244003180;
        Thu, 30 Mar 2023 23:26:43 -0700 (PDT)
Received: from arinc9-PC.lan ([149.91.1.15])
        by smtp.gmail.com with ESMTPSA id o15-20020a5d474f000000b002d7a75a2c20sm1252464wrs.80.2023.03.30.23.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 23:26:42 -0700 (PDT)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        me@1conan.com, erkin.bozoglu@xeront.com
Subject: [RFC PATCH] USB: serial: option: add UNISOC vendor and TOZED LT70C product
Date:   Fri, 31 Mar 2023 09:26:39 +0300
Message-Id: <20230331062639.11725-1-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arınç ÜNAL <arinc.unal@arinc9.com>

Add UNISOC vendor ID and TOZED LT70-C modem which is based from UNISOC
SL8563. The modem supports the NCM mode.

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  6 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1782 ProdID=4055 Rev=04.04
S:  Manufacturer=Unisoc Phone
S:  Product=Unisoc Phone
S:  SerialNumber=<redacted>
C:  #Ifs=14 Cfg#= 1 Atr=c0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0d Prot=00 Driver=cdc_ncm
E:  Ad=82(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=01 Driver=cdc_ncm
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#=10 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=8b(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#=11 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=08(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=8c(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#=12 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=option
E:  Ad=09(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=8d(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#=13 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=0a(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=8e(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 2 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0d Prot=00 Driver=cdc_ncm
E:  Ad=84(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
I:  If#= 3 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=01 Driver=cdc_ncm
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 4 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0d Prot=00 Driver=cdc_ncm
E:  Ad=86(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
I:  If#= 5 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=01 Driver=cdc_ncm
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 6 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0d Prot=00 Driver=cdc_ncm
E:  Ad=88(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
I:  If#= 7 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=01 Driver=cdc_ncm
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 8 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 9 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=8a(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Bus 001 Device 002: ID 1782:4055 Unisoc Phone Unisoc Phone
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x1782
  idProduct          0x4055
  bcdDevice            4.04
  iManufacturer           1 Unisoc Phone
  iProduct                2 Unisoc Phone
  iSerial                 3 <redacted>
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x01e7
    bNumInterfaces         14
    bConfigurationValue     1
    iConfiguration          4 4ncm
    bmAttributes         0xc0
      Self Powered
    MaxPower              500mA
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         0
      bInterfaceCount         2
      bFunctionClass          2
      bFunctionSubClass      13
      bFunctionProtocol       0
      iFunction               8 CDC NCM
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         2
      bInterfaceSubClass     13
      bInterfaceProtocol      0
      iInterface              5 CDC Network Control Model (NCM)
      CDC Header:
        bcdCDC               1.10
      CDC Union:
        bMasterInterface        0
        bSlaveInterface         1
      CDC Ethernet:
        iMacAddress                      6 <redacted>
        bmEthernetStatistics    0x00000000
        wMaxSegmentSize               1514
        wNumberMCFilters            0x0000
        bNumberPowerFilters              0
      CDC NCM:
        bcdNcmVersion        1.00
        bmNetworkCapabilities 0x11
          crc mode
          packet filter
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0010  1x 16 bytes
        bInterval               9
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass        10
      bInterfaceSubClass      0
      bInterfaceProtocol      1
      iInterface              7 CDC Network Data
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass        10
      bInterfaceSubClass      0
      bInterfaceProtocol      1
      iInterface              7 CDC Network Data
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         2
      bInterfaceCount         2
      bFunctionClass          2
      bFunctionSubClass      13
      bFunctionProtocol       0
      iFunction              13 CDC NCM
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         2
      bInterfaceSubClass     13
      bInterfaceProtocol      0
      iInterface             10 CDC Network Control Model (NCM)
      CDC Header:
        bcdCDC               1.10
      CDC Union:
        bMasterInterface        2
        bSlaveInterface         3
      CDC Ethernet:
        iMacAddress                     11 <redacted>
        bmEthernetStatistics    0x00000000
        wMaxSegmentSize               1514
        wNumberMCFilters            0x0000
        bNumberPowerFilters              0
      CDC NCM:
        bcdNcmVersion        1.00
        bmNetworkCapabilities 0x11
          crc mode
          packet filter
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0010  1x 16 bytes
        bInterval               9
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass        10
      bInterfaceSubClass      0
      bInterfaceProtocol      1
      iInterface             12 CDC Network Data
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass        10
      bInterfaceSubClass      0
      bInterfaceProtocol      1
      iInterface             12 CDC Network Data
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         4
      bInterfaceCount         2
      bFunctionClass          2
      bFunctionSubClass      13
      bFunctionProtocol       0
      iFunction              18 CDC NCM
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        4
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         2
      bInterfaceSubClass     13
      bInterfaceProtocol      0
      iInterface             15 CDC Network Control Model (NCM)
      CDC Header:
        bcdCDC               1.10
      CDC Union:
        bMasterInterface        4
        bSlaveInterface         5
      CDC Ethernet:
        iMacAddress                     16 <redacted>
        bmEthernetStatistics    0x00000000
        wMaxSegmentSize               1514
        wNumberMCFilters            0x0000
        bNumberPowerFilters              0
      CDC NCM:
        bcdNcmVersion        1.00
        bmNetworkCapabilities 0x11
          crc mode
          packet filter
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x86  EP 6 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0010  1x 16 bytes
        bInterval               9
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        5
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass        10
      bInterfaceSubClass      0
      bInterfaceProtocol      1
      iInterface             17 CDC Network Data
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        5
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass        10
      bInterfaceSubClass      0
      bInterfaceProtocol      1
      iInterface             17 CDC Network Data
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x85  EP 5 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         6
      bInterfaceCount         2
      bFunctionClass          2
      bFunctionSubClass      13
      bFunctionProtocol       0
      iFunction              23 CDC NCM
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        6
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         2
      bInterfaceSubClass     13
      bInterfaceProtocol      0
      iInterface             20 CDC Network Control Model (NCM)
      CDC Header:
        bcdCDC               1.10
      CDC Union:
        bMasterInterface        6
        bSlaveInterface         7
      CDC Ethernet:
        iMacAddress                     21 <redacted>
        bmEthernetStatistics    0x00000000
        wMaxSegmentSize               1514
        wNumberMCFilters            0x0000
        bNumberPowerFilters              0
      CDC NCM:
        bcdNcmVersion        1.00
        bmNetworkCapabilities 0x11
          crc mode
          packet filter
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x88  EP 8 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0010  1x 16 bytes
        bInterval               9
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        7
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass        10
      bInterfaceSubClass      0
      bInterfaceProtocol      1
      iInterface             22 CDC Network Data
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        7
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass        10
      bInterfaceSubClass      0
      bInterfaceProtocol      1
      iInterface             22 CDC Network Data
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x87  EP 7 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x04  EP 4 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        8
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x89  EP 9 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x05  EP 5 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        9
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x8a  EP 10 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x06  EP 6 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber       10
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x8b  EP 11 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x07  EP 7 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber       11
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x8c  EP 12 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x08  EP 8 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber       12
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255
      bInterfaceSubClass     66
      bInterfaceProtocol      1
      iInterface             26 ADB Interface
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x09  EP 9 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x8d  EP 13 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber       13
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x8e  EP 14 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x0a  EP 10 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
Device Qualifier (for other device speed):
  bLength                10
  bDescriptorType         6
  bcdUSB               2.00
  bDeviceClass            0
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  bNumConfigurations      1
Device Status:     0x0000
  (Bus Powered)

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---

I'm completely new to this so if there's anything obvious that should be
done with the help of the output from lsusb and usb-devices, like using
USB_DEVICE_AND_INTERFACE_INFO instead of USB_DEVICE, please let me know.

According to Conan, the TOZED modem actually has the UNISOC SL8563 chip but
the label on the module is TL70-C, which is the TOZED module name.

Arınç

---
 drivers/usb/serial/option.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index f31cc3c76329..6db79d34c991 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -595,6 +595,11 @@ static void option_instat_callback(struct urb *urb);
 #define SIERRA_VENDOR_ID			0x1199
 #define SIERRA_PRODUCT_EM9191			0x90d3
 
+/* UNISOC (Spreadtrum) products */
+#define UNISOC_VENDOR_ID			0x1782
+/* TOZED TL70-C based on UNISOC SL8563 uses UNISOC's vendor ID */
+#define TOZED_PRODUCT_LT70C			0x4055
+
 /* Device flags */
 
 /* Highest interface number which can be used with NCTRL() and RSVD() */
@@ -2225,6 +2230,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(OPPO_VENDOR_ID, OPPO_PRODUCT_R11, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0, 0) },
+	{ USB_DEVICE(UNISOC_VENDOR_ID, UNISOC_PRODUCT_LT70C) },
 	{ } /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, option_ids);
-- 
2.37.2

