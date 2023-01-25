Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12ED967AAEC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 08:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbjAYHa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 02:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234859AbjAYHay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 02:30:54 -0500
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8371E2A4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 23:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1674631854; x=1706167854;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S8hnSLYOZecQkiI56lVN4hzFQcZvr4AOVHDIGkx8cyw=;
  b=oYml8rl5KcwXaB9YgAA0/gk+H8zlDiDrPClECNMIyDz7AiKyaQkXJmMG
   qHxMOJhfpapWEkHMV9wY9JVPk8n3oAfiUCTIu8M6OC+T5l5X4S/wnIzZe
   o9HxtY723JBi8MCRWhxrt6EJosXW3hnpP26vRXkJ793mEeHtmfhLRcmHS
   mrVlw15/s7gou6lU2Crqm3H7QR+tGlL2/n+//zeISG+yLq2DgRe6KEG3a
   LA4TvQA6o0NAmVgs7COlOKXGojnUcNCtUJf81QyFUuoZUDdKwdxKXA2H7
   MHyIdap5HHIHTTLHFt+xOo2BTC1b5wG+CvXMHhJEUHX8ic43qFiHXaDqO
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="77449092"
X-IronPort-AV: E=Sophos;i="5.97,244,1669042800"; 
   d="scan'208";a="77449092"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 16:30:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVrxvuItbikM/OeperymIuAoHR3+QIVcXtM5r7xcv5GTkGa0CLV8B4P+9dAVI6N6BUWRRDJINH3pFDpP/wt1blJEck/lnooIMFDSTWmEcPrc5U9R6cF81j9fYpcAMigS+GmqqFSHRIBeC3p5OO80BoFnQa95z3uxgrbJ3jgqREk7CYBarI1HYm7NzSRO5EKzooW8VsMUQNpyWN/HoXorriye16uVIhrTDn4Jpf6uzQ5uVXya9gntEEOOuNl4bIFPaeKF/ArVZeIIHhTkW/WkkwqYtYynG6mHKai05+0y+PtCLim4bWZgCQKjGX5uzsh7X2kEsZBttwW5RlvvrLLlEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8hnSLYOZecQkiI56lVN4hzFQcZvr4AOVHDIGkx8cyw=;
 b=mvuq9rviScjAF+nBRTddQhQ4VULL/+1UJM8lm70UTAUpvUFSkTxYbX9UBvBy4oiaYf2fZFwdSQI5Dc0fRhVpkN0fCrkowYIQ/yHT4w35gS5+0ofgb9+2oGXPUEQC7M3nwNs7JtXKPKJcQ8SmBEszpWF3jpvX+UR2x1isA65ZdBP5rsTjPY0IG4i32KFQGNdW/IW7v8s4H99cweq8xy1JL0ymTzQXFJAyBd9iX/7tybiy8xFEw5iwvMoRGwnSXMcgy+Rkg+z7k04a/78Ky7QWxMHnZWA3DKry+irKNPD6y/InQbcT/Qm/pXJ7duNqitMj1x0pMttM8wEyRLmj1HkMww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYWPR01MB10910.jpnprd01.prod.outlook.com (2603:1096:400:391::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 07:19:38 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::2d81:9d85:cd8d:e41a]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::2d81:9d85:cd8d:e41a%8]) with mapi id 15.20.6002.033; Wed, 25 Jan 2023
 07:19:38 +0000
From:   "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To:     'James Morse' <james.morse@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "peternewman@google.com" <peternewman@google.com>
Subject: RE: [PATCH v2 00/18] x86/resctrl: monitored closid+rmid together,
 separate arch/fs locking
Thread-Topic: [PATCH v2 00/18] x86/resctrl: monitored closid+rmid together,
 separate arch/fs locking
