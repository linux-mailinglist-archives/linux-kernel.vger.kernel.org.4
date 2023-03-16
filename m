Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24B96BD62A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjCPQpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 12:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjCPQpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:45:45 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B15AA70B;
        Thu, 16 Mar 2023 09:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678985128; x=1710521128;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kBzQFDnzlzjmhfrtwk6wyzdC2C9olURu0EQGhFgucnI=;
  b=CHYHgakzoL74gmI0ai+rdA1y5U8y7xGs86qUifo31lo672Kpd09HPBJv
   gSogBoLqPOwvWh/7OPKORwrONAgK6Cm9oODS+UToURYdpQQbBRZz3kKvt
   NwtlgVSjkNmXFVue3yvkmQbzEnxGxWBIOz/aaIgZyQzaeyJJcbl7vp5e2
   U32bOHEWkJZdAsKyO0B+/0n8v+6kiuc6OCDN1sM1UAU1ZRCbMSNU3Ghc3
   a1smU1f+wxqDZPYPLN1L/7dtqVadbb9ZWrAMzob7hUZ+6Dp5kC583KIti
   WPU67oePdXlavDQ4xJtsB/W+Feuj9vZXBUIYihsqoPP+oDweO/rHPfOF/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="321904498"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="321904498"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 09:45:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="629951467"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="629951467"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 16 Mar 2023 09:45:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 09:45:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 09:45:24 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 09:45:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQ4z0ORpjZCl1v9lGhhaWRDFKZ/nGKsZS7pdIIGkRu+/AEr3VbIfOggZv2docbXl3tbJzVioUXDg+ndSPTa/SZlLm+FLyGkExPiQQ/9inuzNNqNNKrlLMjcgMhULt6drPEImxwEjKsAE5dcXK0aNb22DTWq11RKZTqlipFM1Q/X96K+rrDqg9NlfEk2yMR1OWEJjYGuZqVf1qDKmWGwG+iIC9QyHMeBSwcapj8rS8Dt847D4lJRn+n7LtarnKk+FeujVwOBGdlQZViewMnV7Y0IjhMAbFaZj6SWMz0E9l+HPrCcpNnbCJTe/Bf8ppLTPI6kh6Uv1llwhd5lSS6iHqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBzQFDnzlzjmhfrtwk6wyzdC2C9olURu0EQGhFgucnI=;
 b=Ji+JdUU6c1TfSyvASTV3xjqu2EL5mETBX343x/rhgjM9HY/ljDMTRHvH35pqyzLvuSS2VCuEffu4+Qvlo+eB25NOnE8EXvWVar9sTdR6JrrQEPsfn/pRL0XYr/pCqXfj51psyl3/StGpzN/SkPWnkNvL7tebmqTVYBRmD6jAbVVsglerot2GZGtYPS3emuxUL09qqpLl6k9ihIgDW3XW5FQIneZJxGA9YSfuOO4dMKXsGhsnvwX/Pxw3BlPdzyRlmz+ZI+1w3rgrlpSMT9bSVcAE8oeszfiwXxwoyANmucpZf6srW+NQY/LRPR2su4a3DRlpFiWFSmwKztsS+uCegA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ0PR11MB4989.namprd11.prod.outlook.com (2603:10b6:a03:2d9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Thu, 16 Mar
 2023 16:45:22 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a47:481:d644:a8b5]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a47:481:d644:a8b5%7]) with mapi id 15.20.6178.024; Thu, 16 Mar 2023
 16:45:22 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>,
        =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "xiexiuqi@huawei.com" <xiexiuqi@huawei.com>,
        "lvying6@huawei.com" <lvying6@huawei.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cuibixuan@linux.alibaba.com" <cuibixuan@linux.alibaba.com>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "zhuo.song@linux.alibaba.com" <zhuo.song@linux.alibaba.com>
Subject: RE: [PATCH v2 1/2] ACPI: APEI: set memory failure flags as
 MF_ACTION_REQUIRED on synchronous events
Thread-Topic: [PATCH v2 1/2] ACPI: APEI: set memory failure flags as
 MF_ACTION_REQUIRED on synchronous events
