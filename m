Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2F772E1C2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239119AbjFMLfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238329AbjFMLfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:35:40 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FA2CD;
        Tue, 13 Jun 2023 04:35:38 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DAbT3l012549;
        Tue, 13 Jun 2023 11:35:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=SS5WrGW9ZfEOLF7WZA3G4fBtHQia1/ohIJje5XSJ0tU=;
 b=OtbT3cA5Vs2VGSFu5xYLv4zyPK2hbmxWhBb9jcwBfQDR+vOgOFL4zX8xuhsZp9y0sGvZ
 tT48NfxBczUtXB/lO5eqMaTbr2NurL1Ck8U60QZXHoVEFlHSdmng+tI1WIDADNjm6R6f
 EXJ/R8GCDFwWFuoFBVpLa1UVOwaWzF1M4GfdJE22JibbEkleib6CUbtbmfnRfCjHOjW4
 nw+WlW7+FkCop0N8K+5DhANHQGXiwpT+1uxiT3AamCGrRKroVFua7s2jh0FfKcYBgReu
 tU5WqZ1kzzVca3FRAUe6npCH2fem/OO8EtG1tGBUaxn4Ve3cgZMjWPIRlVi8Mk0b3bjB kQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r6a8ysfp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 11:35:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TpBoclaE7IDIBkNn++QMradBAsqAslVyCCxZJcr/4EhjxBgs8Btyj8XzRWuatfMOpyePMqa9g2pb+LtZmanxt75ahQJlXg9kyNRdiwLyHLLLni/HlW60A/KdF6eW3L7xt4CGuS6MS1XXRPZbXLoVc+U17B+spqvDpTYfdu4ecIXoXqqH40pbNll3fvet8yGrbyKb5LwOtge3xSNT9lyOujVU8SKDwy0PgmTCUaC68paKP9ltLCdrWe8kSy39jFho7K61UVCu5nHr0BkeNTQQfWkTgRkrHi8mk6hTeLStCMYGFmVpnDF5t7fssgZkgRJQS9SvMG6q54W+1XniReiVHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SS5WrGW9ZfEOLF7WZA3G4fBtHQia1/ohIJje5XSJ0tU=;
 b=Xb/O1xqxwDHiXh7IG0jGB26wN7n7UhG1zg37QdBFFKL6ZmSYlAQreqeayT+ksTKDuNvPV7VLjv5vZYIwN0xlF6qZugyQRn420TIL5VUXHh8Kq+eFZt0cRar5UuDPMgrvpBYIuOP7lAZOjyDCIJyDVV2C8ZqRv/Ado8Q0lz9H1bq87cCldc19hazHv8ZGibrvHMevFQWTcxWRAUlfROF2fnpUrCC6rwrmtBgIQhrbx6Oo9MdqMBErD8WysEX9Qt9R5f3+FOUhfFYrNF4kiuDR2B3UA+GIMuHvdSscET5yE58+l0NF96rGosWKWBxKdLRwO2tSu+muhPAAtE4RHRNJ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from BY5PR02MB6770.namprd02.prod.outlook.com (2603:10b6:a03:20c::17)
 by CY8PR02MB9524.namprd02.prod.outlook.com (2603:10b6:930:6c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 11:35:31 +0000
Received: from BY5PR02MB6770.namprd02.prod.outlook.com
 ([fe80::35f5:e657:3d42:8d6e]) by BY5PR02MB6770.namprd02.prod.outlook.com
 ([fe80::35f5:e657:3d42:8d6e%4]) with mapi id 15.20.6477.028; Tue, 13 Jun 2023
 11:35:30 +0000
From:   "Mukesh Savaliya (QUIC)" <quic_msavaliy@quicinc.com>
To:     "Praveen Talari (QUIC)" <quic_ptalari@quicinc.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "konrad.dybcio@linaro.org" <konrad.dybcio@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Mukesh Savaliya (QUIC)" <quic_msavaliy@quicinc.com>,
        "Visweswara Tanuku (QUIC)" <quic_vtanuku@quicinc.com>,
        "Vijaya Krishna Nivarthi (Temp) (QUIC)" <quic_vnivarth@quicinc.com>,
        "Aniket RANDIVE (QUIC)" <quic_arandive@quicinc.com>
Subject: RE: [PATCH 1/2] soc: qcom: geni-se: Add SPI SLAVE mode support for
 GENI based QuPv3
Thread-Topic: [PATCH 1/2] soc: qcom: geni-se: Add SPI SLAVE mode support for
 GENI based QuPv3
Thread-Index: AQHZncPKGvyzmiHkJkS+nMVuNJLseK+ImiYA
Date:   Tue, 13 Jun 2023 11:35:30 +0000
Message-ID: <BY5PR02MB6770F5A65ADF5899920CDC60E655A@BY5PR02MB6770.namprd02.prod.outlook.com>
References: <20230613065229.5619-1-quic_ptalari@quicinc.com>
 <20230613065229.5619-2-quic_ptalari@quicinc.com>
In-Reply-To: <20230613065229.5619-2-quic_ptalari@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR02MB6770:EE_|CY8PR02MB9524:EE_
x-ms-office365-filtering-correlation-id: ec475526-79a1-4388-e33e-08db6c024acb
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G7lTdhfoxsX8x6sToaAhriIRqW7rLv6eoiLlHEcTY17NlDcqNO7wjy+UaVhwctKPTLaqyir+34uZzuovUuZifuzbpIiT+9Dhk7qaA9DKPFaRJupNTRIAb4fIzpveuU/2tOsz+8S0VAaH9K44PkcJbcPn7V+yehFqWE78jkm0wcEhoGmuKNQg4aa0zIaxi5htgEoGfj3xDNPvrNa+Ql2KKzum4aSvlBKS6HSWYg/M1ERtfEGiKf2Tau72SeTFgb96QPI6e+VjgnBWk0g6dPdyfLjyV1DpGkj0zb9mdANaphdsVUtXOSMQQJEptIsxirRaGnywnR4SGKYhcDOL/zClLi2mJguQfx8BxGCuEe2TsUmZA44M6Qi+6Z5eccociy1qYXHNOMoZ3SUPWf1kruNru5oEiQhYoeCGgyK6qFIxcLJqNCjOj8zdkR4+9nMQlnl7g3eKSBoH/l3XEk6SxX7aULAJo/6Hca79sez9rGYa3ER/uw2rJOlJk/M7WOK+DjW+Hf/pGAongE6CqUJnaR2hauFXzyMgLQJfctE765K0ou0LikAzKiHu8VQMwWjUl8Ks/OWOtklutqJzqhC4S+OhR9mOydLdQWXCHXbV87NbFXO/5xlm/Xr/C1aVLzgioitT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6770.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(6029001)(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(451199021)(83380400001)(33656002)(38100700002)(86362001)(122000001)(38070700005)(55016003)(478600001)(71200400001)(76116006)(110136005)(54906003)(4326008)(7696005)(8936002)(8676002)(2906002)(5660300002)(52536014)(66946007)(64756008)(66446008)(66476007)(66556008)(316002)(53546011)(186003)(107886003)(6506007)(41300700001)(9686003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b5LBuZREIS9jRxAzox1C9ux3oNZ6sW94KRyvUg+u54RhrUkkRuwwQtWIwemL?=
 =?us-ascii?Q?gR/msjg/r2qXDkickpXPH/uTGXaFBKPC1JfSI8KpgdoQwhp7Ul9/AoOEjzKA?=
 =?us-ascii?Q?tbaU8CpIa7KUIyLOtKnrEIFUcvyP+eoBP5SgZjeXAectjREZ2QZD5IcrPJtf?=
 =?us-ascii?Q?E3B1sSuPOQSLpYsx09ls/jUOHMhSoeMLM9vXRZMLrr8/B2ae0OMn8fMXbkDu?=
 =?us-ascii?Q?6VCrgo5osnLCBv4HIk1K0ZpWc96JVOvp2fMWimmab0LpK1RIR2dhcnTzdU7b?=
 =?us-ascii?Q?wFSOpnVROravEsYvmkyOiewDilkPxfrpUI93DQnqTBPz4M4+UJtY9ISYToXc?=
 =?us-ascii?Q?IYPAp7H94FqrQqpoHwk1QQTDYTJENHoP8Q0WI9PPpKYJpchboNPK2Y5sRiy6?=
 =?us-ascii?Q?BzjH2u2p1+6A+NDgJ2ZSq/gZynhjk3Rq9ruG2oDqTBcdlkG+SrU2q4o6IzeN?=
 =?us-ascii?Q?9LncbDNRwSKZfQ2bNSctKKN5yjq8WOlW2GQPdKYS9iX/whpvJj8NWXUzOkGE?=
 =?us-ascii?Q?cKtH2IYnJoYfy98j4/CUNzQjHgbK8stsAh2UXBh0xC2Wt8byZ49IHZWuEKKh?=
 =?us-ascii?Q?ocdWWpTmQnlhL9OArcEvZsXYuEAdWGncaE5Ad2FCPGt7CTLWDcEbU/o4hRml?=
 =?us-ascii?Q?Xf082Ragkkxc/nrplhkmf4xyAg7zJe7vvH02YgHB288+2zN53SOPV8pGvE+L?=
 =?us-ascii?Q?N31U19LWCsvCJjTOKOVtYZmaP2EuGF0ftYggfGS1lqhMA5IGnE3oioMy1Vwn?=
 =?us-ascii?Q?ts8SEp7GptFrjYpm5EpwAQsV1qIJq6LorhvyImi9ZaozXlegXokcBtq9i2Dw?=
 =?us-ascii?Q?UpS1IYNpszY+dNKtnRwP0heQYpJ6zG3ngro76cMpYJnY5IstYnCUYZ/gAWUp?=
 =?us-ascii?Q?FuhKbc+sk7diStgRTvwrb91yKiH9FspZeHYwQ4OYU3rmqZk0bScod+oaIx03?=
 =?us-ascii?Q?WE7FKG0omw0+RR1tMIMJPpMAuMY/3HB7xzuNZDO9dnUaUVjvQY97dnAZsqPb?=
 =?us-ascii?Q?OimPNUYd2jX9noJ+Oo1S3VZgcuYqlVi7Ks4+ldVOF69t33bfWBcZxcPc22UA?=
 =?us-ascii?Q?L61+xtId9bQKCpnfusr86SNbB58UT7lmCsutveRDB/6OWYpa5nFfNzu66zOw?=
 =?us-ascii?Q?C9qbNSgQ0G6bqR7pVQi2GgKwMdqpT9S1BupC4dvW2h24iIMYOmn6vCmQrisR?=
 =?us-ascii?Q?o9Su0UVxJRTvG8bPlFlzDKJJKWvk2SaGhEqcTczO6x57eGIP+hE/MXULKDXv?=
 =?us-ascii?Q?YLqjuxgBvojr20xrC9tSKkCVw3WVy1X6Uz8ttuYj+z4sUaSplC3c3i8sa1Pi?=
 =?us-ascii?Q?ZlX8nrvdGfAi+UzqP5DvPCVfxLMtwgo2aqzCeXE2VSo/2/cFKTdXjf4jd23Q?=
 =?us-ascii?Q?WJhghzhyRLlqUlskN8z5aYFwZf8yYgdKALBQy+y3crm09j11CHMZSK0vLNyf?=
 =?us-ascii?Q?aQiQSmMEQGskhlu6mJIOcVtYQSr81BDrKt4/0o2pi8/UV3YtFcER6UtOODVg?=
 =?us-ascii?Q?n3zhua7LTHVpkbwhMDPv2Hdu1/9bqXAB8m2ax0NbTn+8YMfXpdwWBR2t5YkY?=
 =?us-ascii?Q?dsQp5O0aMagii7aPTuZeYJVSjzm2UjWJUpCWl/ut?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Uyd2msm5BJ0x7hp0W9GqRuaLzCjbgpGZES3dGysxAWP1VieG56G01ryUH6voNob6EgyHdBBFJPCCeFBK5hRft8IirY/jlxva2h4drRPY7Bxeoj5/BQ/CmB9h9ANH25azlHiblW3i8teunmcBDevECHH7dFumU81FJmNsSDKcwfYqrGn6Tk7Pz8wNtU7eDbqdY4D6nFb81DvG3Z2xYsM3vvKIWXG8kOsTAjjGm0pm1/K+k9VwPUHtbaEJOVMp9QLNgqjCAwVSVE2jG6mcpswl0qrE0nUD2Q4/aiEggNJE4Uo641+tuOlq81oiw+AGXIVkeS4MRxyKyBU3u0+KLZmqt55jefc8tRSRXSpg68Ok6SO9XfrO/p3lSBA9WnP8vqwR4qyLDh+bQCgjHCGf+KYP//BS5NXmkNLYVR9PwfwLpl5zu5CSATZjEkL/BTlbMWjpoLlg2v89RM86mgr0GSAfUJ4y1ZTYQToo94Qkl5o5H5PXoTZQVMaB2IeCs9ydmEQHnZuMzIdJUfhqxKay1HQAv1KZ3rpfeKqx8QStivt7/03dKVrVx4XbIopB/ISk9AmCFV+aYXY3KJhACPjRZFlRgfsdTJsuijsksBWl4X6oQnlSXQB88sT0utXNaUTkdRphbcqxaICuEKs3VWWZZbosaZtcUkkwCa1JFbr5NKVP/7HrgdZuhHbx/lbTLZeIlmWCL2IN6EobUp31xblnrhtKzaBhgxm/rNvb8hym+dfG6v69teSjm847dk5hDqJUwbe9Ibh4m7FtOxWELDanMikIwOZkGT4L/SvIjYBx3oO/ifM+eTBy1m9zbrgpTf4nUIXB0zBEBCnIKt8XQdIym6EeZQ==
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6770.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec475526-79a1-4388-e33e-08db6c024acb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 11:35:30.3644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZppSZ3ObSLVx90Oht2zdpCyhkfBN+T4zM65M0ict8l059bM6tZnP/UodvzKHmM+0CAZnqGdtPPgNBlF7zrU6c5g+vVqSLHdvlhJWGDC9WCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9524
X-Proofpoint-GUID: NQhBn58lY53p8UmW9Ie4nf8SX4zHx75W
X-Proofpoint-ORIG-GUID: NQhBn58lY53p8UmW9Ie4nf8SX4zHx75W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_04,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 malwarescore=0 impostorscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1011
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130102
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Praveen Talari (QUIC)
> Sent: Tuesday, June 13, 2023 12:22 PM
> To: agross@kernel.org; andersson@kernel.org; konrad.dybcio@linaro.org;
> broonie@kernel.org; linux-arm-msm@vger.kernel.org; linux-
> spi@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Mukesh Savaliya (QUIC) <quic_msavaliy@quicinc.com>; Visweswara
> Tanuku (QUIC) <quic_vtanuku@quicinc.com>; Vijaya Krishna Nivarthi (Temp)
> (QUIC) <quic_vnivarth@quicinc.com>; Aniket RANDIVE (QUIC)
> <quic_arandive@quicinc.com>; Praveen Talari (QUIC)
> <quic_ptalari@quicinc.com>
> Subject: [PATCH 1/2] soc: qcom: geni-se: Add SPI SLAVE mode support for
> GENI based QuPv3
>=20
> Add SPI SLAVE mode support for GENI based QuPv3.
>=20
> Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>

Looks good to me.

Reviewed-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>

> ---
>  include/linux/soc/qcom/geni-se.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/include/linux/soc/qcom/geni-se.h
> b/include/linux/soc/qcom/geni-se.h
> index 821a19135bb6..29e06905bc1f 100644
> --- a/include/linux/soc/qcom/geni-se.h
> +++ b/include/linux/soc/qcom/geni-se.h
> @@ -35,6 +35,7 @@ enum geni_se_protocol_type {
>  	GENI_SE_UART,
>  	GENI_SE_I2C,
>  	GENI_SE_I3C,
> +	GENI_SE_SPI_SLAVE,
>  };
>=20
>  struct geni_wrapper;
> @@ -73,12 +74,14 @@ struct geni_se {
>=20
>  /* Common SE registers */
>  #define GENI_FORCE_DEFAULT_REG		0x20
> +#define GENI_OUTPUT_CTRL		0x24
>  #define SE_GENI_STATUS			0x40
>  #define GENI_SER_M_CLK_CFG		0x48
>  #define GENI_SER_S_CLK_CFG		0x4c
>  #define GENI_IF_DISABLE_RO		0x64
>  #define GENI_FW_REVISION_RO		0x68
>  #define SE_GENI_CLK_SEL			0x7c
> +#define SE_GENI_CFG_SEQ_START		0x84
>  #define SE_GENI_DMA_MODE_EN		0x258
>  #define SE_GENI_M_CMD0			0x600
>  #define SE_GENI_M_CMD_CTRL_REG		0x604
> @@ -111,6 +114,9 @@ struct geni_se {
>  /* GENI_FORCE_DEFAULT_REG fields */
>  #define FORCE_DEFAULT	BIT(0)
>=20
> +/* GENI_OUTPUT_CTRL fields */
> +#define GENI_IO_MUX_0_EN		BIT(0)
> +
>  /* GENI_STATUS fields */
>  #define M_GENI_CMD_ACTIVE		BIT(0)
>  #define S_GENI_CMD_ACTIVE		BIT(12)
> @@ -130,6 +136,9 @@ struct geni_se {
>  /* GENI_CLK_SEL fields */
>  #define CLK_SEL_MSK			GENMASK(2, 0)
>=20
> +/* SE_GENI_CFG_SEQ_START fields */
> +#define START_TRIGGER			BIT(0)
> +
>  /* SE_GENI_DMA_MODE_EN */
>  #define GENI_DMA_MODE_EN		BIT(0)
>=20
> --
> 2.17.1

