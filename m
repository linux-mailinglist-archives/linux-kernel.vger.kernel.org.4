Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA17F65EFCF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbjAEPSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbjAEPRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:17:54 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FD558FA4
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 07:17:51 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305E4HNb005886;
        Thu, 5 Jan 2023 15:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=wuvIjx9c/WELh35eOrZlKKSq9Hvd8E+tfrJ2t58oNDc=;
 b=YINkFg407/D4vSkkQ2e/sr9Bsg8Ge5StEtRySYJGIF03x1kamU/ifgjNJA7VO5aJC/oW
 w0XCcTrsYZWOFzgtgNZwz4301l7Ep4em6ZkQJLRo0N57rDBerPZBtXciWOVechknGMsx
 lb8Cubce/ZKD0p7KiDD/Hw8xwUsFzDSAgPQksRDHUcvXINs8qqRYa/CyuG2hxi1pRm7F
 fExsUK43itzSdSD4qDEl1BxVQL3rpslLK59/Q3d1AXDMb9Fl0Ob/BbOSmS/zl3Cd7eMr
 VK9YABTJ+VFEL7iguFXNBxady3/zOnTb52LX7tH5pdhShyodlRwccpkveQZZ/pcby8IW qQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtc0as555-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 15:17:24 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305EPJuK028032;
        Thu, 5 Jan 2023 15:17:23 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mwfsytrkm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 15:17:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bT0D3AWhgbtkSwlZLb8JtAJyZeYH0pKIfJ8tvaR3BEv5wCfNpVFSoFux92p5bJAMLYp0K4WWYbD0HweC089yBjbagSajY5o1Kq/O31b4dHqJhYD3v5538oz6DNP0w7uO+T3I4W1x+wytLgCirQoATuEKUgCzGhajPC0BbMtruksIhINlUIqM/WsUJwYESKD8IsjGokFSvDomLC6KSysMKFgj5PsTNmwtugNS6POoG+DUmUs7E88lDsuFnpoY0hn0eKKTT6on//rEZBrNiuotkkOvEPRtqjWkSlhYv7Tw0ShoYsiQ4hYXw3Lvx3Hzwo+ET3VBLgMKAQjOYCnYU2FFgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wuvIjx9c/WELh35eOrZlKKSq9Hvd8E+tfrJ2t58oNDc=;
 b=T8nNBKnGm/75BNbXcQ6R5k1k/j4c/Pq9/2Uf9OXQGer5CxErDDcXb1yah0CVaMHM9hYm1SO/7NESFDsCIS55NI/CHZjPYRWI+pBDVl9MteQk0MPIBYlai74bb2p/uGdip+G9R4MjeDs7WyzIDhNgAbCGbKI94FzHh9tj+xA2QDppVqYxhJKmMFz34QJOaR3W8+wkEoqnvYuFAbPZnbC8j+4fsKDDfUa+oL7GrqdMGQ35Cx2MWQDnolwCMfHXQofW3p3/EGO4ieT5wG+thPI3lt9RHHO5mym37bFvFnVAVRe2X2Fj+Fl5Cxrp3zLld9TZ73bl8bg6kyyl/wayoeLBTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuvIjx9c/WELh35eOrZlKKSq9Hvd8E+tfrJ2t58oNDc=;
 b=fc81DrORNv+Yfq1CeAa1KXQY+E3BOPkfGae7mOdKmxcu2Zv2vWkPndFljldxqLy8m0mXI249NGRWQQ+s08HyFf6Ts0bNiE0DPt/D0QA0baSpLHo1s7mOPXU9K59O4POWboJS8Vj5vYT1yKYBN8hF0/3nbYC9rpp26GNtXoULN9g=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH8PR10MB6477.namprd10.prod.outlook.com (2603:10b6:510:22f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 15:17:20 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a%5]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 15:17:20 +0000
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
Subject: [PATCH v16 0/7] crash: Kernel handling of CPU and memory hot un/plug
Date:   Thu,  5 Jan 2023 10:17:02 -0500
Message-Id: <20230105151709.1845-1-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR21CA0029.namprd21.prod.outlook.com
 (2603:10b6:5:174::39) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH8PR10MB6477:EE_
