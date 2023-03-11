Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7016B5BA1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 13:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjCKM1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 07:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjCKM1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 07:27:24 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413FD12BAFF
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 04:27:16 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32B71j1E022139;
        Sat, 11 Mar 2023 12:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=SQzlytezXPYT2I2mBYHiLOssMLceYRKd4im8sgtdEeU=;
 b=YRojT7EdQ9gdKwMZby6iQQ/Ba1ExOF4jz9uu+Ri0YI8+LFWpgGdH+Ht4c7BQMnuIlI8e
 VdPor0fUGYHPmmTcCVGiYOmCb2b48M7ltKdygzRduUknsLn4FYkLpALZCOADaqXBPpY/
 cOO6uuv0EiBEB9Pv5IG7EIWjNuReN/cZNRqV3hVbZPa6p50X7F0Pnty5QocAlj+eK9pP
 Tjeojb1pNWhsAGYI/vDg/uJy2udGt/ynNuRbtsuO1b7DsUFNoKPD1wW8hQf1InGwvGC/
 FOx7Uy/DXE0sCB/KkVrm6zMOOEof9tjo4UQuBUAljec4uawl4f9VNEUPUwIDOs2fS8dt mA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8hpcrcf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Mar 2023 12:25:01 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32B9lBpc007386;
        Sat, 11 Mar 2023 12:25:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g39kp3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Mar 2023 12:25:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BONJkht+pt0aN4KLmSN0i/iDtbG0khTLOm1wj/3rIBV9OJusXhQLyo8X9rnnS5TT5RC81zZcFAUt1wCBK1lOjvoxTQUpsIFEAfluKySx5wohrJS8CV+8v5SNbpxmITwQ96IdVIfV/Y18H7y/HotFcPoqRDOTOnOxNsPHq5LnlDLGEWXoptf0POpmJmkpwnsh9/GL1sLkguw2o7rwoP3pXDVTZ7LFckzHaglcl7ROXYNGcr4UR8zrCm8BnnKYSgTTD/9FWcwAX/P5UawHavTf3c13WjepDSB6v/DnL3j942TGqm7jI44U+lxKwMudnori3n2xizY/94HJvUXeikeOEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQzlytezXPYT2I2mBYHiLOssMLceYRKd4im8sgtdEeU=;
 b=g+W0BSks37B8m8NgY5uIMZELQfVkDonmXn/s+5L/NBbloXSRXNQRByJgPOGJt7GDCPs0uinTFbmG2B6RutZnaEpEYUk10gBzmpOYKX3SICsP3wfY94hE4SowitXSujdIBGzerSCuS3odiJxGqljN6iMloJfLkRtsULSGZ8K/6yLFWXQHqttgXik6DDr6EJQmtFZVkGufEs9RMTDf1bIiy0tQZPNB1qvX71fc18EpxA6h22V2N78+jJfHGUwzOs1HwU0dJ6TW+GVdQRHdCVQ90PzW1TFJ1mxVEu5glX7ClegwRAU7MWVFG9ba8bLTJbpnE+jXzrLQKkgQ1vFI5hzZWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQzlytezXPYT2I2mBYHiLOssMLceYRKd4im8sgtdEeU=;
 b=dWOhg3mLubTMIOcnhzJnpNILkdmO+aOLeBx0AiqBueHUQckJ4Jbtg5ZCn4nriU0MOC1bk1WudyG3psy9R3EJIn/WAPnQgV+aUt4JMGo7oixrxdh3PelFKrJIPA77sZ8T2d1OTvDkvvyqE/tt4q6apaXJRwQDqO7Jr/fVzOiCVOc=
Received: from SN4PR10MB5559.namprd10.prod.outlook.com (2603:10b6:806:202::16)
 by DM6PR10MB4218.namprd10.prod.outlook.com (2603:10b6:5:222::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.22; Sat, 11 Mar
 2023 12:24:59 +0000
Received: from SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::f1de:9c09:166c:4e89]) by SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::f1de:9c09:166c:4e89%5]) with mapi id 15.20.6178.019; Sat, 11 Mar 2023
 12:24:58 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     David Hildenbrand <david@redhat.com>
CC:     Zach O'Keefe <zokeefe@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>, Rik van Riel <riel@surriel.com>,
        Mike Rapoport <rppt@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: THP backed thread stacks
