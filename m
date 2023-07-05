Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D3E748F46
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 22:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbjGEUrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 16:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234011AbjGEUrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 16:47:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008CF1BD0
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 13:46:53 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365J9vLI026809;
        Wed, 5 Jul 2023 20:46:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=wQU+MyD7DjF4JJXbXJR2AI426KUXBGMgInzNd4BM6hs=;
 b=e5n1gCK5Il056w+XEUlFYjIxXwLXX99in5zSIZLLn+++n1EqQbp8UkO4gkNkHM0V7ghZ
 WnQPf5VhjFMcGO9W+Bznlj+oj7t4eO8K5PwPBo1HhRWReVu1/NwbaoKjVGKoCcoDvxcX
 zzDJa3PAJ2RfZNc8tZHfMmqUKdXBhNplqVbbbnQHrS1T/XJNXna9+pxxGTKyQScuHeLk
 CkxJdmViD+YzzjmIUu2rmk1hWb3IEpP6u+llzFOug42d4vkKW6xzGb973uBMpwgiAUqZ
 q3lFreyA4q1+6ue9NE7I5npW1K3eG7ilcBLV26wqypZoSi8DEmVCKeDB0wTnX8JUmqu+ FA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjcpufd00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jul 2023 20:46:35 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 365KkD8Z013525;
        Wed, 5 Jul 2023 20:46:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak64dww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jul 2023 20:46:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3g+RnT0ad02AJNceuV3J4CxsDQ6171oxfhdM5svvHn4IZBKR+O2BuNlI9uRM247zTlOK3ifpYp1moTaE99FNpvW3vRHRY4k6KVoqh2Q0E1fdjQVy3Ij2AvwHVCP0vxqDTNedAbkmILTlK8Uw0628B+eK4YgaCzZzB4m3UWgeC+Nx9GsKpoLsO8oZc3MHIpIq+nYKgyub2DcabtxagfcY2f+f2DApVtW2u+a8NkH0sUm1N868SHzJyEwtj6+VgBPLCHu+Xye6FyiFaKrEirpk4bguLxZ+IWwHF50mK4JRqWXPEBT6kx7oGFfY0sSEfPfEFGo74v4leSUEZrNNjmb6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQU+MyD7DjF4JJXbXJR2AI426KUXBGMgInzNd4BM6hs=;
 b=LTt4bvePqNgmVLVwRVQ9scb+9+YdRIIEdDH7Bq1UbYg+bt9HmL6S3a7qczXyobtYjm9VLBLNz/2vR0KhOM+N1K60p9BFISoDIRf+o9C3aZ3YX9oZ8e/TXvlr80vaEPOHfb5wn4ri3pp9hGE1vWIOzgJWy1If2wbcpYHeYy7XWdycm6lpm1tF/g6ImuXB6oke/rf9ReY7y5zr3YEEuAgaoUaA56EA6N/kjpXMBnn16Rg0m1k/gdiw4/8+/4nJrYwOQWOBuZIrgPM+/+z0e97/8jx8jGW9Y2LuTFC3kmBwewGymxL979tr9ZjxqpcZCHdX4OQKrbs/s/r1XCZqRjSW1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQU+MyD7DjF4JJXbXJR2AI426KUXBGMgInzNd4BM6hs=;
 b=eQjA98OW1OIuoWklifRfX+hroXVIi+gITCuYF4sN2jY+t22utRwXaLVgP0PUVdhKKBlhBocV7cbHaF0osLVK2h29DdKSF6Fz/qrZFW/8nIBwV2Sx3FKlhS1zfzsxXFs4xYk9JvRYQOBbPeHmrtSEKDHjzOhCeSnxsywH3ddvhf0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6285.namprd10.prod.outlook.com (2603:10b6:806:26f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 20:46:31 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 20:46:31 +0000
Date:   Wed, 5 Jul 2023 16:46:29 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oliver Sang <oliver.sang@intel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH] mm/mmap: Clean up validate_mm() calls
Message-ID: <20230705204629.clctvnx4qdqoexyp@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oliver Sang <oliver.sang@intel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <CAHk-=wjUp5+tcsHG89ieuwa0wUtSWWBWRt8xOsoZ1nskZbbk-g@mail.gmail.com>
 <20230704184752.6lwrytfirr4huu34@revolver>
