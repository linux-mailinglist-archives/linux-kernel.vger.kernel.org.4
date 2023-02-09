Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2072D690C58
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjBIPBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjBIPBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:01:39 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B261F3345B;
        Thu,  9 Feb 2023 07:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675954896; x=1707490896;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8fIlILh8QsAbnz2deOL7Bmkf7rs3gKsUTt0AOIUqYTw=;
  b=O+D0IBWRgJ+ujVMYiVLkfAdQKrhkvpkCDgnJsKe+YMzEXFOJw8HT4Ua0
   Z7Q8gE98rIFExP0iatmuhC/wyxjcK2CTPD629anSOl27cPgVVZ2zkMQlw
   yx5dGXA+5o+ZdTR9f2zYBAqGMAXGQvrLqHDzRarrWKqKoGXehpIWK1FGq
   /JloDmPPW+CbBibDm3owZ9xSs2kW23j8lHNlYTrDZCaN8V6ghcffp2gOj
   2Cx3ttfUhbiaVV+MSwQkE6JCT9W7dkrXg84C5EvTQOfdB+TQI9Vs5eVTT
   t2+en66pnQOGARQVl+T4Vwlhartr3V0VlDBPhkwh2OKkHLa6Uh47dhYH2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="328765701"
X-IronPort-AV: E=Sophos;i="5.97,283,1669104000"; 
   d="scan'208";a="328765701"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 07:01:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="700091102"
X-IronPort-AV: E=Sophos;i="5.97,283,1669104000"; 
   d="scan'208";a="700091102"
Received: from lbermanx-mobl.ger.corp.intel.com (HELO terminus) ([10.214.227.103])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 07:01:16 -0800
Message-ID: <6086ffb8cbb0ea9cc99397a8789993884da02b32.camel@intel.com>
Subject: Re: [PATCH] uvc: Intel PID enabling UVC Metadata attributes
From:   Dmitry Perchanov <dmitry.perchanov@intel.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     linux-media@vger.kernel.org, laurent.pinchart@ideasonboard.com,
        mchehab@kernel.org, linux-kernel@vger.kernel.org,
        evgeni.raikhel@intel.com, demisrael@gmail.com
Date:   Thu, 09 Feb 2023 17:01:12 +0200
In-Reply-To: <CANiDSCutto9KpP=Q5GCXpTn=eUE+RsCpWqA_goDb+MqnT3iU+w@mail.gmail.com>
References: <9001ccdec3e3234253cf2f93ea39745ed6f525f1.camel@intel.com>
         <CANiDSCutto9KpP=Q5GCXpTn=eUE+RsCpWqA_goDb+MqnT3iU+w@mail.gmail.com>
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo.
See below for D435 and D455, i can get more if necessary.
I'm not sure how can usb descriptor help in that case, we appending only dr=
iver_info structure to known pid.

Regards,
Dmitry P.

<<< BEGIN lsusb -v for d455.txt >>>
Bus 002 Device 005: ID 8086:0b5c Intel Corp. =

Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               3.20
  bDeviceClass          239 Miscellaneous Device
 =

bDeviceSubClass         2 ?
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0         9
  idVendor           0x8086 Intel Corp.
  idProduct          0x0b5c =

  bcdDevice           50.e0
 iManufacturer           1 Intel(R) RealSense(TM) Depth Camera 455 =

  iProduct                2 Intel(R) RealSense(TM) Depth Camera 455 =

  iSerial                 3 012345678901
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength         3010
    bNumInterfaces          7
    bConfigurationValue     1
    iConfiguration          0 =

    bmAttributes         0x80
      (Bus Powered)
    MaxPower              180mA
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         0
      bInterfaceCount         3
      bFunctionClass         14 Video
      bFunctionSubClass       3 Video Interface Collection
      bFunctionProtocol       0 =

      iFunction               5 Intel(R) RealSense(TM) Depth Camera 455  De=
pth
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      1 Video Control
      bInterfaceProtocol      0 =

      iInterface              5 Intel(R) RealSense(TM) Depth Camera 455  De=
pth
      VideoControl Interface Descriptor:
        bLength                14
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdUVC               1.50
        wTotalLength           91
        dwClockFrequency       48.000000MHz
        bInCollection           2
        baInterfaceNr( 0)       1
        baInterfaceNr( 1)       2
      VideoControl Interface Descriptor:
        bLength                18
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             1
        wTerminalType      0x0201 Camera Sensor
        bAssocTerminal          0
        iTerminal               0 =

        wObjectiveFocalLengthMin      0
        wObjectiveFocalLengthMax      0
        wOcularFocalLength            0
        bControlSize                  3
        bmControls           0x00200000
      VideoControl Interface Descriptor:
        bLength                13
        bDescriptorType        36
        bDescriptorSubtype      5 (PROCESSING_UNIT)
        bUnitID                 2
        bSourceID               1
        wMaxMultiplier      16384
        bControlSize            3
        bmControls     0x00000200
          Gain
        iProcessing             0 =

        bmVideoStandards     0x 0
      VideoControl Interface Descriptor:
        bLength                28
        bDescriptorType        36
        bDescriptorSubtype      6 (EXTENSION_UNIT)
        bUnitID                 3
        guidExtensionCode         {cb6c60c9-4c59-254d-af47-ccc496435995}
        bNumControl            16
        bNrPins                 1
        baSourceID( 0)          2
        bControlSize            3
        bmControls( 0)       0xff
        bmControls( 1)       0xdd
        bmControls( 2)       0x00
        iExtension              6 Intel(R) RealSense(TM) Depth Camera 455  =
RGB
      VideoControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             4
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID               3
        iTerminal               0 =

      VideoControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             5
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID               3
        iTerminal               0 =

      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x87  EP 7 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               6
        bMaxBurst               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0 =

      iInterface              5 Intel(R) RealSense(TM) Depth Camera 455  De=