X-MS-Office365-Filtering-Correlation-Id: eef5685e-b210-4f77-c722-08daef2ff014
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: acgT0SMKfe2vqSHY5kXvrBCSoDeJO+QkxH3+I4BBRb9zQFDXixl3ntDhXGIWV7hL7TMkw1FZAKFL+q6DwzYJGGTx8AA+SuItrfhlHIJ2MZwWV3KkPnOEsQQa5wxcbu2lWDP3wciyAFigslt92/qiyw7M1t5yqZFlqFj+l9Dmz2fcHRMuflIBL1//NncYmKEgo8GtAikgVAZtwcgOV8TyNu0lrB6aWxJnJ34L7LRIvOoIWXWZmsHgUCza8KaXpyEE/l/88rwyFRihDMUVRkmJzd5ZDnOOrNX0Wk6LHQSnB/tLTAbln+Hwx9Oyax0GkbnBKL1sckLuiwRcF5HjANOO5RZ2AeI7gEB5dzm+qARcrEoltVsbDi8dxZ9pVk7QylPB6Jya8hLk5IdwUtZUlFguThrEMjndUs8dwVKiueI5/mEwjcU4vmwZYDxFuY+1bFFQ/37EWrTjswzjLVgo62dwSx2dwYmA0PE9yTHPtagPWcroT8L5FIWvBaRkQZBlS+2m9Dhzp8U/qLZGwhS+TONFCZfPcr+1vjuXDMqppXauhK5witMA5p3RZ35Wi7H9CAisVrOYPGB67RpDqre+Vf6RkWCjF06dXc14+W0DVyTbwDoz3YZmxtoa4VWp1mdc9LRUEJSKvnLrRDe29TWJxMXm4OZ38tuG1xjV6ff17a68qiWsPxg0UmVOHPiFUVB676Pzs4pU9Oau7/9UV5lHumbghA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199015)(5660300002)(7416002)(2906002)(8936002)(41300700001)(478600001)(316002)(4326008)(8676002)(66556008)(66476007)(66946007)(6486002)(966005)(6666004)(6512007)(26005)(6506007)(107886003)(83380400001)(1076003)(2616005)(38100700002)(186003)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?98ongt+yimbopS8+fEZKs7A/NtmbgAAvFybokNmZCvHRrHoh3OsVId9zPhrS?=
 =?us-ascii?Q?Hn3aJS5v1Xxqul9splOjC0QtEVja1OOv8BMK9fE5Qwiwc5qS62bau9PZG8qD?=
 =?us-ascii?Q?IJ5cPck/k+/Cwg1kfd/aUP2QSCZTSHEMcKketSaQNhL73l1blMF12quuqZzP?=
 =?us-ascii?Q?St3OXfpCfHCLoTf1hDvoFC5RFaSihyC3OnzXOs3ez0pczUAWd/iOCodOrEnO?=
 =?us-ascii?Q?ie7ZxEKjkd4mIanq+vkUKMRwqvq4nmcAk/kW3x3/uDWKAS22zIqz/eHRBmgQ?=
 =?us-ascii?Q?7DXG/Z8yr4cn9qXR1YpdKVfLobqhXEzebjc1Akoy+pb1rK881Cw/kDBzogU8?=
 =?us-ascii?Q?I0YVVuUYaRpHLaQx7P5OlKQxO4uzfBDKLruSJSsNcTgP5YvqiHE8LRf8Th4n?=
 =?us-ascii?Q?8b6FXbuB/N4RnHZ4sDbOXOriKajTxe3jKK4dOEHHu0kydllyr+YiKGZena3/?=
 =?us-ascii?Q?h3qCPpCIhVydO5S1odKkSCElYcUPwwE+EKQmvW2DixycOV3dleMzEGkwPHqI?=
 =?us-ascii?Q?ciJaw77QAHOgg/kCI20LRXlqaZOcTZI1rvm24gAxc/hWU2MMX3l4beCm0/96?=
 =?us-ascii?Q?TNtzFCtr2wOeajtR3SDfXwrcuvZF1aFjLlfYGk4PC0/pycuLqF2YwdRqZNep?=
 =?us-ascii?Q?gKo3hNvGLTds91mtEZMHPHIMT7AT3XUelhQNwGOpFbAPdJxBy++/j/wkQmt5?=
 =?us-ascii?Q?AzgIP8PumcrFqk12SbreorxMyp65VWNYLEmXM3G1LLVbt+9bBKn8ECZaOmaM?=
 =?us-ascii?Q?mX8losTPaBuEAehpLqx5UCP706JCd/Ggl60Gnkpvf9vpHVnL9XxoseHIUstJ?=
 =?us-ascii?Q?JJA2Kx9MqpKi4dcEOjG6bgnlaPzyemv4/U3j84JJbvsCS4VCPXhmoY4H5EBz?=
 =?us-ascii?Q?iiaL+ADFd/xX/DlVK7V9HHCADtknzt7Ejjv0JSXKaJHAFisnw7ffIMOsiQTQ?=
 =?us-ascii?Q?ToeTfXaq8tI6iJcCz0SS+BF2BJHxAAwxl+6//zlORH1XegmM+NJ01a/oCTfA?=
 =?us-ascii?Q?PEzM7jMPPKpmETw/pKOIOR5Q5e91qFIm3SXHO5+xc+CDTDg4ABzaQgCQsk6N?=
 =?us-ascii?Q?bd97uDtK5wa8Mzg+gA6Vm2NyIXTJv2h6tH8ywL1TAy707agUgkdlphwRD74F?=
 =?us-ascii?Q?9Iqu8PGQ2zzy4uVA3KrwK7SgkF13/l9d32MN+pbfRoQgcm7xCC99JR3lwqvP?=
 =?us-ascii?Q?Xi9rBa93yDRvLylY4x7ogeESiHzq3EPC9CLFZk0oGRD56liUrccPJbxfM5fv?=
 =?us-ascii?Q?frisiFyXp+sVnpZhydmWMlB4e+alvHOcqecPq+ECTW6pZKgS8PC1qXxYrEAr?=
 =?us-ascii?Q?Gboi9mZAmo88e/zzWcjtvRQgEItFnNOmZs9Fhvf+/Xb2h2ub5QmTBp/ziBC3?=
 =?us-ascii?Q?PINNLB9dIOTN0ySfmY42IQii6p1UnAs2lKfKi6gr5IXL3cpbD1myKIMWQq4/?=
 =?us-ascii?Q?xWOmR9eqHgT9GrQvPY8H5LOfeIZ2ELZW9//KVCxkwa6GCvGeQXUEvxlL+tCJ?=
 =?us-ascii?Q?Q/08TMsQplnRp/m+sMS7VhsXVl23hVYFjE5wg3BeBlVY1SZWg0WBauanLpI8?=
 =?us-ascii?Q?4uq0ss+5dlshAMXMcmbGRLrt/XyXlGHv9LlTY8Bs/Sv6CvWkk0TQphpTfZox?=
 =?us-ascii?Q?MA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?8Ox76PRztKE07N1ki0i1d4cmBDshfyB0k2pd/Vji64CQuxIbdgdsDVgNSvHr?=
 =?us-ascii?Q?WhaH+Bk4YQdbcjFthkzCY2qo2INddOyiNh64MqiyzvmZzQeBxxHIExjdN0k7?=
 =?us-ascii?Q?132DZ9fhELtx2MKPVlRYgckzTC6UPH5z8vqbo2kEIFD+qrv/iwKCHpqwJ/m5?=
 =?us-ascii?Q?x7lEbWsdmmwgqNv7CSV+3DX8ho6xJpDNwtUK5ytetKO/g0topPi4fmVTgaO2?=
 =?us-ascii?Q?Q+a7u5YP7iqCjrdNG5S2+lMAp/kFoI8iQD1+tDRXT+XbM1sZBP8+s3Mxef4L?=
 =?us-ascii?Q?NBj2VHc2t/7KX5Jl+H4h2WKPNR6hM9k0V0Ve9YxqHJlkSukRLkfFygWCvMrK?=
 =?us-ascii?Q?EaglBOb0x9ISk8znf4OheSktJ3lsg5LaJHi1zwNphmd1QJDQGWhrOrXzviCt?=
 =?us-ascii?Q?v9HS0BLh9s7eTN8BBEkoblNGOw9A/9pHWv6ml0/y+V2d/Wc9EXLcGUxixE8P?=
 =?us-ascii?Q?dJDI/gNeWHDmA60H0LTYm9s1zNPKGlbiV2OzCLs/Y4LTZLAiHs3VVVn66b8f?=
 =?us-ascii?Q?W51VdZMQMzW5OL2om9nDpdnR/pUmFvxXkAzcYQCf8KRHbQ0iaszsZUTKR5lP?=
 =?us-ascii?Q?EjVqwnoaz3CLmst3b83tK+mIdjJK4d+DIF/799g0K4dZzukdCtv0whMAIrfP?=
 =?us-ascii?Q?NfZHeYgjQ8FH7JrHoJTMdVAfxx7GR7u0nTyE//94w5outGQFMHcGwNou1J6I?=
 =?us-ascii?Q?TU+Zczt+IsodQeI20rSfjsI+6No1AJM7mcYxC5VavR9SEv08khGxyyKhijCG?=
 =?us-ascii?Q?8Jnx+vIdFNeVB9tgKawtwC+Tz7OA/kZx8rUX0CXTg8GViuUgIMsf0uaenTkM?=
 =?us-ascii?Q?jE3mlKizq4q7f+TByHgXq4fSj/Dzt6C+2jnywNpVDnqUcBsHFNooZyChcu9k?=
 =?us-ascii?Q?fz4ClbzpsKNbuiRX67vbRwcdvT+b3HYUedMxKOTYCXwDlfVcPeyUdyCvVZi1?=
 =?us-ascii?Q?FZ0WZlwZEcL0W/8D5lj4zML6cbmzhcxIoy52HfQrX1MBP7/kVMj23gRoFbGt?=
 =?us-ascii?Q?eCEkKmsdM4EqoRhit2DxSiHCEKIHhoehFjSPzy2HdNwAA3Uu0kikTIvTCQG9?=
 =?us-ascii?Q?ezTTb9H8H8OklBcMaKb45Bv1jcVdswAIG21k8H44kHlR3VvKJ9BI7WLPSAG6?=
 =?us-ascii?Q?1lFCSBGkrn+fqUEnVhZLx72vNI+oPhfCfDYmBaWYi2a1HMoPal3aDv1JrfpW?=
 =?us-ascii?Q?vKAh7cwaZEOR07GcdFIo/sZueFSmOHFYEPDPGGbgbH1NMFQqWrLPY1aH70qj?=
 =?us-ascii?Q?Te50nJw3Z8YaFx5tKKx75c9KMU/LWNyuKUfJ0fGsLLdv9ffYdK5pPkCPshC/?=
 =?us-ascii?Q?NUGp23ekxjFDt2inxfDAPxKs7ugCk9FfoSfobo10XTV/8Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eef5685e-b210-4f77-c722-08daef2ff014
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 15:17:19.9530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kuhu6MTd8Xy0K+qVzvtx7EQtKipN6zvsZOsVtSiQXqVmuWxUC3zjUvqXx0gCLpKEIr/4BADD260NUxreEZn0EEZpf9UAguO9KcHU7C8i7s0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6477
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_06,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301050119
X-Proofpoint-GUID: d2aGdkz5yBsZLFt9WUODrP5TEBaMIK61
X-Proofpoint-ORIG-GUID: d2aGdkz5yBsZLFt9WUODrP5TEBaMIK61
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the kdump service is loaded, if a CPU or memory is hot
un/plugged, the crash elfcorehdr, which describes the CPUs
and memory in the system, must also be updated, else the resulting
vmcore is inaccurate (eg. missing either CPU context or memory
regions).