Content-Type: multipart/mixed; boundary="qfieyirchnpfqrjg"
Content-Disposition: inline
In-Reply-To: <20230704184752.6lwrytfirr4huu34@revolver>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: MN2PR16CA0040.namprd16.prod.outlook.com
 (2603:10b6:208:234::9) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB6285:EE_
X-MS-Office365-Filtering-Correlation-Id: 93ded773-d329-42c5-9975-08db7d98e9d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y9Em+Xl4V/ckmFYqrSyf++ReH3RI8xe8iv4G6l40k8z2PtY9NttiS+KdiHxEenWGooRk3y9NhilK9tQpj2yybbmRzQiYoKpLOulxkN9q4CrWsIi6NmlBGzPDaUu6dOZAMh+s3au2qnNw5+aXH5zOhv4guZImk2PPPR28PsDiQ6W6PIpDubngXgUpG4pKQqkeYLl3sRqqc0Kh0hApcIb9kvAJ9y3mTbGZQYyk6EXpszeO+Rmnn52cbOXAlO/e3Yk3DugSOoxpDXXU2uuU19OqXoyfme2PMv23D/uBeZM9/iqWL4DwGxQ1XN3X80ACuj8jY4GyNbGlYK5WF3oWMzPi7kPS2uPKffycRaX9Ctz3PCGHmYRaGWu3fJt/f4+K2NyCdfAgXOjFS8MKJhz0kal8hk8SksfCZc1vE1yvhWrx0Ntu2fGN1bFE1JI8AyYBHh4rHsU9QVIeIAJFv81rk6qgpgGoGu+8J9mX7JyIeklFvhU3TVFJ/NgY3N3stgjHYH/9GgYq0tvvT0ySEbQLE9zMiPg1vXra4Lnzq6LNnFlYU+zkg6OXbeDbxJD7wXNqQjZpzR6HODTEdfSg8OGdZnIk4TIRaUUuY73nKStHamhUGBe9kd57lCXfBQxQDDMaUQJl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199021)(6486002)(41300700001)(86362001)(38100700002)(33716001)(44144004)(83380400001)(6506007)(1076003)(26005)(6512007)(110136005)(9686003)(478600001)(316002)(66476007)(66556008)(66946007)(8676002)(8936002)(186003)(2906002)(235185007)(5660300002)(15650500001)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1vW+1Jq3Y0YcPsW3gdTD37XJ327EQnCX0pBjMfAeTwIMXl4dPync5gJ7B6ky?=
 =?us-ascii?Q?ue1zmXlaaxeWG30u1Hc2X5Gst6BlfSi3Wlrygx7KDwxwaxWcfme9aKPPvWWI?=
 =?us-ascii?Q?HrVRbV4gywEdVdkbXRBHQuXE28zA2R2QOw2k0+p5YI3rgETEKPoO7fzMHUsU?=
 =?us-ascii?Q?f0eL4xBqZqYpAzPDg+XgT4vFAQV+SK2YV2y+irGM3Jt7xy4RrMQ5YEmqQIik?=
 =?us-ascii?Q?7YZiG7p5PUc8EwFcjH1fXYfjnlpC+x25Nr5PG9p6x8ZEq4fCzIZwht0pB1oB?=
 =?us-ascii?Q?RTVXbdSk2K2qn2owd7scBt90rdLPk86CgXgowR8Puw8JF+fvV4M26hKDdI+S?=
 =?us-ascii?Q?PTyi1odcL7IHBXghylzx2ckTZVS1hIthHPK6VzGCexlH8YwpmEHMv7ZHEqWZ?=
 =?us-ascii?Q?0mBLgAE/3zLo52c1O1ereI4jjMdQIkkuZIjoMuFVSTJrKe25HV83KzteqVp1?=
 =?us-ascii?Q?6pu/9gBi1nlj/mnVeeB4e2er9o4v9e+T878q4ZQJQMYlDW6LXOuRGdlmKUYV?=
 =?us-ascii?Q?VMWsVIJdmkzeQxLHbkDiuW1xEiosyAVGWIzk3xaDVqNnvJ8UMlLa5aFv2CsP?=
 =?us-ascii?Q?M1GKPDJ6I5gNfrAVsMqsGBp5dl9n/lwvoRg5KyzB3hPrz5vPlGGPJLC8YfEW?=
 =?us-ascii?Q?UPvOg9TNGZD1iDZydK1qvOv4zjQuv/zheWhqezs3wVRhJMC5uBF3KIspgYgL?=
 =?us-ascii?Q?4T9N/C/6WUZi0uHDS2c8T1+TMM5vlLms5ABvwAP5lQG365MhXYsVRQfrbRoU?=
 =?us-ascii?Q?4H+31JmbCnupJtmKlHb1tZn9BBfg8uIlSphKl75p7iAu0ISbUdbKAvYTkHJW?=
 =?us-ascii?Q?iEZbsP9tVAEd96abTTrjvSU4kIyU4tOzFsq0oNiyuMBqXogX0ptvi+uVepqY?=
 =?us-ascii?Q?yBt2ucesdlccLgje8ZEUcVR3dmdYfQVeGFGWjeglxn/vCoHKrNYLahBzlFSG?=
 =?us-ascii?Q?oazbs+Rtzc0Thcpvoh8vd1Oc5i8HAWD93EXpKZqjlNBmEUm815dguFV9vtzr?=
 =?us-ascii?Q?VPKdBhWrxgcshfFqLnw/F4X9UnIEJB9Vq2cQFjkElHLPtt075cjtHAPFqNi0?=
 =?us-ascii?Q?eOTSsvD4KNrmnm67ppjaO7KirUh0svI+V/UoBjDKf95xbKsouB/T/vhfmhp9?=
 =?us-ascii?Q?hIUhSCDNhIRw0EPQOcLPVDP8vamSXcIUB47X4N9YhC6AmkHlpWj577zONKeJ?=
 =?us-ascii?Q?rEg3hDLjULE3awDW00K9+yuDxVoaEDPjEyJs3T6T7R25h7q505pkqBUQC7+j?=
 =?us-ascii?Q?VuyXqrXGtVa2rui8jZmhiZzv7I7F2LL741eVgznq7GkAsLke3UHEUsPURmZC?=
 =?us-ascii?Q?AzfOVU9wPGVgb4XyjlEnxnBKzm3FGKLNJPKFWHRKRmXHFSyDQ5kjYSABSwsu?=
 =?us-ascii?Q?1OXyEDngU5Yvx8YG/7mfU1TfBhxJxtFxLZQQtIcRuUENpkZH2P28EkpBsm+c?=
 =?us-ascii?Q?IhOiX99E5ZxXbwcC9ftpQ9n7nblgV488twaEHbX3UOXzvj7D/PQGLYis6kei?=
 =?us-ascii?Q?BZpgg4VOf8ftGG+BeelOGl58zzaCWRD/7GQD8j9TcyqQVTlc8AoMzo7/gXP2?=
 =?us-ascii?Q?+Tbea77kp9aD0TfQoMUf3TEqLee2oOWGPsXMLQMo7aTDKAjSCzSKefA5Wvks?=
 =?us-ascii?Q?7w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VBQQp9PYMdW9P63O+IaTZW0wjk7nduV/5L+veSAoe36514oeNH8eIu3xueQpi30yxdRmrgGWEWqwfKyjhcRb+HWVyw5dfQrXXH+WeuNXAerlkzA0t7BZk1FaBqs1AMbMOBmdzix9UCfzlm5xm7txI0HQDIgijMCZnYw87ut6YtJ9O4a/iSXy0YgDzQu8KuN5aKOZ+0KKy3659rp5hZZLscZfKjS7Tf1doXR71M5q0r9XpsCYRrp175dRpdw5iFybNWNsxnG1Nl0QeXlw+slQph8OnF7gtijFZ3oc/CZh5RO7ZtO4WXBsHbiB2mBLsM7d40P086ZSwZKK4VH9cUQIPjUQK9Ho2PM7jKp4yl9G5aL63CkkoDcl8quseB7JBro/t5KH9sCA2vpzUNw5Gu8YFk2gw6CnR6o6hQ/KVc96uKeNLXIG/7kwHRrBwLQMYjJWKL8dvnj0xO+NrujcBTS/IUdujFD4JklLhwds/QZYup9YIjrHEL0kUh+uA5WhuZ530EqIJCjg0F1HHCofdY7jK9BsuFLQqrcuACxysjiSoys7oRzIbm2n5jE+bNywcYJPK2wZ8bPTf+1ZOmYlyWAdkAvRagGROKbjOCoKI6cjgBNipDGWO4uJfg1NgfzI6w+2KlSyZYzf76EvZWqjBpNZ5tX7YiofKbEbX+1g8mTvNK0FUCC0qd+swGZhnihH4i7Kk/BSwzgr1VWDETvkiv3Up/KJ5Y5ppE+kCMCruuijl8Zg2WlgwSPymuAgD3r7ZjlIrkKS5CBTH/6NgEbCO5hUO96d0RI2EnhVyNtUxlemCx+JVCYnberM1k2yYWJ8FHbGPxHD+vBIr0R3PHWLuA0fuOtFxJiZ2x+Bl+4dFbIDcKHVR9j9LgeRumuWpmEEYxd8S8EYiRJSHuXaugC7nCAglA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ded773-d329-42c5-9975-08db7d98e9d6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 20:46:31.6488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqwksM6ggzMp3d2BeMYjUYqPOOUQEp3f7C0iXNUqfmGLsqdKP0gxOPOwsXdj+5PGH3dKWPAv7M3AqgaBOJHg0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6285
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_11,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307050188
X-Proofpoint-ORIG-GUID: bWKHr0QrfBlPLcEXUdXidE_Y_KUPyULT
X-Proofpoint-GUID: bWKHr0QrfBlPLcEXUdXidE_Y_KUPyULT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--qfieyirchnpfqrjg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Liam R. Howlett <Liam.Howlett@Oracle.com> [230704 14:47]:
> * Linus Torvalds <torvalds@linux-foundation.org> [230704 14:36]:
> > On Tue, 4 Jul 2023 at 11:25, Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
> > >
> > > validate_mm() calls are too spread out and duplicated in numerous
> > > locations.  Also, now that the stack write is done under the write lock,
> > > it is not necessary to validate the mm prior to write operations.
> > 
> > So while I applied the fixes directly since I was doing all the
> > write-locking stuff (and asked for the locking cleanup), I'm hoping
> > these kinds of cleanups will now go back to normal and go through
> > Andrew.
> > 
> > I do have a question related to the write locking: now that we should
> > always hold the mmap lock for writing when doing any modifications,
> > can the "lock_is_held()" assertions be tightened?
> > 
> > Right now it's "any locking", but for actual modification it should
> > probably be using
> > 
> >      lockdep_is_held_type(mt->ma_external_lock, 1)

