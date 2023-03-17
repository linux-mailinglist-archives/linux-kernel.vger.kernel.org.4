Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413F86BF3C1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjCQVWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjCQVWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:22:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB69C6DB6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 14:22:16 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HKuWPd016808;
        Fri, 17 Mar 2023 21:21:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=zN3cT91sjc+CGW/b1TMScu30sdafxLLQAsYvU3EjQmg=;
 b=EEGiHi+noxqqonm8N/cPUy0tqhbYYWnzmdK8YMqecNO1Ydjl2kDL6OCy0e3j5Tyyugca
 oAppxfrrPufy04NdRnMLfOwZBi9ftOxRqQ2VZbJ3Mio4oMMqtW7trX1YDRWFgwv6tbGQ
 yG37ocEVYy8OqQybClMWQ/K7c0UTvG7+6E6tl04uKB49vg/iyM7SgvsaIQ6JKjkHUsup
 WJuEa1GcG36aKlD/jBv22sagbMRYxf86U9ElKqD9f8kIJLqhCc6zYb/pmQfyVLSxXMxR
 DQ88Mmgcl42bJyBM6IWjUatPauelFEFAbAi2ldqVrqKUiY1nD/SbtA4COz+soLGFb1Xl ZA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs29cyqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 21:21:59 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32HJJcjq015649;
        Fri, 17 Mar 2023 21:21:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pcu2uc4ae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 21:21:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOQxDg7u1oTcSI/OcSVXAQZG7lLFs5WLp+cT7VbnTtOKr4XlCv0vTv1+NE+KZMTEbpKhAC96EWTO7CqwTIX9S8vX8YqSuwpZJtKQWm3lirjEUeFma7poa7tz+/GT7s4V6taoXtjA6myY87ZJ8UPlru3FU9HnhlMRtfmBtjasGW2JXv2o53DBuZ6fL70kCKro64QoW6J2SY+ifpOd7TGXIM+n+ew7W0Lyl2Uvrbunwu+bP/PNunNDVR4KlcgthtnnI7IGC9kiHieYVc92lVTHZ4ttxYsl6y5hlOFuayP73NwwBdikncDGZ+cyLYOhS3hvtmeXxoKHHPzdC0aKWoI9Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zN3cT91sjc+CGW/b1TMScu30sdafxLLQAsYvU3EjQmg=;
 b=WGbEn9IKSL/OaxzP5R7XWGukuTCPQHJM221yne33TDaToXVqDaE6ARMUd5uuqNj0F3bqjQiUmF9Wx8HIvh9uzrPte3+ZkOgH3umMOlSBPBk8GFtuXchB15zgWtGRbVLv/oCVNL5ZPDNHbmJhzKGLWP+zD9IWKRecOccDDGLBk5LLIs8A8F98pHCeewl0SZsoIPnl2eD4GXHy2zsGicQRQTXOvpSwArg8nX86gyYuSP/q/qLtj5PUfbKWJQh1UL/2s3Gvkbyj82X10/gqWHPOS0PD7LzTuXS8oFbv2tNK/Y4FARRLFExztFSau6HdVZUgl2XGU4Mgbw+wXhkDhUkzgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zN3cT91sjc+CGW/b1TMScu30sdafxLLQAsYvU3EjQmg=;
 b=jqaKSyzPc1rbn+Sx0pkr1ZNuJ3bEOALnd2HCzyTzY84/XRWhL9jsGDPm1tDc+lR5xm/RtngeKn0Y45Nc0mvjpkK7UgEWw1h1uX9SfHF3zVsdZViREymqBcwb2kyEV5ArwI1DlC4mXwQeojswGxrADF08rf93mtFyPnaiT9A0Zrw=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS7PR10MB5901.namprd10.prod.outlook.com (2603:10b6:8:87::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.35; Fri, 17 Mar 2023 21:21:56 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38%9]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 21:21:55 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v20 6/8] crash: change crash_prepare_elf64_headers() to for_each_possible_cpu()