Thread-Index: AQHZJ3g3C0NdqeI7vECSTq2SoW0UxK6uyIBg
Date:   Wed, 25 Jan 2023 07:19:38 +0000
Message-ID: <TYAPR01MB633078AF40B01259B82868AD8BCE9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20230113175459.14825-1-james.morse@arm.com>
In-Reply-To: <20230113175459.14825-1-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-01-25T07:07:44Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=cede3cf3-e28d-4753-a276-ef553ba98fe2;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 09a3f8d0886a43e18e9dd6dcfd5f49f4
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|TYWPR01MB10910:EE_
x-ms-office365-filtering-correlation-id: 0425ff96-58f0-444f-b8a1-08dafea484c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r7/8ggpYtr9Jj0DCGUW2y44M35/KWrDbq+fdOKIHBADJ/n5G7RP19ixu6H7wh7bCPUcW4watZYfAtnzofRdaKejLBguIG4h7UTjAcYft4ss8X2vbrJS2GlX7e19amjMCyd38y7abJY+mb6OJOKEDEtsf0SjGBOR1esEjwVPV2askHtKgjx8JkhD4tnIpCDqneP8MZvTEuDxxxGC3GaL+IGT3G7pzTwll2w83x/XAq36FWrjQfSIKJWKMQJFgJLmqcpuFDIs5w+L+wANQwXXJ69MAA1gQAbeqNgZB14tuo3rSE58+BdGCui+6VfJWPtK3FtcGJ9Z7noLZAM5pVG8ShDJBLG0dk1acwEr5NCgGdLhU5AZimdyJYydkgPKAYC3DDN2MhdwaeeC5kWHIfbRhda1PDzfQ2iJuY0cCJSDEBJBPWhVc835q/dFJOwzYjkoNoNlBS0smuNj2ZGFskOcwjeH+WeSc81YFaVvF3QX+bTYlJd+LIeKVzgzgYW2fewzVOh5vUJ2h2f+qAPj6ucXmyLkhNy2sEqX9hImmdJhDQp1q5N1Z/JPBmlgKL2feMXJuFE4ZTqRzNQ6GjkK2UzoOL5fucgmKwhPdfuq/vQKhN7pEzRNkli1l6oUXyjB123hhUy6tgd3WDqshmjKb6Y9YFeRE0U7UCDT4MJN3oWF5CB4ik+pDA5Upkh7uPgKgNCB3Az0DiCXB03idL2M/JBUiIINbm9JnN9V8U2wnIP9EcxU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199018)(1590799015)(85182001)(4326008)(82960400001)(86362001)(5660300002)(8936002)(38100700002)(2906002)(1580799012)(186003)(26005)(9686003)(71200400001)(8676002)(66556008)(54906003)(6506007)(76116006)(316002)(66946007)(64756008)(7696005)(558084003)(38070700005)(7416002)(55016003)(66446008)(52536014)(41300700001)(66476007)(110136005)(478600001)(33656002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?T3AxdGh1c0taa2VBNml0WEZ6VmNsTWtmcmhhQkFzbEJwSFpWd3BPV3I2?=
 =?iso-2022-jp?B?eG1HZUpseC9kT1hwam1iVi9veTlIQnBQQzA3QWFVbEkxeEZzUzcrVFZF?=
 =?iso-2022-jp?B?cDJiY3Q1ZjYrcnRmUTUySFFkZSs4YzcrVzF2QnZjMXlCVUpMTDdoVVRh?=
 =?iso-2022-jp?B?VkJlMDY0VDV4WGRqQXlUNkl1d3pVbXMvaWcwQis0bzdqRkZYK2pvaGxC?=
 =?iso-2022-jp?B?WUtJcWhtV0FEa2hXTEQ5NndBSi8wU0UzR1dYb1RUMGZmV0VqSWRBRlFH?=
 =?iso-2022-jp?B?eDhFdEhBMHlWVWZjRG0ySVg1eXBKL3gwYkFDMXV4Nng4b2IvZGg5R3dQ?=
 =?iso-2022-jp?B?YnVhZmNOd0MyL0paRHdZUnFlU3ZVNE80RVNQODM0THkrSzlERGJPTzJa?=
 =?iso-2022-jp?B?Tk05NW4xblJ0TDFPdFd3c2NSZXpSOXRSTllvSE53UEdycWJwLy9ybnJ2?=
 =?iso-2022-jp?B?RTQ4aE5tZ3BmT3p5eG5CSllIZlJRYUdWQzN4cDBGc3hxU1VBT1BlcU92?=
 =?iso-2022-jp?B?VnhSNWtFUFl1aGNLc1o3R1JFeWE3NjJPMWRreWJoSFc0VjJyTTNmNTNZ?=
 =?iso-2022-jp?B?R3laSXZWY1lzY1FESmlEYXZPUHkrd0x6Z2NlTnF1UFZJMkdIUEZxTUlP?=
 =?iso-2022-jp?B?bmoxTkxFbncxSGJrbkc3cTQ3M1NDcHVDb2ZhS0xxeTkvQ2lwWEM3bDJp?=
 =?iso-2022-jp?B?dFlqblUxNkowNFRTZ3RkRkhXRWNIVnc2bEp3M1NVRUNRUHMvK2U2c0tM?=
 =?iso-2022-jp?B?azRkZXZxeG90cXJ0U1phK1lVanQ1RG5USzA3S0lwMnkwZFNJNU4yZ1lz?=
 =?iso-2022-jp?B?cjhRMmdRcVpQa2orY0JZWVFQWWk5bFIrTkhBWHBPWjdvRXMwc08wRG5N?=
 =?iso-2022-jp?B?S1p0S3kvbmxxa0FSSUdhc2xCeTZiTjN1UXExSy8zV2t3d09nVHkwQ3RR?=
 =?iso-2022-jp?B?ZXZ6REh5TWtueGE0aE9Kdk9BUmpYcWhZdW90ZnI1ckpIb3BicFRpTnNZ?=
 =?iso-2022-jp?B?UW51VTRvR3RPUjJPaW15WUgyNUVvaFdDcVo1RkIxLzRQYy9odGdTUFhu?=
 =?iso-2022-jp?B?RnZOUitScG1YLzJLSFczVEpTd1Zpa2YzQ2xYalp3TUVKQ2NVTms0c0Jv?=
 =?iso-2022-jp?B?Y3k0WHBPNFFMSXpRN0dIWWlKb1BTbm5hb0UzZC9qajJzVC82L0ZwMWM0?=
 =?iso-2022-jp?B?K241K1EyRlhHTVdiaTBpalZFQ3kwclVZL0FzMnNzWk5FdHY2ajZyTWhW?=
 =?iso-2022-jp?B?eUxHQWp4VWJOTE5GdFp0ZFJUREk3M0dsMHRpUU1wWGJVYVJtM2Y4S1ZO?=
 =?iso-2022-jp?B?QURDUXkzSXowdDliQVZ5RVVvM25KSnNzYzZwbjBBQ2QxT210UWZCbFRH?=
 =?iso-2022-jp?B?ZmwzTTRCMzV6MURxeFg5QlhyRlRteWNZS3Z6MkJoeG5lUHZjWVUzM1ZG?=
 =?iso-2022-jp?B?RVNGUjV0cDRST0pWTVplWXMrNlphZEFpV1ZVTmtHV1ZFQi80cmxWTnMv?=
 =?iso-2022-jp?B?dm9xL25mQk1aTVU1MzFHRnoxOTFsYWk0T1E2S3creEE0bjVPVnRoSy9m?=
 =?iso-2022-jp?B?Sk9zS3VsSlpxdTRabVk3UTBzZFBkbkR3a0UwTmk4OHh5OU5zMWQ4YXBm?=
 =?iso-2022-jp?B?U3dNKzUvOTJ5M1BSUTcyYjBsa3VXbDFmUHB6MmJXVXRkZW95cmVMYlc0?=
 =?iso-2022-jp?B?YU9kNEFYRHMvdm1sT1V1cEU2V2dUc3ZmY25qUHVKVmtwVHRhOE9kZ3Ja?=
 =?iso-2022-jp?B?aG50L2FaRGZHblRNd2xwK0pVV2FEbFlTNENCZitzNkFFdmplUVBnUW9H?=
 =?iso-2022-jp?B?UDcwZk1jSjNTNXdGbEFZWVpVZWNqK2U1cHVrbHFMWlZZNlNxbkRCWGhP?=
 =?iso-2022-jp?B?MXEySnMxR3BLMnN2QUxBcDF2Si96dzE5Mnl6M09iRyt5Y3NIU291R2g2?=
 =?iso-2022-jp?B?SC9wcUovbDA5VC9KUVBELythUGRnam5BZ0ZQSHhMcml6VUNpNTdMdjBC?=
 =?iso-2022-jp?B?Ry9jS2J2K25kYlNPSGlYL1BnaFdLbFJMeDNoYUVWamFKM2xqaVl0VnV4?=
 =?iso-2022-jp?B?azNmaU9nRHFLN2k5L0g1UWNSc0o5NWV5LzlYU0pkOE1yeDYwSThoOFFG?=
 =?iso-2022-jp?B?OWtBcGNEYm9nYmdnNlk3b29iMVB4ZUl5VHdrVFczYUlyRGtrMVJFbG5v?=
 =?iso-2022-jp?B?U200eTl2cU91V2ZIYm1HYVlwR1l6UGhqZ21oYmVSVHNhRFNrL2dGWXU2?=
 =?iso-2022-jp?B?bkYwV3VWcHhEaUV6TTNNMGF5VC8xYWlVd0FjTldVTXVoNVR3eG8yRG4r?=
 =?iso-2022-jp?B?M2QvNlFlUUhFK2NJZW81Q3FGVlJmY2NjWHc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-2022-jp?B?WDR5MHU3VUVMaXlSQzZZRDhCMmZEbnpRWFZGMk1ud2xZTTNOeE5TbFBS?=
 =?iso-2022-jp?B?UytSRHhyZXU5NDNKOHFnd2JHSHRib05ZdUxqMk5lZTgzUUl4Qkp5Mndp?=
 =?iso-2022-jp?B?NjFuSlFNS3lkbjJkL1E4ZkFWTlllbW5JMXhPcjVsUksraE9Jb0w0NUVx?=
 =?iso-2022-jp?B?a1BGVEtFM0FnbXNpV250SWZJNm14NjRmd1ltRE1QQ0E3NGU0Y0taUksv?=
 =?iso-2022-jp?B?NmpmL09JNzc4QW4yNjdyUGFIWmpYQlVxdThqOTF4cGhERDFXb0c4SnVG?=
 =?iso-2022-jp?B?eEdOWFd3WWhrTU81eXFsVHpzZWc5b2VnMGF6QWtlUEQ2c0NZZjJrNnRm?=
 =?iso-2022-jp?B?cEpLd3pJMlVEaHB2ekpwOUJDenFKSkFZN0xHY0ltWElpUE1mREpycDJ0?=
 =?iso-2022-jp?B?ZDdFVGtjNzczc1YvbWswWGxhNFovZ0xqSXdoaHNIaTFCaGZZZE9oNFho?=
 =?iso-2022-jp?B?S0JBdTBFOCtWVjNMVCttcUc1VmlPZVlmaDU4REhvSDRNUXJReVpQbW1j?=
 =?iso-2022-jp?B?QU83Q21YNlg2TDB5LzlkRG45eWhlUmhXazdQamlSeXVYaENDbUFVRXB4?=
 =?iso-2022-jp?B?bWc3aUV1bmtPT09GVituN3RZVXNBVis5WVhzVFdGMUlKOWJ2WkYwK09G?=
 =?iso-2022-jp?B?eWh1V0d4b0doVEQxTHdmVWFYSVY5WG51SjQzZUdIcXRVbWYyQVFTUlZv?=
 =?iso-2022-jp?B?ak9PNFhlNzhxUUNrVFVsbVBXaEIwSXM2enM2MkJybHlIYUVURlJ4R0RV?=
 =?iso-2022-jp?B?NTlOdnp0L1JNTHVxeUdmNGtUdng5ci8wWU91R05zUysvVXFEZ2R1SkJ6?=
 =?iso-2022-jp?B?M28wZ3NxQjNPRFRKdzIrQU9YTmVOSlMxRTZCRm1vQUJCUmh4eGZvbk5j?=
 =?iso-2022-jp?B?VmJxbDVjUDRGRmtCb2RETGJ5akE3T2ZUWmp6bDNPdDMxOEg0TFd4RjZy?=
 =?iso-2022-jp?B?UGpOQ2F5MWp4UHAxb1l6ZkNzNjY2ZTJiNnNSR2RCNWxLVDJjMGhhWi90?=
 =?iso-2022-jp?B?SDlKalkwamFPa21URHRGeW41d21CZU5XNjBxbDdDdXN1Y21uenFKTG9I?=
 =?iso-2022-jp?B?SitZNXI4bGQ5a0ljMEsxc21PYVpwd2E4WVlIRk1aNjR0MjhSTTZocUdq?=
 =?iso-2022-jp?B?T0Yzd29QeWZoekI4SmdSdHR4S3ZWYVRIU1prMm1RNnNSSGxTNElnTlpO?=
 =?iso-2022-jp?B?SlRBSlNqdmlDRFQ1T3RTbVJpb01oL2RVb0c0M2ZtSi8rNk5tbER0WXBh?=
 =?iso-2022-jp?B?UllWRU1VeGprVFA4R1Qva3FsaDg4RjdiRE1xQWoxRG1vc2twK1lpdkY2?=
 =?iso-2022-jp?B?MmJSMzNqRVo3RzBCQUt2QnZybG5wRFZoMFliclhtM1BWOFRVaGdkNWlR?=
 =?iso-2022-jp?B?YTc4U1JhVVZlMDdlWWJ4RUpWRVFNWkZSNDdpSit3TzRFdnRMQjcrMEcx?=
 =?iso-2022-jp?B?RXZJSElEcFhmUDRRcU84b3diS3NMdjdHeDJNQmRUWkR3Z2tOckt5MGpu?=
 =?iso-2022-jp?B?Y05CTkY1ZWdyVTlFOGlXTnVHM0w5NjgzckZ1ZEpyNE1EZUhJZWYwRTl1?=
 =?iso-2022-jp?B?MUlabWtZWTdHOS8weHFrV3hSZC82YXBtclJLaWNDZTAxVytXdVB0azdE?=
 =?iso-2022-jp?B?T2dRMTA3cDJ6MGRBRk8vTmtaUHA0Y2NKdmQzTkZyU3lKSVVSQWlxK1l6?=
 =?iso-2022-jp?B?ZXQ1dnJCRnJRNGJKV1h6NlBQVmE1SktHUlBoYnlDU1FOS3ZXTkxlVlpB?=
 =?iso-2022-jp?B?NkpzeXAwRVcrU1RDcGd3UUpmMkQ5dWJ5VS9tSzFzSzY2TXpsa3JNTmNp?=
 =?iso-2022-jp?B?UjVCQlZFYk43VzdxS1RLYzJVMkI=?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0425ff96-58f0-444f-b8a1-08dafea484c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2023 07:19:38.1429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WL6Va1R5zBipHtJpQqQzTITgoeLz4uKK9d4F3NFcG5NbHdNVrg3S5Vid4KD2aXvFMQqC5uWxImqcV0ex2oq8HHLZIq8Smo/l0vpIA3Ma/uM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10910
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Tested this patch series(v2) on Intel(R) Xeon(R) Gold 6254 CPU with resctrl=
 kselftest.
No problem.

Thanks
Shaopeng TAN

