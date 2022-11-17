Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2270F62DADF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbiKQMaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240089AbiKQM3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:29:02 -0500
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392E971F3B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 04:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1668688129;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=o1Of7SasIvL4zjj/d+LU0bHmOfJWM7Blc34WEI87rO8=;
  b=gWz857fUADT+k9dX3TPwZ+rj1m7r8Awt5kA8i5JyDkvrlvZA+AyD1bV8
   CGA4g5lU0uzSevUn3noLo/D1APW6SaEh4thRILfNvW26KCqS77/kuIRge
   z3MJmGbI38FdpBq29/DiwST6m3p8O7A/k+MZSQkDc4432S8q0zsPPsfam
   I=;
X-IronPort-RemoteIP: 104.47.58.105
X-IronPort-MID: 85021016
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:sZzEqq2Agk5okDwm8PbD5WBwkn2cJEfYwER7XKvMYLTBsI5bpzZRy
 WQXX2iDbKmIY2Wkeoonaojg9RsOu5HdyN82GlFvpC1hF35El5HIVI+TRqvS04F+DeWYFR46s
 J9OAjXkBJppJpMJjk71atANlVEliefTAOK5ULSfUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tq3qMDEULOf82cc3lk8tuTS9nuDgNyo4GlC5wVnOqgR1LPjvyJ94Kw3dPnZw0TQGuG4LsbiL
 87fwbew+H/u/htFIrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRrukoPD9IOaF8/ttm8t4sZJ
 OOhF3CHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqFvnrSFL/hGVSkL0YMkFulfLSZU+
 tc9EW40UR2hwOe5/LGcFsNBr5F2RCXrFNt3VnBI6xj8VK5jbbWdBqLA6JlfwSs6gd1IEbDGf
 c0FZDFzbRPGJRpSJlMQD5F4l+Ct7pX9W2QA9BTJ+uxqsy6KlFEZPLvFabI5fvSjQ8lPk1nej
 WXB52njWTkRNcCFyCrD+XWp7gPKtXOmANhLTOTmnhJsqGyRz2M4BEYRbweipeeL0kGsZ8pnK
 nVBr0LCqoB3riRHVOLVWhSipXeesx00WtxOEvY74gWA1qrV5QmCAmEOCDVGbbQOsM4wWCxv1
 VKTmd7tLSJgvafTSn+H8LqQ6zSoNkA9L2AYYjQfZRAY+NSlq4Y25jrUVcpqGqOxitzzGBnzz
 iqMoSx4gK8c5eYM06i45lnBjyibuonSTgU16wPUWUqo9gp8IoWiYuSA61LW8PJBJ4axVUSas
 T4PnM32xPADC9SBmTKARM0JHaq1/LCVPTvEm1ltEpI9sTO39BaLYY9U8Bl6JUF0LtwDfz75J
 kPe0T69/7dWNXquKKNyPYS4Dp1yybC6TIy4EPfJctBJf559Mhed+z1jblKR2Garl1UwlaY4O
 tGQdsPE4WsmNJmLBQGeH481uYLHDAhnrY8PbfgXFyia7Ic=
IronPort-HdrOrdr: A9a23:x9MIZ6ljuVx2X2z7NV8e/lmEMFLpDfMEiWdD5ihNYBxZY6Wkfp
 +V8cjzhCWftN9OYhodcIi7SdK9qXO1z+8X3WGIVY3SETUOy1HYVr2KirGSjwEIeheOvNK1sJ
 0NT0EQMqyWMbEXt6fHCUyDYq4dKbq8ge+VbIXlvhFQpGhRAskOgTuRSDzra3GeLzM2Z6bRYa
 Dsgvav0ADQHEj/AP7aOlA1G8z44/HbnpPvZhALQzYh9Qm1lDutrJLqDhSC2R8acjVXhZMv63
 LMnQDV7riq96jT8G6c60bjq7Bt3PfxwNpKA8KBzuATNzXXkw6tIKhxRrGYuzgxgee3rHInis
 PFrRsMN9l6r1nRYma2ix3w3BSI6kdh11bSjXujxVfzq83wQzw3T+Bbg5hCTxff4008+Plhza
 NixQuixtlqJCKFuB64y8nDVhlsmEbxi2Eli/Qvg3tWVpZbQKNNrLYY4FheHP47bWDHAcEcYa
 xT5fPnlbFrmGChHjbkV65UsYWRt0EIb1O7q445y5SoOnZt7StEJgAjtbEidz87he4Aot9/lq
 T52+1T5c9zpoV9V9MDOM4RBcSwEWDDWhTKLSabJknmDrgOPzbXp4fw+6hd3pDiRHUk9upEpH
 36aiIviUciP0b1TcGe1pxC9R7ABG27QDT208lbo5x0oKf1SrbnOTCKDAlGqbrqn9wPRsnAH/
 qjMpNfBPHuaWPoBIZSxgX7H51fM2MXXsEZsssyH1iOvsXIIIv3sfGzSoeaGJP9VTI/Hm/vCH
 oKWzb+YM1G80CwQ3f9xAPcXnv8E3aPia6Y0JKqitT75LJ9RbGk6DJl+GhRzvv7WQFqo+gxYF
 Z0Jq/hn+eyuXS2lFy4nVlUBg==
