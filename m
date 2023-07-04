Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECB1747547
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjGDP11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjGDP06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:26:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289DC1AA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 08:26:57 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 364EibEU002669;
        Tue, 4 Jul 2023 15:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Qd12EALWCez1g5nkFvTFc4FjGLwOifc6Gs/OL76I5vE=;
 b=I1r2oR1bPp9NtCHvG8s6nncmPL3GAsee7oTXsa5V2Bwe4d8Zubqw9TizZbbOw7dZUyEj
 g2jHyw+qRpLnvJjgDoKggPHrli+xKhgmwnWgl4BDX0JuMpHlsU69bcLYiTkvD4bWSTUi
 wgsuiuEeEVB082uhLdmqi+5DD/M5yUrVKsdqukRaTjaYnngT2OEtI7v56E6Ynu8+5AwP
 Ku2hqp8k5lvcvU7RcgZ27hURYxUle3aQPJCJwZ3HyOYYfJAEScnfVLY4A5qeU9Dqe0AH
 5Ofv4ptH+pyTLTcz8wSOyn5/xBE/VhGJQTxSMKyYHOLoGnqx6BZVmr0EGlvaI1u+eFz8 yA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjb2bmv1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jul 2023 15:25:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 364EHbpR020986;
        Tue, 4 Jul 2023 15:25:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak4hurp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jul 2023 15:25:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kI4bl6kBTmA2t2RQB3FSCT3EAWuMYBEpRl3SqC04oy3WqSD9l6oa0DAaqDljvf2KxGKOoI7+aLnbWgzF5lRU6zim8pgYEdGkJta6ulkyKwsmP5dJ2S6UVTkQrr5trmnTQXtnuGOA9ZVwX/fWeA5dvLClJ6QsqO95/vcyTW/BYvEUaXKG5ULmnYc8bYwjHxv40T0hEKR+F77uQ6fZEj92oGA1mihAzsiusOduAxaEk6ni6weALo/bAgQ7pGW+J5bm7xCkxgYxTciuDn0KdLhd9Ihbw0nFVxFSbegjDOPEyqeXg2Y0+Rpj2iXxUKAtAlJN1d7lD47UKyOACZz7TZ6Ohw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qd12EALWCez1g5nkFvTFc4FjGLwOifc6Gs/OL76I5vE=;
 b=e/kEofvVhxskrrQ89Gy8TkgRPiAfjRwSx0dzSCy7NQXtlt8XhxWyWoyrYLZ23JsB9CTpoqJg6aa+12A2mifRN67xvkxB935gXX3PQy6KFikCVRbOM5zu0c8kHf5+SrjmINiJAivLjYdVp1/AXm63SebfTLTefyrFxffdG1dYOi3EQiIy34gJRWq23TvkD8HWUMAqNc8CTtylycPw63mdYXiBo8iDF2VScvj/Rl4IlxSGR3jT63FlY+iyOIo3d+/Iq2sg4LGxFS4gcogXfBrLDI/fmo+J2JbLno/iAOHgKOQ7S7SRtpzrh6HToE/J+vIrFojxi3buLvGJIYgYapd69A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qd12EALWCez1g5nkFvTFc4FjGLwOifc6Gs/OL76I5vE=;
 b=VxQPes1dUAISm8SG3C36Jh8e/kV7o7DD14531QDsvq4SGBIWnzQKoB9964MfEWylM1DXKCsflkSbzYUJQIUlN6LhclHZMg+OC/ld5pSbOzBYDuBopqges2afgjMqSpk0jm5nnFLpXGZGtFZqZfnXG4hfDoTuboc42m80z51EjHI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB5824.namprd10.prod.outlook.com (2603:10b6:806:236::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 15:25:50 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 15:25:50 +0000
Date:   Tue, 4 Jul 2023 11:25:48 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [mm] 408579cd62: WARNING:suspicious_RCU_usage
Message-ID: <20230704152548.afqtyylbrxzunq55@revolver>
References: <ZKIsoMOT71uwCIZX@xsang-OptiPlex-9020>
 <CAHk-=wg1_8L+e09_RuX=Z_49oLn8=w82YzCk+kybS-ymSd_zbA@mail.gmail.com>
 <ZKN6CdkKyxBShPHi@xsang-OptiPlex-9020>
 <CAHk-=wjXEzCV7HGPS=2zgJJ8R14e97hAesQ_7fjFZNS=jOADYw@mail.gmail.com>
 <ZKQj238p843J4eZ1@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKQj238p843J4eZ1@xsang-OptiPlex-9020>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0405.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::18) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA1PR10MB5824:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ba644d1-0f81-4165-d490-08db7ca2f2d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qfXKvyT6lgMwvjr63AeK714KuW81ZSWZVjRD+u/e2+yKTVwtJ4DVxD4xaj1AEE7dJFwir5L/75hSSW+HIcHdYCjDNNU/vffnnjj3XSHlRUe3oZPzaeniB2AOh3LafJrrvRV1K8BI5og0a5NTKOjWjecTv1bKYrCWdw71UE8PrzExfIfEPRRoo3a8wBun8cODkUW8Rgq4h+lUaqMnWxXzOBEoZUHljzR1bnThSV9sNlKxxBJi+rK4+U8vn9erdG8UI5TP/i8zqHDxrV7ofHb3LQIXlvJYh4Y+8SaTU7deiIegD67havPc6NBaRzq0CTTb2xRlBv6rwrLxmb0GkmroC6q335ss5p6ykWjMGHwzYTCU9VgqVpVs+dfy0+GjZHTW5o+3YvZvnOIYasETIndox4FWG72qEapB53+3QGmeYV/IgNMmUtmxdqgVSH4DlWmApLiU24LgzYs+wWR7T4UoMnfHaudzhYLP2F9H76QFq8+ZkLpzAgAjSfC2ln529gA1mG3dbAfhmPq9M219+WEYHwOIFLukgMwv6PIgXLdRr1ia7OLtNnp/SRj7nnLHpe55
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199021)(4326008)(316002)(66946007)(66556008)(86362001)(186003)(6916009)(9686003)(26005)(6512007)(66476007)(1076003)(6506007)(83380400001)(2906002)(6486002)(38100700002)(33716001)(5660300002)(478600001)(8676002)(54906003)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?anbc8hUz/7kJiM3Av4hsdTl56rOeH/1F9cabee0VZjMJ0gzpZMTkzluNad+d?=
 =?us-ascii?Q?EDjYKZtnv52FBvct8BfSsYdhiSsuuJPX9eRbF4jevA8vNEGYjGIXH5yC1eQJ?=
 =?us-ascii?Q?wO7Xm3TaJtv0FdBZbeSzuzmwFCMS010G/H9hmLeKTR+6sM9o9YaVHIMI8Th6?=
 =?us-ascii?Q?dWCtq4BPEX/nkpfjylleNxXQ6Pm60hGXhl79FYH4Qd0XTiBSVlYhdNhaf7Pr?=
 =?us-ascii?Q?hnOnw7rNtQxWQ8BUqQmuH32dejKGqFqKgBUAIWua6rnhEwFXErtVGKqrw4T4?=
 =?us-ascii?Q?MkJahdQTlLu2rS9zmshlvwju8xJ9cH8Z3FZWv23Eh26W5kHwjrfQdtDL+j/h?=
 =?us-ascii?Q?a+KHdFSJhgHweZ7WfIJnbxZ18+LyPm7jgsrcqirzCN7DSwv94XS7DSicOqqI?=
 =?us-ascii?Q?6sihIqP85yK+c4RYmpMaH64TJaCfDuklsGcydwHSia9ixbEe4axS7uK/P3aJ?=
 =?us-ascii?Q?t6pIpLCiqocva7ct9q2XR/bkPpITlFQ+856RLJFtd6K3zh99VXpH9VkkLxnD?=
 =?us-ascii?Q?3UfXpsl5bz8jrXigZtUntVPex7qbQpNYkMI40yoXyfnBUvs7L0wsYYa4L3+V?=
 =?us-ascii?Q?vHQPgXbcH93Qkp+3N79dGHlPOIPKNh97oKFvGlHprSbqerOvEXYJgbsn+wwG?=
 =?us-ascii?Q?YdO4pZQWw1uA5t/33rF02sBZVbug5R9eEWRacI/qcYRFuNMDyIhzWaBKb0ll?=
 =?us-ascii?Q?OYEEx0UoGj1SgyYztoDY7kGSwCBoidOSNGDobk4CCPzCm36DDVZPty3CjAP0?=
 =?us-ascii?Q?MhPjBUBr0m77zlC935Ru0AOy0M41C8VtsaKx6cMumc9WlbRqMf51RikUangH?=
 =?us-ascii?Q?xq0phI/G+1PM11YyznefMsnTdy8qFRZgdkbxE4Dd4rAK5/ZJGNVh4JCXtuRB?=
 =?us-ascii?Q?YAlixIiTAn5+NtbLafP4DWaoDXkIpLUXWsNdHXHvCzR8h9j+vQ++Vrz3akK5?=
 =?us-ascii?Q?fpIayRAUEmNizdxTaK36CKiGUfPtJ+nDG46birYzODDkid/zNj/Tu1pyBPuK?=
 =?us-ascii?Q?4oXZHZjTQjwX9tx/J1UYpTj9KagIN9/wDXBeQmgDosnSpwtpbhcX3Ae+18s6?=
 =?us-ascii?Q?lw9nIw0Zcr2PAkwUM3ckwgHLadaqm/ijmNdr8i6SoyZM6K6irH/lLjB9jzme?=
 =?us-ascii?Q?T3SQ3eZo55MTY+8sIkW7y5dt+awD4Uib+NvWmGVCSWsveH3aVvWhZmpHahsg?=
 =?us-ascii?Q?V9WHhOR+JEnDqxCRCMlq49u/NMGUtyw5NMHV5zBIOG6dnRyPgCkOru6ArY1s?=
 =?us-ascii?Q?/a0d2TgFcj1NPvgLraWvrmuYu1h4HCIJgDqhs9ElpnRYFJA3rK/J6O1yFImy?=
 =?us-ascii?Q?sl3L61ZFEyoq8BqSHzH4zZkciGLtLT3Yw57LylgRn/MFYMAyKCo0Ae+2Rd/n?=
 =?us-ascii?Q?71/f/el3Xs8nAiE+aCPbkzfwU10l5O/8ptXsB9NtGqjyHHbeRHXdBQuvBMeS?=
 =?us-ascii?Q?Zs4HF57Q4fMVpHFUqkel9NdX1uQvii+pOlaAT8OxP5n4gJhf/Sj6lhI4jZAM?=
 =?us-ascii?Q?5HWrysU9HgAIfzI0Dzktel+UHOIHIa9o5ioIyRgF7NTJnf9Z/SKoabRN+lBk?=
 =?us-ascii?Q?SZWgYi0MDWjnLsAJDLbDScJWNFD4VYwPTPvSh960bhcrbjnVvFMof/My2bvZ?=
 =?us-ascii?Q?Eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: G3cUNxnZD2lzDCtkINUAaEGvXRXbgyNP2c02jyFdNPSjMYcf9WIs8o38CX8oV/bX/+qk7/1R20h+DThH04pVq+MAtc6+ekrqgFIvBIuotAZs7GInp/umE3DoXsAD7UH1wqCsfkW8IQhdHEvsg2z8PetEBfueg/bcWzF+PylRhum+yBFqb/YB3d4VFIL2iiYab3Q8nbkSfLBtIYavN80og2qcCWT0SyqjDCKUvMapS6YSOkBjMQ9CVVLJYK9Mt3k6VHSjrftISZnUInOwZxm/5VTAHS6gtY70K2PkIDXjU+QMMJNFUJRnFF2yAVGNssy+dgCmH/azSVAYHWbz5qfuaOyLPCROuD0UZzYJc8TgFcwG6scSYc+qLXzl2EaZRNiq2FrSEodhwXY2Rl0h4JpMmfSNrw+6XXXr2hZmKJnE5pPN8XkzqP9T82aPOzALXCBM0nutwmEEtYxGFQJ6huWzmDezbsXcpkZBviN66y2RCfKEPJyb+fekV4/CKv8/DTsrb2DTNLlGJ2M+TKDdT+kq6WjEnI3S6kMKgnBhLMgxth1gMHO6CcbbZb/ir9vVJL4YotCghBfHzeZ8aABPeqZBwdP0J8b+lkoj21zqXT6vQSH3rQQf6XbRDg4KV0ypTMpds3GKVEUuikq/cjXgQTEzpXk0ysyle6ClyJdOROBHAV5+rErHDHF9a4elZb1Zdh9F3a/3vRPGbjeEQvJpcjqoME2h4QHz5NUbsMKj+Bk1ZVe4Fa81xBbi802SoBQv/DJoR/XZZ5nBYAC03/iPV29KrdHg/kMmb415w1latKhcOXsfMOr30rkYwoAMafrXGonzyVXBJXMjKkreLo35vBRRW4CddW9OkbufMmfctz8dy5uPYQ5EtmvvUTm1hRbgQ8Q5
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba644d1-0f81-4165-d490-08db7ca2f2d8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 15:25:50.4632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GTAg0018j7JubiVGLc9HTRF61P+UNK4vzX2MlmzcEsiee1GIAfcKTPUkUAGQZcd8Gz1litILyrH+NKnyThyufg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5824
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_10,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307040133
X-Proofpoint-ORIG-GUID: TshNGlJDLLFmkyfXcQvEt7c5WE2FEzDO
X-Proofpoint-GUID: TshNGlJDLLFmkyfXcQvEt7c5WE2FEzDO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Oliver Sang <oliver.sang@intel.com> [230704 09:51]:
> hi, Linus,
> 
> On Mon, Jul 03, 2023 at 07:29:48PM -0700, Linus Torvalds wrote:
> > On Mon, 3 Jul 2023 at 18:48, Oliver Sang <oliver.sang@intel.com> wrote:
> > >
> > > by patch [1], we found the warning is not fixed.
> > 
> > Hmm. I already committed that "fix" as obvious, since the main
> > difference in commit 408579cd627a ("mm: Update do_vmi_align_munmap()
> > return semantics") around that validate_mm() call was how it did that
> > mmap_read_unlock().
> > 
> > > we also found there are some changes in stack backtrace. now it's as below:
> > > (detail dmesg is attached)
> > >
> > > [   26.412372][    T1] stack backtrace:
> > > [   26.412846][    T1] CPU: 0 PID: 1 Comm: systemd Not tainted 6.4.0-09908-gcb226fb1fb7a #1
> > > [   26.413506][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > > [   26.414326][    T1] Call Trace:
> > > [   26.414605][    T1]  <TASK>
> > > [   26.414847][    T1]  dump_stack_lvl+0x73/0xc0
> > > [   26.415225][    T1]  lockdep_rcu_suspicious+0x1b7/0x280
> > > [   26.415669][    T1]  mas_start+0x280/0x400
> > > [   26.416037][    T1]  mas_find+0x27a/0x400
> > > [   26.416391][    T1]  validate_mm+0x8b/0x2c0
> > > [   26.416757][    T1]  __se_sys_brk+0xa35/0xc00
> > 
> > Ok, that is indeed a very different stack trace.
> > 
> > So maybe the fix is a real fix, but the first complaint shut up
> > lockdep, so this is the *second* and unrelated complaint.
> > 
> > And indeed: it turns out that do_vma_munmap() does this:
> > 
> >         ret = do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
> >         validate_mm(mm);
> > 
> > and so we have *another* validate_mm() that is now done outside the lock.
> > 
> > That one is actually pretty pointless. We've *just* validated the mm
> > already inside do_vmi_align_munmap(), except we only did it in one of
> > the two return cases.
> > 
> > So I think the fix is to just move that validate_mm() into the other
> > return case of do_vmi_align_munmap(), and remove it from the caller.
> > 
> > IOW, something like the attached (NOTE! This is in *addition* to the
> > previous patch, which is the same as the one you quoted, just with
> > slightly different whitespace as commit ae80b4041984: "mm: validate
> > the mm before dropping the mmap lock").
> 
> Thanks a lot for guidance!
> I applied below patch directly upon ae80b4041984, and confirmed the
> WARNING gone. Thanks
> 

Thanks for testing this.

I can clean more of this up now that the mmap locking has been changed.
For instance, we can drop a number of checks before a write (and all
read cases, if any remain) since there is no alteration without the
write lock.

Thanks,
Liam
