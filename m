Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB64F663181
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237678AbjAIUbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237426AbjAIUbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:31:16 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C91112742
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:31:15 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309K9XDV002348;
        Mon, 9 Jan 2023 20:30:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=3njPUGQ+pshlMi8uLQc1tpaNm4p3iA4Eaumf8ZOOE+0=;
 b=pxe9Iuzaxa7pow7iUsNE4lPVPbwNU1tXVK6VEcdwU829m0UuyXrdz/1QOaHdQysiEoHP
 g9Uz61rQ6a6KOy1HqgGOD7NeR3hwNWPUlBS+5zpDlNcqRuKYNGk2OGZcgk1FK7FeRKbS
 t/hqJjfPk/amR45zg5ekqA1MTFGptBsqBERhi0p0gusRyv4VQK27CjM35ayVBvsWz6f4
 6UURTCnl1TO4kOm4Ry8wgElXS0MI7MJ04I5dsC3smp3l3GSCdLVM1N7CfQqrFynA6r4Q
 MJikye4PUgz4Cr6on26Sj4dW+oJ7Fkz4DiOyuyt5EnCWeb9GFElH7VUezV6h8f2nGqSW lA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mydxmb1qr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 20:30:53 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 309JuqpV035347;
        Mon, 9 Jan 2023 20:30:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n0h8unp4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 20:30:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1xFUwMp5cfgEJZBsAdWofroSlYD2+TNMQCi0pabf0f0e7MtzP1XJYdzkmAUDuPg2PvDg5i9JyYci3bW67ZH8GF3l2ttExe2oWvuaetgG4ZIBGNhY3Lp6PZHIFO0D8R5lpf4d7OHEOXJhhludwWBwHywK/m7q6ROsxBM0yQ9IxxvROzJg6pCIoTe3pIOKy2dkv7oVebwH2ODt+WRGSV6LHJ+ltfU0ztyJGo9FQ65AzzJHn8I+CGD3t1cGx0VgJFtN4LYCrOk4dQ3HPGNt5rt7u+jZnEw4LrlxkfRTwWM1s+aRryuwVn+XN2tkDg0RVMwR07UjyXYRpxcLWMlncreiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3njPUGQ+pshlMi8uLQc1tpaNm4p3iA4Eaumf8ZOOE+0=;
 b=cDGnDk6eedrziqo7/hi/EHYSJMDWHdWahkgwZabFo2scNkqk6BRxj7VtnZF+uKcCUYYCoMMV6z0ISqemn8NMgljhtsWfdjfmxJh/zkadtrSX7bRgQVnkmV1/sBh0TkRu6iXOCiLNqVqFq3ylRLw2IOdrXXkNNamNRfmzSOUOxFZIjvQNM8809TxCka8jbESa0zgtboPSLuYdrcNGMMQbL8dWNdt7TcQt0dTSJsaxMm3lR6tXaUltyClM5fhCM7R6/dWMAAd9PJHWe8GakxUF7zR28xaNbdrnl1SQf8l1OZFXXsdfdX8079TlYo7KKvKfUc3O9IdbQzO/XXAonS/FqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3njPUGQ+pshlMi8uLQc1tpaNm4p3iA4Eaumf8ZOOE+0=;
 b=jGhhgHkgeCdm3X8djWhOATpN/Z5hr5BKlpWSTYtagd4T2DkK6KeIJVNJfpUaPajf+c8eVcBcp9Y395WTzHDiuX1BXODHC9tkV9aOTcT0q8R82Jx1yP205f8Nbsiju8QOSpayx3NUGGKOj6ouwq9Vm9sapE86xzYJiBKL4FJhslY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA3PR10MB6970.namprd10.prod.outlook.com (2603:10b6:806:315::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.10; Mon, 9 Jan
 2023 20:30:51 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Mon, 9 Jan 2023
 20:30:50 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     SeongJae Park <sj@kernel.org>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 22/44] mmap: Pass through vmi iterator to __split_vma()
Thread-Topic: [PATCH v2 22/44] mmap: Pass through vmi iterator to
 __split_vma()
Thread-Index: AQHZIToky9xKc85E+U28OcnfnQqIUK6SNXEAgAAKwACABBDvgIAALYiAgAARTQA=
Date:   Mon, 9 Jan 2023 20:30:50 +0000
Message-ID: <20230109203026.nqwhze2d5y62z4tf@revolver>
References: <20230109164533.3qkorup75h3zsi7t@revolver>
 <20230109192831.61258-1-sj@kernel.org>