X-IronPort-AV: E=Sophos;i="5.96,171,1665460800"; 
   d="scan'208";a="85021016"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Nov 2022 07:28:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hky2llobSglHuLR2C+eV8cHUIuC8wfLG1FD9LeIQrYtrNLUXvHj5U4bMNS8Gl1lWltNEVsUSKaXQrPh6RzqB1iqSBL/yh4JsIRkR0h7//3qy2MgZY4VNC/RLwECUTZamoRX4rmzfZ1SP7qKDxEdffEyWlVd1Q1axvY+40Svx0gPOLzsNYPKNzZV/p8Npkh0bLjrC3DocW9MzEnFVW1QRpZ2MbuGU3KfIUHr1bfH0Ka6XwnJtPChjxlCyUvc51TIHd9AvseXx3CvGhyM7qPJQzZQRGaagPKue4qghj4aQYh5H42bNIO5wiu/xQ/nGBnSIe4CQxsiMK0Ftk1IbvrADyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1Of7SasIvL4zjj/d+LU0bHmOfJWM7Blc34WEI87rO8=;
 b=gX8iHtN9vx/feTu8TPUcU5sgMiqK9F/3WXE02gaKJAgAbFKzsw6GlEu7B7/jM7kK7UJlsSDZsGwLdnuNWN25Gu3PB2R4BcF8N/MXtpzPA+JZWNzLdy5lvV+0PN1R6iy/Q5ERfCcVOWNWLuF09LtOJkL9hZ0P7w6qaFTEpgTyV5qCt1JhQOLjgAf346Rx/GERn03DQeE93LLCdUuJGNVwMq38V/HfUM4DH4Ne/gcgTL5vsU8JEIsrcbiAbqdGKwLVYIIBaMulTvGA6OnC1+Y7+y+fEojy0IZ6Lq0HpKFRoItBo2zS+nEy/yoxpC7fjBMHnyvfxpUZ2gDNbhbfZcvJkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1Of7SasIvL4zjj/d+LU0bHmOfJWM7Blc34WEI87rO8=;
 b=FY4Hjzhrk6ih1XOMCpeRESpzMreYmIpKZwSepyL9Eykftk4OOBEqgmagC4wbZvutwcsm83KODlBuWG+oxMElXVcK6G+Zt0G7o49IP3SEHoo11F9mHB9qpoATHT/Matix7QQqsxk//GYAxxYxBRFLSlGBC22DO9gOJEK7f2Vh5wo=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by MW4PR03MB6395.namprd03.prod.outlook.com (2603:10b6:303:122::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 12:28:47 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::c679:226f:52fa:4c19]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::c679:226f:52fa:4c19%5]) with mapi id 15.20.5813.020; Thu, 17 Nov 2022
 12:28:46 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     =?utf-8?B?TWFyZWsgTWFyY3p5a293c2tpLUfDs3JlY2tp?= 
        <marmarek@invisiblethingslab.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jan Beulich <jbeulich@suse.com>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] xen-pciback: Consider MSI-X enabled only when MASKALL bit
 is cleared
Thread-Topic: [PATCH] xen-pciback: Consider MSI-X enabled only when MASKALL
 bit is cleared