The current solution utilizes udev to initiate an unload-then-reload
of the kdump image (eg. kernel, initrd, boot_params, puratory and
elfcorehdr) by the userspace kexec utility. In previous posts I have
outlined the significant performance problems related to offloading
this activity to userspace.

This patchset introduces a generic crash hot un/plug handler that
registers with the CPU and memory notifiers. Upon CPU or memory
changes, this generic handler is invoked and performs important
housekeeping, for example obtaining the appropriate lock, and then
invokes an architecture specific handler to do the appropriate
updates.

In the case of x86_64, the arch specific handler generates a new
elfcorehdr, and overwrites the old one in memory; thus no
involvement with userspace needed.

To realize the benefits/test this patchset, one must make a couple
of minor changes to userspace:

 - Prevent udev from updating kdump crash kernel on hot un/plug changes.
   Add the following as the first lines to the RHEL udev rule file
   /usr/lib/udev/rules.d/98-kexec.rules:

   # The kernel handles updates to crash elfcorehdr for cpu and memory changes
   SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
   SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"

   These lines will cause cpu and memory hot un/plug events to be
   skipped within this rule file, with this changset applied.

 - Change to the kexec_file_load for loading the kdump kernel:
   Eg. on RHEL: in /usr/bin/kdumpctl, change to:
    standard_kexec_args="-p -d -s"
   which adds the -s to select kexec_file_load syscall.

