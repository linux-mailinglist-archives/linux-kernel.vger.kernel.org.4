Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C054631E7C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiKUKei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiKUKea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:34:30 -0500
Received: from esa2.hc3370-68.iphmx.com (esa2.hc3370-68.iphmx.com [216.71.145.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB12527CCF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1669026869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=YHPGugGitXvHZlE1d9kV/h0t+sD3euQGc1fPgzWqA5o=;
  b=RmZCK3mlkh1qBe6/p/DdyE9hcGLY6OlqAIdYRwdvhhJsCuTzBe+UyUtQ
   eJUe7vOW5CsKNpgxBNy3ag/4izg+ZN++Ab0YsAwiISyhHpeBTGSOWQr8Y
   nXIVOAPBC2JbkVFiCf6cKbdU90h4KbTu/QdBujy7SaT1OOJ9mEZBDJ6Ua
   U=;
X-IronPort-RemoteIP: 104.47.66.49
X-IronPort-MID: 85257541
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:46A+dq0vDFv1o4vKu/bD5fpxkn2cJEfYwER7XKvMYLTBsI5bp2RUy
 DEbUG2OOvbYa2H3fNp0bo3l80kOv8eGx9ZiG1dopC1hF35El5HIVI+TRqvS04F+DeWYFR46s
 J9OAjXkBJppJpMJjk71atANlVEliefTAOK5ULSfUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tq3qMDEULOf82cc3lk8tuTS9nuDgNyo4GlC5wVkPKgS1LPjvyJ94Kw3dPnZw0TQGuG4LsbiL
 87fwbew+H/u/htFIrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRrukoPD9IOaF8/ttm8t4sZJ
 OOhF3CHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqFvnrSFL/hGVSkL0YMkFulfGU9q8
 +5DChExPh2oh9Dx+q6ge+g1iZF2RCXrFNt3VnBI6xj8VKxjZK+ZBqLA6JlfwSs6gd1IEbDGf
 c0FZDFzbRPGJRpSJlMQD5F4l+Ct7pX9W2QA9BTJ+uxpvS6PnWSd05C0WDbRUsaNSshP2F6Ru
 0rN/njjAwFcP9uaodaA2iLx3LKQwH+iMG4UPK2H0fds3Qa5/GMoVDgXdnCmpty7uFHrDrqzL
 GRRoELCt5Ma8E2tU8m4XBCipnOAlgATVsAWEOAg7gyJjK3O7G6xFmUCCzJMdtEinMs3XiAxk
 E+EmcvzAj5iu6HTTmiSnp+Woim1IjM9NnIZaGkPSg5ty9PkuoAoyBXUUsxkDrW2n/XyAzj7x
 z3Mpy87750Pgsob/6G6+03bmTWqp4iPQgNdzgDWWG2ixhl0aI6se8qj7l2zxfxYBI+dT1SH7
 D4IlqC24OkQANeNnSqWTeMlGLCv+ubDMTvAjFopFJ4knxy9qyCLfo1K5jx6YkBzPa4seSfgS
 F3CpQRLopRUOROCd6Z5ao+1I8cn167tEZLiTP+8Rt5DZJJZdwKd+ixqI0mK0AjFmUMskKg5N
 r+baYCnCnNyIbpqyjm/W+oG0fkzzyQ6xHvaSZHTzhK73L7Yb3mQIZ8BMV2TfqUw57uFiBva/
 swZNMaQzRhbFurkbUHqHZU7KFkLKT0+GsrwoskOLOqbeFI6SScmFuPbxq4nd8p9haNJm+zU/
 3a7HEhF1F74gn6BIgKPApx+VI7SsV9EhSpTFUQR0ZyAghDPva7HAH8jSqYK
IronPort-HdrOrdr: A9a23:lLr1CqHA5d/qxkw5pLqFiJLXdLJyesId70hD6qkvc3Fom52j/f
 xGws5x6faVslkssb8b6LK90c67MAnhHP9OkPIs1NKZMDUO11HYSL2KgbGD/9SkIVyGygc/79
 YeT0EBMqyWMbESt6+TjmiF+pQbsaG6GciT9JvjJhxWPGRXgs9bnmRE4lHxKDwKeOAKP+tOKL
 Osou584xawc3Ueacq2QlEDQuj4vtXO0L72fBIcABYjyQ+WyRel8qTzHRS01goXF2on+8ZpzU
 H11yjCoomzufCyzRHRk0fV8pRtgdPkjvdTGcCWjcARCzP0ziKlfp5oVbGutC085Muv9FEput
 /RpApIBbU511rhOkWO5Tf90Qjp1zgjr1fk1F+jmHPm5ej0XigzBcZtjZ9QNkKx0TtpgPhMlI
 Zwm06JvZteCh3N2Az7+tjzThlv0m65u2Arn+I/h2FWFaEedLhSh4oC+149KuZIIAvKrKQcVM
 V+BsDV4/hbNXuccnDip2FqhOehW3widy32N3Qqi4iw6Xx7jXp5x0wXyIg0hXEb7q8wTJFC+q
 DtLrlovKsmdL5ZUYtNQMM6BeenAG3ERhzBdEiIJ078Ka0BM3XR77bq/bQO4v2wcpBg9up8pH
 34aiIZiYcOQTOsNSXXt6c7sCwlAV/NEQgF8/supqSQ4dbHNf/W2S7qciFdryLvmYRaPiThYY
 fCBHtnOY6cEYLQI/c54+SHYeg1FZA/arxghj9pYSP4nuv7bqvXi8f8TNH/YJLQLBdMYBKNPp
 JEZkm/GPl9
X-IronPort-AV: E=Sophos;i="5.96,181,1665460800"; 
   d="scan'208";a="85257541"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Nov 2022 05:33:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIpmqLgd1AzlqK8pqGDec0OLCrIb8xv/yosS8KXL/bN28ieay/LlbgbozxatE+yaEpSP/5jEHN9pLhtBVJUMMR6l4aFVRwFzy8RLH2dm6R7X50SDJ1AdymDDVEikFEql5Wz4UvTq12t2jjyiVgGllJFXnyoKmD3FzC/b4J02dRCwosWGXM9lDovQ55YPl3YAtMnOZv1oRA33Y0ZEhk8jSWyAL0rFMTWBFLm07aN77FpROiurpmNQDgahonxNPdRcMr2rOvMZ+29EG0N1DCTwKHOiUWxXmO5c8m7PFBmfO1P1hkChGxUwzEAXzMnNvl9bRik8/oq5ksYSHYHYe8CWsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+3B4L6OirXeCSTJWk4PnCTnlFvaE8OXfvZ/IgYSk6A=;
 b=hyS4BGKh9pbxAsdhDiynwJfs//zih3895saqEs31lA8EjCdrifxFamaePSaUV1TQ+fOseJISzrQXxTA9mDKlYNG+nBEQn7ovwKa6Ov+PXQSFADOKpN6PQLegN8x0OMZ58BVD4uiekB9R3voNssMF+UoFhKZxKaxF0CdPWHuw1+5o+c51NZZNZvM52ts5lxu+nzXe3Mk0JgjLzTJ1kJuu2yfn32H6lW07hzt1OFAGdx8/3Z+954mGlP7sOu/5Rm+8s4ygcnCp1gv/7DUwEOWsXrl+PZCjNFKkwwj+VRE1mpBmogkLszhgwEHomKk15P5ioKFYQeJWJznorpXCXgVTGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+3B4L6OirXeCSTJWk4PnCTnlFvaE8OXfvZ/IgYSk6A=;
 b=wqJSgE7utIsmTSsPzikIXUv6qWUXOLiRiXZxWZtmP41BM1KbEuml7ofsPfHvq6XbAVtkWZNut1r5RbeOI9Bk6Wd/fup4aPcMaCNWTAs1A4TJdrfi7bLFDiJVrQiI0WEaH7SZ9KgBAM6Olq9CHQlNZt9G1P+0aFAJ7x6LG6XGvZU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com (2603:10b6:a03:395::11)
 by BL1PR03MB6102.namprd03.prod.outlook.com (2603:10b6:208:31c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Mon, 21 Nov
 2022 10:33:20 +0000
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::740b:4e0a:7de4:5ab1]) by SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::740b:4e0a:7de4:5ab1%7]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 10:33:20 +0000
From:   Roger Pau Monne <roger.pau@citrix.com>
To:     linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, jgross@suse.com,
        Roger Pau Monne <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Alex Chiang <achiang@hp.com>,
        Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 1/3] acpi/processor: fix evaluating _PDC method when running as Xen dom0
