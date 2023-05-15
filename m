Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B29703E95
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245176AbjEOUXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244443AbjEOUXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:23:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06D830D2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 13:23:46 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FJsVm8010018;
        Mon, 15 May 2023 20:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=2qYx1OO4Yfm7gpICVfncdHnXFLErpaA9v2GIGLdh12w=;
 b=xk4+gSYEVnShnyWHOjYZ2YhqBstJjkDbPyD4QQVu6huIx2oA+bgbFrYPjYcnvcRz+j9i
 a+9EuHttvHRzjcSaFGQsLKNzABaLoCaUrzPOYqI4WtpvP+o+fVu9JSFKjrTR2j14e70e
 eXESjPgydrBLPqWyBijrk+J3VJ9C7ez/AQy7aoKp+29GFESSfuuD+mVhObJhSlZQ8mYi
 L4lML4amfJbcEJXO9Mkm/ujGAxZ15QHPMM3UQrWl8mDgbka+ZjTVjaXeN//c9FLk9bdK
 CuXSD2s4sbLOOxxBKEptc711nyr7Uoe8wpbMVUsJmvzDnrsReltlOn3twNt+4XIPcvC4 mw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2eb0tct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 20:23:31 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34FKM6pB036943;
        Mon, 15 May 2023 20:23:30 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj109dxnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 20:23:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+IDBrxyzlu39/QGrciqseLaqx/7DevoXMLCWDWbzhRYI5N1T/pNZ8Y+PfG9s8QfxsjU3vy8ZB89XlJzbZzVQ8c2C+GiG7EfO9dXa7JxljyglnGugtgk5jNbvgX3iy0x0EVFu95MAaVtEAUmSK+v9okbDZU3SC+y3II4/hj/pvwmib86pX37igmuhLxh/seDrGXQ2uOKKrxjT7CqmGDIJU+rSf7MuHowSB/lZDQd35g/DrLQ/kP0+15vTLEqYpchbz4s0osEIy9A1bSV9e2PvALCInuOjSuLE6w1p7lXbHmxG0cmur00OXUnHG63Dk8K6IfcnOWjF0JSas/Oi6cPBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qYx1OO4Yfm7gpICVfncdHnXFLErpaA9v2GIGLdh12w=;
 b=j7hZ3pJzgBPYLtFdx4jXOhgu8XODelcStD/aZx6/aPhtzxe1azlW0JDcxMlErhZaSO8GSPSVF4yG9k3W7BMVV5gS5kAIJ3lPhlVXIFCec+K1F72gvd6EFQIZT8yiGKio9O0LIogHc8MIEzYRQppbanpysqPY117BxJrtswV9IwpyusDrH9/ZVkyJVewvUDjFbV1VY/WKaT43l7BZe5sdMpIKYDuZFbC3kE/lBfFUGmIRDD20KSbUYomDys7h+HEnrqsYdukqsY+RSRVZvCLqRBrXg24Djxwi1u8f1Jjc6OWMugNcTyl6skJuxpJnfrdZlSVs4inkj5gXKhEH3vL0vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qYx1OO4Yfm7gpICVfncdHnXFLErpaA9v2GIGLdh12w=;
 b=esLcGDfZnD8vrzJNVI/NdtHNBx4zp0qVu9z8HOVj4pzvzZ3JsdZi6DBHfuV25YXbfH3bs+gIf+ZXQnc4dksBJozKK00yGteKzADGfJh4wTe2+yB8bPiDWnEhoyCofke1Ge60/ByvClY9D45yoTkddwis6prob+iSHCbmQCyV6WU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB5821.namprd10.prod.outlook.com (2603:10b6:806:232::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 20:23:20 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 20:23:19 +0000
Date:   Mon, 15 May 2023 16:23:17 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2] mm: userfaultfd: avoid passing an invalid range to
 vma_merge()