This kernel patchset also supports kexec_load() with a modified kexec
userspace utility. A working changeset to the kexec userspace utility
is posted to the kexec-tools mailing list here:

 http://lists.infradead.org/pipermail/kexec/2022-October/026032.html

To use the kexec-tools patch, apply, build and install kexec-tools,
then change the kdumpctl's standard_kexec_args to replace the -s with
--hotplug. The removal of -s reverts to the kexec_load syscall and
the addition of --hotplug invokes the changes put forth in the
kexec-tools patch.

Regards,
eric
---
v16: 5jan2023
 - Rebased onto 6.2.0-rc2
 - Corrected error identified by Baoquan.

v15: 9dec2022
 https://lkml.org/lkml/2022/12/9/520
 - Rebased onto 6.1.0-rc8
 - Replaced arch_un/map_crash_pages() with direct use of
   kun/map_local_pages(), per Boris.
 - Some x86 changes, per Boris.

v14: 16nov2022
 https://lkml.org/lkml/2022/11/16/1645
 - Rebased onto 6.1.0-rc5
 - Introduced CRASH_HOTPLUG Kconfig item to better fine tune
   compilation of feature components, per Boris.
 - Removed hp_action parameter to arch_crash_handle_hotplug_event()
   as it is unused.

v13: 31oct2022
 https://lkml.org/lkml/2022/10/31/854
 - Rebased onto 6.1.0-rc3, which means converting to use the new
   kexec_trylock() away from mutex_lock(kexec_mutex).
 - Moved arch_un/map_crash_pages() into kexec.h and default
   implementation using k/unmap_local_pages().
 - Changed more #ifdef's into IS_ENABLED()
 - Changed CRASH_MAX_MEMORY_RANGES to 8192 from 32768, and it moved
   into x86 crash.c as #define rather Kconfig item, per Boris.
 - Check number of Phdrs against PN_XNUM, max possible.