Date:   Fri, 17 Mar 2023 17:21:27 -0400
Message-Id: <20230317212128.21424-7-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230317212128.21424-1-eric.devolder@oracle.com>
References: <20230317212128.21424-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR13CA0044.namprd13.prod.outlook.com
 (2603:10b6:5:134::21) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS7PR10MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: f679fa2a-3d6e-414e-4b78-08db272da280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fyxVBL/zErCt18ZDf8apk62BjYgjGGdu3Sfxx3/29scfAWjCyCL2p7Sv0DrFDdk8CciuS8dupwutqTKcQalGgUHVZeZPUM4VDXsPFh1ujPkWuuggxURkqU2cvlTEnDMCXgYLTZYPM6eGmJOTa8ClyY3gbal5XNnd2X6WS2PfmsXd5Y3Zk5/m2XJkbUi+CcezNMnncxdbE9jKAmfP0KiIrN1Dv4pgKH0OXA3BNSO1OWP9m3dncs0qmr8T8fy/DDOtYTxOWBJ8DitNHXoAt7mjVi/ddYEidJDjt79Azni585laGMcLe6ZtzRFDjCwZKTX4tC7DnyUNgtV7tAsuIzZI0HJRg4fbAesxVCBjGNA6LVBE5fRLFB1OGWNFEzclzEMBxrGopYcWSe8gCuDiXwaiRCRMdYsPel58yu1SqeXFaDaR0YdFc6Xx7VMrFIoOqEfj2v5IN1AHgQqWY8BdOI40Y11bmM2494x5n6UXwIJNP89jCWClS1a1GfmPFRuMxRzbvC/+ACY5b/u3Pa0lR2xA+phVuzXCCjrdst8aY5w483eeCxVNmQReYclzFFeuWOskpXrPUE8ts7/JJU+5ZArsnk/v5hysViJc1jfmQDeV3VT4WntIvWAh5h8VEYL9vhbdV3gv4RbNNjV8lFazpOytiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(396003)(376002)(346002)(366004)(451199018)(86362001)(36756003)(2906002)(38100700002)(41300700001)(5660300002)(7416002)(8936002)(4326008)(2616005)(6512007)(186003)(6506007)(26005)(1076003)(83380400001)(107886003)(316002)(8676002)(66556008)(6666004)(478600001)(6486002)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J/xzcdYAsT2roT1IVtsKHRfNJUWTJ7kZ5pQq5YcJtmR3XTFNV3a2rADrGr9i?=
 =?us-ascii?Q?GJ9tio2Cks45XNZLR5yrsem7G/jQQ1khAocByUwbQstGtd0xP7NbAw7/vkO8?=
 =?us-ascii?Q?+VCgx8ceHWxOE9/HsD7WmZ4p99pNO5FlwONCDMnHE5H7ogR8t3uMbrWyxij/?=
 =?us-ascii?Q?ncmuOQMCjJ4AEZXl3TyC41Bx/iyKFpJSYpNz0VTk0XRKIU+batQnMO25e6To?=
 =?us-ascii?Q?fmtZAjdGy7QRAGYGmY/zeZRKiJABS5gOnGGHZifEDT9VmdTBz+psSJzcUvSl?=
 =?us-ascii?Q?nTEPu/9ghG4GnoKUqO5mGav4oNFsxNf97UYJznD3qG399Fu5+P7Woe7SGtGz?=
 =?us-ascii?Q?SiU/Ct8Z9RZehjdV9qE1sj5oUHh4NU91mDEorNUWTzO/x7pWpmHFvpd4/wSL?=
 =?us-ascii?Q?Y8oMcyCebmNC0NSp583apisFBNaXY1JD/+RGP+vu9dhQxsSB9AjLRdeyCM1Q?=
 =?us-ascii?Q?o0xQHPwF7so4jgnbmnPyrvc7xrLg2Q5eI6laTYG745MSr8Cob3qtfM5H40KC?=
 =?us-ascii?Q?TfnxoihUCVLMkJ+QHBxhjG99FUk057Gafn0Scm8gcX4kW2Z8j223gPWS0Hpe?=
 =?us-ascii?Q?tKPwPVqENUV5QhmPfAXTaNngffmHxTovIUUE0VDDTmrdRyflGjFuRCT7zbNk?=
 =?us-ascii?Q?ZVExOyBXwvXL9RA8XK35mtOqXhUILTz2nWNSb6VNVmBKn1p63XChs9jlf2X8?=
 =?us-ascii?Q?suJtlmLnQhJjsajIHcIcyymq6uPIMXdH0ucmtRdQaCiUTFjX+XTEfvB08NvJ?=
 =?us-ascii?Q?trGJipesgs+xJXH1sRMG5BCZF1IZJJTPSd5Q4aa12Os5ekltPhIFe+jf6t5k?=
 =?us-ascii?Q?NFu9dw/rguDu0hYtzNYmoaboD+OQj7qEGkLvPk2bSWEwNZg9l6mkajb6IdPA?=
 =?us-ascii?Q?d8EDHiquD1ACqie9ju5z/xTZwwwWOu7cRvxXcLDDuRO7LTS9n00AMysHCvK3?=
 =?us-ascii?Q?W3BFiA/YefbTj+C8gmEj5am4d00MUVp6k5wj7IzKqAQHpEQL06ISJnbl1pDN?=
 =?us-ascii?Q?J7rkvPlGvGmrKtOg7mQipNQd2IRekrlnAjKhbvFiJY5D2OtEkYqb0r852acd?=
 =?us-ascii?Q?wGVCR88nce4kyUlf5M/+e00y0Jzj0/uf6/9FhNPTGxhyJWdnT3zTy1icd5F2?=
 =?us-ascii?Q?Mnjs+8qVzzC1vu/N5qugXj8/+hKQJ6qMhkCeibn/Gplstm7BdyT5BOzaXCrl?=
 =?us-ascii?Q?4RexQPsFgqrcR8IsvPkjTyzQRPu2Q9h2i+JW4XQ4GJ6sNKW0DWMpRwP6C7Qd?=
 =?us-ascii?Q?46NYEG54MhaK1FSooanoYhQArZSFhxvkLuGYyPQTOdYodU7b5L/IDcaMSENU?=
 =?us-ascii?Q?um/yTaJeGh5ce7jHetrtA1hIv4vCTBCbBzJK6td334Mi4Ujj9Yadmxsb9fd+?=
 =?us-ascii?Q?8mj6wL01+frZ7OhkMi8zGqHecjfzYduc0iOkZvnWBxXfPQRj2twqtI4SUCps?=
 =?us-ascii?Q?/rbehSL9gCKgityC28ymSMHSJxFwubA16hF5DJeIMUZsjgBlKj95ZuU7Oa3T?=
 =?us-ascii?Q?MoGrQepzHuBCnM/z7qpyF2BIA2ju2bgXZBC3PQMtxBJabY2uN2dNyme5TF9+?=
 =?us-ascii?Q?ScKwYKpooSebRwFEplZDmw7F0XXyioD3+MD2cMLDmxlSmt7lbcMEBPuJ51vE?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?4gDFUtdc/FSrySf/pWkgB7TWyADbzmI6H4MNTk5fBt8SZg/8mHDldPHnfIpC?=
 =?us-ascii?Q?kdlnaYw51tSiLpilhOvM5aYVg1qm4aEQ4NJHgpi27/yS8XpXlbKr8rUILAGv?=
 =?us-ascii?Q?2iuLR/31N7bHHhChA+g8Wx7i/7uRlX95I09ZKVqdxoqjplDCUHj8VSw0E6OV?=
 =?us-ascii?Q?Evu4BxCHHuhe7j/PqluSf/kpgBjK8BA3EP7bCTEcBxfyz8mnlJfGnMeyOJ5D?=
 =?us-ascii?Q?gXNf/ZieaRAZ5i2+yA1/F0N6Tyjz26fT149u8NU0KePpkiGlwBy6XRYoSdxB?=
 =?us-ascii?Q?Q6wrRyxrs0FcwWi2P3TqA2mcxhSmRRcRz76v+vY7ZQJQ9eohc5VXQw0rZBJZ?=
 =?us-ascii?Q?jpO0gQptZOg8WhzWh8iZFdP3h9T44yUZxbWPLiLUSfoeVKGJ0gTZyLZAf6w1?=
 =?us-ascii?Q?BQvcOsA6+zvaK2hScwYWNo5oKqFktdAUCRIknDuRKxrzDTm2jE+KEWLZLAyS?=
 =?us-ascii?Q?CkKCdBT3bacWPhDEYkJECo8iMe9xesbNbl3eZe0zRTZDVTaUIPqB1n91NGqI?=
 =?us-ascii?Q?/OUl+Yb6tUjiPSVsn3hGS6xVqCKz0Y0fbzviKifeAtOGn8cKZAjR2mPut/0A?=
 =?us-ascii?Q?XYiOekRH6SICSj5ILGuANCXDT5SsDpfDKYmwgyArP6T1MsJ5PXI265cupR0V?=
 =?us-ascii?Q?AJKDT0q9eTwHS1NBqfTGBmKNZIH5OM63GP5E1mmtCm81j8dl3bhOx7hBJHO2?=
 =?us-ascii?Q?aqLGhb18TiIx0GbaAR05rhzGMVEz4RwdXOEXpx4T0ot/XFPQN0f0NjHzrVud?=
 =?us-ascii?Q?f8mgpqY/iHI60ZH0vMAEOeI3QSXVmSE8WUvSPneWCj5ojbzDEnLE0HuewAKL?=
 =?us-ascii?Q?hLfJu+W3Egzx3vqi0sbjgL7lWAcYJhKhColHp34GGZQFTMY7Q3RydeKolhq/?=
 =?us-ascii?Q?ktMMZ0oUk94TETDF9svI4WrDDtkUF0o3Vi9+XMvu7Eq8e/3cJ5eV6Zw4HkMk?=
 =?us-ascii?Q?y0gMeWKKxGNVGdvlUon8/8m5BCBg+uEawCRrpaY0c9sAUg9wMf+DExZ6/CRi?=
 =?us-ascii?Q?pFJt74ekPAsTcgzpL+HoRZ+6hfjQPMk70El/1zJh4l1ct1GtLx1Pd741l9rY?=
 =?us-ascii?Q?/FcWBf/GBx+w6JgeiHeumTGf1iYEhTG0ch6JrlyB1301LcFLJ6UF1VReqKsv?=
 =?us-ascii?Q?t5VCnXuEKbq9CEUr7iMew269TgPZ9yUm/kmGsjJgUwY3soWJUGwpPtw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f679fa2a-3d6e-414e-4b78-08db272da280
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 21:21:55.8260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h8Ejamc+RWZFE2meZ0BR5Rip9MyodBx0MrmZE9BQXZyNqpNyU5ZlDf+hwGSz7qKCakf0zdsSmXACPffxifTeprIp8sjNEHjeM773OjGkAKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5901
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_17,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303170150
X-Proofpoint-GUID: Dhls-A_tCITodXZ66z23di2RPLG2I2UL
X-Proofpoint-ORIG-GUID: Dhls-A_tCITodXZ66z23di2RPLG2I2UL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function crash_prepare_elf64_headers() generates the elfcorehdr
which describes the cpus and memory in the system for the crash kernel.
In particular, it writes out ELF PT_NOTEs for memory regions and the
cpus in the system.

