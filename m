Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F140E6BCC02
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCPKHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjCPKHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:07:00 -0400
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A7D59808
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 03:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1678961209;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=xPOSWM9uBris1Lv760ndKfYv/SsqyjSbzUtuVhe/l/A=;
  b=I6CEC5Di8rtWTohOjnkst8EcoNtWUI1fdyxxO+c6caF73/374qEbD4mL
   W16KtGNWjt9UKwS6wZCa8Gj6XdCT24BeQtgVcxLRmkp/y8hxeYzE3KN4s
   2TSZVIufuCAB62SaMXxF/aBk6Ii7uwR3SvAJAYE0mG1mEOKZN/sqfCL2b
   k=;
X-IronPort-RemoteIP: 104.47.55.175
X-IronPort-MID: 101501202
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:1XcnSq8NphhCvbKWZw8bDrUDQH+TJUtcMsCJ2f8bNWPcYEJGY0x3z
 WIaDTzVaP+IZzanLd4natvjpxgE7MLVzINlTwRt/yE8E34SpcT7XtnIdU2Y0wF+jCHgZBk+s
 5hBMImowOQcFCK0SsKFa+C5xZVE/fjUAOG6UKicYXoZqTZMEE8JkQhkl/MynrlmiN24BxLlk
 d7pqojUNUTNNwRcawr40Ire7kI/1BjOkGlA5AdmPqkV5AG2e0Q9V/rzG4ngdxMUfaEMdgKKb
 76r5K20+Grf4yAsBruN+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+v9T2M4nQVVWk120c+VZk
 72hg3ASpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn9IBDJyCAWlvVbD09NqbDklI/
 94AeCwLUSq9gt+5y5KFcNdguYc8eZyD0IM34hmMzBn/JNN/G9XpZfWP4tVVmjAtmspJAPDSI
 dIDbiZiZwjBZBsJPUoLDJU5n6GjgXyXnz9w8QrJ4/ZopTWOilUujdABM/KMEjCObd9SkUuC4
 HrP4kzyAw0ANczZwj2Amp6prraXxH6jAdhKTtVU8NZH2Ue+6XRUDyRMUGWjg9e3sxaTXtNAf
 hl8Fi0G6PJaGFaQZtv6RBC2iHmIswQYUtxcVfY3gCmJy6zJ80OaC3ICQzppdtMrrok1SCYs2
 1vPmMnmbRR/vbvQRX+D+7O8qTKpJTNTPWIEfTUDTwYO/5/kuo5bpgKfEP5gHbSzg9mzHiv/q
 w1mtwA7jrQXyMQNh6Oy+Amdhyr2/8eUCAko+g/QQ2SpqBtjY5KobJCp7l6d6utcKIGeTR+Ku
 31sd9Wi0d3ixKqlzESlKNjh1pnzjxpZGFUwWWJSIqQ=
IronPort-HdrOrdr: A9a23:A77j0KlUY9dSNKIwDfw6m6TYRF/pDfI93DAbv31ZSRFFG/Fw9v
 rCoB1/73SftN9/YgBCpTn+AtjjfZqxz/BICOoqUYtKPjOHhILAFugL0WKI+VLd8kPFl9K13J
 0QFpRDNA==
