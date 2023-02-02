Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE2D688AC1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 00:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbjBBX0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 18:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbjBBXZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:25:46 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E917B6601F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 15:25:42 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312IDtgH023725;
        Thu, 2 Feb 2023 23:25:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=sFqxWoDZW/mg2N6Jmmdjm0YHRP1aB5VdFZshq+zxhYM=;
 b=ZUnbkfZKIYP993CAXuLAotOx7gN44U1sE7FDcikatY+NJbYf6ijagqTXUy+6vgAyYUTj
 ddiCydME2zzPOaNdPc7i6OM1RAuq8VEgtouyRVenxWH+aUfp7v7MYovAzS2m71zgk7XN
 EJHFMiVdGDx7HGg4i/Z6PjRduILfop8R74OlHck4fkYUMffqkHdu/NwZW1VclSQGxMyJ
 FiAmO79JUJRZRHiZozLZ3Qipkma2CCG76KqbDlcSOpnY92YnpmOYt1aEhIZuhTqAKaq8
 Lv60lJfpar+CpCWqZw8WFfp7GlElE9S6noJL2uv9D3Se1kev574WjG3Su4lOoqFg2C0c GA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfq28v5vu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Feb 2023 23:25:30 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 312LFS8g005986;
        Thu, 2 Feb 2023 23:25:29 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct59rb6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Feb 2023 23:25:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TaicNHN1TbLD/YTrHJ4SszsM672doTanE+7xexHD4arEA4XLbYQt+DWWeQ9S05uKW0kQAB0Fj81esebDxdf1te4l8no7CchRWS9esvIBaRuq3Goe+yyz9BDZ9ha0WOppXS3UjpjfajX2AcwRBYuCFgLCRrVD8PMNa/lcgojVMVba1ioNnXTnc1CoKJqHL4RYCrrn01EvCFxdfU1YjaiOhzhcqUDwGaewdXiM7TnN0cGutIAu56pUBx6PwlFBjK2n4ytp5AFzQrMJpapd3EmIDNfYErK7tZjj9mWkSwZ0tEvN1NADeCA+bMEqMJYWV9+TdU6UgxXcEf9F6pf/Daw67Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFqxWoDZW/mg2N6Jmmdjm0YHRP1aB5VdFZshq+zxhYM=;
 b=bjvc/1gqCtB+GgE/sLZbQEW3i0PlM7rO61yXe7hBJH+rlKmMjF1kvf8sUaVdLGfcaam9AnpuaqEYpEBGYyEmPfjRaao0tLxFD223dFuNXJkBSVsP67jKqPztKkrkdZ8HvstG3+4a/pcZsphrIn4qSxa3nNw2Uko5OKudfW9aYeufTwq7LGfJ5PV/vgady5clmpd6fM+3ssBM2qxWicp7HNcaoHdJ+TBkpq8oEHnzR2AHZwMiczPtOFdQ0pAlb1xNK4kbs+B4YvkYgThP0vi+BuJoy80BzZLIO6dp3mvfnzMs/Tfu4EafIxHTFDkYN+UiP1sDpF1cj+NietU53KAq+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFqxWoDZW/mg2N6Jmmdjm0YHRP1aB5VdFZshq+zxhYM=;
 b=qwaLa8c1+MQHJQm6IJU12ngMRMieaDRscpkMFacTTbHGc/Umg5eRaum3bUeb3hfDOPMIVeigsTUfDJdrkAxbzUFDaJb2sGt8Ue5yaM75tGRvRTa29el65qEi4m1fcBe/PVyGRZCKHn/VWisAodSub0ICOlFD8MwVjwm2gR8EQOA=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 PH0PR10MB4536.namprd10.prod.outlook.com (2603:10b6:510:40::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.25; Thu, 2 Feb 2023 23:25:27 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f%5]) with mapi id 15.20.6086.008; Thu, 2 Feb 2023
 23:25:27 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, torvalds@linux-foundation.org,
        konrad.wilk@oracle.com, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v11 3/8] fork: add USER_WORKER flag to not dup/clone files
Date:   Thu,  2 Feb 2023 17:25:12 -0600
Message-Id: <20230202232517.8695-4-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230202232517.8695-1-michael.christie@oracle.com>
References: <20230202232517.8695-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0285.namprd03.prod.outlook.com
 (2603:10b6:610:e6::20) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|PH0PR10MB4536:EE_