pth
      VideoStreaming Interface Descriptor:
        bLength                            15
        bDescriptorType                    36
        bDescriptorSubtype                  1 (INPUT_HEADER)
        bNumFormats                         2
        wTotalLength                      739
        bEndPointAddress                  130
        bmInfo                              0
        bTerminalLink                       4
        bStillCaptureMethod                 0
        bTriggerSupport                     0
        bTriggerUsage                       0
        bControlSize                        1
        bmaControls( 0)                    28
        bmaControls( 1)                    28
      VideoStreaming Interface Descriptor:
        bLength                            28
        bDescriptorType                    36
        bDescriptorSubtype                 16 (FORMAT_FRAME_BASED)
        bFormatIndex                        1
        bNumFrameDescriptors                8
        guidFormat                            {5a313620-0000-1000-8000-00aa=
00389b71}
        bBitsPerPixel                      16
        bDefaultFrameIndex                  1
        bAspectRatioX                       0
        bAspectRatioY                       0
        bmInterlaceFlags                 0x00
          Interlaced stream or variable: No
          Fields per frame: 2 fields
          Field 1 first: No
          Field pattern: Field 1 only
          bCopyProtect                      0
          bVariableSize                     0
      VideoStreaming Interface Descriptor:
        bLength                            30
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         1
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            256
        wHeight                           144
        dwMinBitRate                 53084160
        dwMaxBitRate                 53084160
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  1
        dwBytesPerLine                    512
        dwFrameInterval( 0)            111111
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         2
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            424
        wHeight                           240
        dwMinBitRate                  8140800
        dwMaxBitRate                146534400
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                    848
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           2000000
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         3
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            480
        wHeight                           270
        dwMinBitRate                 10368000
        dwMaxBitRate                186624000
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                    960
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           2000000
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         4
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            640
        wHeight                           360
        dwMinBitRate                 18432000
        dwMaxBitRate                331776000
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                   1280
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           2000000
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         5
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            640
        wHeight                           480
        dwMinBitRate                 24576000
        dwMaxBitRate                442368000
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                   1280
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           2000000
      VideoStreaming Interface Descriptor:
        bLength                            30
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         6
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            848
        wHeight                           100
        dwMinBitRate                135680000
        dwMaxBitRate                135680000
        dwDefaultFrameInterval         100000
        bFrameIntervalType                  1
        dwBytesPerLine                   1696
        dwFrameInterval( 0)            100000
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         7
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            848
        wHeight                           480
        dwMinBitRate                 32563200
        dwMaxBitRate                586137600
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                   1696
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           2000000
      VideoStreaming Interface Descriptor:
        bLength                            38
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         8
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                           1280
        wHeight                           720
        dwMinBitRate                 73728000
        dwMaxBitRate                442368000
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  3
        dwBytesPerLine                   2560
        dwFrameInterval( 0)            333333
        dwFrameInterval( 1)            666666
        dwFrameInterval( 2)           2000000
      VideoStreaming Interface Descriptor:
        bLength                             6
        bDescriptorType                    36
        bDescriptorSubtype                 13 (COLORFORMAT)
        bColorPrimaries                     0 (Unspecified)
        bTransferCharacteristics            0 (Unspecified)
        bMatrixCoefficients                 0 (Unspecified)
      VideoStreaming Interface Descriptor:
        bLength                            28
        bDescriptorType                    36
        bDescriptorSubtype                 16 (FORMAT_FRAME_BASED)
        bFormatIndex                        2
        bNumFrameDescriptors                8
        guidFormat                            {50000000-0000-1000-8000-00aa=
00389b71}
        bBitsPerPixel                      16
        bDefaultFrameIndex                  1
        bAspectRatioX                       0
        bAspectRatioY                       0
        bmInterlaceFlags                 0x00
          Interlaced stream or variable: No
          Fields per frame: 2 fields
          Field 1 first: No
          Field pattern: Field 1 only
          bCopyProtect                      0
          bVariableSize                     0
      VideoStreaming Interface Descriptor:
        bLength                            30
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         1
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            256
        wHeight                           144
        dwMinBitRate                 53084160
        dwMaxBitRate                 53084160
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  1
        dwBytesPerLine                    512
        dwFrameInterval( 0)            111111
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         2
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            424
        wHeight                           240
        dwMinBitRate                  8140800
        dwMaxBitRate                146534400
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                    848
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           2000000
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         3
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            480
        wHeight                           270
        dwMinBitRate                 10368000
        dwMaxBitRate                186624000
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                    960
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           2000000
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         4
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            640
        wHeight                           360
        dwMinBitRate                 18432000
        dwMaxBitRate                331776000
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                   1280
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           2000000
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         5
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            640
        wHeight                           480
        dwMinBitRate                 24576000
        dwMaxBitRate                442368000
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                   1280
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           2000000
      VideoStreaming Interface Descriptor:
        bLength                            30
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         6
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            848
        wHeight                           100
        dwMinBitRate                135680000
        dwMaxBitRate                135680000
        dwDefaultFrameInterval         100000
        bFrameIntervalType                  1
        dwBytesPerLine                   1696
        dwFrameInterval( 0)            100000
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         7
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            848
        wHeight                           480
        dwMinBitRate                 32563200
        dwMaxBitRate                586137600
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                   1696
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           2000000
      VideoStreaming Interface Descriptor:
        bLength                            38
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         8
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                           1280
        wHeight                           720
        dwMinBitRate                 73728000
        dwMaxBitRate                442368000
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  3
        dwBytesPerLine                   2560
        dwFrameInterval( 0)            333333
        dwFrameInterval( 1)            666666
        dwFrameInterval( 2)           2000000
      VideoStreaming Interface Descriptor:
        bLength                             6
        bDescriptorType                    36
        bDescriptorSubtype                 13 (COLORFORMAT)
        bColorPrimaries                     0 (Unspecified)
        bTransferCharacteristics            0 (Unspecified)
        bMatrixCoefficients                 0 (Unspecified)
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst              15
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0 =

      iInterface              8 Intel(R) RealSense(TM) Depth Camera 455  Y
      VideoStreaming Interface Descriptor:
        bLength                            18
        bDescriptorType                    36
        bDescriptorSubtype                  1 (INPUT_HEADER)
        bNumFormats                         5
        wTotalLength                     1482
        bEndPointAddress                  131
        bmInfo                              0
        bTerminalLink                       5
        bStillCaptureMethod                 0
        bTriggerSupport                     0
        bTriggerUsage                       0
        bControlSize                        1
        bmaControls( 0)                    28
        bmaControls( 1)                    28
        bmaControls( 2)                    28
        bmaControls( 3)                    28
        bmaControls( 4)                    28
      VideoStreaming Interface Descriptor:
        bLength                            28
        bDescriptorType                    36
        bDescriptorSubtype                 16 (FORMAT_FRAME_BASED)
        bFormatIndex                        1
        bNumFrameDescriptors                7
        guidFormat                            {32000000-0000-1000-8000-00aa=
00389b71}
        bBitsPerPixel                       8
        bDefaultFrameIndex                  1
        bAspectRatioX                       0
        bAspectRatioY                       0
        bmInterlaceFlags                 0x00
          Interlaced stream or variable: No
          Fields per frame: 2 fields
          Field 1 first: No
          Field pattern: Field 1 only
          bCopyProtect                      0
          bVariableSize                     0
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         1
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            424
        wHeight                           240
        dwMinBitRate                  4070400
        dwMaxBitRate                 73267200
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                    424
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           2000000
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         2
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            480
        wHeight                           270
        dwMinBitRate                  5184000
        dwMaxBitRate                 93312000
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                    480
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           2000000
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         3
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            640
        wHeight                           360
        dwMinBitRate                  9216000
        dwMaxBitRate                165888000
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                    640
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           2000000
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         4
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            640
        wHeight                           480
        dwMinBitRate                 12288000
        dwMaxBitRate                221184000
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                    640
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           2000000
      VideoStreaming Interface Descriptor:
        bLength                            30
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         5
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            848
        wHeight                           100
        dwMinBitRate                 67840000
        dwMaxBitRate                 67840000
        dwDefaultFrameInterval         100000
        bFrameIntervalType                  1
        dwBytesPerLine                    848
        dwFrameInterval( 0)            100000
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         6
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            848
        wHeight                           480
        dwMinBitRate                 16281600
        dwMaxBitRate                293068800
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                    848
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           2000000
      VideoStreaming Interface Descriptor:
        bLength                            38
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         7
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                           1280
        wHeight                           720
        dwMinBitRate                 36864000
        dwMaxBitRate                221184000
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  3
        dwBytesPerLine                   1280
        dwFrameInterval( 0)            333333
        dwFrameInterval( 1)            666666
        dwFrameInterval( 2)           2000000
      VideoStreaming Interface Descriptor:
        bLength                             6
        bDescriptorType                    36
        bDescriptorSubtype                 13 (COLORFORMAT)
        bColorPrimaries                     0 (Unspecified)
        bTransferCharacteristics            0 (Unspecified)
        bMatrixCoefficients                 0 (Unspecified)
      VideoStreaming Interface Descriptor:
        bLength                            28
        bDescriptorType                    36
        bDescriptorSubtype                 16 (FORMAT_FRAME_BASED)
        bFormatIndex                        2
        bNumFrameDescriptors                7
        guidFormat                            {55595659-0000-1000-8000-00aa=
00389b71}
        bBitsPerPixel                      16
        bDefaultFrameIndex                  1
        bAspectRatioX                       0
        bAspectRatioY                       0
        bmInterlaceFlags                 0x00
          Interlaced stream or variable: No
          Fields per frame: 2 fields
          Field 1 first: No
          Field pattern: Field 1 only
          bCopyProtect                      0
          bVariableSize                     0
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         1
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            424
        wHeight                           240
        dwMinBitRate                  8140800
        dwMaxBitRate                146534400
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                    848
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           2000000
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         2
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            480
        wHeight                           270
        dwMinBitRate                 10368000
        dwMaxBitRate                186624000
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                    960
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           2000000
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         3
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            640
        wHeight                           360
        dwMinBitRate                 18432000
        dwMaxBitRate                331776000
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                   1280
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           2000000
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         4
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            640
        wHeight                           480
        dwMinBitRate                 24576000
        dwMaxBitRate                442368000
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                   1280
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           2000000
      VideoStreaming Interface Descriptor:
        bLength                            30
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         5
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            848
        wHeight                           100
        dwMinBitRate                135680000
        dwMaxBitRate                135680000
        dwDefaultFrameInterval         100000
        bFrameIntervalType                  1
        dwBytesPerLine                   1696
        dwFrameInterval( 0)            100000
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         6
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            848
        wHeight                           480
        dwMinBitRate                 32563200
        dwMaxBitRate                586137600
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                   1696
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           2000000
      VideoStreaming Interface Descriptor:
        bLength                            38
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         7
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                           1280
        wHeight                           720
        dwMinBitRate                 73728000
        dwMaxBitRate                442368000
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  3
        dwBytesPerLine                   2560
        dwFrameInterval( 0)            333333
        dwFrameInterval( 1)            666666
        dwFrameInterval( 2)           2000000
      VideoStreaming Interface Descriptor:
        bLength                             6
        bDescriptorType                    36
        bDescriptorSubtype                 13 (COLORFORMAT)
        bColorPrimaries                     0 (Unspecified)
        bTransferCharacteristics            0 (Unspecified)
        bMatrixCoefficients                 0 (Unspecified)
      VideoStreaming Interface Descriptor:
        bLength                            28
        bDescriptorType                    36
        bDescriptorSubtype                 16 (FORMAT_FRAME_BASED)
        bFormatIndex                        3
        bNumFrameDescriptors                7
        guidFormat                            {59382020-0000-1000-8000-00aa=
00389b71}
        bBitsPerPixel                       8
        bDefaultFrameIndex                  1
        bAspectRatioX                       0
        bAspectRatioY                       0
        bmInterlaceFlags                 0x00
          Interlaced stream or variable: No
          Fields per frame: 2 fields
          Field 1 first: No
          Field pattern: Field 1 only
          bCopyProtect                      0
          bVariableSize                     0
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         1
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            424
        wHeight                           240
        dwMinBitRate                  4070400
        dwMaxBitRate                 73267200
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                    424
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           2000000
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         2
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            480
        wHeight                           270
        dwMinBitRate                  5184000
        dwMaxBitRate                 93312000
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                    480
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           2000000
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         3
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            640
        wHeight                           360
        dwMinBitRate                  9216000
        dwMaxBitRate                165888000
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                    640
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           2000000
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         4
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            640
        wHeight                           480
        dwMinBitRate                 12288000
        dwMaxBitRate                221184000
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                    640
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           2000000
      VideoStreaming Interface Descriptor:
        bLength                            30
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         5
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            848
        wHeight                           100
        dwMinBitRate                 67840000
        dwMaxBitRate                 67840000
        dwDefaultFrameInterval         100000
        bFrameIntervalType                  1
        dwBytesPerLine                    848
        dwFrameInterval( 0)            100000
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         6
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            848
        wHeight                           480
        dwMinBitRate                 16281600
        dwMaxBitRate                293068800
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                    848
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           2000000
      VideoStreaming Interface Descriptor:
        bLength                            38
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         7
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                           1280
        wHeight                           720
        dwMinBitRate                 36864000
        dwMaxBitRate                221184000
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  3
        dwBytesPerLine                   1280
        dwFrameInterval( 0)            333333
        dwFrameInterval( 1)            666666
        dwFrameInterval( 2)           2000000
      VideoStreaming Interface Descriptor:
        bLength                             6
        bDescriptorType                    36
        bDescriptorSubtype                 13 (COLORFORMAT)
        bColorPrimaries                     0 (Unspecified)
        bTransferCharacteristics            0 (Unspecified)
        bMatrixCoefficients                 0 (Unspecified)
      VideoStreaming Interface Descriptor:
        bLength                            28
        bDescriptorType                    36
        bDescriptorSubtype                 16 (FORMAT_FRAME_BASED)
        bFormatIndex                        4
        bNumFrameDescriptors                8
        guidFormat                            {59384920-0000-1000-8000-00aa=
00389b71}
        bBitsPerPixel                      16
        bDefaultFrameIndex                  1
        bAspectRatioX                       0
        bAspectRatioY                       0
        bmInterlaceFlags                 0x00
          Interlaced stream or variable: No
          Fields per frame: 2 fields
          Field 1 first: No
          Field pattern: Field 1 only
          bCopyProtect                      0
          bVariableSize                     0
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         1
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            424
        wHeight                           240
        dwMinBitRate                  8140800
        dwMaxBitRate                146534400
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                    848
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           2000000
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         2
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            480
        wHeight                           270
        dwMinBitRate                 10368000
        dwMaxBitRate                186624000
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                    960
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           2000000
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         3
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            640
        wHeight                           360
        dwMinBitRate                 18432000
        dwMaxBitRate                331776000
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                   1280
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           2000000
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         4
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            640
        wHeight                           480
        dwMinBitRate                 24576000
        dwMaxBitRate                442368000
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                   1280
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           2000000
      VideoStreaming Interface Descriptor:
        bLength                            30
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         5
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            848
        wHeight                           100
        dwMinBitRate                135680000
        dwMaxBitRate                135680000
        dwDefaultFrameInterval         100000
        bFrameIntervalType                  1
        dwBytesPerLine                   1696
        dwFrameInterval( 0)            100000
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         6
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            848
        wHeight                           480
        dwMinBitRate                 32563200
        dwMaxBitRate                586137600
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                   1696
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           2000000
      VideoStreaming Interface Descriptor:
        bLength                            38
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         7
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                           1280
        wHeight                           720
        dwMinBitRate                 73728000
        dwMaxBitRate                442368000
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  3
        dwBytesPerLine                   2560
        dwFrameInterval( 0)            333333
        dwFrameInterval( 1)            666666
        dwFrameInterval( 2)           2000000
      VideoStreaming Interface Descriptor:
        bLength                            34
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         8
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                           1280
        wHeight                           800
        dwMinBitRate                245760000
        dwMaxBitRate                491520000
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  2
        dwBytesPerLine                   2560
        dwFrameInterval( 0)            333333
        dwFrameInterval( 1)            666666
      VideoStreaming Interface Descriptor:
        bLength                             6
        bDescriptorType                    36
        bDescriptorSubtype                 13 (COLORFORMAT)
        bColorPrimaries                     0 (Unspecified)
        bTransferCharacteristics            0 (Unspecified)
        bMatrixCoefficients                 0 (Unspecified)
      VideoStreaming Interface Descriptor:
        bLength                            28
        bDescriptorType                    36
        bDescriptorSubtype                 16 (FORMAT_FRAME_BASED)
        bFormatIndex                        5
        bNumFrameDescriptors                2
        guidFormat                            {59313249-0000-1000-8000-00aa=
00389b71}
        bBitsPerPixel                      24
        bDefaultFrameIndex                  1
        bAspectRatioX                       0
        bAspectRatioY                       0
        bmInterlaceFlags                 0x00
          Interlaced stream or variable: No
          Fields per frame: 2 fields
          Field 1 first: No
          Field pattern: Field 1 only
          bCopyProtect                      0
          bVariableSize                     0
      VideoStreaming Interface Descriptor:
        bLength                            34
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         1
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            640
        wHeight                           400
        dwMinBitRate                 92160000
        dwMaxBitRate                153600000
        dwDefaultFrameInterval         400000
        bFrameIntervalType                  2
        dwBytesPerLine                   1920
        dwFrameInterval( 0)            400000
        dwFrameInterval( 1)            666666
      VideoStreaming Interface Descriptor:
        bLength                            34
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         2
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                           1280
        wHeight                           800
        dwMinBitRate                368640000
        dwMaxBitRate                614400000
        dwDefaultFrameInterval         400000
        bFrameIntervalType                  2
        dwBytesPerLine                   3840
        dwFrameInterval( 0)            400000
        dwFrameInterval( 1)            666666
      VideoStreaming Interface Descriptor:
        bLength                             6
        bDescriptorType                    36
        bDescriptorSubtype                 13 (COLORFORMAT)
        bColorPrimaries                     0 (Unspecified)
        bTransferCharacteristics            0 (Unspecified)
        bMatrixCoefficients                 0 (Unspecified)
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst              15
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         3
      bInterfaceCount         2
      bFunctionClass         14 Video
      bFunctionSubClass       3 Video Interface Collection
      bFunctionProtocol       0 =

      iFunction               6 Intel(R) RealSense(TM) Depth Camera 455  RGB
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass        14 Video
      bInterfaceSubClass      1 Video Control
      bInterfaceProtocol      0 =

      iInterface              6 Intel(R) RealSense(TM) Depth Camera 455  RGB
      VideoControl Interface Descriptor:
        bLength                13
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdUVC               1.50
        wTotalLength           81
        dwClockFrequency       48.000000MHz
        bInCollection           1
        baInterfaceNr( 0)       4
      VideoControl Interface Descriptor:
        bLength                18
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             6
        wTerminalType      0x0201 Camera Sensor
        bAssocTerminal          0
        iTerminal               0 =

        wObjectiveFocalLengthMin      0
        wObjectiveFocalLengthMax      0
        wOcularFocalLength            0
        bControlSize                  3
        bmControls           0x0000000e
          Auto-Exposure Mode
          Auto-Exposure Priority
          Exposure Time (Absolute)
      VideoControl Interface Descriptor:
        bLength                13
        bDescriptorType        36
        bDescriptorSubtype      5 (PROCESSING_UNIT)
        bUnitID                 7
        bSourceID               6
        wMaxMultiplier      16384
        bControlSize            3
        bmControls     0x0000177f
          Brightness
          Contrast
          Hue
          Saturation
          Sharpness
          Gamma
          White Balance Temperature
          Backlight Compensation
          Gain
          Power Line Frequency
          White Balance Temperature, Auto
        iProcessing             0 =

        bmVideoStandards     0x 0
      VideoControl Interface Descriptor:
        bLength                28
        bDescriptorType        36
        bDescriptorSubtype      6 (EXTENSION_UNIT)
        bUnitID                 8
        guidExtensionCode         {6e41ecb8-aca3-8045-8d5c-0bee1597e43d}
        bNumControl             2
        bNrPins                 1
        baSourceID( 0)          7
        bControlSize            3
        bmControls( 0)       0x03
        bmControls( 1)       0x00
        bmControls( 2)       0x00
        iExtension              0 =

      VideoControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             9
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID               7
        iTerminal               0 =

    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        4
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0 =

      iInterface              6 Intel(R) RealSense(TM) Depth Camera 455  RGB
      VideoStreaming Interface Descriptor:
        bLength                            15
        bDescriptorType                    36
        bDescriptorSubtype                  1 (INPUT_HEADER)
        bNumFormats                         2
        wTotalLength                      419
        bEndPointAddress                  132
        bmInfo                              0
        bTerminalLink                       9
        bStillCaptureMethod                 0
        bTriggerSupport                     0
        bTriggerUsage                       0
        bControlSize                        1
        bmaControls( 0)                    28
        bmaControls( 1)                    28
      VideoStreaming Interface Descriptor:
        bLength                            28
        bDescriptorType                    36
        bDescriptorSubtype                 16 (FORMAT_FRAME_BASED)
        bFormatIndex                        1
        bNumFrameDescriptors                7
        guidFormat                            {59555932-0000-1000-8000-00aa=
00389b71}
        bBitsPerPixel                      16
        bDefaultFrameIndex                  1
        bAspectRatioX                       0
        bAspectRatioY                       0
        bmInterlaceFlags                 0x00
          Interlaced stream or variable: No
          Fields per frame: 2 fields
          Field 1 first: No
          Field pattern: Field 1 only
          bCopyProtect                      0
          bVariableSize                     0
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         1
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            424
        wHeight                           240
        dwMinBitRate                  8140800
        dwMaxBitRate                146534400
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                    848
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           2000000
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         2
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            480
        wHeight                           270
        dwMinBitRate                 10368000
        dwMaxBitRate                186624000
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                    960
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           2000000
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         3
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            640
        wHeight                           360
        dwMinBitRate                 18432000
        dwMaxBitRate                331776000
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                   1280
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           2000000
      VideoStreaming Interface Descriptor:
        bLength                            42
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         4
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            640
        wHeight                           480
        dwMinBitRate                 24576000
        dwMaxBitRate                294912000
        dwDefaultFrameInterval         166666
        bFrameIntervalType                  4
        dwBytesPerLine                   1280
        dwFrameInterval( 0)            166666
        dwFrameInterval( 1)            333333
        dwFrameInterval( 2)            666666
        dwFrameInterval( 3)           2000000
      VideoStreaming Interface Descriptor:
        bLength                            42
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         5
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            848
        wHeight                           480
        dwMinBitRate                 32563200
        dwMaxBitRate                390758400
        dwDefaultFrameInterval         166666
        bFrameIntervalType                  4
        dwBytesPerLine                   1696
        dwFrameInterval( 0)            166666
        dwFrameInterval( 1)            333333
        dwFrameInterval( 2)            666666
        dwFrameInterval( 3)           2000000
      VideoStreaming Interface Descriptor:
        bLength                            42
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         6
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                           1280
        wHeight                           720
        dwMinBitRate                 73728000
        dwMaxBitRate                442368000
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  4
        dwBytesPerLine                   2560
        dwFrameInterval( 0)            333333
        dwFrameInterval( 1)            666666
        dwFrameInterval( 2)           1000000
        dwFrameInterval( 3)           2000000
      VideoStreaming Interface Descriptor:
        bLength                            42
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         7
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                           1280
        wHeight                           800
        dwMinBitRate                 81920000
        dwMaxBitRate                491520000
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  4
        dwBytesPerLine                   2560
        dwFrameInterval( 0)            333333
        dwFrameInterval( 1)            666666
        dwFrameInterval( 2)           1000000
        dwFrameInterval( 3)           2000000
      VideoStreaming Interface Descriptor:
        bLength                             6
        bDescriptorType                    36
        bDescriptorSubtype                 13 (COLORFORMAT)
        bColorPrimaries                     0 (Unspecified)
        bTransferCharacteristics            0 (Unspecified)
        bMatrixCoefficients                 0 (Unspecified)
      VideoStreaming Interface Descriptor:
        bLength                            28
        bDescriptorType                    36
        bDescriptorSubtype                 16 (FORMAT_FRAME_BASED)
        bFormatIndex                        2
        bNumFrameDescriptors                1
        guidFormat                            {52573136-661a-42a2-9065-d018=
14a8ef8a}
        bBitsPerPixel                      16
        bDefaultFrameIndex                  1
        bAspectRatioX                       0
        bAspectRatioY                       0
        bmInterlaceFlags                 0x00
          Interlaced stream or variable: No
          Fields per frame: 2 fields
          Field 1 first: No
          Field pattern: Field 1 only
          bCopyProtect                      0
          bVariableSize                     0
      VideoStreaming Interface Descriptor:
        bLength                            30
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         1
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                           1280
        wHeight                           800
        dwMinBitRate                491520000
        dwMaxBitRate                491520000
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  1
        dwBytesPerLine                   2560
        dwFrameInterval( 0)            333333
      VideoStreaming Interface Descriptor:
        bLength                             6
        bDescriptorType                    36
        bDescriptorSubtype                 13 (COLORFORMAT)
        bColorPrimaries                     0 (Unspecified)
        bTransferCharacteristics            0 (Unspecified)
        bMatrixCoefficients                 0 (Unspecified)
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst              15
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        5
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      0 No Subclass
      bInterfaceProtocol      0 None
      iInterface              9 Intel(R) RealSense(TM) HID
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.10
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength    1000
         Report Descriptors: =

           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x86  EP 6 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               2
        bMaxBurst               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        6
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0 =

      bInterfaceProtocol      0 =

      iInterface              0 =

      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst              15
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst              15
Binary Object Store Descriptor:
  bLength                 5
  bDescriptorType        15
  wTotalLength           50
  bNumDeviceCaps          3