For completeness of the email tread; it turns out we want 0 as the last
parameter.

(include/linux/lockdep.h)
/*
 * Acquire a lock.
 *
 * Values for "read":
 *
 *   0: exclusive (write) acquire
 *   1: read-acquire (no recursion allowed)
 *   2: read-acquire with same-instance recursion allowed
 *
 * Values for check:
 *
 *   0: simple checks (freeing, held-at-exit-time, etc.)
 *   1: full validation
 */

...

/*
 * Same "read" as for lock_acquire(), except -1 means any.
 */
extern int lock_is_held_type(const struct lockdep_map *lock, int read);


> > 
> > but there's just one 'mt_lock_is_held()' function (presumably because
> > the internal lock is always just a spinlock that doesn't have the
> > reader/writer distinction).
> 
> Ah, yes.  I was trying to do just that, but ran into an issue and backed
> out of fully fixing this portion up until later.
> 

Here are two patches to increase the strictness of the maple tree
locking.  I've boot tested them on x86_64 with the bots config and
ensured the lockdep problem was resolved.

The first introduces the new mt_write_locked() function, which ensures
the lock type is for writing.

The second updates the munmap path to avoid triggering the warnings
associated with dropping the mmap_lock prior to freeing the VMAs.

Thanks,
Liam

--qfieyirchnpfqrjg
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-maple_tree-Be-more-strict-about-locking.patch"
Content-Transfer-Encoding: quoted-printable

