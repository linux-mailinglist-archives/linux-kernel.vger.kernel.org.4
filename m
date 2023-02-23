Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496ED6A0282
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 06:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjBWFp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 00:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBWFpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 00:45:53 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2612CC48;
        Wed, 22 Feb 2023 21:45:52 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31N492un029050;
        Thu, 23 Feb 2023 05:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=CFFgMHjFUjiIg4qCLQmR88254xzf6nQXEEjevOrd7KQ=;
 b=JcHa5fwJlW0CmtFVK/Ptd1pTFjK72O4f17tpZryvDX/iYnZoJGPGsuLR8hbSm79+boYb
 OkHC17RDGNsYG7NPmO3bCb0OFcauoQM57Y1i9BTs/C+WrQB8UzeonJ7Iwsw0lLuaepcr
 7wMLCy/6nIkSzQbW+zDWEYVYNa16guYscycpwNlFjtdG2s3RhRXzhSop4QUWBF7t6vJn
 gAnMRB1fh9CAf+vP6wxGMxjw3/xV4bC5GXIH/Vycd7EmzjO4hKsHlNsCs5OI74VLDEFy
 nN6kVC2BMpr6m1sSbNXmYBnCMtDnZC+d5jfD5HxRk3EZkYgsTfpUKKZrTUO1QIBdPNTa PQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nwypbrc05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 05:45:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWPd3orp6cGEH9/Ew/88hnH8rxFLvD9p28cCx/wQGlRDHwfKnw0CX224S9wgR5YOgOkgT0XjzceGHiQyqlPVmROZdaOUxfTpZTuxrR0LrA0NCfQfWtH/2Z4weI+aY3RcusD/KZJ0cMQLQhQS69LLVr7aPNLvlCB4vtXYZhg6GvVGPmTROn+b1atrX0QnoJCcPC5ONemCmmP20ibBZAbGYKlZZ2WixrvWQPxKUibKt9VT2ayMIauBKYsz28x0FeM+WZumTo6TYvXqDvDqJJ5F3nbhlVqb3rToE8QPAjcAI72NdOIMO7b6DSm+HOFq4JASmXTHFs9Fgb0Joq95omNceA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFFgMHjFUjiIg4qCLQmR88254xzf6nQXEEjevOrd7KQ=;
 b=WMdNFleLrVRzxLyB10YDWryEWvE2/qvdC48uasvpomYixS0I96uxtlia63RHv7l2S3XezimK8pVaXS4H8WVLz4UlMoq0urE0gIDlNKyjxKvrldV75xjHkxfCdql/s1G9MWoyGS8spt8uZ9Jl7G1EDAPJ9m77vfhfldlaBU7hrPJ9Ama7MTopXvWsu/8cjx1nDtgG4tEmi4FOypWRqHT2FRU9BeW2vKUSjcevURjOfp0GXnq6EOcNlTbfeOoCuVSF8AFfo4CNEhYRPGvfZPnGx4X5oR9bya1CDX8vmMdYGDzz0Wa7psfRFWHpExH+NVMR+a+dXQEPLcNq8umwtl42xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from DM8PR02MB8169.namprd02.prod.outlook.com (2603:10b6:8:1a::14) by
 DM6PR02MB6586.namprd02.prod.outlook.com (2603:10b6:5:21b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.21; Thu, 23 Feb 2023 05:45:37 +0000
Received: from DM8PR02MB8169.namprd02.prod.outlook.com
 ([fe80::6699:58c9:7fbb:c35b]) by DM8PR02MB8169.namprd02.prod.outlook.com
 ([fe80::6699:58c9:7fbb:c35b%6]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 05:45:37 +0000
From:   Vikash Garodia <vgarodia@qti.qualcomm.com>
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mka@chromium.org" <mka@chromium.org>,
        Albert Esteve <aesteve@redhat.com>,
        "stanimir.varbanov@linaro.org" <stanimir.varbanov@linaro.org>,
        Enric Balletbo i Serra <eballetb@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Vikash Garodia (QUIC)" <quic_vgarodia@quicinc.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        Fritz Koenig <frkoenig@google.com>,
        "Dikshita Agarwal (QUIC)" <quic_dikshita@quicinc.com>,
        "Rajeshwar Kurapaty (QUIC)" <quic_rkurapat@quicinc.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: RE: [PATCH] Revert "venus: firmware: Correct non-pix start and end
 addresses"
Thread-Topic: [PATCH] Revert "venus: firmware: Correct non-pix start and end
 addresses"
Thread-Index: AQHZOt4trMzBaaZ5zE+7PcOTvgimf67DrmxggAEVDoCAAxZ1gIAADYWwgAARp4CAAdsZgIAGDYUAgAABLACAACdbgIAJiz6AgAKHGuA=
Date:   Thu, 23 Feb 2023 05:45:37 +0000
Message-ID: <DM8PR02MB8169E16569616870A583B376F3AB9@DM8PR02MB8169.namprd02.prod.outlook.com>
References: <20230207102254.1446461-1-javierm@redhat.com>
 <DM8PR02MB8169809493BF2822E6C29EECF3DB9@DM8PR02MB8169.namprd02.prod.outlook.com>
 <ef09bc9f-d570-be11-238b-bd34063917fc@redhat.com>
 <70c01751-1dd7-c4bd-a96e-94dea437aa40@redhat.com>
 <DM8PR02MB81696369DBFE619E43F81EEFF3DE9@DM8PR02MB8169.namprd02.prod.outlook.com>
 <e87344c6-acef-7f3f-5cac-24961dbd9401@redhat.com>
 <6f97a117-0d9c-e21b-9adf-50f2233ba9e3@leemhuis.info>
 <ea283f0a-ca72-447e-ce87-68c1bbee793e@leemhuis.info>
 <CAFOAJEdBbzqkGVqw+vgNYNxyaTHwvjFyskTwjycP820L2tOctA@mail.gmail.com>
 <b548da46-bf91-6f1c-4b63-4002109056bc@leemhuis.info>
 <9a0bfef8-0b5d-f4d0-a8a5-4bbcacc5c0fb@leemhuis.info>
In-Reply-To: <9a0bfef8-0b5d-f4d0-a8a5-4bbcacc5c0fb@leemhuis.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR02MB8169:EE_|DM6PR02MB6586:EE_
x-ms-office365-filtering-correlation-id: e9d8a669-4163-4f38-bc63-08db156130a5
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OnWwE/T0lk/X8D2bUiqHNQQllYED3HbB1pKYlBbJ6hnGN6k2gms29CDbliT1QSkJd+ZydNZh6lXR7FkBcn51Koj63KtHLvnjAqSMJvhqoes9Ty2tJX1RIBf4dZRWbST2GY1J7JLphchxiRvUcTrUX+UV1LRGerBILtQsXH+xUfm25/fbPXtBuhPUrAld8HETaC1P3M/TVglgQaBH1ivEA1lV5J+BKwischhdLcHqZx87vZLrUVodG6JQyaXeBaBsKyOgp9Z2DFHPlfKAOICJIFxn++bdc8E20E0/XS2n0HLyhm2DtzNaiTwo8W+idg53DgQmxHMhFVGr5WpTQhpFcZNfLeQaav+MZ4UrVH3N4SIiU1HscPtCUATXFToX/USPOwYRk95gVpZWi9k9AvgklMboRNvTG5C2wnYsriipYD61CM5V2Oi21SlO6jb+0vUHU9GmI3iSssXAokQgfOzlRsNk0kjf+61nKn/3yS9x9p1J5oKwCU4hTGa+1NusvSCRQBYK5MkcEIhk38xqpW/imzNb0wHd68ot3JREe4m7/rWOtn7lHmaBMmQBIk9UZLb444wMFyRcMkVW8JsTx2sxVULaSdgNEU/dsRnQi4ILd/mo/612iCAwjAbxUrf+mO6+kZ63flBL6tlO1+/SS1Dj0zWglYmDIAZslD7jNfeOAmZTEOqz569oPQ9q8DrHvHogonbI/uKEPaUHwBnPfMtN90LxiIfHgMq6JfWzwFWiEeA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB8169.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(451199018)(66899018)(66946007)(33656002)(38070700005)(86362001)(2906002)(5660300002)(52536014)(41300700001)(8936002)(38100700002)(83380400001)(7416002)(122000001)(71200400001)(54906003)(66446008)(66556008)(110136005)(966005)(7696005)(8676002)(76116006)(64756008)(66476007)(9686003)(53546011)(26005)(186003)(478600001)(4326008)(316002)(55016003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmU5VUNZRGFibDNTMklzeUY4WWdMVXp6NWt0Qml2TGJWVk1rUDIwTmxKa1Nz?=
 =?utf-8?B?RVhGUk03MkZGb0VlOTUrOWUwY1REbGZlL3lmYTdPV0VTRWxCMUVpQlkzVC82?=
 =?utf-8?B?alhaUG8vSzNhaGEzVkRubjJEWllQM1hUc1BwSVFpRzF3RG9aR2NkUTVFWXZE?=
 =?utf-8?B?Q0ZtQkx5TEpOK0M5US9OWWllc1ZmdGNPOXU2aHFxa2RnQUE3TXNZSm9iRFZ6?=
 =?utf-8?B?bi82YU5lL3l5QlNLMFd3S1QvUnFWNDFvMVBNMlh5Y2N2NCtmZkxIWnI4K0Zt?=
 =?utf-8?B?cVVpa1RKMllISEV4S2YyRm9SN0taQTFwVElpRVpHNEcwaFlubFhKL2c0YmRW?=
 =?utf-8?B?V1JXWEhsOHlhaXRZMCtiY3hHUmtvNzE2VmpNTU9kS2d2clVobkU3bS9QVW5r?=
 =?utf-8?B?M0J3ZlNSRDBnMmpTRE5zMDFMazIxLzlJSFRESGlSemd3dHRXd0dzT2FBaFBR?=
 =?utf-8?B?UEtHVk92eXRNK1VRaG1SR3ZyblJjaC9tWVVTWTB2WEN4NFZMZkNnd3RxSml6?=
 =?utf-8?B?aHJZYzFqeG0raUlESHVWcmY4a092UE8xMmlMdE9EbUw5MWI0QWhkV0FYQm8r?=
 =?utf-8?B?ZG9jSkh4R2t5REpicGM1R0hSK0tjQ2RNOWpaalZKUWQrbkMwcnZmeFNRZXVJ?=
 =?utf-8?B?UDdZSmdxdE96WERadUFFdlBhSWFoanE1WVI1TmJkTXJsM0lheUkycUF3UlV0?=
 =?utf-8?B?ODQ3SG1DOTYrYk8wbUZOZ0xXeVdmZWRablJoKzZ1anRZLzY1RVV2dC92cWFM?=
 =?utf-8?B?QUJFaEhVZm9aZzhHQnpjT3d3d2pVSGJiYkJXaVlvano5TmdNZ3pqRFlBLzJY?=
 =?utf-8?B?UWJNSFRnbXg5ZUVCRVlPRnc1eU9VTi9RRWw2WjMzaGZQcFk3bVRtVDNSUjQ1?=
 =?utf-8?B?VEVIS01pNytGSk5ZWnNoNzZXZmx1THgrTWhOM05DRWkzTXFpQVJPOEdYRFMv?=
 =?utf-8?B?TE1JMThkdDhOWDJHc3RTajBISENSN2s4RmhnY1RlM2VteGtKaVhXdlExaEJo?=
 =?utf-8?B?aGV3RU4xRnBFT2NMUS96NzZ6Si9qalN4dEZFcXg4Tk5jeVd2SndXMnFFeXBp?=
 =?utf-8?B?SXdXbzJrRm5GSVdsTmQ3OTFRdmxmOUdpNGZ0OHM1bnJlK3RwMEVuUE1wNkhp?=
 =?utf-8?B?dzVibGk1QzM3YVI1WExOQWxUV3o2eHZDaHRwNmZaVUNINDZPc25uelFIbSt1?=
 =?utf-8?B?YUdXY21ISGMxOUtuKzQyaDM5WG5oZjM1VG14VmxjdC9pclBQWnYwOEl6SXl5?=
 =?utf-8?B?NGpERHZnekxSYjAyWEF0bVJTcG5PUFUyUkN2QzNNT3JSSTZCM1M5NlR1OERy?=
 =?utf-8?B?WDlQS2kraGVYcGpDL2hiZEFxVjJHT3ljQko5UzhzMmFtVW9WdDN2a2h2L0Nh?=
 =?utf-8?B?SFN1cW5mdnpvS0FVMW9vcjJ2YlJDUXhsRTFiVTdaNTBHd0FnTDlleHc2Rzlw?=
 =?utf-8?B?eWhWeU5uemF2bzZOWmRCZ2pvRFpUbGFWSUVTUFFhUmt4dGZvaFNxbUg1RnpB?=
 =?utf-8?B?NXo3WlllVFZHaFBpWTl6SmZGY3A4Y0hXcEExWmhaQ1RDbUIrNGhMUldjWkRP?=
 =?utf-8?B?RTVqZXBUZVNzNnlqRTh4WUFTSjFVcUZYdFZTRVlhRExyb0FWNDM5cVlJRnpt?=
 =?utf-8?B?azVEeDNlMkFSa3Jac1FDemk3RWJhWUo4WDF3R1dHVkxsV2wwM2U2Wkwrak9M?=
 =?utf-8?B?S1FCVDlQcklFd0xuaklOQ2tzYXJ2MWlJZDFrQjUwbEwweEoxdzRPYjVPbW9s?=
 =?utf-8?B?QkxrL2c5VG1UYUVhN0hJYmVvTFNFdGF6L082ekhQRi85Z3BkVjhxQmdnWlFV?=
 =?utf-8?B?cDBKNUhCckNaajRXODFXdHdUbTdUU2dhSVp6NE05THdmcEg5SW41VWkzQURp?=
 =?utf-8?B?N1NIUlFQL3BIM0I1U2JwTHV1VEtuRWlMNUJLVlRuSUZOWitXcDEyWGR2bEpO?=
 =?utf-8?B?ak4vbkRmRVg0M1hjRUFjeVRTNDBWbGNjZnZmT1k5YUd0K3hBVTQyRnorcC9T?=
 =?utf-8?B?K3JFbytwMnhNV0o3amhJQ0syZW1VRm9iTG40ZTBpdUpkeUNyR1NiLzdtVEFt?=
 =?utf-8?B?dStQQ25paW4zQUxKOUZHdU9hRnE5MWxMYzBoWE14TU4xOEN5WHVXQWNkRkVu?=
 =?utf-8?B?L2tGeGRsckNZQkZ3YlQrR1dnang0WWx2MXlENjVJU3BodGZlc0UzWjhzZkxp?=
 =?utf-8?B?Q0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UFlqZDFNYk1sczZtd0U5NGU5N0FDMEVFdmhUYzEwTDU0NmFEWitGM0c2V0Fn?=
 =?utf-8?B?OVRFbE5jbTV1VW1GTkNWVk4vRndyMFY5RTNyV0NRL0NDaGR4NFJsdklCNC9a?=
 =?utf-8?B?SXVzUTc3VGVuYkpKTVJZcVBDUzVZa3M1ZDgybXNWd3RVNVFpUGpWOTkzWGdT?=
 =?utf-8?B?TmVnL0lWTGJhUTh2WVMybHFJMzRjT3U3eGVjbkNNYU9MbXZYYnRvd1Q3Ymx1?=
 =?utf-8?B?djEzRDBJa1U0MXRLVkhSRkVFUktBcnVHRnJ3c1pYVWlLWDFWNEZiTXF2cTV6?=
 =?utf-8?B?WGNHbjZtb05HOGlPa3ZKSTEyRWtXTWR0NHdQRGVoajhyQ0RmWUFBRysyWnhV?=
 =?utf-8?B?ZzB6anFSdHgxVDFTMlVTWDhyVnFKZVhWa3ordzNGRWhmdHBxdlhJTExFNnN6?=
 =?utf-8?B?TXBRYkZZZDJ6STRlbXB4clZ2UkwvQVJBL2Rzb3daSVdqVS96UTlva1ZVcUdU?=
 =?utf-8?B?QjczOWJzQlV6bk5QYWplSDA3SFVjdXAxUGZSd2ZOVlZ6V05qcy95MkRGSmI2?=
 =?utf-8?B?dHBaSHBzWVdJQmZOa3E1RXVidVE0Wkp4VHBhNVNQVm5TNmhDVVBSci9tblJr?=
 =?utf-8?B?N3ZIYzgxVVEvTUZHOW1Yb1NHOFVXS25KMXVDWTF6SVRKY09ndGJpUnhldi9z?=
 =?utf-8?B?MnF5a1p4V3pkcUVLZmpsU1NSUy9sWmNZV2xzRlNXeXRFSjNJZjF2cnFseVU2?=
 =?utf-8?B?KzcwRVl2aXV2ajhBdkwzclNSNGZpRm5tV3ZTNi9zakhkVVpHemRxWll0VUcw?=
 =?utf-8?B?TVFveUFNSGtoTUpsU28zSmVmZ0svd2dZb1I0dnZEQjgvTWRsSzZWcGdXSGYx?=
 =?utf-8?B?WEY3RnNoUlhpVVFPcmxuTmJ5Sk1wbnpTWk1YT2xsaFlYbVN5WG1KTU1sWDFE?=
 =?utf-8?B?SFhDaGhjMVY0ZjlxVGVFekIvc2xUVThURVVVekNYeDJHZjNYM3dDWWt2WG82?=
 =?utf-8?B?WlhtTnlEdDE5THh6blhmT0c4Z3pBaFl4QURNMmIzMkQ5WHRCNjRxTEMrbGFV?=
 =?utf-8?B?UnpuVkYyNldhSWZUaGFxczNVZDJnUURPbG5IVEFVVUo3RWorZHJWUzUvMnRX?=
 =?utf-8?B?bkRNU3BqNFZ0R0tieDA3MjgzT0RCc0p5d3NVWjBuTjdDUHpxbE5tOCtLNTRL?=
 =?utf-8?B?c1E0dDBiRzZQem1JZCtnc3oySGhzMyszYng0WTRIM0R2UFpJTUhGakF2M0ZH?=
 =?utf-8?B?eEhkb3BzVUREUmtXQTZEMW0zclJvOXRlaGdsZ3RIVnpPaC9xclFRNlVET0xZ?=
 =?utf-8?B?VDFWakw2azgwaWNveDVzV0ZpZ3hjTWdvZFFmOW0xeEMxLzhkcGYyTlJMRmhF?=
 =?utf-8?Q?2wUvBIPCV0TOKJ+ZC1HL+CTvWPV2IsWrP7?=
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8169.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d8a669-4163-4f38-bc63-08db156130a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 05:45:37.5079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NZUxVVcZRXx3gP/JXJdoK4JKw5XdRlTO2lW+dTIUy282VWeL+xCLOfVffxJQEBcE+SHAobe/0fzAiv1x5L+D2iXRFKWcEYoXMDny91oDjQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6586
X-Proofpoint-ORIG-GUID: wsCCKWPxXiGTS-JocpI3M52aUqWEeC6N
X-Proofpoint-GUID: wsCCKWPxXiGTS-JocpI3M52aUqWEeC6N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_02,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxscore=0 spamscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302230050
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxsLA0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBUaG9yc3RlbiBM
ZWVtaHVpcyA8cmVncmVzc2lvbnNAbGVlbWh1aXMuaW5mbz4NCj5TZW50OiBUdWVzZGF5LCBGZWJy
dWFyeSAyMSwgMjAyMyA4OjMzIFBNDQo+VG86IFZpa2FzaCBHYXJvZGlhIDx2Z2Fyb2RpYUBxdGku
cXVhbGNvbW0uY29tPg0KPkNjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBta2FAY2hy
b21pdW0ub3JnOyBBbGJlcnQgRXN0ZXZlDQo+PGFlc3RldmVAcmVkaGF0LmNvbT47IHN0YW5pbWly
LnZhcmJhbm92QGxpbmFyby5vcmc7IEVucmljIEJhbGxldGJvIGkgU2VycmENCj48ZWJhbGxldGJA
cmVkaGF0LmNvbT47IEFuZHkgR3Jvc3MgPGFncm9zc0BrZXJuZWwub3JnPjsgQmpvcm4gQW5kZXJz
c29uDQo+PGFuZGVyc3NvbkBrZXJuZWwub3JnPjsgS29ucmFkIER5YmNpbyA8a29ucmFkLmR5YmNp
b0BsaW5hcm8ub3JnPjsgU3RhbmltaXINCj5WYXJiYW5vdiA8c3RhbmltaXIuay52YXJiYW5vdkBn
bWFpbC5jb20+OyBWaWthc2ggR2Fyb2RpYSAoUVVJQykNCj48cXVpY192Z2Fyb2RpYUBxdWljaW5j
LmNvbT47IGxpbnV4LWFybS1tc21Admdlci5rZXJuZWwub3JnOyBsaW51eC0NCj5tZWRpYUB2Z2Vy
Lmtlcm5lbC5vcmc7IEZyaXR6IEtvZW5pZyA8ZnJrb2VuaWdAZ29vZ2xlLmNvbT47IERpa3NoaXRh
IEFnYXJ3YWwNCj4oUVVJQykgPHF1aWNfZGlrc2hpdGFAcXVpY2luYy5jb20+OyBSYWplc2h3YXIg
S3VyYXBhdHkgKFFVSUMpDQo+PHF1aWNfcmt1cmFwYXRAcXVpY2luYy5jb20+OyBKYXZpZXIgTWFy
dGluZXogQ2FuaWxsYXMgPGphdmllcm1AcmVkaGF0LmNvbT47DQo+TGludXggcmVncmVzc2lvbnMg
bWFpbGluZyBsaXN0IDxyZWdyZXNzaW9uc0BsaXN0cy5saW51eC5kZXY+OyBNYXVybyBDYXJ2YWxo
bw0KPkNoZWhhYiA8bWNoZWhhYkBrZXJuZWwub3JnPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0hdIFJl
dmVydCAidmVudXM6IGZpcm13YXJlOiBDb3JyZWN0IG5vbi1waXggc3RhcnQgYW5kIGVuZA0KPmFk
ZHJlc3NlcyINCj4NCj5XQVJOSU5HOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRl
IG9mIFF1YWxjb21tLiBQbGVhc2UgYmUgd2FyeSBvZg0KPmFueSBsaW5rcyBvciBhdHRhY2htZW50
cywgYW5kIGRvIG5vdCBlbmFibGUgbWFjcm9zLg0KPg0KPk9uIDE1LjAyLjIzIDE0OjE4LCBMaW51
eCByZWdyZXNzaW9uIHRyYWNraW5nIChUaG9yc3RlbiBMZWVtaHVpcykgd3JvdGU6DQo+PiBPbiAx
NS4wMi4yMyAxMTo1NywgSmF2aWVyIE1hcnRpbmV6IENhbmlsbGFzIHdyb3RlOg0KPj4+IE9uIFdl
ZCwgRmViIDE1LCAyMDIzIGF0IDExOjUzIEFNIExpbnV4IHJlZ3Jlc3Npb24gdHJhY2tpbmcgKFRo
b3JzdGVuDQo+Pj4gTGVlbWh1aXMpIDxyZWdyZXNzaW9uc0BsZWVtaHVpcy5pbmZvPiB3cm90ZToN
Cj4+Pj4gT24gMTEuMDIuMjMgMTU6MjcsIExpbnV4IHJlZ3Jlc3Npb24gdHJhY2tpbmcgKFRob3Jz
dGVuIExlZW1odWlzKSB3cm90ZToNCj4+Pj4+IE9uIDEwLjAyLjIzIDExOjA3LCBKYXZpZXIgTWFy
dGluZXogQ2FuaWxsYXMgd3JvdGU6DQo+Pj4+Pj4gT24gMi8xMC8yMyAxMDoyMiwgVmlrYXNoIEdh
cm9kaWEgd3JvdGU6DQo+Pj4+Pj4NCj4+Pj4+Pj4+IFNvIHdoYXQgc2hvdWxkIHdlIGRvIGFib3V0
IHRoaXMgZm9sa3M/IFNpbmNlIG5vdCBhbGxvd2luZyB0aGUNCj4+Pj4+Pj4+IGRyaXZlciB0byBw
cm9iZSBvbiBhdCBsZWFzdCBTQzcxODAgaXMgYSBxdWl0ZSBzZXJpb3VzDQo+Pj4+Pj4+PiByZWdy
ZXNzaW9uLCBjYW4gd2UgcmV2ZXJ0IGZvciBub3cgdW50aWwgYSBwcm9wZXIgZml4IGlzIGZpZ3Vy
ZWQgb3V0Pw0KPj4+Pj4+PiBJIGFtIGFibGUgdG8gcmVwcm8gdGhpcyBpc3N1ZSBvbiBzYzcxODAg
YW5kIGRpc2N1c3Npbmcgd2l0aA0KPj4+Pj4+PiBmaXJtd2FyZSB0ZWFtIG9uIHRoZSBjYXVzZSBv
ZiByZXNldCBmYWlsdXJlLiBUaGUgb3JpZ2luYWwgcGF0Y2gNCj4+Pj4+Pj4gd2FzIHJhaXNlZCBm
b3IgZml4aW5nIHJhcmUgU01NVSBmYXVsdHMgZHVyaW5nIHdhcm0gYm9vdCBvZiB2aWRlbw0KPj4+
Pj4+PiBoYXJkd2FyZS4gSGVuY2UgbG9va2luZyB0byB1bmRlcnN0YW5kIHRoZSByZWdyZXNzaW5n
IHBhcnQgYmVmb3JlIHdlDQo+cHJvY2VlZCB0byByZXZlcnQuDQo+Pj4+Pj4gR3JlYXQsIGlmIHlv
dSBhcmUgd29ya2luZyBvbiBhIHByb3BlciBmaXggdGhlbiB0aGF0IHdvdWxkIGJlIG11Y2ggYmV0
dGVyDQo+aW5kZWVkLg0KPj4+Pj4gWWVhaCwgdGhhdCdzIGdyZWF0LCBidXQgT1RPSDogdGhlcmUg
aXMgYWxtb3N0IGNlcnRhaW5seSBqdXN0IG9uZQ0KPj4+Pj4gd2VlayBiZWZvcmUgNi4yIHdpbGwg
YmUgcmVsZWFzZWQuIElkZWFsbHkgdGhpcyBzaG91bGQgYmUgZml4ZWQgYnkgdGhlbi4NCj4+Pj4+
IFZpa2FzaCwgZG8geW91IHRoaW5rIHRoYXQncyBpbiB0aGUgY2FyZHM/IElmIG5vdDogd2h5IG5v
dCByZXZlcnQNCj4+Pj4+IHRoaXMgbm93IHRvIG1ha2Ugc3VyZSA2LjIgd29ya3MgZmluZT8NCj4+
Pj4gSG1tLCBubyByZXBseS4gQW5kIHdlIG1lYW53aGlsZSBoYXZlIFdlZG5lc2RheSBhbmQgNi4y
IGlzIGFsbW9zdA0KPj4+PiBjZXJ0YWlubHkgZ29pbmcgdG8gYmUgb3V0IG9uIFN1bmRheS4gQW5k
IHRoZSBwcm9ibGVtIHdhcyBjYWxsZWQgImENCj4+Pj4gcXVpdGUgc2VyaW91cyByZWdyZXNzaW9u
IiBhYm92ZS4gU28gd2h5IG5vdCBxdWlja2x5IGZpeCB0aGlzIHdpdGgNCj4+Pj4gdGhlIHJldmVy
dCwgYXMgcHJvcG9zZWQgZWFybGllcj8NCj4+Pj4gVmlrYXNoPyBKYXZpZXI/DQo+Pj4NCj4+PiBJ
IGFncmVlIHdpdGggeW91LCB0aGF0IHdlIHNob3VsZCBsYW5kIHRoaXMgcmV2ZXJ0IGFuZCB0aGVu
IHByb3Blcmx5DQo+Pj4gZml4IHRoZSBwYWdlIGZhdWx0IGlzc3VlIGluIHY2LjMuDQo+Pj4NCj4+
PiBCdXQgaXQncyBub3QgbXkgY2FsbCwgdGhlIHY0bDIvbWVkaWEgZm9sa3MgaGF2ZSB0byBkZWNp
ZGUgdGhhdC4NCj4+DQo+PiBJbiB0aGF0IGNhc2U6IE1hdXJvLCB3aGF0J3MgeW91ciBvcGluaW9u
IGhlcmU/DQo+Pg0KPj4gVGhyZWFkIHN0YXJ0cyBoZXJlOg0KPj4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGttbC8yMDIzMDIwNzEwMjI1NC4xNDQ2NDYxLTEtamF2aWVybUByZWRoYXQuYw0KPj4g
b20vDQo+Pg0KPj4gUmVncmVzc2lvbiByZXBvcnQ6DQo+PiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9sa21sL1k5TFNNYXAlMkJqUnhidHBDOEBnb29nbGUuY29tLw0KPg0KPk5vIHJlcGx5IGZyb20g
TWF1cm8gYW5kIExpbnVzIGNob3NlIHRvIG5vdCBhcHBseSB0aGUgcmV2ZXJ0IEkgcG9pbnRlZCBo
aW0gdG8uDQo+VGhhdCBhdCB0aGlzIHBvaW50IGxlYWRzIHRvIHRoZSBxdWVzdGlvbjoNCj4NCj5W
aWthc2gsIGRpZCB5b3Ugb3Igc29tZWJvZHkgZWxzZSBtYWtlIGFueSBwcm9ncmVzcyB0byBmaXgg
dGhpcyBwcm9wZXJseT8NCg0KV2UgdHJpZWQgd2l0aCBkaWZmZXJlbnQgc2V0dGluZ3MgZm9yIHRo
ZSByZWdpc3RlcnMgYW5kIGFycml2ZSBhdCBhIGNvbmNsdXNpb24gdGhhdA0KdGhlIG9yaWdpbmFs
IGNvbmZpZ3VyYXRpb24gd2FzIHByb3Blci4gVGhlcmUgaXMgbm8gbmVlZCB0byBleHBsaWNpdGx5
IGNvbmZpZ3VyZQ0KdGhlIHNlY3VyZSBub24tcGl4ZWwgcmVnaW9uIHdoZW4gdGhlcmUgaXMgbm8g
c3VwcG9ydCBmb3IgdGhlIHVzZWNhc2UuIFNvLCBpbiBzdW1tYXJ5LA0Kd2UgYXJlIGdvb2QgdG8g
aGF2ZSB0aGUgcmV2ZXJ0Lg0KDQpTdGFuLCBjb3VsZCB5b3UgcGxlYXNlIGhlbHAgd2l0aCB0aGUg
cmV2ZXJ0IGFuZCBhIHB1bGwgcmVxdWVzdCBoYXZpbmcgdGhpcyByZXZlcnQNCmFsb25nd2l0aCBv
dGhlciBwZW5kaW5nIGNoYW5nZXMgPw0KDQo+Q2lhbywgVGhvcnN0ZW4gKHdlYXJpbmcgaGlzICd0
aGUgTGludXgga2VybmVsJ3MgcmVncmVzc2lvbiB0cmFja2VyJyBoYXQpDQo+LS0NCj5FdmVyeXRo
aW5nIHlvdSB3YW5uYSBrbm93IGFib3V0IExpbnV4IGtlcm5lbCByZWdyZXNzaW9uIHRyYWNraW5n
Og0KPmh0dHBzOi8vbGludXgtcmVndHJhY2tpbmcubGVlbWh1aXMuaW5mby9hYm91dC8jdGxkcg0K
PklmIEkgZGlkIHNvbWV0aGluZyBzdHVwaWQsIHBsZWFzZSB0ZWxsIG1lLCBhcyBleHBsYWluZWQg
b24gdGhhdCBwYWdlLg0KPg0KPiNyZWd6Ym90IHBva2UNCg==
