Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5916C27FD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 03:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCUCTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 22:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjCUCTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 22:19:03 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Mar 2023 19:18:47 PDT
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com [216.71.158.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42CD37F1C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 19:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1679365128; x=1710901128;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FfzfVMbeMlSHuCkrwOInDMqlVQh20rgNqvkSmvP3LG4=;
  b=hP1TBUQ9i5weBMigRb0UCZPZIlWHnMDAgOoMD8zjnHQ+wiqmQuLRvBnW
   M+jyzgf3EHRJXrBJhbSj4693I+h43rEQ8Xt4UKEOi2O+h9ILo2+sEj6Tp
   fimb4tzksJsiC5Sf0r7lwpK9Pbu4N/CGLQYn1O/dqVRbXGYZyr166hlN3
   EMPL6CZkHE269oXm4cwrUo3czPNix8KAd1hAOKW4PJX+3UOM7Pj7jVRmA
   3VxqSfTfXG9CsUcw5zr7PK2SJibwDkMwhkU93+T70AIM2hDSwDvZal2De
   7K8Ds34lqpDBqDcwrHTrpSinnPqXZ2RN3GpgBhRCC5AFTauo809ozcaBD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="79659361"
X-IronPort-AV: E=Sophos;i="5.98,277,1673881200"; 
   d="scan'208";a="79659361"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 11:17:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDBkmFRfS+j7JEJGXLh/B0o7BacTBGMJdXnFpX+IF6CVkCQ00vmtLt2W1Hp4yxr/NSgg1Gz6Q0S+tBUb+TU7k0sDSzSJNiOnFbI+d2vR0pAj3+3mu5Y3DfdvyQTjzSFXc6/YvYdQVy3hshudZXE6ygmwGfFW+9tgrbZDC8LGQk1Yj3GtoL1t9MQVaWS8esPUZrYGqY/jX5RkZitAfpz6By0aXSLKihD1K/FcB3MTSjJTxLd+foYBz64laBzehLlILGUI06zT7iAiBfhzWb1iEvrtuxLxZ2HjCaJ0ox+KahVXqQi4IyQRH6LbFyBGC3j4/xlxMIrz77OXvZHdkTeCXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfzfVMbeMlSHuCkrwOInDMqlVQh20rgNqvkSmvP3LG4=;
 b=AA27qoDM/O+2eNiiRKakA06QaEM9FF4sA85lslUyQTfH+thgTSzR27ELdPQ2+9wcv0dHNC1tzK1c+NW7Y9q+0ZLN3Qc65iyo92hmAzh8wSptSrbW3mkF42YT3p9uM4tNmNUGEaEIbARFhoAYsmER+ILqn0j3k0UJ7IWNzfAp7S2gZF9NujoYvGeiz8tZ8hj2PcWrl4Bty6xM7/LpoULqxs4UyeWCmbmK9bVMFZM2NDeOOC0eZhMJPa65eRK65ggZRWFJ29BnXTxMSLn6N3OW0iSYIIbml+qt+UVLAXBWqJtoXmL2LS0R25qoPPfYP3Vh+taKAdx9A36v2Zdcz4cnoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by OS7PR01MB11901.jpnprd01.prod.outlook.com
 (2603:1096:604:236::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 02:17:37 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::777c:ddcc:cdd0:7ec2]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::777c:ddcc:cdd0:7ec2%8]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 02:17:37 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvdimm: nvdimm_bus_register: Avoid adding device to the
 unregistered bus
Thread-Topic: [PATCH] nvdimm: nvdimm_bus_register: Avoid adding device to the
 unregistered bus
Thread-Index: AQHZV+LVN1DLpX/+y0yTP+b0+z/XPa79j4OAgACkEICAAEgHgIAEddSAgAECAACAAJNlgA==
Date:   Tue, 21 Mar 2023 02:17:36 +0000
Message-ID: <cfa1a053-b99b-c22e-b80c-4b92f5f4e225@fujitsu.com>
References: <1678955931-2-1-git-send-email-lizhijian@fujitsu.com>
 <64133bcbbe368_269929415@dwillia2-xfh.jf.intel.com.notmuch>
 <ca55bea9-d2a8-ccce-010e-a26f6003a059@fujitsu.com>
 <641401d75d039_1dee294a1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <eae85bab-cdb6-b8b3-8014-2e7f3916bfe2@fujitsu.com>
 <6418981ac577c_1dee2948f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To: <6418981ac577c_1dee2948f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|OS7PR01MB11901:EE_