v12: 9sep2022
 https://lkml.org/lkml/2022/9/9/1358
 - Rebased onto 6.0-rc4
 - Addressed some minor formatting items, per Baoquan

v11: 26aug2022
 https://lkml.org/lkml/2022/8/26/963
 - Rebased onto 6.0-rc2
 - Redid the rework of __weak to use asm/kexec.h, per Baoquan
 - Reworked some comments and minor items, per Baoquan

v10: 21jul2022
 https://lkml.org/lkml/2022/7/21/1007
 - Rebased to 5.19.0-rc7
 - Per Sourabh, corrected build issue with arch_un/map_crash_pages()
   for architectures not supporting this feature.
 - Per David Hildebrand, removed the WARN_ONCE() altogether.
 - Per David Hansen, converted to use of kmap_local_page().
 - Per Baoquan He, replaced use of __weak with the kexec technique.

v9: 13jun2022
 https://lkml.org/lkml/2022/6/13/3382
 - Rebased to 5.18.0
 - Per Sourabh, moved crash_prepare_elf64_headers() into common
   crash_core.c to avoid compile issues with kexec_load only path.
 - Per David Hildebrand, replaced mutex_trylock() with mutex_lock().
 - Changed the __weak arch_crash_handle_hotplug_event() to utilize
   WARN_ONCE() instead of WARN(). Fix some formatting issues.
 - Per Sourabh, introduced sysfs attribute crash_hotplug for memory
   and CPUs; for use by userspace (udev) to determine if the kernel
   performs crash hot un/plug support.
 - Per Sourabh, moved the code detecting the elfcorehdr segment from
   arch/x86 into crash_core:handle_hotplug_event() so both kexec_load
   and kexec_file_load can benefit.
 - Updated userspace kexec-tools kexec utility to reflect change to
   using CRASH_MAX_MEMORY_RANGES and get_nr_cpus().
 - Updated the new proposed udev rules to reflect using the sysfs
   attributes crash_hotplug.