Device Status:     0x0000
  (Bus Powered)

<<< END lsusb -v for d455.txt >>>

<<< BEGIN lsusb -v for d435.txt >>>
Bus 002 Device 006: ID 8086:0b07 Intel Corp. =

Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               3.20
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2 ?
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0         9
  idVendor           0x8086 Intel Corp.
  idProduct          0x0b07 =

  bcdDevice           50.e0
  iManufacturer           1 Intel(R) RealSense(TM) Depth Camera 435 =

  iProduct                2 Intel(R) RealSense(TM) Depth Camera 435 =

  iSerial                 3 012345678901
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength         3062
    bNumInterfaces          6
    bConfigurationValue     1
    iConfiguration          0 =

    bmAttributes         0x80
      (Bus Powered)
    MaxPower              180mA
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         0
      bInterfaceCount         3
      bFunctionClass         14 Video
      bFunctionSubClass       3 Video Interface Collection
      bFunctionProtocol       0 =

      iFunction               5 Intel(R) RealSense(TM) Depth Camera 435 wit=
h RGB Module Depth
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      1 Video Control
      bInterfaceProtocol      0 =

      iInterface              5 Intel(R) RealSense(TM) Depth Camera 435 wit=
h RGB Module Depth
      VideoControl Interface Descriptor:
        bLength                14
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdUVC               1.50
        wTotalLength           91
        dwClockFrequency       48.000000MHz
        bInCollection           2
        baInterfaceNr( 0)       1
        baInterfaceNr( 1)       2
      VideoControl Interface Descriptor:
        bLength                18
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             1
        wTerminalType      0x0201 Camera Sensor
        bAssocTerminal          0
        iTerminal               0 =

        wObjectiveFocalLengthMin      0
        wObjectiveFocalLengthMax      0
        wOcularFocalLength            0
        bControlSize                  3
        bmControls           0x00200000
      VideoControl Interface Descriptor:
        bLength                13
        bDescriptorType        36
        bDescriptorSubtype      5 (PROCESSING_UNIT)
        bUnitID                 2
        bSourceID               1
        wMaxMultiplier      16384
        bControlSize            3
        bmControls     0x00000200
          Gain
        iProcessing             0 =

        bmVideoStandards     0x 0
      VideoControl Interface Descriptor:
        bLength                28
        bDescriptorType        36
        bDescriptorSubtype      6 (EXTENSION_UNIT)
        bUnitID                 3
        guidExtensionCode         {cb6c60c9-4c59-254d-af47-ccc496435995}
        bNumControl            16
        bNrPins                 1
        baSourceID( 0)          2
        bControlSize            3
        bmControls( 0)       0xff
        bmControls( 1)       0xdd
        bmControls( 2)       0x00
        iExtension              6 Intel(R) RealSense(TM) Depth Camera 435 w=