Thread-Topic: THP backed thread stacks
Thread-Index: AQHZUId6EUNxRdiQ4UKEGoIYcgiIL67zHhkAgAAI0ICAABpxgIAAo6sAgAGi3AA=
Date:   Sat, 11 Mar 2023 12:24:58 +0000
Message-ID: <F5DD5318-F762-4FE8-AF1D-7D9AC6A73D39@oracle.com>
References: <20230306235730.GA31451@monkey> <ZAaCISgq4A/GnkCk@x1n>
 <20230307004049.GC4956@monkey> <20230308190206.GA4005@monkey>
 <CAAa6QmSdTo77dP2q2nU==C_2PdyF611+PVF32uPOTUQbp1kc9Q@mail.gmail.com>
 <20230309233340.GC3700@monkey>
 <CAAa6QmSiuFF6Oe0-j+eD0ma2tZAbhZuwENDYSZQSBrh1oeaLdA@mail.gmail.com>
 <9F855331-33B2-4366-9375-988B0D3DAC98@oracle.com>
 <9f44de08-b484-baa7-80c8-0a02a7abb717@redhat.com>
In-Reply-To: <9f44de08-b484-baa7-80c8-0a02a7abb717@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.221)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN4PR10MB5559:EE_|DM6PR10MB4218:EE_
x-ms-office365-filtering-correlation-id: e3336b85-5f3e-40d8-4463-08db222ba133
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pHIqBpe1z+cqePeO+CkfeAg0wqNwlbQdMHlI1Zm71rpK+YMGADOlAtaIstgRCKL8AnOrScd8VNI2PXdk4KHtJk0rwfJP3/dTZ6YURWeuFoIzKydklfJMmw0rbdAJ9Bx65vwyOmXpmmpzenGcmvHpNbWskAkYrwXH6B22gER0LxByShiqvItxQ/V8qV74XT+/nTbboVvCoJwNTkPTdQX3jPUcI+UmoBiRPL2NOjsKwYMFJiK8vP/OONjKIwMujSe0aJZ8UenH/+uTWbiUQsUtevZ2JJYjtLKaPFijbv3Dn31+VJfcmkkUw31Ps5ItZl4AdzB1EDbvWJ3Cy4navfMs/q3Z1YqtXaG9RTp1it2hDZ4nT1M2jSlA479I2IM1CLt+pYmSccro1An3SqS877E1Ro01zPmzIGswkuech7y9Jj6eE2OgGIcqtPa8d5XDS+Th92owGXSp800eiZaEvgCS72ITG3NY/TvjAF2LT0IqZAfkOfrdJ9wOGM3Ak8pL1/p5D361n9VjuFYw31e8TK8NmjJwoETzlNH6SG5MwluA5G5LTCA7WLRnYmXHzhObMyCBuV+Mr2OqYZsEGcJLfat3/XMeyEVClAR2KWWgvM4nsg1zUa5gLo26It0fBLdWB4tZ3g+auUBYBxTTDS0/NQHCyVwbOme6Xp0P5y0P/dS8NqUBiJ0zZreoVtq7lMv4vX2uE/jtVlnWDyXmsKpkmF3vyL8oIzKIZs5k21vZASXkKcw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5559.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(136003)(39860400002)(366004)(346002)(451199018)(5660300002)(33656002)(8936002)(2906002)(44832011)(41300700001)(3480700007)(86362001)(38070700005)(36756003)(38100700002)(122000001)(71200400001)(91956017)(66556008)(66476007)(66446008)(64756008)(8676002)(478600001)(6486002)(76116006)(6916009)(66946007)(4326008)(66574015)(54906003)(316002)(83380400001)(53546011)(186003)(2616005)(6512007)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wFrL1/p7my8Cr3jnqGJFtlaT3H75HYFRjCBzsgFP8ZimefRfaBolq8DBlv9H?=
 =?us-ascii?Q?i+iDea5cPo/Dpi3ygNt2Zn2IwTNqZn67JjXChEG+MeHO3OF5uii+mR5DyB32?=
 =?us-ascii?Q?2+JhSvQCcVi9hO18/S8zjHu8IQf7BsmzAybSN65HQM8u279o2b6RoHQoCmrc?=
 =?us-ascii?Q?ZmergcN1nms3Bat0FTOFSZc9KM9V4Qo5HMJ59sE7irBNI3SE+a8Y5ZJ/UUwk?=
 =?us-ascii?Q?eQGq8ZNdogujtwLzzy9+KH+ZOlHsm0M5k6sjzOEhAAcuNcKI/g/VSEJgAuE0?=
 =?us-ascii?Q?YZQy3rfpHr9xpWI1BIm1ot/tGQkj78kKQTV7gxazIJu7m0GlNe4BHkr7SBaQ?=
 =?us-ascii?Q?26M+XPlFmFz3ax2WaLNfaf7L2LAY+AwWGIoQo/bpGN/RDU3m95Gnyy8HobF8?=
 =?us-ascii?Q?rz3NuWewxZnM/N/NnyNr1Etv1NcWqUopumqElDHfwla9HNjWs0tZcFVuJAJd?=
 =?us-ascii?Q?tQohx8HKI0A9unsW60fqy5HK8CigMAVDALjbUW3CzHuCeFqKQ3MckOHXQgzs?=
 =?us-ascii?Q?OMfbt0H/0b/I2XmfFnAHhZrtXlSVjm3zP92cbK/c+FSRjNWVabnWiBev5hQL?=
 =?us-ascii?Q?u1KJELMGQiSVbvuDdZWiHu1RprbmaqIhYYOrFAElPGj+fqalTlqsQJlmJ6kb?=
 =?us-ascii?Q?fRcjguvbXko7y+FfyJsJli4a5ljBMISBPMdF5/sH3vI617DqMlto1CvKc+Z7?=
 =?us-ascii?Q?qc5XunXDQ6V06Ehpi92sGDfwA0Rcy9h1d+iXOI5NU5MsbpE+EeTHmQDFxPFB?=
 =?us-ascii?Q?61GDraSx9rg/VpsK4msBfbV7DK83+IO7SbCbjIJ/VQYW8DIJMK1qycBmKuZH?=
 =?us-ascii?Q?6ouDyzYlB+gl6rBuxmt4W28S/64V/kfcUADOUWnPB+TV6PxvF1779c7ZzjIq?=
 =?us-ascii?Q?6YzWe5kmThkUN7+2qaqBkmtUQYbheRRqSNEr9tWqEBtUnSi7BEd94M+TT4n/?=
 =?us-ascii?Q?lPIVbVA3woFSRnimTNLPTkmEoBVPV9Hh643PKQQ3mGmbpqO+6xb3ITd1Ieva?=
 =?us-ascii?Q?YKCd67Wzge/U7m6OfymlQXGnJn4DsKB2kRXCu0+mt55iMe7nRxn9OEnGbfgw?=
 =?us-ascii?Q?j0wUT+P5pIRxp8NJTDZwC6Lm7PU1lKOoYpX3TszX/vuJBUvPpCnS1dtjYl3w?=
 =?us-ascii?Q?brtot0VvzjidwoypDFQ20zgsJbj1Fvkjkz0Z5/hvSji5d8dL1hVeB6kYjFwc?=
 =?us-ascii?Q?/3CanHTvMADrZHsb5bG/eZa+Gx/M3VERi4Vuje3HSxocvzSUvqSLsr7WnLpO?=
 =?us-ascii?Q?7Y8FdWrasaGW7napHLUpOrrUBvTtjG17ZU1tjtq8nTreMIVFKUHhXAz/ySwp?=
 =?us-ascii?Q?g9x0E8mSdSPRu9wVSXFy1AonDqZCnj6PNCdOdLi2qnL3abWDFUj829rWTpFh?=
 =?us-ascii?Q?Z4exiHEg5YrCioG+Z5PJyGM3sgbeYRXrcgCH3Kyu6fJeD/W2gGIG40G2mFy0?=
 =?us-ascii?Q?eZhPOX1G0yZtI1CzvS/uaRgN1vUDaheDMxjQBDb8HGWhRaf/pTvahfdQYPrz?=
 =?us-ascii?Q?xW7YkL0nJ2qjj8+3ha/o2UO2xS8VffMHlLOaurNre4EKjCSUf1woIMkG2rcA?=
 =?us-ascii?Q?1dPhC/Sos33IuRF6DJhOAEJJm5iguoYsrhZ/b6TVQqxH1UBKDlxKN2PP8SM5?=
 =?us-ascii?Q?jgnO5mHUC4G2G4l5pKqYE7hFZcMEyujI0PTVPjS4p1VzGWzJTBfrinABYqfB?=
 =?us-ascii?Q?sv/crwtHImw2KnY8bLVun7bg8JE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8704A9509AA6A04194864E119D0973F8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: O4Fg6cBbikoi7kIX0JZVp+NU8r3oDqpCspTS0TvhjNLgExYcYFRKf0b6cKq0JyQGgM0aSH4KVbYnyhio6kqkgXHsi52S3HZYm1gY6QkISOzn1b6hKb2/WvC6OtXH5HYs5lr8yl4QxiQBABGQp72SuVQ7lVYC/z2qmIpk/k10IcE6S1quEhezS1Y7YVTqk9bDIqr54DjSyDKcBZTIC2YhWwJq8bNkVvs4ELck3It5ivV2LwDwPQe8Ub4CyyBWAd07GA16xzp0ka/lzRQO7ScOxs4M/ls4RvxkS8wXFxrXqoZbSUY0ewIPX8lPC0PRxk+gPb5OZX0WjvmLAq2E6J4uaB+7+U0ZWKcs7I/3dctERB6HeUalGGynggU299lBfbtCKsCTIUftWPy1F2TZKLiVbk9Lemg0n0XtWPeRSu5HWfzBLsCrIYFHzCwMzixF2Uur8x499/vTNFGjoVeIzlReC1cTeNSUoKxAx63dIPJ3OtOopwPHVwnyAXGj3lRM4jr49dEuTDEJYxG9/kUStgn3OmM8mh4tUdX0NWa6X/FM8etr4zMYM4AI/KSSQUJzL9y6pGPsHykuQP3wojT+aITAC6xWefA0EU+9kuOBHCj3XHMPyguVj8Th9EV/9teeG37ed90OR4hFuhHNOc9OaPSj52NK1isUbfwKrH9GCHXuShPXJGE07i/XCveYkG7e8Zsbf/ksrv+qmxyLQ7nEKj76+3VM1oH03O5p6sWRo3eX8/7TaHhlJy2g2FgmI09ZAAvAcQispT2/oRBZU7wu6fCFpCx2nJAeAMMRm83HPWZicmL1pcVmxwFZSyEqdqW/I4qE0tkHa3FWjrKddAQoShvqDE9JvKkpZVGBajxW8J3cX5O0fq082n8OLlk+AkNiG8xK8AckgFsAqxitm3HG265zvHVwTe2cZ9USH07r/I4ina0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5559.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3336b85-5f3e-40d8-4463-08db222ba133
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2023 12:24:58.5705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aauQ1n61hWpmg1lOhFQumtBELlPjnA0RcPkeDq1X2THXrADLbCkoTg7uFLwj0sqSU/nqDeyTibJyNyuV/V7X4x3VoLywHPXKj520sY68vb0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4218
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-11_04,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303110110
X-Proofpoint-ORIG-GUID: 7N69igobjJ2RsTgBz4z0IWIkXiz2OmG0
X-Proofpoint-GUID: 7N69igobjJ2RsTgBz4z0IWIkXiz2OmG0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mar 10, 2023, at 04:25, David Hildenbrand <david@redhat.com> wrote:
>=20
> On 10.03.23 02:40, William Kucharski wrote:
>>> On Mar 9, 2023, at 17:05, Zach O'Keefe <zokeefe@google.com> wrote:
>>>=20
>>>> I think the hugepage alignment in their environment was somewhat luck.
>>>> One suggestion made was to change stack size to avoid alignment and
>>>> hugepage usage.  That 'works' but seems kind of hackish.
>>>=20
>>> That was my first thought, if the alignment was purely due to luck,
>>> and not somebody manually specifying it. Agreed it's kind of hackish
>>> if anyone can get bit by this by sheer luck.
>> I don't agree it's "hackish" at all, but I go more into that below.
>>>=20
>>>> Also, David H pointed out the somewhat recent commit to align sufficie=
ntly
>>>> large mappings to THP boundaries.  This is going to make all stacks hu=
ge
>>>> page aligned.
>>>=20
>>> I think that change was reverted by Linus in commit 0ba09b173387
>>> ("Revert "mm: align larger anonymous mappings on THP boundaries""),
>>> until it's perf regressions were better understood -- and I haven't
>>> seen a revamp of it.
>> It's too bad it was reverted, though I understand the concerns regarding=
 it.