With respect to the cpus, the current implementation utilizes
for_each_present_cpu() which means that as cpus are added and removed,
the elfcorehdr must again be updated to reflect the new set of cpus.

The reasoning behind the change to use for_each_possible_cpu(), is:

- At kernel boot time, all percpu crash_notes are allocated for all
  possible cpus; that is, crash_notes are not allocated dynamically
  when cpus are plugged/unplugged. Thus the crash_notes for each
  possible cpu are always available.

- The crash_prepare_elf64_headers() creates an ELF PT_NOTE per cpu.
  Changing to for_each_possible_cpu() is valid as the crash_notes
  pointed to by each cpu PT_NOTE are present and always valid.

Furthermore, examining a common crash processing path of:

 kernel panic -> crash kernel -> makedumpfile -> 'crash' analyzer
           elfcorehdr      /proc/vmcore     vmcore

reveals how the ELF cpu PT_NOTEs are utilized:

- Upon panic, each cpu is sent an IPI and shuts itself down, recording
 its state in its crash_notes. When all cpus are shutdown, the
 crash kernel is launched with a pointer to the elfcorehdr.

- The crash kernel via linux/fs/proc/vmcore.c does not examine or
 use the contents of the PT_NOTEs, it exposes them via /proc/vmcore.

- The makedumpfile utility uses /proc/vmcore and reads the cpu
 PT_NOTEs to craft a nr_cpus variable, which is reported in a
 header but otherwise generally unused. Makedumpfile creates the
 vmcore.

