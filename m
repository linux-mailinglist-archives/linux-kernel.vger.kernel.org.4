Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0D5670DB7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjAQXfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjAQXem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:34:42 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB7F45BDA;
        Tue, 17 Jan 2023 13:24:34 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HLN2oD022154;
        Tue, 17 Jan 2023 21:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=5xvI3dZKAm3/rBvHa7U0dwZ2zrF9tUivbj0yUdvxiME=;
 b=xI5idqh9TTY+bQ8TQQeYqu6DWXY641uUU39jthrvkz6XAJPl1SJX/CFgEEZz3s8NbSAc
 KTue5H8NDxCSWGZOqvd6S9GvABK7dad6L183073pE9Cee3uHirGze8uFmWmJ6dDGBqoJ
 JSdDODf+7FqLoChWSorsBOUz+GdPkoHkj+L2gkm/MG5ux8VBoT5DN5LzO03YSrKQV1yb
 tBUSeeye+HWZLmHsXCKfyvACdidvD4TVO39j7UU/EMuwANHAVHRXHUzVDht1Nhc6VzJq
 0vMnWlio7Ncas8awnzgrm/2Po7nEpQaRR6cZVHro5H8y9uVmKELsnuodJmC6rBwtKbgR dw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3mede25k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 21:24:20 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30HLIsY0023561;
        Tue, 17 Jan 2023 21:24:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n63ftr9c7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 21:24:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXJy3e0Iu45m2eKQmWzYFKbFyVJyHp9BpxTnz7hw2mw0oPoxb1nMaKV+BAq6WCMwE3GPNsDu/otjkFJ0II4vdziB6V3tca/4zdgCrAYiz6Lfhipfvbi8zQLrsfYRmFgBvLlV+/SMs3YKr9GSVgMRfPA4RWKPpoj9ir6+zwaZ0KqatkI1WnVuCzGejGfLsfxIvXIQUtJPgiY2VWLM69aIDwzj4uwyZswk1p3OaJbuguC+JGrpS9hepF73NQ7QA9DIHLCeca757cb/k61bKB1B0/EVwELBOTSgJvMiXKjiYJulLSxVWybGpGTCIuf5YyZcZdapo1n9OmEZOFkhQVDcdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xvI3dZKAm3/rBvHa7U0dwZ2zrF9tUivbj0yUdvxiME=;
 b=ALDIYwSm3a/Z5/+4/oulT0x1olCAC0fwgWGw2dZsU21lOniikCax+QTo5rsDVeJQZdkliOVo+d3V7VluUZyM2MxZ6Vmb0sPwPxCpTTFFwn6UKRWhekgBH2yRq62YtpqN2v8YDqkG+q/Vqk6M/Pw2OivbN57dVrFLmPctSCbKhPwAh8GKR4dQ7V5HEPbWLUiyTJywkT78wDnYzhxmKnA3BcmqPX2gKFr6evUQNjiEWfSsLH4kfo9rVtW+uV/Sy8wyOxXjWkJioEDVTyRTGbbhxUtENmnF9kElEigty2OTEW/uZGJR2FTJyNaVc9RFf/3f5hfb+CHoLGs9Voq93+9b7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xvI3dZKAm3/rBvHa7U0dwZ2zrF9tUivbj0yUdvxiME=;
 b=ZdN/KBPuMPvlnMClFo41Ny0IQsEEBYhi9C6adB41lunV3XVGgSRBFfKcSqDRlnZ82AXk5yBT2+NOfHVBfT8JRauMlceTHgwkdlmOnTevTpe+ZJruPNgh6c3DwsN7F/5qMD9fzv/RqDE4D2XgS6I54LgP3u+WL7otJbUPZmulHrE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6062.namprd10.prod.outlook.com (2603:10b6:8:b7::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Tue, 17 Jan 2023 21:23:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%5]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 21:23:45 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the nfsd tree