X-MS-Office365-Filtering-Correlation-Id: 66a94706-aebd-4179-bf9b-08db0574c451
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WxDXDtytV1aHaL1GeG8qvF37PdEXp4QQxBAf914QzPev6aDiEKJf5WRY/n1i+BDLxHbas8hHvhsMaCqEg0iwt7LZKaZOoBg/US0I9dkLzl+wL3fdymkzCVP43MPWSVYbUwxjSy1b4KYvlFEurBqbLqUfg67qAHorbRTweipmG4aZhsGxWY485K0I56nSLM2rll96LaxOnsA71wANJ7Oo9auDZ9H/o2TtE1UI7WXDn+kAkCEY8VovqGAFS+EXs4KCGofcMTV/kE1D9OIw1FNATSR2iRDY9RGTDy6laDIv+5dDsCtJ3FFYrIyio1+ULOpBD0y5YYDtExyiXeHL1UpOkwJcxGydyuF6L25VWs4LYIt639ccR6Faa6FuWR91+bDeixHs6AebmVJ+p2k+mM5w01+MbDp7Zged6ZFALNeIy+aMlJZ5rMrwVnQApDuootkYgMV4ONnk3QMpUsjAjMLMLT91P8N5mPNDJMPuUcdy+qiGx8TnwfFgyBAbKy9abuLbE82rePJ5kteFwsdKnFNSiunMV1FA0Ff4Jyq05uHLP+pl/v7wWdGBIUDfcgHFDfbYCU2Kv9tzvq3VleMVDwDZnI4u6kBFRrRELK8vaBH7HZM5/2RaA8H/QBkqRAWu0GKdY7y6WGYDrM9YdiECXATuvNL3KX6NtfETX7mDQlbN+nwPEsv8qcxQADUvLMyXQcG9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199018)(316002)(83380400001)(6666004)(54906003)(2616005)(36756003)(2906002)(66476007)(38100700002)(186003)(6506007)(66946007)(66556008)(26005)(1076003)(6512007)(6486002)(8676002)(478600001)(7416002)(41300700001)(86362001)(4326008)(921005)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4hE4RgG/rRhhJ4YrbWLgJV2DwCxrT5INnhKjvHurzMwWkLXZnQVFc/ynbsVx?=
 =?us-ascii?Q?Gfprhc1/qOt8TbwarZrteNgVQgpejS2taA6qbKEtJbLniDJPyKvsCHEveS5B?=
 =?us-ascii?Q?SELy++FP8aEi2xZAKd5Vxl1sENDHVWrr74JCb4/ItuLMNBml4k52Q3dnkG+Z?=
 =?us-ascii?Q?Vp7Fw3E0Kf+/l257VJ/AXX+d1X0mnj3UTcFXgPENPBqCtpDO8k2jVuzPoymb?=
 =?us-ascii?Q?wEr6F5Pq2YX5XSOX/vhU77ruqeboEoPlI034hky8ho8f3ugWJ9elqG3trdeg?=
 =?us-ascii?Q?Ir+U34J5m4m8OQ17R/T8N6X/8WVyzVnqOcVQu9bsZKrrOZjAo6XqFZ3CHx1r?=
 =?us-ascii?Q?pAujCFtVcmPRgTdHeX9OwF5QdZZlSgN2FM1B7HBMnls+wjlLC0Vh7j28WY0p?=
 =?us-ascii?Q?avSo4UQknLPcygzaq/BDp5O52HzYNNDVUqSMMBLhWfjIH1zdz3lHJTxP2Ce5?=
 =?us-ascii?Q?HjfTjczyFL7dHmJL7SprDUne7RAE69EsL8vu6Xq0SQ8SEoi1j/D3dH9qlj/c?=
 =?us-ascii?Q?MtPX7yKjH1kPxYC21eHjXp49aOjBW+IfUhhl4ZCni0zl1Jxgi3rIZKXkjn4t?=
 =?us-ascii?Q?XxYG62AmUyA/xTnFcqvov6iD4anCI1KWl3PyKgUsJGuNsiS+HZuzRnJN3vqd?=
 =?us-ascii?Q?EnOWgHGLfadRC+YtRgtpYGcRef8gKGEhiLmZWstFZLcoRpZ2sr+G5HPnDk/8?=
 =?us-ascii?Q?lDf9mySJC5/XEuEaZRgaIzD/L+ilw+VhilzX74x3bXeNEuHWOEEXlVNplNNf?=
 =?us-ascii?Q?ucTLic5d4sXMmrk/fLdp5MLh0dkEPx123sqKjUJbGMAnMunyw3eXsPIYUZac?=
 =?us-ascii?Q?JvRPry8tJjg6ZozVdGMHR7ch26X8zfnih2WcT8WO8wdnOdxbX/b0xba6lgfD?=
 =?us-ascii?Q?YO/bsvWw7Gsw9g7v6HkKr8tV4JQxRW28o61alBANo4qvA1ct/ZQUjVBC+m0g?=
 =?us-ascii?Q?zNvaVnLuYnnolvyZVG6hZFmupF9NDOxhSwsv2SOnenvi3zL+tMOJukrUa0+s?=
 =?us-ascii?Q?BqtVm0yjYYyzw/IE5n6r4GGcYsAICcMOc6Qzs4P2Av129405xUIIVePHy93p?=
 =?us-ascii?Q?VlnCuBfV46EKOwQSe+ppcpJbBg64zcWDoEsmDYQJsZINCA8IqkTUmB24rfBW?=
 =?us-ascii?Q?al5IKHOhFewoF7nZ6+El/x3GjNthe+0+MSxDuZ9+otrXnXQdgbykBqxUutY1?=
 =?us-ascii?Q?bB6HkiN31k1rs1rBuE/TZEc+dsaFVGGLziSUkWGOeKWWAaunFwP6pXTrwQ5W?=
 =?us-ascii?Q?x+cZtBY0VqMbLbgY6Q8YE4TGaxW5m2EPx7NO0KlKLsUSQsZsUWLkYnn/Cvu1?=
 =?us-ascii?Q?BBs1OpOLNpnhpWdFwQke1hg1XBk/PMGSNCJwZUfcbCDf9WEQKz/05FZyNbJU?=
 =?us-ascii?Q?BWHnvODuEuwZvJoQXw2lMWnnKSt+Brt1NC2QZ08NaQZeJuQoaDkTL9SZ0b7d?=
 =?us-ascii?Q?RF4Kri8JMst6lp7zUh2z9Bnqa+HSgJ+5qqgySpALSszcrKKSIRnkjg5pvEpo?=
 =?us-ascii?Q?7BmbzpB+OofObBZ9erlIhhcBQ8E+NNx3doLVVOURQs5ciOzLIlrQv3yCXygZ?=
 =?us-ascii?Q?1gR4tFfQ1GnSPgqOFQ18TNMA52uTLcwD5RuuY8wPBexxEKH+0BhDJz4lPb+k?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?GZ2hvMsBeh5klrRMUxySMBMYcdgsDVwelbLUTb9McunURlPiOC5bAGvyBPWZ?=
 =?us-ascii?Q?cbBvZCRgmmpSpj9KQ6FtCLRh8j97Z0ro+nb8BoYvzgE+F7m0idT7fhypASPI?=
 =?us-ascii?Q?F/0MLG2V21nRR1fH8VBu8Je+T9WLWZV6pzPhH8vWI0QZi92p2W5RSXDVNg00?=
 =?us-ascii?Q?dwI7iHgJFr02Hemc7eujWZWCTbVwNgGZKiTabPDSfA82tb2HBEY1Ea/xoZfr?=
 =?us-ascii?Q?mtQIVefyWwv1iyHq2vhJZhon/+qNkdP5ObVsVf5nDh+NYtuPTmPeNJJDLePO?=
 =?us-ascii?Q?R7uGc/XK81XqGHRbvmk0tA1UVAr2qWGKMj0MnLTfGOocCspbVlZYypholwRz?=
 =?us-ascii?Q?uBvFAfuwllT7TG0HOEsBap2L90QAdDikn7DgqvIDg8BLoBcvdSyZZMauZUVB?=
 =?us-ascii?Q?anDEBmdFfA0cSQ73P5tg4Q4FogUaqZgT6kmR735n9cEWmg7FJcXTEYRY55EE?=
 =?us-ascii?Q?85WedLCzRxp18PU/Rb+ZYWLgqVMICxb20XPkcT4EJSHHlZAJeaX1A3iahLlC?=
 =?us-ascii?Q?4BjnQ/RqYcM1Bzcgii/NtZzwxaX/VXtpcFEi8CARHtyaNvk1ccEoOdWu7wYn?=
 =?us-ascii?Q?R6o4vSVg0sKgZfoQORRzMLut05oEm2uOPNoOEtaukSgenxbvZ7KGJvToi01g?=
 =?us-ascii?Q?uLEH4VQxRasOUarP63aLX+Ko6dE7/BJjV7VNNqp7XVcroQ1VUWQ1dHNuL/Z9?=
 =?us-ascii?Q?JwPU2P5VZ9VZZ64UYMBAHV5f6tuw6AVbhdc4Dgxyd3pXGVvub66t4RjcsYuf?=
 =?us-ascii?Q?QBMy40B3zuKDa4DBUxSQ0+SdGp1UqnFPg2ZOycVhI2sjhRwvtdxBTn29wFXs?=
 =?us-ascii?Q?ObsiWvpSa4LLRRCsAXEuXk9SPNtAKIwinl4Oy/aBDAuEkHbOeHV1bBtc2D06?=
 =?us-ascii?Q?5pEfdqyyd0XP9uPUE8378vwKFDP+mCFf3ifFjS5QjBgzGyx0mQXdjovsdcHA?=
 =?us-ascii?Q?GFP/rnJgMkXtpxtwdC1mnHNX76KBftOMWKPSYuMIANE0K9oJcsVLgghfHS8d?=
 =?us-ascii?Q?HJu9XCyfS/d0waZrMBireedmBDrR3EIuzkdwSnqeFeGmsc8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a94706-aebd-4179-bf9b-08db0574c451
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 23:25:27.2500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bSkvBy7SA6bxEOsO+0r/hKqPvpfS90gSUm5k9u3n7PrsmIgMGI0Eyp85E6XdGvmaBZQmgvaKV7BiDiozPSodxaZu08dLqsBBq8ZOkNhcNHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4536
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_14,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=992 adultscore=0
 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020207