In-Reply-To: <20230109192831.61258-1-sj@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SA3PR10MB6970:EE_
x-ms-office365-filtering-correlation-id: 1d8e6b63-91fd-40df-1825-08daf280661f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5cin/xEkj3rzrxGw+cPN9U2/sfKQe25IyLg9KTAGyZKr754eSpCXGAvPOKeOUw6UtJGNWFK9rNNBoOjQZd5rdLploT8gnf6AhKxiCOY/x3LVrZR6BJjVqxEvXCdXmgEXs5Sk6jRzFWx7XwCnRw79EdhFTnKG0xuf3yErjrkOnRObRe86Ydujmbc3QvGA2uGK9omMmWd9VCW7UuLlDSTIPBjWzE8bcbwKw3atr0nNIbPLw9ZWup0SNPuuRQxM0ZNAoxB+YWnXl93nc7QbrVeiBl2UiQNmfNbdqoNywjZD7aTKQXdqEqS1vcWThORbhxsa5XlNbWBYcIKdnHfbQIbqEv4LO6hr+Za8GnXsI8cZ6cS27Y/n9g/Sq3rDVst8iLYZI3ycMWqlZ0ewruG21hVUcpihBqrdqSvBU0FM0rfBRHrMx+wSlQ9zMAVuEVQ4OILYVIn0NeyaHiFrcISbOJ9Hb4IEf0vCeLHIOJojHJxqAB7kb4MPDVgYt4M03gbDGS2JP1NF//VRMUru2WU/upt0QDRhifnXY8NY55u2QzKjxlYsbfAZMlK/Yq2UCRmahLrg/8DDgSI8OIXfPTy48YrTw6E6VX/0l4gRo3bEeFLNISKIO0M4+8PcXM1Au/D+A5IZTxgh+LDPDfp6W23S0WXlycEXnb2+CXplBis3PmrOlK7ouxESmVSVUKT3am9oLZWXjQKgR9nh2A7G4c35JRfLBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199015)(38100700002)(122000001)(83380400001)(6916009)(38070700005)(86362001)(91956017)(76116006)(66446008)(66476007)(64756008)(8676002)(41300700001)(66556008)(4326008)(66946007)(54906003)(316002)(44832011)(2906002)(5660300002)(8936002)(6512007)(1076003)(33716001)(9686003)(71200400001)(26005)(186003)(6506007)(6486002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDJ3K3BydUcreE5ndi9TUW9vTmtLZG1PVGNuT2R1Y3VDMHJaS2xSQWhZTnRF?=
 =?utf-8?B?NjRyeUtBb2xGOGJta0gvZFk3VFZvOTYzZC9YOCtXT0hhbnI3RTFUaEZZTzlj?=
 =?utf-8?B?VGdvZFZ5aE83dkw4Y21QMmhuWUE4cnBmTzI5WkZWVWRKa25XV2lPUzNpWTVy?=
 =?utf-8?B?Qll0L2pyREpWeFg2azhmOW9yNUc1dEtHZmxZUVFmYmVSUVI4bXFjNTZMcU1u?=
 =?utf-8?B?aE1wRmRubUhDcndHVkVRNVFoTmpZZUZVT2NDNms0OEN2Q0EzVk5qUE4rWG5P?=
 =?utf-8?B?dXRKMDcySTBjUlR0WE9jQlFuTEdoWmliZEM0aUtMWE50VkRKZTI4SUo0NHdO?=
 =?utf-8?B?Y2lQMGNzVG5heE5EOSt6Y1FSc3VrT3M0QUVuSWR1YU5ma1UzeE11dEJ0aTd3?=
 =?utf-8?B?Qmw3aTFQZ2NzS0ZFNEJiNjZORWc0Vll1YzNSU1I2ZFp2NnZEUU5nV1F0bWdt?=
 =?utf-8?B?VWlQTGdQSHhYbVFnc0xxYStYZWN0cHJkb1NBUkZqQWZ3aS81N1VMeTVoWEJD?=
 =?utf-8?B?d0FmaXEyOENOc1I5ZW1uL2x5U3lMYnFOUHYxajNzTW1IWFJlRUswa2tLR0NV?=
 =?utf-8?B?Q2ZLajFoWmJ2cFVPdXdUK0NjbEYyU2JDbll0a3VGNUZReXdmNS9ENFArMTdM?=
 =?utf-8?B?SERHNWluc2hHb0lzYlB2WTd5YWJNY2hXQ0FUcVNEVDVKOU5zbG44OTZ3NXR1?=
 =?utf-8?B?VlVzeUlaVlFnQnZvSURaZGUvL0NIU2MzQkdyYVNrcXBnQnlEMlVLRGozMXQz?=
 =?utf-8?B?eGM3QXJnaVEzdXFEVnRjZUFEQmhJQnBuOGRHMXhmczFvTVZIYlJCVEMxbzJI?=
 =?utf-8?B?ZHNVenpud3Z0c21iYUI1KzlWV2M5bGxJM2dZRVcxcUlqNTEyUXNDUUhUUEtl?=
 =?utf-8?B?Qy9pbFhGTjErRlNoNVRuN0hnempVT3AwTHRab1RzcUozL3cyRVFxekR5L0VC?=
 =?utf-8?B?VXBMa1JBYjgySVVMTUxLd1JVbmZhSHpFajFZcmRUUFRoaGRBNXZkRWN4UG1v?=
 =?utf-8?B?MHpicnBtVCtCaWRXUXFqcGlha1FJd0xvc2cvUjZYcjNDYXJRWXM1cDFta0Q2?=
 =?utf-8?B?dXlVczJhYjNrKzltV2pWZC9TRUdQbzlLcUFVQi80bUNCNjJYcDdmTmV3OStK?=
 =?utf-8?B?QjVYZE9xcTYxNEI5T0M3d2YraUFPUGtaUzlOdWVneGIrY0VlWWZJbldVNWpn?=
 =?utf-8?B?d0NEZkdOK3VXaHNPOENveU5ZUStIRkxtWXpON21HOXhldXRLbHpGUlBtUVM2?=
 =?utf-8?B?V1hSTmVYYzlVZW84WFFENldVc3NLanNUVWpPZFJEdkxvZmVtN1RINnlWaFBs?=
 =?utf-8?B?bFIzdWZHdk5wL3FoU21KQ0dlNEkyRHA0N0J2Vm9VUjYxV2ZsQi90cnBtRHBt?=
 =?utf-8?B?Z0pUakN0MFNIa1dRQ2lsR0MzVWpLNk5BZ1c4akVlb01hWHRwclc1RFc2dnph?=
 =?utf-8?B?TzRVeHgzM1hERWlCM3NkV3YzenFUc3JJY0FRRlBmRVZnOTNqaVkxa3F5ZVNM?=
 =?utf-8?B?RGM0OHRzc2ZUR3BsclhDVnVkQ0lpR3VtRUNER1RqNHNUNmxBSE5DQnA1d29y?=
 =?utf-8?B?WVZqVWlRMFlXSFZYL1gzdHFlbXhYdWRDYy9zOUlONWRUa3Vib25mQmdsTlNm?=
 =?utf-8?B?dkJkNUpVYnMwbkN2eU9oOTMzRnNkQWVqV0k1Z3BSUTJNai9OdHJlb0hDa2lD?=
 =?utf-8?B?cTNTQ3ZkTUVOODRiRDYwMTdhZEZsQmM5UnFQY0NyWDJVemFlbWdXZkxxYXls?=
 =?utf-8?B?R2JvM2pWM1ljdkxDeFVtUmUwV1RrUFRINUZWYnk1ZVlTeTgydEpRNmF3Z0lO?=
 =?utf-8?B?WlU5SDlOc2VIRENRbEZ5K0d1NU9XZGhsbEZnYU1OR0owK2RGbU9HZFNEbUFt?=
 =?utf-8?B?Y3p1M3dFNzRSZEV6bHRtc1RNNFhmdWFSMmtpajJyZnJCSDI5Q2NmSUZQT3F1?=
 =?utf-8?B?N1FZRTdXMmRVMDFNU0FCYjVOMGJBSnlWNG5VU1NmTEcreUJUR2VXd2F6bnht?=
 =?utf-8?B?bk1VeFFLOEVtNmJGN05Bc0NTaWY2S0xKWmJwNHBiSjZqQUdhdUU2RUxPeS8x?=
 =?utf-8?B?MkIrMkRsSkNlWjJJZG5CNkZLV3BHMCttOUNudmdwdXhHNnVlNjJEL2Z6VS9H?=
 =?utf-8?B?YkI3RjlUOHQwTlZKUVUyWkNsSzVpVGdwU2xLTFNid2FlM1dLNG9XVGdKU1BC?=
 =?utf-8?B?U1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AAAB719F732D5E4F9E7848110B77FEEB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EF7V3f3DwjMpg9IAIA7hqElqqb+VOXuHlJ4RWJwI60lP/2SZcUgQXdZwb+q/1uP0YP6dX37+mP5046XgkuSfjXVGSIqDxkdTROPOAOUtNQyX7vKlOWp1FwuPQV4abuLsdSACPreEURS849qC/2HUlGK9bcLYg5TxRh5T1X/ljsgiOsDEvxAVmqUqTLq4k4mLHb8agPDAQMhdkqD0UpBVvTrbLEwg52iSVTnDLc1Op2p1KCHLY3L7h0mDsZznFZ6iS0wYeLsTSfj+Wy5tf1ZgQiowbKxrnvO2VnfPJv++gIeKpo7ygoIbKw5g0Fcpkv0/wz7L2GQp+8t2HPYp57+x5Y9I18j0E8n4RHoYMRXw5FyHIibz2KB8knEX3UJ0T0QmHMwbfQi2VarN1N4hgZylO4pcHmb3+uNP16aUkbXFfKj5hasTeRiK2Bsk8PeNOXkbuyv16F8NVYvJ5vXm71IpDKA6AXngtxlf3ETq7/QyP7E/Q+wddSI6M+TsN1u9I7ThgtItxMYEHDMynUrTZaK7Tq6Bz9m/DCN5QOp6MFyJ1DxFPRW29a73u+JQLUjBpp4jux4cnxyEmCJBcmDSUqOZZ7DdKSzXIAaVhdLvCIzcRjD7RaHnhCFNx2yQQNK9SV3wC8CqdwLAkd1c/XSvTm+vwmfr7545ZsjEfcE10KnhyWjlZQmMbIdk5u42mrXrVMgqv5E5uGcIJRsVdSbEdr1g9/qPPakh7nlH3y2jzeP9neoZFZOklugmydoUd/tKwZWM/Q6Gm4b7Mjzotj2qmKA/cdfx2QJBYmK5xrktivjspR4WHh7fw+mRRfQiYTDSrKJLborcS7IDwHgyXOtNQypb4mH0vyT/SVazwmGWm/CswqJtPzWBgz2gbmtTc7NZpyB1SnhoB1JS2ynEjjnrTJ6rDkXrvUKI1cd2FuHGIP7A3aw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d8e6b63-91fd-40df-1825-08daf280661f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 20:30:50.9083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NS992kT7awAr/L6FDwkOJxz6nkM6sYTiR6IOUFTNO2mWNdzApoPAPQv9dIIZp5ckxQM0cLQVeFdDAQctr3US8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6970
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_14,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 bulkscore=0 adultscore=0 mlxlogscore=708 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090143
X-Proofpoint-ORIG-GUID: vVOnnVT9EyItH_vOSmwaHC2GcO8HnsWC
X-Proofpoint-GUID: vVOnnVT9EyItH_vOSmwaHC2GcO8HnsWC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KiBTZW9uZ0phZSBQYXJrIDxzakBrZXJuZWwub3JnPiBbMjMwMTA5IDE0OjI4XToNCj4gT24gTW9u
LCA5IEphbiAyMDIzIDE2OjQ1OjQ2ICswMDAwIExpYW0gSG93bGV0dCA8bGlhbS5ob3dsZXR0QG9y
YWNsZS5jb20+IHdyb3RlOg0KPiANCj4gPiAqIFNlb25nSmFlIFBhcmsgPHNqQGtlcm5lbC5vcmc+
IFsyMzAxMDYgMjE6NDBdOg0KPiA+ID4gSGVsbG8gTGlhbSwNCj4gPiA+IA0KPiA+ID4gT24gU2F0
LCA3IEphbiAyMDIzIDAyOjAxOjI2ICswMDAwIFNlb25nSmFlIFBhcmsgPHNqQGtlcm5lbC5vcmc+
IHdyb3RlOg0KPiA+ID4gDQo+ID4gPiA+IEhlbGxvIExpYW0sDQo+ID4gPiA+IA0KPiA+ID4gPiAN
Cj4gPiA+ID4gSSBmb3VuZCAnbWFrZSBpbnN0YWxsJyBtbS11bnN0YWJsZSBrZXJuZWwgZmFpbHMg
ZnJvbSBpbml0cmFtZnMgc3RhZ2Ugd2l0aA0KPiA+ID4gPiAnbm90IGEgZHluYW1pYyBleGVjdXRh
YmxlJyBtZXNzYWdlLiAgSSBjb25maXJtZWQgdGhlIGlzc3VlIGlzIG5vdCByZXByb2R1Y2libGUN
Cj4gPiA+ID4gYmVmb3JlIHlvdXIgcGF0Y2hzZXRbMV0gYnV0IGFmdGVyIHRoZSBzZXJpZXNbMl0u
DQo+ID4gPiA+IA0KPiA+ID4gPiBJIHRyaWVkIHRvIGJpc2VjdCwgYnV0IG9uIGEgY29tbWl0WzNd
IG1pZGRsZSBvZiBtbS11bnN0YWJsZSB0cmVlIHdoaWNoIHRoaXMNCj4gPiA+ID4gcGF0Y2ggaXMg
YXBwbGllZCwgSSBnZXQgYmVsb3cgZXJyb3Igd2hpbGUgYm9vdGluZy4gIERvIHlvdSBoYXZlIGFu
IGlkZWE/DQo+ID4gPiANCj4gPiA+IEkgZnVydGhlciBiaXNlY3RlZCBmb3IgdGhlIGJvb3QgZmFp
bHVyZS4gIFRoZSBmaXJzdCBiYWQgY29tbWl0IHdhcyBhOGUwZjJlMTI5MzYNCj4gPiA+ICgibW1h
cDogY2hhbmdlIGRvX21hc19tdW5tYXAgYW5kIGRvX21hc19hbGlnbmVkX211bm1hcCgpIHRvIHVz
ZSB2bWENCj4gPiA+IGl0ZXJhdG9yIilbMV0uICBUaGUgc3RhY2t0cmFjZSBvbiB0aGUgY29tbWl0
IGlzIGFzIGJlbG93Lg0KPiA+ID4gDQo+ID4gLi4uDQo+ID4gDQo+ID4gVGhhbmtzIGZvciB5b3Vy
IHdvcmsgb24gdGhpcy4NCj4gPiANCj4gPiBJIGhhdmUgZm91bmQgdGhlIGlzc3VlIGFuZCB3aWxs
IHNlbmQgb3V0IGEgZml4IHNob3J0bHkuICBJIGFtIG5vdA0KPiA+IGhhbmRsaW5nIHRoZSBpbnZh
bGlkYXRlZCBzdGF0ZSBjb3JyZWN0bHkgaW4gdGhlIHdyaXRlIHBhdGguDQo+IA0KPiBUaGFuayB5
b3UsIEkgdGVzdGVkIHRoZSBwYXRjaCBhbmQgY29uZmlybWVkIGl0IGlzIGZpeGluZyB0aGUgYm9v
dCBmYWlsdXJlLiAgVGhlDQo+ICdtYWtlIGluc3RhbGwnIGlzc3VlIG9uIG15IHN5c3RlbSBpcyBu
b3QgZml4ZWQgeWV0LCB0aG91Z2guICBXaGlsZSBkb2luZyBiaXNlY3QNCj4gb2YgdGhlIGlzc3Vl
IGFnYWluIHdpdGggeW91ciBib290IGZhaWx1cmUgZml4LCBJIGZvdW5kIGJlbG93IGJ1aWxkIGZh
aWx1cmUgb24gYQ0KPiBjb21taXQgYXBwbHlpbmcgYSBwYXRjaCBvZiB0aGlzIHNlcmllcywgbmFt
ZWx5ICJ1c2VyZmF1bHRmZDogdXNlIHZtYSBpdGVyYXRvciIuDQo+IA0KPiAgICAgbW0vbWFkdmlz
ZS5jOiBJbiBmdW5jdGlvbiDigJhtYWR2aXNlX3VwZGF0ZV92bWHigJk6DQo+ICAgICBtbS9tYWR2
aXNlLmM6MTY1OjExOiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCY
X19zcGxpdF92bWHigJk7IGRpZCB5b3UgbWVhbiDigJhzcGxpdF92bWHigJk/IFstV2Vycm9yPWlt
cGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQ0KPiAgICAgICAxNjUgfCAgIGVycm9yID0gX19z
cGxpdF92bWEobW0sIHZtYSwgc3RhcnQsIDEpOw0KPiAgICAgICAgICAgfCAgICAgICAgICAgXn5+
fn5+fn5+fn4NCj4gICAgICAgICAgIHwgICAgICAgICAgIHNwbGl0X3ZtYQ0KPiAgICAgY2MxOiBz
b21lIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzDQo+IA0KPiBNYXliZSAibW06IGFk
ZCB0ZW1wb3Jhcnkgdm1hIGl0ZXJhdG9yIHZlcnNpb25zIG9mIHZtYV9tZXJnZSgpLCBzcGxpdF92
bWEoKSwgYW5kDQo+IF9fc3BsaXRfdm1hKCkiIGNhdXNlZCB0aGUgYnVpbGQgZmFpbHVyZT8NCg0K
WWVzLCBpdCBzZWVtcyBJIHJlbW92ZWQgdGhlIGV4dGVybmFsIGRlY2xhcmF0aW9uIGJlZm9yZSB0
aGUgZnVuY3Rpb24uDQpUaGFua3MuDQo=
