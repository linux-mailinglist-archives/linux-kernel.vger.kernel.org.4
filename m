Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B774E730CA3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 03:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236839AbjFOBcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 21:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236211AbjFOBcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 21:32:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0732125;
        Wed, 14 Jun 2023 18:32:11 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EK0BQO015413;
        Thu, 15 Jun 2023 01:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=AD5V3/tAb1vFAD5VwMEEcgbrDas9iHFdRWguyOp3Agw=;
 b=u9RCuFPzgK5TWbdYauZwZ2K7NdeMhVlJXLeueilIRlBa2dwdlAay3Zq5P9Kb+hBoNZ5K
 cGqxymggemVxyXYnCHwF0dFA7Se87SGB549hcXG6LMmw6zZAnmCoIHJQPid3YqEmWFIr
 CKX2t/OtRgQVLliyrhkzw9GnSZpwYoOkE+CpHuOMdU2PLmjRjKy4p0kGALYZlxPVX8wi
 uj5dw/hAVnP3EILxuedf45LesR3VH/g719PeR/lvhO5ey61Jo+VtCBDqv4sBgr+6s4Md
 MMO9hkA9P49KOlSJO8rU1RlZ4tf1Nlxm6fYVWxMPMhPzgr2M6J+x1c4PnGkyrDB6mQsu yg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h2aru32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 01:31:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35F0b87t008307;
        Thu, 15 Jun 2023 01:31:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fmck5mn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 01:31:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0if7zPB+il5ZtBjDM301EOAL0iKfbBANdBwS4wS3+xs3EAsii1UmJ9V21goTOZ/3Othbs9zI0OFl0ZXG3yboV0ICPetFXWjYWERBU2IpH+etc72r5I5ILiLtKYB+zTJ+t4mi9bv+5tU8hDU87SwX2sNkUBkuyM8ukHEkrSgdC1Djl9JJ981QLwmSW1d+20Zsb+r6sXpbthokK96xCgkgFnGlhWQQMDTudaAsVdaBhqcg70LILP1NfxhFx1n4VbF/gnO86c3giY+3YbpT8heBCyZ0lboxyeDyubWTXudWUarvkCgBpx5ueDpokW/gyP2KxnT5Eo2FS1p5NqcS8lVpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AD5V3/tAb1vFAD5VwMEEcgbrDas9iHFdRWguyOp3Agw=;
 b=fsk3sn7IKyAe46GXKfCOgax6WCZVzEVvmkSfHL28D7ooGqBHHdVXWEkX2QqTExglFBz2/pJeOvResynARRwjxyVoo2ct5aE8w81Kn9t9ujpY/AlBXwYfC2VPb14lLQyMRMP0QdEmCj2P5YeEOzf3tmGgXhx7fbrMasOqzXj0WKHnXQMkubx/Np4T/6SGAxP59ymv3P+THuNZDVnoCIDo31pegDn3sU9htCurBtUeL4K7IcBMrFDzUs8ajduFvXZJ92c8LvjrmzBJ1wIjuWFYdvXGO2a0FovexQdGS6pHXaY0EyrQl1SZOmXZ3/+uCLvc/zKIxBryA6K1QT6pRTuPNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AD5V3/tAb1vFAD5VwMEEcgbrDas9iHFdRWguyOp3Agw=;
 b=wB8Mr8xhE3Szi8Vpa0oowFA4ViOA2Xap3hysRmx6Ij3eLf6h5Z2Z+yB3DCk5z0xbs4pfPpCQpP9SlNb4ooff5/yG2wyAPXpXvHCDkxOGJuNqoYQR6ED0h0KrjXiSbcstxRNSUJTI9geh8LypdC3+IYo5OAK/suZNo4XehP/ReTY=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CO1PR10MB4580.namprd10.prod.outlook.com (2603:10b6:303:98::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 01:31:51 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0%7]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 01:31:51 +0000
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: ufs: samsung,exynos: drop unneeded quotes
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1wn05wlxg.fsf@ca-mkp.ca.oracle.com>
References: <20230609140651.64488-1-krzysztof.kozlowski@linaro.org>
Date:   Wed, 14 Jun 2023 21:31:49 -0400
In-Reply-To: <20230609140651.64488-1-krzysztof.kozlowski@linaro.org>
        (Krzysztof Kozlowski's message of "Fri, 9 Jun 2023 16:06:51 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0026.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::27) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CO1PR10MB4580:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fd0f1a8-3f80-4953-22ce-08db6d404b4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bnxd5rnm6+wF8ZljfbAvNvJdbr318yVLMdd6x1cohRGF6WHtr+SitHPGM7pApXtjtDv0Y42hg2c9qND+v/XaRwiIVCUEHV2pwpc/HTr2XVekMQs3nmKLtNqN7+EAd6PKu4O/zVdUXHbc4oCNfZWepJFEoqhrn0eyW/cX+75OcQlsfNINha6bARDM1NEa32VjgWIDC6yXynzFQFuQSXJzHVmYvPO2s+7H/5iIKs1P2FkFffj1I3GF0pHAMg22n7SnLJRWUzmZM/7VCrINh+LmOKxVNnZ7w13bAjaJw28TQ+UyFg/K8S/La6k/LQwomd43lX5fEP7Uwkrcv4lW7t7GZRcilxYctiQPtJJUOftpDYeC+t5Nf6nnTkguOdVcybjAmeTTfK+H6mSH8MCAQdQZU/SlySngWxgX93PnIGpl/cQnbE56t/RLo6+bVEENBP810Ph5R8eLVtUv6SQHul+7tzUwqkbxpkhXpaDEKHiVvxHnz+od6AZFtr2NoBRjfehnxHdnI4i7/QvkmazTIEzTFk60wmM4b4lc5rP+SvdGr+xiwapOqOXEpxGwD7DMSgva
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(376002)(39860400002)(366004)(451199021)(41300700001)(5660300002)(7416002)(8676002)(8936002)(2906002)(558084003)(86362001)(478600001)(186003)(6512007)(26005)(6506007)(36916002)(6486002)(38100700002)(316002)(66946007)(66556008)(6916009)(4326008)(66476007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qHori+3v+rEnKgW3bcIpTb4OlSl8r570DMJWZN7b2NYVIWIoKTAaPe5+JyxH?=
 =?us-ascii?Q?uc86qHT/1H293L4dvcVrYQlQ9Lc/P9Ip/JwZ722GACZVRdV3zXeY7VdH6Ler?=
 =?us-ascii?Q?T75R6V+WwUcANwV3k2WFejTltfXQZOmqv9lup+sHQglD5Jr5hSylYJtBQfKQ?=
 =?us-ascii?Q?HNCFsm6iTeFljAM10F0Z0nWHktE0Yxg4KKsz79V7sftZ9B8Yp3V54hXf1kPf?=
 =?us-ascii?Q?JLEncphzrBklLUo5YJ8jFYrwY6JNsQ/ZBf0HqvRdHvsT4PL4vS68qqr5EAsI?=
 =?us-ascii?Q?xTtZDdOsonG3Fq06nAdQ8KOmIQuW8R5q/t2T24KBV1rMkQs17/RblRJLuVFq?=
 =?us-ascii?Q?jcBWzdpLHySsrcG4bJcSCw4pnjIpcYKHTHj2nHi9Osnp/tcf1bhobuSQ+4qZ?=
 =?us-ascii?Q?s5nThH8z9BRdakqqDgO12PTJ92nInp69uO7IuRK+4Zn3EsMKGnta/o8fCmNg?=
 =?us-ascii?Q?q+97oAgppCnY7engYPh4URP7SJGs0bAAW0PVaR04tTi0ql/iJgfjxxGvKF8R?=
 =?us-ascii?Q?DcgVcZvdje1Fc2DtD2iU/ARQVNSfkJ0aB+mZRxOkTJYGeOMjdIFwreHb0+rT?=
 =?us-ascii?Q?Df/iWfj5qNtMHFR5Wzm+7f8lc5wCI00KE59Qwjc6ZUflbJIHwQEpqn/8dfYA?=
 =?us-ascii?Q?PRg4C+lYlIIkSqb0q4hF81YBKGXoCOFMJapbjRvlBCrLVZaXzaS+gaHOvzR4?=
 =?us-ascii?Q?fOvJA35jkWYQ89N1bm4k7cgP2BDI85EIVLfrQN06W1IqiUGxQDgsb9DXw1Ey?=
 =?us-ascii?Q?+ihcRrhS6QluXYcYBlSle+6fT1DTQ/yv7sv562bfA+cRZSYJXw+JY4sSnSBz?=
 =?us-ascii?Q?ISggCLik+0blFxsXk48Dc8yBsB5w4iyKgaAY0h44rY/YMKnxil7WXsXJWSBn?=
 =?us-ascii?Q?ixHZPUFECnCgkOTCUi4y1XGMz2EvXeNK8+f1w9jO2MHoHzdGovZ/8pVzxX+v?=
 =?us-ascii?Q?QZb0t8PuRvkASfO0dPwlv9zvH8fJm54EGBIZ7uopR8X+q6wbJ9XuBI444h28?=
 =?us-ascii?Q?CFJYKrzNMHGMDwdYfpmn0IxlyM1ZjeS3A+ndPR9+bYcoJ2MWhNxyorf6M+EV?=
 =?us-ascii?Q?UOfS9Jc7ikZbj8PfbRzgpdaaCHVcw/lY7cyBol1ZDGcHduGTS/Y/9uVvA9Xz?=
 =?us-ascii?Q?9Xl9SAjAg8AE7NZ9GzhWvNQmT91uZjNcv/suMf/wo61yOXz86TzAdfjEgBfm?=
 =?us-ascii?Q?lo3YnnY6Hk3TF77J0NOMt3lLxNTwgtJSCXDmHPjs5jLL7uVznyTq5wumwBh0?=
 =?us-ascii?Q?0fhF2287KRdtIKonRmyPDJRbJCaXLr+QfDNZwfZojlneQMtarVVCuYOzex2q?=
 =?us-ascii?Q?9gHMu5oubOLFhJyu5johcE0ogQHsHVICWP7cECSeC1vJY9JTei54kioGFH2v?=
 =?us-ascii?Q?HnnOi20V1Vl5eGpUG9bekQXtZTgd3aIBqARsAUzXK5OFBOoni2UzR+/gHwX0?=
 =?us-ascii?Q?J47156zTtkQSWaedZdxNH+qFVlPTR2Y0XjZh02Y14TkqiP/eibmRRq1AeRsv?=
 =?us-ascii?Q?s4d/Vd0IGM1h95QqtrHLj60+0ArzhJ12nLKFfGGdDNtWde+ukXL0LDeHVB9S?=
 =?us-ascii?Q?0V62TYM9VgZkwITjPCfvOAc4nnM/hc4993aASsvOlvSMocCf7pJ1dUlDHRCb?=
 =?us-ascii?Q?yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?mqt+j5N8skuKdfmQ+kWLmi13NAdxvdtmrUbeLWe9lZCNQk+9Es5k/DdbekvW?=
 =?us-ascii?Q?JrkYJ/gqL7LL1FN3tNJpbTcxkQ5CreRPBoe2fUx4c+LUmGx6snAvrMFlBlp8?=
 =?us-ascii?Q?XGM63FXPNDCxqKRqFLqEajMZ6BJKX5eEOApY1/pdq3DgwFUrT/IZ9Ch05J8I?=
 =?us-ascii?Q?iWpSKnOrt2fwy1Wv8GCJUO0cv0cbtGQxYntk4KUojtJefVytmB9+b5aR9ndC?=
 =?us-ascii?Q?R9F0WWNZXR2PMfh09PxuImKprp+22f2VsfQhIyl1Jt4XtAc7DsY2+wEEHbvT?=
 =?us-ascii?Q?eR2CSk7Mtt7hm5WR7ITFY04lk7WQF7SSGsMIBSed2RvalkOoCKbI21/VJfwu?=
 =?us-ascii?Q?kafN5GVRJuoyUY0Re+UYa2JsAoQCCYy/tjrwm6eEG+MKrfnBOxeiPV/4xxOB?=
 =?us-ascii?Q?6Xa6NtbaVOc24Emp6YSYut+lkY+SHxqhaKkemaYyRIzaOdLMdtynXrpysZYR?=
 =?us-ascii?Q?+QrDkYAhlMczLDk9eAED2cgGORsYP5Vdy2HbOr/2ZswaKwSlD/qdrYnzfTEv?=
 =?us-ascii?Q?CYdk7Jhqd7kcW6pj5K55QMLkSgOj/Y6y7i/p4Rwx/faXptBwoJhJBjBQq2Kl?=
 =?us-ascii?Q?i5VGk8Xbel74hHP673KmrvMm8OMsGb9FpFJB9+70hLKUj/+Nc0i8GaAf4S5T?=
 =?us-ascii?Q?FOWvqtbMfVkBVk2ZfbLSo3RobcJRB1RgBao0jHs6dF6BN1uZm33UsfvpIRZN?=
 =?us-ascii?Q?zOFs2k7IZRFOa0ybWsy4xHdbsDxnForUypjq9fyh518GB+6FkPyfF9/CUzUH?=
 =?us-ascii?Q?Pz79MWbh0FnacMCHfbo3ViPqzqgra2XOSYVl63esGgea+R72Fu/o/Dmwc4yC?=
 =?us-ascii?Q?evBaq5tB8MynphzKZ3CnhuDpSVF2uLCCRqt1T0qVptGteKcGue1zsdMttDSB?=
 =?us-ascii?Q?+SyjbdqWXWimDqNz6CiqnxBgLSO3VtECg0Y96oRxljFEaR7AzmDUrFEAJI6h?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd0f1a8-3f80-4953-22ce-08db6d404b4f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 01:31:51.3014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f9UIOzfdiaoXZgBQgUpxLFKP6cqIMVW8HGcX5/79SSImoBfOR+QrEMVgZk0JYW1uRCP0mfpII4hPsQenyRXnIGf7q+1B+nPKmcYEiZs0LPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4580
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_14,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=772 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150011
X-Proofpoint-ORIG-GUID: FTpC03XRE9jvr-mHUmYiz-jKL2QEUWJM
X-Proofpoint-GUID: FTpC03XRE9jvr-mHUmYiz-jKL2QEUWJM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Krzysztof,

> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
