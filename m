Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86CF5F97EE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 07:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbiJJFsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 01:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJJFsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 01:48:52 -0400
X-Greylist: delayed 4867 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 09 Oct 2022 22:48:51 PDT
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DF14DB4E;
        Sun,  9 Oct 2022 22:48:50 -0700 (PDT)
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29A0f8mL016620;
        Sun, 9 Oct 2022 21:27:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=2aZn1gHMxolnrFCPFDxqofhTJnK+vBze9LQpCkVQpMs=;
 b=WZW/ToH0yQ0HeeGPqoG6/Rx3T7zED/hXXli69qpOn6fMx4DvPTJttCYQlkDUsOxeDlwX
 BXuWmlPEle0bDq79lEYZu/6EkTVEHNODLd42Lq23jWSRw/DRkGm7ExjNiEn77aVpsG1/
 jMgzMkS4lciiVHH0saOvfcEVlH/xogzgfZA1pbnPPzszuTzJOUpRa382k94TBM1UqgIK
 bPOghsEFviE8EI7LHzyTO7A2ybN7dRLzR47eulnO5UhMu4qsgo6n0gxkAKfMcGShKOub
 sDyh0Bc/uxRGS/X9drgaYxcLO4sKRYFoG9zF7La0Pl7+47DiQlRvM0cQ9HIy3VXnd1s6 tw== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3k35rvxew2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 09 Oct 2022 21:27:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bX7YYPGNJPB/hn//gummJ54thgWHynRLJf6Z6+Trv/lAh50i0gpnGu9ajjZcIGwzcGlx/ACrqeIhfax8KphQWGjQjib23lSXoItPWsTjK/+dnJk8Rq2+tRAyiP8iGMkEa2Domx9ILrCZd9oodrOZZ6ln/Wxy24+EkSztiJY4fsnaOrWP6Vhs6fgUFQTv3pIAtbauZ5iMIbs33eH7ddXbZHTJjUdLK5+Kz2e+daS+ofpwkSMWhM0C3/LL4dfHCsx3dkOlKzSFY3LmCJIMMhCY3y6ESATezaREVAXEqWDAU/lOVWvFcLZNzI6HMUc/tCOUVK8tMviPk9O3j9zaV2kguw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2aZn1gHMxolnrFCPFDxqofhTJnK+vBze9LQpCkVQpMs=;
 b=hDaiW/BSyEBM8/Bpjb2m2a32ebc03oklSqYL1R/H3Dy0R1UYOCcjEm9n637vLzYkme7rVrpdkSMrAcEE7vYeOCBcHKAHZwLAcIWplkcQyJqQTi8feB12cp7FxwhI1wAWLYR9kKQuwHLa5FpoaRae4R/9vCFhGDGaqlwXIA0j75zXXbspgtAq95OnwgyVD3KrS8iFyLDDCeY0VQCw63ljZC4ghDMinkPhCqdsNGxPv+Ej9eHdx3QK2dNb1wdpqk+5H8i2Qt+nUXsMXQsPzgrl4NF27jxkUKt/PmMmmYyfBjyF7vVzoiR7wI/4wTx+te2plf9HGmD7M3DZGpqc4OaHyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aZn1gHMxolnrFCPFDxqofhTJnK+vBze9LQpCkVQpMs=;
 b=azQa/yalNQVHyA2i4N5BggfmqHP5gh/NZjbcv6vsU2BUtGqcn9nFaZfI8xvnx27gPvyp0Wf4aFn8nrKHM+tcka+CVmeT8/ldtMWb7ubS5oYeVFEtyhoJBqEgrZCDZajgYD+ijjuXrlGzwx1S2UcFOQ/AztNmVQb/LF+K/MfuEIQ=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by CY4PR07MB3160.namprd07.prod.outlook.com (2603:10b6:903:d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 04:27:15 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::22a7:7839:ee96:eb89]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::22a7:7839:ee96:eb89%4]) with mapi id 15.20.5676.031; Mon, 10 Oct 2022
 04:27:15 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Dongliang Mu <dzm91@hust.edu.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: cdns3: adjust the partial logic of cdnsp_pci_remove