From c214e54a20258ca9c3ff787b435b04a1d900ad21 Mon Sep 17 00:00:00 2001
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Date: Wed, 5 Jul 2023 12:37:47 -0400
Subject: [PATCH 1/2] maple_tree: Be more strict about locking

Use lockdep to check the write path in the maple tree holds the lock in
write mode.

Introduce mt_write_lock_is_held() to check if the lock is held for
writing.  Update the necessary checks for rcu_dereference_protected() to
use the new write lock check.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h | 12 ++++++++++--
 lib/maple_tree.c           | 10 ++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 295548cca8b3..f856d67a5d7c 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -184,12 +184,20 @@ enum maple_type {
=20
 #ifdef CONFIG_LOCKDEP
 typedef struct lockdep_map *lockdep_map_p;
-#define mt_lock_is_held(mt)	lock_is_held(mt->ma_external_lock)
+#define mt_write_lock_is_held(mt)					\
+	(!(mt)->ma_external_lock ||					\
+	 lock_is_held_type((mt)->ma_external_lock, 0))
+
+#define mt_lock_is_held(mt)						\
+	(!(mt)->ma_external_lock ||					\
+	 lock_is_held((mt)->ma_external_lock))
+
 #define mt_set_external_lock(mt, lock)					\
 	(mt)->ma_external_lock =3D &(lock)->dep_map
 #else
 typedef struct { /* nothing */ } lockdep_map_p;
-#define mt_lock_is_held(mt)	1
+#define mt_lock_is_held(mt)		1
+#define mt_write_lock_is_held(mt)	1
 #define mt_set_external_lock(mt, lock)	do { } while (0)
 #endif
=20
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index bfffbb7cab26..1c9eab89e34b 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -804,6 +804,12 @@ static inline void __rcu **ma_slots(struct maple_node =
*mn, enum maple_type mt)
 	}
 }
