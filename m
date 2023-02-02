Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E285688AC4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 00:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjBBX0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 18:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbjBBXZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:25:46 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA0C6F232
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 15:25:44 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312IDr6M023684;
        Thu, 2 Feb 2023 23:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=/IMIKf/zhloX496mHLKG4jtUZBOTiObn8MpfjmHwPfQ=;
 b=C2owgRbY/dgXbQytKCfwY2YjBKw/AEv8FgjmSZtnykxiwGOMb36OtZJg1QO4FLuHY4v7
 YHUt0qMJAmz3C+nvJCMXsfUhtJ99fJISGb6W6pKPNT1lN3a55ER3qSu+QaKszTyAlTix
 BaD5CFQekUAN2CKAoUYgK6YuiaYBrsY2NV0h+ipGSiwRQ5qCII8JjIa+hvgfzavwu6Td
 6KlG9TqpqjaLYjQiLIEZu7CY3K/uhzIysUb05VQo87Kl3ncrGCueY3N3JqmXaAb0Gg+R
 OF0voIAmckg9LkOGwWi4zDottJcobRFqCLXaOx8yGoksGygyhLJprUS/DVUzDvdJOtBl RA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfq28v5w0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Feb 2023 23:25:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 312LJZvA030056;
        Thu, 2 Feb 2023 23:25:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct59hc8d-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Feb 2023 23:25:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAgLNrG/mriX5DHvutBJkF181J+RZoCPaRz264bo2xR3gQK9r8KhrMfv18euDuPwYTgyMiaVx/Xo84yUiL5tC499yfY9fcI70CnJZlmeXhoJjTmoimeYuufoPQHF5MJaN2e3IrMRHDJOavwoLrZW1qy6MO1lhk7jrtrr5YOCIhcGzxghmQNrM6SQ3F3PRb94n7oJL2JSi0rJ1Ob1fWZZ9H2X9apR/ipGA1lvCieizIKMCS7JA/7pEHT/+65gz/tukz/HjHdu5zxMtTwOfzySs42A8HA53dm2VSy/ax4cxf2SFjGUOtdhGuH9AB21m4lCliCN1YiQwfWl9xZ6oum+xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IMIKf/zhloX496mHLKG4jtUZBOTiObn8MpfjmHwPfQ=;
 b=lHJyVUzDfRZHGEQTfmambaxvHx3Bx+MCpJqUtqH1zFKWcp/Wk+OdL25EHxAgUvB7V5bPlgNUukuDRHJwy9N+jk1J0Ci9ZQPczkysQnIF0f0eBpyebSC4JZboMzU7YgXuy7jC9zlsLDZzsrcBnsUECwqjUVabFJcEeZ82Trq4NmsMFOC9Pko98yQcR5G31wQLCOD/Jd9Xrw6yiBVwwL410VK+BpmTUX6lm+cDBY4oPkmBAH/y3qTKaAfNxjGH9b4UCl0nk4b8zJJ+v9gVd7KK4G+vylHaXvfS/G3qzm9qv1+nDSddcal7zn00Bz5e5g7hHazRywejzzaKAIvQGjYKBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IMIKf/zhloX496mHLKG4jtUZBOTiObn8MpfjmHwPfQ=;
 b=Qzt6CX8sx4bD3MijN+Q0Jf4tOQM1klqY9UBmn8ghH2T2ZBpkAypd2lmKzyDyhkTk3gvDG/pTY4NXwe2jieRNoKWixlMQ65de4wSv0zpYJHXlP8H8VhR6l0wLPb8vzJKQG8LOD6Yn9UpPajX13NbKdcvAZgYXzXAqFPCBtr7x4YA=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 SN7PR10MB6643.namprd10.prod.outlook.com (2603:10b6:806:2ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Thu, 2 Feb
 2023 23:25:31 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f%5]) with mapi id 15.20.6086.008; Thu, 2 Feb 2023
 23:25:31 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, torvalds@linux-foundation.org,
        konrad.wilk@oracle.com, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH v11 5/8] fork: allow kernel code to call copy_process