Thread-Topic: [PATCH] usb: cdns3: adjust the partial logic of cdnsp_pci_remove
Thread-Index: AQHY27ATjFC1Puf270uKLKm53d01q64HCYkg
Date:   Mon, 10 Oct 2022 04:27:15 +0000
Message-ID: <BYAPR07MB53817EF4EACBA1CECEED97FDDD209@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20221009072305.1593707-1-dzm91@hust.edu.cn>
In-Reply-To: <20221009072305.1593707-1-dzm91@hust.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZDA0ZDA3ODEtNDg1My0xMWVkLTg3Y2EtYTQ0Y2M4MWIwYzU1XGFtZS10ZXN0XGQwNGQwNzgzLTQ4NTMtMTFlZC04N2NhLWE0NGNjODFiMGM1NWJvZHkudHh0IiBzej0iMTEyMSIgdD0iMTMzMDk4NDk2MzQyNzMzMjA5IiBoPSJMdmNWZUc4MFFoa2ZLdlhhMTFYTnd1Tzd1RVE9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR07MB5381:EE_|CY4PR07MB3160:EE_
x-ms-office365-filtering-correlation-id: 53cabf8e-70c4-4527-ab93-08daaa77b59c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HsNaYqy01OYtkpgA6VTqiS6SgCLIzVCzpDZDlzX47JnN+C3Az+aFDlDQFOICuDrxZ/1oLoWL9qUvqldHxfxlVHcFmCwSM34d6vPBdOxf21Bj4ktFN+3eUjzTEQUCNH9YWAWSVxI6+wSRttf94i6aqAFPigjx6f8Zg46LLioFr1GsXequPH+yyT0+d7ctR2pjlEcbyneppmdXJpvoje5rZA4PudsuRabFeecfvF90qKNeoPru5z7mHJpwU4wlObHUZDnu8q6vQuct+QrS95rorHH6VJN+9x/1rWqwzVXyRPskLWO4JswPMuFVM5MjJuDA/RVLdyEyYH3uYs32CmaCD/1bLrFsWJzYIhJKnNtcbmq11omS9k+fUohMXZOzk0wfNl2+bpRvKFCccdGMRw98taj6QC6neVLsxFmo8J4kRlmjZ2Sri6uGcNg9NIycV7QgdF66NQBDI1urBiPwjAreSFwPJkaOK3zzlQIEHs4f08J8vkypUo/7j8gB0M/UTEC4RBGUwxA2fyFFOWi4jcl9JnSXq70kPGZfzupcX1tXaMsop1Poq0zUS70nfPQQ5gG/5+cjqfItMiwOtAiIfn5hvfino8lZhzsoAMLDEtVh8KwNwW7K1ptcYU7ZUtfBY4/3kTxv9IzafffAHGzNQJWoitSUesKr10s5nyaWOQpWB0XZyEW/oIcOrRhUsR4WnxeiO4avQg5y3efAAClP3bIN5y9dLytx9KbxoAfO0besdMbsUDl0IDt0LBH4mYNs9fnCiUk9JqJjjGkole75151b9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(366004)(376002)(39850400004)(346002)(36092001)(451199015)(38100700002)(122000001)(86362001)(33656002)(4326008)(55016003)(110136005)(38070700005)(316002)(54906003)(71200400001)(4744005)(52536014)(5660300002)(8936002)(64756008)(8676002)(66446008)(66946007)(66556008)(41300700001)(478600001)(186003)(76116006)(2906002)(83380400001)(66476007)(7696005)(6506007)(26005)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1Ewy3RK19ZU8NJf/HBHab3OIdGDE6aXrG4zdR0/iI+raEHMKZK+mHAKLRkAD?=
 =?us-ascii?Q?fIajypMWM/cbYmfC+DgKfwz3DxtYYumyq1h/CEH7l3zM/MlpylhLtvu92HVe?=
 =?us-ascii?Q?4EuRVUcafhYNJuKZPCj++v0t0TMejiReiHWxXN1Ry5oDrI2v0oq9Rj2QhP/m?=
 =?us-ascii?Q?ayRzwrAm1f3DURMSOqXXtvT0PNMEwzP0U0tOyHnmM6G86WAQ/EYUFWfL5yfs?=
 =?us-ascii?Q?h1ODNMGeN+stv3ng8PQkb5F6bdg80jco7vxb7+oh7ezLC+zyaO+QPcv4nKK7?=
 =?us-ascii?Q?Ikul/VrU8wIkAFSR/isYm4HquERCKYUtg7fsLu3isGzkCU7ilribNFQfp7Uc?=
 =?us-ascii?Q?SGyDAgVqpm1lMGnmMlqHsCL5aG/Yps9L5UPQUnhobYrVh9RMc1UDnRIYu8Zi?=
 =?us-ascii?Q?3k2LzKOO2GJ5jcN0rLXOYvItM6wE2jTNKAfHxvZjawmLVYKF+9OlvxYkkl6r?=
 =?us-ascii?Q?oMvYTEozL1wfkyMDf5uJtwGqdsoZyBjonXpek8/Tk8ksX+zc8dIdYS4y6fuX?=
 =?us-ascii?Q?Ev4Kq/vruPT4Y2uTu4e6YkaCqgOhIRZZURLWXIBJa3G2hgRUa0+bpqTeMCK9?=
 =?us-ascii?Q?jkkyBb0JM58hPPIVtnMv7L2BVkHwV2bUkowfjPcxa3nIUaTNz3x6Lz4IwVhG?=
 =?us-ascii?Q?t6h/B6DH4r4U8xTLQCn1IkCraFOrjAlaKNpXOAvCkTNdoxVHM6ptD+PiPSP+?=
 =?us-ascii?Q?4A7NDrV+PI/KqsSwI3l3X+MPoJBkz03+wvXsdoQudcJOWl23+GCsPdSYNqCf?=
 =?us-ascii?Q?mNjdMCf11hMqpwgVJA8dRRgqoLV6twVJWmzVYDXBB5T4BQ8aihrWt5syloy+?=
 =?us-ascii?Q?J8i8YsMYNV7FO/x1IpwkrVLn10rttil2+YoF8zzBdpTXp3iBryl/SscG4D/o?=
 =?us-ascii?Q?5oQtWsaNb3x36WGnVVD0uJygDWhGyj4AfueE5N+MrAfZai3MIsym7KGITZH1?=
 =?us-ascii?Q?Ug+BFZjwN1jsp7SrIB8WC2q5sEYMXTCVVQvc5tHZ6BfERre1tH+jDEUx33gC?=
 =?us-ascii?Q?31rX/1zFAXB8KOWNp6OkNm6ABq9X+u5YHl3uT8RBTyg8/eUlPzARKbJNAQz3?=
 =?us-ascii?Q?oMqobguhVUZxAeX0a/wKIwvsqdYhgJEDVcqFSyzbpgIPk+OE++wTTq2GHfZ7?=
 =?us-ascii?Q?8lwYCEeiAek1b4jAnIYowih7UMbxZvWnr4twQMlZ0eDsLQ6P1MByNtZGVsy9?=
 =?us-ascii?Q?DUCYB7VPi/UZ2rdyOsuspeIS9LYshQMdZZSwEv3+OgLpyU23Okij3rQE0+CF?=
 =?us-ascii?Q?3306hUT95ClITgRD7DJhl5QyCDBzcY5jQ4tP+mD/8DuAX0UNWExA5AtTOW+v?=
 =?us-ascii?Q?h78S8maH6JL/Wr7QcWU8YOCghld2JM4493L+qsvKhtPyxBWpwuoKVHU8eN2Z?=
 =?us-ascii?Q?cw1lu5/JKm81j/VOBCPCXshc2AMgWp45eYsKJs5KUN8oLKCO2FNotGEzymKG?=
 =?us-ascii?Q?3cj/b1RqJPJS8T5/9fdOgyS2i4rq6vDS+4yHVUls9aqxphOFrMmnkxGw9yiU?=
 =?us-ascii?Q?S+kLqRkNcW6Qlh4pSPPf6KHvuXsfrScKVEsN/vLUOhgWTVLTqfD3CPpumCxu?=
 =?us-ascii?Q?I0mzyq7xWO9J7WkQ0aBot7KTLVtJW2QvIsi7t95+t+NxNjHR643Mm1khOLTz?=
 =?us-ascii?Q?Mw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53cabf8e-70c4-4527-ab93-08daaa77b59c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2022 04:27:15.0495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dWECJflmNlFqqKluakJVa5x3Hudcx6e0gWIh7sV6RNTJwTUGquiq0pTsTzuDAkN3l18ziHwaCBVe1GTKOHpxs4ZMMymGnXMUqdRXaiagBfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3160
