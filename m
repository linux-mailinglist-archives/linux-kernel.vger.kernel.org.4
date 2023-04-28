Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B806F121D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345433AbjD1HKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjD1HKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:10:15 -0400
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A171BDC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1682665814; x=1714201814;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2R7EHI68I3mRoU5DGkFT0rPnhC08yA5ol1jncvl/2KM=;
  b=EeYi0ieoSGUpS+XoWKOYnWsR4DxApzKPhA+ydl3gY0ZkQOE+wpTyu62H
   Sk7Po3IhLyxQZxjgluzbzJVUCZ4SHdRcmnaEgE3uEGJMpaUanaIXxhWeC
   C9jIxInKuh736HxqHa7rijQ5lZj/jaeeUTAwFpmYOj10QqSTihluhQW0N
   uD4CVZ3+LKELW/r1yAgZGfyFc2boNMRpUr29P4jnIUzWtnHbm3+TaAq8C
   sgsq6IkYBrhTvzZcBxLdbHYltcKuKCMj4AR/qbib03wRLP+w+9xeE1F/9
   NHRTdjbEgiXPPynesLhkJSrpHmQ8Cu0ulxwmQLyTV5ZIX1eZAOU87BBur
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="91441455"
X-IronPort-AV: E=Sophos;i="5.99,233,1677510000"; 
   d="scan'208";a="91441455"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 16:10:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3HG9NQTh3x5sfAzifabLU5GoY8qfF6dFqUZxsHsrntQXfGhT2dxwvqgtPw6eTZmvUJqzddN5r1uQs0zoXbIBBdAYy46+vjFpa8fyDr39Wqzb0Zi08ly7doZ/KZWdGUcQayEGjlw4ulVOc8EmjaqzpwCIKG/pa0Rx37+Y+HejJABmoFioDgk5cVoBtAH2DUQUEHhGZ+l4gRSd4JM7o7qbYgrqXdQSvgVvUhyafCVSB+K7HPgljDuauQl9JeF7Hbgjh+q8xZ7olPZToLdd1fa6razQOJkPcNYDvYftI+oObYsK3mKwAgrJSCBxKeIvr3L107yokqIt81uOPv0u3C8/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2R7EHI68I3mRoU5DGkFT0rPnhC08yA5ol1jncvl/2KM=;
 b=jdaFrBtdyZsacfzxVjf1ah3MBR9Eqz4pf6aWf+Le+hMw2yzYcLVLBFL6RILi871TfEp4OkWjAo0rXTegnEwUB58cMNNQBuq1Tnmmhv5tI+Q90CC0u4rQ/1Pwv46JqMCud3VoKkRasaH7yQ/kzTBnlSu5copfBNMDW43iqZjZh5KqHnv4uknl1CExo3LCI7NPZEjosEvgSI7txOF5x8rjl7xbMigw3gifY32JL/1g/5cJaNZkfBXzdyWF7y9X+jjpGEpQx0GLBpuEb53z1qnfbLLoMGiKwYCb5jfZGqGjtWozndIbWtmjpCql8X1wGBYMzm5Me03nHv9c/7s3dYj7Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYCPR01MB10760.jpnprd01.prod.outlook.com (2603:1096:400:294::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.23; Fri, 28 Apr
 2023 07:10:03 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::687d:4884:ec0b:8835]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::687d:4884:ec0b:8835%7]) with mapi id 15.20.6340.023; Fri, 28 Apr 2023
 07:10:03 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     Jane Chu <jane.chu@oracle.com>, "x86@kernel.org" <x86@kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>,
        "Shiyang Ruan (Fujitsu)" <ruansy.fnst@fujitsu.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Takashi Iwai <tiwai@suse.de>, Baoquan He <bhe@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sean Christopherson <seanjc@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Colin Foster <colin.foster@in-advantage.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH v2 3/3] resource, crash: Make kexec_file_load support
 pmem
Thread-Topic: [RFC PATCH v2 3/3] resource, crash: Make kexec_file_load support
 pmem
