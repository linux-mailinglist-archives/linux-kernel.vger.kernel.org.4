Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3410F72D0CE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbjFLUla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbjFLUkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:40:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92DA1728
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:40:47 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKOQW1003980;
        Mon, 12 Jun 2023 20:40:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=n9fkLaYuOty+dIbsK0bmceZK6lnVKin+jtS1fPal57o=;
 b=l8/TrtRRb3BF3qCIj0LPmLOuuYyaks/RGqU3W564+g0JUDYa1W2tO+9laVfW+xG7cTjt
 4iI3RUY/VLkhRhzPk1F4QkOtv86X4RZJhKZBWEicAhxiNWINneHGSS+mHe5eyRe+eiGy
 Lmi8gRRdS4pZEIU1P9IdsOYXpmWZsrY70XXNHjIepSw5HrRrrfpSN7ZXtxLgyHsg3jBL
 Zma3+xKLLeo3F7IWH6q1lsWs/t5CaPFQqmwH/kxO7dMlQdc+nLM6OTYrpPK2gZleyi/G
 vGETpqGdGFRYggPs9HsvXDXcNkazd4t2Y4ckTQgeQrjUlTkdVYfQvjK+lBvnDBVXLXCD Ew== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fs1uxaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 20:40:32 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKTaW2021673;
        Mon, 12 Jun 2023 20:40:31 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm39bw6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 20:40:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Biva5kqmHDmfulmPhwEhudLNkIA3Sx9T3fNxePUj3H+sCjYdSeVwb+AlRnJf8lYQDkB8wU1l4nOiBfwrVOW6sRp4Qw7mR/erjBBkmDGjl/tq0oywm4zeQo5G2j/iI2AvhTg4Gc5uoOqZTegYeFIxtALopGxcIII03t/Js7hE6DInH2ANk6uuavkz/w+zjtOd9R4OI4HRTPpYfPbmJjKO9mNkEHu6b49A6bzzAKAXzwY+O/W7imMjSmGpuuPy+URwNMIXtZKiYJCSssXDb70nzGfXFJHJeERMFqAFvWF4fkkVnRMP4BQxO0L0dCyVeu6iJ0TQzB5iXOd372rNDasQuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9fkLaYuOty+dIbsK0bmceZK6lnVKin+jtS1fPal57o=;
 b=QDOPuC621uABdOXMTXU6G04prklZ1de6OQmCwucHpCwHtOau+qoLIaWWhrNZuv5G9/v9CBTvCLM82FdzHMCDap8YwqaKVQpy+17oNLvvHOBr+x9FcmUJT1FaTsgZh+mjnbLV0zsrlKFP5tW7gVUIgoXi6aVgprV12lsBFkcogIPSptBWtIzJuqNHwtOPaVGJ+p8bvtpvdCAd2ifzy3G4uJIdkS/5yZV3FXUCkP5lK5nku6hY89flF/+bGeEuNMjAbeqePUvqwNWQ/naT8SJSJKl/bPa5k2obHgE3jeh0Ful0bE2pWXRvN2Mvly9TSSewhhM6JgLrmGr1fsE6XRnQAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9fkLaYuOty+dIbsK0bmceZK6lnVKin+jtS1fPal57o=;
 b=XDhsDDVmDJiFxmdAFTpaIwhMHFKYTF+e3HR2shbWqoTA6Qa3CrGtvjuai3Zcf+nByl7yjb2TD1HZ4qnM+R8WfITAUxH/4Iy5l523loXbTORBtX0X6yAgxP6txKdrhxbpwqZFzR+WI+afP3G6DKXijTvkj/55w52FQWbgt76xKEA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB5868.namprd10.prod.outlook.com (2603:10b6:806:22b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 20:40:30 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6455.045; Mon, 12 Jun 2023
 20:40:30 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 12/16] maple_tree: Move mas_wr_end_piv() below mas_wr_extend_null()