X-Proofpoint-GUID: APgSWVIzeBEy-2YJcji_6VLxk3qM6_17
X-Proofpoint-ORIG-GUID: APgSWVIzeBEy-2YJcji_6VLxk3qM6_17
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 adultscore=0
 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=938 suspectscore=0 mlxscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210100026
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>In cdnsp_pci_remove, if pci_is_enabled returns true, it will
>call cdns_remove; else it will call kfree. Then both control flow
>goes to pci_dev_put.
>
>Adjust this logic by modifying it to an if else.
>

Acked-by: Pawel Laszczak <pawell@cadence.com>

Thanks
Pawel,

>Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
>---
> drivers/usb/cdns3/cdnsp-pci.c | 8 +++-----
> 1 file changed, 3 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/usb/cdns3/cdnsp-pci.c b/drivers/usb/cdns3/cdnsp-pci.c
>index fe8a114c586c..efd54ed918b9 100644
>--- a/drivers/usb/cdns3/cdnsp-pci.c
>+++ b/drivers/usb/cdns3/cdnsp-pci.c
>@@ -192,14 +192,12 @@ static void cdnsp_pci_remove(struct pci_dev *pdev)
> 	if (pci_dev_run_wake(pdev))
> 		pm_runtime_get_noresume(&pdev->dev);
>
>-	if (!pci_is_enabled(func)) {
>+	if (pci_is_enabled(func)) {
>+		cdns_remove(cdnsp);
>+	} else {
> 		kfree(cdnsp);
>-		goto pci_put;
> 	}
>
>-	cdns_remove(cdnsp);
>-
>-pci_put:
> 	pci_dev_put(func);
> }
>
>--
>2.25.1