Thread-Index: AQHZePGp6T3ME1yIBk6VWnFnTOh+FK8/n1mAgACvqYA=
Date:   Fri, 28 Apr 2023 07:10:02 +0000
Message-ID: <fd853558-f5ea-c320-adf0-457092c7949e@fujitsu.com>
References: <20230427101838.12267-1-lizhijian@fujitsu.com>
 <20230427101838.12267-4-lizhijian@fujitsu.com>
 <7babd90e-1514-3fe5-89ad-9d06fe2b0a39@oracle.com>
In-Reply-To: <7babd90e-1514-3fe5-89ad-9d06fe2b0a39@oracle.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYCPR01MB10760:EE_
x-ms-office365-filtering-correlation-id: 95aead93-2c58-404d-b90a-08db47b79662
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NJO7p0n7QqP2SXsfbeAzUG0bpaN6WiQXTj5PQ8xZDO/qSpTNjWCiAOodgRSKHZfgQ18TrsPTc5S/DJa4ni04bvbc3q6r/liRHdzYvxsXTzc7qDFmgh8Lkkwkz/KRK1/ZMi73CrCKfaUXgc4j/1LHTbURBTSI1xth4pTm1Xn9DhIXK3Oro5gWp8L1dCuqAbE8v98MC+LPFP+p3Vj0aycdbdMnATj1/Wpo3GmOdDSfeHZ1XJB8u3FtB04l1yS0f1U36ogJgkFDXCNY3X93NN/ICPTS4uof1wx/3+KrZI1OBl8c/TF4OrCwz9622r7jzBSNWO843S7au7QUMBu7KlGV0DYy/0O7bNvQLEUussczz/0tuBnaeweUACbptphxbYumPOu1VPZZF/m688+LWuHnC2oPFRSwRJbYmgKmKxFbKgpTldWF9I21TldG7lNmm8slFzHQZOlhcCMisIOQqxbfhAN6YBz1ZqZhw+YjGb4IKLkhveuuvK1RYeLfnpIyIh9uCh7s8jVy0SH09RldgGTqns6irH3cXdqFwy/wUi61Am7XNAg69AK1nJAXG1DQikdv6kwhbCWEi4+gE52fH1psUuNfxXbdTv0hlL8TbGL6YTNFPyrWI1yIvAvSe8Uv3xG1+rI5WguiE8su+MiEX4xxTBuF+NzbFkSvie7EHPvjbstv1oncJoY/ad1d+PgaxN5PGV6/dpRexCdB/zJX8DJpJw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB11664.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199021)(1590799018)(36756003)(85182001)(1580799015)(26005)(53546011)(186003)(6512007)(6506007)(76116006)(91956017)(64756008)(66446008)(66476007)(66946007)(66556008)(4326008)(316002)(86362001)(478600001)(31696002)(54906003)(110136005)(8676002)(8936002)(5660300002)(7416002)(38100700002)(82960400001)(2906002)(41300700001)(31686004)(122000001)(38070700005)(6486002)(71200400001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3QyalZSMklmdkhHL00reGNEK3ZwRkd2UG5lOWlubVFTQkZoT3kyam1YZkFY?=
 =?utf-8?B?cXRBNzNzd0hYT1pRVjVVbDNyTm16SUNzVmJVaHMzWUxHaFVDVVVTU2V4NTRH?=
 =?utf-8?B?RlNqTnd4MXNpRnVVWkdQcDU2THcxRXdvMC9FRlFJNXFHeHVrYXZlSlRUZ1Bs?=
 =?utf-8?B?T2pyMlZNT2JpNGlsNkpYYW5rcStka1RqQk55clFXWEtPeXZxcjMyS1ByMXdv?=
 =?utf-8?B?M0xQR1RJeEQ5aVd6djV0MFg1RU82WnFlWDIxRTYranFxMzJRNnM2YWFodXNR?=
 =?utf-8?B?RHdONlh6c3JCNUdadVo3dVlQT1JzWHNTVVJmNzNVSjNrem8vOElaT0tBN3Rz?=
 =?utf-8?B?Z1BLcDVuU1hGdzlsbmdGVTJIL0FTeW9Cb3pMWkVHMUY1cUtiaXJqdWh6Vmw0?=
 =?utf-8?B?ODZRYWVCb1NiZ3QxN3NCZlkxKytzUVkwemJMV2J6TWU5Q25uazBydmJXMVE1?=
 =?utf-8?B?SzFhNE00K3IyNWltbHRmTnRUNHdSb2N0cmRreEFOaEROdG5TOW1SNDZBc3Az?=
 =?utf-8?B?WitUSGk3NmtFYXB5K3B4T1NmVFA2U1RYRFUxQ1ZzMnVXWkFEMXkxMXJ6UlYx?=
 =?utf-8?B?N3cvVmJuZmhDRDkrMlF4dTF5L0VTaGxLWTV1c1hpNUt0YUVKUHZORGZCOFBT?=
 =?utf-8?B?ZDBtL0tiMFpieVJWZXhtNnNnY2w5cmlscGF6NU1UZmRzbjNNQk50MkdhQytu?=
 =?utf-8?B?YnJyRkMvZm1ncU9RY0M4Mkt3b295djFpVllCNlFzcGhQeHpkOWh5R2MxUjhj?=
 =?utf-8?B?d3B4ck9Zd2lkcXRDMlhmckFERGE3MDdHK2JrUG92VTZZZ1M4aGVNeUxZcjRq?=
 =?utf-8?B?NUh6S25iaXRhTEhOMHc5UWEyMTlJWDZzcE82b2pVMkE4RmtkNm1YSHJldlFa?=
 =?utf-8?B?cFBVZzA3MitBUmxvd3hMMjliOHdsT2RUUkJJZzYzelJ6QW04Z1hUZExBVTZU?=
 =?utf-8?B?bjA4OVN2SHRVYXI1WlJNTFNlYzhKM2hNZk42RkxpR2Q3OHFqU3FMNEVOSlll?=
 =?utf-8?B?MzliWkluVmJmVExOYUZFc3lubzl1NzlNbXB5dXl1eHN3aldmMklCdloyWGxq?=
 =?utf-8?B?MXFtcUQ4QU5Gd3laaGpBLzZsY1ZOMWxmbEZMZjJOTW4wYWVRWUl0RGhqa1Zj?=
 =?utf-8?B?a3Q0SWN0NWRKY25JZkxEMVN1Z0kyZVZ4bGxHQ0ltNU5SaFF4WmFXbHIveStO?=
 =?utf-8?B?L0tlUVBxeVUrQ2I3L21hK0hzK3hSdzFqV3FDS00yZG5raVVIZkFKakMrWDVN?=
 =?utf-8?B?d0Vsc1hkZWpBR3VLSHF3akpVekZxTGNBWEpyRmlYUGNnTURCQ3pXcGs0WFFD?=
 =?utf-8?B?WkZLYWgwOHQ0Y2Q4cFhvdTR3RXZvb0ZMRUd6YzFiS2hsMUhJMENVU3dTT3do?=
 =?utf-8?B?UTR1dzVHdkpoQlhCWWhBZmJJQklqdnE5VDRPRi9VTEVpcW83ZERCWXRVYTUy?=
 =?utf-8?B?Y3JzNEJndDM2MHNtcVNKZWlCQWZlV3RRaExyUmU2cUtKNmtHeUJUS1pBRlF6?=
 =?utf-8?B?Q3kzWERxbU4wL3N4UUh4TnRLSnJQTHZkOVhxclNORDcwWjY2SGJQRkV3STVN?=
 =?utf-8?B?alM4YUprbElZODdkcnVPRFZDNHBlRVpoZGNPcmtrekdNb2ZsN2VuM2t5cy83?=
 =?utf-8?B?QmJLYi9YeWM1eTk1cjhzck5uT3hDUmxpcFFWVjZnMkV4UW5OWkVaV1RyZzNw?=
 =?utf-8?B?Y3o2Z2pHaTZwbi9EKzByTDlOMVdzeDc4OHJKVE9iUFFHdnV3NlFRcysrN01y?=
 =?utf-8?B?UnZvR2JkMHFwZ24rYXV5STNvREFLNTg1Rjk5QnRwdUJ1a1hITHVJNk1JdTRv?=
 =?utf-8?B?dUxqbTZDNXhMZHFIaFlkYUJMN0pjUnVCMkVXbXNHcHdudFlxTUtleTZkb3JB?=
 =?utf-8?B?NEdGekJUSUtkLy9yTVpMK0w5NVRXbDlXeUVCcEQ1R2l4cUM5eFlWL2FKMnVx?=
 =?utf-8?B?ampMcmZONUkzeHoyWVdSdTk2N1lkQUovbmYxTVFVWmVmSkcyVkJwaGVCd1gx?=
 =?utf-8?B?aWRFUks4RnNCcVkwMFZCWDE5ZmJSRktIL3JOL3hONHFxci8xVnFXRnZVZ2s0?=
 =?utf-8?B?U3RYZHc3R3pIdFdZeEppc0VMenVsSVhCOXI0c1F0ODBjaTlnbVloZUYrWTd3?=
 =?utf-8?B?aWlTOUZPVkNXbE9JakNRZEhoSEFnanBxOHlla3RZK2VOR0dpSktGSU1DcWJm?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <28DD14B647FDBA4BAEBF751179FEBA1E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SjhRR2JHV1JrWmhvWVNseTRCeUNneXJpVlh5eXY4dVZDVm9qZGFFeW9mcDNp?=
 =?utf-8?B?enBlcmp4Wlo0ODBQcytPUkRBMDZkeEZzUDNMeGEraEJobjdtcjZNcTlhUzNr?=
 =?utf-8?B?elVFaklRdzd0cHZkMGlCZ1hSUStYdnNaYzN0NVY2Y0h5ejlGa0Vrcm5ONTFq?=
 =?utf-8?B?bW9WYmFyVUt1QzZwdURMazBhb2FDcFpWZ2swN0NCQVlqOHhZL0c4QkFLRGtz?=
 =?utf-8?B?RkNwaUp0NEl6V3duV3p6WXZzS215YTFERVRZVGZtYTQvcHl0L09xalpjYVV0?=
 =?utf-8?B?ck5WTFZBcEVvZ2tBTlFoUmFqZFBMbmJEQUo0b21uR2ZTSHlNdlJ2RzhDRUpP?=
 =?utf-8?B?dkhncDgzdGNxaSs2QXgwc3N3OGx1U093U1Q4d2IrMytiMHJaQSszRkhnUG44?=
 =?utf-8?B?M3M2WXhpampRNnN0VkxQbVZJRXYvQlVKUENnU3JXVVd1UWxMMnBRMC9MYW9T?=
 =?utf-8?B?Y2lIenJSMXBiM01UOUV5Yk5UV0NEY2pOc1FibEp2QzIxUVZQdzZoU0F5VVBH?=
 =?utf-8?B?UTJiUnorVEtlME1wU2Ftdnk3Z2VXVzM1RUU4NHFLV2x6bEZkYVovNXRCdkJ5?=
 =?utf-8?B?anllNFgycXVOaXZJWHBGMTlUejRYNXBha0NvT1d6ZE83SkJEZ202ZGdlOS9D?=
 =?utf-8?B?SjRock4xOWlRb3RORzJ0SE44cGFCUm9TVlZNUUY1b1RtMXZuWGx0T0hOWDFJ?=
 =?utf-8?B?d3B3RzJTNGh2OUJxM3V2TmJXWnlyUnNTMzVSbTUxTmhTMHN2UVlqYVU0OEVI?=
 =?utf-8?B?TzhzQWxxSEZJek5yTHBmNlBFZEdLUUxtV3NWQkpqTi92WUUyNGladWp4N3pv?=
 =?utf-8?B?YUZ0amVhNGowM21LNld2blhRNFZJWUwrS3ZTeXNOTElLOVFZckZqTXhvQ2dS?=
 =?utf-8?B?ZFJNOEZhd0NUcmErUTNIU3JiUGlHSkVRMTFpWHJaK0pRVFltUSt0UHRHR3VY?=
 =?utf-8?B?SGtiNUZiY2RVdXBKWFA1Y1k5WVJHUmxnNUsreE81dWxHcmg0UmZ2Wnp1eGZJ?=
 =?utf-8?B?R3RVQlhhRmRMcnRaandMZmgzYytMbWZnbEZCMTF3ME5wbUVLS2c2OGVGN1FT?=
 =?utf-8?B?SHdDa3gydXZHVGthRmJkL2N1VzBrby9aLzhIRXpFZ093ck9oV1JrSnJFNEZl?=
 =?utf-8?B?UzZXTHFuZG9EZzluNGRBZnp1ZFpselBRd3lyU1pRVVdUYVQ0Ym1tY252UEN5?=
 =?utf-8?B?aGZ2R3o3YkU0aDA5ZXpDSWQ5UjhrbkhYelEwVUw5UCt4WE1sYThzUm05VGVt?=
 =?utf-8?B?ajRPRFVtd0FzOTIrUldYWVo5U3R0M3FWQUtaelBuMEpzYTZmMkhNUkhmTXJx?=
 =?utf-8?B?R2pUSDFBbHA3aU9Oc0IzVlNYSjFQVk9EYy9UamRtbG5FRi91UURYcXRQdmpB?=
 =?utf-8?B?SVRDZjNZeDB4ODhaelgxdUd0M2dyZzdHMldnOWxoOVMyN1hSaDNTam1pUkI2?=
 =?utf-8?B?YkcxdzNIcGVwYUl4eXJabVVqWlE2dXltNzMvQUptREtYMEx3dGxtbmV6SzlQ?=
 =?utf-8?B?dEFwMit1MFNhMHZ2Z0szeEVGYmIvcTgzR1NVVnlnMFFuc0dtM1p1dldrTWNv?=
 =?utf-8?B?eks1MzY5T2NyL0RjaFRuT1FMMzF6Mm9PVDkzdkhETjkzWFNDTU1hbHd4MTVj?=
 =?utf-8?B?bFhaaWFUTmQxNDNEOW9GR292V1RaR0ZPMEpQTktwRHAyWG04ZDFWRk1PQkVU?=
 =?utf-8?B?a3FDZHpYVUU3dzQzOXh1QmNsZEhpaHo3UzBDYm1CWGNmNFVJbEdEZzMvOHdZ?=
 =?utf-8?B?bGo4aXNreW5ZOGZOcElPbm5hS09ucmFNVUFyNXBSdENicmw1dGtldnBzREpi?=
 =?utf-8?B?Wm1yTXpZdkw3NHZHTGozNDhTREIrbjVaUTVlVHJ0bjNqck5pK1RFQmRsVjly?=
 =?utf-8?Q?2SP5+aGVdygVN?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95aead93-2c58-404d-b90a-08db47b79662
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 07:10:03.0149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aH2OnUVWXe0B8zA2I6RqoIV51AWkWqKopo7H3XVOVq5Q0bqXFd0Htzn8479kkXWxSMx7qjOnTm6Cyr3SidsR6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10760
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SmFuZSwNCg0KDQpPbiAyOC8wNC8yMDIzIDA0OjQxLCBKYW5lIENodSB3cm90ZToNCj4+IGRpZmYg
LS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3Jhc2guYyBiL2FyY2gveDg2L2tlcm5lbC9jcmFzaC5j
DQo+PiBpbmRleCBjZGQ5MmFiNDNjZGEuLmRjOWQwMzA4MzU2NSAxMDA2NDQNCj4+IC0tLSBhL2Fy
Y2gveDg2L2tlcm5lbC9jcmFzaC5jDQo+PiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3Jhc2guYw0K
Pj4gQEAgLTE3OCw2ICsxNzgsNyBAQCBzdGF0aWMgc3RydWN0IGNyYXNoX21lbSAqZmlsbF91cF9j
cmFzaF9lbGZfZGF0YSh2b2lkKQ0KPj4gwqDCoMKgwqDCoCBpZiAoIW5yX3JhbmdlcykNCj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gTlVMTDsNCj4+ICvCoMKgwqAgd2Fsa19wbWVtX3Jlcygw
LCAtMSwgJm5yX3JhbmdlcywgZ2V0X25yX3JhbV9yYW5nZXNfY2FsbGJhY2spOw0KPiANCj4gU28g
dGhpcyB3aWxsIG92ZXJ3cml0ZSAnbnJfcmFuZ2VzJyBwcm9kdWNlZCBieSB0aGUgcHJldmlvdXMg
d2Fsa19zeXN0ZW1fcmFtX3JlcygpIGNhbGwsIHN1cmUgaXQncyBjb3JyZWN0Pw0KDQoNCkl0IGRl
cGVuZHMgb24gaG93IHRoZSBjYWxsYmFjayB3YWxrX3N5c3RlbV9yYW1fcmVzKCkgaGFuZGxlICdu
cl9yYW5nZXMnLCBzbyBpdCdzIHNhZmUgZm9yIHRoaXMgY2hhbmdlcyBJTUhPLg0KDQoxNjMgc3Rh
dGljIGludCBnZXRfbnJfcmFtX3Jhbmdlc19jYWxsYmFjayhzdHJ1Y3QgcmVzb3VyY2UgKnJlcywg
dm9pZCAqYXJnKQ0KMTY0IHsNCjE2NSAgICAgICAgIHVuc2lnbmVkIGludCAqbnJfcmFuZ2VzID0g
YXJnOw0KMTY2DQoxNjcgICAgICAgICAoKm5yX3JhbmdlcykrKzsNCjE2OCAgICAgICAgIHJldHVy
biAwOw0KMTY5IH0NCjE3MA0KMTcxIC8qIEdhdGhlciBhbGwgdGhlIHJlcXVpcmVkIGluZm9ybWF0
aW9uIHRvIHByZXBhcmUgZWxmIGhlYWRlcnMgZm9yIHJhbSByZWdpb25zICovDQoxNzIgc3RhdGlj
IHN0cnVjdCBjcmFzaF9tZW0gKmZpbGxfdXBfY3Jhc2hfZWxmX2RhdGEodm9pZCkNCjE3MyB7DQox
NzQgICAgICAgICB1bnNpZ25lZCBpbnQgbnJfcmFuZ2VzID0gMDsNCjE3NSAgICAgICAgIHN0cnVj
dCBjcmFzaF9tZW0gKmNtZW07DQoxNzYNCjE3NyAgICAgICAgIHdhbGtfc3lzdGVtX3JhbV9yZXMo
MCwgLTEsICZucl9yYW5nZXMsIGdldF9ucl9yYW1fcmFuZ2VzX2NhbGxiYWNrKTsNCjE3OCAgICAg
ICAgIGlmICghbnJfcmFuZ2VzKQ0KMTc5ICAgICAgICAgICAgICAgICByZXR1cm4gTlVMTDsNCjE4
MA0KMTgxICAgICAgICAgd2Fsa19wbWVtX3JlcygwLCAtMSwgJm5yX3JhbmdlcywgZ2V0X25yX3Jh
bV9yYW5nZXNfY2FsbGJhY2spOw0KDQpBdCBsYXN0LCBucl9yYW5nZXMgPSAjcmFtX3JlcyArICNw
bWVtX3Jlcy4NCg0KVGhhbmtzDQpaaGlqaWFuDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IC1qYW5l
