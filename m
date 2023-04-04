Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903BF6D5BE1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 11:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbjDDJ1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 05:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjDDJ1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 05:27:11 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D686F1BD0;
        Tue,  4 Apr 2023 02:27:10 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3347L5qb013793;
        Tue, 4 Apr 2023 05:26:47 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3pqrh57wsj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 05:26:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ua6NRznAkWeRMknpnE6Xm1pdVysV69i5u809o6LIOHzrfXhasXYieDzTQsUUSwedUw7vCXZYT/EMR4IgoComQmS3oL0HZBuzR5OP8nN7Lwac1OciQh4dbD+X6nYuMUa+fU1BYPHgdh+btO2V3GK7n5zw9frzrCDPi+OsnGFh1YIHA+LAH4IP9u38DZJ+fLQPgg/12bAQzKi56Asyu2KWx409fLJkbgSIOhQTUSSTwVxlHxg/yUjNR1LucbNpeFJxzcVUpsaZPyS7FP1NqhT+E8njLxQSG/MG43zyEyQ1PwlS6AhcMfv/fDxXM1uzQ5LC/aP/5TaZNrYcWMqOG8gzBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SToMsgbUaAfauTaHAQLUzCbw6HJhDn6bz6AxV8rIlhA=;
 b=V/5V8L7EevhthJUBpa8kie1OxFHJzkE5F0ps1ZT6ek+Pnw3qIYbaAvRNyoxMHmwU1nfmXWzkyXvISGnpN8ATevqEt+f+X+dXinwdFanNcM+2cbPCFcBZABEG83IGkqIzCPGzZnE9D2WYvPycElMROl3M6xkr/bVxg7XS5C98HD3WQQ8pn4rb3yhaX/ObXFjsVyl6pBJ508D3gIKRbEJh2OvOvXx75URwdtLBr/GxOqa2PU7SUBF9/gB1nCvPti6KRkGXTA5S4wvNs+WsRkA4Wt8VwkKo23w9uhlaDB3K/+OqrT9KckU7QbLZ1z/eKXgeSewW/X0nqZhzo2bLoJ22Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SToMsgbUaAfauTaHAQLUzCbw6HJhDn6bz6AxV8rIlhA=;
 b=I/tr0fVHaqX07ftsTGYNN6BfsWEdeB/U3FSbvyWi74wybqpj8vGb7uhwUZe5+OxAwMl6+D6G6Z9apYi3fh/KAjYXDkPXlGIfwgOtlTKVMnlSnxMsNrXuolyfVhjL7NhbRCYFc69YJAyuqLqHeHjWZcwQFN53YzwShZJ9uibF4ss=
