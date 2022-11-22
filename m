Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B7563349F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 06:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbiKVFGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 00:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKVFGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 00:06:41 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AB02DAAF;
        Mon, 21 Nov 2022 21:06:39 -0800 (PST)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALLZB3w021321;
        Tue, 22 Nov 2022 05:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=3HcA5MxGaRY1gf588OevGaO6eAcRtGZ9l3gM+FHDy2U=;
 b=PPO4BasAa2ZUQKaCzKMC55ibA9hDT4MRPZf4os6kLipgRBwZnEJoxponcG2dGv6WsSFp
 35ittw6FEKh8QqPwSr+IBdDi7hymZ7bEaV2aK+vg8cic9vqFqsYpmjPOnbxNIuxQF8XT
 5MBRQTOMY0RfUXtrRjUT4NIcbKS+Pg6koFp2HmCjG2Z7EOYW9nOTuWNIE6QkR/UyqdB7
 cLoNL1rRP1ejx+eiujijEYBt/KfEW8CwvVYMBBCWUIPoId+NphZOdb3c84HofgQJRJ/I
 NGmlzc6Lc6Xov/WUxV3eTrDGHe3/JY8Q8Ws8ITx5n97lsQpIgDCpaoYqEZFXr7Q3qOSV aw== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3m0ffj3hcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Nov 2022 05:06:27 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 53536801ADA;
        Tue, 22 Nov 2022 05:06:24 +0000 (UTC)
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 21 Nov 2022 17:06:19 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Mon, 21 Nov 2022 17:06:19 -1200
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 21 Nov 2022 17:06:19 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njC6eq0vB+G5gpM7n82mJ8JoukgKgeqZLVWftYvoVGGXZkUq6QUuunP2AGWOzgjLpZXLD8X0i0KxPvDfUJPhbdeVd0H8i2LjgQZLyM1A0ONZCg7MKIyy2Phmu4+X1hjTlM9alYzzRH35dVpfdZmOseU5gB+dSe6U8EzPSHhxj85gsQ1DMnn3AJnU/brMsNAWlheV6g8Ee5sLkjduD0ftODf1JnnKs8X91+EJ+Wh/PAUcEGlB/JyA+0aP2raA+ioDOlYaYc7W0kMfqKiFUFbW+AefHw6NBoIIcCbLk7klUoN06BkbxbYUYqxw+vkGqllJOeBalWcrb8CfYH75yTvxig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HcA5MxGaRY1gf588OevGaO6eAcRtGZ9l3gM+FHDy2U=;
 b=d/DXC7IP7g0c+7Q8e/Mkhw3kAPzIRFKb4aUUKZCP2+bQ5Bsln6ObLHf/ckTSrOEu/2s/tMHRQfNeCWaZT3v7GWxH86FpqMxHyNfjjC1O/KS9KSHk6557/8MuLZ9JaG0yaWQFvaRt6R7w31uJF6nGJYPTuWVMqAV8Q/a6flMJuu1bzXI+koTZrCt8887lWSpPHbkBvFwS5GBmRw0TW9kEmNgmCILW6Ccm4ZMAdYqJxgDrDFIV7G4RCz7vFyoq0WCl0Cbahfpjym9JKi77ruReVTDwTcBvNSp6jtYlTldMZsYxTgwsBRX4boBhsaQTRvczcEmnsVwYBzDYk6mtmRreWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by MW5PR84MB1643.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 05:06:18 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5511:bd85:6961:816]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5511:bd85:6961:816%9]) with mapi id 15.20.5834.011; Tue, 22 Nov 2022
 05:06:18 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "ap420073@gmail.com" <ap420073@gmail.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 10/24] crypto: x86/poly - limit FPU preemption
Thread-Topic: [PATCH v4 10/24] crypto: x86/poly - limit FPU preemption
Thread-Index: AQHY+XHqfLLvXNGxcESumjNg7U4Mn65BZh+AgAjYNxA=
Date:   Tue, 22 Nov 2022 05:06:18 +0000
Message-ID: <MW5PR84MB1842625D9ECAF4F6244F558BAB0D9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221103042740.6556-1-elliott@hpe.com>
 <20221116041342.3841-1-elliott@hpe.com>
 <20221116041342.3841-11-elliott@hpe.com> <Y3TF7/+DejcnN0eV@zx2c4.com>
