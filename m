Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF76562D0A4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 02:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbiKQB3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 20:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbiKQB3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 20:29:30 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B63945A17;
        Wed, 16 Nov 2022 17:29:29 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AGMiDnI010256;
        Thu, 17 Nov 2022 01:28:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=euxkXEoRAY7xnDK5NayvCNU49ShH2JwVZkcet08Vaeo=;
 b=HT8gBU4X8l09tzG5dfmiJm1VxnMOTBa11Ke21sD+lEZM96KD3y3hIJwgnRJloK3bX3oQ
 1Ume67bb2YzN9qHENWBcMTf9DO/o/pSuVhV3b2TWBt1VAAtElznGG9600VtTLkA0vOsC
 LMRiWbHW0W1lOJP6VuBWV/NnyUd8uMnKZjTi07n1HZag1aETDlMbG6YnnOh0cfbYX0xq
 cRe43URU7iI7jGKG1t5PpOx+HMRDoRDXhd/TACKhP0W0h4i65/2ZKn2GXFUpNSm2fOX6
 kLF3ZcHaj5CnD4Z6OlHRhF5718e4Sf0VnlamQRpx5+s9yR4wZ3q+qy+oQVUhEH28XMxt lw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv8ykpmkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 01:28:43 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AH0II6W012415;
        Thu, 17 Nov 2022 01:28:05 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1xendfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 01:28:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QmRFF9gcb0CJsu71043OIoPVTcmgZ+LcIrZ9dMqldKnYGVT1hGL0uW6zcZNhWdYrq+13yjdeFg2PfhtIpo4zb894XpA6QjSAAV/8eWndiGRNYjHfALeNSqgD1LfX+uA/83BfMWYSoeWtTG7RoYxFrHAwVNjZHbao7HEw5EAVvAXPrhCaLAtMwsS3jupuDZkfRvEtaatOf8QMvXJrgfL9lbC4uXm9/ziic7XhUX5GtKcgZ3kOieLAmplLMB1diAdsDuDn8ztNgRqt1AV2nDX8RUtiEndEBPkwMtqsBnLySgK+vwcIjO1O59AJBwuKAS1x/7mW8T9cewkxlLLwu+KfLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euxkXEoRAY7xnDK5NayvCNU49ShH2JwVZkcet08Vaeo=;
 b=hnx8RH3bouK/IhTy+a4LFYvI8T5d8A+zneaNBawI7J76wyWBgluzv8aPnehiEiHnYgKEeC5D160qLldCVgcdUC8VwNAshInnFrVnM+cNr+Ejata5+OWiIVBMUWgpPLQMPB5e1opgsQe738c6+O7lzzkEvnJnYQ/5K1H48HnrEJfXSH5vgZi+3soZWK0G8th5AjCx57/4hyyiD2l771gJoXHHvbfNaFn9xOU+HZmVXafSS0am0XLycG29K88ouJVHPBIE9ciX/5LorueULjupi8zYPUBzFrc3KJcTPz6e4OiKUMgj6Rpjr1mvzk7APpK48XuEMOaD6KYFhjLxxPIm6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euxkXEoRAY7xnDK5NayvCNU49ShH2JwVZkcet08Vaeo=;
 b=KgsWEJgsWBnrh8OVd0YxYcyS7Gyklq4fq3hRTcu1TK0C80U+JliFMXenqG232wDwfMOeR9UabQedolddVUEhHFBxGSI4m4dBAGDf+0EG4vBrkTIchOkCfvbiTgN+DqlWIfZvorUvBd0i60JjVdwwpEeYFABdgNUDobJGT6eSt/U=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by CY5PR10MB5961.namprd10.prod.outlook.com (2603:10b6:930:2e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Thu, 17 Nov
 2022 01:28:03 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::8127:f9d4:2c92:c253]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::8127:f9d4:2c92:c253%7]) with mapi id 15.20.5813.014; Thu, 17 Nov 2022
 01:28:03 +0000
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>
Cc:     Nicolai Stange <nstange@suse.de>, Martin Doucha <mdoucha@suse.cz>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [PATCH] padata: Always leave BHs disabled when running ->parallel()
Date:   Wed, 16 Nov 2022 20:28:02 -0500
Message-Id: <20221117012802.62504-1-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:208:23a::25) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|CY5PR10MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cfd26bc-0150-45a1-4683-08dac83af8f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pu+6puaXzoDUjYtA85Cf8xKKYHCgRecR0lDQbtBnmWdiGlbwXjDoqkkO8utZQiHkVM41Odc2Y/pO1YGcfO35wTzqHjJu4SV5PMwLg1pHDO5M4XaZn4KODAxmhg43On+nV045u6Amk5V6+7tfHBxYzsNgfXnhuPfvUk672lC3AqHBIFf0+rhYYB6DhXdU2GdXiqMJqLu4i/lN+v8VRHOxaz752qygTYELcTVN4gFIoh3l/DBOJYiIHsW+TlnoPwte0TUsYYWC6RUgGZM78WGmawSg2WhmUDIFw0BcuTTJZd4yUOmkGXF4sH5R8QLOFkIEkiNSU8gyLCN38Ts85XbCJArd5gI0bobdcDLPjeI3zQGmeUck4mj6rL90opfRKtl8slXuYOChQTF11GszrSVgOUni2YZUz3U3OVz3AXfgHLFH+ZEOsd/0pM3FQaUTF1pguH1x6NvN94z9HVWiGc/E50TKniaFPto8izBPsbWqQRFNqETAvOxTggUjCA7Al6kDVqJT9ecUylV+sOT0MnNw4O5M89CV+UhxUo8OWLYIVq471kCf63pawNu9yobM3p5cAISGIAtyknUy0X1WiVtixvpGhAheQy7V2tEtAqjvMyws6FGMgAnazJDmqEk1iyNK/3fVflnitVP+qKBWrYnr3ygKA8EkgghwZxShiMLOKI8xjJII2LOdnMCNREspSLRj/WLTcbuMJA5dtbpynpJOIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199015)(6512007)(38100700002)(26005)(6506007)(1076003)(2616005)(186003)(83380400001)(5660300002)(2906002)(66476007)(6486002)(107886003)(8936002)(4326008)(54906003)(8676002)(66946007)(66556008)(41300700001)(316002)(478600001)(110136005)(103116003)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nAK5wwSvPJZ/ebFccB/dlFvPizF1UvQjskNv8p5q5wEB+ZET1kP60EozuvxV?=
 =?us-ascii?Q?tkEvwNP0aMjBDHcdtGb0khhhkryVGpi4mUQMdDSpaJFt+qdFUVstcFjgHSZQ?=
 =?us-ascii?Q?IkDy1lS/7Hp6JEHX8GrJjA99sEdm8l6JsQDn2t7CfzQx+bV6mUAWTHXxRIAk?=
 =?us-ascii?Q?Qs7qquQa4k4mpuyWoNt395SqR/WsCNRnwR/3HAQFYwkG0p3xsLhsW2qL7G0T?=
 =?us-ascii?Q?w6LnJ/wmhvlOf2IPYsfxD2LU3MFjHUhlmcKdP6R1jZ+r2hRXAElV8cIhUfG4?=
 =?us-ascii?Q?vGS22M+DenSTH6q78jrCCvXk2QeQg4yhL44mfhYvYkyBV0Ai2b6bmx6pkwb8?=
 =?us-ascii?Q?I85JTK7QgN/ANx0yedueGjv+q7mfe8r4tpNRjKp6AC4F97i2GIbAOaX9kO3t?=
 =?us-ascii?Q?ytYpIdpgePa9Ff8+Vl5maqh+EezgvSl+HOkKVS2JBHjzfz/ko84PARPZ1U5s?=
 =?us-ascii?Q?q6ndiXu2/IIB92dtmufgDrVZDefi1N4Fr6C59WE7fs1LdYRBeDLkTwG+I2eX?=
 =?us-ascii?Q?NMIRWmWYCzY39VRAhstAK0KIpXQduocFBSU3vsMFNNmHa/XpKhEaUii5p3tJ?=
 =?us-ascii?Q?sNj8CttQE8y/7USXtnd4CYy67QSurSvjdf/dvaO/HxE9UaoO3lD6jDY09MTG?=
 =?us-ascii?Q?LIhuaaj+0rAFj2QhPE2sfVAIscikCPHYh+kbFKiBVtKBf3EWzVkeBMKSfewy?=
 =?us-ascii?Q?WUhFCOBfbbRJuBBhoxlMfcperPPUCpUthi4O+jKBoGiXWnKwBUJ/quOJXaqY?=
 =?us-ascii?Q?pI8aM3fRM9xROrV6yUHEVuxMGTdFsUpHKioYUlbsyiAhcURVRnSQSeQT9+/8?=
 =?us-ascii?Q?EtWKCh2nb8vfJ57TT/z44S/Q5w99kRj34QqR85T0bGHoPcf5dho2kkRjCpiD?=
 =?us-ascii?Q?Lcrsbf7OoiCmXuHxq3C/yml36SuQwkIBKTtsvB6z1/B3oVqMba3xz5mfbtWP?=
 =?us-ascii?Q?RboVKn7vzOBMfH1uCUPN9dtVQSOjO45oVLwjiuruv22SnAuys0x0qK635bOI?=
 =?us-ascii?Q?RkPHvhu9y2iW4TBMD9McihNgBVHz1AO3JeFuw+CFsiUN4Fu0glYC796D0z4h?=
 =?us-ascii?Q?cGewAQ0lbwR/XyDhqIjJeau7SdqTFGk+CTTZeugfNRUkn+fnvmU3j2LrDtkU?=
 =?us-ascii?Q?wNkLShqyZmhZnYC96J8Oq2NHyEqZ3ymVZ32lMgdft0So27JthiDHOuW8bE6W?=
 =?us-ascii?Q?yemfiQ83etuGou+WOikoRhytKq5JqUqFV+dVNqBYEI3VH2S5QZmCg4w6dHDj?=
 =?us-ascii?Q?Jw0b4+bkH2nghFR0H5wAC0IDMvPS8h9Z2yuylG3aTJMGb8sob8zygITiJOoZ?=
 =?us-ascii?Q?2wZYPHv4hjhSRltqodjOfakdEMFgPE69W8V0SrLXJlZEClUAUps+wd6z/qSR?=
 =?us-ascii?Q?u8ENXsE1iB0cUzCYFoRh+j4CFAu+pgCfw66iYU2I50lbTc+XkTZKK2gNs6D5?=
 =?us-ascii?Q?xTl97Yg9p1rVAqApiLEAaB9pgqJNxc7P6illBozhzxRwknLuBvZSABMkRJwG?=
 =?us-ascii?Q?e9JKx37aXvKDNNwoV5AeL0Z3DaRlY1xgPBlARn1Sa8/v6cscgMAVDWUkH8hn?=
 =?us-ascii?Q?jxFkTtxKkmffWzn147v7xmqBfMirODPCKUy3FmBW/ZUOq6A9ykZO77KGGOHv?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?EnykmEwqnpN5Se7Rl+B6sax+tbsWBC1F1oJe4amjVL1RuODWONeKd5ic+u+i?=
 =?us-ascii?Q?Q3PMlAcg5ZQGpjd7TrgLKLc6bJeHcIWdCJ1GdApL8dknZBeNAeHqNygHp4He?=
 =?us-ascii?Q?WNt9wW2DzF0teH89uSzZOguBN9MkLkslBWRwcPPRUJeLDY5V749HCVSOI5Uf?=
 =?us-ascii?Q?uL8dpv3eKLvUsvDw+x9kFmDYoMRloamWch0E1qasDlS6NJJVT8wumSol1PIS?=
 =?us-ascii?Q?+gheSg6w1fTeMi8+YKOzXWkevAVvZMSwY4KtXeC+avUqDVTZzQaDqh3Yd01T?=
 =?us-ascii?Q?8rhUrpTyIV+5H9IH1eL18H/xNGeS6RsK7tybsxiSYej2yK8qQJT0jEtHatfw?=
 =?us-ascii?Q?nyuHJYARYgKz6CU1KiAL+hWORSKYY+UvUNilB4XvZYHzR4LFhlse+ex4/QYI?=
 =?us-ascii?Q?AZQLAmc3M3Jo7u2dY2iKCfKPD8Vh/MiNsrZdQMAfq7xRLz8//pe2GvzAT7KJ?=
 =?us-ascii?Q?YT9/44W0kO4eICJxF7cpqJpjucwu7Ts0902Lrp0pirEmmsiPNLsF2qzfLAoE?=
 =?us-ascii?Q?L/Q9+EimLNXNUtwH7HwAjKBrFzc77nENBdK4dqpVQxLmVSE6mrzdrPI+WzXv?=
 =?us-ascii?Q?+3roaIeyVr8bBvfo+V/szQoPAawiuTOnev7/IPxIqngemWl8JZHnt6tEmV+Y?=
 =?us-ascii?Q?b/TyXJr2iOvNlM35h6a/K6PEuYzLPs6Y8bEw+zv/hsxuteRjzUjQ8nopdB4M?=
 =?us-ascii?Q?pWhmBrXEurE6oxNKCInFplS0klUf8pxKcw/GBBiNRJ9+4+95kiDAovSpjovI?=
 =?us-ascii?Q?mBf3pqdN9TBLNU11snQa5aUls/4L+6wq9MmppR8UPvHE0UTu/DHBCPXwIQqc?=
 =?us-ascii?Q?jKzcFZUxFWBJ6NASYmDRdeR+8GPhbO9WhhGTf4C28f1zY34k24JKdry22VW+?=
 =?us-ascii?Q?QDj0q8vgGhxPs7J0c5GJWb3v9XevOUAKFi1Of6ch51QRX2sKjl9wJN6fthp5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cfd26bc-0150-45a1-4683-08dac83af8f9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 01:28:03.8184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0NEzSL7zUMVl9eMW5TOurovW5ZWYKDRNocGonDdYEoO3yuP2ZOsl9Ueq9Vd2DJQ/XwXt/BQ6NhVEh4dutQKrvNZ6GbAtJTQZ7xj5s7mrXss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5961
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_03,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170008
X-Proofpoint-GUID: Gj1vdzlpzAul4GiQV9G3nEIR1mkH0I_5
X-Proofpoint-ORIG-GUID: Gj1vdzlpzAul4GiQV9G3nEIR1mkH0I_5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A deadlock can happen when an overloaded system runs ->parallel() in the
context of the current task:

    padata_do_parallel
      ->parallel()
        pcrypt_aead_enc/dec
          padata_do_serial
            spin_lock(&reorder->lock) // BHs still enabled
              <interrupt>
                ...
                  __do_softirq
                    ...
                      padata_do_serial
                        spin_lock(&reorder->lock)

