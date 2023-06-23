Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD4373AE35
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 03:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjFWBHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 21:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjFWBHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 21:07:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1831419F;
        Thu, 22 Jun 2023 18:07:18 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35MIIr4v005874;
        Fri, 23 Jun 2023 01:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=CUlxICF+IxntiHbeDLoxeRMquchOpfNJ+2hm6NeP1A4=;
 b=mSvqN65sHNexV9PJlhYDFj7S2tjhcn+nOb0RRXyfaJ4Wj4Uq7F54GxojzhCB/Sz0ceLv
 cfp8RTQfvykJErSf2uMMjSn5ZgNQoHG+BgM9QTtyYIUV654vgSutmYr79CfkndP/NyAo
 IwaQhjdu0YL6T/nPhRUuTW6kLYy0BwnIN0Y/3m5PfiTmQxZ7UDT7/0rTA+jkF363io2/
 YZxA4tBbEWzg7Le2JjoYaYjLug0PeVgQ4wT/6kFsmXlUieV8QKAp8SkrjrHgXd8W+QxD
 N4KIysTXDTcC/PtaVSmawvytWbrG+mh2YzbcjiaSdncOriIYAlqcSt7BZtiFsYP9cd/S qg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94vcu6pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jun 2023 01:07:01 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35N0CCg1008354;
        Fri, 23 Jun 2023 01:07:00 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9398m9bd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jun 2023 01:07:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeLggIfrUtIXm7owXkyWMUOoAH3QwONl+EwTcW7a0EN83kJaY8cxF9h0aW9CwvsdjJoWL2N5LN1TQNtN9VfnJb5XaCwDG96CWiGY7vA9MLWs75OdT/m2keknmsbT+/ZaoYUWqUCRLHCQFz526mNOjK27wWDkJuo2d+zLaWv98suGWuJB8hMZ1fSars1nqXphraHLWKy3ggAv3pWhJHNTwADM15c07xPBK0ebzq26a0arQNCyPukSgm0XbonPvoI0FA41VOa7gT01ebSaAlOaX5jVh+R4xGTXgpjQ4GBu1Sf+ZVzjR8+d9/E+WemwPbdpkxCjzklFTfFGMdhLMLEfPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUlxICF+IxntiHbeDLoxeRMquchOpfNJ+2hm6NeP1A4=;
 b=adz6cGlbGjwOQUZPRiCw23Yyu1ZQC2humcWp5zBIEutdZirz/gvMS98ba7V6b721KMYzSI2uLMou5rdREbPAO5Yu4hh9kjljBBh11NFaVmcSokA28MazbV49ZkUY0qgIzezETE7k9DCJ5hAAPc/SRltE+gI+bv1oDTi/d3bP8XwEa+kUuu9I+8q0DTHg7sZxMW/nxCobUCr0ZR4XrJ/P5fyiLEeFBbF2drjeNV6b7NCGoPD6bJuW4ewURksYOiRAXSfWQJ2TV+zeW3DSTxd6elPO2vtyj4Pqh/H9cpxERXNn+uYeiY8bdbO6aluu93Fi2PPbSdraMA79FGxPLqvDqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUlxICF+IxntiHbeDLoxeRMquchOpfNJ+2hm6NeP1A4=;
 b=tqV47GhqgWjcrI2OKuqOkKpxYssJVEzWwZO8u8ZNzCgDx+fhGKcPwf230kpSptJovk14tR40e/1BOBx6MfBuj1HEojpiBXOHVCkOZa65HKP9v8dZFIcNNovNxNWeTlAWPSWYKmNKuXRzCPuT960a6GEFYidP0bl7DZ69iQA0j8U=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA1PR10MB5735.namprd10.prod.outlook.com (2603:10b6:806:23e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Fri, 23 Jun
 2023 01:06:57 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0%7]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 01:06:57 +0000
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH v7 1/3] dt-bindings: ufs: qcom: Add ICE phandle
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1wmzvov3n.fsf@ca-mkp.ca.oracle.com>
References: <20230408214041.533749-1-abel.vesa@linaro.org>
        <20230408214041.533749-2-abel.vesa@linaro.org>
        <4aadaf24-11f6-5cc1-4fbd-addbef4f891b@linaro.org>
        <yq1ilbgqoq6.fsf@ca-mkp.ca.oracle.com>
        <80ca0da4-5243-9771-0c4c-62b956e97b2f@linaro.org>