- The 'crash' dump analyzer does not appear to reference the cpu
 PT_NOTEs. Instead it looks-up the cpu_[possible|present|onlin]_mask
 symbols and directly examines those structure contents from vmcore
 memory. From that information it is able to determine which cpus
 are present and online, and locate the corresponding crash_notes.
 Said differently, it appears that 'crash' analyzer does not rely
 on the ELF PT_NOTEs for cpus; rather it obtains the information
 directly via kernel symbols and the memory within the vmcore.

(There maybe other vmcore generating and analysis tools that do use
these PT_NOTEs, but 'makedumpfile' and 'crash' seems to be the most
common solution.)

This change results in the benefit of having all cpus described in
the elfcorehdr, and therefore reducing the need to re-generate the
elfcorehdr on cpu changes, at the small expense of an additional
56 bytes per PT_NOTE for not-present-but-possible cpus.

On systems where kexec_file_load() syscall is utilized, all the above
is valid. On systems where kexec_load() syscall is utilized, there
may be the need for the elfcorehdr to be regenerated once. The reason
being that some archs only populate the 'present' cpus in the
/sys/devices/system/cpus entries, which the userspace 'kexec' utility
uses to generate the userspace-supplied elfcorehdr. In this situation,
one memory or cpu change will rewrite the elfcorehdr via the
crash_prepare_elf64_headers() function and now all possible cpus will
be described, just as with kexec_file_load() syscall.

Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 kernel/crash_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index ec1d68569f6b..30ba30cadf2f 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -364,8 +364,8 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
 	ehdr->e_phentsize = sizeof(Elf64_Phdr);
 
-	/* Prepare one phdr of type PT_NOTE for each present CPU */
-	for_each_present_cpu(cpu) {
+	/* Prepare one phdr of type PT_NOTE for each possible CPU */
+	for_each_possible_cpu(cpu) {
 		phdr->p_type = PT_NOTE;
 		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
 		phdr->p_offset = phdr->p_paddr = notes_addr;
-- 
2.31.1

