Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B77F6F5F24
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 21:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjECTcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 15:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjECTcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 15:32:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EE57AA0
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 12:32:02 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343HomnJ017464;
        Wed, 3 May 2023 19:31:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=xcIeBINQRNHRxvcz2Oan0QNui+BXXVeoXn13xbr4IgM=;
 b=z9dbs7QsyBAmCjtilh7V1Yzxi/pyKasJ2jU/tyrHnKXn89VKlmqM+tjDS4vgQOS5g+Nn
 Zlczc3d2TDoY66lrbgHBv8KDZ6Cu5098vMT8rYY1UPGsDs++oBAzi27uQLl3psxI3vC+
 /v9PFbN7jBjTu0bo6edpcla1AeY1X2qrdAomqubVrBNmZhIo3ehIvdWPOUKxY9tfXsIf
 bYE2WW44OPyitcG+CQdJLXGD5dxLVhD4JmTP7HpP06a3rUVG3m6YojM5lNtlIKxLhXGq
 /HfzMZDq7p//cSlFQFCFLr5WTm09OjpETYZbaeXmOqM9YvELMm74eR92gy0Q9xtqamKv Yw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u4ar33n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 19:31:55 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343JOhpo020756;
        Wed, 3 May 2023 19:31:55 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp7j4uf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 19:31:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuoqjmmmGoH4ICk1kO6vmSs/ZU+8fGMPkoLTDtmKXtmXFJEFRGFRF0Ss7I/yoOT2QqReRDjaSX9Mr5Y6Tfa2heyCYYd2L8inc0a1c4xKFCZx06B8Qvod1ZVWb9ij457AYCL6d1ZWYhH/lCNJJ4qi16A9Zfia6cNDKhoEiyLB5YXxNl29p2oCzx5lgbWIbywW/6HmhYVCl4o5dpbAyaGReElkmTHjfxsyZX6iN9uSNN5EkAA+3h/vuG7DD1OTKvU2PMQoDgbpM2DmD5loTUY7nJMbauvJW+6zQMvkLh0Od+VNmEmyrFj+p+jrIdQwegSqGbIwy6RfqNUVanFUXkzI5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcIeBINQRNHRxvcz2Oan0QNui+BXXVeoXn13xbr4IgM=;
 b=QUfPq2TlKROTDC7nsSCGkN5HCLKkmk3YFQOK6oXcWs2xhxo9XgZJE8XkWCrJZCWvq+REX0i8HUq2GHh4Kqw4zfmeheOyekUITOrxZMikz1c0k9GgoVxg6zYPYstQUNAP51BdWtCcri3Spbex+7o23S/3t7ltxdNwk0QneZF8Xkjso9G0XdBR4AFsao4cc828anBEBMKequmDnzeMZRYxPSAAHZ7aYm5NsjG9TquZowB7a/o6rKM4RrJkBwKYjbRZqDJTdA3D8aaLvjCc7AsfaG3y5AesOeYAHNZ8NEy2UGsCBuPJoCKr1O7KHC3TzR1bsS5qAM8LjUbosOEAdcsbjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcIeBINQRNHRxvcz2Oan0QNui+BXXVeoXn13xbr4IgM=;
 b=Xf31ZboVZSQUU0/GwZep+5L2Zrsw9Tgf/T/qudVFxKBc4hMj9V8Peg2OY0BVpPCFTK6kLcLyVNiA6KkeOsT3EJpuc2/HlwFZ4oNjdS8iMK/pvjYqVwk+K2u8qnov5U8zjjCfupAVjQwb3qk8diwcaiFJE9EXTKVssNGhlo/oC80=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by SA2PR10MB4730.namprd10.prod.outlook.com (2603:10b6:806:117::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.20; Wed, 3 May
 2023 19:31:53 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::7fc1:adad:b2d5:a1aa]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::7fc1:adad:b2d5:a1aa%7]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 19:31:53 +0000
Date:   Wed, 3 May 2023 15:31:50 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH 10/34] maple_tree: Use MAS_BUG_ON() when setting a leaf
 node as a parent