ith RGB Module RGB
      VideoControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             4
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID               3
        iTerminal               0 =

      VideoControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             5
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID               3
        iTerminal               0 =

      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x87  EP 7 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               6
        bMaxBurst               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0 =

      iInterface              5 Intel(R) RealSense(TM) Depth Camera 435 wit=
h RGB Module Depth
      VideoStreaming Interface Descriptor:
        bLength                            15
        bDescriptorType                    36
        bDescriptorSubtype                  1 (INPUT_HEADER)
        bNumFormats                         2
        wTotalLength                      755
        bEndPointAddress                  130
        bmInfo                              0
        bTerminalLink                       4
        bStillCaptureMethod                 0
        bTriggerSupport                     0
        bTriggerUsage                       0
        bControlSize                        1
        bmaControls( 0)                    28
        bmaControls( 1)                    28
      VideoStreaming Interface Descriptor:
        bLength                            28
        bDescriptorType                    36
        bDescriptorSubtype                 16 (FORMAT_FRAME_BASED)
        bFormatIndex                        1
        bNumFrameDescriptors                8
        guidFormat                            {5a313620-0000-1000-8000-00aa=
00389b71}
        bBitsPerPixel                      16
        bDefaultFrameIndex                  1
        bAspectRatioX                       0
        bAspectRatioY                       0
        bmInterlaceFlags                 0x00
          Interlaced stream or variable: No
          Fields per frame: 2 fields
          Field 1 first: No
          Field pattern: Field 1 only
          bCopyProtect                      0
          bVariableSize                     0
      VideoStreaming Interface Descriptor:
        bLength                            34
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         1
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            256
        wHeight                           144
        dwMinBitRate                 53084160
        dwMaxBitRate                176947200
        dwDefaultFrameInterval          33333
        bFrameIntervalType                  2
        dwBytesPerLine                    512
        dwFrameInterval( 0)             33333
        dwFrameInterval( 1)            111111
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         2
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            424
        wHeight                           240
        dwMinBitRate                  9768960
        dwMaxBitRate                146534400
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                    848
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           1666665
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         3
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            480
        wHeight                           270
        dwMinBitRate                 12441600
        dwMaxBitRate                186624000
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                    960
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           1666665
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         4
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            640
        wHeight                           360
        dwMinBitRate                 22118400
        dwMaxBitRate                331776000
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                   1280
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           1666665
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         5
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            640
        wHeight                           480
        dwMinBitRate                 29491200
        dwMaxBitRate                442368000
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                   1280
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           1666665
      VideoStreaming Interface Descriptor:
        bLength                            34
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         6
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            848
        wHeight                           100
        dwMinBitRate                135680000
        dwMaxBitRate                407040000
        dwDefaultFrameInterval          33333
        bFrameIntervalType                  2
        dwBytesPerLine                   1696
        dwFrameInterval( 0)             33333
        dwFrameInterval( 1)            100000
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         7
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            848
        wHeight                           480
        dwMinBitRate                 39075840
        dwMaxBitRate                586137600
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                   1696
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           1666665
      VideoStreaming Interface Descriptor:
        bLength                            38
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         8
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                           1280
        wHeight                           720
        dwMinBitRate                 88473600
        dwMaxBitRate                442368000
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  3
        dwBytesPerLine                   2560
        dwFrameInterval( 0)            333333
        dwFrameInterval( 1)            666666
        dwFrameInterval( 2)           1666665
      VideoStreaming Interface Descriptor:
        bLength                             6
        bDescriptorType                    36
        bDescriptorSubtype                 13 (COLORFORMAT)
        bColorPrimaries                     0 (Unspecified)
        bTransferCharacteristics            0 (Unspecified)
        bMatrixCoefficients                 0 (Unspecified)
      VideoStreaming Interface Descriptor:
        bLength                            28
        bDescriptorType                    36
        bDescriptorSubtype                 16 (FORMAT_FRAME_BASED)
        bFormatIndex                        2
        bNumFrameDescriptors                8
        guidFormat                            {50000000-0000-1000-8000-00aa=
00389b71}
        bBitsPerPixel                      16
        bDefaultFrameIndex                  1
        bAspectRatioX                       0
        bAspectRatioY                       0
        bmInterlaceFlags                 0x00
          Interlaced stream or variable: No
          Fields per frame: 2 fields
          Field 1 first: No
          Field pattern: Field 1 only
          bCopyProtect                      0
          bVariableSize                     0
      VideoStreaming Interface Descriptor:
        bLength                            34
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         1
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            256
        wHeight                           144
        dwMinBitRate                 53084160
        dwMaxBitRate                176947200
        dwDefaultFrameInterval          33333
        bFrameIntervalType                  2
        dwBytesPerLine                    512
        dwFrameInterval( 0)             33333
        dwFrameInterval( 1)            111111
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         2
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            424
        wHeight                           240
        dwMinBitRate                  9768960
        dwMaxBitRate                146534400
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                    848
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           1666665
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         3
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            480
        wHeight                           270
        dwMinBitRate                 12441600
        dwMaxBitRate                186624000
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                    960
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           1666665
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         4
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            640
        wHeight                           360
        dwMinBitRate                 22118400
        dwMaxBitRate                331776000
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                   1280
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           1666665
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         5
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            640
        wHeight                           480
        dwMinBitRate                 29491200
        dwMaxBitRate                442368000
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                   1280
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           1666665
      VideoStreaming Interface Descriptor:
        bLength                            34
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         6
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            848
        wHeight                           100
        dwMinBitRate                135680000
        dwMaxBitRate                407040000
        dwDefaultFrameInterval          33333
        bFrameIntervalType                  2
        dwBytesPerLine                   1696
        dwFrameInterval( 0)             33333
        dwFrameInterval( 1)            100000
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         7
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            848
        wHeight                           480
        dwMinBitRate                 39075840
        dwMaxBitRate                586137600
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                   1696
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           1666665
      VideoStreaming Interface Descriptor:
        bLength                            38
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         8
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                           1280
        wHeight                           720
        dwMinBitRate                 88473600
        dwMaxBitRate                442368000
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  3
        dwBytesPerLine                   2560
        dwFrameInterval( 0)            333333
        dwFrameInterval( 1)            666666
        dwFrameInterval( 2)           1666665
      VideoStreaming Interface Descriptor:
        bLength                             6
        bDescriptorType                    36
        bDescriptorSubtype                 13 (COLORFORMAT)
        bColorPrimaries                     0 (Unspecified)
        bTransferCharacteristics            0 (Unspecified)
        bMatrixCoefficients                 0 (Unspecified)
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst              15
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0 =

      iInterface              8 Intel(R) RealSense(TM) Depth Camera 435  Y
      VideoStreaming Interface Descriptor:
        bLength                            18
        bDescriptorType                    36
        bDescriptorSubtype                  1 (INPUT_HEADER)
        bNumFormats                         5
        wTotalLength                     1498
        bEndPointAddress                  131
        bmInfo                              0
        bTerminalLink                       5
        bStillCaptureMethod                 0
        bTriggerSupport                     0
        bTriggerUsage                       0
        bControlSize                        1
        bmaControls( 0)                    28
        bmaControls( 1)                    28
        bmaControls( 2)                    28
        bmaControls( 3)                    28
        bmaControls( 4)                    28
      VideoStreaming Interface Descriptor:
        bLength                            28
        bDescriptorType                    36
        bDescriptorSubtype                 16 (FORMAT_FRAME_BASED)
        bFormatIndex                        1
        bNumFrameDescriptors                7
        guidFormat                            {32000000-0000-1000-8000-00aa=
00389b71}
        bBitsPerPixel                       8
        bDefaultFrameIndex                  1
        bAspectRatioX                       0
        bAspectRatioY                       0
        bmInterlaceFlags                 0x00
          Interlaced stream or variable: No
          Fields per frame: 2 fields
          Field 1 first: No
          Field pattern: Field 1 only
          bCopyProtect                      0
          bVariableSize                     0
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         1
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            424
        wHeight                           240
        dwMinBitRate                  4884480
        dwMaxBitRate                 73267200
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                    424
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           1666665
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         2
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            480
        wHeight                           270
        dwMinBitRate                  6220800
        dwMaxBitRate                 93312000
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                    480
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           1666665
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         3
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            640
        wHeight                           360
        dwMinBitRate                 11059200
        dwMaxBitRate                165888000
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                    640
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           1666665
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         4
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            640
        wHeight                           480
        dwMinBitRate                 14745600
        dwMaxBitRate                221184000
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                    640
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           1666665
      VideoStreaming Interface Descriptor:
        bLength                            34
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         5
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            848
        wHeight                           100
        dwMinBitRate                 67840000
        dwMaxBitRate                203520000
        dwDefaultFrameInterval          33333
        bFrameIntervalType                  2
        dwBytesPerLine                    848
        dwFrameInterval( 0)             33333
        dwFrameInterval( 1)            100000
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         6
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            848
        wHeight                           480
        dwMinBitRate                 19537920
        dwMaxBitRate                293068800
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                    848
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           1666665
      VideoStreaming Interface Descriptor:
        bLength                            38
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         7
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                           1280
        wHeight                           720
        dwMinBitRate                 44236800
        dwMaxBitRate                221184000
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  3
        dwBytesPerLine                   1280
        dwFrameInterval( 0)            333333
        dwFrameInterval( 1)            666666
        dwFrameInterval( 2)           1666665
      VideoStreaming Interface Descriptor:
        bLength                             6
        bDescriptorType                    36
        bDescriptorSubtype                 13 (COLORFORMAT)
        bColorPrimaries                     0 (Unspecified)
        bTransferCharacteristics            0 (Unspecified)
        bMatrixCoefficients                 0 (Unspecified)
      VideoStreaming Interface Descriptor:
        bLength                            28
        bDescriptorType                    36
        bDescriptorSubtype                 16 (FORMAT_FRAME_BASED)
        bFormatIndex                        2
        bNumFrameDescriptors                7
        guidFormat                            {55595659-0000-1000-8000-00aa=
00389b71}
        bBitsPerPixel                      16
        bDefaultFrameIndex                  1
        bAspectRatioX                       0
        bAspectRatioY                       0
        bmInterlaceFlags                 0x00
          Interlaced stream or variable: No
          Fields per frame: 2 fields
          Field 1 first: No
          Field pattern: Field 1 only
          bCopyProtect                      0
          bVariableSize                     0
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         1
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            424
        wHeight                           240
        dwMinBitRate                  9768960
        dwMaxBitRate                146534400
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                    848
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           1666665
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         2
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            480
        wHeight                           270
        dwMinBitRate                 12441600
        dwMaxBitRate                186624000
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                    960
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           1666665
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         3
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            640
        wHeight                           360
        dwMinBitRate                 22118400
        dwMaxBitRate                331776000
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                   1280
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           1666665
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         4
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            640
        wHeight                           480
        dwMinBitRate                 29491200
        dwMaxBitRate                442368000
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                   1280
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           1666665
      VideoStreaming Interface Descriptor:
        bLength                            34
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         5
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            848
        wHeight                           100
        dwMinBitRate                135680000
        dwMaxBitRate                407040000
        dwDefaultFrameInterval          33333
        bFrameIntervalType                  2
        dwBytesPerLine                   1696
        dwFrameInterval( 0)             33333
        dwFrameInterval( 1)            100000
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         6
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            848
        wHeight                           480
        dwMinBitRate                 39075840
        dwMaxBitRate                586137600
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                   1696
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           1666665
      VideoStreaming Interface Descriptor:
        bLength                            38
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         7
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                           1280
        wHeight                           720
        dwMinBitRate                 88473600
        dwMaxBitRate                442368000
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  3
        dwBytesPerLine                   2560
        dwFrameInterval( 0)            333333
        dwFrameInterval( 1)            666666
        dwFrameInterval( 2)           1666665
      VideoStreaming Interface Descriptor:
        bLength                             6
        bDescriptorType                    36
        bDescriptorSubtype                 13 (COLORFORMAT)
        bColorPrimaries                     0 (Unspecified)
        bTransferCharacteristics            0 (Unspecified)
        bMatrixCoefficients                 0 (Unspecified)
      VideoStreaming Interface Descriptor:
        bLength                            28
        bDescriptorType                    36
        bDescriptorSubtype                 16 (FORMAT_FRAME_BASED)
        bFormatIndex                        3
        bNumFrameDescriptors                7
        guidFormat                            {59382020-0000-1000-8000-00aa=
00389b71}
        bBitsPerPixel                       8
        bDefaultFrameIndex                  1
        bAspectRatioX                       0
        bAspectRatioY                       0
        bmInterlaceFlags                 0x00
          Interlaced stream or variable: No
          Fields per frame: 2 fields
          Field 1 first: No
          Field pattern: Field 1 only
          bCopyProtect                      0
          bVariableSize                     0
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         1
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            424
        wHeight                           240
        dwMinBitRate                  4884480
        dwMaxBitRate                 73267200
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                    424
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           1666665
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         2
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            480
        wHeight                           270
        dwMinBitRate                  6220800
        dwMaxBitRate                 93312000
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                    480
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           1666665
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         3
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            640
        wHeight                           360
        dwMinBitRate                 11059200
        dwMaxBitRate                165888000
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                    640
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           1666665
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         4
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            640
        wHeight                           480
        dwMinBitRate                 14745600
        dwMaxBitRate                221184000
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                    640
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           1666665
      VideoStreaming Interface Descriptor:
        bLength                            34
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         5
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            848
        wHeight                           100
        dwMinBitRate                 67840000
        dwMaxBitRate                203520000
        dwDefaultFrameInterval          33333
        bFrameIntervalType                  2
        dwBytesPerLine                    848
        dwFrameInterval( 0)             33333
        dwFrameInterval( 1)            100000
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         6
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            848
        wHeight                           480
        dwMinBitRate                 19537920
        dwMaxBitRate                293068800
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                    848
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           1666665
      VideoStreaming Interface Descriptor:
        bLength                            38
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         7
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                           1280
        wHeight                           720
        dwMinBitRate                 44236800
        dwMaxBitRate                221184000
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  3
        dwBytesPerLine                   1280
        dwFrameInterval( 0)            333333
        dwFrameInterval( 1)            666666
        dwFrameInterval( 2)           1666665
      VideoStreaming Interface Descriptor:
        bLength                             6
        bDescriptorType                    36
        bDescriptorSubtype                 13 (COLORFORMAT)
        bColorPrimaries                     0 (Unspecified)
        bTransferCharacteristics            0 (Unspecified)
        bMatrixCoefficients                 0 (Unspecified)
      VideoStreaming Interface Descriptor:
        bLength                            28
        bDescriptorType                    36
        bDescriptorSubtype                 16 (FORMAT_FRAME_BASED)
        bFormatIndex                        4
        bNumFrameDescriptors                8
        guidFormat                            {59384920-0000-1000-8000-00aa=
00389b71}
        bBitsPerPixel                      16
        bDefaultFrameIndex                  1
        bAspectRatioX                       0
        bAspectRatioY                       0
        bmInterlaceFlags                 0x00
          Interlaced stream or variable: No
          Fields per frame: 2 fields
          Field 1 first: No
          Field pattern: Field 1 only
          bCopyProtect                      0
          bVariableSize                     0
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         1
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            424
        wHeight                           240
        dwMinBitRate                  9768960
        dwMaxBitRate                146534400
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                    848
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           1666665
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         2
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            480
        wHeight                           270
        dwMinBitRate                 12441600
        dwMaxBitRate                186624000
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                    960
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           1666665
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         3
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            640
        wHeight                           360
        dwMinBitRate                 22118400
        dwMaxBitRate                331776000
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                   1280
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           1666665
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         4
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            640
        wHeight                           480
        dwMinBitRate                 29491200
        dwMaxBitRate                442368000
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                   1280
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           1666665
      VideoStreaming Interface Descriptor:
        bLength                            34
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         5
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            848
        wHeight                           100
        dwMinBitRate                135680000
        dwMaxBitRate                407040000
        dwDefaultFrameInterval          33333
        bFrameIntervalType                  2
        dwBytesPerLine                   1696
        dwFrameInterval( 0)             33333
        dwFrameInterval( 1)            100000
      VideoStreaming Interface Descriptor:
        bLength                            46
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         6
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            848
        wHeight                           480
        dwMinBitRate                 39075840
        dwMaxBitRate                586137600
        dwDefaultFrameInterval         111111
        bFrameIntervalType                  5
        dwBytesPerLine                   1696
        dwFrameInterval( 0)            111111
        dwFrameInterval( 1)            166666
        dwFrameInterval( 2)            333333
        dwFrameInterval( 3)            666666
        dwFrameInterval( 4)           1666665
      VideoStreaming Interface Descriptor:
        bLength                            38
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         7
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                           1280
        wHeight                           720
        dwMinBitRate                 88473600
        dwMaxBitRate                442368000
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  3
        dwBytesPerLine                   2560
        dwFrameInterval( 0)            333333
        dwFrameInterval( 1)            666666
        dwFrameInterval( 2)           1666665
      VideoStreaming Interface Descriptor:
        bLength                            34
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         8
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                           1280
        wHeight                           800
        dwMinBitRate                245760000
        dwMaxBitRate                491520000
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  2
        dwBytesPerLine                   2560
        dwFrameInterval( 0)            333333
        dwFrameInterval( 1)            666666
      VideoStreaming Interface Descriptor:
        bLength                             6
        bDescriptorType                    36
        bDescriptorSubtype                 13 (COLORFORMAT)
        bColorPrimaries                     0 (Unspecified)
        bTransferCharacteristics            0 (Unspecified)
        bMatrixCoefficients                 0 (Unspecified)
      VideoStreaming Interface Descriptor:
        bLength                            28
        bDescriptorType                    36
        bDescriptorSubtype                 16 (FORMAT_FRAME_BASED)
        bFormatIndex                        5
        bNumFrameDescriptors                2
        guidFormat                            {59313249-0000-1000-8000-00aa=
00389b71}
        bBitsPerPixel                      24
        bDefaultFrameIndex                  1
        bAspectRatioX                       0
        bAspectRatioY                       0
        bmInterlaceFlags                 0x00
          Interlaced stream or variable: No
          Fields per frame: 2 fields
          Field 1 first: No
          Field pattern: Field 1 only
          bCopyProtect                      0
          bVariableSize                     0
      VideoStreaming Interface Descriptor:
        bLength                            34
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         1
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            640
        wHeight                           400
        dwMinBitRate                 92160000
        dwMaxBitRate                153600000
        dwDefaultFrameInterval         400000
        bFrameIntervalType                  2
        dwBytesPerLine                   1920
        dwFrameInterval( 0)            400000
        dwFrameInterval( 1)            666666
      VideoStreaming Interface Descriptor:
        bLength                            34
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         2
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                           1280
        wHeight                           800
        dwMinBitRate                368640000
        dwMaxBitRate                614400000
        dwDefaultFrameInterval         400000
        bFrameIntervalType                  2
        dwBytesPerLine                   3840
        dwFrameInterval( 0)            400000
        dwFrameInterval( 1)            666666
      VideoStreaming Interface Descriptor:
        bLength                             6
        bDescriptorType                    36
        bDescriptorSubtype                 13 (COLORFORMAT)
        bColorPrimaries                     0 (Unspecified)
        bTransferCharacteristics            0 (Unspecified)
        bMatrixCoefficients                 0 (Unspecified)
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst              15
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         3
      bInterfaceCount         2
      bFunctionClass         14 Video
      bFunctionSubClass       3 Video Interface Collection
      bFunctionProtocol       0 =

      iFunction               6 Intel(R) RealSense(TM) Depth Camera 435 wit=