>> From my point of view, if an address is properly aligned and a caller is
>> asking for 2M+ to be mapped, it's going to be advantageous from a purely
>> system-focused point of view to do that mapping with a THP.=20
>=20
> Just noting that, if user space requests multiple smaller mappings, and t=
he kernel decides to all place them in the same PMD, all VMAs might get mer=
ged and you end up with a properly aligned VMA where khugepaged would happi=
ly place a THP.
>=20
> That case is, of course, different to the "user space asks for 2M+" mappi=
ng case, but from khugepaged perspective they might look alike -- and it mi=
ght be unclear if a THP is valuable or not (IOW maybe that THP could be bet=
ter used somewhere else).

That's a really, really good point.

My general philosophy on the subject (if the address is aligned and the cal=
ler is asking for a THP-sized allocation, why not map it with a THP if you =
can) kind of falls apart when it's the system noticing it can coalesce a bu=
nch of smaller allocations into one THP via khugepaged.

Arguably it's the difference between the caller knowing it's asking for som=
ething THP-sized on its behalf and the system deciding to remap a bunch of =
disparate mappings using a THP because _it_ can.

If we were to say allow a caller's request for a THP-sized allocation/mappi=
ng take priority over those from khugepaged, it would not only be a major v=
ector for abuse, it would also lead to completely indeterminate behavior ("=
When I start my browser after a reboot I get a bunch of THPs, but after the=
 system's been up for a few weeks, I don't, how come?")

I don't have a good answer here.

    -- Bill=