Thread-Index: AQHY+nmitCFszY02+EavJ4U+R9Py8K5DC1MA
Date:   Thu, 17 Nov 2022 12:28:46 +0000
Message-ID: <e606aa11-aeb7-fcaa-d699-380be4adc1ac@citrix.com>
References: <20221117114122.1588338-1-marmarek@invisiblethingslab.com>
In-Reply-To: <20221117114122.1588338-1-marmarek@invisiblethingslab.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR03MB3623:EE_|MW4PR03MB6395:EE_
x-ms-office365-filtering-correlation-id: 9ea922b8-1b9c-4624-5c59-08dac8974621
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a6aXv1yVbkkbZ+OIk6YalTjkFUitW0wbYEQ3AhDUqTx0hDf1+0OqM/IvAjlYCTz2O5YmW3nTj6MnhID4LPytlEXn2nxwbiqBqSE3isddC3e0jZ6Aik8LOxQAumbjGngqPeNc2Z9HXbiuOhYZ9Z4WwFiMKGmnc8TpZoFodxFMd+rY2VfbPKQzIYgKDuck901hKUiAGtTjsrXIIK/TaypggddGFsvZaZ2X2NZa9cbrEY6/Iq7bTjUPWOmzAZ04jDyOTjw9AwLgAcD9n2UTjZKNHAbD25I66JULNjurQ0blGK/jM7dMDUtWeXbTCY1/g//l8/mXRIijs/bDFWaMBpb2+35xKerD7mBVILu50kHhUSIKGG/2rizuf1+B52I0u1dI76QY8oapJihBJDZjCmX0SztiWfkeRsd74MGSSLvVjmc8R9taJcEC4Wl3gz0p61hoRhFspRVE7OY6s3ejKsP0aklWW+AHVlQLMjc7ulZ0LSRiZMoS6aH4bd6eHaV/Kne8g7npcl/gkHF+BG3Dk6aSnBCX1xPxh8odyHa8c66ytXKSfbV4Wa4BaT5g4eigzvq4X8APXB24NwIelT9R44rAHbxWgZpgg+1eqT09wEPsGTq35AKOjztGk0TmwOE7VtUKtb64oB2RlAoSIBbPSAtooZCyPe2EGOPsugeoiqjerTl46+N9Pc24dmYOOTrOrGU/Bgy8AEN5UY1DwFrqmOargHNvFtus1OzM9fL/0S5Ka6j5TSzUfelb02EDLkwAXeWna1vOAUWDVRCIAf31g4vhqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199015)(2616005)(64756008)(86362001)(31696002)(4326008)(186003)(8676002)(76116006)(66476007)(66946007)(8936002)(66446008)(91956017)(66556008)(478600001)(5660300002)(36756003)(41300700001)(6486002)(6512007)(6506007)(71200400001)(110136005)(26005)(66574015)(54906003)(4744005)(122000001)(316002)(53546011)(82960400001)(38070700005)(38100700002)(83380400001)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTF5bTNnT2dWRWNTTjlhck5JNXdiandrMFN1R1NVN3hKOGJYOTJHR3hwNnY0?=
 =?utf-8?B?R0JxcEZ4WEdNeWhCeCszSTFOYTMwZ3kzSXhqRnFSWFNncmNrK1ZCdnU2SUh0?=
 =?utf-8?B?Qjd5dUw2U1EwSzFhRFNoRzk5Tm1jTjFNUWYzZFZVS3hZZEZuNllXSU1uNm9U?=
 =?utf-8?B?eE9IRHk2UFRRRHJhL1YyL0RoN3kzL2hFZnN2UTk0c05HM1pQZXpiTVI2bHhj?=
 =?utf-8?B?QlJnYnlCRk9mTzkrbWxzM0x2RXRpMjJ6NGYybHdRTlNNR0Q0SkY1OWdYNFlP?=
 =?utf-8?B?clJNVU9na3YrTnRYd0sybElhRTdZbmxUazZJV244RnRtUzhzbE9QMzY3dXN3?=
 =?utf-8?B?UzlJZlhVdy95b3R6dHBycWsrRkcrOERYb1ZsYzBpVVRyTDROOWQ1ZkxhWVhz?=
 =?utf-8?B?b1hzei81UUJ4V1dnWit4ajRNY2hxQk1WVDMwaVhRNFI0cmd5bC9UbnFVdHUy?=
 =?utf-8?B?WHh6R2twTUF2bDVrT1h5M0lEa2IzUlNtV1hBOFlBS2ljRnBkL2RoaEFObk92?=
 =?utf-8?B?dHFiVjRONzhQVUVkRGttblhBZHl4N1dXcTNDWXhzMEhWcFB3bUVJTGZlc21V?=
 =?utf-8?B?WTZ4SnBqN2MwOU9HMjRldlhsMGFoM1ZFUWlpaVhzSGhJQkNaTEsrY3dtcEth?=
 =?utf-8?B?TzFzNHJZTDVzeXJnZit0UGU2TGxXcm5tOGw3MWVrTVBnZEphNzh0bUxmSXps?=
 =?utf-8?B?bG8rR0Qvd0s3R2hvc0FMWDltZC94eG5MODZJRCtxZGZIYysvN1UrcjJJV1N3?=
 =?utf-8?B?enk1eFFWUUdTMk9WOUF4ZFJMRVZDVFNCVDhjM2ZpL2pNWXNzWEVkU1ViM3RW?=
 =?utf-8?B?MkZudTJYMGhDRzljY1RrVlZibXI2d2tLL0RvNWcwMVB2cCtJSU15M0JwYjdB?=
 =?utf-8?B?L01VNFdWbG9nWXN1VGVxK1IxdWVBeHJ4YTBsQU9aZzl2WUFoSmVkYW9nZ21G?=
 =?utf-8?B?YzhyRWlNa1Qxd0JNSTdFbUNzTDBCMHFicmUxOHMvQmFNS2lxWGtVVHBHTHky?=
 =?utf-8?B?aUZFM2R4NzlMYnJlYzcwa2VKS2k1RlkwNXNXR2t5S3JhNmlQS1I4NzhEKzVN?=
 =?utf-8?B?bDA4THlFd3FvTnVBR2pGTkdPcVhmMmNZMkRtVmF3aEkxYm1maXNDck9WaXZ1?=
 =?utf-8?B?ZGozK2dDOENYeGpaRnBwTVpNQ1ZubE0vcG9hTVVxMzRqNEFEeWszaHoySUpp?=
 =?utf-8?B?NnROYUk5dm5qQWVIYndiTVI0RG15T2dPcGF1WWVaMHViai9NckordlNEcWVi?=
 =?utf-8?B?V3hyRnk2dEhLU1Q5Z3k3emFOUVk2TVJHYnhScUUzL05NZ0VCMnN4N2t6ajdZ?=
 =?utf-8?B?cnVQdE13T20xWFhTdW1qc2pPZ0djclhRaHFMbDAzdTBGUVFXQ3hxZTJBVVFQ?=
 =?utf-8?B?NzN4V2p2dFFuSE5Panc1U0NKaGxSWXgrbmVoc1J0djQ4M3NXUFVYVjNFZGZE?=
 =?utf-8?B?WDBUaXVQWlQ1MHhMS1RINFZ2WmZhaWUraHNlRGdOL3dtYW1LQjEvZlhzMWtX?=
 =?utf-8?B?N2xiNjRpNU1PZkg4Szd5Vmw5a2ROZVR6c1JJais1dGlWNjFyU0NLaUlrL0Vw?=
 =?utf-8?B?aVUrR0dEZmJsZlFGRDBJbGwyejVTcVdBY3l1TW1jaUxhZjVzbGlhUFExeFJs?=
 =?utf-8?B?bXMrWVpkMkhvUC9lbXE2YUpFR3Q4dm41OHFLNlA5Y1l1Q2pSUzRjRzBGbWFJ?=
 =?utf-8?B?clY2WFZjS1J2blpLRnlGcDN6dXBROFAyUUdsLzZXRmVyQkNvamloUjI1NXhn?=
 =?utf-8?B?ME15eENiV1V5Sk5LMTFXOUkzcnVieHFrSHVvcEJZNStwc1VTRmV0RjRJTE1l?=
 =?utf-8?B?YkxScGs3emUvZVpXUnhsUEprZDlsYnBYWDkzdjQzYy9IZmI4VWw5K2FxeFRI?=
 =?utf-8?B?Vnp2S1VzWUxnb1hMcXo5OG5PVGhxT0ZqMEs5WlVsWXRBMlBCVzNNRUd1d1I1?=
 =?utf-8?B?T2tCS0hma0hpM2ltYjZERDkwbCtEaXFSYnI0QW5pcXY1UTE5T0lvSzNaejJ1?=
 =?utf-8?B?QzBuUHcxY3RzcitoUm16ckdRQStVd2cweXd5QnBOV3A2OXpWQzdQSjR4WjNY?=
 =?utf-8?B?aC9IRW5qOTVtZlZxZFR6Q3FWaDdDQ1U3RVBtRXJPTWd2WGQyS0NYRXRGYis2?=
 =?utf-8?B?THJnSktncHFmRUNyNzlUeUxHQ3FvNnU0TE5Wb2pXRXpFTktacnpFdmNPM3Ns?=
 =?utf-8?B?ZlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB6C0DBDF3C2594C8FA97E5B739934D0@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dk11Q0YvQmpReWdYd3QxWncxSllpUUxtUmZMS3BhdjB3ZlJVQU8ydFpvaXpy?=
 =?utf-8?B?alREL01wQWtBbXBKRURIWlQ5VnU2OTJjQnJEM1F6OVU4WGJBckl5Y3RXQWxy?=
 =?utf-8?B?U1ljZVJHM0ZTWlVZTnhEcXFsbTY3QzNESnRKMHY1T2ZJY3llL1ZxOVJ3TXIy?=
 =?utf-8?B?clpIa21hWWlhSWVhL3pka1g3eGNnMExlSmEraW5HS3plUDM1VjZTcTVaREYw?=
 =?utf-8?B?T1ZoK1hQSDZtSEJJL3drWjdoTXZ6Zkx5WTlSWENTOVNscGp0QXNlQXlyWm85?=
 =?utf-8?B?YmhVK3FleXBNK2pTcVNEcHlXY3RpYklsOTFObjZyeHFOaytONXUrUVBSdmtR?=
 =?utf-8?B?MTI3ZkJZSlR4WlllY1M0Z0RpZ0tPUDJYZ1FaODNVUzlmZG1hZUV0bEI1Tzgz?=
 =?utf-8?B?b1VmWEhZbytEQlZUWS9jRkcwbkpwV1ZsWlVDWFVCNWFMSGtrQTRpSFZBa1Fa?=
 =?utf-8?B?ZzY4TElDVERLQUdDVExoUks0TDJCVG5DWm1QRkYxL3RJZTI2MENYWGdyQlJp?=
 =?utf-8?B?RnVJNUl4MUlQZVZVMlRFd2NUV2lkQS9pQWpZVGxVMmdMNzlrQzRPUEFFRWxk?=
 =?utf-8?B?RWo2aS9DcDU4MllVQk83WEV6RmxnN2pXMFNtZFJUbnZHL1RsTkdaZnBWMDZa?=
 =?utf-8?B?V3k2S0dnZEptTGlpY2lJeXpWcGJhbFIvU3MxY1RQdEdPcnBsQzZoaUtQdVZa?=
 =?utf-8?B?OWE0bzFqOHhwVmZiZkF3OVY0VnpKOFFmOVlpSlUxbWpMcG5GckZ0aDNvcm56?=
 =?utf-8?B?MUxoSEJUSURTM2pZVmRON1RONS9oRmFvYkFZV0E5dlBvQUxYQlU3a3VyUGl1?=
 =?utf-8?B?cVlxNHd2UDhwR0ZqTVVLQmdwZFBSUFdaQ0svQzY0SVhPMDZ0bG1mQ09mNngr?=
 =?utf-8?B?TDhiOGFQSDFEczVqUHRFcjdKZHE1cngxdXFmQWFldXMyODBKQURYQW1ya3dh?=
 =?utf-8?B?Y3NzUGFNa1pHSVo2anVRelE3WHYwTUt5RGYyNy9YbFQzbnVsSE4zVGFPQjBv?=
 =?utf-8?B?dFdqSXYyL21jZmpBR0tWcmIxdjJ2RnZaRW41bTdtdU83NWkwdjhaazZtSENz?=
 =?utf-8?B?MEVMQWJRM3BrMzRUdzZrb2x4UU83ZnNYSXI1REtEQnBYRXF1WjB3UnRhM2pP?=
 =?utf-8?B?UGpuRHdIOHRzd2MyZXZkVVdZd0NxdWIxMGw4RHdiajQwbi9aemNKaUJnZkN4?=
 =?utf-8?B?MmdIRXpESVVrTlpxbnJzbHFTODZEY1dUZ3pnZFM0MDQ2VUV0OVJ6S3Q5ZWdz?=
 =?utf-8?B?b2V6Q1BLeFZtTnZiR1ZkM0puTW5FUUlpQy9oMUNYNjhoSHFqaUNoZHBURDRo?=
 =?utf-8?B?blJZdCt1amdVUGI3Unh2WTUvTzJhQ24vR2hoVlkyR0M4MllkbjNQaFlWNE91?=
 =?utf-8?B?NXN6OGZVWGduTHc9PQ==?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea922b8-1b9c-4624-5c59-08dac8974621
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 12:28:46.7929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E3myUmIeg/AE+qTIpAdc39HKto8w5oDvuDmM/wWlIifvP9mbA/PzklK7z2UFxcyR3snkfOA8Byo3na+U/ZmZLFegt3xIZZi2xOG4VZe24Ek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6395
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTcvMTEvMjAyMiAxMTo0MSwgTWFyZWsgTWFyY3p5a293c2tpLUfDs3JlY2tpIHdyb3RlOg0K
PiBMaW51eCBlbmFibGVzIE1TSS1YIGJlZm9yZSBkaXNhYmxpbmcgSU5UeCwgYnV0IGtlZXBzIE1T
SS1YIG1hc2tlZCB1bnRpbA0KPiB0aGUgdGFibGUgaXMgZmlsbGVkLiBUaGVuIGl0IGRpc2FibGVz
IElOVHgganVzdCBiZWZvcmUgY2xlYXJpbmcgTUFTS0FMTA0KPiBiaXQuIEN1cnJlbnRseSB0aGlz
IGFwcHJvYWNoIGlzIHJlamVjdGVkIGJ5IHhlbi1wY2liYWNrLg0KPiBBbGxvdyBzZXR0aW5nIFBD
SV9NU0lYX0ZMQUdTX0VOQUJMRSB3aGlsZSBJTlR4IGlzIHN0aWxsIGVuYWJsZWQgYXMgbG9uZw0K
PiBhcyBQQ0lfTVNJWF9GTEFHU19NQVNLQUxMIGlzIHNldCB0b28uDQo+DQo+IEZpeGVzOiA1ZTI5
NTAwZWJhMmEgKCJ4ZW4tcGNpYmFjazogQWxsb3cgc2V0dGluZyBQQ0lfTVNJWF9GTEFHU19NQVNL
QUxMIHRvbyIpDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmVrIE1hcmN6eWtvd3NraS1Hw7NyZWNraSA8
bWFybWFyZWtAaW52aXNpYmxldGhpbmdzbGFiLmNvbT4NCg0KVGhlIFBDSSBzcGVjIHN0YXRlcyB0
aGF0IGRldmljZXMgYXJlIG5vdCBwZXJtaXR0ZWQgdG8gdXNlIElOVHggd2hlbiBNU0kNCm9yIE1T
SS1YIGlzIGVuYWJsZWQuwqAgVGhlIG1hc2sgc3RhdHVzIGhhcyBubyBsZWdpdGltYXRlIGJlYXJp
bmcgb24gaXJxIHR5cGUuDQoNCklOVHhfRElTQUJMRSBleGlzdHMgYXMgYSBib2RnZSB0byBtZWFu
ICJJTlR4IG5vdCBwZXJtaXR0ZWQgZXZlbiB3aGVuDQpuZWl0aGVyIE1TSSBub3IgTVNJLVggYXJl
IGVuYWJsZWQiLCBhbmQgZXhpc3RzIGJlY2F1c2UgaW4gc29tZSBjYXNlLA0KdHJhbnNpZW50bHkg
ZGlzYWJsaW5nIE1TSSBpcyB0aGUgb25seSBzYWZlIHdheSB0byB1cGRhdGUgdGhlIGRlc2NyaXB0
b3IuDQoNCg0KSSBjYW4gYmVsaWV2ZSB0aGF0IHRoaXMgY2hhbmdlIGZpeGVzIGEgYW4gaXNzdWUs
IGJ1dCB0aGUgbG9naWMgc3VyZWx5DQpjYW5ub3QgYmUgY29ycmVjdCBvdmVyYWxsLg0KDQp+QW5k
cmV3DQo=