In-Reply-To: <Y3TF7/+DejcnN0eV@zx2c4.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|MW5PR84MB1643:EE_
x-ms-office365-filtering-correlation-id: f06573ad-1773-4029-d4b0-08dacc474a23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AAyd1TnB6nDn+trngXFHFQz9YCXm0jpsKU+55JJccwjkkwSr19hGNPMQOnRGCEjZvslEPAgfIJSJ+wUelGYVnjM7ickqTvUrIo3SHjy0LfWrmkrOkaDy7qoF1I/4uwt0FrZ/3bEk/FjecwZkK6lKvKZizLGCF8q8O4n+4dT1qoAOvdADVn3PyFCv/sgfYreLNpMhaXDFWG59LYg+l++Rg5EFtBieHYr16NEVOc5mZT77GzcP8nXKN6difR9u9Je27tHcGmlF+/lrqcFzrdqMsJX+tOXpyPgjOaqJzaMcAUyYy7UucRSAWDarHi6Gv4WxHDExScJ+5sho4oFjgG5HRK7d8ICe7A09QQ4lydFd55KCIBhQzZZR6R2bJck5Bb0ictCMknAhRrP1lwBCzFP3UnHxSbMrmu6b7nyPRZleaiv+s5qKDkSnzFeGpjfc0+E1GfHJQ7C8Fan8g+ogFGL3SJE1DP6j06dG3WnWBMyi0+mBejDsOzpiKhoAxUdzr0rzKCSLy4mHxsmzJOHmaTNX+9xMIQL+FmQlnNUmzvRLtHaZ101ZTYwJGSvWlJwgVBvHNldRq+u8I0CY3Qw26Nds8Jwtk+Lg5MGYH3bb6Bea7RN8n2juKVvFguRIWbK4J4vIUcXyK+cA/L8iK5w/119VIIgiZPJDHwQISGLXCHrpP5xz1UMzDLk06xNxeAdyMOegtBPwYfwEXNHfom6BEXp+1jnOSOLUs9kNyXnisRXTMVs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199015)(66899015)(33656002)(86362001)(38070700005)(66476007)(55016003)(76116006)(64756008)(41300700001)(66556008)(66446008)(4326008)(316002)(8676002)(82960400001)(66946007)(122000001)(38100700002)(83380400001)(478600001)(71200400001)(966005)(45080400002)(6916009)(54906003)(26005)(52536014)(8936002)(7416002)(2906002)(5660300002)(186003)(53546011)(7696005)(6506007)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3pYVmxaQXA4NEQzR3FzOXE0cjdQRW01dlVOTlNpV29yN1cyVjV0RURNVlNN?=
 =?utf-8?B?TTNCLzFzWDlaZ1JZUVV2bVVzNFVacGVodE9VR25FRTkvdHYvNGV4WGxVc291?=
 =?utf-8?B?RGtNTnY0ZHM0eDhDU0ZYcXdaMCt6aFlNbTFjdUl1OWJVd0ZQRGRKcWNDZGg2?=
 =?utf-8?B?UVlmNE82dE8vTnh1UnFJaVJWblM4U0RmdExqY01iQnBGYkVnOG9Fak9zU3pr?=
 =?utf-8?B?bitEUlN1N2NVMkxtb1BidVd5dlFISStMbDRUUDlrMlhxOWc3MDB3M1BFK3Uy?=
 =?utf-8?B?cThBSUhaMnpQZVZsL1pseUtoclE0SGJSSnp4VGJuTVdCT29sWUdLVzdPZWtQ?=
 =?utf-8?B?TGtQWExUVUZwVXQ2Y2RaMnVuUEVOUmlhWVMyY2swNFFCb05YNVFibEJ3a2xB?=
 =?utf-8?B?dWhDdTJlWnVremxhUzlNTnpHN1QzR3ZSM08yYWNaWWN6N0hUZ1FJVE9HNUFq?=
 =?utf-8?B?cTZkUWVJY0ZvSWM1N1BWSVQ4aUtmMWJLak4rbWV2NjdhYStmK2pGRUJiOEtW?=
 =?utf-8?B?RUZMWW4rKytmcUk4YXcxekMwempzYUpQMlpKcGZ4NmwxTWcvMmV1N0NnR1JZ?=
 =?utf-8?B?SVJQWDRVVEpqOEp5M01xcHY3eE8wQnk4WnR3eVBLd3ZLUHR6TmVDMlc4N2FS?=
 =?utf-8?B?S2JaRmdrZlptMTVITTFiaitkZ2FXQlA0WTI3cmIwVTdkSGdEcnF3cTJxVmRr?=
 =?utf-8?B?ZzdScllwMWJ2cG1nZDlzZWJrYjN2amJmdDFZV0hxTjF4OENjK0IvalZWTE1S?=
 =?utf-8?B?a2R1VWkxRERJMW1LWVAxdHQ4WU5nVlV6L2dFR0J2TklsZzlYRTNVM1cyVlNz?=
 =?utf-8?B?TnBDR2g0Q1ZvOGFJejlKWjFyMTJ0NTJwK2lUTUVhMWRsOWtjeXVGUUxoekpK?=
 =?utf-8?B?SVI5UUhSUU01MXRhbldXU2hnT3F5U0puQ0hOaG5jY01FN3B0NHFsVmVoekZx?=
 =?utf-8?B?QzZoZUIrSzVXYWp2Q0pmS3pEK3JybGxtMWloMnIzOHJ6OWZGczV2djlTOURr?=
 =?utf-8?B?MVZPRzkvb281V2hOK0xleXZpRTgxSndCZFZwVU9mVDlmOFFxeE8zZ1RoZE5l?=
 =?utf-8?B?VVJLR3NxaWdiK25WUTdzREdvQlZTaGhUNEF0QVNQM2VEZUg1WHVVbnpRa05v?=
 =?utf-8?B?Y1RyT1hRbkFxeFhzWCtPakFxd2Q2Y2NhblFHWlVEdlVjcVl4ZlpmU2p5QTNk?=
 =?utf-8?B?Q01lbFdEejdHK1FsRmswVGNRZGxQdVNGWmkvRWJkTWkwdEVkQkdqNDgwenBD?=
 =?utf-8?B?TC9LYlNlOEF5dXVwMW1Sa2tySXpVd2pqdzQ2MU9OcWV5YlROSi9ZZ24xNFIr?=
 =?utf-8?B?SmFCa1FDVk1kNFMrZ3ZlQVJMb2p5bUx1ZVpCRnllMmJ3SVoraUwxM081WjdU?=
 =?utf-8?B?OEU5aHlndXVVY1pWV1NVZkZqanpiVEhhbEIyQkJGdGxsQzArYnB6WWlMQzFw?=
 =?utf-8?B?eHZ6RkM4c1hITUhBVEJoencvbEM4MnR6QnZTd3orNXYzaHkyRUdjdmdhVEl5?=
 =?utf-8?B?aW5rMm1GelBoaVBjYnNDUGNxaDlyQTJ1ODlaQVdXR2UyNUhKbTVodFcrY1NF?=
 =?utf-8?B?alB5blNMWTVzNFBRZGJVczdHSitpck9EVDh4WUJNd1FwOFJSL3VvSS9SRmhW?=
 =?utf-8?B?VWY5dUtzSjVnZ0ZaY1Y2czRmTjdoZWZ0NnA0MGpvYXJmN1ZqdndwQ3NBaUFM?=
 =?utf-8?B?d0duSnVPVFQ0dnVYQmo0RDZvZ2ttTWl3aStVL3AwbnZPMHJQZjJ0RmpuR2VH?=
 =?utf-8?B?b1NCMGNBRUJVUkt0eUFHTG1ySHFFaWE4MEFMNkYwc3NjNnZDK0ltRDRRaFFX?=
 =?utf-8?B?bzJPWjhNcW0rYzRpTktWMmM5T2dmMnZ5TUpyT2RzQTJsL3FJUitSdE9KUkVP?=
 =?utf-8?B?U2EyVlMzNlBTQjl4YW04L0NIZko5d0hlazUrOHZVTC9OYmJaN3NuMjQzQkFy?=
 =?utf-8?B?L0JIYlA1RHFBbkJ1aDJPTmw2VXh2L2N6RzEzdzFhY1dtU0FlcERaN3hQVC80?=
 =?utf-8?B?OVBoVkJ2TEg5cTZWaGdHVXQxZTV4TzVkL3lOdUlRVy9XSDMxN3pUbXJDVWwz?=
 =?utf-8?B?bmJBVkQ5TG5TT2ZWbHQ3Yll5VzFaQy9yY1lsUjFobks1SThvbktBN2Z6VXhm?=
 =?utf-8?Q?H9u4=3D?=
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f06573ad-1773-4029-d4b0-08dacc474a23
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2022 05:06:18.4640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jewxgjUN29FXVRtM9WhAlXwCYczrAppFsxpJhmnCR0zEbco9u3O/MDv7PKxNP+dV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1643
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: 7H_9YIigS24kDuzbi0Q7i_JuNvdM7LFU
X-Proofpoint-GUID: 7H_9YIigS24kDuzbi0Q7i_JuNvdM7LFU
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_02,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211220037
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gQS4gRG9uZW5m
ZWxkIDxKYXNvbkB6eDJjNC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMTYsIDIw
MjIgNToxNCBBTQ0KPiBUbzogRWxsaW90dCwgUm9iZXJ0IChTZXJ2ZXJzKSA8ZWxsaW90dEBocGUu
Y29tPg0KPiBDYzogaGVyYmVydEBnb25kb3IuYXBhbmEub3JnLmF1OyBkYXZlbUBkYXZlbWxvZnQu
bmV0Ow0KPiB0aW0uYy5jaGVuQGxpbnV4LmludGVsLmNvbTsgYXA0MjAwNzNAZ21haWwuY29tOyBh
cmRiQGtlcm5lbC5vcmc7DQo+IERhdmlkLkxhaWdodEBBQ1VMQUIuQ09NOyBlYmlnZ2Vyc0BrZXJu
ZWwub3JnOyBsaW51eC0NCj4gY3J5cHRvQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDEwLzI0XSBjcnlwdG86IHg4
Ni9wb2x5IC0gbGltaXQgRlBVIHByZWVtcHRpb24NCj4gDQo+IE9uIFR1ZSwgTm92IDE1LCAyMDIy
IGF0IDEwOjEzOjI4UE0gLTA2MDAsIFJvYmVydCBFbGxpb3R0IHdyb3RlOg0KPiA+ICsvKiBhdm9p
ZCBrZXJuZWxfZnB1X2JlZ2luL2VuZCBzY2hlZHVsZXIvcmN1IHN0YWxscyAqLw0KPiA+ICtzdGF0
aWMgY29uc3QgdW5zaWduZWQgaW50IGJ5dGVzX3Blcl9mcHUgPSAzMzcgKiAxMDI0Ow0KPiA+ICsN
Cj4gDQo+IFVzZSBhbiBlbnVtIGZvciBjb25zdGFudHMgbGlrZSB0aGlzOg0KPiANCj4gICAgIGVu
dW0geyBCWVRFU19QRVJfRlBVID0gLi4uIH07DQo+IA0KPiBZb3UgY2FuIGV2ZW4gbWFrZSBpdCBm
dW5jdGlvbi1sb2NhbCwgc28gaXQncyBuZWFyIHRoZSBjb2RlIHRoYXQgdXNlcyBpdCwNCj4gd2hp
Y2ggd2lsbCBiZXR0ZXIganVzdGlmeSBpdHMgZXhpc3RlbmNlLg0KDQpVc2luZyBjcmMzMmMtaW50
ZWwgYXMgYW4gZXhhbXBsZSwgdGhlIGdjYyAxMi4yLjEgYXNzZW1ibHkgb3V0cHV0IGlzIHRoZQ0K
c2FtZSBmb3I6DQoNCjEuIGNvbnN0IHZhcmlhYmxlIHBlci1tb2R1bGUNCglzdGF0aWMgY29uc3Qg
dW5zaWduZWQgaW50IGJ5dGVzX3Blcl9mcHUgPSA4NjggKiAxMDI0Ow0KMi4gZW51bSBwZXItbW9k
dWxlDQoJZW51bSB7IGJ5dGVzX3Blcl9mcHUgPSA4NjggKiAxMDI0IH0gOw0KMy4gZW51bSBwZXIg
ZnVuY3Rpb24gKF91cGRhdGUgYW5kIF9maW51cCkNCgllbnVtIHsgYnl0ZXNfcGVyX2ZwdSA9IDg2
OCAqIDEwMjQgfSA7DQoNCkVhY2ggZnVuY3Rpb24gZ2V0cyBhIG1vdmwgaW5zdHJ1Y3Rpb24gd2l0
aCB0aGF0IGNvbnN0YW50LCBhbmQgaGFzIHRoZQ0Kc2FtZSBjb21wYXJlLCBhZGQsIHN1YnRyYWN0
LCBhbmQganVtcCBpbnN0cnVjdGlvbnMuDQoNCiMgLi4vYXJjaC94ODYvY3J5cHRvL2NyYzMyYy1p
bnRlbF9nbHVlLmM6MTk4OiAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgY2h1bmsgPSBt
aW4obGVuLCBieXRlc19wZXJfZnB1KTsNCiAgICAgICAgbW92bCAgICAkODg4ODMyLCAlZWF4ICAg
IywgdG1wMTI3DQoNCiMgLi4vYXJjaC94ODYvY3J5cHRvL2NyYzMyYy1pbnRlbF9nbHVlLmM6MTcx
OiAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgY2h1bmsgPSBtaW4obGVuLCBieXRlc19w
ZXJfZnB1KTsNCiAgICAgICAgbW92bCAgICAkODg4ODMyLCAlcjEzZCAgIywgdG1wMTI4DQoNClNp
bmNlIGVudW0gZG9lc24ndCBndWFyYW50ZWUgYW55IHBhcnRpY3VsYXIgdHlwZSwgdGhvc2UgdmFy
aWF0aW9ucw0KdXBzZXQgdGhlIG1pbigpIG1hY3JvLiBtaW5fdCgpIGlzIG5lY2Vzc2FyeSB0byBl
bGltaW5hdGUgdGhlDQpjb21waWxlciB3YXJuaW5nLg0KDQouLi9hcmNoL3g4Ni9jcnlwdG8vY3Jj
MzJjLWludGVsX2dsdWUuYzogSW4gZnVuY3Rpb24g4oCYY3JjMzJjX3BjbF9pbnRlbF91cGRhdGXi
gJk6DQouLi9hcmNoL3g4Ni9jcnlwdG8vY3JjMzJjLWludGVsX2dsdWUuYzoxNzE6OTc6IHdhcm5p
bmc6IGNvbXBhcmlzb24gb2YgZGlzdGluY3QgcG9pbnRlciB0eXBlcyBsYWNrcyBhIGNhc3QNCiAg
MTcxIHwgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IGNodW5rID0gbWluKGxl
biwgYnl0ZXNfcGVyX2ZwdSk7DQoNCj4gQWxzbywgd2hlcmUgZGlkIHlvdSBnZXQgdGhpcyBudW1i
ZXI/IFNlZW1zIGtpbmQgb2Ygd2VpcmQuDQoNCkFzIGRlc2NyaWJlZCBpbiByZXBsaWVzIG9uIHRo
ZSB2MiBwYXRjaGVzLCBJIGNyZWF0ZWQgYSB0Y3J5cHQgdGVzdCB0aGF0DQpydW5zIGVhY2ggYWxn
b3JpdGhtIG9uIGEgMSBNaUIgYnVmZmVyIHdpdGggbm8gbG9vcCBsaW1pdHMgKGFuZCBpcnFzDQpk
aXNhYmxlZCksICBwaWNrcyB0aGUgYmVzdCByZXN1bHQgb3V0IG9mIDEwIHBhc3NlcywgYW5kIGNh
bGN1bGF0ZXMgdGhlDQpudW1iZXIgb2YgYnl0ZXMgdGhhdCBub21pbmFsbHkgZml0IGluIDMwIHVz
IChvbiBhIDIuMiBHSHogQ2FzY2FkZQ0KTGFrZSBDUFUpLg0KDQpBY3R1YWwgcmVzdWx0cyB3aXRo
IHRob3NlIHZhbHVlcyB2YXJ5IGZyb20gMzcgdG8gMTAyIHVzOyBpdCBpcyBtdWNoDQpiZXR0ZXIg
dGhhbiBydW5uaW5nIHVubGltaXRlZCwgYnV0IHN0aWxsIGltcGVyZmVjdC4NCg0KaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGttbC9NVzVQUjg0TUIxODQyODRGQkVENjNFMkQwNDNDOTNBNkZBQjM2
OUBNVzVQUjg0TUIxODQyLk5BTVBSRDg0LlBST0QuT1VUTE9PSy5DT00vDQoNClRoZSBoYXNoIGFs
Z29yaXRobXMgc2VlbSB0byBjb25ncmVnYXRlIGFyb3VuZCB0aHJlZSBzcGVlZHM6DQotIHNsb3c6
IDEwIHRvIDIwIEtpQiBmb3Igc2hhKiBhbmQgc20zDQotIG1lZGl1bTogMjAwIHRvIDQwMCBLaUIg
Zm9yIHBvbHkqDQotIGZhc3Q6IDYwMCB0byA4MDAgS2lCIGZvciBjcmMqDQoNCnNvIGl0IG1pZ2h0
IGJlIHByZWZlcmFibGUgdG8ganVzdCBnbyB3aXRoIHRocmVlIHZhbHVlcyAoZS5nLiwgMTYsIDI1
NiwgYW5kDQo1MTIgS2lCKS4gVGhlcmUncyBhIGxvdCBvZiB2YXJpYWJpbGl0eSBpbiBDUFUgYXJj
aGl0ZWN0dXJlLCBDUFUgc3BlZWRzLCBhbmQNCm90aGVyIHN5c3RlbSBhY3Rpdml0eSB0aGF0IG1h
a2UgdGhpcyBpbXBvc3NpYmxlIHRvIHBlcmZlY3QuDQoNCkl0J2QgYmUgaWRlYWwgaWYgdGhlIGxv
b3BzIGNoZWNrZWQgdGhlIENQVSBjeWNsZSBjb3VudCByYXRoZXIgdGhhbg0Kd29ya2VkIG9uIGEg
Ynl0ZSBjb3VudCwgYnV0IHRoZSBSRFRTQyBpbnN0cnVjdGlvbiBpcyBub3RvcmlvdXNseSBzbG93
IGFuZA0Kd291bGQgc2xvdyBkb3duIG92ZXJhbGwgcGVyZm9ybWFuY2UuDQoNClRoZSBSQUlENiBs
aWJyYXJ5IHN1cHBvcnRzIHJ1bm5pbmcgYSBiZW5jaG1hcmsgZHVyaW5nIGVhY2ggYm9vdCB0byBw
aWNrDQp0aGUgYmVzdCBpbXBsZW1lbnRhdGlvbiB0byB1c2UgKG5vdCBhbHdheXMgZW5hYmxlZCk6
DQpbICAgIDMuMzQxMzcyXSByYWlkNjogc2tpcHBlZCBwcSBiZW5jaG1hcmsgYW5kIHNlbGVjdGVk
IGF2eDUxMng0DQoNClRoZSBjcnlwdG8gc3Vic3lzdGVtIGRvZXMgc29tZXRoaW5nIHNpbWlsYXIg
d2l0aCBpdHMgc2VsZi10ZXN0cywgd2hpY2ggY291bGQNCmJlIGV4cGFuZGVkIHRvIGluY2x1ZGUg
c3BlZWQgdGVzdHMgdG8gdHVuZSB0aGUgbG9vcCB2YWx1ZXMuIEhvd2V2ZXIsIHRoYXQgDQpzbG93
cyBkb3duIGJvb3QgYW5kIGNvdWxkIGJlIG1pc2xlZCBieSBhbiBOTUkgb3IgU01JIGR1cmluZyB0
aGUgdGVzdCwgd2hpY2gNCmNvdWxkIGxlYWQgdG8gZXZlbiB3b3JzZSByZXN1bHRzLg0KDQpUaGUg
c2VsZWN0ZWQgdmFsdWVzIGNvdWxkIGJlIGtlcHQgaW4gZWFjaCBmaWxlIG9yIHB1dCBpbiBhIHNo
YXJlZCAuaCBmaWxlLg0KQm90aCBhcHByb2FjaGVzIHNlZW0gZGlmZmljdWx0IHRvIG1haW50YWlu
Lg0KDQpUaGUgcG93ZXJwYyBtb2R1bGVzIGhhdmUgcGFyYWdyYXBoLXNpemVkIGNvbW1lbnRzIGV4
cGxhaW5pbmcgdGhlaXIgTUFYX0JZVEVTDQptYWNyb3MgKGUuZy4sIGluIGFyY2gvcG93ZXJwYy9j
cnlwdG8vc2hhMjU2LXNwZS1nbHVlLmMpIHRoYXQgbWlnaHQgYmUgYSBnb29kDQptb2RlbCBmb3Ig
ZG9jdW1lbnRpbmcgdGhlIHZhbHVlczoNCgkgKiBNQVhfQllURVMgZGVmaW5lcyB0aGUgbnVtYmVy
IG9mIGJ5dGVzIHRoYXQgYXJlIGFsbG93ZWQgdG8gYmUgcHJvY2Vzc2VkDQoJICogYmV0d2VlbiBw
cmVlbXB0X2Rpc2FibGUoKSBhbmQgcHJlZW1wdF9lbmFibGUoKS4gU0hBMjU2IHRha2VzIH4yLDAw
MA0KCSAqIG9wZXJhdGlvbnMgcGVyIDY0IGJ5dGVzLiBlNTAwIGNvcmVzIGNhbiBpc3N1ZSB0d28g
YXJpdGhtZXRpYyBpbnN0cnVjdGlvbnMNCgkgKiBwZXIgY2xvY2sgY3ljbGUgdXNpbmcgb25lIDMy
LzY0IGJpdCB1bml0IChTVTEpIGFuZCBvbmUgMzIgYml0IHVuaXQgKFNVMikuDQoJICogVGh1cyAx
S0Igb2YgaW5wdXQgZGF0YSB3aWxsIG5lZWQgYW4gZXN0aW1hdGVkIG1heGltdW0gb2YgMTgsMDAw
IGN5Y2xlcy4NCgkgKiBIZWFkcm9vbSBmb3IgY2FjaGUgbWlzc2VzIGluY2x1ZGVkLiBFdmVuIHdp
dGggdGhlIGxvdyBlbmQgbW9kZWwgY2xvY2tlZA0KCSAqIGF0IDY2NyBNSHogdGhpcyBlcXVhbHMg
dG8gYSBjcml0aWNhbCB0aW1lIHdpbmRvdyBvZiBsZXNzIHRoYW4gMjd1cy4NCg0KDQoNCj4gPiAg
YXNtbGlua2FnZSB2b2lkIG5oX2F2eDIoY29uc3QgdTMyICprZXksIGNvbnN0IHU4ICptZXNzYWdl
LCBzaXplX3QNCj4gbWVzc2FnZV9sZW4sDQo+ID4gIAkJCXU4IGhhc2hbTkhfSEFTSF9CWVRFU10p
Ow0KPiA+DQo+ID4gQEAgLTI2LDE4ICsyOSwyMCBAQCBzdGF0aWMgdm9pZCBfbmhfYXZ4Mihjb25z
dCB1MzIgKmtleSwgY29uc3QgdTgNCj4gKm1lc3NhZ2UsIHNpemVfdCBtZXNzYWdlX2xlbiwNCj4g
PiAgc3RhdGljIGludCBuaHBvbHkxMzA1X2F2eDJfdXBkYXRlKHN0cnVjdCBzaGFzaF9kZXNjICpk
ZXNjLA0KPiA+ICAJCQkJICBjb25zdCB1OCAqc3JjLCB1bnNpZ25lZCBpbnQgc3JjbGVuKQ0KPiA+
ICB7DQo+ID4gKwlCVUlMRF9CVUdfT04oYnl0ZXNfcGVyX2ZwdSA9PSAwKTsNCj4gDQo+IE1ha2Ug
dGhlIGNvbnN0YW50IGZ1bmN0aW9uIGxvY2FsIGFuZCByZW1vdmUgdGhpcyBjaGVjay4NCg0KVGhh
dCBqdXN0IG1ha2VzIHN1cmUgc29tZW9uZSBlZGl0aW5nIHRoZSBzb3VyY2UgY29kZSBkb2Vzbid0
IHBpY2sgYSB2YWx1ZSB0aGF0DQp3aWxsIGNhdXNlIHRoZSBsb29wcyB0byBoYW5nOyBpdCdzIHN0
cm9uZ2VyIHRoYW4gYSBjb21tZW50IHNheWluZyAiZG9uJ3Qgc2V0DQp0aGlzIHRvIDAiLiBJdCdz
IG9ubHkgYSBjb21waWxlLXRpbWUgY2hlY2ssIGFuZCBkb2Vzbid0IHJlc3VsdCBpbiBhbnkNCnRo
ZSBhc3NlbWJseSBsYW5ndWFnZSBvdXRwdXQgdGhhdCBJIGNhbiBzZWUuDQogDQo+ID4gKzcNCj4g
PiAgCWlmIChzcmNsZW4gPCA2NCB8fCAhY3J5cHRvX3NpbWRfdXNhYmxlKCkpDQo+ID4gIAkJcmV0
dXJuIGNyeXB0b19uaHBvbHkxMzA1X3VwZGF0ZShkZXNjLCBzcmMsIHNyY2xlbik7DQo+ID4NCj4g
PiAtCWRvIHsNCj4gPiAtCQl1bnNpZ25lZCBpbnQgbiA9IG1pbl90KHVuc2lnbmVkIGludCwgc3Jj
bGVuLCBTWl80Syk7DQo+ID4gKwl3aGlsZSAoc3JjbGVuKSB7DQo+IA0KPiBEb2VzIHRoaXMgYWRk
IGEgbmVlZGxlc3MgYWRkaXRpb25hbCBjaGVjayBvciBkb2VzIGl0IGdlbmVyYXRlIGJldHRlcg0K
PiBjb2RlPyBXb3VsZCBiZSBuaWNlIHRvIGhhdmUgc29tZSBleHBsYW5hdGlvbiBvZiB0aGUgcmF0
aW9uYWxlLg0KDQpFYWNoIG1vZHVsZSdzIGFzc2VtYmx5IGZ1bmN0aW9uIGNhbiBoYXZlIGRpZmZl
cmVudCBoYW5kbGluZyBvZg0KLSBsZW5ndGggMA0KLSBsZW5ndGggPCBibG9jayBzaXplDQotIGxl
bmd0aCA8IHNvbWUgbWluaW11bSBsZW5ndGgNCi0gbGVuZ3RoIDwgYSBwZXJmb3JtYW5jZSBzd2l0
Y2hvdmVyIHBvaW50DQotIGxlbmd0aCBub3QgYSBtdWx0aXBsZSBvZiBibG9jayBzaXplDQotIGN1
cnJlbnQgYnVmZmVyIHBvaW50ZXIgbm90IGFsaWduZWQgdG8gYmxvY2sgc2l6ZQ0KU29tZXRpbWVz
IHRoZSBDIGdsdWUgbG9naWMgY2hlY2tzIHZhbHVlcyB1cGZyb250OyBzb21ldGltZXMNCml0IGRv
ZXNuJ3QuDQoNClRoZSB3aGlsZSBsb29wcyBoZWxwIGdldCB0aGVtIHRvIGZvbGxvdyBvbmUgb2Yg
dHdvIHBhdHRlcm5zOg0KCXdoaWxlIChsZW5ndGgpDQpvcg0KCXdoaWxlIChsZW5ndGggPj0gQkxP
Q0tfU0laRSkNCg0KYW5kIHNpZGVzdGVwIHNvbWUgb2YgdGhlIHNwZWNpYWwgaGFuZGxpbmcgY29u
Y2VybnMuDQoNClBlcmZvcm1hbmNlLXdpc2UsIHRoZSBwYXRjaGVzIGFyZSBlaXRoZXIgDQotIGFk
ZGluZyBsb3RzIG9mIGtlcm5lbF9mcHVfYmVnaW4oKSBhbmQga2VybmVsX2ZwdV9lbmQoKSBjYWxs
cyANCiAgKGFsbCB0aGUgb25lcyB0aGF0IHdlcmUgcnVubmluZyB1bmxpbWl0ZWQpDQotIHJlbW92
aW5nIGxvdHMgb2Yga2VybmVsX2ZwdV9iZWdpbigpIGFuZCBrZXJuZWxfZnB1X2VuZCgpIGNhbGxz
DQogIChlLmcuLCBwb2x5dmFsIHJlbGF4ZWQgZnJvbSA0IEtpQiB0byAzODMgS2lCKQ0KDQp3aGlj
aCBpcyBtdWNoIG1vcmUgaW1wYWN0ZnVsIHRoYW4gdGhlIGNvbW1vbiB3aGlsZSBsb29wIGVudHJ5
Lg0KDQpJIGNyZWF0ZWQgdGNyeXB0IHRlc3RzIHRoYXQgdHJ5IGxlbmd0aHMgYXJvdW5kIGFsbCB0
aGUgc3BlY2lhbA0KdmFsdWVzIGxpa2UgMCwgMTYsIDQwOTYsIGFuZCB0aGUgc2VsZWN0ZWQgYnl0
ZXMgcGVyIEZQVSBzaXplDQooY29tcGFyaW5nIHJlc3VsdHMgdG8gdGhlIGdlbmVyaWMgYWxnb3Jp
dGhtcyBsaWtlIHRoZSBleHRlbmRlZA0Kc2VsZi10ZXN0cyksIHNvIEkgdGhpbmsgdGhlc2UgbG9v
cHMgYXJlIGZ1bmN0aW9uYWxseSBjb3JyZWN0DQooSSd2ZSBmb3VuZCB0aGF0IHZpb2xhdGluZyB0
aGUgdW5kb2N1bWVudGVkIGFzc3VtcHRpb25zIG9mIHRoZQ0KYXNzZW1ibHkgZnVuY3Rpb25zIGlz
IGEgZ29vZCB3YXkgdG8gZXhlcmNpc2UgUkNVIHN0YWxsDQpyZXBvcnRpbmcpLg0KDQoNCg0K
