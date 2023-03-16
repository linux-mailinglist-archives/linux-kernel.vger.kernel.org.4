Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311B76BC245
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 01:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjCPAPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 20:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjCPAP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 20:15:26 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEB041B6B;
        Wed, 15 Mar 2023 17:15:23 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FLcRRv032539;
        Thu, 16 Mar 2023 00:15:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=TeKBxengrxv9NUmsoSmmenwH6npEz9ZEixFTvxnWsIc=;
 b=FObfjfkr5KnXbSCBaG0J4lC6SaN8BBPiE9tkCeVcAOG2g9GzZ4Yy8fv0ySXzk8O18XXU
 Rs1akwUTFoJQP8ehdblObj5/O5rAn1F4jr7zBWdfxAYEh17rQ17HchbT4ZvK7ZpSDkNK
 CkBNBapjYlD+KEgaw9GUNXUQude+W1YmGlhPqZDNRNDgSvCBQz8xSLQQ9RSDYJfTsWG9
 SR/KedT2+3jprNtDPd2qcwY1UtDFmpp8bYKy+tZ9pgKVgwYjLeH/Lcg0VhjOSFdUoyUX
 w4GBB2BGpnz1WalknpN6jbiTf4rBmNvMozVRZfu+P6PvGPW4a38i/GZ9F930JjUKYo7H AA== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3pbp3x0ue8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 00:15:18 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 88835805E1E;
        Thu, 16 Mar 2023 00:15:17 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 15 Mar 2023 12:15:17 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36
 via Frontend Transport; Wed, 15 Mar 2023 12:15:17 -1200
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 16 Mar 2023 00:15:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDszlYBtHPaJsRo7yCMgiH+2YYHDUtZuir3/tiDD3lwQ5jHnxTUH0lgCUzJft7aHZ5z8gN6as/yriKnm4Crd6d1BWvH8zRKT5SECDwX9Z0vJAuhDH7brm+4U9zIl7bfl6BvGH0tlyn1NEeY5Mg/svO8mTYq4NUiW31r2vS7oecUej/bm/NT4ayyBaEYiC1ZTMSS/FEoZ+FhNbS1gZdLItX9TSLAb7Hu+YG7wOQUb7OV9w7ysw4Fft4ucRisde1AJn+7XKyyDI0wKOp2Kuz/OxPj1GSnP/SijBXs9Qry2TOKwGEjahKbD8ZH3EHJAsB2eCXUp0eKscHTXI+es08+jSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeKBxengrxv9NUmsoSmmenwH6npEz9ZEixFTvxnWsIc=;
 b=hRSprWvvQLDZcTIvgkbrzfQ2xi5/xUiA/Qp1tX41bbaw8iGZExchqX8OUpKQdASoDob4PKEiIKCF4tdakAPoHGf3oMo2l6LnTa+nmX3Bgtz4VO7AeUNAUgNqvpKDjoC4Z3Gx4f7txH4kRWX4yWCRhSOvmCTxTNtJu4vVoakdj9c7k+7rEYX8osT9oYwXwQVX8cDeTsGKzWUynsTqaJ8X5WCLDU6KfrprdE3grHzYz5wDBAzwrsmB37i53CEx4lM8QENMGAhD20oQbjOpEfIp564wtF18Tcf42FTxLauM+F/zJi8Hj4pzeZ+EvPvkia6Ji6PVhBLL9J2HlX8/wdaCGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1373.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:48::7) by
 PH0PR84MB1574.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:171::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Thu, 16 Mar
 2023 00:15:15 +0000
Received: from DM4PR84MB1373.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::7040:7ebe:4715:31fe]) by DM4PR84MB1373.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::7040:7ebe:4715:31fe%7]) with mapi id 15.20.6178.026; Thu, 16 Mar 2023
 00:15:15 +0000