h RGB Module RGB
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass        14 Video
      bInterfaceSubClass      1 Video Control
      bInterfaceProtocol      0 =

      iInterface              6 Intel(R) RealSense(TM) Depth Camera 435 wit=
h RGB Module RGB
      VideoControl Interface Descriptor:
        bLength                13
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdUVC               1.50
        wTotalLength           81
        dwClockFrequency       48.000000MHz
        bInCollection           1
        baInterfaceNr( 0)       4
      VideoControl Interface Descriptor:
        bLength                18
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             6
        wTerminalType      0x0201 Camera Sensor
        bAssocTerminal          0
        iTerminal               0 =

        wObjectiveFocalLengthMin      0
        wObjectiveFocalLengthMax      0
        wOcularFocalLength            0
        bControlSize                  3
        bmControls           0x0000000e
          Auto-Exposure Mode
          Auto-Exposure Priority
          Exposure Time (Absolute)
      VideoControl Interface Descriptor:
        bLength                13
        bDescriptorType        36
        bDescriptorSubtype      5 (PROCESSING_UNIT)
        bUnitID                 7
        bSourceID               6
        wMaxMultiplier      16384
        bControlSize            3
        bmControls     0x0000177f
          Brightness
          Contrast
          Hue
          Saturation
          Sharpness
          Gamma
          White Balance Temperature
          Backlight Compensation
          Gain
          Power Line Frequency
          White Balance Temperature, Auto
        iProcessing             0 =

        bmVideoStandards     0x 0
      VideoControl Interface Descriptor:
        bLength                28
        bDescriptorType        36
        bDescriptorSubtype      6 (EXTENSION_UNIT)
        bUnitID                 8
        guidExtensionCode         {6e41ecb8-aca3-8045-8d5c-0bee1597e43d}
        bNumControl             2
        bNrPins                 1
        baSourceID( 0)          7
        bControlSize            3
        bmControls( 0)       0x03
        bmControls( 1)       0x00
        bmControls( 2)       0x00
        iExtension              0 =

      VideoControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             9
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID               7
        iTerminal               0 =

    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        4
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0 =

      iInterface              6 Intel(R) RealSense(TM) Depth Camera 435 wit=
