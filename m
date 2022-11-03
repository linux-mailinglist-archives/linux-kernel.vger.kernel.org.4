Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33761617AF1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 11:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiKCKji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 06:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiKCKjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 06:39:36 -0400
Received: from mx0a-00622301.pphosted.com (mx0a-00622301.pphosted.com [205.220.163.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A31DF31;
        Thu,  3 Nov 2022 03:39:34 -0700 (PDT)
Received: from pps.filterd (m0241924.ppops.net [127.0.0.1])
        by mx0a-00622301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A3AdSSj021396;
        Thu, 3 Nov 2022 03:39:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=com20210415pp;
 bh=zGVvEY/g/cmyomKD7RM7ypA2Z6x5MiUwEwC7QAmkd4M=;
 b=eNqWljL4imuwMaQXgQBdPk72Yy9aI4afRW4doNtaXbl7Qc9dt7J1EuEp0I5xc3yhf+04
 FdzymIS/s8/yq6MHaue7Vz62whdH6oDr4Cyx2NCF5kvvbyul26Mnjll68g3LKN5oAQWu
 RJOTyWZu4psvCPPA1fjF1r0C5pCyHoP7kUnHkcDH3+TVOJc3OHkWA9Rby+75aFYsArdV
 6oGLvkiHcFnLTCt5oIeAnqE+SIY0j+TRrxiZ8j6TIfhv4xXSjE0tGIweiDip/kg9uQ16
 gGQcqETU8kuzfCmhJxOtmAC5NydEkNQZmvmkqXzftR+o2MUsleiInxRXBkBdwlp8sIiS Rg== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 3km9s40233-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 03:39:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0hP6Y0d1W0C1Awld6hJZT+meUtccVn9XL30Q9t70CkBZ0bv3QmDE259BUwSCFTBLjRlc/U/hDhzMEYmeHRF4ndPG6iJ7Ek4kWCDOV1JZhHWIvCkWCk6QDUsSIZqAhuokbxk+CQbl055S6eNikj3in/FE61UJywS1SJtd0TrcZ5C44Sr9IyVUQJX1ZsevAhOQ1/N/TEZTpWQuZUzySYyoyWHg6t0xK0o1HnbgP+OPVgLWKOa3bCrk+aW8k2G9HQOvCLcjjq4qgHDbJeHTE8B+2hJnrX9WB0j8dp3b7t1hUBIgR57CBIzP9W/ER75HlYoj3Tb19jPvSQO0xvf6XiG7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGVvEY/g/cmyomKD7RM7ypA2Z6x5MiUwEwC7QAmkd4M=;
 b=SAz6G0YEDXP4PU7RQxkK+9YeWc2XPVkVNlI1bq2r8K0T7wRd2Jx1eBpHeXNXooPHsoQlBZrY72JPxLqlv9WlIjNrwwLTrYocQl3Ld0u3iIqyeLoH3FRLj2PX2E+ERd4AsAh5cdk0U1gaxSG0rHa1lqiIga12biIFQCXdmutP1RPSvL8z+Z+PQqv9wBLGJLQk2ejpEasdz/Os0C7niNB0GkvsOT7kUdo76sq3rWdo1AbeWhsBjvPLsUQJbXtIkawaZ/Alc0vJEA5uWdtKpDc1vz5Eu9IQsmBjrr4trKdVefhFpQg3jNIvgZI03nenKGN9fvw4kkETJ4cbXZMUENpepg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ambarella.com; dmarc=pass action=none
 header.from=ambarella.com; dkim=pass header.d=ambarella.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGVvEY/g/cmyomKD7RM7ypA2Z6x5MiUwEwC7QAmkd4M=;
 b=MUKNO5da6cItRevSgHIs1NaGUNmAOxe81/ZbQ3NYYGfipo4Xaj0IYoVkDmqo3heG8olgsL8yqbDOsvR2BPtcLG/PJIvCTbUn1EAkEYmSEhB6R7aqlQItBzihK4tU/4lENum99TOxelDSRhB+nRUHtgYdbCZh4Df43nS0V/kmqA0bm7ZkKNCWUlf3v5Kk7BZde2WRy8MDFWOiNLEf2oHkdyyBdRwZW06c5sfcrPeilT4TyaxNDYhHu64y48WCYzeuaBBsDf2STSOFZtO0doE+WVLiAHksfr4FbVTJ9nkFUS6cJpbWB6ux5vN9vCtldt53LC3GkRd+x5S4fSI1AGSc9g==
Received: from DS7PR19MB6254.namprd19.prod.outlook.com (2603:10b6:8:9a::19) by
 BL1PR19MB6034.namprd19.prod.outlook.com (2603:10b6:208:39d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 10:39:24 +0000
Received: from DS7PR19MB6254.namprd19.prod.outlook.com
 ([fe80::f9bc:3b31:8390:e804]) by DS7PR19MB6254.namprd19.prod.outlook.com
 ([fe80::f9bc:3b31:8390:e804%5]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 10:39:24 +0000
From:   Jing Leng <jleng@ambarella.com>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Dan Scally <dan.scally@ideasonboard.com>
Subject: RE: [EXT] Re: [PATCH v4] usb: gadget: f_uvc: add super speed plus
 transfer support
Thread-Topic: [EXT] Re: [PATCH v4] usb: gadget: f_uvc: add super speed plus
 transfer support
Thread-Index: AQHY70mqW2UbhSRGJU+WU3QyrSkAPq4s+QSAgAAGZnA=
Date:   Thu, 3 Nov 2022 10:39:24 +0000
Message-ID: <DS7PR19MB625403D5994B3F8BD520C89EA6389@DS7PR19MB6254.namprd19.prod.outlook.com>
References: <20220217031035.6150-1-3090101217@zju.edu.cn>
 <20221103060041.25866-1-jleng@ambarella.com>
 <166746992763.2442643.8937261146141591391@Monstersaurus>
In-Reply-To: <166746992763.2442643.8937261146141591391@Monstersaurus>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR19MB6254:EE_|BL1PR19MB6034:EE_
x-ms-office365-filtering-correlation-id: be69f906-50b0-4fc2-e40a-08dabd87accd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7OMFfOoSPTMoc7/E2vl8H2DudlVwgBw3saeNA0LkwPrjkcePewFmQu4LjCGvEtgaiZctO4t00J/sD2zCKX2pU7rMSFbXDxoG3+S9A5jOpqLyjHUgQdOiLcn0tixGFM/uc2+luklGZ9CH/9HFOut1lzPMVhxB+GeFJENGNr8Eh0kWqCGyN6dg0hVHODcd70AUNY0bgBpl/NfRrcajnIouO9Fdmx1qfV7OFgblRBEDJF4kNPljl1vj2lsy9lvtK2pK0ymflC7fzz+NoawNpDMscPQyEDiNhPuijcGkR3qcqCYnvT8f31NA8pShrUFLO92uEQ6vyfyG/MsLYOvk1BvH09KDibGPQCV2KDSvKqbU8QKCMD5YjuFBPQZzzCDD8qYdMFpS12DQZGHf13e69ry2IZAFFFB3mnH5lN51tWOU01nDGAk6ZrdBG4bFSq3P/EL4nrgTM/hOIFA4wzah+1O9hr5yQUDHw17jsHTvtqhaSqN1kKQfOSxz1eqWpd5UdmwVaoq3g2mqG2tfQ5gH8UrpKY2k2XNQlDZxpMEAi6jqi7qIoi0Ols5Vo8ru2fxz/CTRODjnFX/gPFzdk/sxRWU5TvFi42lTBIB0WMQpHH7wQJEGTRT13U47MzAumTszFgR51B5vPMZR2FTZ04iMbRTo9pr+OBEHB4u/8GNLjQ8ZMz6pVOPd+PYW6A3F8I+dxGpdA+EzGsQS5vD7o9yCDZF6djilbEgUXxp6+WF2S/bbNZpsnkiuGNkJWE8TLWAuJCjs09hJ4nHf0MsvZAEk7E6gBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR19MB6254.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(346002)(366004)(376002)(39850400004)(451199015)(26005)(38070700005)(55016003)(110136005)(54906003)(53546011)(4326008)(7696005)(41300700001)(316002)(33656002)(66476007)(64756008)(6506007)(8676002)(66446008)(91956017)(66946007)(66556008)(76116006)(83380400001)(38100700002)(86362001)(122000001)(52536014)(8936002)(5660300002)(9686003)(2906002)(186003)(478600001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?V2dqY2tic2NlajFrTFl4akhWMkZIcTREM2w0QXpwS0hOM1dOU1NndE02ZXV5?=
 =?gb2312?B?Rm9yeGhTaHBYSS94d2Mrc1luQzg5RU1OOVNkWmU5bklUdVZLRDk2VW1WNjAy?=
 =?gb2312?B?RmNoeHhNTjV4NFBsTVdRWkp0ZUR1djJNQ2gySjJpNS9RUUVwWS9ibVRYbGJa?=
 =?gb2312?B?RjBBYm9PeGZkSHJtWUlTRTF1ODdxQVpXZkRKSG1aTzYydElOTHRGVmxWK2gz?=
 =?gb2312?B?UkoydDM5TVQ4Um00WC9QUjd2S214Z08zVTF6ejdvbS9kazEzMFErVks2R2VS?=
 =?gb2312?B?ekdzRDFjU0pGRlg3MURLM3dHbXUxU1FtL241cE9MWUlpdVRXZzM2dzdxdU1Z?=
 =?gb2312?B?Q2IzU0lMSjFoT01LeFMyZ1F2OUUvQ2U1aXJSbkkzckxGNnZEd3RHOVQ3UlA4?=
 =?gb2312?B?amFuU1VIaEF6VmgyRmlZWlJ1VHhBcjJEaXFLMXcvb1FoSGVqb0prRkQ0Nmdq?=
 =?gb2312?B?REFMZzAzdVp3bUZGNXRUc3F5a1hOT2pzZ1dLVmZROTl1SmxKUmNrazArczI5?=
 =?gb2312?B?bkQxNVlidThLV2JSQzMvUmY5L0JZL3RRU3RFMG5HdStJaVRObmhmUmZWbGNo?=
 =?gb2312?B?dE5IYW52NDRlT3Z3YVA0anQ0NW55TnE4VnU5Ly9jaURWQXhTdEhxYzZUbEd2?=
 =?gb2312?B?UHdqNWVxNzMyY003NDBSSUIvZDhnbmptTHM1VSs3SitJN2lCN1NHYWJZdk9D?=
 =?gb2312?B?QUFZQWc4dy9SQlFaazhzRG02SFlOVkdRbUxjZWdMdWN2WTJBMk8zR1JGMTV2?=
 =?gb2312?B?bGJzUkdQZENxZmZtRmM1UzVwL1pLOFdQeHl1Rmh6OFJxazR2bXlUdy9uV0tI?=
 =?gb2312?B?VmV5YVNKL0ljcjl2VVUyc3pZZ090TmxUV1VCZE9kc2NSY0lzcnFrWjBkcVY1?=
 =?gb2312?B?OExhR1JDalQvZG9zc0NkelpuOVAyNFAvd0RJZUFHL1ZnWG0yM25pQ3MxY1Z0?=
 =?gb2312?B?L05yK3BLUjBlU0pZVHZydmVQRDVuOW1YNnBSSlFSS0w2QnJIbGRDVHg2OUdT?=
 =?gb2312?B?UkZwdk5SdmdGMUl0RXMzWHlnRUVGQmtFc2duZUVScUt3d2tOZ3Z5L1JmVnJV?=
 =?gb2312?B?M0FWZE9FUTQxT0F1SFJBTmw4U2FBK3VGR2Z6RGxKK1BFSy9qMEpqMGVlSFAr?=
 =?gb2312?B?OGdWODJNdllYRGVjN2lxNWw0U3JDWVU4eWFPRzFNOC9rTDVEeHk4d1RFK0Zr?=
 =?gb2312?B?VE5FMm5iZGNlWmVwWFE5WHZZNm4yVzJBbWIyRzhKWlVwRlMyZm9vYzNKOXNy?=
 =?gb2312?B?NzNObzEvTmpCVk5LTkpoUzlVSUVZZkY2dkw1MTZacFlFZWxkVDM2cHYvY1dw?=
 =?gb2312?B?Z1JKcFMxY2U1OFphaHhTKzYvUWZuanV1RDFnWDgvNDVwVzF6MTBSaENxNnds?=
 =?gb2312?B?YytpZzU2bXZrbXJQMGR6eFRxVnVtWThkNlllMXFpWERxeDZZdG93SzNIaWhT?=
 =?gb2312?B?a1I1Q3BHWTJZblhSN0YwcGZuOHoraS9sbEdqUTRCYnh0MnVsN1pXd1NSZGJM?=
 =?gb2312?B?eW1Ld1RESVZpRmo3elBwSFdJWWVraVVhbzdVTmI4ajNRY0QzYlVERk41Vm1E?=
 =?gb2312?B?RXZCMHJIZ3c2bGVFZ2F1RE1rUWFwN1lhck9wbWk2eithcHRyNllSVll0TVNy?=
 =?gb2312?B?Q2NucU45NlJXWWpXbjd4RWxuQkFpNjdqUllOS0JsL1VMZjZ1UXIwdlg1aWN1?=
 =?gb2312?B?VzFoakFxU0xZZjdxWDRoVWFlOEE2d1RCYkxzTmNLVFNicHJvVjZiL1JDdUdM?=
 =?gb2312?B?Tnl5eWZBRnhOZ0I3ZDk5N2pudDNEQmhPYnk5bFkrTEFNOVpPSlZYbW8wdi9j?=
 =?gb2312?B?cGkvekRuOHVzZFV6R1FmUlVCR3JmM1NmeE5oMEhOTG85T1YyUlpPeWZsRlU5?=
 =?gb2312?B?ZmtwTUZCMTVEejdvS0NPTVZTYXBiSXI1aTdVSTZGazZGNWZEREFvQjYreTNK?=
 =?gb2312?B?UFI5UjJBMnZnZENJVjVZVllsY3BxampRWnc5aFRsMGFKb2ppUm05SW1lbUFS?=
 =?gb2312?B?dVNoR29yVEh5OFhNQXN5TFJXKzA5K0I5NTZUT0cydS9IYkprbU9jWldrNlU5?=
 =?gb2312?B?OStib05rV1FmT2hZMTEyd2MyZWM3cFAxcUltWFkzb244TXJNbVN2SFhHUXQ0?=
 =?gb2312?Q?gWLHBRYq8u8qgNThTpPfGiOyD?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB6254.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be69f906-50b0-4fc2-e40a-08dabd87accd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 10:39:24.3130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ux1RXVLEmciTco8i2g3eRt5sazmvneO7nKSq1qcUyBkG/oyYoiMwS1vWzUz4u7SXZSC2gLvlHIrXxZNwe/XsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR19MB6034
X-Proofpoint-GUID: bx7PCtVMfKVjiOF0hly20Ax0X8rAvheU
X-Proofpoint-ORIG-GUID: bx7PCtVMfKVjiOF0hly20Ax0X8rAvheU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_02,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 phishscore=0 adultscore=0 mlxlogscore=999 clxscore=1011
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211030074
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS2llcmFuLAoKVGhlIHBhdGNoIGlzIGV2ZXJ0aGluZyB0aGF0IGlzIHJlcXVpcmVkIHRvIHN1
cHBvcnQgVVNCX1NQRUVEX1NVUEVSX1BMVVMuCgpJIGRvbid0IGhhdmUgYSB3YXkgdG8gZGlzYWJs
aW5nIHRoaXMgdHJhaWxpbmcgbGVnYWwgc3RhdGVtZW50IHdoZW4gc2VuZGluZyBlbWFpbHMsIGl0
IGlzIGF1dG9tYXRpY2FsbHkgYWRkZWQgYnkgQW1iYXJlbGxhIG1haWwgc2VydmVyLCBub3QgYWRk
ZWQgYnkgbWUuCkFtYmFyZWxsYSBmb2xsb3dzIHRoZSBHUEx2MiBwcm90b2NvbCB3aGVuIHN1Ym1p
dHRpbmcgYW55IGxpbnV4IGtlcm5lbCBwYXRjaGVzIHRvIHRoZSBMaW51eCBjb21tdW5pdHkuCgpU
aGFua3MhCgotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQpGcm9tOiBLaWVyYW4gQmluZ2hhbSA8
a2llcmFuLmJpbmdoYW1AaWRlYXNvbmJvYXJkLmNvbT4gClNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJl
ciAzLCAyMDIyIDY6MDUgUE0KVG86IEppbmcgTGVuZyA8amxlbmdAYW1iYXJlbGxhLmNvbT47IGJh
bGJpQGtlcm5lbC5vcmc7IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBsYXVyZW50LnBpbmNo
YXJ0QGlkZWFzb25ib2FyZC5jb20KQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc7IEppbmcgTGVuZyA8amxlbmdAYW1iYXJlbGxhLmNvbT47
IERhbiBTY2FsbHkgPGRhbi5zY2FsbHlAaWRlYXNvbmJvYXJkLmNvbT4KU3ViamVjdDogW0VYVF0g
UmU6IFtQQVRDSCB2NF0gdXNiOiBnYWRnZXQ6IGZfdXZjOiBhZGQgc3VwZXIgc3BlZWQgcGx1cyB0
cmFuc2ZlciBzdXBwb3J0CgpIaSBKaW5nLAoKUXVvdGluZyBKaW5nIExlbmcgKDIwMjItMTEtMDMg
MDY6MDA6NDEpCj4gVVZDIGRyaXZlciBkb2Vzbid0IHNldCBzc3BfZGVzY3JpcHRvcnMgaW4gc3Ry
dWN0IHVzYl9mdW5jdGlvbiwgaXQgCj4gZG9lc24ndCBzdXBwb3J0IFVTQl9TUEVFRF9TVVBFUl9Q
TFVTIHRyYW5zZmVyLiBTbyB3ZSBjYW4gcmVmZXIgdG8gCj4gVVNCX1NQRUVEX1NVUEVSIHRvIHJl
YWxpemUgdGhlIHN1cHBvcnQgb2YgVVNCX1NQRUVEX1NVUEVSX1BMVVMuCgpUaGlzIGlzIGEgYml0
IGNvbmZ1c2luZyB0byByZWFkLiBEbyB5b3UgbWVhbiB0aGF0IHdlIHNob3VsZCAobGF0ZXI/KSBh
ZGQgbW9yZSBmdW5jdGlvbmFsaXR5IHRvIHN1cHBvcnQgVVNCX1NQRUVEX1NVUEVSX1BMVVM/IE9y
IGlzIHRoaXMgZXZlcnRoaW5nIHRoYXQgaXMgcmVxdWlyZWQgPwoKPiBJZiB1c2VycyB1c2UgYSBV
U0IgZGV2aWNlIGNvbnRyb2xsZXIgdGhhdCBzcGVlZCBjYW4gYmUgdXAgdG8gCj4gVVNCX1NQRUVE
X1NVUEVSX1BMVVMgKDEwIEdicHMpLCBkb3duZ3JhZGluZyB0byBVU0JfU1BFRURfU1VQRVIKPiAo
NSBHYnBzKSBpcyBub3QgYSBnb29kIHBlcmZvcm1hbmNlLiBJbiBhZGRpdGlvbiwgaXQgdHJpZ2dl
cnMgYSB3YXJuaW5nIAo+ICJjb25maWdmcy1nYWRnZXQgZ2FkZ2V0OiB1dmMgZG9lc24ndCBob2xk
IHRoZSBkZXNjcmlwdG9ycyBmb3IgY3VycmVudCAKPiBzcGVlZCIuCj4gCj4gU2lnbmVkLW9mZi1i
eTogSmluZyBMZW5nIDxqbGVuZ0BhbWJhcmVsbGEuY29tPgo+IC0tLQo+IENoYW5nZUxvZyB2My0+
djQ6Cj4gLSBSZWJhc2UgdGhlIHBhdGNoLgo+IC0gTWFrZSBlbWFpbCBhZGRyZXNzZXMgKCdGcm9t
JyBhbmQgJ1NpZ25lZC1vZmYtYnknKSBjb25zaXN0ZW50Lgo+IENoYW5nZUxvZyB2Mi0+djM6Cj4g
LSBNb2RpZnkgdGhlIHRpdGxlIGFuZCBkZXNjcmlwdGlvbiBvZiB0aGUgUEFUQ0gKPiAtIEl0IGlz
IGEgZmVhdHVyZSBidXQgbm90IGEgYnVnCj4gQ2hhbmdlTG9nIHYxLT52MjoKPiAtIFVwZGF0ZSBt
b3JlIGRldGFpbGVkIGRlc2NyaXB0aW9uIG9mIHRoZSBQQVRDSAo+IC0tLQo+ICBkcml2ZXJzL3Vz
Yi9nYWRnZXQvZnVuY3Rpb24vZl91dmMuYyB8IDE0ICsrKysrKysrKysrKy0tCj4gIDEgZmlsZSBj
aGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl91dmMuYyAKPiBiL2RyaXZlcnMvdXNiL2dh
ZGdldC9mdW5jdGlvbi9mX3V2Yy5jCj4gaW5kZXggNmUxOTZlMDYxODFlLi42ZmZhZjU5NGJlOWQg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfdXZjLmMKPiArKysg
Yi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl91dmMuYwo+IEBAIC00ODIsNiArNDgyLDcg
QEAgdXZjX2NvcHlfZGVzY3JpcHRvcnMoc3RydWN0IHV2Y19kZXZpY2UgKnV2YywgZW51bSB1c2Jf
ZGV2aWNlX3NwZWVkIHNwZWVkKQo+ICAgICAgICAgdm9pZCAqbWVtOwo+ICAKPiAgICAgICAgIHN3
aXRjaCAoc3BlZWQpIHsKPiArICAgICAgIGNhc2UgVVNCX1NQRUVEX1NVUEVSX1BMVVM6Cj4gICAg
ICAgICBjYXNlIFVTQl9TUEVFRF9TVVBFUjoKPiAgICAgICAgICAgICAgICAgdXZjX2NvbnRyb2xf
ZGVzYyA9IHV2Yy0+ZGVzYy5zc19jb250cm9sOwo+ICAgICAgICAgICAgICAgICB1dmNfc3RyZWFt
aW5nX2NscyA9IHV2Yy0+ZGVzYy5zc19zdHJlYW1pbmc7IEBAIC01MjYsNyAKPiArNTI3LDcgQEAg
dXZjX2NvcHlfZGVzY3JpcHRvcnMoc3RydWN0IHV2Y19kZXZpY2UgKnV2YywgZW51bSB1c2JfZGV2
aWNlX3NwZWVkIHNwZWVkKQo+ICAgICAgICAgICAgICAgKyB1dmNfY29udHJvbF9lcC5iTGVuZ3Ro
ICsgdXZjX2NvbnRyb2xfY3NfZXAuYkxlbmd0aAo+ICAgICAgICAgICAgICAgKyB1dmNfc3RyZWFt
aW5nX2ludGZfYWx0MC5iTGVuZ3RoOwo+ICAKPiAtICAgICAgIGlmIChzcGVlZCA9PSBVU0JfU1BF
RURfU1VQRVIpIHsKPiArICAgICAgIGlmIChzcGVlZCA9PSBVU0JfU1BFRURfU1VQRVIgfHwgc3Bl
ZWQgPT0gVVNCX1NQRUVEX1NVUEVSX1BMVVMpIAo+ICsgewo+ICAgICAgICAgICAgICAgICBieXRl
cyArPSB1dmNfc3NfY29udHJvbF9jb21wLmJMZW5ndGg7Cj4gICAgICAgICAgICAgICAgIG5fZGVz
YyA9IDY7Cj4gICAgICAgICB9IGVsc2Ugewo+IEBAIC01NzAsNyArNTcxLDcgQEAgdXZjX2NvcHlf
ZGVzY3JpcHRvcnMoc3RydWN0IHV2Y19kZXZpY2UgKnV2YywgZW51bSB1c2JfZGV2aWNlX3NwZWVk
IHNwZWVkKQo+ICAgICAgICAgdXZjX2NvbnRyb2xfaGVhZGVyLT5iYUludGVyZmFjZU5yWzBdID0g
dXZjLT5zdHJlYW1pbmdfaW50ZjsKPiAgCj4gICAgICAgICBVVkNfQ09QWV9ERVNDUklQVE9SKG1l
bSwgZHN0LCAmdXZjX2NvbnRyb2xfZXApOwo+IC0gICAgICAgaWYgKHNwZWVkID09IFVTQl9TUEVF
RF9TVVBFUikKPiArICAgICAgIGlmIChzcGVlZCA9PSBVU0JfU1BFRURfU1VQRVIgfHwgc3BlZWQg
PT0gVVNCX1NQRUVEX1NVUEVSX1BMVVMpCj4gICAgICAgICAgICAgICAgIFVWQ19DT1BZX0RFU0NS
SVBUT1IobWVtLCBkc3QsICZ1dmNfc3NfY29udHJvbF9jb21wKTsKPiAgCj4gICAgICAgICBVVkNf
Q09QWV9ERVNDUklQVE9SKG1lbSwgZHN0LCAmdXZjX2NvbnRyb2xfY3NfZXApOyBAQCAtNzMzLDYg
Cj4gKzczNCwxNSBAQCB1dmNfZnVuY3Rpb25fYmluZChzdHJ1Y3QgdXNiX2NvbmZpZ3VyYXRpb24g
KmMsIHN0cnVjdCB1c2JfZnVuY3Rpb24gKmYpCj4gICAgICAgICAgICAgICAgIH0KPiAgICAgICAg
IH0KPiAgCj4gKyAgICAgICBpZiAoZ2FkZ2V0X2lzX3N1cGVyc3BlZWRfcGx1cyhjLT5jZGV2LT5n
YWRnZXQpKSB7Cj4gKyAgICAgICAgICAgICAgIGYtPnNzcF9kZXNjcmlwdG9ycyA9IHV2Y19jb3B5
X2Rlc2NyaXB0b3JzKHV2YywgVVNCX1NQRUVEX1NVUEVSX1BMVVMpOwo+ICsgICAgICAgICAgICAg
ICBpZiAoSVNfRVJSKGYtPnNzcF9kZXNjcmlwdG9ycykpIHsKPiArICAgICAgICAgICAgICAgICAg
ICAgICByZXQgPSBQVFJfRVJSKGYtPnNzcF9kZXNjcmlwdG9ycyk7Cj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgZi0+c3NwX2Rlc2NyaXB0b3JzID0gTlVMTDsKPiArICAgICAgICAgICAgICAgICAg
ICAgICBnb3RvIGVycm9yOwo+ICsgICAgICAgICAgICAgICB9Cj4gKyAgICAgICB9Cj4gKwo+ICAg
ICAgICAgLyogUHJlYWxsb2NhdGUgY29udHJvbCBlbmRwb2ludCByZXF1ZXN0LiAqLwo+ICAgICAg
ICAgdXZjLT5jb250cm9sX3JlcSA9IHVzYl9lcF9hbGxvY19yZXF1ZXN0KGNkZXYtPmdhZGdldC0+
ZXAwLCBHRlBfS0VSTkVMKTsKPiAgICAgICAgIHV2Yy0+Y29udHJvbF9idWYgPSBrbWFsbG9jKFVW
Q19NQVhfUkVRVUVTVF9TSVpFLCBHRlBfS0VSTkVMKTsKPiAtLQo+IDIuMTcuMQo+IAo+IAo+ICoq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioKPiBUaGlzIGVtYWlsIGFuZCBhdHRhY2htZW50cyBjb250YWluIEFtYmFyZWxs
YSBQcm9wcmlldGFyeSBhbmQvb3IgQ29uZmlkZW50aWFsIEluZm9ybWF0aW9uIGFuZCBpcyBpbnRl
bmRlZCBzb2xlbHkgZm9yIHRoZSB1c2Ugb2YgdGhlIGluZGl2aWR1YWwocykgdG8gd2hvbSBpdCBp
cyBhZGRyZXNzZWQuIEFueSB1bmF1dGhvcml6ZWQgcmV2aWV3LCB1c2UsIGRpc2Nsb3N1cmUsIGRp
c3RyaWJ1dGUsIGNvcHksIG9yIHByaW50IGlzIHByb2hpYml0ZWQuIElmIHlvdSBhcmUgbm90IGFu
IGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIGNvbnRhY3QgdGhlIHNlbmRlciBieSByZXBseSBl
bWFpbCBhbmQgZGVzdHJveSBhbGwgY29waWVzIG9mIHRoZSBvcmlnaW5hbCBtZXNzYWdlLiBUaGFu
ayB5b3UuCgpEbyB5b3UgaGF2ZSBhIHdheSB0byBkaXNhYmxpbmcgdGhpcyB0cmFpbGluZyBsZWdh
bCBzdGF0ZW1lbnQgd2hlbiBzZW5kaW5nIGVtYWlscz8KCkl0J3MgcmVhbGx5IG5vdCBhcHByb3By
aWF0ZSBmb3Igc2VuZGluZyB0byBwdWJsaWMgbWFpbGluZ2xpc3RzLCBhbmQgaWYgeW91IGFyZSBy
ZWFsbHkgYXNzZXJ0aW5nIHRoYXQgdGhpcyBwYXRjaCBpcyBjb25maWRlbnRpYWwgYW5kIHByb3By
aWV0YXJ5Ci0gdGhlbiBpdCBwcm9iYWJseSBjYW4ndCBiZSBpbnRlZ3JhdGVkIGludG8gdGhlIGtl
cm5lbCAuLi4KCi0tCktpZXJhbgoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUaGlzIEVYVEVSTkFMIGVtYWlsIGhh
cyBiZWVuIHNjYW5uZWQgYnkgUHJvb2Zwb2ludCBFbWFpbCBQcm90ZWN0IHNlcnZpY2UuCg==