Date:   Thu, 22 Jun 2023 21:06:54 -0400
In-Reply-To: <80ca0da4-5243-9771-0c4c-62b956e97b2f@linaro.org> (Krzysztof
        Kozlowski's message of "Thu, 22 Jun 2023 08:07:51 +0200")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR14CA0053.namprd14.prod.outlook.com
 (2603:10b6:5:18f::30) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA1PR10MB5735:EE_
X-MS-Office365-Filtering-Correlation-Id: d475ee32-a396-498f-c873-08db73862409
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pGPs7+hF7XMwj1UJ6N5mTziPWvX5MMFQywiYzpQStkBNcbNws/E4AzbqwCTwplkzqd7xNp8ThSYf3MLsg43DxDuzIc96UYAWfOUIzT2RZacBQznK8juhCiwAqObgmoKXyuSZJ+CJNoXekrKK0CLN2uMZbZZZi2aTCbveXuK1q/VCTnn4WIFOnHi6GWVQ57g+6ThKJaaQRVIZ5vYc6np5Q1557aYBnO3RzoVvRPiDMAjeP0I/sl8SbmZRfoWlgu+/onVMcQpVm/BZGbHokxJWy+eS8etDOG26kMywZrbvv0qeaLgvGLAHlTxi5nSOGsW5Lz3/71ttZ4TQLMRG+vLaC6YhVKhw53+Bkvhr76OFmBpJLVjDYAitAd9WSM9nbDriBtkdYE6yNX29J37K7kgXF9joEdrcZJ5/rgmtNxYvLnbxSKqX2BQevraEDvvX4Klx/3GCSp5Vd7gpjxsGnH0PLT19mpivKv44UAcGIzCw4Mtiydv5inXHpKYbP15cxEMhZty1j0Jii2v0S7VM/UPsHwLIDPSn8MbMIQ9XfF2rW6Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(66476007)(66556008)(6916009)(4326008)(186003)(26005)(38100700002)(86362001)(6506007)(6512007)(36916002)(966005)(66946007)(6486002)(478600001)(6666004)(54906003)(2906002)(8936002)(8676002)(5660300002)(4744005)(7416002)(316002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GbX7C4TpkJpIFk38tIhq2C8OIRCgiv8RVdn8nJdda4KZO5UUgHAbHjn3/pQo?=
 =?us-ascii?Q?gHKdgfFHKK1CpwzMfxKfUHa5NAQUa4B/4LoL1WikVbzLsxUOCE2yg57LY6FI?=
 =?us-ascii?Q?AzvlDuJyKF04RgUplsQwIb5nWk4Toe8WMthJOatuixu9tA77b7gufRDbZe4+?=
 =?us-ascii?Q?Yp4eJDHHFPOOoE1HyARSJqHnKSzSrYItiUybBLjlYhVrYDwxTAUMIvl4CVBi?=
 =?us-ascii?Q?nraZmhewlhqtSMDJdBc2dKZunkvdjxhL7cMS6Nn0F12W2ShC1Du7qzDMijT+?=
 =?us-ascii?Q?QcetW+GUklHwzXPLGbJplU34Z/4hGfk3yWfLMZ8ltmjmgP97QvMYikfc9M7c?=
 =?us-ascii?Q?5hBPSFllPFBtf/Q2HlRApwQHiYwwN6UHLCx6iUgI31UGLN+vqxUbxFf8YACv?=
 =?us-ascii?Q?VUOOPb3u46FjbzpQtfXcZX/U5Yd433EXBBmAUAYxDce7cDJEUze34LqkE1uf?=
 =?us-ascii?Q?Yvap/Pf4Yfv17bbzN5aqHvKEjmUf0XcF7xqZDMVqsuY3OmbaAxz4ginWOhvX?=
 =?us-ascii?Q?tM1Lj02TpllF/eCcg/nuOKXE/HomJcgKGgzqy6pdOJxbzvHbcPbtWJBPOH6N?=
 =?us-ascii?Q?Vt/04O4v+z8EkoloivOaAGDHWuwSLRWA11yU5y2iBh8VuXxz0xat+m1kgC/f?=
 =?us-ascii?Q?3/E8OcBobwfKb9qOvbO8cx0Q2Ux0QmnUoRdU5tSeYW4WAd0r1qW4FOAxHjfm?=
 =?us-ascii?Q?1hqkQNL0YRzR+REtGO9Ug1oz+lbBkOZV0QP1m7WSeehvUnLktY/Fg/lM+MG9?=
 =?us-ascii?Q?8GMxd9QjruyTfqePZZKNpu8XlQRhnvNB23sMGSVQdcUnCsq5lLAe5yKQKWD7?=
 =?us-ascii?Q?8JFNHsNbRMRuhTQnaeeOyoJpylcTGgjiQ00BuNkTooOoXWGv4zMcuvgwjpBA?=
 =?us-ascii?Q?lbY+G5xty7qRwYtwMSz0dYYUbyfGbOdH0GGf9NcXzo2ytz2VUT0E90bWer5T?=
 =?us-ascii?Q?5IVEvMqQUjDVSX1T5TVRMkgL1xsE2sxMNNmXI/rifMH6EYnC5XMK85n8mB+J?=
 =?us-ascii?Q?YZJobUXvFC/iEYM49r8ocskftq5eZg/SJ4XkA7tIA6CcXcRwoBbS9Y5MMsw2?=
 =?us-ascii?Q?NwN5C7g1TUqifjsHGpJTK4/C9S1SwX4Vto9Y2lfTVBY59qz83Kxlv7AWPMxb?=
 =?us-ascii?Q?iRw6eReoDlzjpmQcQhCHaGNMb7bi8ExC81wLAtiZXLqAksLMvzxVmLhspeMt?=
 =?us-ascii?Q?sib0XT/0ZaajgWKe+kb6PIYWoPgOxK5LetLY2kHW5Vd0J5I6YSdeEMEBgVog?=
 =?us-ascii?Q?NYigAzvlSDp6xoRpnSl37fiPcmD6qngn5twlrYGXCJERm2SADybAjlFHHebL?=
 =?us-ascii?Q?DkGJcwz5mnt9T+oqmxJYAC8PAu3OY2glWOb6ektx4lVOq/KVFhrDmkDuT7Na?=
 =?us-ascii?Q?95B7PRK8VXMgpJARJECr4fT0NAmje4OqznMJH/nQOFSutgUplcAzThyFIKwt?=
 =?us-ascii?Q?jZlp87vaVNC23WAU5dWEvKDDVMyRM450XoXoigl+QjOE68wtoxzfqJBpZwzh?=
 =?us-ascii?Q?7/VAhFMwP93PpY45pcpPKwb2NOrX4RTJNRu6AxIko3lgsUOc9sNvSu94C/5s?=
 =?us-ascii?Q?nXBAlGgr0clhBupza5PyNNtku1ezPNuGsuJxmkw4jfbYXYTWcygt2h/hMXom?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?OpANrtIBENgVMB4WELYbM1TQUR0JgpuC2/Zwo/amcyC/1YNKKB89Ms9OAg5r?=
 =?us-ascii?Q?fvZZbcjcGX5sn04oWpmsmK9/DbtVqRxCclElrvhoYEvA4T1enrciEveUW3g8?=
 =?us-ascii?Q?RRHORnQ6/ScRXNVE4ogzKQbISq6zdVtQ9+83qDpi4dogVjq6utRRr5O0AYwg?=
 =?us-ascii?Q?jyvq4uQI60NxGPQl7bM9f6D7zuPvXwmBbWt2rnTOFwHN922Fh+ntKOEBFvCe?=
 =?us-ascii?Q?C+kLTePZZb4a4kihDkrhlq9uA4XWl7+P/cKguGNgybOAxC2wGFa0xBQdM2II?=
 =?us-ascii?Q?3ntIT5RkNlB/AEU31WbN4CsXnIljOHx3ncw6cHYHxJlRtGYhHzfuZDLR8TUM?=
 =?us-ascii?Q?92x3ZwYEV7S5MtlCSwZvfnP9bSHcc6r7PVXNMhHhiCrLJl+jcNXyAjohtG6N?=
 =?us-ascii?Q?6BrwdnJqQr6aqY1bTo1/AOwfjo6CI/2eAqYfdmm7PKoVOZ6/5uSJIx7DsUJl?=
 =?us-ascii?Q?9kVGNGY+aY7sYBJ/RfyWX3h7EnrTIT7kJA9ALREJ4AwTLXSUvXA4baFos6CC?=
 =?us-ascii?Q?vRsiuHG8W07EtS1NkIMD33AVICsls10Iz7RINWFR5COF/sjf9fRa6QzJdMs3?=
 =?us-ascii?Q?BbJcs1t78y0k2WNh+5TLsj/tUykM8aIxBs8nEQS4OhkZV8O9YKgKPyEHCpyw?=
 =?us-ascii?Q?VfFH2TtmjNxP72dW5u80fWJUne4t5AJY1jjcUNehUDW/xETTAqolCYpPHuTe?=
 =?us-ascii?Q?kX3bN1omZ2vxaYOWmzzlZhW3kAibm1USSZfcuTX7N6WJ49SKTzRBo3C0WZ6v?=
 =?us-ascii?Q?e58NIpL2+fCu3/wfh31AxymGXNXoWmcZrLYk7s3SzdyJlNjkOMHmN8EzkSz/?=
 =?us-ascii?Q?4jJAz4uRe9tB96CzRgPgGzgJ73IMobSmdclHJzzkjXT1UDilIhKgU+/GVmaC?=
 =?us-ascii?Q?aDi31E7z/wmAVJehey4bzPXrpQ2dMNeuhzfUsUpxeYJ7at9LzS0oN51kzgbz?=
 =?us-ascii?Q?fQc89hlq5+S9U69QpKsfzUX1x2X6aPy0SY+5ykVJC8GMkLY3NOFHfphhenBR?=
 =?us-ascii?Q?3X/66OZZFCeZieSYFpNnZaqy46wSSH3hXstYIaAUr0TqZPE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d475ee32-a396-498f-c873-08db73862409
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 01:06:57.1966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/dI/ZLpCTKH6V5xsQDQtWzhXDBBTkUyMorgkSGQ/g3JG3Fwsqd/e3BnQ3yayOhdCUOis+nGX+Wh54WjIdNUFqhrtWpBuUIlifSumJfNY8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5735
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_18,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=857 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230007
X-Proofpoint-GUID: mC94I4sgMSeiF-mOYwQEs9OilxNXtbTD
X-Proofpoint-ORIG-GUID: mC94I4sgMSeiF-mOYwQEs9OilxNXtbTD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Krzysztof!

> AFAIK, this was not applied. At least as of next 20210621 and I
> commented on this few days ago. Anything changed here?

It's definitely there in 20230621:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml?h=next-20230621

I merged the series on the 16th prior to you withdrawing your
Reviewed-by: tag. But let's just get the bindings fixed.

-- 
Martin K. Petersen	Oracle Linux Engineering