h RGB Module RGB
      VideoStreaming Interface Descriptor:
        bLength                            15
        bDescriptorType                    36
        bDescriptorSubtype                  1 (INPUT_HEADER)
        bNumFormats                         2
        wTotalLength                      475
        bEndPointAddress                  132
        bmInfo                              0
        bTerminalLink                       9
        bStillCaptureMethod                 0
        bTriggerSupport                     0
        bTriggerUsage                       0
        bControlSize                        1
        bmaControls( 0)                    28
        bmaControls( 1)                    28
      VideoStreaming Interface Descriptor:
        bLength                            28
        bDescriptorType                    36
        bDescriptorSubtype                 16 (FORMAT_FRAME_BASED)
        bFormatIndex                        1
        bNumFrameDescriptors                9
        guidFormat                            {59555932-0000-1000-8000-00aa=
00389b71}
        bBitsPerPixel                      16
        bDefaultFrameIndex                  1
        bAspectRatioX                       0
        bAspectRatioY                       0
        bmInterlaceFlags                 0x00
          Interlaced stream or variable: No
          Fields per frame: 2 fields
          Field 1 first: No
          Field pattern: Field 1 only
          bCopyProtect                      0
          bVariableSize                     0
      VideoStreaming Interface Descriptor:
        bLength                            38
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         1
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            320
        wHeight                           180
        dwMinBitRate                  5529600
        dwMaxBitRate                 55296000
        dwDefaultFrameInterval         166666
        bFrameIntervalType                  3
        dwBytesPerLine                    640
        dwFrameInterval( 0)            166666
        dwFrameInterval( 1)            333333
        dwFrameInterval( 2)           1666665
      VideoStreaming Interface Descriptor:
        bLength                            38
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         2
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            320
        wHeight                           240
        dwMinBitRate                  7372800
        dwMaxBitRate                 73728000
        dwDefaultFrameInterval         166666
        bFrameIntervalType                  3
        dwBytesPerLine                    640
        dwFrameInterval( 0)            166666
        dwFrameInterval( 1)            333333
        dwFrameInterval( 2)           1666665
      VideoStreaming Interface Descriptor:
        bLength                            42
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         3
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            424
        wHeight                           240
        dwMinBitRate                  9768960
        dwMaxBitRate                 97689600
        dwDefaultFrameInterval         166666
        bFrameIntervalType                  4
        dwBytesPerLine                    848
        dwFrameInterval( 0)            166666
        dwFrameInterval( 1)            333333
        dwFrameInterval( 2)            666666
        dwFrameInterval( 3)           1666665
      VideoStreaming Interface Descriptor:
        bLength                            42
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         4
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            640
        wHeight                           360
        dwMinBitRate                 22118400
        dwMaxBitRate                221184000
        dwDefaultFrameInterval         166666
        bFrameIntervalType                  4
        dwBytesPerLine                   1280
        dwFrameInterval( 0)            166666
        dwFrameInterval( 1)            333333
        dwFrameInterval( 2)            666666
        dwFrameInterval( 3)           1666665
      VideoStreaming Interface Descriptor:
        bLength                            42
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         5
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            640
        wHeight                           480
        dwMinBitRate                 29491200
        dwMaxBitRate                294912000
        dwDefaultFrameInterval         166666
        bFrameIntervalType                  4
        dwBytesPerLine                   1280
        dwFrameInterval( 0)            166666
        dwFrameInterval( 1)            333333
        dwFrameInterval( 2)            666666
        dwFrameInterval( 3)           1666665
      VideoStreaming Interface Descriptor:
        bLength                            42
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         6
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            848
        wHeight                           480
        dwMinBitRate                 39075840
        dwMaxBitRate                390758400
        dwDefaultFrameInterval         166666
        bFrameIntervalType                  4
        dwBytesPerLine                   1696
        dwFrameInterval( 0)            166666
        dwFrameInterval( 1)            333333
        dwFrameInterval( 2)            666666
        dwFrameInterval( 3)           1666665
      VideoStreaming Interface Descriptor:
        bLength                            42
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         7
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            960
        wHeight                           540
        dwMinBitRate                 49766400
        dwMaxBitRate                497664000
        dwDefaultFrameInterval         166666
        bFrameIntervalType                  4
        dwBytesPerLine                   1920
        dwFrameInterval( 0)            166666
        dwFrameInterval( 1)            333333
        dwFrameInterval( 2)            666666
        dwFrameInterval( 3)           1666665
      VideoStreaming Interface Descriptor:
        bLength                            38
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         8
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                           1280
        wHeight                           720
        dwMinBitRate                 88473600
        dwMaxBitRate                442368000
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  3
        dwBytesPerLine                   2560
        dwFrameInterval( 0)            333333
        dwFrameInterval( 1)            666666
        dwFrameInterval( 2)           1666665
      VideoStreaming Interface Descriptor:
        bLength                            38
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         9
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                           1920
        wHeight                          1080
        dwMinBitRate                199065600
        dwMaxBitRate                995328000
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  3
        dwBytesPerLine                   3840
        dwFrameInterval( 0)            333333
        dwFrameInterval( 1)            666666
        dwFrameInterval( 2)           1666665
      VideoStreaming Interface Descriptor:
        bLength                             6
        bDescriptorType                    36
        bDescriptorSubtype                 13 (COLORFORMAT)
        bColorPrimaries                     0 (Unspecified)
        bTransferCharacteristics            0 (Unspecified)
        bMatrixCoefficients                 0 (Unspecified)
      VideoStreaming Interface Descriptor:
        bLength                            28
        bDescriptorType                    36
        bDescriptorSubtype                 16 (FORMAT_FRAME_BASED)
        bFormatIndex                        2
        bNumFrameDescriptors                1
        guidFormat                            {52573136-661a-42a2-9065-d018=
14a8ef8a}
        bBitsPerPixel                      16
        bDefaultFrameIndex                  1
        bAspectRatioX                       0
        bAspectRatioY                       0
        bmInterlaceFlags                 0x00
          Interlaced stream or variable: No
          Fields per frame: 2 fields
          Field 1 first: No
          Field pattern: Field 1 only
          bCopyProtect                      0
          bVariableSize                     0
      VideoStreaming Interface Descriptor:
        bLength                            30
        bDescriptorType                    36
        bDescriptorSubtype                 17 (FRAME_FRAME_BASED)
        bFrameIndex                         1
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                           1920
        wHeight                          1080
        dwMinBitRate                995328000
        dwMaxBitRate                995328000
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  1
        dwBytesPerLine                   3840
        dwFrameInterval( 0)            333333
      VideoStreaming Interface Descriptor:
        bLength                             6
        bDescriptorType                    36
        bDescriptorSubtype                 13 (COLORFORMAT)
        bColorPrimaries                     0 (Unspecified)
        bTransferCharacteristics            0 (Unspecified)
        bMatrixCoefficients                 0 (Unspecified)
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst              15
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        5
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0 =

      bInterfaceProtocol      0 =

      iInterface              0 =

      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst              15
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst              15
Binary Object Store Descriptor:
  bLength                 5
  bDescriptorType        15
  wTotalLength           50
  bNumDeviceCaps          3