Received: from CY4PR03MB2488.namprd03.prod.outlook.com (2603:10b6:903:39::12)
 by SA2PR03MB5673.namprd03.prod.outlook.com (2603:10b6:806:fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 09:26:45 +0000
Received: from CY4PR03MB2488.namprd03.prod.outlook.com
 ([fe80::3ebb:ede8:1ce9:2528]) by CY4PR03MB2488.namprd03.prod.outlook.com
 ([fe80::3ebb:ede8:1ce9:2528%6]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 09:26:43 +0000
From:   "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Arslanbenzer, Zeynep" <Zeynep.Arslanbenzer@analog.com>
Subject: RE: [PATCH v5 2/2] dt-bindings: rtc: add max313xx RTCs
Thread-Topic: [PATCH v5 2/2] dt-bindings: rtc: add max313xx RTCs
Thread-Index: AQHZZkM1/0NcmmhHVE+7c9BLHmZIxK8arcoAgAAOpACAACNY0A==
Date:   Tue, 4 Apr 2023 09:26:42 +0000
Message-ID: <CY4PR03MB2488DFC99C23ADE16FF40E2F96939@CY4PR03MB2488.namprd03.prod.outlook.com>
References: <20230403154342.3108-1-Ibrahim.Tilki@analog.com>
 <20230403154342.3108-3-Ibrahim.Tilki@analog.com>
 <dd6f0842-519f-1bc9-f7f5-459863dc3dcd@linaro.org>
 <202304040710049c9cc01a@mail.local>
In-Reply-To: <202304040710049c9cc01a@mail.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcaWJyYWhpbS50?=
 =?us-ascii?Q?aWxraVxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUt?=
 =?us-ascii?Q?NmI4NGJhMjllMzViXG1zZ3NcbXNnLWNkMDg1ODI2LWQyY2EtMTFlZC04ZTgw?=
 =?us-ascii?Q?LTdjYjI3ZDcyMzFhYlxhbWUtdGVzdFxjZDA4NTgyNy1kMmNhLTExZWQtOGU4?=
 =?us-ascii?Q?MC03Y2IyN2Q3MjMxYWJib2R5LnR4dCIgc3o9IjM5OTAiIHQ9IjEzMzI1MDc0?=
 =?us-ascii?Q?MDAwMDI2NjI5NyIgaD0icm54Y2c4T1NEV2VoUFBQZnZlbnZIblNYTlI0PSIg?=
 =?us-ascii?Q?aWQ9IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFB?=
 =?us-ascii?Q?RW9DQUFBNUdNYVAxMmJaQVhvZlkxSUlQWm8rZWg5alVnZzltajREQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUhBQUFBRGFBUUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUVBQVFBQkFBQUFRZGlrNVFBQUFBQUFBQUFBQUFBQUFKNEFBQUJo?=
 =?us-ascii?Q?QUdRQWFRQmZBSE1BWlFCakFIVUFjZ0JsQUY4QWNBQnlBRzhBYWdCbEFHTUFk?=
 =?us-ascii?Q?QUJ6QUY4QVpnQmhBR3dBY3dCbEFGOEFaZ0J2QUhNQWFRQjBBR2tBZGdCbEFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHRUFaQUJwQUY4QWN3QmxB?=
 =?us-ascii?Q?R01BZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpR?=
 =?us-ascii?Q?QnlBREVBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFB?=
 =?us-ascii?Q?QUFDQUFBQUFBQ2VBQUFBWVFCa0FHa0FYd0J6QUdVQVl3QjFBSElBWlFCZkFI?=
 =?us-ascii?Q?QUFjZ0J2QUdvQVpRQmpBSFFBY3dCZkFIUUFhUUJsQUhJQU1nQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUE9PSIv?=
 =?us-ascii?Q?PjwvbWV0YT4=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB2488:EE_|SA2PR03MB5673:EE_
x-ms-office365-filtering-correlation-id: a4992c05-db9d-4a95-d697-08db34eeb3d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EWptV5rRtCfODyhUbFPhxD9sMCU7lZq1YWt6xErg9Cddmom97jcYSBtrgLRyZQzmdZIcshl+sbOA4lwOqR95rm3wCQYof4YwfJ/F1h8mBO5lpC/N9kJhTuhKGfVJDzDvtkabWdqtxtTC5rRH220UYRybC7dYfyHd7dbRNAfi7FX/IxtLpDmaHnT51rKyZKX+eA9e34yGPhw275tGIXvH3+r/B90BGtR5lR7yIUOYirIlLoNr7q1utclrk5Y2DRUDT3JzHQkWzW0HlqJcAuo3eAqlCxxlFwhSwOssyXLVKHuLwxRAfBL83dR9YGV+iv4T/719EuoWmR1wGVtxvR4p2VDbsfD7hmGNlSVUTAZaPxsoZ8NRQrM8gSo3lhcEyYp/nW4FcmqRm2SZ1zoPN5HGOiZXa6QF4OqjAV5D3svwb5eTqJnO8IRIRSj1SjxUJU5v2SzPZU8onVvOjVupiUBdLhxChwsamqAjQf6NpfH2BkBzoPWWgIqHFRwv1fv8arW2FQ0wnXtHd6mlXC/cGQsztUd1cOKWN5JPpZX1MuWNOhWoqwn6JShmeFMZpeo7/6+FTePsaejALIU0x+ZdIHdloj/M32+nO4t10GG9ZoJThLopUQPa+8KK01EDGn3jIHNsxF/yVHoXzeg1SQej64Pq9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB2488.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(451199021)(86362001)(38070700005)(33656002)(2906002)(966005)(7696005)(55016003)(71200400001)(53546011)(83380400001)(186003)(26005)(6506007)(107886003)(9686003)(8676002)(4326008)(66446008)(76116006)(316002)(478600001)(66556008)(66946007)(64756008)(66476007)(7416002)(41300700001)(38100700002)(122000001)(5660300002)(54906003)(110136005)(8936002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Zx/px/7/jXsK1ui8DTLGSmLuvnH9ia2h+YlWOvlJ9Qlp4BG3fMGgGrBVxO15?=
 =?us-ascii?Q?LqKLHT0PeJU7ABqUbN9LeXbTknA10tF4J5DABamWs+ZR47Sbr1rOqBbR2T4K?=
 =?us-ascii?Q?tLL55u91vnP640/UL79ouQ7LRzlrq8HTSvjRD92F+l+NRTG1IhwwvDpHqz2N?=
 =?us-ascii?Q?7BnzEAIDE1n8YqAV78Sjwn2RkQZV+F1un5Cc21Xnkw0zESlBfPLRZDIyF6Pb?=
 =?us-ascii?Q?CMRTryzDq4+ui0AD0bpXoZxiJUzzCkuOPomBii196LN5Rs8CNF7VO6Sj12BF?=
 =?us-ascii?Q?wTdNiCOHgV1cYjqjbCUBMVEtgiNVN3abC0v+uZc8Kt27ily2IBe0zddO6EbG?=
 =?us-ascii?Q?jVYXv6ZLwiajJkoPQQ0lMRmkdjt8IEx2vK+l4R9sT4W2zsoEeD0sXl6z+LBP?=
 =?us-ascii?Q?iIfcHHjHAIWSyxLJ+UkqPpsFGTsQ3HbQCz9Org+B37UBGBjNjXE6CgYW8i4F?=
 =?us-ascii?Q?i591rinzqE1KKXDIaIPTHHjWKOFCNnVhgFNr8GOfTR5UcSyoN+/cDk0HxCXh?=
 =?us-ascii?Q?cHBgt/udOCukpfNYNPRS0N/IkWbuSrsBAlauaUkr4lrjicus+DzXpiOC+equ?=
 =?us-ascii?Q?sXMnvZfYmaAKHa4QF6SiCq5vJ7do/WB3IVo/mRRpwvBS+XsqRVc1D+TYNwYC?=
 =?us-ascii?Q?VqSsY+Jq70agESjD+ZdqzQ4PG6ZIGxuXaH2x1uXZgI4uVMbxYD9RmM1JmnTF?=
 =?us-ascii?Q?IobQJUdHCln7/31wCWDZi1nrpVdAkg4AFOG7RDZClN+MI3EdJ8p7rwyAgUmV?=
 =?us-ascii?Q?wuUI+NrgmMjLvuqBvpYYmrEV9VdK5v0nX3rKHuHC4qaTOzCCkoLRgjICyuhY?=
 =?us-ascii?Q?FYEe6QU3hZ0ZmgGS0nZm092v7WNlTmj5FRU87Ysoikr8jaPHV7AD67gVQ1gC?=
 =?us-ascii?Q?twX/3lXQXGFWeyMYi7FkSVzHYYY3LWMi0/xxIzSZDS04KYwBdPyn4lNJWn/N?=
 =?us-ascii?Q?3zRGl8aVF2D//CnClyLPnug/Ee5VqWmqguVFew8arffBgWwi9CS3wW0+WYDm?=
 =?us-ascii?Q?e8KMPh5WNiSRIoOhAZ6OiuuWsTtbMXDGw50nr82qN2PSvQS3ov5SSeFNQwYo?=
 =?us-ascii?Q?N6Ls9oEjCsek5Ya6a/gC3Y4s4Mc1bojOs3tyPC+EnY/8iXj51RIfJIA9f5pw?=
 =?us-ascii?Q?JNcNvW/ePKvec2Mhh2tb59PmifywypAwZoa5UgFX/8J9OXcFZv8zn3UdWx4U?=
 =?us-ascii?Q?UagZOOErHKQer6pq7UmzXYd70T1Kf+6e/X28HO0MKkDbFX16mEv2b7qQCRAn?=
 =?us-ascii?Q?tSphnXXfZj6kL3j1e8YUPm8rT+dlpA6Md/SlH0CdrCbC56OR2d32iiPZo7Yh?=
 =?us-ascii?Q?J4mjX7yMBflnZ3GS1SVEuXgPrK0EnentDpDOXhk2+Ks2XZVRpmXIUWB2DeWb?=
 =?us-ascii?Q?xDx7ktndeXLq/R8DDFS/7cTn3q32n2y+JfEgU1y1jJ1davjtbUbTMA7wAUqC?=
 =?us-ascii?Q?zTMWBtXCOu93aDvgXpLcmPIcTnX98hNViyQJiws61EcDb+IzVpcQtmcZm4M2?=
 =?us-ascii?Q?4EBunSQsMMpRrQnMN3fhLnvm5y1BE9vvPt9T4Ci0qSDCFufqCdD5NEEAFUxk?=
 =?us-ascii?Q?i0UPNn+gm20KcvGPn9Pbgfbi+nSdCFQiVaJIA9fM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB2488.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4992c05-db9d-4a95-d697-08db34eeb3d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 09:26:42.6544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cXOcvD+dVBdiHVD2sBh0o9RSMEPB1y0j4ZL47EFSw8wThfiB/mTygbk00eLeR4ItLMTnq+IpVXcBJ2K5e5W38byS9ftECxK0J6LrhijrUZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5673
X-Proofpoint-ORIG-GUID: H0i_AjytFGDd1czqE4uf09c1uK-Mc0Lf
X-Proofpoint-GUID: H0i_AjytFGDd1czqE4uf09c1uK-Mc0Lf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_02,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1011 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304040087
X-Spam-Status: No, score=-0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 04/04/2023 08:17:40+0200, Krzysztof Kozlowski wrote:
> > On 03/04/2023 17:43, Ibrahim Tilki wrote:
> > > Devicetree binding documentation for Analog Devices MAX313XX RTCs
> > >=20
> > > Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> > > Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> > > ---
> > > .../devicetree/bindings/rtc/adi,max313xx.yaml | 144 +++++++++++++++++=
+
> > > 1 file changed, 144 insertions(+)
> > > create mode 100644 Documentation/devicetree/bindings/rtc/adi,max313xx=
.yaml
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/rtc/adi,max313xx.yaml =
\
> > > b/Documentation/devicetree/bindings/rtc/adi,max313xx.yaml new file mo=
de 100644
> > > index 000000000..0c17a395e
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/rtc/adi,max313xx.yaml
> > > @@ -0,0 +1,144 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +# Copyright 2022 Analog Devices Inc.
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/rtc/adi,max313xx.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Analog Devices MAX313XX series I2C RTCs
> > > +
> > > +maintainers:
> > > +  - Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> > > +  - Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> > > +
> > > +description: Analog Devices MAX313XX series I2C RTCs.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - adi,max31328
> > > +      - adi,max31329
> > > +      - adi,max31331
> > > +      - adi,max31334
> > > +      - adi,max31341
> > > +      - adi,max31342
> > > +      - adi,max31343
> > > +
> > > +  reg:
> > > +    description: I2C address of the RTC
> > > +    items:
> > > +      - enum: [0x68, 0x69]
> > > +
> > > +  interrupts:
> > > +    description: |
> >=20
> > Do not need '|'.
> >=20
> > > +      Alarm1 interrupt line of the RTC. Some of the RTCs have two in=
terrupt
> > > +      lines and alarm1 interrupt muxing depends on the clockin/clock=
out
> > > +      configuration.
> > > +    maxItems: 1
> > > +
> > > +  "#clock-cells":
> > > +    description: |
> >=20
> > Do not need '|'.
> >=20
> > > +      RTC can be used as a clock source through its clock output pin=
 when
> > > +      supplied.
> > > +    const: 0
> > > +
> > > +  clocks:
> > > +    description: |
> >=20
> > Do not need '|'.
> >=20
> > > +      RTC uses this clock for clock input when supplied. Clock has t=
o provide
> > > +      one of these four frequencies: 1Hz, 50Hz, 60Hz or 32.768kHz.
> > > +    maxItems: 1
> > > +
> > > +  aux-voltage-chargeable:
> > > +    enum: [0, 1, 2]
> > > +    description: |
> > > +      Enables trickle charger.
> > > +      0: Charger is disabled (default)
> > > +      1: Charger is enabled
> > > +      2: Charger is enabled with a diode
> >=20
> > 2 is not an allowed value. I asked to drop this property. It is coming
> > from rtc.yaml. I also do not understand "with a diode". So otherwise it
> > is charging with, I don't know, FET?
>=20
> No, what is not explained here (and maybe not unsterstood by the
> submitter) is that the RTC has an extra diode so, charging will always
> enable a diode, select a resistor and then have or not an extra diode.
> Figure2 of the MAX31329 datasheet is great.
>=20

That is exactly why I had "adi,trickle-diode-enable" property in previous p=
atch.
So if I can't have "adi,trickle-diode-enable" and can't add an additional v=
alue
to "aux-voltage-chargeable", I am not sure how to add support for the extra
diode at this point.

Best regards,
Ibrahim

> >=20
> > > +
> > > +  trickle-resistor-ohms:
> > > +    description: Selected resistor for trickle charger.
> > > +    enum: [3000, 6000, 11000]
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +
> > Best regards,
> > Krzysztof
> >