Date:   Mon, 21 Nov 2022 11:21:10 +0100
Message-Id: <20221121102113.41893-2-roger.pau@citrix.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221121102113.41893-1-roger.pau@citrix.com>
References: <20221121102113.41893-1-roger.pau@citrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0041.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::12) To SJ0PR03MB6360.namprd03.prod.outlook.com
 (2603:10b6:a03:395::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6360:EE_|BL1PR03MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: fe416c5d-484e-4b08-2ed8-08dacbabcef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rnbkGf486ctDaemLQOehJivg6yriyrtrll6TV8wRURi3pxnCLqz4yDd+uARn4d65Rkcm/so0lxHNrLybHIeaAvO0jJjwMm1ym5KgNxVOrdlTUZOwbV3LWQIZEiNOLf3pSlwJF0GLydgNx9IOH1BnCnbjtY2FVfWHOm6+3w1MFiL6ljwsSQcQLVsU06uRW8BLc9ixfKUz28MvWxxCyBFnQlIFi+y+5TQVc0mFuPwwarhhtQj38+l9JscUTZDcOLPv8sJ4/oayunvazhPhVkS0tlmazQs3gHWqk4opUg6UCc9Ap9DkDO1ofIa4TGqyOryf34Tke5XzvyPxdAJtgga93nt0clHpyULbX81Pkp2FHIawWNkAniwqO3+TSdLCk6u4eLKepm79kdJc6LITvuMMOCvwGwWT+zUXPj82pEU/Ae8eDv0UjZEzOK/GU8e+i+kMi/nqDdkutkqWfg5y5gAirrQVb+JRVcPagtrA2G9Kn59IS5l1W2qpRIWykW0T09wvzmqQ883PvBMMOIBscphoh/3m2k/tsiU95LMiLyLyA9pI59MtdRjosN0pKfS1Pppaeo0cd/8SxBafCJF5duJm8q44YqF/kOdRhbnFr9RYbFbRXfj3tnfe+Lh9zRSjCdDYpWtBTo74J9DooVYWIEn5Sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6360.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(451199015)(478600001)(6666004)(6506007)(6486002)(54906003)(38100700002)(66946007)(66476007)(26005)(316002)(8676002)(86362001)(6512007)(83380400001)(6916009)(66556008)(4326008)(82960400001)(7416002)(5660300002)(186003)(41300700001)(8936002)(2906002)(1076003)(36756003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anlBdnZnWkxyalJMbGtMbEFVSEJRR3lsWjRtRmxWdVY5TU5FRWNLdXJnemlx?=
 =?utf-8?B?c0wrQWZYRFU5U0R5S0VUR3BTOVJDWTNUTFVnd3BWYndrUFNWcUFOTnNLcjhp?=
 =?utf-8?B?eDFIQmM1UmFtVFpPVC9xa0JwZVdIaFdaYXVXZ0cxZWFVYjQ4QUd2YjY2NjMx?=
 =?utf-8?B?ZElPUUZaZjRnT1dKL0NKMzYzRE42T2E4ZUw3c2pTMXczUytyR1FVRGdDTFJR?=
 =?utf-8?B?Y0tub0FkcVplUUh3MmlqbGpRZHNSU01kVVE5aWtRTlQ3bEtlRXlSYmNDZytL?=
 =?utf-8?B?b0o2YWVPa2p1dUh1dFdzN0ZWTzZpNThuaFZRaTJUVldEc0JWeGhXRGl5LzFa?=
 =?utf-8?B?RmhQbCsxYXkvRm5oaVV6bzFlUWl0UTRyRmx5ZkFWbHhRNnZoT0hOUE5WN0pO?=
 =?utf-8?B?M2hKT3lwT0R0UUlnc0oydXUvbE1BeEJ2dXRpbi9GaEJRWCtwV2FMdFRhNHVK?=
 =?utf-8?B?dHd4YTVXL3d1K1l1Y3dwT1YrRUlEWmpuVitzcmhvYW9zWktBbnZRM1BwN2Iz?=
 =?utf-8?B?eHBQbU8ycTIwbzlnc3BqYTlaOFF5VGxLWGJicG9VT3hUdnRaR0x4dTFLNnE4?=
 =?utf-8?B?S0NWa29jeEZzREpvNURSc0NYL1JFSVBUN1Rjbi9SbFppR2h6Sm9hakZFMEw5?=
 =?utf-8?B?SUd6dVdwTmV2a29jbFBXa0Y1bHJ3ajkwR08vYTBsbUZWY0lHOGlLeloxMm1j?=
 =?utf-8?B?M2d1R2JCYW1DbmNueFlESzVOcHlFZUhNZkxGb0Iwb2swcWtwQkFhem1CcDh3?=
 =?utf-8?B?YkVqcHMwMUFmNVV2a0lzczNHZjArSmZZejJXRFNzeCtZNXRhb2dzbGx2aHY5?=
 =?utf-8?B?cFR4eVVaWFFNcSt0MThHOTNESEJOM0FhUVJkYTdyMmpTU21YS3RKM3VjTzJr?=
 =?utf-8?B?THdOcWlpZUxDNjFHS054V1RyREFibllCcHBFZGFNMUtLRHdMTkxqSTh4bUhI?=
 =?utf-8?B?MzdPUVhDd1ovdkwxMFNoMEJ5YTh4R1ZHRmEzUVRjdWpQUk9udWtpTFdyUCts?=
 =?utf-8?B?alFNeEJHdGVQVERrYUVpbEY3ellXd0RTa2ZydlhhblJlTHJEUkw5b0p0elI5?=
 =?utf-8?B?ZHorcDVzdE05UEU2VlVPcnIxSXI2ekNvd0R0UUFZbWtNa05naDJWMWRCNmFa?=
 =?utf-8?B?RUkrbXAwSGxXbklYamxvRTN2WjlBY3hkZkxXemRBcm45RkdmUDhOdDZDT2gr?=
 =?utf-8?B?bEh2MHNQWm9IUnVRN21yeFR2ZTFSdkFUUkJwUDRnWkFkRldncTkvaCtRUkp2?=
 =?utf-8?B?VWFqNGNGREtPSlBmdkt0OERZSVhLa2RxVzM2aEpmakdTdDQ0S2syRkhGamFu?=
 =?utf-8?B?Ym9FSXNoT2tZbFRER3c4dDUzaDIxN28wYm5BblQvcGlsMWUxQk1yTFJrUXBo?=
 =?utf-8?B?RzdWZyswS0lOeVVVQVJnczdhODBDRUl3Y3pZaFZVZ3J6L2w5aElvdUt0YTRu?=
 =?utf-8?B?TFNXZE1KdmI3cjJ3OGxvcVFMUmhrV0svbnhrMG9ScmtuS29QRjlWOThDQ2Yw?=
 =?utf-8?B?KzRJdWQ2M3JJb1dxZDN2anNDVldsOWhqdXpQRjloS3lIZTY0MCtMUGx0UHha?=
 =?utf-8?B?VmdWZitaaEs2RDliLzhUeFRISFQ2dEFqYWljYkgzTFFLblZrb2hhWlhtN2Vw?=
 =?utf-8?B?Smw0UHNYdFJzakd5NmhhL2s0cHNIWnlkNXVkS1BPcFpUSEJBbisyb2FuN2pv?=
 =?utf-8?B?MU9saG5DRkZPS3dCUksxU3ZHTHdaZm9Ib29FM01VK0RXY0M1NmFPUGNtRXRN?=
 =?utf-8?B?aTRlQm9HMVZndDJpdFB6cjNGaXlvMjhFNDBYajcvOEdhc0lUaWxWWFExYXhR?=
 =?utf-8?B?d0ZON1Nzb1dWWkVuRDF5aUMyT1p6OERROVF3RGRBM0wzYW5lb0szbkNuendh?=
 =?utf-8?B?bWRIamZ4Qy9INzVTMy9lTHRCS3hFK0trYnNRMk5UV3VCRjVrMFZ4dGFJZldB?=
 =?utf-8?B?bWhKMFkzRTZnT3VtTytEeUUwQmFHWklYS05VRW9VTTAxaldHZlBJdWc2SjVh?=
 =?utf-8?B?TElXSXVOUnRNL1dtN1lHUnhvclIvMWMybUZMd2ltZFI0QjRaNHlNQlRsL0pO?=
 =?utf-8?B?b0hkRWFzSlA3V1RlSHV2eGRXTDNOZHdJQk1NY0d3ZjlVbUhKZFVVYVo2WXVX?=
 =?utf-8?Q?OOoDgcQ3kVdj+b2f1SiaWy0Ej?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?OCt3U2hFRysvUnpVUDZqZjVxL0ZSZ25adlRzSkQvWlJJL1JoL2s0OEV2RWQ4?=
 =?utf-8?B?YWJmeG50RVVoclJ3MkNwdXdVaGp2M3Qrdk45QWZBL01sM0U3dHdZREJ0aExM?=
 =?utf-8?B?UWlqUFhtaEJ1NFVhRnRPUmdVTXdxMXUzK3NaTXc3emhCWW5BZlhKSFZBYXhv?=
 =?utf-8?B?bENyL3dXeHBYNXJDUWFoMzNTbGxGRzlJSmowczBqZzZCYzVDbVJHN2JLTStV?=
 =?utf-8?B?T2g0M0RUOXl2K0xlanUycXBsWThXckVPdGprWXFCVTd0ZWdMNUZxU01RMlEy?=
 =?utf-8?B?ZExrWXpHNWxOWlN6ZFRmRmJRSzBSa200ZTBFN2J3OGhub1BBMmEyNVZYVEJl?=
 =?utf-8?B?WHNYdlhuMTR5eUh0MjVoZVlmL25sbHgrVzJPQnJQK1JGZDV6UjAwNyttK05R?=
 =?utf-8?B?a0VkVUNIUXlST1BXcCsvNk1SZUhNWGhXTUZkZjdtN2J4ejdXUG1Xd1E0OU1N?=
 =?utf-8?B?WWd0MVhpZDJ5YlBndlZkT0dmNmhZVzI5d3Bpdkc5ZE00M0k3Wk5yVHJRZENj?=
 =?utf-8?B?M0xaVEI5ejA3NGxxVFhJaEtVREwvb2VGakFEU3JPcmdCVlFTVTdLSUNiZUYy?=
 =?utf-8?B?b1JsejJoT0h2NThMcEdyT2wzUlc5ZHVUOUowdkg1T0lPT3hlcit1b0xQTWRR?=
 =?utf-8?B?NDgrSUIvWG9aWlR4b2NjcHlRVE56T3hrQmZId0tBbWVTZDQ4bnFFMTVnbDZq?=
 =?utf-8?B?MFBOZUplSDRpa2szL3VzdGk1UDM3QXEzbEZabDM0SnVQN1F3WVFnVWFhOGRR?=
 =?utf-8?B?RFpCYTZVaStBUXBuK2VacFRxTlFvNUZRRDExbjNrMTRaeXRpd1QzcWtWcks4?=
 =?utf-8?B?VnlqVTdQbGF1SFpYVWdIOVlYeTlZc2orMGdKR29pQU54RDNiQndzWDZoWlYv?=
 =?utf-8?B?by9UOWpXbjlPbU1iREowVzcxWnp5WlpjSXcvWHhqYytBM0Z4dEJEaURXWlU1?=
 =?utf-8?B?OTd5dC94MG4xaUI0d2szWWZabmxlR1F2ZzQzdDdrclBSMWZuL2NJQ0N6b0ZB?=
 =?utf-8?B?eENva0VxVFg3WndydGlYK04xdDZpRVRZK25iWkpQMG9qbDNVQnNXOFlrSTBQ?=
 =?utf-8?B?TmxSS2F2bVVWZHJlQ01mTUtGdFAxUnR1SFhxaElqVDNZKzQ2bkRLcmVTRDNx?=
 =?utf-8?B?YXE1bDhsNGZyM3EzeVBqREtiUFZwaVQxZWNocTNIeDQ3d3lLU0cxeCs0NXlj?=
 =?utf-8?B?N3h3ZTJTTGR6R0VMUkloNGx2VXFVWWxQai90VkxLQkR1VWI1aEpsSTdLS3Mx?=
 =?utf-8?B?UTFWQVU5T0RPSGVPUG1VTVFDekhtMGMxQ3BJL2dlbEtQYlMxWUlTWitrQ1VX?=
 =?utf-8?B?dHRxWUhWRWdsV1JFcFZPVUtobFRRbUtsell0V3ZrNGhzMENaQm5JbkdYZzZO?=
 =?utf-8?B?a0gvTjZGRGpPVWd0K2xTRUgzaDRIMmdkcWNvS0hldlR0NENLekVRUmpaeWdl?=
 =?utf-8?B?VUpYYmpXN0VsT3BRc2VqaU8vN1p2eGs1TnNnbUVmbW5SRlVjeVlFYU9VR1Jq?=
 =?utf-8?B?K2ZobEpmamxINHprQjFtekZtaTlLM1lMWEhLYkYwZ1VkTk9iejBMaWxiUFdJ?=
 =?utf-8?B?WTBaYUVGWDUyYkZTaE9VblhXUi92UHJWN01pektYZDJyTlhRZ2JuZDAwSFhO?=
 =?utf-8?B?QVh4K3dVTHRsWmh3SklqUytWOG5GVVE9PQ==?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe416c5d-484e-4b08-2ed8-08dacbabcef7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6360.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 10:33:20.7252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZiemV/SDoG9Ln0GCEvmTh/MKvi7TdyjpgEzrjy7YSpSf4s5gYtxgOLxo2nztL/rkYGuKuVGXmY4oSrqIuXXNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR03MB6102
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running as a Xen dom0 the number of CPUs available to Linux can
be different from the number of CPUs present on the system, but in
order to properly fetch processor performance related data _PDC must
be executed on all the physical CPUs online on the system.

The current checks in processor_physically_present() result in some
processor objects not getting their _PDC methods evaluated when Linux
is running as Xen dom0.  Fix this by introducing a custom function to
use when running as Xen dom0 in order to check whether a processor
object matches a CPU that's online.

Fixes: 5d554a7bb064 ('ACPI: processor: add internal processor_physically_present()')
Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
---
 arch/x86/include/asm/xen/hypervisor.h | 10 ++++++++++
 arch/x86/xen/enlighten.c              | 27 +++++++++++++++++++++++++++
 drivers/acpi/processor_pdc.c          | 11 +++++++++++
 3 files changed, 48 insertions(+)

diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
index 16f548a661cf..b9f512138043 100644
--- a/arch/x86/include/asm/xen/hypervisor.h
+++ b/arch/x86/include/asm/xen/hypervisor.h
@@ -61,4 +61,14 @@ void __init xen_pvh_init(struct boot_params *boot_params);
 void __init mem_map_via_hcall(struct boot_params *boot_params_p);
 #endif
 
+#ifdef CONFIG_XEN_DOM0
+bool __init xen_processor_present(uint32_t acpi_id);
+#else
+static inline bool xen_processor_present(uint32_t acpi_id)
+{
+	BUG();
+	return false;
+}
+#endif
+
 #endif /* _ASM_X86_XEN_HYPERVISOR_H */
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index b8db2148c07d..d4c44361a26c 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -346,3 +346,30 @@ void xen_arch_unregister_cpu(int num)
 }
 EXPORT_SYMBOL(xen_arch_unregister_cpu);
 #endif
+
+#ifdef CONFIG_XEN_DOM0
+bool __init xen_processor_present(uint32_t acpi_id)
+{
+	unsigned int i, maxid;
+	struct xen_platform_op op = {
+		.cmd = XENPF_get_cpuinfo,
+		.interface_version = XENPF_INTERFACE_VERSION,
+	};
+	int ret = HYPERVISOR_platform_op(&op);
+
+	if (ret)
+		return false;
+
+	maxid = op.u.pcpu_info.max_present;
+	for (i = 0; i <= maxid; i++) {
+		op.u.pcpu_info.xen_cpuid = i;
+		ret = HYPERVISOR_platform_op(&op);
+		if (ret)
+			continue;
+		if (op.u.pcpu_info.acpi_id == acpi_id)
+			return op.u.pcpu_info.flags & XEN_PCPU_FLAGS_ONLINE;
+	}
+
+	return false;
+}
+#endif
diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
index 8c3f82c9fff3..18fb04523f93 100644
--- a/drivers/acpi/processor_pdc.c
+++ b/drivers/acpi/processor_pdc.c
@@ -14,6 +14,8 @@
 #include <linux/acpi.h>
 #include <acpi/processor.h>
 
+#include <xen/xen.h>
+
 #include "internal.h"
 
 static bool __init processor_physically_present(acpi_handle handle)
@@ -47,6 +49,15 @@ static bool __init processor_physically_present(acpi_handle handle)
 		return false;
 	}
 
+	if (xen_initial_domain())
+		/*
+		 * When running as a Xen dom0 the number of processors Linux
+		 * sees can be different from the real number of processors on
+		 * the system, and we still need to execute _PDC for all of
+		 * them.
+		 */
+		return xen_processor_present(acpi_id);
+
 	type = (acpi_type == ACPI_TYPE_DEVICE) ? 1 : 0;
 	cpuid = acpi_get_cpuid(handle, type, acpi_id);
 
-- 
2.37.3