Date:   Mon, 12 Jun 2023 16:39:49 -0400
Message-Id: <20230612203953.2093911-13-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
References: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0399.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::6) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA1PR10MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: c6bff715-1590-4ef9-c30d-08db6b85432f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S4Azg8zRXfu/PIrnPS+QbFRj9bC/7sPgv0vOVVSMqc6vpCiI3lJNnhUeAq6+062fM2Uqp2jKr3cMnkk+VzImODJkO7wvMuwPHPPaz+6+lS8uCxAGjA6Iijdzb1ODFUOMIQvbPLb8+WSEc7BMkRTDNTZU2EmuojPY1Ktfh4a6nShW/nc0LgR1oBmO0+YohKs8+2QsHquk1cB5MmOeI2GuN4QXQ333aSZgune08MyFl+gCaJQRTYnIQsy2OJTkL7AVdhEy4xyXA5Sg06zcdLBP6diMe48uLg/qnM90/SA7sxsrf19+oaUiThgov32ZlYclgexXvTNz6VAxDZ5ycWZWvSyLhKeN/YN6wPaCaRhQMmz6sHzxDM+VDf20GiuAvekKBXsOkzPpI1SZplg13UrnVTJb3nZ1BTLXMPi8af9Eko5mEo6T3d9M+e/YqFnnE/h/YoaSbKwvqNW/zahON2hnBS/Tftwlpt7SVUqu1SHfWXsF/Krg74V/PJB6fiMrhHxr0ZuzRjfp25gfQq2v8Dxi2qc5mCrWKVq+WJhF33b8SZAEteeY4UR1wZ4fotWu+IYj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199021)(8936002)(8676002)(5660300002)(4326008)(6916009)(66946007)(66476007)(66556008)(316002)(54906003)(2906002)(41300700001)(6666004)(478600001)(6486002)(6506007)(26005)(1076003)(107886003)(6512007)(83380400001)(186003)(36756003)(2616005)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?usWxw2IxcrfU1uvE/MbMXTIqYjHtPFi2xROnhDI83KMes8h5dPHPXIZZtyhR?=
 =?us-ascii?Q?kVuME2lj9nqkW3fdp8abD/qe5qemTk3hpI4Dpm/niHspO45Zfgr7yrITjqlU?=
 =?us-ascii?Q?H/T+LSddQOCaP/pMx1AaTx8lWhTLlRoGfa0cYCsUT54v/aJyuvTWaXywmVuh?=
 =?us-ascii?Q?40LPHc2jY8kLMWcZnr5L1sCiclKOLFW5XNQBhwA2iBYGA7IGDRrJL2Kc97Rd?=
 =?us-ascii?Q?1PT1AU7YDStkoDU1A3PR94q/ts3JFnk1jdcKKytM+VrnIqGSkvNl+Nbc5d2d?=
 =?us-ascii?Q?ybQF0N4ex6oNS1xez4cw4pcs6kNBgJkcsVCekLtK3jgs2EkRW57b8kcBftS/?=
 =?us-ascii?Q?PzHoqJkqYMAiO+3CsyB9O6PBmnrDiujzwZEsfDTodrkPeTQNRMlzfCovOirS?=
 =?us-ascii?Q?fVxKgBEzPAPoJs7nu2rWWIxMf0RdR/kArQC9O603mbv+7rD9DZz6ZJWdlt+/?=
 =?us-ascii?Q?4TbDsL3puYRE8fDGNcQsLTiN7wY6xAd1Q0/qBRIwmk47iyxJB7GW0WTDbqft?=
 =?us-ascii?Q?Q+RA5m0ZWIXQANeaAOCXXyz3mDmpHESofiO3AJSZnT7K5UN/QeyA0QTcEUxb?=
 =?us-ascii?Q?RHr3pFn7afTvUipSSvyVYHP8yFq4eVypwmkBGoLK79Ohlov3gGpJudmuUpp+?=
 =?us-ascii?Q?OxNzauLCr3ziBGC1hmV9KR2TMoYV2iEbbIoNsZnhUHPTgOXxd+pWt2AldDrp?=
 =?us-ascii?Q?Uqv+bpgz2GxWQirVuTWIYx11lc3CWXDWzcG9uqtvKC0O1sZVDe6O2zIBEyAw?=
 =?us-ascii?Q?x45GfEGKvH/Yb6ym5JJ407gkMliYT3bhFacsDZp7nYvSugXdlr53vKaFnsrB?=
 =?us-ascii?Q?py1i6mpfjZfEoZ18lZX1REIdaFn8gbHsOqDfAYeIwSt6ayiNEJX7EZ1T2JD8?=
 =?us-ascii?Q?GPVGkZoHAKj4H9jPvOmHbVQTS/tustPS5MEvnroNLODw3PVdAtMZeGuNhtku?=
 =?us-ascii?Q?gCu+r1M4rX8sysDIdK/vHCK6ThNMzIbBoah7+oYrU13Zr89OdQieotSQVDd8?=
 =?us-ascii?Q?JGWRuBKCnzhG4bVcX81Y4/fDa3XRMcuoL+5RMRlKDVBFjzEel6fOF0Ah2078?=
 =?us-ascii?Q?y4caymKpsVLmM2aItCIpoulrweXM5GjugrGfJ+peUgoGnlKsrkxOi0JNCW99?=
 =?us-ascii?Q?FD9xjpBf7id7/VcwVHnhR3kmPX6ldF9nr3mAxQx5Jaogjo6FlaFocnFG6t2l?=
 =?us-ascii?Q?gZgVpc7pCbuBu/Z9BBUiFA2tOOL+wdOiHpNNCv6RbLvx3ksWoEE+NyXzboZI?=
 =?us-ascii?Q?YeMS0a+liRawZeot45lPy2wXvyHcNdfFL/eJneKFCenmCsx2QyjpWqxusokM?=
 =?us-ascii?Q?gnJS8SVkiypFzwdzdf9oXTqDpMXTRCyvK5Kh9hKtTnVioYn9QMfyPfZ1MR5f?=
 =?us-ascii?Q?tQkSvITNFEi7WBeTYpLolK8et4KYFBS8tWdG9Bq+DTwX1GTKwR8zBQ4BdjOP?=
 =?us-ascii?Q?YQllLtbImA0YX8ruEMlHLPHmgMnT+4Je1Ppfpm5BT50Lqs3GeDDB4v9U9NSB?=
 =?us-ascii?Q?qiwEHXhAcg8+nA21OkORdhcj/JxTPvJBJx5CCgirVeThZ2SL08OlQZrwIziX?=
 =?us-ascii?Q?NPx8A71ZjSd6lSG1f/Ox2nnCLMogxWwJYVIBltu+T5pmHfLM/JH8mKyD26h+?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?wV3+jlgnum1LrCKv0q7WDVrZgsIwm3lFLGaHUyhZAaT6ajzSvO9jUey5Qauw?=
 =?us-ascii?Q?u/ZlrpNjwKh6q4imbSqyjd5CqnojBrum31cELcN/mmIigiUXWeroOUw1t46L?=
 =?us-ascii?Q?GyJA5nWjv8K0ybUNJ7P6OmCij2kFZ0goQFDoWq+a7VIUyJxKSJv7CgwiYQEI?=
 =?us-ascii?Q?2wR5cyN9ayP5LbOB/hQsZajC1pCaETzQru7Zm7TQMAc8+HC0TYOrgER/wvXB?=
 =?us-ascii?Q?iNZemJhxVLrzXgvrHulB5qf3R+BFQCPA68BKnnVf6zCK5p5LgasyrdDm7R9t?=
 =?us-ascii?Q?LB8u4HfRcT8B4+8hDMNIuS9510RQW0HxTjnSUlKortk38zHQLWP26A2nl6Rx?=
 =?us-ascii?Q?KAufNAzHaYBJEMMumacIiej/t4bUsNLlkOnndF60NLkKftVsd9MNc/fnrpLv?=
 =?us-ascii?Q?ctfkVhQRVMbXkGc8Fe+r+nf6VoRgwwTASJ1GdKjTVs+XivjgJFzzqYWxa6WL?=
 =?us-ascii?Q?zfeXX8dyct8G+VTI0yvjUBARH8poKdpSdDaxSvkQ7u/8IziPl72neipmUP+v?=
 =?us-ascii?Q?lhUBJLCKR2lQ/Hlfe4bbH+SS4+EgMcUEc9UWI9oHSs0WkGlXMs7aRIFjrLxw?=
 =?us-ascii?Q?sboaQHWoYnP4FXHfIIo/Q2+N8hnKstL0CiRQC4lLj3acHAF73F2HW+Eh9j18?=
 =?us-ascii?Q?oa2WqQMRRHAVYer10jCOPKMgI3xad+NL5Lk57qJvK/n3/lG8fhul2M73Zew0?=
 =?us-ascii?Q?SPpVXnWRAmfW5FTU7TDC76cqdWutAP4AQ1YQvaOxul3aNQlO51TMQRCh6UKO?=
 =?us-ascii?Q?CMq2xPbTLIsi8sQU7DoZVBNypBCgWlgF+rkJR5eEak1HUPOB21PI/yzf04bD?=
 =?us-ascii?Q?is3UPSKVh/vpy8/G00XxcIWJEvNhpOtpdlJCnTIM0IwzJXMnyTYUFE+Z8Sud?=
 =?us-ascii?Q?XlSwd/yVzD6Sa5POW51ladf7mHNC6kyQ0B54mBvTdSQnvUwWYCnms8H5tE6T?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6bff715-1590-4ef9-c30d-08db6b85432f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 20:40:30.5932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQFbMsgksgOUf1JYIbjWwi+WRpUwRYR6ST9WO393gcvd78A0wTelpsRH4wsiFOFzhndbAqP6TxZSkvRVasip9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5868
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_16,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306120176
X-Proofpoint-GUID: ijbDhC1EBN1bpxeSwa9t00WFUerEOBbw
X-Proofpoint-ORIG-GUID: ijbDhC1EBN1bpxeSwa9t00WFUerEOBbw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Relocate it and call mas_wr_extend_null() from within mas_wr_end_piv().
Extending the NULL may affect the end pivot value so call
mas_wr_endtend_null() from within mas_wr_end_piv() to keep it all
together.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index fa51abaab09b..048d6413a114 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4197,18 +4197,6 @@ static inline bool mas_wr_slot_store(struct ma_wr_state *wr_mas)
 	return true;
 }
 
