Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909995E7682
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 11:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiIWJKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 05:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiIWJKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:10:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F346110B04;
        Fri, 23 Sep 2022 02:10:20 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28N8v5lw022816;
        Fri, 23 Sep 2022 09:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=GYK2bn12mfaQBjpiGwqWSHr5s2MkVYYJlNvLQzwLDFU=;
 b=en0bxquHobdgZwmnQqNUR+Z/W6SkbY/kwOouBjb0I9expWrSRpcZldVGkhbuEIiMXznJ
 jzoCRVjrCBg8KnmuvwEchLjL188j1B4bwoS2h4+HCEMYmdxF67UTJvWMVvuUVTwZPVc8
 W1rZ/qD8xuRMLD9FuPXO0MXPxu+7S3yCAJbK8MN9LjYNrEVywiXXW18MfrDAKEIC+Wpr
 MVk3Qd0I2NtSNQUbZQpVnqFMzETrrU06DDeRd5PUM2AZcg/2gZx3yJm/F2/zDIKJ+K7m
 be6Pq9pxWYiS+kH4aigi68IXF4SbhlpHJX851mEU+dLjhngtbayzlOaALzt0z4Sqc4Qo Lw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn6strj8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Sep 2022 09:10:12 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28N6wNJG028999;
        Fri, 23 Sep 2022 09:10:10 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3d5hw6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Sep 2022 09:10:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQZ86B26vY+pBcck2dx946GJcAR3Wu0utmi2gWk2NciJ/JMxmxh6aY1avOfpfVC1S7ct0rY8TXztqhqHnHDzcqV+JGp6gp4Qjvy5kc+700uiUY47RSWLmUHDxeg6DsP6zZUQdhAf0qaYx5e7XGB7pMsLd+B1/X2xvogiJO+eE5Aw44/BXoswhNr9boM/WFGJ5Ytek4JmkvSR4YvSuxH+h4K9mglOvlST/GcioZdjwSfvHYaMtqx0gfOp45D9mEtv0oW0vOWSLUgBIB0zwaXPuRdL8SRuQvb5mFVr9FgiuHs7PuyAuzTwiL5eHhqQCs0oLlV0TYLnABvxBmxPMcyuEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYK2bn12mfaQBjpiGwqWSHr5s2MkVYYJlNvLQzwLDFU=;
 b=AoSfkU0o0snQY5lQjQVN5ZBBumWRtN0RlCzYilXLQx8+eLym2r/e7NhPE6PYhr9psKP++LyElUO+P9Uk2fsGGcNSzIUEfL0O5HkDcesi7MeWuE7aIvFOdrbuLH5C33Cz66ryyeDGDC9hCBtDFepy/cKtPyR49JNgifmKFn3Zyjnq3DkMvWxJDtcbMSch0GbSMbujEGLZZ7AVO/pFG6Jf/Bz0AnsEoLYLLFW8nWEWAlhDxmVSLX+MUlaskG5Q+JwyUUnhLO+uBujMG9AAog5dLQkRH1CU1FGudWw1ID7fLdTaGFLM81kETN2oye72JZwT9dRJDlSY73Fp4cd0fMx9sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYK2bn12mfaQBjpiGwqWSHr5s2MkVYYJlNvLQzwLDFU=;
 b=lv3ZuikvJfmITFRqkMtzQgfmcPCipeI4j0lXaZInERMHsjwGCzfUrpiUE8nKoeTl4BA02Mp5mWF42vq1AhwhWwHMaHdgbjN7uEFXCGtjnJFwHWwDOy+sR15s0QZbCK7fiOdPIXSNz0x4pXMyKmF0bDVI0CwBUHgMS3K1WyKEifs=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4691.namprd10.prod.outlook.com
 (2603:10b6:303:92::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 09:10:08 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5654.019; Fri, 23 Sep 2022
 09:10:08 +0000
Date:   Fri, 23 Sep 2022 12:09:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     ulf.hansson@linaro.org, cjb@laptop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH v2] mmc: wmt-sdmmc: Fix an error handling path in
 wmt_mci_probe()