x-ms-office365-filtering-correlation-id: 87e55808-8ecc-4010-53c6-08db29b27051
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YTwqbedUlf7z6BZiw1DjCzDR0by9o+kqffyToS4NkmwT7OzmF4ipU29cIDNmeX/HnYSRVoA1/w4mbtjsONyu5Ga4zxrD57Rqt93ewmwBzuF73o9qinfYFfaVhSLnP4n9VOZ/X6xfJIyFwGO9izTtU7KvM4adh6U2/wGOF+EI49pvtLv/X67OZalC1wrLB3iC2YZ7/Ohc+Wy9YeyUZ+9ozEvVUVuWifpFcJzcQp/7O7dQCcC3lt1nCacCZ3u2H127lBKwnbF51EhrSdrbfLnyry7JNF4p7xaoI+pv16UnOjwknkPblh3M3v3XzmXQ1v8WxX9WiGsBk0IyCqVQ54ZoyfyB0KkwaGt9aTYciaAo8DBtUMOoCanh0DHOnsVFcRCbpB4/lDwQqnXbIlbOT/GMGHeGeKByHJPePe7p6KpqA+IMTK2dTxg+VdV8cQd6xQdN6IDj3m2HwEDtDNuPU81krBDMP+rBYeT3iSCUQEwHM1gD5q79HKSI5ZkjnuwydCd3NU5zfX+/+k5FT+OQI8IOVZm8WTJzQjzU6UtP8BRaGMLB5sFlSE6EEgLx7g1WSWGfkIJYxZ2rM/MvR321ZYF2oORwTcGuSwUMdSA5a1ZLG8yCezmCgcUebHbGVaCCepntptjlJG6OjipG2lMT/FXEL/3OqR3usEL47Nxj9HqFOL1zF7DQBGtkrDRSiohdT0R78+YDpd1fP6QWhsB1G6ZdYGKXnNIDBkrhouqgk21xd/cFAfU6o+DrvZoeXZSNPBUtjzjqJpbEThjdcCxp357EFVGbZidliEMlXORlE8L90e8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199018)(1590799015)(8936002)(41300700001)(5660300002)(1580799012)(85182001)(86362001)(38070700005)(31696002)(122000001)(38100700002)(82960400001)(36756003)(2906002)(4326008)(6486002)(83380400001)(478600001)(71200400001)(2616005)(186003)(31686004)(26005)(6506007)(6512007)(53546011)(110136005)(316002)(8676002)(91956017)(76116006)(66946007)(64756008)(66476007)(66446008)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzMydklacmI4aHVlNkRSc2x1c2hkUVc1MUZGaEtQRlh2NE1xb0hYRWxRYklv?=
 =?utf-8?B?aUwwcTJNQWsxNGNtYmNOQy9YTUZ4MHNvLzZJUmxIVDJ3NmJoeVZsRWRjT1k2?=
 =?utf-8?B?aTIwUktWaEs4YlNDOS9hWkNXd05NYnhhVE00aEI2amNtUWI3Yyt5cWVRNDN5?=
 =?utf-8?B?dDZCTlJJMkUwWi80Rm1kMjRUSjB0cU1jNUNBc2c4R1FST05Pb3FyK0ZnRFZC?=
 =?utf-8?B?cHBxeEVMMWtta1QrbjBsbHp3ZHQyMkxoYzlZZ1BXOU0rYU1xekxYVTBxVzNH?=
 =?utf-8?B?RWFpMHllQnJRN1hUbXJGS3pTRDVzd1l1aGlWUE96eW1VUTkzMGQwOHI1K1FB?=
 =?utf-8?B?eER3WGJoQlRyMHFsdkgwbUJ3UjNXSTBtT1BQZmtUWVFnTUJTTnkyaW5YRGdM?=
 =?utf-8?B?dElvcmI3bGVxNjRMOHl0QTlaVnB5NGdnMDRkb0xJMmtzcmxMeUxwVmRhTGNq?=
 =?utf-8?B?c28xMmFYcXorNlMreVhibEJETDhsQ2dlNXhiK2tURmFGRS8yYmJwQ0wvSEdQ?=
 =?utf-8?B?alg1R2VVV0VjK2hUa0R5OEdsbEIza3Ruek93THh5WUNqNlJjRjNsK04rSlpI?=
 =?utf-8?B?L2VXWmZnY054YnZic2tjVWM5M0wyTTJOOUFaekV0VGoyM3hZY2Z5VTBBdXg2?=
 =?utf-8?B?QVZOa2RqTXlwQmhWeHlGUk1KMUtBWlc5YTdMeXB3ZmhwS2lXemliT3ROMEVn?=
 =?utf-8?B?dUw5TUdOWXZFOVdheGlEUXJKOThaZGMxWEMrNS81SWtRVjBidXd1TFFNY3Ux?=
 =?utf-8?B?TC8rVlpFSmEzY2wxMHZNTDBsQU1iRlQybUJaWU56cFFPWjNYc2tWRGJYTXpJ?=
 =?utf-8?B?cE9NSTU3Sk1RMndlK2x5NFJFSjV2KzZLdW1HeTZ2bzFtd3hwNFRQS2Z4b2p1?=
 =?utf-8?B?dGZEYVU5eTY0L2ZRUCtIYXhSUWszWnRMWDdoTHBRWDFERHBQUDRmSWRCRVY0?=
 =?utf-8?B?ZFIxallqNVZydERWWUMvNHVHaW5PRHJaejJrTlc4RFVTNllob01CMDRkVmha?=
 =?utf-8?B?RWxWUWl5d0w3bWljU2VqQkFaQUphQzFheDF1aGQ4NktaTS9TaDdDSGJyaEVS?=
 =?utf-8?B?SFRpZEhOekJYUXZacjRRZmhVWWxaODZJUDlBVFVJWFJJQXpjS1QwdEdSYUtE?=
 =?utf-8?B?ZHFqOWRHVWRkdlFzUS9DNjdpZFlWc3RlN2YyZ3l5SjdkMjNXTUh5Rk9WOFAv?=
 =?utf-8?B?VHhYZzdqT1NvVkJKUi9jRDhXMkdHTHFrbDBuc0VtcVh3WXdlVnNIL1RXdHhq?=
 =?utf-8?B?N2NSNys3K3lEajFxcGZ1aEJNY3dvd2Y1UzhsWlRCQVZpa0VFOGd4YlRMSm5p?=
 =?utf-8?B?TlVrVlBQMnhoNnVrZ0lhQk50b0FmTzRDNXZvZkYrK0pMWWpuNTFFMVpob1Qy?=
 =?utf-8?B?WFZ1UG9FNDllTi85ak9qUUFLTWtVeGtlZHQweFpKN0JkS0VVQk5sL1k3M0pG?=
 =?utf-8?B?cHJUTUtjR2Z2UytsdGlNYnZWYmlsR2htTlhLL2g3WC9teDVZcmMzdHo3bUN5?=
 =?utf-8?B?cnYwVmtPNXJ1dkc3aUtidjRxbFNYSnFaSzdGMnk0ZXQwckp0cnRjNjc4WkI1?=
 =?utf-8?B?SWdJUHcvbW1SNENQVHhDRTI4UXB6NmVDZ0xmNk9jVDk4RFJTSTBWdU5QOG1I?=
 =?utf-8?B?MmFGM2tqTFdWRHc4YXR2emN3ZitJT3lYTFNnMDRJUDhjMGl0VG9Ha3dXU1po?=
 =?utf-8?B?SXJhODZwYlYwdVNBZ3FtODZNQzNlNzQxQTl5WGhHZnlJUDZXbStTWHdYeXFy?=
 =?utf-8?B?WUwwL1VWRHcyMDRKdDVGTks3UExIaWIyWUh3eTU5ZkFoMlVldUJnaVRmZWV6?=
 =?utf-8?B?TFkweE9sN1ZhNStha0plWi96R3Nsc0VHWi9hdW5hWEdHbko1QUJnUzJBMmZp?=
 =?utf-8?B?SUtaaHRwRVN1d0tlYmZLR2trUzZyaHNIRGg1N1o4VktqNVlzNUVZNHd3OXJT?=
 =?utf-8?B?R2xMblp5enJMQ2E5LzBLdU5RWURRcmtEZWFoamtndDIxQUxTZHdGeHM3M2pT?=
 =?utf-8?B?NUZaMkRaYmdjdVcxY0ppQThTTlhsQUFtZ2MyUmpRN2NSallhYlcwVHBwSjNx?=
 =?utf-8?B?clgrb2xXdGRoVHhaMHQzdzdhVEJGWjRVQ0NEYVZYeWhJVDIxNHBEbngycEFR?=
 =?utf-8?B?UENmMVlIclFjQ2lsdEN0Z0hmWjJNQitqVEk3S2g3WjRoWXh3RmlwbzhyUUJP?=
 =?utf-8?B?akE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69616E93D056BF44A964E2490E1A9680@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yBhG8dsjber8vYYyPlx28UvlRshYRdVKwAM+ux8Ca5e2bEjnDwpNHF2fW5YWYRZzq4A6fL4xgn03z6nJsR+GatqmIF8kp1FjbkPkrv8YJB3+/+AdNv2BeGlKnzxpImZtCC1E+hb8wUugZHAkQsTG30rQAELajnMCxE81fa9LbNllCLsvECIyFUn3otKA3OGj3WE7PHPn7Xu5muSSIFZp+v5LRo7T0rVUeBjBqSs2VAYfU+wmMNLOMO/MhUrfwGGrdFXq8Dq68khQUnMmv1Ns9HN134WqDyCJNslagD4YYf56Qar0V/7/gR9/jGKYq/bc36tzvFfswOYQ0GFQjGuAEzIf7KG6Xvm0VVAWxEDA9kdMvRa+nb4tFzZPPZej/EvkgHJFFVdWl8yu80fGko1JiuiY3Q83IauLppHCioFWLw22buhsx5rVkQgls8pB3+geXWrYnyfehUdX+IDslIyrgX3mhFBbcLCz12QEfCk7bI9UB/Blx5x1YMPHgVKmzwKjCFHdfqgAXGN5ej82/mg0jrUwNOIu+6uAf29sb/7zZMGekYXIxMCgG5xJ2+U2FGYWfkMSYEg78mk0kX8xDOki1UyAL+BLE56gRex8JK8S0L10PKjS4VPBOS9Xx4u6BDgGvGLLL+Zhf8mkSCSrHGZz8qohcgYJAjVqBsyRQG5KQP5uKxeyTXPzwFP0ipFYjMsW3RSKrrSf1jZ1UejUZuaqeRqJefMnB3ntGnSpMeKAf8WYjNDP3RGl6ECdBsHn0/Lk29FYdZ1yYspeL1oyxU59XlBX12RR2dxQJKAUVaarPwesPAaBJby1d2oZPqefWhG4VDho3HVJTrip8ONVhBSUhw==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e55808-8ecc-4010-53c6-08db29b27051
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 02:17:36.8040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qPDou9I6WBxZIu1m4qfFcTfop0/WuY65FGCRCCCx1v9ogStKPR/UYWlFFKI7nbZvo02CiUm+IYRzhlgeZPjfzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11901
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDIxLzAzLzIwMjMgMDE6MzAsIERhbiBXaWxsaWFtcyB3cm90ZToNCj4gbGl6aGlqaWFu
QGZ1aml0c3UuY29tIHdyb3RlOg0KPiBbLi5dDQo+Pj4+IERhbiwNCj4+Pj4NCj4+Pj4gQ29uZmln
dXJlIHRoZSBrY29uZmlnIHdpdGggQUNQSV9ORklUIFs9bV0gJiYgTElCTlZESU1NIFs9eV0sIGFu
ZCBhZGQgZXh0cmEga2VybmVsIGJvb3RpbmcgcGFyYW1ldGVyDQo+Pj4+ICdpbml0Y2FsbF9ibGFj
a2xpc3Q9bGlibnZkaW1tX2luaXQnLiBUaGVuIGtlcm5lbCBwYW5pYyENCj4+Pg0KPj4+IFRoYXQn
cyBleHBlY3RlZCB0aG91Z2gsDQo+Pg0KPj4gRG8geW91IG1lYW4gd2UganVzdCBrZWVwIGl0IGFz
IGl0IGlzLg0KPiANCj4gWWVzLg0KPiANCj4+DQo+Pg0KPj4+IHlvdSBjYW4ndCBibG9jayBsaWJu
dmRpbW1faW5pdCBhbmQgdGhlbiBleHBlY3QNCj4+PiBtb2R1bGVzIHRoYXQgbGluayB0byBsaWJu
dmRpbW0gdG8gd29yay4NCj4+IEFoLCB3ZSB3b3VsZCByYXRoZXIgc2VlIGl0ICp1bmFibGUgdG8g
d29yayogdGhhbiBwYW5pYywgaXNuJ3QgaXQuDQo+IA0KPiBUaGF0IHBhcnQgaXMgdHJ1ZSwgYnV0
IGNvbnNpZGVyIHRoZSBpbXBsaWNhdGlvbnMgb2YgYWRkaW5nIGVycm9yDQo+IGhhbmRsaW5nIHRv
IGFsbCBjb2RlIHRoYXQgY2FuIG5vIGxvbmdlciBkZXBlbmQgb24gaW5pdGNhbGwgb3JkZXJpbmcs
IG5vdA0KPiBqdXN0IGxpYm52ZGltbS4gVGhpcyB3b3VsZCBiZSBhIGxhcmdlIHBhcmFkaWdtIHNo
aWZ0Lg0KPiANCj4gTm93IEkgZG8gdGhpbmsgaXQgd291bGQgYmUgYSBnb29kIGlkZWEgdG8gZmFp
bCBkZXZpY2VfYWRkKCkgaWYgdGhlIGJ1cw0KPiBpcyBub3QgcmVnaXN0ZXJlZCwgYnV0IEkgKnRo
aW5rKiB0aGF0IGhhcHBlbnMgbm93IGFzIGEgcmVzdWx0IG9mOg0KPiANCj4gNTIyMWI4MmQ0NmYy
IGRyaXZlciBjb3JlOiBidXM6IGJ1c19hZGQvcHJvYmUvcmVtb3ZlX2RldmljZSgpIGNsZWFudXBz
DQo+IA0KPiAuLi5jYW4geW91IGRvdWJsZSBjaGVjayBpZiB5b3UgaGF2ZSB0aGF0IGNvbW1pdCBp
biB5b3VyIHRlc3RzPw0KDQpHcmVhdCwgcGFuaWMgaXMgZ29uZSBhZnRlciBpIHVwZ3JhZGVkIHRv
IHRoZSB1cHN0cmVhbSENCg0KDQo+IE5vdyBJIGRvIHRoaW5rIGl0IHdvdWxkIGJlIGEgZ29vZCBp
ZGVhIHRvIGZhaWwgZGV2aWNlX2FkZCgpIGlmIHRoZSBidXMNCj4gaXMgbm90IHJlZ2lzdGVyZWQs
DQoNCkJUVywgYmVsb3cgbGluZSAzNjk6IGRldmljZV9hZGQoKSBkaWRuJ3QgZmFpbCBpbiBwcmFj
dGljYWwuDQoNCiAgMzU0ICAgICAgICAgbXV0ZXhfaW5pdCgmbnZkaW1tX2J1cy0+cmVjb25maWdf
bXV0ZXgpOw0KICAzNTUgICAgICAgICBiYWRyYW5nZV9pbml0KCZudmRpbW1fYnVzLT5iYWRyYW5n
ZSk7DQogIDM1NiAgICAgICAgIG52ZGltbV9idXMtPm5kX2Rlc2MgPSBuZF9kZXNjOw0KICAzNTcg
ICAgICAgICBudmRpbW1fYnVzLT5kZXYucGFyZW50ID0gcGFyZW50Ow0KICAzNTggICAgICAgICBu
dmRpbW1fYnVzLT5kZXYudHlwZSA9ICZudmRpbW1fYnVzX2Rldl90eXBlOw0KICAzNTkgICAgICAg
ICBudmRpbW1fYnVzLT5kZXYuZ3JvdXBzID0gbmRfZGVzYy0+YXR0cl9ncm91cHM7DQogIDM2MCAg
ICAgICAgIG52ZGltbV9idXMtPmRldi5idXMgPSAmbnZkaW1tX2J1c190eXBlOw0KICAzNjEgICAg
ICAgICBudmRpbW1fYnVzLT5kZXYub2Zfbm9kZSA9IG5kX2Rlc2MtPm9mX25vZGU7DQogIDM2MiAg
ICAgICAgIGRldmljZV9pbml0aWFsaXplKCZudmRpbW1fYnVzLT5kZXYpOw0KICAzNjMgICAgICAg
ICBsb2NrZGVwX3NldF9jbGFzcygmbnZkaW1tX2J1cy0+ZGV2Lm11dGV4LCAmbnZkaW1tX2J1c19r
ZXkpOw0KICAzNjQgICAgICAgICBkZXZpY2Vfc2V0X3BtX25vdF9yZXF1aXJlZCgmbnZkaW1tX2J1
cy0+ZGV2KTsNCiAgMzY1ICAgICAgICAgcmMgPSBkZXZfc2V0X25hbWUoJm52ZGltbV9idXMtPmRl
diwgIm5kYnVzJWQiLCBudmRpbW1fYnVzLT5pZCk7DQogIDM2NiAgICAgICAgIGlmIChyYykNCiAg
MzY3ICAgICAgICAgICAgICAgICBnb3RvIGVycjsNCiAgMzY4DQogIDM2OSAgICAgICAgIHJjID0g
ZGV2aWNlX2FkZCgmbnZkaW1tX2J1cy0+ZGV2KTsNCiAgMzcwICAgICAgICAgZGV2X2VycigmbnZk
aW1tX2J1cy0+ZGV2LCAicmVnaXN0cmF0aW9uIGZhaWxlZDogJWRcbiIsIHJjKTsNCg0KVGhhbmtz
DQpaaGlqaWFu