Thread-Index: AQHZSmjiVCucCwT260yjlP7/yRNd6q79GvgAgAArvwCAAHEREA==
Date:   Thu, 16 Mar 2023 16:45:22 +0000
Message-ID: <SJ1PR11MB608394E7F78D116D09CAC26CFCBC9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20230227050315.5670-2-xueshuai@linux.alibaba.com>
 <20230316072031.GA354196@hori.linux.bs1.fc.nec.co.jp>
 <c1040a40-239b-f8c1-13b3-37b40a90ddee@linux.alibaba.com>
In-Reply-To: <c1040a40-239b-f8c1-13b3-37b40a90ddee@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ0PR11MB4989:EE_
x-ms-office365-filtering-correlation-id: d0cf9601-91a3-44d5-ae6d-08db263dd587
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q9TlV1yy+J2gKTvaKvI95lRGEI4M8rLmVFuic8q7ushABdY5GNwyPAbeKrdlKwifj3cuKKxuNz/Pd30qlQGiab3rOrDPax9OjVak/29+qAj8+oS0PELNvmws1g/iNt1/4ZiJsySH/cEy9JPNROdsOhgu+U9nHH8f8wQjDoE/HTvuN48icemVtwr3XRgfjRv9KwzdWeafvI63cukTGSR8ASL3//xBpOQ5ZGqu7li17d0x2mmRQWAc1qpHqFfy95IFbf/byhRjno2Jj2egu4AJKMJbZbQiekX9SSSyvL2D0u0aAENF9rWm+rSo8a3UKPYZCHScUbCF8TpAef+n9w5gXBRMn8dQRKjmv+6K95yrwf49+Rg3zINU8VodWE2qt8ABsfgS1UObnJ51q2HL8IT5UoYsDfD4anlr7sL+5d6cFD6X7kdZlAPASbbEqnIf+/AwbcC4DamC8Ep0ryW/U2C5q41XcrqBCFNiIfrRhT9G+3wZdg7A5JrX+PoQ7LG/zpeh5a5J6Xr9zhEXiF9Pue0JATZtz8+AZJLPZDCb3JLOuDKXAJXJRgUqzMWE8QFxdmtMPAxXeW48GY4qUjrEUX2IQU+M3ye2O5zthjCIBlNeV4WKcIgeJJ2YKDn5uJWwK2X5qvmuHbCD87Q9b9LUmLXxSCoUbqlU5Jo+zTHVaQ7ZQJGjaZUeOMPV0fcg2X8pVPhTCmqK96RZu0zau0cOL63NNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199018)(66946007)(38070700005)(86362001)(38100700002)(33656002)(82960400001)(55016003)(122000001)(110136005)(64756008)(54906003)(66476007)(66556008)(52536014)(8676002)(8936002)(76116006)(41300700001)(66446008)(478600001)(316002)(2906002)(4744005)(6506007)(83380400001)(5660300002)(71200400001)(4326008)(7416002)(26005)(9686003)(186003)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ykx1WWRjZnc4bnlhcWRQZXp2TDlURHV0VDNYRk1hWnBPb05PcWRMMGJNL21L?=
 =?utf-8?B?M0ZJSVJBWW1RTzNOZXkvWHRMdm9KeFdUUWRmUjU2c0FXbTNKZmdBYTZ3TFVX?=
 =?utf-8?B?SnpLZDAwV2JWWFkzZm40N0EyOTNVRmZUaVdBQ1VrSDVxYmpzVGdObGZMd243?=
 =?utf-8?B?bWRKaHY0QVV5VjQ2ZnJVUVdQbC8zZXZzcFdIbmg1YlN1MjIxelBNaEZyM3Zo?=
 =?utf-8?B?dFp1czR2RkVQdVhCTVNuS3Rrb0lQYk9hSjZ4NnJMVU1lV2RQTFp1YXpXbisz?=
 =?utf-8?B?YVo5UVlOMVBHVWJlUXBRdlZRbHpCM0tQazRXbEgyL3I4cGIzRU5jSjRhVG40?=
 =?utf-8?B?WUw3VG5ENWxsYTFzR0JNRS9nQlpDYlVORFpmQXFPN2tNZGxBSVNjWm5EZ0R0?=
 =?utf-8?B?UW53T0I1SFdybzJUbk5YYXYxR0ZrS0p6ZkgxaVJBZmtETWh4cEs3eDlvZ2Zi?=
 =?utf-8?B?NkJNY29BQStxcVkyb25FUnc5NWZ5SjZxR0dHSElkV3VmUFJLUC94OFJvaXZy?=
 =?utf-8?B?WHR0YnFsaGxkVlVNMDQ4S2dDOWJyTTRmSzBia1dpNGdlb0V6dExNbUJOWUtU?=
 =?utf-8?B?YjFYMGdIYTNrR3I4R0xPVSt3UXJ4ZEsybVhYT0FHc0hVd0I5UFBFbkIySGVE?=
 =?utf-8?B?UGgwbElTaDB2RzVma0NKM2dVUU4zQnNnQmd2WkNPZllJYU1ZOHdwdDArMW1F?=
 =?utf-8?B?ZldNc0Q1NkhvU2RqdkQ1VnB5OEdHYVlQOTczRWd3L0xMOHhLRmlyWFZiZzMv?=
 =?utf-8?B?U095QnIrTG5VMXFxaENZQ3kzNHlwNkl5QVZPcnZlcFVmNFE4NUNPakxUbFB5?=
 =?utf-8?B?OW1hY0c5aStWbGsyWVdHWjZ4cEZVZ1RJYzBZaThlNmJTWjZPR2VkWjRSSVh3?=
 =?utf-8?B?c2dka3JMTEFXbEJGdlZCRVA4bGFGMHd0OGx2bFAzQXJvaTYvbW9oRTVnd080?=
 =?utf-8?B?b0RKbHVaNE1rVHlGcFNTbEJ4ZTVXN0s5K0IyN2FCcEtHZDJ4SGMvRTZ4UVNY?=
 =?utf-8?B?SUEvb1VnZTIzNG4vT1k1TlJ0SkxUdzhPbkxqcUpXc2lZY2ZtYURGbWxIR21Y?=
 =?utf-8?B?R0JLZCtMNTMzQ3FaVUwwMHozS08xeVdvUFN0Q3JzcnUzTGFKelZkaEpuZXV3?=
 =?utf-8?B?ZWsvS0ZsdHZsRVVVa2piN1I2VjdpdkhmSVFkQklwQ1ZCRWQzY0lsU0pQZDNV?=
 =?utf-8?B?TVF3MHgwVWxZbTJSVnVyRUozQzVNc2J1aVZvbnZ0TTkwNUlycFhHUlJDekxl?=
 =?utf-8?B?NFBHNnRES252RmhldVQvSmRFbmtuc09ZY2IxY0pKalE2VEFqQ3RqczkzTlVM?=
 =?utf-8?B?NG8rSXJ5QXlHaWlMTS9TcG14MTJhZzVZTWhPYVFaa0RIWS9Kb3Rab1RyVlQ0?=
 =?utf-8?B?NGZGRXJXS0VHTTB4eTc2dWxya2RQMnpyWFZvcUZmZm5iRmZ5elBBVlhCUEVt?=
 =?utf-8?B?T3dqRWllcmpxSlI0Nm0vbFY5YUtZY2toUUI4ViswWVpiTTZyazNNOU5DeTYw?=
 =?utf-8?B?LzExNTJMWDh1bG5sVjZzWVpQdE9wUUJwRmVraWZpdVh4MlFzYnFLbkJhZ0hS?=
 =?utf-8?B?djlDYWx3cnZSSFQ1eGhCMEtDYWo0aVJNcjJWSHFnUHlSd1dXVVdtL1VTVlVp?=
 =?utf-8?B?enR3bkFzMCt5MVd0RGZoRGNzdmNoQzJkZmtJdGNuMll3SDd0ZThuMUhxbGpa?=
 =?utf-8?B?dUtheURRMkQvM0pCYUNPMzhzT09Mbk0xZkMwaW1RaksveTd4Sy81MTJpQlZO?=
 =?utf-8?B?SlRFcnAvOEVhZGJ5MEJtczMxdzIvY2J0MkdKZDBleVIyMGJLdngyT0tCQU9J?=
 =?utf-8?B?TmM4c1VpakhHb0YrUGFqc1cwRXF2ekhzeEhaV1dseDJMUmtRWHpVWW1PaFRp?=
 =?utf-8?B?ZGZOSlRWaVZOcFAxUklOMzhTMU5xQWhkbWdWMkIybStSK3BZaDNLUThzUHdR?=
 =?utf-8?B?OEhmdnNJb0pTblpObzBmdTlyVmNNQXFxdVh3dWVhaU9WSXpvTGI3MTlseDk2?=
 =?utf-8?B?VDBGY3lXLzVwd0RPKzRSeklCUkNVcVFiUVBhM3hmNnJPT3NaQjNqc0xGTVBy?=
 =?utf-8?B?Z2xtK21GMkFzZUx2NTczN1NlQU1hUzd0eUsyNlVpcU8raXlVZW9VTDN2YmZV?=
 =?utf-8?Q?PODJbkNe2MFjG31hn2t867S8l?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0cf9601-91a3-44d5-ae6d-08db263dd587
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 16:45:22.0200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4MgwFe/pVJWG1rOReBWs0jBXr546sZl9Zu4c5MVcSTyUoXWIXsXQ1Y3+7rOzmJLx8HH0B3rRUN8c9WiVrpdT2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4989
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiB4ODYgcGxhdGZvcm0gd2l0aCBNQ0EsIHBhdHJvbCBzY3J1YiBlcnJvcnMgYXJlIGFzeW5j
aHJvbm91cyBlcnJvciwgd2hpY2ggYXJlDQo+IGJ5IGRlZmF1bHQgc2lnbmFsZWQgd2l0aCBNQ0Uu
IEl0IGlzIHBvc3NpYmxlIHRvIGRvd25ncmFkZSB0aGUgcGF0cm9sIHNjcnViIFNSQU8NCj4gdG8g
VUNOQSBvciBvdGhlciBjb3JyZWN0YWJsZSBlcnJvciBpbiB0aGUgbG9nZ2luZy9zaWduYWxpbmcg
YmVoYXZpb3IgYW5kIHNpZ25hbA0KPiBDTUNJIG9ubHkuDQo+DQo+IEFzIGZhciBhcyBJIGtub3cs
IG9uIFg4NiBwbGF0Zm9ybSwgTUNFIGlzIGhhbmRsZWQgaW4gZG9fbWFjaGNoZV9jaGVjaygpIGFu
ZCBvbmx5DQo+IGFzeW5jaHJvbm91cyBlcnJvciBpcyBub3RpZmllZCB0aHJvdWdoIEhFU1QuIENh
biB3ZSBzYWZlbHkgZHJvcCBBQ1BJX0hFU1RfTk9USUZZX01DRQ0KPiBhbmQgb25seSBjb25zaWRl
ciBBQ1BJX0hFU1RfTk9USUZZX1NFQSBhcyBzeW5jaHJvbm91cyBub3RpZmljYXRpb24/DQo+DQo+
IFRvbnksIGRvIHlvdSBoYXZlIGFueSBjb21tZW50cyBvbiB0aGlzPyBQbGVhc2UgcG9pbnQgb3V0
IGlmIEkgYW0gd3JvbmcuIFRoYW5rIHlvdS4NCg0KWW91IGFyZSBjb3JyZWN0LiBPbiB4ODYgdGhl
IEhFU1Qgbm90aWZpY2F0aW9ucyBhcmUgYWx3YXlzIGFzeW5jaHJvbm91cy4gVGhlIG9ubHkNCnN5
bmNocm9ub3VzIGV2ZW50cyBhcmUgbWFjaGluZSBjaGVjayB3aXRoIElBMzJfTUNpX1NUQVRVUy5B
UiA9PSAxIChwYXRyb2wNCnNjcnViIGFuZCBjYWNoZSBldmljdGlvbiBtYWNoaW5lIGNoZWNrcyBh
cmUgYXN5bmMgYW5kIGRvIG5vdCBzZXQgdGhpcyBiaXQpLg0KDQotVG9ueQ0K
