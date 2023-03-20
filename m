Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD896C2090
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjCTS5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjCTS5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:57:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC9F37B6B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:49:17 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KHE0kb001838;
        Mon, 20 Mar 2023 17:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=CWhtBVYjUkhfE+08kOHty/gKL0RFlXHWzIWb/QXHapQ=;
 b=CzAA8DNzMzFAEbiEIG2XNf5l/VXDpNo+MrXvlzB68BuuM/kznFMn9lU9wdxaS5SDQLDp
 u7o9GjicbzmRJOoTw8Ut0DrjiOaA+9H0U74NUKvnT4kWKovCrlG6QCHSK5VrkzSldt3o
 g8ea0tx+CN5QdJ8NOWu+MakW2g7xToa7g+4hCodMFmDSsSFI6ss65OsPiqf/x//SllNI
 GSEz4LhEPHPPFNbpsA4eLBEeufUbpwPBb/KkW4nR8lToDg2uk/b+i2eIDDGSWQtbTbcd
 S86TEHWRuKh7FR+p0ItC49RG5rfghYbeHTCFGD9yaIzEDbw1Bomaj/5uGfrb3ehOGpTp YA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd5bcc4jc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 17:46:31 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32KGmVYr038614;
        Mon, 20 Mar 2023 17:46:31 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pd3rc3qqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 17:46:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnKbaVqKXdrYeS0B0omm0bHG6GWrZmCR1+1jjjSGjgyvTtVCteBzTWJdEfRXqUa0KUvJIQCMSTmkougj9zSvEAir+84MGVyP3KI8a4i5g/boRVtvd2EkeG6/oDRvGtGhMQ9vWr69mO5oplowUoTggM5jXtN4iAjChhqorHIADoBj1MAuRaqyrFBdu92rKyztO+IvB/uZYq5cpn0aP3i2hPhKPy2SHbW3yhBXKbRfvWEzjlvzT9nbF6foxXPlbjO944NYbTj9DcRE48CKouIhQipkfn1QTlH3SsTun6dqUOwJfEllyT+L8OrkQRN+DHGARk9muiiTNp1HM/w6tsKxgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWhtBVYjUkhfE+08kOHty/gKL0RFlXHWzIWb/QXHapQ=;
 b=DEyzLEsVwqXrTg+HH8cEiNX0yIswnVFg5K0r3No3+eP3LmBRh6bfLa5hL5gkMyTvg1hLthulhhOy6YRX5YA4eQz97AG0k+8mR5WuKvEdfDbqKr+cq1vh24dmvIUErlMhkPlHZwaCUEcBhYix7lvAyeT5InqZVsub+x3oWH9LaY5vsVuMTkK2yvSGeoirsCnspgjndWchK9HwutX2yVeykKRiiMqc7vKnK9j5uPAk5fmt0uLNtG03nlFTb2/yhkJhsElQ1f7aBsyatRlu+T8hjh2ZFB2UuEKhe45yYN1NLS40R5IkbjgZCTTbO43OKmguo150lFOddL2oZVtHv/nlnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWhtBVYjUkhfE+08kOHty/gKL0RFlXHWzIWb/QXHapQ=;
 b=OnZLsVjIZMgLrsQ9pkIWm2a9APIUEYNZ1XUl2QIyfkJjd0gPOmGWMJzoPrboG2nZxZeyntZXjZLux+/PvJ9oR4ig/QPYTNgTpbmCbAYp1Pe9vGZ1iNr/xYPJt5ARLDCY9yxVuXb4UazwmLUfr0dhRelTz4fK7dsyV+94mKmKhCc=
Received: from SN4PR10MB5559.namprd10.prod.outlook.com (2603:10b6:806:202::16)
 by PH0PR10MB7007.namprd10.prod.outlook.com (2603:10b6:510:282::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 17:46:27 +0000
Received: from SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::f1de:9c09:166c:4e89]) by SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::f1de:9c09:166c:4e89%5]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 17:46:23 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     David Hildenbrand <david@redhat.com>
CC:     Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: THP backed thread stacks
Thread-Topic: THP backed thread stacks
Thread-Index: AQHZUId6EUNxRdiQ4UKEGoIYcgiIL67/UY8AgAAO9wCABDgZgIAAbhWA
Date:   Mon, 20 Mar 2023 17:46:22 +0000
Message-ID: <4A61B05E-62C6-4BC1-9301-CF12FC5A252F@oracle.com>
References: <20230306235730.GA31451@monkey>
 <ZBSo+mLUOsKvy3rC@casper.infradead.org> <20230317184632.GA69459@monkey>
 <655ca9fd-ddc3-0bfa-b442-fc60cda02baa@redhat.com>
