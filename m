Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D868A71FA3A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 08:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbjFBGjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 02:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbjFBGjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 02:39:16 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D46DEB;
        Thu,  1 Jun 2023 23:39:14 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3525EvgR006571;
        Fri, 2 Jun 2023 06:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=AxqjIQmpePLQdB+LWiRZJ69DBqv8SGkXtv5jWPnYxdU=;
 b=oIDgjur+DWfDNdqcpOLsFY2MHRqulCcGSNgbUH/WcdzdmYBDi9QVVlVXmxiUHCANhx6y
 FXhrtGCHZ0ILHuszGcEZP3mQOcLFMU+9PQRoNHUVs530QXJY3yAfn5DFMFgtbz0XAyBN
 0iqlyPRt8q2nluCm20uGZ3xjZGtEIoyohHOHiT/Dlq5tpN4Is9cgmykJxh/n4MAP/apF
 OBjLg046SAUsQoCbJnwfft+o5cQp81E77JqphUzoDTREjY1qhjqldziB4il//V43c4b8
 ebt8Y6EKL9OM59uXxwSG3BUmnJC2NCQ6zTT+OhuY4uNVHwhdsJuug9hl518KvAzV+syq 7g== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxs9gtbue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 06:39:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7ztA/KMZ35/AM+3kzTo3JcLtXIQ0RNhu7svI1RApGh5FAY8I43zZcBB+m4c8B/ESSw/5e7kt80aHwAykgK7E8d1PfX0mOIYA31JIyIsfPh5RJHhaLvfBn0r8Ssh7I+q1/gYDmF0rkUqBp9drEMD/QruhfVWL/GaAt5GT7UDR4+ChrK3Ee2JTQtoB+Lq3iMA0yAFfUjAIiqY96AAHy+R6rWOWEgX0cjX6JtdASwUCtZLsWVaVp+vpYbjYm9mzUT6nBziD98m7QPLTUwiyW4uZ0AAZ5uYl1Nf1hXwdiburKLlOpWR+3YLM2Rdhk+AFyOWCIDUY1pDixgYR3gAVctKoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxqjIQmpePLQdB+LWiRZJ69DBqv8SGkXtv5jWPnYxdU=;
 b=QGnnS8+XURINRcm+rBnIrvy/NsqE63J3wonzLgeTN6rKsduDbBl1ZUJUUjVBLPG2xxZZc+DDNMWZYaYREwMQgPArpsFvtHXJ8aAJPglZo8ZYw8v79uW6LKftNLfOkD7pJo96eqf6SgNe1h4dqA5iZAJkabCAFN2QZSG2quT0FVaTCuq28mmdYwHVPCVbYKv4OTchiRAFiDuLKsc1NNiYawvSGAuz0sZzxDq+UoXe1XFwgc2l0NkrDU4i7rUMoVqg0hBv37R24zE2ybPL5dwuZxdNX8A8SFfyO2sY/NT6xmzaCI2WItYsQo2zViP1/sOgv4OwKg2yMCwPl1mbLjNQUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CO6PR02MB7731.namprd02.prod.outlook.com (2603:10b6:303:a4::14)
 by SJ0PR02MB8354.namprd02.prod.outlook.com (2603:10b6:a03:3e6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Fri, 2 Jun
 2023 06:39:02 +0000
Received: from CO6PR02MB7731.namprd02.prod.outlook.com
 ([fe80::c0d:35d7:50b:119]) by CO6PR02MB7731.namprd02.prod.outlook.com
 ([fe80::c0d:35d7:50b:119%6]) with mapi id 15.20.6455.024; Fri, 2 Jun 2023
 06:39:02 +0000
From:   "Mehul Raninga (Temp) (QUIC)" <quic_mraninga@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        "Mehul Raninga (Temp) (QUIC)" <quic_mraninga@quicinc.com>
CC:     "agross@kernel.org" <agross@kernel.org>,
        "konrad.dybcio@linaro.org" <konrad.dybcio@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Viken Dadhaniya (QUIC)" <quic_vdadhani@quicinc.com>,
        "Visweswara Tanuku (QUIC)" <quic_vtanuku@quicinc.com>,
        "Vijaya Krishna Nivarthi (Temp) (QUIC)" <quic_vnivarth@quicinc.com>
Subject: RE: [PATCH] serial: qcom_geni_serial: Setup serial port after Deep
 sleep
Thread-Topic: [PATCH] serial: qcom_geni_serial: Setup serial port after Deep
 sleep
Thread-Index: AQHZkugtQgsIHoUoGU+G+KIDXYHr3a9y6tGAgAFoUyCAAQQ7AIABuuVA
Date:   Fri, 2 Jun 2023 06:39:02 +0000
Message-ID: <CO6PR02MB7731BA49B9EBDC82E801F745E34EA@CO6PR02MB7731.namprd02.prod.outlook.com>
References: <20230530111557.10944-1-quic_mraninga@quicinc.com>
 <20230530150631.7eg6nkre6sva5dcz@ripper>
 <SJ0PR02MB7742A7386189692ACACC0A3FE3489@SJ0PR02MB7742.namprd02.prod.outlook.com>
 <20230601040734.qiy3ibrpznrqptui@ripper>
In-Reply-To: <20230601040734.qiy3ibrpznrqptui@ripper>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR02MB7731:EE_|SJ0PR02MB8354:EE_
x-ms-office365-filtering-correlation-id: ecb0d32a-e699-4b88-fc85-08db63340dca
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: euyWjvHJ/eP/n+0N4xMnCCkLP0N8xLKtpIaxoSL23GpDCCAO6Wp1umkyDgXkxIzwiMnvskmScalapfOvWmm9toCwylBvYDILrRa52XGAUisEhoGMZ3NgUHq4wBM9ElvlUF7gVoxCbfzBQ9kSZ6MSJM44noDEGeT0i78ffCRN3cFLTDEaT1TgtvGr45CD3FzMvEDEbiP/KzNHzUmgiedtgLww59ApxAnJAcb3wROPvQ3smqAEXHBeZEwJuPYKYyPi+fqMxoDWOohfsgs0LfINYwfqvTH6AZcHVXroZ8/Gpz2FNIPuplXEkoUwk0as/lekEIObfV6QobzIyozbAImxqxBemWppSz9Zk9yztPAn1kD6MB+uxqh/l0NOffxZmpQzI0ieXe9h/nlI9tA4lCh7upCpC0osxSXqFVnILWmvy4DVZ9vrr8f2Ce3/0Aio2nDfOBG55qc94F1yGNcnKTi22eITT9lCTg4XiwF8AVyzGi/GgAk1ErCOi/1T+7IQF5XKI1RRJ/TgJdz/AjelPQMja30Ks/xUW1UMAg32ApdbEV3VxrgNEc2qDDrAK3VfewztLYN3ck38BMlllImhWD5dRdup8/TnaKiaTR1C1MyVBnmdvuVrvnjFRceqlsBWgnSY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR02MB7731.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(451199021)(55016003)(38070700005)(186003)(83380400001)(41300700001)(33656002)(9686003)(316002)(26005)(7696005)(8936002)(86362001)(107886003)(53546011)(5660300002)(6506007)(8676002)(52536014)(2906002)(122000001)(38100700002)(54906003)(110136005)(4326008)(64756008)(478600001)(76116006)(66946007)(71200400001)(66556008)(66446008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?42y8laDKrW/1q8fgjV0m+1/hMSwdWH4wxSfNIcfAR/GimcDyy7lmRKLtEA0v?=
 =?us-ascii?Q?JwdYRdfqLSgr41kOZW64u/JtPxMvzgeqhHHSJqoPtXwS5C66r5jXnMo4DYFq?=
 =?us-ascii?Q?+w16zIjNxEBacjid46LdgXe9KD5eqIBfJSI/ihL3nx6uIe5a0ogjLGqkAh4N?=
 =?us-ascii?Q?9Sl1GVf5MofVFz9CjGzlHzNGJhQjHx9Jd3J38kThdSAAWzyCG99dmeqPh9QC?=
 =?us-ascii?Q?JWXjp1Gj+HRPL+gtbelIfrAetH5iEpJaV7ndtXbL+b0IZWXBMUsPIUHBtLw8?=
 =?us-ascii?Q?xru56B38xsCgmQ4cUQlIXxWEpyPth8TST4676m0fqhOCwxdoQbOrSMup0Upf?=
 =?us-ascii?Q?d9jwvgs4ZQd5Xzn6ABivcc8a/ILtxrPxPcG60LgBFK0vhl6+AD+cgWkUa2RS?=
 =?us-ascii?Q?kyoyDrIEX7xK8uvnUxjdPWU9CuYJwW5yDcEoqb0A99noMZZ5ECTFMcjMzqdq?=
 =?us-ascii?Q?fooc4Yz3lTmUHb2KAkInoHuVfPCuclOyLmN8GcB2L/8kMSBYcE+D8E+CVnMl?=
 =?us-ascii?Q?rnqUl6/QrxMcDWCtLePKXfCtUSJBzA8rg+R23ESBL1aXZBvKTtutGtFcxB18?=
 =?us-ascii?Q?+6FsIcFi6LhfXFziSm7DCixhZDLWqEHoa99sptSEoHeTdO/il4KWRAWa9zC5?=
 =?us-ascii?Q?K2H9osvrOzC4lwe80A7duyqBj7+2OFSVPJcXJnCQHLUF5AZ1UpUEhshU8eOY?=
 =?us-ascii?Q?RWNIJafyJoElKSlpxWcy8bBIB58tochnLU/SFPcORahWyGf4XUsZjaV1U7Fc?=
 =?us-ascii?Q?D+PY08hbpd1Bup/CjVsC+68xAqMaXXXDJwsluUVlrFpj1AYigBfendkdTDAp?=
 =?us-ascii?Q?T5Z4ADGDnA9dt0ewffHqXE6Y8ZmBAoeH2hSHY2Pqmx0zi/bnut6SOyw/xqcg?=
 =?us-ascii?Q?TAUxj9roYugAtxgu3ez3ob19NpjPjuKSKJYe4ixcHDDIVbzyfQVnTzHu44vu?=
 =?us-ascii?Q?+M+2G2zyUp/fPD8OvMkng6bRza2PzvRVgDgbwwMgOwnSpagVfgCrbxeQlpBQ?=
 =?us-ascii?Q?qEtVHVJI8oNH1N7DQ2ZXC2dpbqIr36NN3lOnlQcKMp5DCTxPj2gTThBeKhR5?=
 =?us-ascii?Q?GblZLvSUZnt+1QCMdH7DhKVYPwhupyMd8R8u8lrfo5Jx5PhnRqnjFKUl+o3i?=
 =?us-ascii?Q?pHO66kCQuLFv5rgwXJ2sWRXZ8d23QwsKtVSZeYQ4z7Fi+/eKmB1c8hH4cjO5?=
 =?us-ascii?Q?LqH/j+1TYrp2+oXUvFeY4zDEKLZI1ex1kUyq4kFst0nwAjbYSySk0llEWsvo?=
 =?us-ascii?Q?fVkbVDcc1ZOf8Q/irxdQbC3LRHhqCjEWAPgJeOgxCxGIYapZibluIuKf4Mwo?=
 =?us-ascii?Q?19/yVBKkk9m/0Ca4zGTZb86QxcwMJ4eHAVdcVIgwkoyxIy8d+Jfp4quWgkOc?=
 =?us-ascii?Q?8LNx9KHLAJfb8w9Pum3qvMVQ2q2Bz6iTDKOv3usQ2ee8X5BL9yovEUxyuuB6?=
 =?us-ascii?Q?oPW54/ge+cPMVofoFeFqr0AGAcmhLDdXzU+FDDOJqT00F251rJI7UVvNbeCd?=
 =?us-ascii?Q?bI9mZUj7j0lJo2VPGdyODv7ghs/+VD4A5drw6/uSseSvy2bB3JqnYO8gtwN6?=
 =?us-ascii?Q?dAgDboM0rNhIOkcQSqXWwIFj7eIqrg42mVC97e4P?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: q4j0wwN7Tudr1tQuuBb8Gd3plM4+fY9rga2epIO33uHA5EfQOoX1XZeBieRZqJX5kljLiqjHqknUUrKC9Clj5FrYhrWbWtj8dnGVeC997k4Wu1GWyNo5Wq47HpoQkAjWwewtXUD99OBDs8XnGm2SbA6FfXsgm6lxtw8fJmuZapmiabEG9s8x9iH8O8NHq4uQfCvmj0pMxQ0wbWQbNVbbbvfAT/hnjrlpoqMDKE+hFD2XAURT4ggZTKGZoXd/j+zJQ2z+mxhetiOUZcXkHtCnkoyWFLVMRWKJfbfwDSzCyEpliGr+7fQRz4ZZt1cynJPGQxQtO22brZDsKkp4nZvOrRDRPx7v/eRM+GRJNaGTe9Afn6keaZoN28QzXYlue8kABHh8NdvmtfUqLg8dsXv5QTQrd6BKKw/Ni7+ArgECn5sMNHychYSEgrRuJaq0lBr8TCskCZSPHznN6ieDZQZXVnFyKKmKeotsDSTdxCBfENRYkpDLIrcpP0zyVuCAxidnn0CRW6FboKTiPUu9cLo862jLjtOwvhqbSbK7OGIV0csLi6HmUxh6wZeceFNAtDPAGPtuCCmzps/opaL3a4SpkKiVQUda0RNQpz8Xuc90JfqdKpUMeNumYUTLunGYs4lFospyqFLokHBKoS2KSisZWAi94LYBMzKRd2oy1uq3OYl2u/8KzjRhnm3nIUcIGG+5kcTDOvuzY1YmODYOKOuMKwXmSlMHFTPV9Ie8Y6xOGmUHi+7grfb3s5T9GFSJTnAYRhNVkLxBqL5Bf7ET2Knf/kUk+As9NTntiowJtQJcNDztj0kJhB3PhhlVb71YbtBsX6Izx1yi/LQDS3OUNUmYWI/G5ZJWgfyVy5QK7Q6J3RLXU02X8SoOU4V6MJTei5FqJpEZG/RC+Hzv/GdG4Jjo4A==
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR02MB7731.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb0d32a-e699-4b88-fc85-08db63340dca
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2023 06:39:02.3715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DFrLJhk1Z6zd2Avr0n0qI0sL0l7gjbXgbzEjlstOJobL4/dblPguR4+qGe/ny8OXUdpucUX3F6VBFhMO/yl6W+BhyRkYgHu+hmCzZmbcbKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8354
X-Proofpoint-ORIG-GUID: LucJVCLtFkA40EKdEYXtnAHV8cCT5oHX
X-Proofpoint-GUID: LucJVCLtFkA40EKdEYXtnAHV8cCT5oHX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_04,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306020049
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andersson,
Thanks for the review. Kindly find my reply inline below.

> -----Original Message-----
> From: Bjorn Andersson <andersson@kernel.org>
> Sent: Thursday, June 1, 2023 9:38 AM
> To: Mehul Raninga (Temp) (QUIC) <quic_mraninga@quicinc.com>
> Cc: agross@kernel.org; konrad.dybcio@linaro.org;
> gregkh@linuxfoundation.org; jirislaby@kernel.org; linux-arm-
> msm@vger.kernel.org; linux-serial@vger.kernel.org; linux-
> kernel@vger.kernel.org; Viken Dadhaniya (QUIC)
> <quic_vdadhani@quicinc.com>; Visweswara Tanuku (QUIC)
> <quic_vtanuku@quicinc.com>; Vijaya Krishna Nivarthi (Temp) (QUIC)
> <quic_vnivarth@quicinc.com>
> Subject: Re: [PATCH] serial: qcom_geni_serial: Setup serial port after De=
ep
> sleep
>=20
> WARNING: This email originated from outside of Qualcomm. Please be
> wary of any links or attachments, and do not enable macros.
>=20
> On Wed, May 31, 2023 at 01:06:22PM +0000, Mehul Raninga (Temp)
> (QUIC) wrote:
> > Hello Andersson,
> > Thanks for the review. Kindly find my reply inline below
> >
> > > -----Original Message-----
> > > From: Bjorn Andersson <andersson@kernel.org>
> > > Sent: Tuesday, May 30, 2023 8:37 PM
> > > To: Mehul Raninga (Temp) (QUIC) <quic_mraninga@quicinc.com>
> > > Cc: agross@kernel.org; konrad.dybcio@linaro.org;
> > > gregkh@linuxfoundation.org; jirislaby@kernel.org;
> > > linux-arm-msm@vger.kernel.org; linux- serial@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; Viken Dadhaniya (QUIC)
> > > <quic_vdadhani@quicinc.com>; Visweswara Tanuku (QUIC)
> > > <quic_vtanuku@quicinc.com>; Vijaya Krishna Nivarthi (Temp) (QUIC)
> > > <quic_vnivarth@quicinc.com>
> > > Subject: Re: [PATCH] serial: qcom_geni_serial: Setup serial port
> > > after Deep sleep
> > >
> > > WARNING: This email originated from outside of Qualcomm. Please be
> > > wary of any links or attachments, and do not enable macros.
> > >
> > > On Tue, May 30, 2023 at 04:45:57PM +0530, Mehul Raninga wrote:
> > > > While exiting deep sleep, serial port loses its configuration
> > > > hence it prints garbage characters on console.
> > >
> > > Presumably it lost its configuration sometime after suspend, rather
> > > than while resuming the system?
> >
> > I will reword commit message in V2 as below:
> > Serial port lost its configuration sometime after suspend hence it
> > prints garbage characters on console after resuming.
>=20
> Please wrap your replies to 72 chars wide

Noted
>=20
> You can probably be more specific than "sometime after suspend" :)

During deepsleep HW configurations are lost, hence it prints garbage
characters on console after resuming.
>=20
> > >
> > > >
> > > > Set serial port configuration while resume from deep sleep.
> > > >
> > >
> > > What happens if you do this unconditionally?
> >
> > pm_suspend_via_firmware returns true indicating system is resuming
> > from deepsleep. In case we are not resuming from deepsleep, this
> > serial port setup is not required.
> > >
> > > > Signed-off-by: Mehul Raninga <quic_mraninga@quicinc.com>
> > > > ---
> > > >  drivers/tty/serial/qcom_geni_serial.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/drivers/tty/serial/qcom_geni_serial.c
> > > > b/drivers/tty/serial/qcom_geni_serial.c
> > > > index 8582479f0211..c04b8fec30ba 100644
> > > > --- a/drivers/tty/serial/qcom_geni_serial.c
> > > > +++ b/drivers/tty/serial/qcom_geni_serial.c
> > > > @@ -20,6 +20,7 @@
> > > >  #include <linux/serial.h>
> > > >  #include <linux/serial_core.h>
> > > >  #include <linux/slab.h>
> > > > +#include <linux/suspend.h>
> > > >  #include <linux/tty.h>
> > > >  #include <linux/tty_flip.h>
> > > >  #include <dt-bindings/interconnect/qcom,icc.h>
> > > > @@ -1737,6 +1738,8 @@ static int
> > > > qcom_geni_serial_sys_resume(struct
> > > device *dev)
> > > >       if (uart_console(uport)) {
> > > >               geni_icc_set_tag(&port->se, QCOM_ICC_TAG_ALWAYS);
> > > >               geni_icc_set_bw(&port->se);
> > > > +             if (pm_suspend_via_firmware())
> > >
> > > I'm not familiar with this api, but aren't all our systems
> > > implementing firmware- assisted suspend?
> >
> > Not all the platform supports deep sleep hence to differentiate if
> > resume is from deep sleep suspend or normal suspend, this api is
> > required.
>=20
> Can you point me to where this difference in flags is coming from in the
> upstream kernel?

In upstream kernel by default the flag is false, and for deepsleep
support vendor kernel sets this flag true.
>=20
> Thanks,
> Bjorn
>=20
> > >
> > > Regards,
> > > Bjorn
> > >
> > > > +                     qcom_geni_serial_port_setup(uport);
> > > >       }
> > > >       return ret;
> > > >  }
> > > > --
> > > > 2.17.1
> > > >