v8: 5may2022
 https://lkml.org/lkml/2022/5/5/1133
 - Per Borislav Petkov, eliminated CONFIG_CRASH_HOTPLUG in favor
   of CONFIG_HOTPLUG_CPU || CONFIG_MEMORY_HOTPLUG, ie a new define
   is not needed. Also use of IS_ENABLED() rather than #ifdef's.
   Renamed crash_hotplug_handler() to handle_hotplug_event().
   And other corrections.
 - Per Baoquan, minimized the parameters to the arch_crash_
   handle_hotplug_event() to hp_action and cpu.
 - Introduce KEXEC_CRASH_HP_INVALID_CPU definition, per Baoquan.
 - Per Sourabh Jain, renamed and repurposed CRASH_HOTPLUG_ELFCOREHDR_SZ
   to CONFIG_CRASH_MAX_MEMORY_RANGES, mirroring kexec-tools change
   by David Hildebrand. Folded this patch into the x86
   kexec_file_load support patch.

v7: 13apr2022
 https://lkml.org/lkml/2022/4/13/850
 - Resolved parameter usage to crash_hotplug_handler(), per Baoquan.

v6: 1apr2022
 https://lkml.org/lkml/2022/4/1/1203
 - Reword commit messages and some comment cleanup per Baoquan.
 - Changed elf_index to elfcorehdr_index for clarity.
 - Minor code changes per Baoquan.

v5: 3mar2022
 https://lkml.org/lkml/2022/3/3/674
 - Reworded description of CRASH_HOTPLUG_ELFCOREHDR_SZ, per
   David Hildenbrand.
 - Refactored slightly a few patches per Baoquan recommendation.

v4: 9feb2022
 https://lkml.org/lkml/2022/2/9/1406
 - Refactored patches per Baoquan suggestsions.
 - A few corrections, per Baoquan.

v3: 10jan2022
 https://lkml.org/lkml/2022/1/10/1212
 - Rebasing per Baoquan He request.
 - Changed memory notifier per David Hildenbrand.
 - Providing example kexec userspace change in cover letter.

RFC v2: 7dec2021
 https://lkml.org/lkml/2021/12/7/1088
 - Acting upon Baoquan He suggestion of removing elfcorehdr from
   the purgatory list of segments, removed purgatory code from
   patchset, and it is signficiantly simpler now.

RFC v1: 18nov2021
 https://lkml.org/lkml/2021/11/18/845
 - working patchset demonstrating kernel handling of hotplug
   updates to x86 elfcorehdr for kexec_file_load

RFC: 14dec2020
 https://lkml.org/lkml/2020/12/14/532
 - proposed concept of allowing kernel to handle hotplug update
   of elfcorehdr
---


Eric DeVolder (7):
  crash: move crash_prepare_elf64_headers()
  crash: prototype change for crash_prepare_elf64_headers()
  crash: add generic infrastructure for crash hotplug support
  kexec: exclude elfcorehdr from the segment digest
  kexec: exclude hot remove cpu from elfcorehdr notes
  crash: memory and cpu hotplug sysfs attributes
  x86/crash: add x86 crash hotplug support

 .../admin-guide/mm/memory-hotplug.rst         |   8 +
 Documentation/core-api/cpu_hotplug.rst        |  18 ++
 arch/arm64/kernel/machine_kexec_file.c        |   6 +-
 arch/powerpc/kexec/file_load_64.c             |   2 +-
 arch/riscv/kernel/elf_kexec.c                 |   7 +-
 arch/x86/Kconfig                              |  12 +
 arch/x86/include/asm/kexec.h                  |  15 ++
 arch/x86/kernel/crash.c                       | 114 +++++++-
 drivers/base/cpu.c                            |  14 +
 drivers/base/memory.c                         |  13 +
 include/linux/crash_core.h                    |   8 +
 include/linux/kexec.h                         |  27 +-
 kernel/crash_core.c                           | 255 ++++++++++++++++++
 kernel/kexec_file.c                           | 105 +-------
 14 files changed, 492 insertions(+), 112 deletions(-)

-- 
2.31.1