In-Reply-To: <655ca9fd-ddc3-0bfa-b442-fc60cda02baa@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN4PR10MB5559:EE_|PH0PR10MB7007:EE_
x-ms-office365-filtering-correlation-id: 023cc96c-ae62-4049-784e-08db296b0552
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Rwfizt2rOCC1mjk7fGclOptfnNPC34O13sX2s6zE5l6eEaDKeqtW/sFeHty3+0xorVspbrmfucmsrqpCIFQQdnC+0h9NQFiuuQ8Ufu7144F05UHiRfH4YL04HOzt/GTQD05a/wXr7RR+DOCArTFwxQxoeuPH+TEXQFQWlWzN+qybwfq92VQwquXIdTrASV2qvvFePo55LfgdRnApviwyUO2mGvFvQczy0pQp5V+DaARPS3Ig8pSlnAW/3R1RndtBsLc3Di9WAac8QsU+XN40oHGhYda6l4bRI5NqpwiNMUJJz/hP8T0CLuTpm5VP0xRXdRHPYH5bqANRbWGS0X2PIWZGBBUTiU4aeF07w1pBp3bG3Ess77FyOdfkK8Z7ayhhtswOlDs8Td0vM1e9ujoNsrAoPe95Ov8pYSSJ7NTAjqC7t+kqfnW32WqYRRZnCIFlxvX3Y3rMBQ/aiv0vdNpLFn4dcITRzvrC9HiNBzQr/29YWo4qB2KRt1EAQfPMVI1tWz+Pt1DoSg6b7s6xoW+6DZ24+OUe9cVeuF2yWVBdIKtTLqtqbDMgsPEaMaWHqE9RmmDWGerq863qbQmcQ2G9K6lcRHZ4PLv8gHM6pCMxbzXUHDXVzKvmNf8rtMhs0P+rGBTIGtumoP0VNaL2Esa35/82Ap00HlrOXTlooLzDdomQFvYiZjIqkcP9fgrO5aSyufjGbQ1+WzRxo9IXEM6w+7zAMpVUdF7RdwofJVgXiw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5559.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199018)(54906003)(6916009)(8676002)(64756008)(66946007)(66556008)(66476007)(66446008)(478600001)(316002)(76116006)(4326008)(41300700001)(66899018)(5660300002)(44832011)(8936002)(122000001)(83380400001)(6506007)(38100700002)(86362001)(6486002)(186003)(2906002)(36756003)(71200400001)(53546011)(33656002)(3480700007)(38070700005)(2616005)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UibyLOtxpNdZFtxFTQOXRSEC1jVPv8WRBJ5ZlxTxqMHqBJZW9fCf453/gq+T?=
 =?us-ascii?Q?4HLHMoFBbDdJsv3QOlZyESmBH3lqGT3ri8UI/509dGYq4MkQsuo4HmStQQc4?=
 =?us-ascii?Q?x2aoaULEfSwIN5NYZn5ekemdBQunKReC9O+3r9h8u6T7+hdA9sRGXeF+perX?=
 =?us-ascii?Q?FpUsyfpx7DQtGnkeLkTNwu9fQMqH8Xc8TZbBSs4EsC0eNoCpOziQpY1EVUjQ?=
 =?us-ascii?Q?kI0vystrEM1imkgFCchWjpNd34A5WCAU2BjGLAAM92sD2sKjiv5iqFUkXRTH?=
 =?us-ascii?Q?wRk7bOccroj5lF7tJfX2ubmUReRiSx0r0WSq6Xu1RrMgfizhbfjjYzg8pCso?=
 =?us-ascii?Q?S+8pNeg8o1lk1kyiP2pLM6/mq87bBP/AuX668+SNAsYxhBUyf5EwS0jtJx6r?=
 =?us-ascii?Q?iHJreLFPn1kzPZci87aFUZFMQCENiI8wLlDaOsAcaFpeAgJYNnBZVWhbTNNY?=
 =?us-ascii?Q?xwuVnZPCDgZS64YH3T8+FYcYcywLXoAnc2yEv2dB+CRgYnm5P5WVZWPRnZf9?=
 =?us-ascii?Q?VVd1izxg0QmlcPMXHcmy6is1ExR6+5rYH0gscx7TiCGNKj06SUOb9cZmPiYB?=
 =?us-ascii?Q?3GM00DpH0BRTiciaWpoR8WC1B7kpLA6IUfOAu3QXNc62W9CTJV+2o0ojAeK4?=
 =?us-ascii?Q?y0ra0BLNUsNnmyTTCQimG8d2XKh6s/BPRXIj31D+q5aFHV6SfEu85q6WvTGF?=
 =?us-ascii?Q?9f9BTZV7+CqgPlCZLzGOG1Hv9VL0wKbIpkcILfsKh+3b6fpAm70gjmDDDiSS?=
 =?us-ascii?Q?MM2s5YxnK05vfSlvrhtCm0BCOhaUwX7VG+/djhToEYUUAAbCQdAbU9rUR/ef?=
 =?us-ascii?Q?fp4OIFNb9nkZhv/QuWarfcGOCYkRkk2BrD3v5U3dJ3bXFoxirgOhjB/zYbIw?=
 =?us-ascii?Q?29Eh+3N1QNr5IdhdRdp5nKIOcbpzQGr3ALBOdavxDF1c7Oe77aEUa5YyX+UC?=
 =?us-ascii?Q?17Y6ZG1xupesvEWLwVkdRf56WIEBZmqrBb1bNW0bD7EsFbznikOnfQkgYUY7?=
 =?us-ascii?Q?BDW+HTdHYQwKR14Jxm3v0VDKJfJt/ExhyrQ6ELa2JKrUWjql9lgeCUaUL2t3?=
 =?us-ascii?Q?YamJMhNp5/td4hXVOf2vD8ARYr0as1qcuY3S8VES2WLFR3hYUadVmcQrimpQ?=
 =?us-ascii?Q?LwVIwJCLfrMN64vjyZ9CzyrG2b4AN9YZAvdkw8KuLVdyCbJfJhQPCxFInKq+?=
 =?us-ascii?Q?5yILjqM/llluzQ8cY9fnwxfNxBBnfEOZHA1/2k+2RHKkiD7QkK3nri2D5ZfZ?=
 =?us-ascii?Q?geb6kjQ9peyP2EMUlwdytCBK/vuEWlgI6zKEQ7wHM0BDbwz1yG+zDBpEJyFr?=
 =?us-ascii?Q?0uxCxLHBSlG3RpPJZ14hPCx0kCelEnYPAWZGqc1++bOUuzX9l70GdZWGYdsm?=
 =?us-ascii?Q?0fOXx/RZDyjUikmzGOjWKoVjjWBGnoVUREzz4jzoPiSeopONtaEFsGDbKCCx?=
 =?us-ascii?Q?iqFIiXd5Gz+a3EtW1DFKgpAj2aZf5JRVt5oK0IekNoLqpz53S3fOJni+H91a?=
 =?us-ascii?Q?AFWlUt0uXuWIei+8xNdt341fJONkyMlmXrrx0gZWmqnk7wk2kjREA4/DMBST?=
 =?us-ascii?Q?uM57FjH+QVNlN/9EEnvgpE5OGy4lP2KtGZR412MKTYHh9Ph1iN/7Yl2naZl+?=
 =?us-ascii?Q?ssq9bShPm3mAdZymnxU7V8kYXQi+HRqiquIp1re1ZiPH?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0FE5CF7A7D2BC9438EB918E3BF3637F9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QE08Jny+bS/UN7jBJkiGDggAMmUD2YWyrkuzNC9aKZTQm5tRJEBbEruxHXL1usD3PqW/cd+e2Ki0tJmsp2fcp5cXwifxSPhnWxBK8aQcWuyepeAFz/AXj1u89yXYqVanil0w0Zaz5O2sEtC4EdHO+lKayFRHaC5NCcgdPJ/9p+uZHHbnOdgms+KyseMlr93iAsQPe6ZMWt3vzv0W6MSrrLclxjX26EABtEPObozQbiZJQTYiGR5Ci/TT4sCWLmz/Q5GmPDhydWfdUCUkXB+ua2xvgXqdENwEcwsMLdJ/fBHTFds82M26yWTHXXdmsjqOF3aobBdcLgHANkCj+1kVThMtt6A3OHuyGoqhleXYdAUIbmBD0lVk4Rw2a+F5Rr1E0gCOrXi7fsBoz0+6t9WWxXXLCoelZaDom0kNNYUxzAbgbXePHYa0XGe4CrEgfN4b1vRUqyonzK9QJ+J+ZRe4wmiNsp9sNAzDioB0s/klTkiEzqBN5qk4lQlyqcFUzoycQxDzUNHszktj3KxY221ajjkmchJzg3XmiEz2yCd8DJemL8txwsrAxD8qq/kEQ/74uoS2BlEE56s3AT9syQgiQujxRKJ6VvXcBJcjbibuZUfMdQoR/9s5EmeTI5wbQiBF7qTd3otcRl7lNMeoZaEomOO34m6siWRlJUwJsOrDhLuBUDdELtALQXU9099yHVOXzqfBFk9PE//mOteCqrFc4sCDot/ovq3NXoHkOY+yfaklIS1ug+OpMXACgaaL2WHU+InrRLmrlwgCDei/x9tlseb9D42P91y8EgKBLafmU22owfzHKsTw8I8cJorWwjowaWAvvbpwUktXfHnSokAyaKdY74fYVBg2tz8C7PO8HG0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5559.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 023cc96c-ae62-4049-784e-08db296b0552
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 17:46:23.0118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kxDw4ddNKS7syv5Q6NTvVKvVGPYQ9jgXoIONMcMSbRe2KRhWv08S4RG8LNWicQLAuLlcC5HE06sSkf5vsHtFphFnUB3khMCW6PHgNBk9nTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7007
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_15,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303200150
X-Proofpoint-ORIG-GUID: wOiO1gANfRFdGcv8gs_O85M6BiUOv0Du
X-Proofpoint-GUID: wOiO1gANfRFdGcv8gs_O85M6BiUOv0Du
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 20, 2023, at 05:12, David Hildenbrand <david@redhat.com> wrote:
>=20
> On 17.03.23 19:46, Mike Kravetz wrote:
>> On 03/17/23 17:52, Matthew Wilcox wrote:
>>> On Mon, Mar 06, 2023 at 03:57:30PM -0800, Mike Kravetz wrote:
>>>> One of our product teams recently experienced 'memory bloat' in their
>>>> environment.  The application in this environment is the JVM which
>>>> creates hundreds of threads.  Threads are ultimately created via
>>>> pthread_create which also creates the thread stacks.  pthread attribut=
es
>>>> are modified so that stacks are 2MB in size.  It just so happens that
>>>> due to allocation patterns, all their stacks are at 2MB boundaries.  T=
he
>>>> system has THP always set, so a huge page is allocated at the first
>>>> (write) fault when libpthread initializes the stack.
>>>=20
>>> Do you happen to have an strace (or similar) so we can understand what
>>> the application is doing?
>>>=20
>>> My understanding is that for a normal app (like, say, 'cat'), we'll
>>> allow up to an 8MB stack, but we only create a VMA that is 4kB in size
>>> and set the VM_GROWSDOWN flag on it (to allow it to magically grow).
>>> Therefore we won't create a 2MB page because the VMA is too small.
>>>=20
>>> It sounds like the pthread library is maybe creating a 2MB stack as
>>> a 2MB VMA, and that's why we're seeing this behaviour?
>> Yes, pthread stacks create a VMA equal to stack size which is different
>> than 'main thread' stack.  The 2MB size for pthread stacks created by
>> JVM is actually them explicitly requesting the size (8MB default).
>> We have a good understanding of what is happening.  Behavior actually
>> changed a bit with glibc versions in OL7 vs OL8.  Do note that THP usage
>> is somewhat out of the control of an application IF they rely on
>> glibc/pthread to allocate stacks.  Only way for application to make sure
>> pthread stacks do not use THP would be for them to allocate themselves.
>> Then, they would need to set up the guard page themselves.  They would
>> also need to monitor the status of all threads to determine when stacks
>> could be deleted.  A bunch of extra code that glibc/pthread already does
>> for free.
>> Oracle glibc team is also involved, and it 'looks' like they may have
>> upstream buy in to add a flag to explicitly enable or disable hugepages
>> on pthread stacks.
>> It seems like concensus from mm community is that we should not
>> treat stacks any differently than any other mappings WRT THP.  That is
>> OK, just wanted to throw it out there.
>=20
> I wonder if this might we one of the cases where we don't want to allocat=
e a THP on first access to fill holes we don't know if they are all going t=
o get used. But we might want to let khugepaged place a THP if all PTEs are=
 already populated. Hm.
>=20
> --=20
> Thanks,
>=20
> David / dhildenb

Unless we do decide to start honoring MAP_STACK, we would be setting an int=
eresting precedent here in that stacks would be the only THP allocation tha=
t would be denied a large page until it first proved it was actually going =
to use all the individual PAGESIZE pages comprising one. Should mapping a t=
ext page using a THP be likewise deferred until each PAGESIZE page comprisi=
ng it had been accessed?

Given the main questions of:

1) How to know whether it's a stack allocation

2) How to determine whether the app is consciously trying to allocate the s=
tack via a THP or if it just happened to win the address alignment/size lot=
tery

3) Whether to honor the THP allocation in either case

It seems taking the khugepaged approach would require Yet Another Flag to p=
rovide a way for an application that KNOWS a THP-mapped stack would be usef=
ul to get it without having to incorporate a loop to touch a byte in every =
PAGESIZE page in their allocated aligned stack and hope it gets its upgrade=
.

William Kucharski=