X-IronPort-AV: E=Sophos;i="5.98,265,1673931600"; 
   d="scan'208";a="101501202"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Mar 2023 06:06:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBrj+5VX3IDjCXUAeUY1BRo9j+cL2X9Z+RWc10tVk82qqNKKYM3YEi6ekPS48z2UcJyDCZwkyVBsTdwwnxwTCXsqLQVcUAhH8MUsN3cLRvWelbnxOEGrObgXcfhOfCd6BcdhjlUd7Sn1XNsok04PQm0iYTAYlfwucYpbYtOaMBiCc+1hUW8lid3t49GMhAKikBBQyUnDlMASiLlePUg4UiwBJl8IJUhLBrXX6UqmJFTNXNC9EqmgzLkXZO2U9XHacfb4oeLep3QA2RF/KVQFGrlfhgVXfg+MuXgjaAilCbwN7LRxxOBJBdmh1VwoaU23Uj0sxG0kD+bsbYrQfBUT3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x99VX79samaRS0BqFe2rbZd0M6NI81izBgME213FgG0=;
 b=FFOirRrEU5GNdkOcfvDP3gPUCfeL+6/s1alfH1uQ+Xb8ka/Wzg9W/3DMOM/9LV57bmzalS5Lzhcw+SdIExT/nsGHmZ+56cVt+QBp/FWP6mXeSzpp/4VPXooualSlo5g38+pJnLILYtuAgTIgP1libaqM0sbORduXBBSzcz7ZdlmbWl10MBWU5Jz290yJ+uB/NlMRSJsO7UQfzLbBdro8DvIKLId6nyklM7+ABs++AYHDCOBigu/iJSPBYB1kO5YIUIlwRvI0IMg7QLKJCkQG+sik49XWTUAmAMRGR8T3hU+fJcfgq7+l+kv9eLcgW5HrLGPADw0a4/UclFHV8gLXEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x99VX79samaRS0BqFe2rbZd0M6NI81izBgME213FgG0=;
 b=mDcPfdcze1BctPa6nwG4MfZvUqZ8Cfcvy36ky+X8SLxmoDDDi/JrE/xbIOyUYM9B2q8wDtYMWcqbWNS42cBb18edAEmNFmEiuVESQQf39JrdHDYb9AuFCHU6kWSxJy2LSpjfFOceWxnLyv9ESDXvgYuBui6OwXyA1DQC1zs5FUg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com (2603:10b6:a03:395::11)
 by SJ0PR03MB5421.namprd03.prod.outlook.com (2603:10b6:a03:289::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Thu, 16 Mar
 2023 10:06:40 +0000
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::48a7:d1ab:897:acda]) by SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::48a7:d1ab:897:acda%6]) with mapi id 15.20.6178.031; Thu, 16 Mar 2023
 10:06:40 +0000
Date:   Thu, 16 Mar 2023 11:06:33 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Josef Johansson <josef@oderland.se>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Subject: Re: [PATCH 3/3] xen/acpi: upload power and performance related data
 from a PVH dom0
Message-ID: <ZBLqKWqkGawbbRo0@Air-de-Roger>
References: <20221121102113.41893-1-roger.pau@citrix.com>
 <20221121102113.41893-4-roger.pau@citrix.com>
 <407b7c10-ad1f-b6d2-2976-2b297755b2b3@oderland.se>
 <ZBGuVjyDpuUZ3MnZ@Air-de-Roger>
 <2754848f-6c3c-5479-ea6f-1946c93f868e@oderland.se>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2754848f-6c3c-5479-ea6f-1946c93f868e@oderland.se>