Message-ID: <20230515202317.xgc6yogq7kieckp4@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
References: <20230515193232.67552-1-lstoakes@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515193232.67552-1-lstoakes@gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::14) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA1PR10MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b5ef021-9d8a-4e44-037e-08db55823935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6exqf8cy+aSqXDMrF6UF9ZcUJz8Xz/ynjBYFC/Xv0OmXnQQSWoLs1vVul1mXBN4/DbEavGd9udcHJncq3anGHxuz/a1VZZpdnV8a8tC7xZ3UeShJSwrgHOTpMlVNd9OsJZ1Iv8bmOmddCUR18LzYrZYdBIXdSRrJiJd4VZvi4K9dz1QVQdRb7g+IWfzW4b6kuT0bcZOkj6oexmFjiIKrsowit7LaAzQkXjReEB5Q0fKtBKbEAmsjE55SNVCiz4Pz2yTXcGb1azVitcI+IItI/NFAXxtooJ+fkFVjdxpz+Vx7dwX67bkCfOb39Kwh9QutRTQPfSqd5VFRLUEx4v9LFP8uppWxxIOYfy4wX9Lop+8b0RFLVMqhqKM/NzhRxnTaAGkk4iFdcM6dg+xXXi25ezmVBSNuq0zdBqiPUeMs9VY5u52k7sFqxaA7ok1Qxk99Jr5VqXBm4RJZ3WEJGY2KdaxU+HQpNzlUaU6L7SdCGa5cE8VPsF2GyZSw98bIduXMxMpPKsIO5DOCfsjl5/s/zZSeQx/h0EtdZOr7u8b57Xs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199021)(54906003)(478600001)(8676002)(8936002)(5660300002)(2906002)(86362001)(33716001)(6916009)(66556008)(66476007)(4326008)(66946007)(316002)(41300700001)(38100700002)(966005)(186003)(9686003)(1076003)(6512007)(83380400001)(6506007)(26005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2D3hYDJdVGzb5Q5uQeJjUhr0cqfELqqhLKkoNI0rTn3AbrxMcjMmPlxdUP+B?=
 =?us-ascii?Q?0cUbp8a5zu0Chqv20LbTFYfNZUDyNzuQQVMTl4sh8Y1DlLL6XcH+h/PMzcyK?=
 =?us-ascii?Q?l1Vdy2gxS0mPlBtfMRcPrp7UquW6Rb6M/iOpwBbG/FSXAUcbzoxbtZUTqq+p?=
 =?us-ascii?Q?f/754dhbuYMtv4w5VRB8XR5EDGSJZIVwc1zrjNG/baQ+vckK5AsCPRSfS0Ja?=
 =?us-ascii?Q?HUXo58NQS3/mnu9G1dL+gva4tbnfyM9FuD9wF5TnsPMiWCSI+id8e2IxhmPY?=
 =?us-ascii?Q?zbUd4cD6/vb+hXsCfJyT6mihq3EuB1USvQQJ9jftNUlsdg8fnGrP8Pw7HT0d?=
 =?us-ascii?Q?dW+BvuEv1NbtCp+OEgQGTiLwzaVqzI1WLojMgvvo9Tjv4rHtVTyusL4SIF83?=
 =?us-ascii?Q?0WOlePa/GeEvQijDgU57alh/n3RYOldhI+UGJCdmlo8KiiH9ouzyjquZiL01?=
 =?us-ascii?Q?fKfeuZ5jBr+szplY15+nYysT0NLJ7o3rsT54Bq4l8Wzxa+KTu6FvbquiMtsL?=
 =?us-ascii?Q?nWk0f0Pro0QkbNNUA+W9doVDo23Rov4cceNFw0itAV2Xyzbk8IK2OvMtQMub?=
 =?us-ascii?Q?Lk/Ph/bziPDi/JSt2c1oEkO1T4wpGPFUIF/s86GJQdchtDmPT0Brec+MFr3V?=
 =?us-ascii?Q?Pc6aPBwjHj4rT/ftDfro4svbrgoD4vV1HJ+xfBaC+R8H/puENhul6Sf1f8TT?=
 =?us-ascii?Q?c69KR53xakyr/WXcBWIXpdlVs82eXZbhNEklgo8uIQQEQTNLmLRWtqojT9VI?=
 =?us-ascii?Q?OVh9cHDVYlFPYSaHVuy2BA9arhsREz+zHPNAEuJkoOSc/8s/aIoJHZcKQNos?=
 =?us-ascii?Q?aPhT5I6oXYdScjXmlv1fUFpcwM9hKLyUEMCemOi5cKj34p8nmu8ddRi/6CPN?=
 =?us-ascii?Q?KOMVy7E5PmyiZTFrNI53eioN2p/fo74WggYhCnUVwiiZso5aGyYqefldXzGm?=
 =?us-ascii?Q?mnywS7RRTfANsQjgl0UiMzTHB+0mGsFmse2yBu8LqIfIuPMjqtGoO9wFTvRn?=
 =?us-ascii?Q?8LDhYvclI0788vZTA2SdHdMwJV4HFoiyU9qS90B3/9OINOO/zJTR6icMAWYO?=
 =?us-ascii?Q?DlOr9ZLtakjfYyDIH+mYN4Ngc0PAsi3+SkgL/V82dNpoJajzeoX7pFbWS21p?=
 =?us-ascii?Q?+7sBA/i9/PyLLrl32ZeKdbqKViVTRI0e7IWrfkQeY2wTpWlb7uAQBbEzbCkd?=
 =?us-ascii?Q?vjRBL8+9i0pRpOmGmO/E+BLO04bt9uXMQJMX5SaNzhtg7AJkwq3RK4lbFkG2?=
 =?us-ascii?Q?XId1dLtwwSu7uqobxblinD+k4rABvuWbDqlHvB0gcHLghbtmSKXYCGMmjxb7?=
 =?us-ascii?Q?s7ZddMdxrRABet6uvRURE4iwSgqKXB52v+r2AaeKwzYfvyZ/XPX7gn4TVclp?=
 =?us-ascii?Q?tcxkjTlRAFXsiVpowR2EWd3fSuAC/AdCpp190/Onsvx4DBLIrGmM86k7H1v0?=
 =?us-ascii?Q?eCyKptZJy+lKpnr37m82isgxwVLWNhqdt3D7IqFToqAI9F+dJupjjYy4vRS1?=
 =?us-ascii?Q?FYZk08nEF1vrcOkgM6Xm3EpocTxMr1sGoB6kr59KiFlzSd1XktiWSKs0uT7N?=
 =?us-ascii?Q?ou6yZV1kzib8l04n/YBb/t0CO5gIlnSBjXj+iHaPKhPz7XCYSaoOK+xlDUFc?=
 =?us-ascii?Q?yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?muabDbAE32T5ynhafI8NVVLSveFyHFJ9N9AzL32KxsLAH4Nk25C0Af2NWtoN?=
 =?us-ascii?Q?TqG0XyLTtXhfsDWqmxLz4pOQPyGVK/1g/yS0LQyxRncFiCzRFKcdxp3ABoj6?=
 =?us-ascii?Q?6FkUW15mt4yGJOB+LvRfEMlX+/u/D0wtm0MUVrhv5jDO4BJjyp4+we5iHSCE?=
 =?us-ascii?Q?dN5jHC0+hJXiP9fw/X1GKZO2OmJ23l/5yIksYoH0s7l1tIqcBonPPOtBvolq?=
 =?us-ascii?Q?fskq+shHkJaE9St+QAX/3zUMu9brB71doJnkMkedhRmrem85/WbD/uFh+xtE?=
 =?us-ascii?Q?if1oYVUbGJr52n7LBra30AcKxNNtcxev+rXX8JnRgigr+WnCyZO/VahTgFd3?=
 =?us-ascii?Q?l0gsneWMY1vaMXuja0v2TQ2i5NsY+K0lfqss1z0T9DXx1ZnIk7NxTFQuRlQG?=
 =?us-ascii?Q?i74lg91aHWqcWQ/j26e7/A7bTSu2mu5jEbNg7GyD0kEsynHjXf2Stvursv+X?=
 =?us-ascii?Q?2O6b91aPs42SAjTGNMhByG8Aaz92u9wArAKCnAGftr6MrYnPESUzojAk9xIH?=
 =?us-ascii?Q?MdqgU0veCIWEPOoIDMDmv+jYTtIIRaCwi7e+vpXGpvDdVWYNPowYPHVyaDg3?=
 =?us-ascii?Q?SHayockHh28g9Bk6MLrm0byzpHNuhQ3bxhZKMSvwRZxOkbHrNekMxACGulWo?=
 =?us-ascii?Q?QksiMEc3qILsOCIBzG+Yl2szvS/VtlPGpwq7LGD1Jz2Rfkt4t8DUPycVt9Ah?=
 =?us-ascii?Q?eL5CU4AEMo/OHu7ujxrKucZ3LrAmLa4HA881flTxrAUaqfrRS43WnEgdRAOc?=
 =?us-ascii?Q?1L+MvYAYieeANiAF4AEPQTsuA+9eA949+R9ysL7lyDJhqMGqvYO+n5V6D3Fb?=
 =?us-ascii?Q?ORi2sW1XgeWuki4nZPBjLPc2JeKtGQd2alk6z7I9/bFqb061X7C2edOIvQCk?=
 =?us-ascii?Q?W6xuJS9FSlJlQQiZXEglzyPOagAvQJ23uqMLri54bUL1Fp/lxuDW00IxDob9?=
 =?us-ascii?Q?mePfeTpCzFh8fQiiHTxycGVXLZp7biv0RBIlQrLIEnEVtDiRJa6rSkDbAwCm?=
 =?us-ascii?Q?orrF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5ef021-9d8a-4e44-037e-08db55823935
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 20:23:19.9031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WsRKkWFlyylMwr0SzrX9FdjLs6raLA3tXHiMgsn6qZ0wT9smgRgM1kLIAvGDJzpBuvaJD3FhXjpmNwbDllsEbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5821
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_18,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=318 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150169
X-Proofpoint-GUID: yME0vDpwkV39I6jFtOvBmiiEM3qxZ5TY
X-Proofpoint-ORIG-GUID: yME0vDpwkV39I6jFtOvBmiiEM3qxZ5TY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Lorenzo Stoakes <lstoakes@gmail.com> [230515 15:32]:
> The userfaultfd_[un]register() functions will knowingly pass an invalid
> address range to vma_merge(), then rely on it failing to merge to indicate
> that the VMA should be split into a valid one.
> 
> This is not something that should be relied upon, as vma_merge() implicitly
> assumes in cases 5-8 that curr->vm_start == addr. This is now enforced
> since commit b0729ae0ae67 ("mm/mmap/vma_merge: explicitly assign res, vma,
> extend invariants") with an explicit VM_WARN_ON() check.
> 
> Since commit 29417d292bd0 ("mm/mmap/vma_merge: always check invariants")
> this check is performed unconditionally, which caused this assert to arise
> in tests performed by Mark [1].
> 
> This patch fixes the issue by performing the split operations before
> attempting to merge VMAs in both instances. The problematic operation is
> splitting the start of the VMA since we were clamping to the end of the VMA
> in any case, however it is useful to group both of the split operations
> together to avoid egregious goto's and to abstract the code between the
> functions.
> 
> As well as fixing the repro described in [1] this also continues to pass
> uffd unit tests.
> 
> [1]:https://lore.kernel.org/all/ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com
> 
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Closes: https://lore.kernel.org/all/ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com/
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  fs/userfaultfd.c | 108 ++++++++++++++++++++++++++---------------------
>  1 file changed, 60 insertions(+), 48 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 0fd96d6e39ce..ef5d667ea804 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1319,6 +1319,32 @@ static __always_inline int validate_range(struct mm_struct *mm,
>  	return 0;
>  }
>  
> +static int clamp_range(struct vma_iterator *vmi, struct vm_area_struct *vma,
> +		       unsigned long start, unsigned long end, bool *can_merge)
> +{
> +	int ret;
> +	bool merge = true;
> +
> +	/* The range must always be clamped to the start of a VMA. */
> +	if (vma->vm_start < start) {
> +		ret = split_vma(vmi, vma, start, 1);
> +		if (ret)
> +			return ret;
> +
> +		merge = false;
> +	}
> +
> +	/* It must also be clamped to the end of a VMA. */
> +	if (vma->vm_end > end) {
> +		ret = split_vma(vmi, vma, end, 0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	*can_merge = merge;
> +	return 0;
> +}
> +
>  static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  				unsigned long arg)
>  {
> @@ -1330,7 +1356,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  	unsigned long vm_flags, new_flags;
>  	bool found;
>  	bool basic_ioctls;
> -	unsigned long start, end, vma_end;
> +	unsigned long start, end;
>  	struct vma_iterator vmi;
>  
>  	user_uffdio_register = (struct uffdio_register __user *) arg;
> @@ -1462,6 +1488,8 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  
>  	ret = 0;
>  	for_each_vma_range(vmi, vma, end) {
> +		bool can_merge;
> +
>  		cond_resched();
>  
>  		BUG_ON(!vma_can_userfault(vma, vm_flags));
> @@ -1477,32 +1505,22 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  		    (vma->vm_flags & vm_flags) == vm_flags)
>  			goto skip;
>  
> -		if (vma->vm_start > start)
> -			start = vma->vm_start;
> -		vma_end = min(end, vma->vm_end);
> +		ret = clamp_range(&vmi, vma, start, end, &can_merge);
> +		if (ret)
> +			break;
>  
>  		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
> -		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
> -				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
> -				 vma_policy(vma),
> -				 ((struct vm_userfaultfd_ctx){ ctx }),
> -				 anon_vma_name(vma));
> -		if (prev) {
> +		if (can_merge) {
> +			prev = vma_merge(&vmi, mm, prev, vma->vm_start, vma->vm_end, new_flags,
> +					 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
> +					 vma_policy(vma),
> +					 ((struct vm_userfaultfd_ctx){ ctx }),
> +					 anon_vma_name(vma));
> +
>  			/* vma_merge() invalidated the mas */
> -			vma = prev;
> -			goto next;
> -		}
> -		if (vma->vm_start < start) {
> -			ret = split_vma(&vmi, vma, start, 1);
> -			if (ret)
> -				break;
> -		}
> -		if (vma->vm_end > end) {
> -			ret = split_vma(&vmi, vma, end, 0);
> -			if (ret)
> -				break;
> +			if (prev)
> +				vma = prev;
>  		}
> -	next:
>  		/*
>  		 * In the vma_merge() successful mprotect-like case 8:
>  		 * the next vma was merged into the current one and
> @@ -1560,7 +1578,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  	struct uffdio_range uffdio_unregister;
>  	unsigned long new_flags;
>  	bool found;
> -	unsigned long start, end, vma_end;
> +	unsigned long start, end;
>  	const void __user *buf = (void __user *)arg;
>  	struct vma_iterator vmi;
>  
> @@ -1627,6 +1645,8 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  	prev = vma_prev(&vmi);
>  	ret = 0;
>  	for_each_vma_range(vmi, vma, end) {
> +		bool can_merge;
> +
>  		cond_resched();
>  
>  		BUG_ON(!vma_can_userfault(vma, vma->vm_flags));
> @@ -1640,9 +1660,9 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  
>  		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
>  
> -		if (vma->vm_start > start)
> -			start = vma->vm_start;
> -		vma_end = min(end, vma->vm_end);
> +		ret = clamp_range(&vmi, vma, start, end, &can_merge);
> +		if (ret)
> +			break;
>  
>  		if (userfaultfd_missing(vma)) {
>  			/*
> @@ -1652,35 +1672,27 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  			 * UFFDIO_WAKE explicitly.
>  			 */
>  			struct userfaultfd_wake_range range;
> -			range.start = start;
> -			range.len = vma_end - start;
> +			range.start = vma->vm_start;
> +			range.len = vma->vm_end - vma->vm_start;
>  			wake_userfault(vma->vm_userfaultfd_ctx.ctx, &range);
>  		}
>  
>  		/* Reset ptes for the whole vma range if wr-protected */
>  		if (userfaultfd_wp(vma))
> -			uffd_wp_range(vma, start, vma_end - start, false);
> +			uffd_wp_range(vma, vma->vm_start,
> +				      vma->vm_end - vma->vm_start, false);
>  
>  		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
> -		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
> -				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
> -				 vma_policy(vma),
> -				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
> -		if (prev) {
> -			vma = prev;
> -			goto next;
> -		}
> -		if (vma->vm_start < start) {
> -			ret = split_vma(&vmi, vma, start, 1);
> -			if (ret)
> -				break;
> -		}
> -		if (vma->vm_end > end) {
> -			ret = split_vma(&vmi, vma, end, 0);
> -			if (ret)
> -				break;
> +		if (can_merge) {
> +			prev = vma_merge(&vmi, mm, prev, vma->vm_start,
> +					 vma->vm_end, new_flags, vma->anon_vma,
> +					 vma->vm_file, vma->vm_pgoff,
> +					 vma_policy(vma),
> +					 NULL_VM_UFFD_CTX, anon_vma_name(vma));
> +			/* vma_merge() invalidated the mas */
> +			if (prev)
> +				vma = prev;
>  		}
> -	next:
>  		/*
>  		 * In the vma_merge() successful mprotect-like case 8:
>  		 * the next vma was merged into the current one and
> -- 
> 2.40.1
> 