Message-ID: <20230503193150.ey6zx3wgxycssewe@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
 <20230425140955.3834476-11-Liam.Howlett@oracle.com>
 <20230428120822.26aaa9c8@meshulam.tesarici.cz>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230428120822.26aaa9c8@meshulam.tesarici.cz>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0132.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::16) To BL0PR10MB3011.namprd10.prod.outlook.com
 (2603:10b6:208:7e::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR10MB3011:EE_|SA2PR10MB4730:EE_
X-MS-Office365-Filtering-Correlation-Id: 78077189-a40c-4614-3082-08db4c0d0c5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ai73aqmWpkR3mlH+oxKy2pVnebiVln4FvFVSHgUOcmKmpsb5quBA/96eQM0DaciGsysx94AsttwUDAD8t91w11rYJk+g2LMOxKtFzpeY3LDDRqxNSzsCTao2w2sCxgkeKowUU6ZQD7wln0HkNuUlqmLLAu8VCWKqWdzrtqI8ogrClz7NTjYP8HttHkPeNC1qWvmDarYdWgtZ01vtpfxGmpD2fn+6jcKkwlYdQq2a+nLVCnZ1KhJA7T2RdqYhMOb6F0VI1sUItFA2YzZpRKIKTzJvcfJ9GC6VY9U/kiJJAKrh1ooSuLY0rkUspEl8JkXEmvkkl6xSXoV85uJx6a3SEQ/WIelcKyVVTclGLiRsi4cmSoMS91FFdWBS7OGyYotYKwlzPno9xGUEPnCXDoPFziZJY7l8txa5qLaiNOpwx+hnHc9eaGtHNPvGFJTBILcOs6wgdCwD6ydltXlKSYtEjwiTpkSCSZP+KRldGO3VBU2bBMvBjPp7moxq3ZraB5LeW1dfNu5htX/TAJUK7tWCtkrSc2VFWGZ4TRL+L6lF5tXtdJjqpcEDhOPGoWmBG422
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199021)(41300700001)(8936002)(8676002)(5660300002)(2906002)(86362001)(38100700002)(6486002)(558084003)(186003)(478600001)(9686003)(6512007)(6506007)(1076003)(26005)(66556008)(66476007)(6916009)(4326008)(33716001)(66946007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1pRK0tXdVBzQk5aMkN6K0FzbVBQM1NuaHFZTDVRSWVseHJKakxVcGVaT1dh?=
 =?utf-8?B?ajQ1YlpHcXFjK0xhWWhlVXdCMDdVV0hQVWtVY2lJKzhvUGcxTGpkaW9aRnJx?=
 =?utf-8?B?WDZaVUFVNnpRc3RmdWxvSFZxMDM4cXMzUXYwdVVrVVBURlh2VVRiRnY1TFBs?=
 =?utf-8?B?R0I5VTkyTERDQXZFWGxwNmdMWHBkRmtnYUNxd2xTUG9UQ3lSRkZTdDBCMFpp?=
 =?utf-8?B?R0F4SFlmZUplWm96bmxMdHZkUDN5bG1taUZualQvWUxGYVp6MnhaSnZOTy9l?=
 =?utf-8?B?RXpnOU9vcUd6bTN2V3l4YnhaeUcxeStMY1p6bENucjJHaDNRWUljbURUZzZH?=
 =?utf-8?B?K2lUNkRxWWZYMi9RdVAwZnhFN0RTUWVNY0lWaFYvVG1ndmFHdE4xTkNnZ0la?=
 =?utf-8?B?SjBVZnJ4VUFRUWRocDJWYjY0Ymdjc2lzSUo2b2YyNUF5VCs5d2dWbzVOdzVu?=
 =?utf-8?B?Z290Ni9kMXBtMGs4KzM5WUhVZEpYMWJvOTF4bG5UVU9GdFJ6VTNLdDVrUWJs?=
 =?utf-8?B?czh2WlJiMmNxTTJMMCtSd25ORHNjYVZIdnFGZGZWcXVBWVpuZkNqSVp5TXZG?=
 =?utf-8?B?REFQcXZ6TDJ3WlZiYWJEYmZwNTVNZVhPelIwYVlkZlliVDFmVisxNjkzc0Zt?=
 =?utf-8?B?NFFFNGFzczFsZmxTNWwyd2d3djRUUTVzcUtLaFdMNzFGYVhhd0RzMjZXL2tN?=
 =?utf-8?B?VmRYNlNhUjlsaVNBZXRudkYyem1oNzhpQnBNdGgwSi96MllrZTRFTFJ1b3g1?=
 =?utf-8?B?RzlkQUUvUjVRMzdJTEdTcTRMRG0yNHFhZzljUEtaVkRpcSthWGoxdWliYXAw?=
 =?utf-8?B?UlBPeVFYd2NyZ2pmL2tPMVozMTlYMnZqMTdSVmJ1djJ6MFhuUnBpYTgrYjNX?=
 =?utf-8?B?MjJxc0FwS1N5cHdQVFJNQ1psOWZoamZEU2piQzBvbUE0Tytqb3RNV3E5NEE3?=
 =?utf-8?B?czJGM0QxSGoxTkhNc0dzc2xWSHQ2blErTi9YM2RBZkVId0ZLeUhUdnlkeWpq?=
 =?utf-8?B?bFJNWDlvd1l4aUNwYlBsb3pKb2VHVUUrL01uTTh2K0JBdlhJNWhQQml3WE85?=
 =?utf-8?B?dFJ0ZmVXWERBV20zRzJhWkJjRmlXSEhzMzlaSVN3bkRzL0dEdmxGZ2VlbXZR?=
 =?utf-8?B?UHM1ZlBRbVg5Z2pGVWpNZWhBMjZIRVZQNnBKMytSQnhtQUFwRWNncm83NnRM?=
 =?utf-8?B?eVBVOWNjWFlJcjQ4M3VVU242SittTUFmbXhyZkttZVpWZjFnK1BQQUl0N3ZV?=
 =?utf-8?B?RnZDSWR5Q1NYZHMzNnY5UnZZOG1xVXNFTEU5V2RRV21WUmxXSTNtSWd0dzBr?=
 =?utf-8?B?ZkN1QWRUWThuS1hRNHcraThML3doZkpkNEhYQk1LZVloSjBBdTN2RktIaHFS?=
 =?utf-8?B?OXdaK1N3TkFmSDcvSkVrUmJSb3NNTEdlQ2FLNDVZKzFGR3BSNUFuU2RHOGlO?=
 =?utf-8?B?eFdvY0VIeG90Tjc2ZEVpenZDaWwwdk82SG9uV0o0enJMS0NEcDg0Z0lmN2Rv?=
 =?utf-8?B?ZzB2d2E0TjVnMmMwZ1J2TWczVndmTGFCZEVpSE1RYnZucUxpTGM2R0J4QlFa?=
 =?utf-8?B?ZGl4c0NkYXlOMmpNcXo3cUZyYU0vZjk0bHAwYlhFd0lxaENReHE0bHI1ai81?=
 =?utf-8?B?VnRCcGx0dllVdVBsNmtVSFdyS2JrZWtaODlZZVB1bjNHQkNCWmVyWFhUVnZQ?=
 =?utf-8?B?QnNWclh0VWt4bldmakNZcU9ISnN1Y2VLL0NQdlNQbmU2R3dxd1JzYVBkb2Nq?=
 =?utf-8?B?cTlBME5rREJjRGxCRVlHcW81ZG5QTnozN3IxQnZCVkduRjNtdUU0N2U0QlpX?=
 =?utf-8?B?cFZtZ0RuR2xJS3o2eFExZWdXZ25ZNDhiNW9hM1dFT1hva3hOWGlaT2d0MzND?=
 =?utf-8?B?OTZPRlEzSkxRY0JNSExHTHNWMnZ1NE5lclFicU5iTUVVcEtLUUI5NmJWbHV6?=
 =?utf-8?B?TnkwelFQdTQ4U2ErRVNGUmo3RzJxTlB5ckp4MUlsT1pjSjYwaW5JeXVQV1BD?=
 =?utf-8?B?MVdZQ01wKytvN0sweFZrYzg5ODJkV2N6YlNEY3BVTWFJOFcxSUVzaFFBMmcv?=
 =?utf-8?B?b2dtUHBXcEJEYTlIYzJEVUNxVS9UN2d3amZzUXI3KzQwOU9WVGdyN1VvOFhq?=
 =?utf-8?B?S1J3WGhWZHptOGFqM0NSN0tETStNa3JhZkNTRk1vSGwrK0ZJeVNPMGNTbVFu?=
 =?utf-8?B?QlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SVwHCd9xTWq6rX0Qr5L/MRA4NDV1+JZVymrDfFUwf6fkJSbLuiXSGL9S0FA3e4h57KEmc033yd4DwvJ2Hw6JJIF6ByvjHXwnyqhdR30h39qCDuoU8z/o68ojSDexjMLxrXAfa6TZQees+CdtIt0CIgREG0yXqflbUu4MDy9SWXVM95NyoXPzILHcLQWfmtoMQ7ca55Wx8iOFjKKoWcK50Mf1QkY3yHW/gd+S2d8hOXIeZplpZ4vxzcxCdhiSDypQ3U0QCoXkcw+CtkEsYvsCIaUwvGeJk6eCpNZdmGP5YbGVRbGK3DCrG1BnYbfoDoYDyJXtU02yewdkNP/g5ZPL392Ssx0CYJSqW5gavvAtSejH4LCfKsGxjc1IcRv86Iuh7qIt95SrqI7oVZWvHtFbYZ18phRVWMqotMrTwAUV5Vc5IuL4Zi4ghDhSJ5fHLGLkwIjqPhxWY8tEkNEMjTbK7AVcKseB4yAUTQX3w5Ertu0CKXtkugjW1INJG46Y2r6SNvPzLMND/aWInGEofi1NPopf3IrY7wV8vuN8L56PXtSuXaZz84zixC4vYCJEsW1dzm9pTeARqBnZwlkRYiBS7jlqMDjxEfiqQuH7eVWSEp7+Y23BOzJDKp5UXOazdrmHliWLOH8bn6+v4oP2j86YMGI4Gzmfcy9xBjmnoTBDO2M/HuKrPt32BnrjKNGu4DX/OU5fv/S0FicpU1Ni8+9XGqywiCuxzxgBdgTuvRLwDTUY7XuIxVQBcCqsx1+6WMkI9LKan9pSWPV9DmquwXh+lTXALf8WTBTvIR0r5NiFNC7zdRpWFmxrUSSnlV5Z5zElhukVpRaXN2JT/e/R+8sgUfyyfC4IcuEUK7zGFoJCib7KKbxb3aQzeJWCKQEw7IVb3K2WbDpEZ13mHRIuNbdnOlgAGzo1sxHKaGQigaoHiiI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78077189-a40c-4614-3082-08db4c0d0c5b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 19:31:53.0173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LR7Boj1DRuDKeO95DF32jRMYWMMTKVus+DwslZ2Y5KxWL53JcQ8uGgtjEW0S6iIu+FWtxO5FOkcPpYNN7s5lyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4730
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_14,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=704 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305030168
X-Proofpoint-GUID: 0ej--5A0i0x_JpINuhBkRh3hzCRE5h_1
X-Proofpoint-ORIG-GUID: 0ej--5A0i0x_JpINuhBkRh3hzCRE5h_1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> [230428 06:08]:
> On Tue, 25 Apr 2023 10:09:31 -0400
> "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
>=20
> > Use MAS_BUG_ON() to dump the maple state and tree in the unlikely even
>                                                                     ^^^^
> nitpick: event

Thanks, I will fix this in v2.

>=20
> Petr T
>=20