From:   "Seymour, Shane M" <shane.seymour@hpe.com>
To:     "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH for-next] scsi: Implement host state statistics
Thread-Topic: [PATCH for-next] scsi: Implement host state statistics
Thread-Index: AdlW08zNHKI7PyClSKC1+KomWCdnWgANKaCAAArrTwAAF6fJQA==
Date:   Thu, 16 Mar 2023 00:15:15 +0000
Message-ID: <DM4PR84MB137383C5042F6554636774B6FDBC9@DM4PR84MB1373.NAMPRD84.PROD.OUTLOOK.COM>
References: <DM4PR84MB1373DCD07EABD28D88129C50FDBF9@DM4PR84MB1373.NAMPRD84.PROD.OUTLOOK.COM>
         <ZBFnYwtr+2bfjvcY@kroah.com>
 <0be9002bbc7feea0bfd0dc8ad2dccc52bbf34834.camel@linux.ibm.com>
In-Reply-To: <0be9002bbc7feea0bfd0dc8ad2dccc52bbf34834.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1373:EE_|PH0PR84MB1574:EE_
x-ms-office365-filtering-correlation-id: 34426537-bf25-4d99-d598-08db25b38456
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ij5DbCoy0sZ/XOVScB9hA9PeLoNcySw/EkbQysiYUNtQmRebFoGIQTtpSMBbUQ79FBBr3xsg8oHWe840ii10pzcI36QalCyJ4zDJd9CFmhbVBc8zBSGoQOVr4Iy3hbozn0Jv074tvHsAvuiMIzy4/t9nZBv+wynvjGU+VoY+Pnn7Q0USKAT3albli6WibQiTXPkBJCfjsUnYPj8YcEYk8ieF7UgWLPs8xcogOng+cMYDOva9of+kHBR5cWhx7QNOQcP7I2MLlTL8poxrlGNGNMzFIgvVoyJ3/1wVfcqYdwgIWYP94AcIG32co6sEkvQzv1mRJ0p/lQZZ4HGVawj/yef31airtcPq4gVNqDXLU1filnsvEOEfemoIHQEXNnaeHae05dxE1ii8HRTvX4DTEs1dLzIrqY2QNdXlS7yJ4IM4ZwNQaOo/Nhr9erTDrgzbp3mJm5oTKgQC/Ww+iZOEz3XEkugWdL+YRiHIKER6UlLlBDFt8AK8eipkTA1DonPC0bQSdc0UnCGyK9eGTJUgTZ2G9rcPDroVeiFRmnsHxILv2Jwfwwd2joUkwTzsPo9gqclkdVmeoJ7Ungi12fXQQs8amGl9WOElSNJAIwhfbu5ACe1lHgCtkGngJHSSxN3Ow4svD41Ib8g7rKWg87RQNJNG/ErlwK0i/1E82YAQMywaTJ1CKg5pUJ/h47x91+y64ogziFR6JBwPENCdqoNddA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1373.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199018)(7696005)(5660300002)(8936002)(38070700005)(2906002)(52536014)(41300700001)(38100700002)(122000001)(82960400001)(86362001)(55016003)(71200400001)(33656002)(64756008)(66556008)(66446008)(66946007)(66476007)(8676002)(478600001)(76116006)(4326008)(316002)(110136005)(9686003)(26005)(54906003)(186003)(83380400001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGdHYnhRcy8ya21ZS3lDc2QzQmlvbjN3a3lYUklDd1BPeXJVK0JsS1VPRGJR?=
 =?utf-8?B?MkdReXduZXRFd290YWpIdHp3NTFjWm04eGoxRzNTTC91N2QwekFyc2RzRnpO?=
 =?utf-8?B?bEIwZW5HSnhMWlg1VytKUkVVME8vNVJMd3VsMVJtT1FpV3BuOG9VdThqYlg0?=
 =?utf-8?B?Z1ZZYTVJbjluRks2MkZYU0FBNUhPeFdqcDVhQU1hTnJkb2cvdDF4M0s0ejF2?=
 =?utf-8?B?a2I2bVN1WGdhWDZmRGdBc3pMcDBCWTFuaEVzWlkwancxbE50c1l4Z1hhRWtt?=
 =?utf-8?B?TXc3YW93Y3M3LzU5dUpweGtBTlZpMjN3ZmoyQ1VvUUx5ckQxNHIvUEY1WWM3?=
 =?utf-8?B?VC82V1p5eVdZamwzdDkvdjFMV0JQN3BtRG92MDQ4WjZYUXZiMmRtOE45ODls?=
 =?utf-8?B?UXJQTW1OcGUvT0ZpWXZ2dExibE9kcXBCbC9rL2VxUnAyVjBwTVU1ZmdkVHl6?=
 =?utf-8?B?WmhFdHlFVlhsOU0wVUJCT0hmcm5rV1QrOHBUaVRCSXgvaHRwVklOTlZzSGYx?=
 =?utf-8?B?WlhITzEwUU1uMnVJaEhOdHdnTUp1UXVjbzR3ZHNYeGUrS0g5N3I4dkY0ODBN?=
 =?utf-8?B?R0Q5b1RVN1JtSjIrVGVJd1ZTeWZGKzlvSnVqK0paZWw3SXBNSWFTSklFaHc5?=
 =?utf-8?B?U0FTbTZCbzVuZzRrRUIvb3B1VnJpUXJXVmRzTlRib1FOZWhxdUVqM05DNGw1?=
 =?utf-8?B?OUg3NXZ4MjJUYmN1SDN1RTFycGFIVTBWa1VxZFpGclRzZnRXb1JGck14c0VW?=
 =?utf-8?B?VXJ3aVJrV0FaNndYRjMvYWlGWDl0bU1HZ3JKczhvQ21vcGlPR1lONnNVT0Vu?=
 =?utf-8?B?VC9pNkZqb2ZHRHJNUkdscnBtbmk1NHVPdVBFTUlwUk1xakxxMXVXWEhHdUl5?=
 =?utf-8?B?QnE5blJLYlZheEJUQUFiS0hmb0sydFBIRDFjSzdBZTBsVFhWcVNNUjhTMjBW?=
 =?utf-8?B?TUpHeUZwMmx5VWpCMHpUTEdzQWtCdlFxQ3h4T2o2bktDUFRLUkgyQVQybWVj?=
 =?utf-8?B?T0F4b0t6dnNXM2wwbTB1QjJCNXB1WlZzK1ZzeVpBT1UzMDltSThrQ2dWRTBp?=
 =?utf-8?B?eXNXdXovQ3lPakUxd1pkRXFxWEJNUzU1OEtnM0RwRnkyS25tNExhK3BXNFk5?=
 =?utf-8?B?YzNUN0k3T3EySFRteEhVRFRmcy9EWWE5ZitzVEU0RjJNcVIyTXFuaEVkd2Rn?=
 =?utf-8?B?QVR4TDlRd1JQWStRcy9zcVpzekh6bzJVODlQVW9vTytmaWR6ZnMwRFAyTE9o?=
 =?utf-8?B?SjFseU5QMlhkM1FtUzcvRmNXVTFyTkR0T0pERE1HTjNrMjZ0eGRzaytrdEpC?=
 =?utf-8?B?QVpZRW9DK2d5SXRhMjlDNUVBNFNpMDdVT0VGYTFkVW9UTHFCbzYwQUdDMEEx?=
 =?utf-8?B?OGxMZS9ocDhaS2FMMFRGRjExMG1YYWxNQmFjaVlrdnBIemFrRnd3Z2ZwWnU1?=
 =?utf-8?B?ZS83UjlEMm9TaUJLak5RZjZsa2FKU2RwN3ZZbnh3MjZDb2Y1MGs5eTBIM0Vs?=
 =?utf-8?B?SU5URkoxd2VDUTZDNy9hUTNPV0ZYSWNRVzBlV1lzOElKTkRVMng4TXR3enk5?=
 =?utf-8?B?b05OY3F2Z3FSdEE1SnZPeFhOeTBxMkVwejYvem1odHExUFRHaXdFaXVXK1Vr?=
 =?utf-8?B?ZHJuUVc5SThRNHNWeHBWVFlCVGxnYVp5cEdXNytOTzF0MW9UNGh6NytHNktN?=
 =?utf-8?B?NHBwRXUxUDlveHhYV0VDUlNXVzBGR1U3STMvaGZmMDRoeUpLclZmVG1FR0Er?=
 =?utf-8?B?YmNDWTlrZzhzRzhPWmJPWGpLUG1vVHZ2SGFGeDlieVdHek9SSWVlcFFSWXlS?=
 =?utf-8?B?cy80K1BuUWJqdHZnVzcwbmpWVlk4QWVPcGdGcG9seE1Ic2M5MGRhaSt5WnA1?=
 =?utf-8?B?QkY3K3Jib2FIdE9oYmZlR0hPZm1sVEIwWFFnTjkrMFdBR2E4cS9McUxaME1U?=
 =?utf-8?B?MXdieTFXQ1FyYWVxYWdRelpsVjBPTDZxd1ozeDh4SmlGMG5FZ3JIYzdtNHZi?=
 =?utf-8?B?dUFBdk9hUFlINUcyUERrcjRHb1ZZTys5NkN3ditrbEs3YnEwczNSVkc0aVJT?=
 =?utf-8?B?cXRib0t4dEFOUEVrSXo5REUvaVQ1Q2xIK2o5VFJ4TVliVGRYUERNdHZuQkg5?=
 =?utf-8?Q?yNrwnHN+p7WqW8/mlfhiomVLZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1373.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 34426537-bf25-4d99-d598-08db25b38456
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 00:15:15.2401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r9z+HbuJYRrkKDP4MvTBpZGYGzu/aEGn039vT3aitjx79Tepi1cWBYGfy1E632Be6lb8k/53LfwqZ9PxhOH9rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1574
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: zCa5MyT6duPfgCjmfTOpnfp_EFTpEUKl
X-Proofpoint-ORIG-GUID: zCa5MyT6duPfgCjmfTOpnfp_EFTpEUKl
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_12,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=646
 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 adultscore=0 impostorscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150001 definitions=main-2303160000
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBXZWQsIDIwMjMtMDMtMTUgYXQgMDc6MzYgKzAxMDAsIEdyZWcgS0ggd3JvdGU6DQo+ID4g
T24gV2VkLCBNYXIgMTUsIDIwMjMgYXQgMDY6MDg6MTlBTSArMDAwMCwgU2V5bW91ciwgU2hhbmUg
TSB3cm90ZToNCj4gPiA+IFRoZSBmb2xsb3dpbmcgcGF0Y2ggaW1wbGVtZW50cyBob3N0IHN0YXRl
IHN0YXRpc3RpY3MgdmlhIHN5c2ZzLiBUaGUNCj4gPiA+IGludGVudCBpcyB0byBhbGxvdyB1c2Vy
IHNwYWNlIHRvIHNlZSB0aGUgc3RhdGUgY2hhbmdlcyBhbmQgYmUgYWJsZQ0KPiA+ID4gdG8gcmVw
b3J0IHdoZW4gYSBob3N0IGNoYW5nZXMgc3RhdGUuIFRoZSBmaWxlcyBkbyBub3Qgc2VwYXJhdGUg
b3V0DQo+ID4gPiB0aGUgdGltZSBzcGVudCBpbnRvIGVhY2ggc3RhdGUgYnV0IG9ubHkgaW50byB0
aHJlZToNCj4gPg0KPiA+IFdoeSBkb2VzIHVzZXJzcGFjZSBjYXJlIGFib3V0IHRoZXNlIHRoaW5n
cyBhdCBhbGw/DQo+IA0KPiBUaGlzIGlzIHRoZSBtb3N0IGltcG9ydGFudCBxdWVzdGlvbjogV2h5
IGFyZSB0aW1lcyBzcGVudCBpbiB2YXJpb3VzDQo+IHN0YXRlcyBhbmQgdHJhbnNpdGlvbiBjb3Vu
dHMgaW1wb3J0YW50PyAgSXMgdGhpcyBzb21lIGtpbmQgb2YNCj4gcHJlZGljdGl2ZSBmYWlsdXJl
IHN5c3RlbSwgb3IgaXMgaXQgc2ltcGx5IGxvZ2dpbmc/IElmIGl0J3MgbG9nZ2luZywNCj4gd291
bGRuJ3QgeW91IGdldCBiZXR0ZXIgaW5mb3JtYXRpb24gaWYgd2Ugb3V0cHV0IHN0YXRlIGNoYW5n
ZXMgYXMgdGhleQ0KPiBvY2N1ciB0aGVuIHRoZXknZCBhcHBlYXIgYXMgdGltZXN0YW1wZWQgZW50
cmllcyBpbiB0aGUgc3lzbG9nIGZyb20NCj4gd2hpY2ggYWxsIHRoZXNlIHN0YXRpc3RpY3MgY291
bGQgYmUgZGVkdWNlZD8NCg0KSGkgSmFtZXMsDQoNCkkgaGFkIHRvIHdyaXRlIHNvbWV0aGluZyB0
byByZWFkIHRoZSBzdGF0aXN0aWNzIHRvIGVuc3VyZSB0aGF0IHdoYXQgd2FzDQpiZWluZyBwcm92
aWRlZCB3YXMgc2FuZSBhbmQgdXNhYmxlLiBDdXJyZW50bHkgdGhlIHByb2dyYW0gZG9lczoNCg0K
MSkgTG9nZ2luZyBvZiBzdGF0ZSBjaGFuZ2VzICh3aXRoIGEgY291bnQgYW5kIHdoYXQgdGhlIGN1
cnJlbnQgc3RhdGUgaXMpLg0KMikgTG9nZ2luZyBhIHBlcmNlbnRhZ2Ugb2YgdGltZSBzcGVudCBp
biByZWNvdmVyeSBvdmVyIHRoZSBsYXN0IGludGVydmFsDQooZGVmYXVsdCAxMCBtaW51dGVzKSBp
ZiB0aGF0IHBlcmNlbnRhZ2UgaXMgaW5jcmVhc2luZy4gDQoNCkkgZG8gcGxhbiBvbiBpbXBsZW1l
bnRpbmcgdGhlIGZvbGxvd2luZyBpbiB0aGUgbmVhciBmdXR1cmU6DQoNCjEpIEtlZXBpbmcgc3Rh
dGlzdGljYWwgaW5mb3JtYXRpb24gaW4gbWVtb3J5IChmb3IgYXQgbGVhc3QpOg0KDQphKSBIb3Vy
bHkgZm9yIHRoZSBsYXN0IDk2IGhvdXJzDQpiKSBEYWlseSBmb3IgdGhlIGxhc3QgOTAgZGF5cw0K
DQoyKSBBbmFseXNpbmcgdGhhdCBkYXRhIGhvdXJseSBhbmQgZGFpbHkgdG8gZGV0ZXJtaW5lIGlm
IHRoZXJlIGlzIGENCnRyZW5kIHRoYXQgaXMgaW5jcmVhc2luZyBvciBkZWNyZWFzaW5nIGluIHRl
cm1zIG9mIHRoZSBjb3VudCBhbmQgdGhlDQp0aW1lIHNwZW50IChpZiBhbnkpIGluIHJlY292ZXJ5
LiBUaGF0IGlzIGFyZSB0aGluZ3MgZ2V0dGluZyBiZXR0ZXIsDQp3b3JzZSwgb3Igc3RheWluZyB0
aGUgc2FtZS4NCg0KTXkgZW5kIGdvYWwgaXMgdG8gcHJvdmlkZSBhdCBsZWFzdCBzb21lIHdhcm5p
bmcgdGhhdCB0aGVyZSBtYXkgYmUgYQ0Kc3RvcmFnZSBpc3N1ZSBhbmQgaWYgaXQgYXBwZWFycyB0
byBiZSBnZXR0aW5nIHdvcnNlLiBJIGRvIHdhbnQgdGhlDQp1c2VyIHNwYWNlIHByb2dyYW0gdG8g
YmUgc29tZXRoaW5nIG1vcmUgdGhhbiBqdXN0IHNvbWV0aGluZyB0aGF0IGxvZ3MNCm1lc3NhZ2Vz
IGFib3V0IHN0YXRlIGNoYW5nZXMuDQoNCkluIHJlZ2FyZCB0byB5b3VyIGlkZWEgYWJvdXQgb3V0
cHV0dGluZyBzdGF0ZSBjaGFuZ2VzIGl0J3MgaW50ZXJlc3RpbmcNCmJ1dCBJIGNhbiBzZWUgc2V2
ZXJhbCBkcmF3YmFja3MuIFRoZSBmaXJzdCBpcyBpZiB5b3UgdXNlIHN5c2xvZyB5b3UgZG9uJ3QN
CnJlYWxseSBoYXZlIGFueSBpZGVhIHdoZXJlIHRoZSBtZXNzYWdlcyB3aWxsIGVuZCB1cC4gRGlm
ZmVyZW50IGRpc3Ryb3MNCmhhdmUgZGlmZmVyZW50IGRlc3RpbmF0aW9ucyAoZS5nLiBtZXNzYWdl
cyB2cyBzeXNsb2cgdnMgc3lzdGVtZA0Kam91cm5hbCkgYW5kIHlvdSBjYW4gY29uZmlndXJlIHRo
ZSBzeXNsb2cgZGFlbW9uIHNvIHRoYXQgdGhlIG1lc3NhZ2VzDQphbHdheXMgZW5kIHVwIG9uIGEg
ZGlmZmVyZW50IHN5c3RlbS4NCg0KVGhlcmUgd2lsbCBiZSBpc3N1ZXMgaGFuZGxpbmcgdGhvc2Ug
ZmlsZXMgYXMgd2VsbC4gWW91IG5lZWQgdG8gY29wZSB3aXRoDQpsb2cgZmlsZSByb3RhdGlvbiwg
aG93IG1hbnkgY29waWVzIG9mIG9sZCBtZXNzYWdlcy9zeXNsb2cgZmlsZXMgYXJlIGtlcHQNCndo
ZW4gcm90YXRlZCwgaWYgdGhleSBhcmUgY29tcHJlc3NlZCBvciBub3QgKGFuZCByZWFkaW5nIHRo
ZW0gd2hlbiB0aGV5DQphcmUpLCBhcmUgYW55IG1pc3NpbmcsIGhvdyBmYXIgdG8gZ28gYmFjayBp
ZiB0aGVyZSBhcmUgYSBsb3Qgb2Ygb2xkDQptZXNzYWdlcy9zeXNsb2cgZmlsZXMuIEkgdGhpbmsg
eW91IHdvdWxkIG5lZWQgdG8gbG9vayBhdCB0aGVtIGFsbA0KdG8gZGV0ZXJtaW5lIHdoYXQgZmls
ZXMgd2VyZSByZWxldmFudCBhbmQgbmVlZGVkIHRvIGJlIHByb2Nlc3NlZC4NCg0KSGF2aW5nIHNh
aWQgdGhhdCBub25lIG9mIHRob3NlIGlzc3VlcyBhcmUgaW5zdXJtb3VudGFibGUgYnV0IGl0IG1h
a2VzDQppdCBoYXJkIHRvIGRvIHRoZSBhbmFseXNpcyBJIHdhbnQgdG8gaW1wbGVtZW50IG9uIHRo
ZSBkYXRhLiBUaGUNCnZhcmlhYmlsaXR5IG9mIHRoZSBxdWFudGl0eSBvZiBhdmFpbGFibGUgZGF0
YSAoaG93IG1hbnkgbWVzc2FnZXMvc3lzbG9nDQpmaWxlcyB5b3UgaGF2ZSkgb3ZlciBhIHBlcmlv
ZCBvZiB0aW1lIHByb3ZpZGVzIGNoYWxsZW5nZXMuDQoNCj4gDQo+ID4gwqAgV2hhdCB0b29sIG5l
ZWRzIHRoZW0gYW5kIHdoYXQgY2FuIHVzZXJzcGFjZSBkbyB3aXRoIHRoZQ0KPiA+IGluZm9ybWF0
aW9uPw0KPiA+ID4NCj4gWy4uLl0NCj4gPiA+IEEgKEdQTHYyKSBwcm9ncmFtIGNhbGxlZCBob3N0
bW9uZCB3aWxsIGJlIHJlbGVhc2VkIGluIGEgZmV3IG1vbnRocw0KPiA+ID4gdGhhdCB3aWxsIG1v
bml0b3IgdGhlc2UgaW50ZXJmYWNlcyBhbmQgcmVwb3J0IChsb2NhbCBob3N0IG9ubHkgdmlhDQo+
ID4gPiBzeXNsb2coM0MpKSB3aGVuIGhvc3RzIGNoYW5nZSBzdGF0ZS4NCj4gPg0KPiA+IFdlIGtp
bmQgb2YgbmVlZCB0byBzZWUgdGhpcyBiZWZvcmUgdGhlIGtlcm5lbCBjaGFuZ2VzIGNhbiBiZSBh
Y2NlcHRlZA0KPiA+IGZvciBvYnZpb3VzIHJlYXNvbnMsIHdoYXQgaXMgcHJldmVudGluZyB0aGF0
IGZyb20gaGFwcGVuaW5nIG5vdz8NCj4gDQo+IEkgZG9uJ3QgdGhpbmsgdGhhdCdzIGEgcmVxdWly
ZW1lbnQuICBUaGUgd2hvbGUgcG9pbnQgb2Ygc3lzZnMgaXMgaXQncw0KPiB1c2VyIHJlYWRhYmxl
LCBzbyB3ZSBkb24ndCBuZWVkIGEgdG9vbCB0byBtYWtlIHVzZSBvZiBpdHMgZW50cmllcy4gIE9u
DQo+IHRoZSBvdGhlciBoYW5kIGlmIHRoaXMgdG9vbCBjYW4gaGVscCBlbHVjaWRhdGUgdGhlIHVz
ZSBjYXNlIGZvciB0aGVzZQ0KPiBzdGF0aXN0aWNzLCB0aGVuIHB1Ymxpc2hpbmcgaXQgbm93IHdv
dWxkIGJlIHVzZWZ1bCB0byBoZWxwIGV2ZXJ5b25lDQo+IGVsc2UgdW5kZXJzdGFuZCB3aHkgdGhp
cyBpcyB1c2VmdWwuDQoNClRoZSBtYWluIHVzZSBvZiB0aGUgZXhpc3RpbmcgY29kZSB3b3VsZCBi
ZSBtYWtpbmcgaXQgZWFzaWVyIHRvIHdvcmsNCm91dCBob3cgdG8gcmVhZCB0aGUgc3RhdGlzdGlj
cyBmcm9tIHRoZSBzeXNmcyBmaWxlcyBhdCB0aGUgbW9tZW50Lg0KDQpJZiB0aGUgZmVlZGJhY2sg
aXMgd2FpdCB1bnRpbCBJJ3ZlIGZ1bGx5IGltcGxlbWVudGVkIHRoZSB1c2VyIHNwYWNlIHByb2dy
YW0NCndpdGggdGhlIGFuYWx5c2lzIGNvbXBvbmVudCBhbmQgbWFkZSBpdCBhdmFpbGFibGUgSSdt
IG1vcmUgdGhhbiBoYXBweSB0byBkbw0KdGhhdC4NCg0KVGhhbmtzDQpTaGFuZQ0KDQo+IA0KPiBK
YW1lcw0KDQo=