Date:   Thu,  2 Feb 2023 17:25:14 -0600
Message-Id: <20230202232517.8695-6-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230202232517.8695-1-michael.christie@oracle.com>
References: <20230202232517.8695-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR19CA0001.namprd19.prod.outlook.com
 (2603:10b6:610:4d::11) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|SN7PR10MB6643:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d034da1-be06-469f-d339-08db0574c699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pkXJm1Vt665lyDBaXI0CH7EB4UvC0bzW/N+QfqDDOnI4sirx4I5+EZVq5tqVxUVi7lsWXHelBhyJBW+R33MFAQ0mGJuBZXai7UGsq3zJALCMS3GtGYRGuarEz31kbqdQZ0Ka4VwMVLyQj8NBn9B812770oCJbp7ZYkgXFaUtVnDczye3iL47X+v5HKafGmox7Ud+dHX1RADmkwye1nAVgTZAG2NPc15wTHOs/6v/SoqbtZ0KkQi5rTNAE7d1C9UnXpe6ywYyNxhhWgD93Nr3V6OJFIcTn92hLZsdWriiiWl+gVE1hJo+yE48LgvsPFWiRLdn9iW0+2WXlzsJ4nMqYPV30GslJ3k5Bd1/9Zy2iaJS/+eOFx0+4jZgPKhvFr2Gc6w8tJq/NQFNrJcya2oAKRgNLuRdDHBsxGgDnSkylPHcQrC6pdcG3Wal9xz6hjbWEU1Q2+mARajiMhKB5wadG9D8BbiQfWz2QDAEWMlQBwVVwCYkrUAVvdxyfqJxpl9wfFRdU6bMMVlP06svFdxzc/yXjIaiCjqZPY90RA5vAjpcgjFY3jIsU4zcMpI4M7bzIXAVktd8SrS1C8MFmOgCepL/w5C7d4TAjYYSKKs/DsOhmjV/5wj3eo0ew+2lSgylcobU64SvHVZuNVWIdSTabUpz4WHmWt4qhXd90miMLoVh3g/h2YafIlLwybexcpeq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199018)(2906002)(38100700002)(36756003)(83380400001)(316002)(6666004)(107886003)(186003)(6506007)(26005)(6486002)(8676002)(478600001)(6512007)(66556008)(4326008)(921005)(8936002)(41300700001)(7416002)(5660300002)(86362001)(1076003)(66476007)(66946007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Eg2P6bqjmRmWGaSvr8m8o/fMJ+W85Q7pRosRUp9FSQXSU/Ag9SA+/yie4c1U?=
 =?us-ascii?Q?y8fvPF210CeGs75yitNyTV7rMLYyE6BU4kfYMAbbpGjL/WKOYO/rLciGuX2s?=
 =?us-ascii?Q?xUP9J9xnOl15Gk5wg9DwaHP4FMT/s9cZ1JsID1NWe3rqfyg+caZm1GPLr19S?=
 =?us-ascii?Q?aA13jDlJkP4dqCpvT+U4h5AvDiJwr7+ZM1i70oFgsQAeqXYVU/nvvZT5bXeD?=
 =?us-ascii?Q?50/yeJKZIhpboCOfdms+wXm00x44vgwkPthmLHY47TdzBAmnsZ4HtfJECYON?=
 =?us-ascii?Q?aFKN/aL3ItkW0J02nIHylrfRlztFcxkc7pWWWEEXjP6ZpSUp8Jw4PxgaoPM4?=
 =?us-ascii?Q?iJhRBfmOUizVkqdgFwcNp97CCchpcIeYvJhhMpwJEslqYgsEZgWsVO6JuQmO?=
 =?us-ascii?Q?0zATnmMR4ego+zJE8VMbSLMomgjsrDie8z3M0VY3uXDuVx2HeoIJ6uUc1kPB?=
 =?us-ascii?Q?Ydr3ws+dNfrFYeXLlyAbB4GD15EprBdKg3GlSIoj8BJX0toSy8t9J+YvUVEB?=
 =?us-ascii?Q?cASEYNgrvG2A9CgmDHyl8ooxCkDDsMTd5owPH8onSDo4EwFypSBxBKYMAakA?=
 =?us-ascii?Q?y6Ef2hRiLMFcGb1ButN9vgyoYM2FqRfaFUOdfwj4bMPYcadspNbgrsGMKjk4?=
 =?us-ascii?Q?zZ7kLFF9x8Fxif39eC9NE/j+IDJjce8OtNlyEp+qCbC0/4ySjnQ10x2Sn1X+?=
 =?us-ascii?Q?2pmQW2MqNmZcNG3oSrLy27c+DnWrWcdQjIAao1Aqk8opn0n+LaTq06HzHLdf?=
 =?us-ascii?Q?KAJTcMG/k0RO/WA2x0oiOZjqD3bkiSmC9f5IhLiJjxTLklrw1HtTCwjiXDdt?=
 =?us-ascii?Q?4bGy/OoMzxnDxo6wSs0ivHox/kaRfF/djaUSucWUUcfqj8iUu1NoIJiagCiw?=
 =?us-ascii?Q?Qt0l2FesbG1wrNAWmU2bHBXDc8IC+vGasBIBlPrjAs3kb8S7vmwcgU+fRqMa?=
 =?us-ascii?Q?L90OAXQeOSJPUK1jPes39vf18t1o/Sir+hmkxIotZz90WoSB9ohscOrvL19P?=
 =?us-ascii?Q?iAoDonnsqj/KSMyyaDvp/5VRKyiOb5TuprFsG+kmfAlhbgMxW48XeVUJsiVY?=
 =?us-ascii?Q?a5V3WtK8p6gS/CYpkZyzt19fpR4OiDWZxqW9On2W0/tT0jA+ICJkwCgZfC5g?=
 =?us-ascii?Q?0btw4CDUz/ibA7G1raY2y46OhnHDPddjzhe2ogqxfp5kUnsto+27/Q1GGNiN?=
 =?us-ascii?Q?8ACJkb7VTxF3mPn+wgs7xutbJ7OvGjCYFh3axVtE8MQkyOYghx0nCoJKajbf?=
 =?us-ascii?Q?jwDmlqUANMrpzZ/tBwCtmhGmWtwga4INHzYUR3PIAcb5gAlMJXZDt3oTJyBq?=
 =?us-ascii?Q?pDeThxHeVg6FjO575SF6iZRVziIf8Ik9XUisnJ1voBc5rJWS4hItIXyB60hv?=
 =?us-ascii?Q?hrUGZ6+H4Czu60EZYU4sR/asF39n1IzAguEr8caikD99lxcRt5bpunN1uRLU?=
 =?us-ascii?Q?N44AfsneSWm1G7NBXF3yEJqnsykgf1c5uPPuluoDr6hfsRlVP8ANc88zxUjO?=
 =?us-ascii?Q?Ot83tLL9gqfpXew/EydpEIDYnmF73c6c7NQKV/ABEEd2pw5LivkYj0eukMKi?=
 =?us-ascii?Q?YP1jzh5t8Nmm4Q0hyD/6N1RWfsCEa9zx9ryATY5lAT3cym+2GwKK44y3a8ru?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?/faJr23uKovUeKDC4eWJT8DE8Ewndk9zNAlCh6JPHuGT+Sam5bf0zCYysKr9?=
 =?us-ascii?Q?yhHN2La4pLwyOHvvXHIBafHmpP/e+75FYNzQyWnAzW2YNk8dNBcKB5v5kzDA?=
 =?us-ascii?Q?4qIj8CYQHzw8Ci4MwwPxhMKffYRBb4VI3TmU7CWwUER166xu1iOsBPKO5Wcr?=
 =?us-ascii?Q?39qWkgvkPfYoFqxGN/IgMFCq7j5WP6fhJ/G58ZkTfnkhDnkAQAceB5nn5ERc?=
 =?us-ascii?Q?oo+BEpNgMd5wzbtcoGYE8fO4ltN/ZviFm/twqsbdDzlmvPGeMKyS7kYRqC0d?=
 =?us-ascii?Q?nLX4Ez8LUCtXqbaevP3Bt587gHVJQ/FG0W2TUxOTwwLy5wv5GmgxPVHOeWfW?=
 =?us-ascii?Q?05b5F3Y0lYj/S16WZRGGO8Fu1HdpGP+jaBEF1mEGRHoIcvslXxbDQsKzAu/D?=
 =?us-ascii?Q?saalyhwoGpYGf6bFl0RPytJGjSbAqhUClJAnl0hqC403/rbUsPARPWh/Fm7I?=
 =?us-ascii?Q?cWSNWOnnTzP91RNXFeooFXCiPy1bMXN8w+nzkY6+ELsOGoDEdzt1zc6bo9pf?=
 =?us-ascii?Q?kn01egoAz16P4Xx/CW+sMQHw2h2Ln0KPH9gNQoSY115sTie6b+exe8j7EPbO?=
 =?us-ascii?Q?GZwM9/RNtCPcVS/W0HExlZtCwbQ8+tAccPkZ6r1lE192RobT59hwcNjE8Ci1?=
 =?us-ascii?Q?cxRhmlXEmqgXW2pmJLkORUq232heCtQOx+oRaxe3jMeeDVSqoL+wR+nyA1XP?=
 =?us-ascii?Q?tZ7L13YZvF8PRoRnq298Bz6GehCCEZz4jGSg6ZwtZOJ2GZ9Gc9zhZEXVcYuH?=
 =?us-ascii?Q?g5VTWLHXa5YAAcrMJDIdMr57WJ84wC9aAuqs6FvI8B/2bUJD+KIIzbB7TxXv?=
 =?us-ascii?Q?u+Kh2CKxkvZnC/b6kF37bRFbtjXrDw605fum9UAz+aFHJ2NOq8RjR7uncbce?=
 =?us-ascii?Q?fI0cxyrTau75q+wQ8BGBxw3KduozrumMhrBcX/tK0FDODgRrQAnU0Z9NStIC?=
 =?us-ascii?Q?/1SNWt0LYTFRsISYDVV4yFoX2a0nDSrncDndyGHeRj0mNID2sffqvVhgudAS?=
 =?us-ascii?Q?rhRxJU5+GvzMq20JUOD6FxbXtw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d034da1-be06-469f-d339-08db0574c699
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 23:25:31.0934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +uOhydBg374Iy0QHL6caLo4vhpdjsIDCAXW0KhW5qSd66U/SjbqgNh3b45Lr6PVBxbagj7lkeXY/Bn9uvVSlr2Z3xDFVv5kVeTxq5U7UaUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6643
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_14,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302020207
X-Proofpoint-GUID: QrRq2FfXAoWO5pXDZ44IDfC5wEbc0ZvM
X-Proofpoint-ORIG-GUID: QrRq2FfXAoWO5pXDZ44IDfC5wEbc0ZvM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The next patch adds helpers like create_io_thread, but for use by the
vhost layer. There are several functions, so they are in their own file
instead of cluttering up fork.c. This patch allows that new file to
call copy_process.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/sched/task.h | 2 ++
 kernel/fork.c              | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index ce6240a006cf..b0e43a1fd21d 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -94,6 +94,8 @@ extern void exit_files(struct task_struct *);
 extern void exit_itimers(struct task_struct *);
 
 extern pid_t kernel_clone(struct kernel_clone_args *kargs);
+struct task_struct *copy_process(struct pid *pid, int trace, int node,
+				 struct kernel_clone_args *args);
 struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node);
 struct task_struct *fork_idle(int);
 extern pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
diff --git a/kernel/fork.c b/kernel/fork.c
index 55c77de45271..93e545b08205 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2013,7 +2013,7 @@ static void rv_task_fork(struct task_struct *p)
  * parts of the process environment (as per the clone
  * flags). The actual kick-off is left to the caller.
  */
-static __latent_entropy struct task_struct *copy_process(
+__latent_entropy struct task_struct *copy_process(
 					struct pid *pid,
 					int trace,
 					int node,
-- 
2.25.1