Device Status:     0x0000
  (Bus Powered)
<<< END lsusb -v for d455.txt >>>


On Mon, 2023-01-30 at 09:09 +0100, Ricardo Ribalda wrote:
> Hi Dmitry
> =

> I believe Laurent usually requests the full usb descriptors. Could you
> send the output of lsusb -v for these devices?
> =

> Thanks!
> =

> On Sun, 29 Jan 2023 at 15:30, Dmitry Perchanov
> <dmitry.perchanov@intel.com> wrote:
> > Intel RealSense UVC cameras Metadata support.
> > =

> > Co-developed-by: Yu MENG <yu1.meng@intel.com>
> > Co-developed-by: Evgeni Raikhel <evgeni.raikhel@intel.com>
> > Signed-off-by: Dmitry Perchanov <dmitry.perchanov@intel.com>
> > ---
> >  drivers/media/usb/uvc/uvc_driver.c | 72 ++++++++++++++++++++++++++++++
> >  1 file changed, 72 insertions(+)
> > =

> > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc=
/uvc_driver.c
> > index e4bcb5011360..955f67d9a993 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -3000,6 +3000,78 @@ static const struct usb_device_id uvc_ids[] =3D {
> >           .bInterfaceSubClass   =3D 1,
> >           .bInterfaceProtocol   =3D 0,
> >           .driver_info          =3D UVC_INFO_META(V4L2_META_FMT_D4XX) },
> > +       /* Intel D410/ASR depth camera */
> > +       { .match_flags          =3D USB_DEVICE_ID_MATCH_DEVICE
> > +                               | USB_DEVICE_ID_MATCH_INT_INFO,
> > +         .idVendor             =3D 0x8086,
> > +         .idProduct            =3D 0x0ad2,
> > +         .bInterfaceClass      =3D USB_CLASS_VIDEO,
> > +         .bInterfaceSubClass   =3D 1,
> > +         .bInterfaceProtocol   =3D 0,
> > +         .driver_info          =3D UVC_INFO_META(V4L2_META_FMT_D4XX) },
> > +       /* Intel D415/ASRC depth camera */
> > +       { .match_flags          =3D USB_DEVICE_ID_MATCH_DEVICE
> > +                               | USB_DEVICE_ID_MATCH_INT_INFO,
> > +         .idVendor             =3D 0x8086,
> > +         .idProduct            =3D 0x0ad3,
> > +         .bInterfaceClass      =3D USB_CLASS_VIDEO,
> > +         .bInterfaceSubClass   =3D 1,
> > +         .bInterfaceProtocol   =3D 0,
> > +         .driver_info          =3D UVC_INFO_META(V4L2_META_FMT_D4XX) },
> > +       /* Intel D430/AWG depth camera */
> > +       { .match_flags          =3D USB_DEVICE_ID_MATCH_DEVICE
> > +                               | USB_DEVICE_ID_MATCH_INT_INFO,
> > +         .idVendor             =3D 0x8086,
> > +         .idProduct            =3D 0x0ad4,
> > +         .bInterfaceClass      =3D USB_CLASS_VIDEO,
> > +         .bInterfaceSubClass   =3D 1,
> > +         .bInterfaceProtocol   =3D 0,
> > +         .driver_info          =3D UVC_INFO_META(V4L2_META_FMT_D4XX) },
> > +       /* Intel Fallback USB2 Descriptor */
> > +       { .match_flags          =3D USB_DEVICE_ID_MATCH_DEVICE
> > +                               | USB_DEVICE_ID_MATCH_INT_INFO,
> > +         .idVendor             =3D 0x8086,
> > +         .idProduct            =3D 0x0ad6,
> > +         .bInterfaceClass      =3D USB_CLASS_VIDEO,
> > +         .bInterfaceSubClass   =3D 1,
> > +         .bInterfaceProtocol   =3D 0,
> > +         .driver_info          =3D UVC_INFO_META(V4L2_META_FMT_D4XX) },
> > +       /* Intel D435/AWGC depth camera */
> > +       { .match_flags          =3D USB_DEVICE_ID_MATCH_DEVICE
> > +                               | USB_DEVICE_ID_MATCH_INT_INFO,
> > +         .idVendor             =3D 0x8086,
> > +         .idProduct            =3D 0x0b07,
> > +         .bInterfaceClass      =3D USB_CLASS_VIDEO,
> > +         .bInterfaceSubClass   =3D 1,
> > +         .bInterfaceProtocol   =3D 0,
> > +         .driver_info          =3D UVC_INFO_META(V4L2_META_FMT_D4XX) },
> > +       /* Intel D435i depth camera */
> > +       { .match_flags          =3D USB_DEVICE_ID_MATCH_DEVICE
> > +                               | USB_DEVICE_ID_MATCH_INT_INFO,
> > +         .idVendor             =3D 0x8086,
> > +         .idProduct            =3D 0x0b3a,
> > +         .bInterfaceClass      =3D USB_CLASS_VIDEO,
> > +         .bInterfaceSubClass   =3D 1,
> > +         .bInterfaceProtocol   =3D 0,
> > +         .driver_info          =3D UVC_INFO_META(V4L2_META_FMT_D4XX) },
> > +       /* Intel D405 Depth Camera */
> > +       { .match_flags          =3D USB_DEVICE_ID_MATCH_DEVICE
> > +                               | USB_DEVICE_ID_MATCH_INT_INFO,
> > +         .idVendor             =3D 0x8086,
> > +         .idProduct            =3D 0x0b5b,
> > +         .bInterfaceClass      =3D USB_CLASS_VIDEO,
> > +         .bInterfaceSubClass   =3D 1,
> > +         .bInterfaceProtocol   =3D 0,
> > +         .driver_info          =3D UVC_INFO_META(V4L2_META_FMT_D4XX) },
> > +       /* Intel D455 Depth Camera */
> > +       { .match_flags          =3D USB_DEVICE_ID_MATCH_DEVICE
> > +                               | USB_DEVICE_ID_MATCH_INT_INFO,
> > +         .idVendor             =3D 0x8086,
> > +         .idProduct            =3D 0x0b5c,
> > +         .bInterfaceClass      =3D USB_CLASS_VIDEO,
> > +         .bInterfaceSubClass   =3D 1,
> > +         .bInterfaceProtocol   =3D 0,
> > +         .driver_info          =3D UVC_INFO_META(V4L2_META_FMT_D4XX) },
> >         /* Generic USB Video Class */
> >         { USB_INTERFACE_INFO(USB_CLASS_VIDEO, 1, UVC_PC_PROTOCOL_UNDEFI=
NED) },
> >         { USB_INTERFACE_INFO(USB_CLASS_VIDEO, 1, UVC_PC_PROTOCOL_15) },
> > --
> > 2.25.1
> > =

> > =

> > ---------------------------------------------------------------------
> > Intel Israel (74) Limited
> > =

> > This e-mail and any attachments may contain confidential material for
> > the sole use of the intended recipient(s). Any review or distribution
> > by others is strictly prohibited. If you are not the intended
> > recipient, please contact the sender and delete all copies.
> > =

> =

> =


---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

