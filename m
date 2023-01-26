Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6061A67D79A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 22:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbjAZVUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 16:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjAZVUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 16:20:35 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE7871674;
        Thu, 26 Jan 2023 13:20:33 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QIT3tb027854;
        Thu, 26 Jan 2023 21:20:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=xYGJgK5V+S4CbMGoIAoVVCX9Xegp1AkqI6gEIqQxV1g=;
 b=vpQm3Y1z6NaoiIpY8ia9VxMJHXjbARmDfWWJfa1z6bvN5gBOewgD7FUai5tyN0opLuLK
 M4A0dsLcRekPCXKUF9ogzlLoOeTc6qXwA6RInxQPq8X+/j59K6TLAu0AMykQk0r9YU/x
 sRCUh6wATqns9E/LoyB75xwMvVWhDnwiN6hEKvjU2Z03ffoZk5D2kVi/IhGRB5yAe6v/
 F97urDPWKhDj8ot/ZiYtYxi5H9lNw9sxb/wGGnkajxHJQvAz4hN8d49yGJ08fRufkDtP
 7Q9Sl9T1rY+URXGq4Ns/AqdetUBswnC+1yUO4XkLmNL8lR36YuqtdnZA8a6CQkFt8IbH Og== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n88ku3ckf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 21:20:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30QLGv8F034586;
        Thu, 26 Jan 2023 21:20:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g8rqvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 21:20:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UsQ+ynmaMNgrKWxI3YOHNsWIDIUsyHnPVPQ3dNCvf36Mj6B+n0qu1qEXFN0KcLTfQQdRT80PvHBusq3VFG9E4dqJZC1VztT+PEQIceYMgBEl4Wz1L9CX1pf/58g71CuOdWKgDNSZoJcakE5CI24DsixkAC6T+K3uDG6PP5uWgvIAkrzD3xTNNM0Ths7WO5mVYN5Chlx4STPvke6LtQbVI3tz9BGFcAUGSfOlqfiXnu7usqMZATux/z/m5EjU9/b6nfFkoFoUJU9E2TpEFhsZjhl5QkZ+Na/XPRUuvrKbNl81N1VLxSCR3RFcuiX/xmjpRxZt2N1MrDSArRcek4QBjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYGJgK5V+S4CbMGoIAoVVCX9Xegp1AkqI6gEIqQxV1g=;
 b=B51p2o4pjNVE3iTtcQu0GRT1xecYg3u78gCNtK/E7QgXBsL8+KigLgjUooj+TXhQYZMi/uG7JbyWSPTpKpIHCkYQQE9zX5Hh2nCvd4+fJqpCqSRmkfUl8v5usj9BmhfMQg2/ZS9lTGZEtjfSrGAmEZiKXpNESgTtuf2h8iPMLx5FLqTeucdfrdXgwk04dpVfIB4CN9A+7cBwXi2aU9Q9j1Qp00EfTV5D0HwvVZJtKvPsHLU/9+xiVj2WmUrhvqvbfA24ogaMnO7sRFIbzhJsBFuFRZkF6pkv22Pixy5KiFld7kHT7Ze2/4BXiFUhLSBoQVawe4goTNq/6Nea+SvvcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYGJgK5V+S4CbMGoIAoVVCX9Xegp1AkqI6gEIqQxV1g=;
 b=eA6l+lBKDrNYhycfQ8Dc5W+jOPZQWfuG2he1WjXo7yq4yRh95XYkcdWgvHjdyBK3YxU5yEBdXfWeuE4qhCjvnctyAIqpnLbOHAvizbyoXrn79BIyFxbiQKNb5xrf2spdLJxjiXcbI51SaE13ljwQVn7Qy5OdEZG3D4YAgzW0sRU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA0PR10MB6700.namprd10.prod.outlook.com (2603:10b6:208:440::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.20; Thu, 26 Jan
 2023 21:20:18 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.017; Thu, 26 Jan 2023
 21:20:18 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-next@vger.kernel.org
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Sanan Hasanov <sanan.hasanov@Knights.ucf.edu>
Subject: [PATCH] mm/mremap: Fix vma iterator initialization
Date:   Thu, 26 Jan 2023 16:20:11 -0500
Message-Id: <20230126212011.980350-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0350.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::20) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA0PR10MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: e57bb7cf-b9e6-4434-7a69-08daffe31feb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TnxPEx2qAWXS3YvNJ87xTkxCkDPww3/ZQ8extswalN0/abyVkHEeJDPeEmTu/dPrZw6yNLw84SZnCC0VelguNx5lCBH19np4ZbE7aJZ9KuQFBCuJgF9b+aetIZZVvOjp3pmGPUn/WsramQFxEun8kerpoF5g3P5tUccp9PD96OzUDe+FdjvjnZneH7S8T9+t3YPWOHRGOk87YzsRzLEv4X2DzoINKa1w5F3crHNkRVAFLTxIE1WynB8n7CgPrgfSCxvxUUiFFAWvnGyRJPNOTYlkd+0NNK7f/uAGqJk6cOROfZq40sxLWcRNiw/G3Q9X8+K3RA1yXD6X5xj9Gx0OQRomMBfgDUjhRcocyTKMqkMzmeTUrJ85+pO4hY6xLvrsu2sxxoc5IbMwMuIFI9+bUpADBmgHcHIqoCtDHLbCz0WNoun8EUSBcdMyhODK8J4b9QGKVy8Tc3C2efmsSNh5eSIBjrWo79GWO0OisU65Azk/te4RNsVkj3vwskvjiNWnmUG3FmroHYdH+yxzC8V8wwXApruzTEGi/qWTk+CPWwkgbmVWlPqGreJEWuxoj171zxkAiGe4h48swE0XK0utqNNWfcCx5uGe0okBrr4DvQPGurTl3VEF/ASBfBfywEfCWnRu6q4vII+G41LXSuciWrjj1FhuLcCfiDpqY620USeigJvhlAlIzEwM/TMVE7ZM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(366004)(346002)(136003)(376002)(451199018)(5660300002)(8936002)(4326008)(8676002)(83380400001)(41300700001)(86362001)(36756003)(38100700002)(2906002)(66476007)(6486002)(478600001)(966005)(45080400002)(1076003)(2616005)(26005)(186003)(6512007)(6506007)(316002)(6666004)(54906003)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BVnGrspNkO6KFaPY0URJQETwR9fWlmR0l2sO3Gh8vFidVQD1MKm894vcybfG?=
 =?us-ascii?Q?jHq6YCjMIccXyP/bNn39XD25cHgE2joYA84LAp7bSkbikcKblCGa63UIOnab?=
 =?us-ascii?Q?edjLLRBP0pZZgcpUT7Bmm96hbOYWZMHrgjRvHzMcLz6047Y+L7QHliKaEdo6?=
 =?us-ascii?Q?T488BEKT6UvJKog3LS1QjBkmjzsh2lIwiyFNKoT7wXuy5rQuPZpV2+afPMQF?=
 =?us-ascii?Q?QFmbjGaNqCshUE/2TrN3xR/UVt7k3JLenZO/d0+pvd844V/nu1NpeHYn0y7T?=
 =?us-ascii?Q?M8MFFksgX6uETExPlNdvX0ujd7E4bZWArOaAduhXi64EXHLqW53XfR501ZmT?=
 =?us-ascii?Q?6MiY1gWJoMz9VYBvCX+K9uYVi+SmR2T/+JUy7DvLzN7YDNoifMu6D+smnezl?=
 =?us-ascii?Q?yokwHhiwC61RKcNgfKjnNUaGc+AITBd0JhQdXr+PoNenaATpGHiLVMTKhcGa?=
 =?us-ascii?Q?FMBpB8zsrJJcYfF33aiNckn18C4hHw11jnuSGjpVWqzwmLohE9qGo7kxCKAs?=
 =?us-ascii?Q?rgbkOjIFqOd+7r3Wr40ST8q3vZI4CBdqmS/4LZc/aWX0OAyii/WVgjQ0HXpM?=
 =?us-ascii?Q?6p8IA1to/O1XlgJ+mZqwuQQ5DXOGW3PP5Bkdj6GfR7F0yrYLKX+TfuDlWmSr?=
 =?us-ascii?Q?hHq+W+dbp2X7qgbPJvTOrHDuykkfeU+7s4COttRAqt6MD/gLfkgLCU2dDFgt?=
 =?us-ascii?Q?bfPO4LAJMXSSs4WE/IQGUW5hp1lgNORQJjoadPsNod0Ql6afrREC+Yb6Bjdq?=
 =?us-ascii?Q?WXdAriHPGuJ+AKmFEK5CQYTQ38dQi1gh1rd4RlXgup9vSw0yYe0w1PHvROMr?=
 =?us-ascii?Q?6AI9d9Kg1Z4KFIvieP9gzEfJeAbAaeSbOEHV03oRyGVPRw11JmW7U8NY4PxT?=
 =?us-ascii?Q?wtwmDC9Q12iB1J0CeSoOL2kY5C0kAsieSds9kf8sAqsMiybWR40Hco7byACA?=
 =?us-ascii?Q?Esd3kur7QoUm2tsqY3HZGMScb5YxYKy5n1Bv4zWeZ71z07PkXoX10tOtKCUj?=
 =?us-ascii?Q?zYrRZfAvaPdWPsc01qpJ/9/NSRiLnCmXtF8yOSjkPGdRjmemFbjRWoKXA6Do?=
 =?us-ascii?Q?UxDDV7fKXEM3jaER4wCJUz04MnAODpxvB3RGIO9RejShjlblLWAyy4IWMMrG?=
 =?us-ascii?Q?A9a/nFT0159X6aSMsk6yVMnGEV0cf6LqGUi3z9V43siZb96aG9cigbgxPfwT?=
 =?us-ascii?Q?RElE2tb84kEPnZ6L/n4vizm/bOrPZ72CwkIRE2zBdz0vT7GQNEwf1fJbF9wG?=
 =?us-ascii?Q?1VDBPE4utEIqLU0OB3f56Fw8vo5U6p4ZdWf+0K8ncjfhD4MJaOF6OVNAmqBG?=
 =?us-ascii?Q?bZ2ZaN24G2TLYOZVBi3gml9D05FNk1ZCUK34gd2/Gn+WrxVS/P8NowWuNQJT?=
 =?us-ascii?Q?sQu3MinFkaZrZM6bqRrYcX10A7fJtVSvTeKMr/xz8eKHC2UequKLQrSvABPh?=
 =?us-ascii?Q?aOQWcu1Cd0vYUfJOcp5j4XMmrtCrqrtI80+cKgifbPuI1WDrHAE0ctCNyl9q?=
 =?us-ascii?Q?dzpYpMRIlXmVC3+0LTm3ExnTaw3HNABEfhaqcVagvesMr6Jc8f1wkVgkec+U?=
 =?us-ascii?Q?4U7LmfWS4JraUjlipSQlWhUoPMNZiAPmtbGgFX5NTLkFWYTIdG4AmzQoHgYb?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?tx1HJD/akxi3rzfkuA2ZAUrZfbjCuckgJIIY+GOlJb94IlP5S4/grPDCJ1jR?=
 =?us-ascii?Q?nnq7SSLYey5abOn6Gb1TgSzcT+mIZurgy0EO93bSdZOy0d1XpIRzwZ8K8H9o?=
 =?us-ascii?Q?xKMB0c6wNS343CS029olhHmi9wWy72Fuc6FFbgVnBp9lf8YN7G+z3O+4IYJq?=
 =?us-ascii?Q?+oyGpCaphkzQsWjnB/G+oH/AGVIOkrGk/kvk2UZwBPeGj+1y6EMQY1d1UaDz?=
 =?us-ascii?Q?uj04m7qCYN6cwbDWYvPew47j/7DWlwNQtD5sdTq9p+7GR0hA+bW+Y2RUOJh5?=
 =?us-ascii?Q?CWNnu8V4CGx9R+cRjjGSaAX1my4/kMTECyoZjvPbh5BMOyXNgg71yk7LE7S1?=
 =?us-ascii?Q?PiEu6glxB6nVGO2XDRfvrlFtz1eMLkmRFQEf5icplYmkqqUgUmTpJ1ygPIUT?=
 =?us-ascii?Q?T2GSCQtSzC/vq6nmD/SfXCPiIdu3aVuRgBz/o5qw/OkyMAwIlX8NyEX34y4d?=
 =?us-ascii?Q?I9kseKmU8BE71sne30NxNDjgPOnQ6UixI6DKdMTu/eGAK4egpNlDVCHOvFDE?=
 =?us-ascii?Q?Mc1RnSyvSFHmEYZEsZh8Ph0IIucsBA/vFfTWvlfRilxmQkG9S/Jd/vfs2R4k?=
 =?us-ascii?Q?OJbdOSsLUzO4ScGZy033Nz8ICsgHziOkeDDI83OHFON5h5Mw4F4yTYCTMFgP?=
 =?us-ascii?Q?QafINDveit7HSyhxMuKJaUIA/w3HrPew5mBak+2gFHBl6dF1SkAC524LaYav?=
 =?us-ascii?Q?G8j6Lw5urM0KfwjkM7g73CFYVI/7f4permqpLpLQOiYLQx6P5kBlet+yiNFx?=
 =?us-ascii?Q?07M6NA1iNcHa3NaebHYRWO6RnJBqTZLUVehgI4B+zDU5smdOTU79g01kS+hI?=
 =?us-ascii?Q?zt/PXh1n49pVP1FXHT6hiYtbOIgWvWifa4m5LzYuUAI903ocFSqvbV8t2usX?=
 =?us-ascii?Q?KSFN3YI2eq0LPWY8T54kcK3+OBXWn28N+esZ8X5tkw3trTcmVWcfXOL40yi/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e57bb7cf-b9e6-4434-7a69-08daffe31feb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 21:20:18.6093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WbBbnWB0toPaoDg4TZBM7AXNi3Dh4/E9sbjSh+psdkucGh1/lBw4LwZGRxQEzHvi+haIqEsa+kBvGT4H5yW7PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6700
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_09,2023-01-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301260200
X-Proofpoint-GUID: cPedkfnc8sOapKlBlgN6XanfQElnGq7j
X-Proofpoint-ORIG-GUID: cPedkfnc8sOapKlBlgN6XanfQElnGq7j
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vma iterator location is incorrect when there is a failure in the
move_vma() function which alters the address being modified.

Delay the initialization of the vma iterator until the address is
stable.

Reported-by: Sanan Hasanov <sanan.hasanov@Knights.ucf.edu>
Link: https://lore.kernel.org/linux-mm/IA1PR07MB98306BC0F55667A760EABE91ABCE9@IA1PR07MB9830.namprd07.prod.outlook.com/
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mremap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Andrew,

This can be placed next to ("mm: change munmap splitting order and
move_vma()") and squashed before sending upstream.

diff --git a/mm/mremap.c b/mm/mremap.c
index 1bc81afd90de..6c7f49ab7d19 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -585,7 +585,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	unsigned long hiwater_vm;
 	int err = 0;
 	bool need_rmap_locks;
-	VMA_ITERATOR(vmi, mm, old_addr);
+	struct vma_iterator vmi;
 
 	/*
 	 * We'd prefer to avoid failure later on in do_munmap:
@@ -701,6 +701,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		return new_addr;
 	}
 
+	vma_iter_init(&vmi, mm, old_addr);
 	if (do_vmi_munmap(&vmi, mm, old_addr, old_len, uf_unmap, false) < 0) {
 		/* OOM: unable to split vma, just get accounts right */
 		if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP))
-- 
2.39.0