It's a bug for BHs to be on in _do_serial as Steffen points out, so
ensure they're off in the "current task" case like they are in
padata_parallel_worker to avoid this situation.

Reported-by: syzbot+bc05445bc14148d51915@syzkaller.appspotmail.com
Fixes: 4611ce224688 ("padata: allocate work structures for parallel jobs from a pool")
Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Acked-by: Steffen Klassert <steffen.klassert@secunet.com>
---

About the potential deadlock in padata_find_next(), I think this fix
covers us there since that function is only called from
padata_do_serial(), where BHs should now always be off, or
invoke_padata_reorder(), where BHs are off as well.  The _bh spinlock
variants in padata_reorder() seem redundant.

 kernel/padata.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/padata.c b/kernel/padata.c
index e5819bb8bd1d..97f51e0c1776 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -207,14 +207,16 @@ int padata_do_parallel(struct padata_shell *ps,
 	pw = padata_work_alloc();
 	spin_unlock(&padata_works_lock);
 
+	if (!pw) {
+		/* Maximum works limit exceeded, run in the current task. */
+		padata->parallel(padata);
+	}
+
 	rcu_read_unlock_bh();
 
 	if (pw) {
 		padata_work_init(pw, padata_parallel_worker, padata, 0);
 		queue_work(pinst->parallel_wq, &pw->pw_work);
-	} else {
-		/* Maximum works limit exceeded, run in the current task. */
-		padata->parallel(padata);
 	}
 
 	return 0;
-- 
2.38.1