X-ClientProxiedBy: LO4P123CA0548.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::11) To SJ0PR03MB6360.namprd03.prod.outlook.com
 (2603:10b6:a03:395::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6360:EE_|SJ0PR03MB5421:EE_
X-MS-Office365-Filtering-Correlation-Id: f8e74b66-8430-4c77-627f-08db260622a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: maTGKo3NTcH5xgNl/paEI+I3Z5mQpDJ9pEAYrXAXtE7miUdfZRHz/ncDct3+vJj8564A5++8fl7GVwfZwR6XCXd3Olm5IpfKIHt5QamZicgyt6xeNN6OV2n2dtzAdiHKRIwtU8sb/LIfzCDwjSD5B14TUzoTiHxPNAreX7CwRYvnQxi5WDWHmq73RxoFWUIvzfKgUA4y5tH4NeRzedaeLd90301I7oV4RYWPfeQHmIhuu6s1HIHuLJiPjIWF6NDHGlqlawJqx7o5Gs/Lp87a+Z+QxgM3FQcxeWXv684NKGK7w5IkrmEm0aI2d937d4bTlkDIDcvdhPQuP2piMh+N76kCBTefCl9DtywRMpBUxzECm8yn3fEnMtfaEGCeoV2D6vnZm3ENgk5B30hrUjXOn3udDg9RNQCeYt9Avagciy18TiUD+NA0Y/h90B9KMkqyJEJ6O30LE09uqWEIGa49RO9lg5QHa8J+W7hj7wrXxpvTEAzSZGqhiBjC+/WjM04/8XH5nR0O9fxdtHeoo9x2QUgo5UfpyARLrU4RMoopYtGOxrmTW24pPu2Ib9MKfR+88IUHX4useyOiNu5s8vNVy4gPiVJ+OAASuOeDidl01t8X8qvTgTNqN50NcRb2Bvb14OcWR9nkSKs5JiULsZAqRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6360.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(376002)(346002)(39860400002)(396003)(366004)(136003)(451199018)(85182001)(316002)(86362001)(478600001)(6486002)(66556008)(66476007)(6916009)(2906002)(8676002)(8936002)(66946007)(41300700001)(4326008)(30864003)(5660300002)(82960400001)(38100700002)(9686003)(186003)(6512007)(6506007)(26005)(53546011)(83380400001)(33716001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3lXTDc3VTVzU0RDM2daRGRXZU1zMXJ0azFXZU8xUERjMjNURFl1SVdzMTZQ?=
 =?utf-8?B?WENST2NxdklnQVlOVUNReWpIMVh5all2MndJR2dQMzk3dVFxUDVnL0x1ZEw0?=
 =?utf-8?B?bXVoa2RBMEJlWWdzUUJzU3pxWjQ2ZUczWEY4UWtEeHp6elVzd3Q4Mkl0Tngy?=
 =?utf-8?B?bGVwQzhtTXZnRDBRU29BTElzSHBHeGpYVzFQMWo4cmRDOXQwazVIVjE3ejFM?=
 =?utf-8?B?WElBclZVQUZVVGNNOUNjOVdRSlZJWkNUZkM5VHVua1hmRmpaaGtmYjgrWVZJ?=
 =?utf-8?B?RHNNWWphbytaK0tyNUZCeWpQcXhsV3MwNnlFNkdHRXh5T0VKOTlwQ0kxd25G?=
 =?utf-8?B?QlRGdXRpZzdJV0s2VUU3ZmV3ODJwNEoxU3ZLb0hodGd4MXRMZEpQa1Z2NUhl?=
 =?utf-8?B?eFhSS0FiWVFyT1RReEsyYlJuSVdyeXlhSGdkSHMvQU5hbWN1RTlJRUtDRFQx?=
 =?utf-8?B?bE9zb0hrSUZnR3FCM29sL1JKemFOUkxlQm9CUzl4bHdCTXV6YXpESW9OdlVQ?=
 =?utf-8?B?MmJNZm52U1ZlQmFVVnl2TERsVUFhQ0dvNzdpTFh3ZDZrMGNpYWtwQlFZQmsr?=
 =?utf-8?B?elEzS2d4SmlSaCt4d3ZHM3lpSkRaRTJQRzdNalAraVV2cVk1engyMGkxQ2g1?=
 =?utf-8?B?a1p2dEkwWHVRbFZxVUhZbEVndmxOMld1bHVwQ2lwVHhuME1OZVBGN1JqRUZQ?=
 =?utf-8?B?Vm52MTBMV2V1UDN0K1hvRDFrV2MzQS9tclBiRHM4aWdzQmc1eEF6UXRpSW1N?=
 =?utf-8?B?a2c3eGlGMXFLOU53RTVjVjVTRzZOZlRnQXdCL1RncnZpOTZHWlVudDdCcFg2?=
 =?utf-8?B?OHFTeTVuL3VWNmMvRTFPWndhbThKc1U4b2VyWkVJRE90T01xS2x2N2YvZGVJ?=
 =?utf-8?B?a1p5YTIwellteHAzMVdtNncwazFQWXdDU1NDd0N6UWFlNmR4amRlM1ZXM3Nv?=
 =?utf-8?B?QVlxc2NLcjgxYnlGdzN0OUVJRnoxY2pyTnFzVWxhZDNhc0dDQXo2emNTOHlD?=
 =?utf-8?B?NUlhZ21VajBEVDhNMkEvclNzSUIxSmZHc2d2Mkx0QzFlOW1HMHY1cFduMFds?=
 =?utf-8?B?b3dVVXVWcmdTZkFIajN0MDZEUXNOVSttNVVCN1JMM0d1Z0dtbUp0VzJUUEtJ?=
 =?utf-8?B?Z0xDSGdmd3RkTUtPWnhIUHBkVndVRWdQeWdJZUYySTBnWFBBd0NRMWlxbEpk?=
 =?utf-8?B?OGlTME5qL21nUlFGbzYraWtpV2x4Q0xBYWtvMXd4MWhucXZVTi92bmEzV0l4?=
 =?utf-8?B?SzVmTmVma0hXZFF1LzFuK2t0WG93bUhzbXNwRWkwaWNsSFoveFVSQjg5US94?=
 =?utf-8?B?ZmlPbGh3SytBMVRVM201WUtWb1N6cWRhcUZUdFdiRDY5WVorOVRKZHZheVBa?=
 =?utf-8?B?c3lBK0J6clRZc1BLbkw4V01vdDVJL1dYcDU4ekZvR3JZN0piTDU0ZWpFRWRx?=
 =?utf-8?B?bzV5Ny9LZUNMMWNRZjI5SEhoYUtYenNpRVFBbHJPdlBscTJ1c3lNWkRjdHlF?=
 =?utf-8?B?NHRhRTRIdDhPME9id2FJSVVueWZCY1RMZm1SUzlZcmpjV0RGclRJckNXTXVZ?=
 =?utf-8?B?ZFV3R1JxNzUyOUFyYTRxTjEzc1prM0R3Q2JSRlEzU2NzTDBWdFd5TDdsejNl?=
 =?utf-8?B?eExQaFl5NmFEZzNqVlE2ZWo4dFNDQ0JFK3IvM0x4YnBsazhaNFhaaWd2YVVr?=
 =?utf-8?B?YmpIbVdvcDhraWJDMFdNSHIwb0VBNnVHRm5rNUpCR1gyQW1DYVM0Zlk3Nm9W?=
 =?utf-8?B?NWsrOEloanRFWG1ydmtNbGgwSWVVZzM3NmRib2VmcmFJeXozU2ZSd2t2MFNX?=
 =?utf-8?B?MlR5N3hjaXlxQ3g2S01Cem9KUG1ZSlFKQ0dLekk0NGE4YjZVN3AxeHdvS05M?=
 =?utf-8?B?R2d6U09MTmlmUFF0U2NxSDNlSTRnem5yWDZIYVZjSDBWYkxWT1diQldZOEpx?=
 =?utf-8?B?Qm53aDRuMSt5K04wUWsxZlJYRFpGS3QzWVlnRG1ZTGZkZGF6RzhudXMrYzVH?=
 =?utf-8?B?elNKOUdTLyt1aGc2Y2wxbHpIU2lXMHRCM0tORWVEcmwyUW52VGN2R1RGdDM2?=
 =?utf-8?B?eWoxL2hVdkRwUkIrQVRVczVpZEkxTmMyTVdVc0laVXVheGZkOGFnZDFGTFVn?=
 =?utf-8?B?ZmNOS3ZncXdvMDJBaDlYYTl5RHdHSTVBM0dBTTRHaTZTMjErTzdhY1UyVnJw?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XSMHv2SwfHHc0e3oynkIR/iusLXYCbFRv0LZQfLBTI5sLWszJKzrs3ln4lK0r3qqJKJHXwvXbtW+iy2wD8GLdFL/S8U2D02ErsC6hTgYYooH4ShT5lw1+LCEObxIimihwf93dIBLOZvYOxMmq7S9x0B4YKcUQnqxR3sojn5a9FcbYsW3Wo4WTYt3sioJU4ITBqMoSIapkL39xmvXmTAqcCb67niMCSj3yKyeYYPA1dlmfGI5w9gUPpk9kpFm33MHJlUNzoE+bGudaI/OPW+CgwM9F1A/mWmjX5iAL6HEhm0xQPJL3aKA3yPrkv502p7aKSnP6sxngPRKfriObDlJE8HOeQLfwl/JY4VQbW1knKi+gXS5xlRnFsuXv/HJPO+282iyF+vblv1eUx64TMUrF+IcP+ALNopk/vAujN3v3Pmi3Cqo9SS8Djawfyr3gJmbAKe242MZtdVOEmELM8yLQk24b5/yK/CxO48zsxhMLbaqKycRT4L9YOowFj/bJCSH3dPsRrhOJ6dIjORIcwbUWeqxVGTGGEpQ/a8ruWVXBDgD0JVUR0ZLjfRgpvJmHU/Ath6h230hmahx7BHMlyo+c59j6iPHx1ScvsUv3gaq3BgYiwRZkPZwrTF9sZYGgBTYt+kJRghphjZDvd5ActXpK0FXipEOcN4ECB2W1F6LaH5qk6rDZM+GVksnGFLEJew87dwtcBhiSIgCbD/qVHCez8wQXimptrzpFJfpIO2MEOZS41zAtfxKk4Dgyd5Yc6YVILx7Sfc3y5qn85HEj0+jdhdIS5LZA3IGTr0x/E5GUDV1tQiAJhxjUH1zJpkuu7lEWsocaRZ/flvp3J/Y/qOJzyE5rWVTL6Jfr4wS0bVbzzE/1JqdzFU1sx60+k1bcpF1
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e74b66-8430-4c77-627f-08db260622a9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6360.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 10:06:40.0929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LnFNPynkwdTTMqfIf+UU3CSQv1J4SRbPjxJtcdPf1hPFlT62oCHn5HZ3tPwXensZc72Gbh7Ah85srKAj8ciePg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5421
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 08:54:57AM +0100, Josef Johansson wrote:
> On 3/15/23 12:39, Roger Pau Monné wrote:
> > On Mon, Jan 30, 2023 at 10:10:05AM +0100, Josef Johansson wrote:
> > > On 11/21/22 11:21, Roger Pau Monne wrote:
> > > > When running as a PVH dom0 the ACPI MADT is crafted by Xen in order to
> > > > report the correct numbers of vCPUs that dom0 has, so the host MADT is
> > > > not provided to dom0.  This creates issues when parsing the power and
> > > > performance related data from ACPI dynamic tables, as the ACPI
> > > > Processor UIDs found on the dynamic code are likely to not match the
> > > > ones crafted by Xen in the dom0 MADT.
> > > > 
> > > > Xen would rely on Linux having filled at least the power and
> > > > performance related data of the vCPUs on the system, and would clone
> > > > that information in order to setup the remaining pCPUs on the system
> > > > if dom0 vCPUs < pCPUs.  However when running as PVH dom0 it's likely
> > > > that none of dom0 CPUs will have the power and performance data
> > > > filled, and hence the Xen ACPI Processor driver needs to fetch that
> > > > information by itself.
> > > > 
> > > > In order to do so correctly, introduce a new helper to fetch the _CST
> > > > data without taking into account the system capabilities from the
> > > > CPUID output, as the capabilities reported to dom0 in CPUID might be
> > > > different from the ones on the host.
> > > > 
> > > > 
> > > Hi Roger,
> > > 
> > > First of all, thanks for doing the grunt work here to clear up the ACPI
> > > situation.
> > > 
> > > A bit of background, I'm trying to get an AMD APU (CPUID 0x17 (23)) to work
> > > properly
> > > under Xen. It works fine otherwise but something is amiss under Xen.
> > Hello,
> > 
> > Sorry for the delay, I've been on paternity leave and just caching up
> > on emails.
> Hi Roger,
> 
> Congratulations! I hope you had time to really connect. It's the most
> important thing we can do here in life.
> 
> I came into this to understand each and every error in my boot-log, it turns
> out that the latest
> kernel+xen+firmware fixes suspend/resume for me, thus is this not related.
> But as I pointed out,
> the output does not make any sense (nor yours nor the upstream). I should
> check the debug
> output with suspend working fine now to see if there are any changes, that
> would be quite
> interesting.
> 
> Also, I should mention that your patch broke some things on my system and
> made it
> unstable. I don't remember exactly and I know you said that this is more of
> a PoC. Just a
> heads up.

Right, I don't plan to send the PVH part just now, and instead I'm
focusing in the first patch that should fix _PDC evaluation for PV
dom0.  I will Cc you on the last version so you can give it a try and
assert is not regressing stuff for you.

> > > Just to make sure that the patch is working as intended, what I found when
> > > trying it out
> > > is that the first 8 CPUs have C-States, but 0, 2, 4, 6, 8, 10, 12, 14 have
> > > P-States, out of
> > > 16 CPUs. Xen tells Linux that there are 8 CPUs since it's running with
> > > nosmt.
> > > 
> > > Regards
> > > - Josef
> > > 
> > > xen_acpi_processor: Max ACPI ID: 30
> > > xen_acpi_processor: Uploading Xen processor PM info
> > > xen_acpi_processor: ACPI CPU0 - C-states uploaded.
> > > xen_acpi_processor:      C1: ACPI HLT 1 uS
> > > xen_acpi_processor:      C2: ACPI IOPORT 0x414 18 uS
> > > xen_acpi_processor:      C3: ACPI IOPORT 0x415 350 uS
> > > xen_acpi_processor: ACPI CPU0 - P-states uploaded.
> > > xen_acpi_processor:      *P0: 1700 MHz, 2071 mW, 0 uS
> > > xen_acpi_processor:       P1: 1600 MHz, 1520 mW, 0 uS
> > > xen_acpi_processor:       P2: 1400 MHz, 1277 mW, 0 uS
> > > xen_acpi_processor: ACPI CPU1 - C-states uploaded.
> > > xen_acpi_processor:      C1: ACPI HLT 1 uS
> > > xen_acpi_processor:      C2: ACPI IOPORT 0x414 18 uS
> > > xen_acpi_processor:      C3: ACPI IOPORT 0x415 350 uS
> > > xen_acpi_processor: ACPI CPU2 - C-states uploaded.
> > > xen_acpi_processor:      C1: ACPI HLT 1 uS
> > > xen_acpi_processor:      C2: ACPI IOPORT 0x414 18 uS
> > > xen_acpi_processor:      C3: ACPI IOPORT 0x415 350 uS
> > > xen_acpi_processor: ACPI CPU2 - P-states uploaded.
> > > xen_acpi_processor:      *P0: 1700 MHz, 2071 mW, 0 uS
> > > xen_acpi_processor:       P1: 1600 MHz, 1520 mW, 0 uS
> > > xen_acpi_processor:       P2: 1400 MHz, 1277 mW, 0 uS
> > > xen_acpi_processor: ACPI CPU3 - C-states uploaded.
> > > xen_acpi_processor:      C1: ACPI HLT 1 uS
> > > xen_acpi_processor:      C2: ACPI IOPORT 0x414 18 uS
> > > xen_acpi_processor:      C3: ACPI IOPORT 0x415 350 uS
> > > xen_acpi_processor: ACPI CPU4 - C-states uploaded.
> > > xen_acpi_processor:      C1: ACPI HLT 1 uS
> > > xen_acpi_processor:      C2: ACPI IOPORT 0x414 18 uS
> > > xen_acpi_processor:      C3: ACPI IOPORT 0x415 350 uS
> > > xen_acpi_processor: ACPI CPU4 - P-states uploaded.
> > > xen_acpi_processor:      *P0: 1700 MHz, 2071 mW, 0 uS
> > > xen_acpi_processor:       P1: 1600 MHz, 1520 mW, 0 uS
> > > xen_acpi_processor:       P2: 1400 MHz, 1277 mW, 0 uS
> > > xen_acpi_processor: ACPI CPU5 - C-states uploaded.
> > > xen_acpi_processor:      C1: ACPI HLT 1 uS
> > > xen_acpi_processor:      C2: ACPI IOPORT 0x414 18 uS
> > > xen_acpi_processor:      C3: ACPI IOPORT 0x415 350 uS
> > > xen_acpi_processor: ACPI CPU6 - C-states uploaded.
> > > xen_acpi_processor:      C1: ACPI HLT 1 uS
> > > xen_acpi_processor:      C2: ACPI IOPORT 0x414 18 uS
> > > xen_acpi_processor:      C3: ACPI IOPORT 0x415 350 uS
> > > xen_acpi_processor: ACPI CPU6 - P-states uploaded.
> > > xen_acpi_processor:      *P0: 1700 MHz, 2071 mW, 0 uS
> > > xen_acpi_processor:       P1: 1600 MHz, 1520 mW, 0 uS
> > > xen_acpi_processor:       P2: 1400 MHz, 1277 mW, 0 uS
> > > xen_acpi_processor: ACPI CPU7 - C-states uploaded.
> > > xen_acpi_processor:      C1: ACPI HLT 1 uS
> > > xen_acpi_processor:      C2: ACPI IOPORT 0x414 18 uS
> > > xen_acpi_processor:      C3: ACPI IOPORT 0x415 350 uS
> > > xen_acpi_processor: ACPI CPU0 w/ PBLK:0x0
> > > xen_acpi_processor: ACPI CPU0 w/ PST:coord_type = 254 domain = 0
> > > xen_acpi_processor: CPU with ACPI ID 1 is unavailable
> > Hm, that's weird, do you think you could check why it reports the CPU
> > is unavailable?
> If you would give me a hint at how I could check?

It likely requires you to add printk statements to the kernel in order
to figure out which conditional fails when running as a PVH dom0.

> Right now my guess is that C state and P state is not in sync, thus P state
> are for every other
> CPU and C state is for the first 8. AFAIK AMD only have performance-cores
> (unlike Intel).

Linux thinking the CPU is not online is more likely to be due to the
ACPI ID differences when running as a PVH dom0.  Anyway, I will try to
revisit this and figure out what's wrong.

> > 
> > Overall I don't like the situation of the ACPI handling when running
> > as dom0. It's fragile to rely on the data for dom0 CPUs to be
> > filled by the system (by adding some band aids here and there so that
> > the PV vCPUs are matched against the MADT objects) and then cloning
> > the data for any physical CPU exceeding the number of dom0 virtual
> > CPUs.
> That's my understanding from earlier implementation as well, nobody actually
> like it,
> But the current solution is something working in a bad environment.
> > 
> > IMO it would be much better to just do the handling of ACPI processor
> > objects in a Xen specific driver (preventing the native driver from
> > attaching) in order to fetch the data and upload it to Xen.  This is
> > what I've attempted to do on FreeBSD, and resulted in a cleaner
> > implementation:
> > 
> > <link>
> > 
> > I however don't have time to do this right now for Linux.
> 
> Maybe I can take a stab, I very much like the climate of the kernel but
> everything
> seem so scary :) I've been trying to understand things better, how they're
> all
> connected.
> > 
> > > xen_acpi_processor: ACPI CPU2 w/ PBLK:0x0
> > > xen_acpi_processor: ACPI CPU2 w/ PST:coord_type = 254 domain = 1
> > > xen_acpi_processor: CPU with ACPI ID 3 is unavailable
> > > xen_acpi_processor: ACPI CPU4 w/ PBLK:0x0
> > > xen_acpi_processor: ACPI CPU4 w/ PST:coord_type = 254 domain = 2
> > > xen_acpi_processor: CPU with ACPI ID 5 is unavailable
> > > xen_acpi_processor: ACPI CPU6 w/ PBLK:0x0
> > > xen_acpi_processor: ACPI CPU6 w/ PST:coord_type = 254 domain = 3
> > > xen_acpi_processor: CPU with ACPI ID 7 is unavailable
> > > xen_acpi_processor: ACPI CPU8 w/ PBLK:0x0
> > > xen_acpi_processor: ACPI CPU8 w/ PST:coord_type = 254 domain = 4
> > > xen_acpi_processor: CPU with ACPI ID 9 is unavailable
> > > xen_acpi_processor: ACPI CPU10 w/ PBLK:0x0
> > > xen_acpi_processor: ACPI CPU10 w/ PST:coord_type = 254 domain = 5
> > > xen_acpi_processor: CPU with ACPI ID 11 is unavailable
> > > xen_acpi_processor: ACPI CPU12 w/ PBLK:0x0
> > > xen_acpi_processor: ACPI CPU12 w/ PST:coord_type = 254 domain = 6
> > > xen_acpi_processor: CPU with ACPI ID 13 is unavailable
> > > xen_acpi_processor: ACPI CPU14 w/ PBLK:0x0
> > > xen_acpi_processor: ACPI CPU14 w/ PST:coord_type = 254 domain = 7
> > > xen_acpi_processor: CPU with ACPI ID 15 is unavailable
> > > xen_acpi_processor: ACPI CPU8 - P-states uploaded.
> > > xen_acpi_processor:      *P0: 1700 MHz, 2071 mW, 0 uS
> > > xen_acpi_processor:       P1: 1600 MHz, 1520 mW, 0 uS
> > > xen_acpi_processor:       P2: 1400 MHz, 1277 mW, 0 uS
> > > xen_acpi_processor: ACPI CPU10 - P-states uploaded.
> > > xen_acpi_processor:      *P0: 1700 MHz, 2071 mW, 0 uS
> > > xen_acpi_processor:       P1: 1600 MHz, 1520 mW, 0 uS
> > > xen_acpi_processor:       P2: 1400 MHz, 1277 mW, 0 uS
> > > xen_acpi_processor: ACPI CPU12 - P-states uploaded.
> > > xen_acpi_processor:      *P0: 1700 MHz, 2071 mW, 0 uS
> > > xen_acpi_processor:       P1: 1600 MHz, 1520 mW, 0 uS
> > > xen_acpi_processor:       P2: 1400 MHz, 1277 mW, 0 uS
> > > xen_acpi_processor: ACPI CPU14 - P-states uploaded.
> > > xen_acpi_processor:      *P0: 1700 MHz, 2071 mW, 0 uS
> > > xen_acpi_processor:       P1: 1600 MHz, 1520 mW, 0 uS
> > > xen_acpi_processor:       P2: 1400 MHz, 1277 mW, 0 uS
> > > 
> > > As a bonus, here are the previous debug output on the same machine.
> > I think the output below is with dom0 running as plain PV rather than
> > PVH?
> This is the upstream ACPI implementation vs yours. What would plain PV vs
> PVH be in dom0?

But that's always with Linux running as a dom0, or just running bare
metal?

Thanks, Roger.
