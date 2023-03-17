Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A046BDFC7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 04:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjCQDq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 23:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjCQDqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 23:46:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC539977C;
        Thu, 16 Mar 2023 20:46:52 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32H0dZRX026768;
        Fri, 17 Mar 2023 03:46:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=l+Y3mhyQ06UTosIAyAV/ib06/m/74b1OX6NpDp0MuaQ=;
 b=XXflz/FvB/KmzgbbOwxmfOIA1NZAWjNzbw7ZQbYa6tXtNmi+kVFznKuzLdHIAILxw9i5
 //jmPbpIijb6AqwPHb632cgEdOc5A3hssPxcu1BN9jlN69KLdE+XXe6ky5L+KB8j5hZh
 G6vQM6Bx8zY7z0DbGrksMNGourojGRHuZmk5wnLyPozD/Bf57bLRoRb8EYuWdEBH4r8/
 Exckeg8Y+Vv7kxlND3qbIUOTaklcBxyZMEkzW+ay+DjQkZ/WhJcUO3nzcl0Bs1D4bhOP
 CbDSngCA346snjNr7w6Sw6tkq7AK5Wux9fZu8AfhzncsAo47NS/ii552aYEhBM8Watuc AQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs29jyeu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 03:46:35 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32H0V75n029728;
        Fri, 17 Mar 2023 03:46:34 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pbqq665ec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 03:46:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g257m2OHhIbU3/LXhawW9u37RFln/133CpMjs5lJl95fB0QcX3Au2YyCgPX9rPk33jHVx8+LJvks6yopf8BhvE1dT0S3XGlzqCqBSYE2pw8c0wRU9aw3wvADdOyyvHK0uAS75IbFHvatwIuNclNqbEXMEsoCQn0Z2WBwVTpe7Pq8ZS0eurh0ywyloymX8l2p0UaWXemsr2pEC2GHj2BMeYKG6crNUmyT5c+i3cmxfrgk4siFaFhr82A7bt/8eV+DWtoKsHbVrw5DPdCNFEEgkeQsqhvfGBUGzteiOTBIUbHfxdJGm65GPicG0+OWZUezqws/s2rFjtMMHXCdVmgaWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+Y3mhyQ06UTosIAyAV/ib06/m/74b1OX6NpDp0MuaQ=;
 b=MHIZifYJTN5HBxaaIAW3RJOxZCHJBM9D4uE6B3QTE7pw9ktVGz6N3VYHxRvnRghlQ3MwE8njwPlBu9anzr8BrYS+o5GoYyqdO4OTGksbGsv+5A16bXbNNy1aYkecWiXL0eaPJKIQhadEthu30lJp8TrXe3T5bJS3vmJSUt1j6cMGHK6+NwOsH7GFqSjoC/ROD3wUrwgdtX0Vc23U6JbunfKr28an9jtzJbkUS4X10+wM2RX0Mv1MFqNi3TKlr3Xrnc4mdyOoXck+2MMv6TdnS9M3rGigQRTkdB6m85/Xu6giCzsdeXkVZgarXBUNM13tEkcBQyKBAmcFIHKeA5OaYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+Y3mhyQ06UTosIAyAV/ib06/m/74b1OX6NpDp0MuaQ=;
 b=WGUxJkujF43Gl+n9Xn0gIzp6oJnt1KeYtlJxNif8KnGX0Yrg0B4036Dq8OafJQzz3Nx57ZRjCGjG30jr2+GlrMOf4Vf+T8AgGCK5eiAN0XIHGUk9+M/peuK30/8AvekDz201LstXewSAzGfpVgtYCOIBkdZdetRuV7QfwJLqnRI=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MN2PR10MB4269.namprd10.prod.outlook.com (2603:10b6:208:1d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 03:46:32 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2%8]) with mapi id 15.20.6178.031; Fri, 17 Mar 2023
 03:46:32 +0000
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-scsi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/3] ufs: qcom: add __maybe_unused to OF ID table
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1zg8cvy46.fsf@ca-mkp.ca.oracle.com>
References: <20230310214435.275127-1-krzysztof.kozlowski@linaro.org>
Date:   Thu, 16 Mar 2023 23:46:29 -0400
In-Reply-To: <20230310214435.275127-1-krzysztof.kozlowski@linaro.org>
        (Krzysztof Kozlowski's message of "Fri, 10 Mar 2023 22:44:33 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0116.namprd11.prod.outlook.com
 (2603:10b6:806:d1::31) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|MN2PR10MB4269:EE_
X-MS-Office365-Filtering-Correlation-Id: 52956a8b-e53c-484c-d89f-08db269a3277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wmW/0GkfaESRjdqJdiELW8CA3wI5SALkd6kQgMZz7kxW+FmAsLHXuIvMLnoKJBjc6UDhQaaa0wrkbrZcGTWWBQbA1az6h997dI9jk6gzSNvduQhGJ1GtLbAmKids8m2CPCSG/fBEiWYpHP9gna9Cs1/8hJbCqMoOYeYb1bpdIF4+HPQzl0897VFytT14o3KInxbPRgswavQBbNzd2+u7o4S+Iapr0gwHieXiUrxffhIxC8dTX1O9Wh9VLtrJbp1zYbxbXUH2i7tT4+d69YOJz00kRtMnaITzhGGUEkMNDVJzL9WV8tZ8x/Yph060Ufyd7stvHi0CCftz5vRycv4SFpIYm43aPtKXm35gRyXWmseSL9BWcpcWZH/WkeW4t2W8gDSnNCL/FhNyzlCLO16NbSRoztrUz3yo1RK80Gnj1n/CEUc+S9ShnRb/T3Zd2+RuJVI63n/JjZ/bDVr/0VAR/kVCdmh8C1ZboijtQggdv/NFNXO1BrrGAuZQ3vFUdyq/Y6oSFz3mdGAzXaDzeBKhr9Sn60lNz73OBQtSuXPrNBpC5Vgjmu6AqBY1PnbcXTYZCoGjs2H8zbYPy7JaiKrDmw8tPUPQDOYN2/kIyZ7YZdVdckoNWmkXmjNltHMXo9mtt/JKfmjbS/vaEv3notN3aEs5fMLqeAKPs8oXD10oeuVVpuCPCzcl9RPBZFC+i8tg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199018)(41300700001)(8936002)(5660300002)(7416002)(2906002)(38100700002)(558084003)(86362001)(36916002)(478600001)(66946007)(66556008)(66476007)(8676002)(6916009)(4326008)(6486002)(54906003)(6666004)(316002)(186003)(6512007)(6506007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HB09Ek5tEeqlc9CqnjGAT3Vr41zPsAmWr14CaW96vnupCy8scqTrYkHWXgCJ?=
 =?us-ascii?Q?HzmxSCyBitOel/pVYTWEZgbaJcmk8LMWXzgj6P5e2XY8A94ouEwsZ7OTrA8g?=
 =?us-ascii?Q?yLXoGImUKBcfqB3OPu0iVXq2ZorXcBo813++++DPvlLZxGhdfrTF9yl6Bmc2?=
 =?us-ascii?Q?QifsWyu5dBfCez873AOPgWXndYoxf3oBWAeRToqJGclfUQHisbDT+TRGEjPr?=
 =?us-ascii?Q?d5SaAn/7b6T7QiegNIK8zEfC9BTGA9G1YFmNHqkfG++bJ51Eo3Csb/3l4zzw?=
 =?us-ascii?Q?mw+SawPVpent0QYiG4AmS6+/3cWW3gT73ekwfvuH4++TB9CMb4VTlrMhqMYF?=
 =?us-ascii?Q?reRj5yjiamynAAPe4CR0OVZpfOiECv/9FUApMW89vy3OvhhKEsEWbUaoKtP7?=
 =?us-ascii?Q?lT8c21Jy9KAxaj4cw3icys7ebmgpbky4+eC5aVNBMMdHl6cgKP2nDISJE+RM?=
 =?us-ascii?Q?WqSp0Tkjn8oUC5kMemzVQuMGAhrQOhnUqXHCBstsRfz3FaYA+nlp/DhkHSUy?=
 =?us-ascii?Q?MTS950Lme/tQVj36AlUxY4xAL0QwxtcmZGuX4fnLawcrbmOuzWlkK+geiVDa?=
 =?us-ascii?Q?DjFhxYPAgexBC7tEAiDEqGHBHT/i+XY73F//Ya8YZB1kGBCrlZD5bQhFvEBe?=
 =?us-ascii?Q?tiOPqdgi//yuOVWOYVQGQ09PoBr2vQYY+haF6pdsF8O64pkCUbPMHVss5cS3?=
 =?us-ascii?Q?gRc6Ky4j2JHpSmcP0+xUb3AQmGurqsHT/drRNXQ7j6d6L3FNU63svKaolMrV?=
 =?us-ascii?Q?JMfOxDsVc7q+Got4zIxEhSKMiEB73dC3HnjHvm0/oX6OwegXGyoFcxYR9TRA?=
 =?us-ascii?Q?kFxko6edPmCS90kwQ05tfy7k3S7FEUz0UbcHiVtQFC5UpMTxszsXr/I9U/s5?=
 =?us-ascii?Q?e1gtkA+jlNabM+LeDnYMvs5mI20QiVTF9Z4NS5v0abebUOKjHcAQabMaZpyd?=
 =?us-ascii?Q?+id1kSwhZKFML5f3lDCYpuFc416vNP4TTf4h86EqTQuNXua2eDLKXc1XV76M?=
 =?us-ascii?Q?g+0JiALZN6OIPAI/5kUTHtQ+KL4ZreH+LzQWuwWdPrPmO96aLhVsL9FECSdV?=
 =?us-ascii?Q?GwPZFDDYFkbJkRIVATqZi7Vx2dEhQoV8j7cydt45XAejVmMtRsoaN6srgEo6?=
 =?us-ascii?Q?51PgS6/fChdFcujzEM12A3sADTw9tF385P8GOLDPdrMgWzZyi7O1JEHAw4nG?=
 =?us-ascii?Q?7dqgtX2QvQlpTnPlzcoplhScvU2+IROm8rkJRwT/o9FPOTlRUxyKwJrMXOG6?=
 =?us-ascii?Q?9sED0cYIvtbouHcEv19iXtNgPpzHPC2y6NqAA+Bvoe7UAH296GDNc/mgqKBE?=
 =?us-ascii?Q?oK8umzKLq30HnB4pUsOWqMT4/deWCm1CBuechWp702pFqfPxCsQZWZVP73if?=
 =?us-ascii?Q?Xw9WjzLnBka3EeecVPpswqpieN4bRIGKAriM83jy20OFW2P+9Y3ppn8trSPP?=
 =?us-ascii?Q?AfwZKp0+yC7Z8/5for83N3EqmsEARkqCf7hqiY7DYiXDIY1ilzOBOsWyi0B0?=
 =?us-ascii?Q?YrUf8DkvYCsWrsRhwubag8HQPqCafQKi4Rtv8GYCHL3Wzwgo8DyAxAGdV4TN?=
 =?us-ascii?Q?z+WrQX699I7CekT94YfwcdZ0rlUOppP0+xjGHOWlXukbLG5twUry/u/0sugC?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?KdffqjOSYE1cUUUmCYBwcKOSXkhzR5fXSoC/k020GKbcuz3rHr3XLA6jF6dX?=
 =?us-ascii?Q?X+OM/rhgTUqLmCv5Mzk1qsE0v+/dnzfCcHT3tmZ0WvPh8fbfEajNuIQDV2UD?=
 =?us-ascii?Q?63PC1URCwIvyje8jxCmsfUbxIpk48FvcNJGsIBV+k0xwcW301tTlgJwkrsDB?=
 =?us-ascii?Q?DDRNpKt5jRh4EdfnBrQldCjhIgxJLOynCAuiO5CnHTJthMhtwSanVmVk7nHo?=
 =?us-ascii?Q?b6nPG2DwtCcX6JL5TKOAnhZLbIbG0FsDNwc0x5rkYwpZ4CVGwcPWcfi0qcEu?=
 =?us-ascii?Q?PsuvS/dlhG4NApwqsB7qVyuuNV1Tp3D8Liv7gBNofZSevNRPN5zC65DcNZp0?=
 =?us-ascii?Q?s0loI4XHGUakCUmEq0fT5Stvf6OseQpJLB4JmhacXw88TAtiT6oeh+Xq+P2B?=
 =?us-ascii?Q?v4UMsPtX/V0eyBV2HlyoQIINm9g3rYfYBzDrFPa9eDoMx2+HpEPk9UZqI+Sf?=
 =?us-ascii?Q?g5ChrqQO+jAGtTv0gRsiwpttVknKGKFdSGgfxDPpOtRmWA6RHLNQX+vvDPzj?=
 =?us-ascii?Q?QZHDDwmWvIiTVJpuLAPleH4/T/a1PNaWyUYa7iV2+Nb0Cspj59XpWF7zXrcv?=
 =?us-ascii?Q?bHJ+vkdkRzQTq1RwykgdT86eMVWUO7fkloE/1trCgbxZnNPpoqEIcJ5HmFv/?=
 =?us-ascii?Q?IUgYQDpX+wFaYQw/5aokqSjNTQDX01nR9L319lNlRGzgF+Aha6Ad6T2OGhbm?=
 =?us-ascii?Q?+Xxd1RLBfw3VFft48XLJ4JdaXLBJJBqT/KDir6CcoKe3sQo4x5un+ErLrseM?=
 =?us-ascii?Q?g6BRvwrzsJkiIWzX8gfJjNx6/JyEv2TpWwxWi/AkSlloG3zMxzUv1DL86WW0?=
 =?us-ascii?Q?wpoy4Y+B4EUpADH7pBPpFzgZYj6yt9IJbofa/LHhpuZD2i/z22AKYsefBboY?=
 =?us-ascii?Q?NS+9sKTuO84nHIlh1yvBK4RnaVdSjKLpSjyUa0pseaSB1PVIV4dW8XPTnVXX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52956a8b-e53c-484c-d89f-08db269a3277
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 03:46:31.8622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZhMxHCiQpk4ao9XaDz+Q2KOjvU5BPbe+lteGPONKT+tPAEukDZtT4U84sl7DYk1epLEaQ5eRoAcrRWzvmJHWdnomdK+UDGH8WwWCptfSE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4269
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_16,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=977
 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170020
X-Proofpoint-ORIG-GUID: WhvCwsb3FRHwyxYXFDP_JrfNgwT-K4G7
X-Proofpoint-GUID: WhvCwsb3FRHwyxYXFDP_JrfNgwT-K4G7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Krzysztof,

> The driver can be built on ACPI and its .of_match_table uses
> of_match_ptr(), thus annotate the actual table as maybe unused.

Applied #1-#3 to 6.4/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