Thread-Topic: linux-next: duplicate patch in the nfsd tree
Thread-Index: AQHZJtuHjKaXgt/yjkWRrCUo/8ISo66bbLAAgAW0fICAAK0OAIAA5AyAgABtdoCAAAaBAA==
Date:   Tue, 17 Jan 2023 21:23:45 +0000
Message-ID: <E6550C77-4A13-4AD6-8991-D1E369F716E2@oracle.com>
References: <20230113101326.09b1250e@canb.auug.org.au>
 <53DEC27F-0AAC-4EFA-AB6E-0B5D44AACFB9@oracle.com>
 <F7CFC18D-6AAC-4DAD-AA43-5C718FC1100E@oracle.com>
 <20230117115228.13b55d07@canb.auug.org.au>
 <C72F2CC7-EB89-44D4-AC4A-C33EBED4B120@oracle.com>
 <20230118080027.300ab7b5@canb.auug.org.au>
In-Reply-To: <20230118080027.300ab7b5@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM4PR10MB6062:EE_
x-ms-office365-filtering-correlation-id: 4a111ec9-f5b9-4e9d-ac62-08daf8d11d80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9ivuuNuZ30BvENBoaqYelZbp9DgkFDvIFrqmEZAKd6vVzzHqmXsd2jwpOfgrjnOYqlNPKmRXseYZWPLv7gkXTgR8NC4C7y0L8nAVvqXapJVEajtN2hjLbxwU6LnjWGTBJXqyJ2LUKrPSOgh652xxC1bhbvQfyl/c7bSiyMsa+zFF/ubIJ5xut8fl5eIQ++I+NUFJvTtvInXdXDCzMFSumwltOz3HPTdDoKlZmohdBoK+FVOjudg0J0YLf3OdJXIz4FxIrkKkuq6KRKhxk5nZTygSm7BvdITWn9h4myXAygc+oQYi6x5b7zeKHeUdMiJql4D7j+o3vN2BAkt+rjX8qDJuuWwBSGfi7Wr4pOiawrrEQjB/fM+ZOI5TpJM5qzuKTZhYw7bc4PfvZlCSqfWUas2GYHsEHRqADwl1kpCDaW47hcKiYPhPzWJra2YnvfBnN6xCkFbKc3nRqO/7jSASAWsSWErrOKHlAL7kkqjsQpmDU6z15SFY6y1cZDZ9AwY+bPK7j2luaM2kmkCnSDxnv25l/GWAoIc+WYW9cGCkdb1alTTzq7da6zHFc5cmPQNNuOaW119+teMZm1jNa2SIF1C4EZzqULxVBqaKStq5CPOlsZEefZD6zKdPc3BFfNzlbb3TR+H/KJC+/8vvMN34b87wUTKCFwYDRoHJc3zU8ICWxwvwk2T9FHApbfXGksu+hcxa30597wiIeRUeqLf0teSoolp1uU7gCBXJ2jGYpKc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199015)(33656002)(5660300002)(316002)(36756003)(54906003)(2906002)(2616005)(38100700002)(83380400001)(122000001)(6486002)(86362001)(6506007)(53546011)(186003)(26005)(71200400001)(478600001)(6512007)(41300700001)(8936002)(76116006)(91956017)(66946007)(8676002)(4326008)(66556008)(6916009)(66446008)(38070700005)(64756008)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IjGn3gxithy2PbLchtoJqH/L9I2mr+Io969v9g99EF1YVFI0Mjsi5SYDa35x?=
 =?us-ascii?Q?z/mmXNe25d4R4tb5NBLNdZU/Ok4F2843nCMRbTkzAkLnNRC4zmf/zyiPpv4s?=
 =?us-ascii?Q?URC95FvuidZ6GJsIgB7WVxv0zq8RkmqpnDfUPCB9IhQeYSTn0q2+mZd0xVv1?=
 =?us-ascii?Q?dILIHuDcRY3yIrw75lYkiFkDEr4vE1RhQbggBMr4/cTdRZTtoUhKRFmaZYpA?=
 =?us-ascii?Q?5mxpSFoFLNTdMq1xZvDHbc8dPMCh6V0GnDlHsIb7KTk6q+ot/Pi9w0+Gy5O5?=
 =?us-ascii?Q?TqC8ENzwac+fo0SNYEsrNnAlih6VKuBs6qVZtEX+/wwW33GHYPzxlAfZS1no?=
 =?us-ascii?Q?mOIzSKQndHA6WFVJZHz22zjBYmVTkd9yy4NDsIYx0IRuBQIBo0UKwL2yTjmP?=
 =?us-ascii?Q?jG6D2geLaOZPCZKNOGZeGcSkCmKBhfrtiSAG4xUS0OlcRYSTFGtCq6xpsBvw?=
 =?us-ascii?Q?g33Fou0OON/rrgZN291ua4qSQphEUnD9kSeorREZ36dQIMIR/3XjFEWy5xp+?=
 =?us-ascii?Q?2IzvceVaAsX6vAOWM10kFP7pYz1OTdhoXOVcXqxP2BUbP3CsdlkxEXUwfF27?=
 =?us-ascii?Q?i72wO03X61R8XzEhPHZDE/i0T71jyK60Fc2Sodkg8ZUkq367a8bd7J/Yw2wW?=
 =?us-ascii?Q?2jHIVVm/BIvKhoSihd7Tm1jaF41jlHjW13oTpZZ3HXvmpPRz8x64+aNUL1Q8?=
 =?us-ascii?Q?bA3dgmD7svlz2fcDZLVoC6v0KxaaPlDCXaE2ji6CFswuPL7C4BVc0Zzkvyeg?=
 =?us-ascii?Q?jXnXzJjrGMcarBGoaoX6sb5Imvfc/MuLi4EOqgGKHs2ffHnU6570rJmsqndn?=
 =?us-ascii?Q?qzdJEoXC99xeUsFuOv6yrLLw0F4Q91BlalKrUZSWa8SKM1qoHK3S3SnjdjfU?=
 =?us-ascii?Q?EheVFRxFDLGCkwxwZzoWO5dWmnB89B7a5ZlkUE5PeUB4xeVDf9GYmLUxVkUD?=
 =?us-ascii?Q?sEO6CDRNXzCx8vPjVlnSCXTBSS/qDzcGWJYRkrGqn6FbdNwMtU+h4nf+Q1zy?=
 =?us-ascii?Q?Pp2NVAhZ5XMEg/m1iA6NWvUfU5MNDKNHp4q6h+iRyWlf1kms9NnBsSVc6FKZ?=
 =?us-ascii?Q?QIvOwFzYWCmJG9AVxW5mWQJRnNvRb6GBtIuGh07M1t1ChwanfeL9ypeDw7fv?=
 =?us-ascii?Q?uaRwLWuo7cJVo+ocEcTqlADmPnjyjCBWlxGKQuYblX6IEdK4BSUkSdqhKS32?=
 =?us-ascii?Q?WrpPSm2zSTnkOQp8nRrdASNI/lgY8IWj2Ybifwq1Drsj8gBV+ZYXBJ6H9wKb?=
 =?us-ascii?Q?klwb1sBmM8C8cW9aXYdXRDzh/iWBQ5SjRWERQ3QLrYBUT8KqqeNmmcaTEFn/?=
 =?us-ascii?Q?GwLgxumReFCfv2nrjmN3kthLgpQa5D/r4kyq0D2DNJGZoLs1uJ4Da+2qKLKR?=
 =?us-ascii?Q?SL2Bf1lx8hkgf0uw0YlcRMyFU+hXaMTEDTFWywckjmgEomu4vyr5JF+q0lpu?=
 =?us-ascii?Q?desEgCeJNBJQGaVPKJRAJ2P2bhUQgtP+V5UXI6tK5WnqBZ/XGfzvGGor1w4W?=
 =?us-ascii?Q?8tnOIuk0L9ZggQdjqrbV8jzaIDxQUtXU/IrC8flgq3WuyXFqI4+aYfgw8KW5?=
 =?us-ascii?Q?tLt+iBrDV8fcENTJCQgR+XN2HT2f1TOHcOXjlO6SDk1okC+sAq/aX3fCYCtX?=
 =?us-ascii?Q?Aw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ED472CADCF780E4C833C1B2BDB3E6134@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FGgoAr/Eafpha8J/apsXuCUfr+rwCvzKYVIXReKTFM+h7Oc1UgKPlSDDcLLDbd5d/8UgH1SQYmBL2PigQOS4F6mIUjDCtN5JWoEIzNX5uHvKO9h97cmmGBBY83ee2yApDGOTnXt7KNG2ZBRJMHgPH9jPicLVNr+CSADHsl9/+KbjgJeLqRDE3cXCvnIXCTdK7eqSM4zoW8ZiLa+zRtT5cyWxFo9yC/gClgG6Et+G/xQuJFXm8i9TsIs0fFDm7lzv0jXLVNv1iGTd/rqnaWgJk8EaJe+rZFbWn/5n1BmT5ih2Bpwph00TD9jBnGSErjBWLfcujI9QL9ALhQmAGaDepmEmP+RvOpbSSPlsmjp+9nv39ywZl+0DNLEEI1EY3rlIeO5x2IqKJKQay/KshMUuxD5FLPSAkGeroCAL0L0ImFv8QjgkUbmGm5YeA4/o2XxnOpcpt47YGkZlbfvHZzTiQNIqBLTl2MpXk5h2OvIyT0JOcUoOWzZ4zBfXBc9Hbsk76oZNYkvx4a8hS4iOtGJlpsxxlpzxJsnHsLBS57VcWdnLTHaKGLP6kYqh5EdzBQ3DwkQ8RDyss71E+8BIxxvDxX6cAbJCQ+QFtudbXGAtibvGVMc6VIh0yu5YCQOtF/W+SvnOih3rPFAl6eO4Unu4vulI9NBdKvLz69hkljEMzwxI/y3VOE3MWP7ZEkaut6GQytNGAIK1ZP+LNiKNosxN+ROZlKMn5Jfqs+rVsbKVRZNXQGYycI1xtpAlhG7a9IwB0q+WuH2nN0viphWCAdlOwznoJZkdbI5h78W9WPY9gZm/QdyNCV69dNTvcM9HAfDX
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a111ec9-f5b9-4e9d-ac62-08daf8d11d80
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 21:23:45.2859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JfpoWLNI5pPJCIu9jIuuzgCr3ls8HbBmQsgBtiCpqatdVSIPbRj++FI5Ovogq58zvh0kPNtymSt4y6rWtrTpKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6062
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_10,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170171
X-Proofpoint-ORIG-GUID: kvWPoxK77tVIbM2Pdf62_LqLkMyANdq0
X-Proofpoint-GUID: kvWPoxK77tVIbM2Pdf62_LqLkMyANdq0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 17, 2023, at 4:00 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrot=
e:
>=20
> Hi Chuck,
>=20
> On Tue, 17 Jan 2023 14:28:42 +0000 Chuck Lever III <chuck.lever@oracle.co=
m> wrote:
>>=20
>>> On Jan 16, 2023, at 7:52 PM, Stephen Rothwell <sfr@canb.auug.org.au> wr=
ote:
>>>=20
>>> Hi Chuck,
>>>=20
>>> On Mon, 16 Jan 2023 14:33:06 +0000 Chuck Lever III <chuck.lever@oracle.=
com> wrote: =20
>>>>=20
>>>> Sorry, I wasn't clear. I need nfsd's for-rc to be picked
>>>> up and merged into linux-next before I send a PR.
>>>>=20
>>>> I've trimmed for-next to temporarily remove the duplicate
>>>> commit, so you should now be able to continue merging both
>>>> into linux-next without an issue. =20
>>>=20
>>> I am not sure what you mean.  Your for-rc branch has been in linux-next
>>> for a long time and the current version (SHA 7c24fa225081) was merged
>>> last Friday. =20
>>=20
>> My bad. I was looking in the wrong place.
>=20
> No worries.
>=20
>>> For clarity, the cel-fixes tree and the nfsd tree are both branches of
>>> git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux - the for-rc
>>> and for-next branches respectively.
>>>=20
>>> Maybe I should rename cel-fixes to be nfsd-fixes? =20
>>=20
>> Renaming my source branch as well would make things a little more clear.
>>=20
>> How about I name the branches in my repo nfsd-next and nfsd-fixes?
>=20
> Yes, that sounds good.  Let me know when you have done that and I will
> update my end.  In the mean time, I will rename the cel-fixes tree to
> nfsd-fixes.

That's now been done for-rc -> nfsd-fixes and for-next -> nfsd-next.

--
Chuck Lever