-static inline void mas_wr_end_piv(struct ma_wr_state *wr_mas)
-{
-	while ((wr_mas->offset_end < wr_mas->node_end) &&
-	       (wr_mas->mas->last > wr_mas->pivots[wr_mas->offset_end]))
-		wr_mas->offset_end++;
-
-	if (wr_mas->offset_end < wr_mas->node_end)
-		wr_mas->end_piv = wr_mas->pivots[wr_mas->offset_end];
-	else
-		wr_mas->end_piv = wr_mas->mas->max;
-}
-
 static inline void mas_wr_extend_null(struct ma_wr_state *wr_mas)
 {
 	struct ma_state *mas = wr_mas->mas;
@@ -4245,6 +4233,21 @@ static inline void mas_wr_extend_null(struct ma_wr_state *wr_mas)
 	}
 }
 
+static inline void mas_wr_end_piv(struct ma_wr_state *wr_mas)
+{
+	while ((wr_mas->offset_end < wr_mas->node_end) &&
+	       (wr_mas->mas->last > wr_mas->pivots[wr_mas->offset_end]))
+		wr_mas->offset_end++;
+
+	if (wr_mas->offset_end < wr_mas->node_end)
+		wr_mas->end_piv = wr_mas->pivots[wr_mas->offset_end];
+	else
+		wr_mas->end_piv = wr_mas->mas->max;
+
+	if (!wr_mas->entry)
+		mas_wr_extend_null(wr_mas);
+}
+
 static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
 {
 	struct ma_state *mas = wr_mas->mas;
@@ -4377,10 +4380,6 @@ static inline void *mas_wr_store_entry(struct ma_wr_state *wr_mas)
 
 	/* At this point, we are at the leaf node that needs to be altered. */
 	mas_wr_end_piv(wr_mas);
-
-	if (!wr_mas->entry)
-		mas_wr_extend_null(wr_mas);
-
 	/* New root for a single pointer */
 	if (unlikely(!mas->index && mas->last == ULONG_MAX)) {
 		mas_new_root(mas, wr_mas->entry);
-- 
2.39.2