=20
+static inline bool mt_write_locked(const struct maple_tree *mt)
+{
+	return mt_external_lock(mt) ? mt_write_lock_is_held(mt) :
+		lockdep_is_held(&mt->ma_lock);
+}
+
 static inline bool mt_locked(const struct maple_tree *mt)
 {
 	return mt_external_lock(mt) ? mt_lock_is_held(mt) :
@@ -819,7 +825,7 @@ static inline void *mt_slot(const struct maple_tree *mt=
,
 static inline void *mt_slot_locked(struct maple_tree *mt, void __rcu **slo=
ts,
 				   unsigned char offset)
 {
-	return rcu_dereference_protected(slots[offset], mt_locked(mt));
+	return rcu_dereference_protected(slots[offset], mt_write_locked(mt));
 }
 /*
  * mas_slot_locked() - Get the slot value when holding the maple tree lock=
.
@@ -862,7 +868,7 @@ static inline void *mas_root(struct ma_state *mas)
=20
 static inline void *mt_root_locked(struct maple_tree *mt)
 {
-	return rcu_dereference_protected(mt->ma_root, mt_locked(mt));
+	return rcu_dereference_protected(mt->ma_root, mt_write_locked(mt));
 }
=20
 /*
--=20
2.39.2


--qfieyirchnpfqrjg
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-mm-mmap-Change-detached-vma-locking-scheme.patch"
Content-Transfer-Encoding: quoted-printable

From 58fd73f90e7331678a728ada9bf92013105afbc1 Mon Sep 17 00:00:00 2001
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Date: Wed, 5 Jul 2023 14:47:49 -0400
Subject: [PATCH 2/2] mm/mmap: Change detached vma locking scheme

Don't set the lock to the mm lock so that the detached VMA tree does not
complain about being unlocked when the mmap_lock is dropped prior to
freeing the tree.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 964a8aa59297..3bb5a4e1f4f1 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2426,7 +2426,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
 	unsigned long locked_vm =3D 0;
 	MA_STATE(mas_detach, &mt_detach, 0, 0);
 	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
-	mt_set_external_lock(&mt_detach, &mm->mmap_lock);
+	mt_detach.ma_external_lock =3D NULL;
=20
 	/*
 	 * If we need to split any vma, do it now to save pain later.
--=20
2.39.2


--qfieyirchnpfqrjg--