Message-ID: <Yy134J0QUi1Z7BcZ@kadam>
References: <53fc6ffa5d1c428fefeae7d313cf4a669c3a1e98.1663873255.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53fc6ffa5d1c428fefeae7d313cf4a669c3a1e98.1663873255.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: MR2P264CA0127.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:30::19) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|CO1PR10MB4691:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c7f5320-a5ae-4fd5-a52c-08da9d436962
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: op0FpPNTgdg4QzpxbMH7suZ7cRHNQQiTxxCqDHJQiCKtcSyi4z1osCGW/YGb5oc6DJpsNdSHKnbBzRTJAIXQcjyjvjOkN3+SLyA0j/Xyir5Jtx+2OvKegmpeAW+MhT0xuoyx3vAWSe9cCqZuYG3dP+w8DSr9vfR/56xNVc/6CURDm0uGU9KS+/8J+DOT2CQx4I1fnUCr4joTQ18zS3IejJYbylW5A+HXh4yGwvd7rkmDwNcSuHjlMmasJqAcw57R0cW5PL7sXr86ACrCcfNjoenFd7SL/xs32iFAiSxJX1oAAb/CZ+VWskajsPHE+i9sIGaQrSox5dL9rdvjxtjxOdFi4KfzevOBo5kVvulvXBqOYuBs91lsov+2IgnV+kYJki5WW8SocAKu/+mfTQl7RKxmK/S6Nox342ea+qsJDeHVsOCeAXx6FCrQo6yBR3Uvv9Z+RDRU7MAmk4bI1SSvgRGv+PKt2N1ZjrjcxG+QtM/6A1Xey/lZoY0yOzaIfd9ORLmHM0178QL3KRKRjWK4fUjpGo1ZRbVFIT/jOhJGuDrWQjimWrXnWHAft1aM2lCdGv2Kt9Mg2nNMsP3jDbw8O/OxrR6Rdsr/vJxMPetuBK1+N0bRfii5UQKN/+rAj2goMWw2lBUWBDrPgk6/k8q78il1z2BkiuDZRaBsBpJ90kocS8/xzNF40hGO2lYTcztQSchmoiv6QqD5tX53mUtJapJImdrbX4N0cm1GLDdB3zon13PSBghKdQhISfxW0Wt2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(136003)(366004)(39860400002)(346002)(376002)(451199015)(5660300002)(4744005)(8936002)(44832011)(86362001)(6512007)(66946007)(66556008)(66476007)(8676002)(186003)(6506007)(9686003)(33716001)(4326008)(2906002)(6916009)(316002)(41300700001)(38100700002)(478600001)(6486002)(6666004)(26005)(504134003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DaeiaAMH8UxPatVTe9OyGwQgg5d8DfNvkAsy5RFaW7ThKMvZ4sAH/EjGHUHQ?=
 =?us-ascii?Q?SCpSaBH++QhKaAxTvwQurrMYSo8NELAVzT/Mtm8lvN1C+MSwhG+xZuxETaKH?=
 =?us-ascii?Q?4n0KU7QtrZc0Vx+kaE1EuOvIAM4u8qI1l9vPDYbng+pWGA5+hwcjGFznKpje?=
 =?us-ascii?Q?+9ZtH81I1UzIVdirJl3wwvDQvfRcGsoRTS79NxPrtqAzpJyzgD1oulpmj88M?=
 =?us-ascii?Q?xIU5bMflF6q2knOAXfTW1c4iH2w5ZPqYwXxzYDHTTYPRIXfTpwf8y2QWEZ2L?=
 =?us-ascii?Q?1ryk+pAa0vbDWCAhe+mn7fq5XYvpuGw+uBMnjGPyH/Uo0p9JCHNw8zcS+Jr6?=
 =?us-ascii?Q?f2xIZfDOddMnfB1Z4x9c9pK4yZfqjBJr+6U1Lv23vOvYzcSrxHB7RneG787r?=
 =?us-ascii?Q?WTfQ5eLtDfB1EJXmq4bs2oSb8dAG8jXi0Z/Dv4ViefIvbYhcCIjh/Zofstai?=
 =?us-ascii?Q?t/YAbelyoUH5g8fA9tbN6dRBgdsNw9SLsbe3KsiR4cAbk86dk/nY5HwJl9UJ?=
 =?us-ascii?Q?X1q95UbbSxoYzEsnMzAQ4CwPD/CFdVP1cW7OtDvv8fWBwt0l9QF4ZB4mk4ln?=
 =?us-ascii?Q?QabwyW/scyGxeF7oRQ7supFPjH+g1GlrC+r06+Zf1KRmwAjz75TYcZdYN4QF?=
 =?us-ascii?Q?M4PGXMBHurDBCieXkE8iRNTDgn8F+KZISa2P2FLa8t1WYqG4AGb3HS7nmuP9?=
 =?us-ascii?Q?CGP+MPbGdm3N8zNFTaWjWeBZ7JuO2hPh4pfbSw/33hx6cF8ea8G4VK35HqMu?=
 =?us-ascii?Q?tGqeiBxu+6vkgpP20dJyzvoAa2E807kKA7G2f9oJt3N7Rvm5SifAcTItyViV?=
 =?us-ascii?Q?omlU/BEKF3F69uvBFnxYW1w4lAFEec5wZVXKjFnDePcfEtVaUwiIRW5knLvu?=
 =?us-ascii?Q?dsjcIddWnfaGdNK4fe0aG0ZWPMPqtRHQLUaaCZepep/FM9N5u5j3ifn3Fo4y?=
 =?us-ascii?Q?9tAMjK/Mm/Dt3Wsvbfe1C2hnhe6bwmlEgMYGLPwFAOZoxK7/dpER9GOrBW7+?=
 =?us-ascii?Q?ZO2Kmw2MwDzjMxq+juFXkca92vnfqs8XI73DRSaVycVPnYcXlz7/ffEUYGC7?=
 =?us-ascii?Q?0+X6YtSFAm4V7R/1KiHug7LzJBHIZPc5SSrDm2ouvDJJnVGNW5ptC9kZNK+4?=
 =?us-ascii?Q?Pd2gBfVn5dYCnttyLVoJwg5OQA2WBYvSfB6hU+6hlbKNHlx9cQMHmnrJsy3Y?=
 =?us-ascii?Q?K/Vq0bzovVNxgtg2kSv+IMgwBYYU1rw++DvH2fflXpI/qu3CVLMUY0ViNZHT?=
 =?us-ascii?Q?0YwIRdxCuMW6I7Ky43BwJL7vo5S2Os8tSzuwE1FPXAOdGwerCjDeYqwIlFuB?=
 =?us-ascii?Q?LLgUIGrR+nrkq1nXDBrewi3H8qY9ihu+CiGaKDVuCz4oxwaPIcZPTyVLoPHO?=
 =?us-ascii?Q?Tp1aVaBS1acAY4oy5t+/GoFfTCLWXyhi/ncasS1IlnlgAtF/X4aqC5eZusfx?=
 =?us-ascii?Q?NXdiZDvVfnuxkvm+TNK7cL91AV+jhkWVQHyRZ3jSDvFI2z2eFZPTngvgvxn8?=
 =?us-ascii?Q?or93QXdRHprapfyijER6XBMlVXFNfgpSLA1wFIWxRRiF/IYm66sWJ38Eu1pn?=
 =?us-ascii?Q?+xYC69uPnxJAyBjCuEg8jWeCqC0g13v9DLLqIObx?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c7f5320-a5ae-4fd5-a52c-08da9d436962
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 09:10:08.4663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MMyVp6SG8BfuKQg6pCYAZ8k92EsKmVMmpNr9+HobqSMvlok2nON7nJ8MZs9x7auUDBnjPY5RHwu940qX8kLVRxmCqv3AlVgXOYjWLXlGs28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4691
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_02,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209230059
X-Proofpoint-GUID: 4qfd47YVdZZGfUh_xuHtxyMn_xYlvNgn
X-Proofpoint-ORIG-GUID: 4qfd47YVdZZGfUh_xuHtxyMn_xYlvNgn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 09:06:40PM +0200, Christophe JAILLET wrote:
> A dma_free_coherent() call is missing in the error handling path of the
> probe, as already done in the remove function.
> 
> Fixes: 3a96dff0f828 ("mmc: SD/MMC Host Controller for Wondermedia WM8505/WM8650")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Changes since v1:
>   * Add and use the (ugly named) 'fail5_and_a_half' label   [Dan Carpenter <dan.carpenter@oracle.com>]
> 

LOL.  This really made me laugh.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