X-Proofpoint-GUID: M_sWB8op24b0vVimBPAZQmsCnWUG9IFM
X-Proofpoint-ORIG-GUID: M_sWB8op24b0vVimBPAZQmsCnWUG9IFM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each vhost device gets a thread that is used to perform IO and management
operations. Instead of a thread that is accessing a device, the thread is
part of the device, so when it creates a thread using a helper based on
copy_process we can't dup or clone the parent's files/FDS because it
would do an extra increment on ourself.

Later, when we do:

Qemu process exits:
        do_exit -> exit_files -> put_files_struct -> close_files

we would leak the device's resources because of that extra refcount
on the fd or file_struct.

This patch adds a no_files option so these worker threads can prevent
taking an extra refcount on themselves.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Acked-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/sched/task.h |  1 +
 kernel/fork.c              | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index dfc585e0373c..18e614591c24 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -20,6 +20,7 @@ struct css_set;
 
 #define USER_WORKER		BIT(0)
 #define USER_WORKER_IO		BIT(1)
+#define USER_WORKER_NO_FILES	BIT(2)
 
 struct kernel_clone_args {
 	u64 flags;
diff --git a/kernel/fork.c b/kernel/fork.c
index 77d2c527e917..bb98b48bc35c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1624,7 +1624,8 @@ static int copy_fs(unsigned long clone_flags, struct task_struct *tsk)
 	return 0;
 }
 
-static int copy_files(unsigned long clone_flags, struct task_struct *tsk)
+static int copy_files(unsigned long clone_flags, struct task_struct *tsk,
+		      int no_files)
 {
 	struct files_struct *oldf, *newf;
 	int error = 0;
@@ -1636,6 +1637,11 @@ static int copy_files(unsigned long clone_flags, struct task_struct *tsk)
 	if (!oldf)
 		goto out;
 
+	if (no_files) {
+		tsk->files = NULL;
+		goto out;
+	}
+
 	if (clone_flags & CLONE_FILES) {
 		atomic_inc(&oldf->count);
 		goto out;
@@ -2255,7 +2261,8 @@ static __latent_entropy struct task_struct *copy_process(
 	retval = copy_semundo(clone_flags, p);
 	if (retval)
 		goto bad_fork_cleanup_security;
-	retval = copy_files(clone_flags, p);
+	retval = copy_files(clone_flags, p,
+			    args->worker_flags & USER_WORKER_NO_FILES);
 	if (retval)
 		goto bad_fork_cleanup_semundo;
 	retval = copy_fs(clone_flags, p);
-- 
2.25.1

