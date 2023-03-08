Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB1B6B0726
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 13:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjCHMcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 07:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjCHMco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:32:44 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCC9BF38E;
        Wed,  8 Mar 2023 04:32:43 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3288EO9B009542;
        Wed, 8 Mar 2023 12:32:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=i+jPVnboHkvbXt+Fd/jsWF5Kzqll+Rin7LBudK8aZFo=;
 b=FWHs72wwCQ7KeS4MEazElNakEzucJJtqmHkFNc3bbtdxjD9KO6vkOgIx6L2uZ3W2qBiH
 kjE+k7IcPpDGU4+OrxZ0caaszFEUXbA/pEBtE85seh899XlIkJe73qUzm6quOtyykNQh
 baHRbNOKj7Pi6sCrBaE7F6iDL004cm9qSW+gqbOEl64sYFQnoinBKgwlRxmUDvAfTarF
 dY7KuP9Vx6iVezZjcv6ux45DuPP+IX7d5XM53THOGFkciL655+3geSy5tMT6Gn9z4cm2
 5+/9sfmz/IwhMIbDP+eINE3og9nrpkjVKYp5p/NZVhbK4LP8dju90FLwb3j7LEokiRG4 4g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p4161yw80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 12:32:37 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 328BDiZE036526;
        Wed, 8 Mar 2023 12:32:36 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p6g45d6hy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 12:32:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMXnhJhZkBVvgWnM8e1WQG02LWys/gnmWnpwxS87s0/MoJ+HcsPtLkiV9Q38/rNPBmpK/Hs5ehiN9setoyjQ5YD5bqKsiuM4sXUbWuw17iXs9h+Xi7gq0w5GiGYL2hIMYAcliWCMvan4/WsMcyXajVjsv6chNRGrPtN+y16xObhRASp1v4d72lRPPPkNoPYgnnzy6+gE8vhY/Cj4Tl+Pv1z/oY8TlVmkkMHOsL2tqT693vKyHAo0GpL+qZDgdseNZVavdt7bSuvJdRkyCDAmQc0shjJuFx5Kc0YD3gHWdBe6Y5VAedS+xtzlI0rjmmReTfedJ7fECLyqSmOr9D3VVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+jPVnboHkvbXt+Fd/jsWF5Kzqll+Rin7LBudK8aZFo=;
 b=YO1b1oeK5sgX9JHZIKZLPM9PoRqbOd7BTPl+asCWMPO4tySmT92uHoL8WdI4RxlCVqGBDGFfO/UVlwzVZWNUuCbe5BFmRFaCKnHbJtubZr/ne6AE7X8CeFg/y/yGGByFK0Dw2APh2MRSwz1mMn0W/XYjhP1kkX+wgyCRrq8pwE7DjrXfTG8ZIjxZ5nJMFUgDb06K508H4KW84aYKp7QpyfuDpzDyfTRBrKAC7lhF0TYdo+XHco6rf2QYd0rlcZzopGBgvCFrXTLtRPqlcgJ20JNm8xioKwdK2UWOsF+cPPD7I50yaLKiPR2N6Yb/TlyeJkvrq9Nc6h5h4eKOpv3qhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+jPVnboHkvbXt+Fd/jsWF5Kzqll+Rin7LBudK8aZFo=;
 b=CtRthm0qfxULtmB48wJc0dhEQ1MVprr8qxptVQeos2HWfr7aIhLWSXhqfvIJJRyz3iEsIuw4/OFix/Mvgm2e6o1Jw7h/C7OyL5DlrBh3HQrKnFXxu7X7V5BY1S9OnvvnTxD1cqNqcWRh9py3fr+wSGQHvUsMot06E9PF6T+N9KU=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SN4PR10MB5574.namprd10.prod.outlook.com (2603:10b6:806:205::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Wed, 8 Mar
 2023 12:32:33 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.027; Wed, 8 Mar 2023
 12:32:33 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Lee Jones <lee@kernel.org>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Subject: Re: [PATCH 26/27] mfd: remove MODULE_LICENSE in non-modules
References: <20230224150811.80316-1-nick.alcock@oracle.com>
        <20230224150811.80316-27-nick.alcock@oracle.com>
        <20230303105203.GA2420672@google.com>
Emacs:  ed  ::  20-megaton hydrogen bomb : firecracker
Date:   Wed, 08 Mar 2023 12:32:28 +0000
In-Reply-To: <20230303105203.GA2420672@google.com> (Lee Jones's message of
        "Fri, 3 Mar 2023 10:52:03 +0000")
Message-ID: <87mt4n5spv.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0530.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::13) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SN4PR10MB5574:EE_
X-MS-Office365-Filtering-Correlation-Id: 7139ed85-7853-48d4-0287-08db1fd130fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wjDVLirjBo6COm4oZzGmeNUxnPbNge6T6LPxyZWkC3RQvC746hCI1w73J9Rttr8TipqP7XuEcQILC/wGRTlGcOx/3xY4GHVGXRBtpgW+pqhixTAuC+C4de71gCzzWQsgSZNwVC82LPh4OnseIFvHZci2zS4FcG7zdajCcJMI24DFeynkAcJXHE4maC4d9G58wyEDdIS1wGj4zNHqIiv5/YYnILK08iHjfDM9CgVdQFcs+HVLPWhvm4DJ6J0mui9oOTGwQGz+DTXNuSu0By/kUin3sidJDeQ5FaIU7Wf2/cH+Nz+0TfALnh98PpqA7/jO11oRr2Dgq9zjmJZKoTrXNmWGrdHXtui0W2ABhAXP4ir8oUp1S9YScylRZw2pAwjoDbvk5dHmfTOdkVZ8hz3d+b4Ar+NMOLKvas38kyNpcp4SqO+0RLueVSYsHJ4E/qvb7zrwFTEtvlfGTTLrWtlr5ZT77XvUK4oZSyDM5ilfnRqwV6szyCvmdA8K98NoECvITmTKagG4psTs+Q/69j5VjHTvMeinXuivh+YPt060OBOj6+4ndYedPrf3cVSNk0TCP7VIrzNvjG0/hyhJiZuZVqdxd5BxRxSyT+cTZUxwbUCKGUEGZACdM66oiuFYtHLY8xZJPjsZRlhMy9eiNXYKdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(376002)(346002)(366004)(136003)(451199018)(36756003)(6666004)(54906003)(478600001)(6486002)(316002)(8936002)(5660300002)(2906002)(66556008)(44832011)(66946007)(66476007)(8676002)(6916009)(4326008)(41300700001)(86362001)(38100700002)(6512007)(186003)(9686003)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N5/5onkBeqfGocNgZouBTLDc+Td7NTyshDCI2OQsBQ9/1OxLlNt2qXTNrabZ?=
 =?us-ascii?Q?+SFKx3C2K1aw2VSt18BLFyAz1igUr6Raje1T4PXDh97kZamiNtr/+EkfNi8B?=
 =?us-ascii?Q?gbDVoIMKp3y7uTMNbjhijZIFINJpF0dq6bjqqkSIOFmhoxJbo+haGzCBoZQP?=
 =?us-ascii?Q?fkpKqt58oDl1pJSUP8EfuvvV1EsOZHFm/o1xSGxw93XAzlUywBn0W85rlgV2?=
 =?us-ascii?Q?hWbY7bI6geIovf+aYQ8DCxc81iz/IXe1SrRW7vsoK7gdfGwFoh694CMePRgF?=
 =?us-ascii?Q?yB4fgPm4Gd4e/e8gAXI3023MkmV9v3u8+vs8o3UzZClhUmnS84aetk00GR54?=
 =?us-ascii?Q?zQWGCoomWy72ngeCSzzKSrznpmNIwuuqK9RXcBjJYsOls/Rgcl5Wpvna5pb3?=
 =?us-ascii?Q?o3P19PGcGKUb+aBwUg1vahCRQREUFxvPu7OBPxfgee62HGRIPJwAAeQ5LUnp?=
 =?us-ascii?Q?UH+VfkMv+R8UNDFh7Ued5BlsAM8zTDnHbYWAcHntsUgNgFId0o1ymDPhDTBS?=
 =?us-ascii?Q?QtmcW4DDaRX6derKIWZHHM/JmX63JoxGGsyMdfvpHi4lhxigU7WXl5wSn50K?=
 =?us-ascii?Q?wEqX8327JfTaFUGYxF6CV24Lk0ZCUeEp0uG3fg7/z12741dIY3Amv25yKTf0?=
 =?us-ascii?Q?QPDr/HlK2D3JBAYU7y7c1S5O/dEQ6SGB4+8o5nQh2eMYYIiT51U5PFsTB+mG?=
 =?us-ascii?Q?ETpnfNIzlQv9NFBSb3zJZHS7debVHgzSk81FOJIKwQLRP1bQYC3uUYUbunYR?=
 =?us-ascii?Q?0l55rTScOUXynsXil8zDW1mPqHWeiR9Ls3wMyBXk4GiWgY4RI/FhR3rIYXiy?=
 =?us-ascii?Q?6embisp6TD1wXl7jdANVzUwx5FIr/ggR/3IOed+FBnAKGrCBZGMoJx9dvwIo?=
 =?us-ascii?Q?XD3mPeEMBTaoEjNbtwa3DUMLBeqGZaPhI2wpWNWjWpNKxnJaQdm3Qg3TjXKo?=
 =?us-ascii?Q?XB50uKgy4R86odZes61NjCMQAyvPpmnwBzY21HK4rAA/fJH15ryurhW4AkAb?=
 =?us-ascii?Q?FMNyAdaEdmmu+tB5acYCYvAoG7b0D2Kigskbh1KZ+kVr3UMrIbr1W0bi4Peo?=
 =?us-ascii?Q?ruzXi2jxbOlcJZCtu69LIKzGJIrqP/jWYku/nWnxDwIqJTayUoL7U+Rl7flf?=
 =?us-ascii?Q?Up5DM+4Baxd+Ro7bCTg1fh6o2hSQf13kIc92OrZLXQy8T3NqduJJT+90cPHo?=
 =?us-ascii?Q?fA7NFeLL32HnfEpO8/f8C1VhG6K94AAeIJcaXHFKt49Lnv7c0LN+MB/VDZub?=
 =?us-ascii?Q?VqzaF8psTNrSOwRKqz5xLQwxFT5af45gxCTahpNnK4jQqUyqmm4IVfqGdRHS?=
 =?us-ascii?Q?vQo1SFYBcGsj4WquIWXiwM2cOpduohHdxKQUE9QFSHs0JxKuj6vKQVhhf5lk?=
 =?us-ascii?Q?kEiixa/Pk96qIT3n8xxb6riGdSreKFpheEzqKTKz5Ml54NMbAXopup396fKF?=
 =?us-ascii?Q?nGo2m9GI2+Zd56lvT+LemBE7nJx2u1DDnBlR1DYrLISxdDpDy5Mk2R44X58P?=
 =?us-ascii?Q?Do7QStEa1wdBgxlehVilLaDjqiVJseA68uYwgAMfjy3IPchr2Nkj3DY5ljxl?=
 =?us-ascii?Q?46eCEO0Hi2htzAUDmtHahXdUcVV8C3Q1q/pqQJ9Cg9hp8nSErIRDBGstlqQD?=
 =?us-ascii?Q?Pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8DhuuZ8fCPCRqEnUvcD9kdIDk/auftZK/2jnHK4RbOKUFrYo8GS2aw1fyVlRhQJ8xAzsiSxBOuSeZZXhbctfuAvBaSc7Xk/iwWoiU50g/zqHqTX1FIRdV7e8vJhbyI+lwSoV4/N3v3O0PLTUwi0BxVvip584Rtomhu99Hd1UCOQeKPjginx6wKR1aeCbMVrkdpnCS5/FDraL0ofkaGRQMzJoH+NHqp2n0JUZ5UioVHrZpolfTHqZ62XBMtvMSeboMMQgajRCScFalQo+eWNxX7ojaobzwyLTwlcEbd/GvLoIYUnUJZgFzK1ZUoI+v4Cb5TKosvPv8tEkgFt0F4yLGQu/2meh0GsXcVmWmFC57cVI4Rz0aqa7sR7sWpgwAIMIzZbPn2goYK26IJqY8epsjN6Y4yq9JYjuwXk9HGDhlGJ31UOEEAua0t6kHx1etMZeovgFszIZ0c/Dv6eCCwKcE7ThBMDXjMjxH/jugwY/OPu9tIv9bXmU4bwh/kuX722X5c9IdzPfuZU10SCShxhgSSDUE/+zxfPT4TZPUHAdlcdn+SA79asyzSgfIXMOEf2+s/lvcwrn47LeoEgIPsBk5pWySV0HNt9Z7EuUE70/VWrycEiqfajfoDAUveOLvqDZ3ZHgeTkOWV5pRupQeWhX8yMM8RM2DJEyBbrxubA/dwDTrxpe1t1bbikXu+l1s3ZCFTb6EBXsdeC2yosuDsAWdZZSWvUcU6w6ECcFAPzWKYGeEDMNC7JwK50Scf8o1kfgoKtGmFWctVdfpEZuiKPDr7eIw9p9FiZEKwT71FSGPx+TT8pN2L7ydYSujMTQneMcn5KbiSeIsS3koNpF/7MJOVTSGs8hSDwDiH5biW7Pplk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7139ed85-7853-48d4-0287-08db1fd130fd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 12:32:33.5445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AbQRkHqtu2Qk2e8+l4BOFYTo8Vfybv6fOIL4wHE5MvYAQb/b1OLnoE7YFKeHgKdHfCQMZDp6MBXVFb+fonJGYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5574
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_08,2023-03-08_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303080107
X-Proofpoint-GUID: UQAHxbFYSPjtC0OM4Xmh8AwBgQL5YDeD
X-Proofpoint-ORIG-GUID: UQAHxbFYSPjtC0OM4Xmh8AwBgQL5YDeD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Mar 2023, Lee Jones verbalised:

> On Fri, 24 Feb 2023, Nick Alcock wrote:
>
>> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
>> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
>> are used to identify modules. As a consequence, uses of the macro
>> in non-modules will cause modprobe to misidentify their containing
>> object file as a module when it is not (false positives), and modprobe
>> might succeed rather than failing with a suitable error message.
>> 
>> So remove it in the files in this commit, none of which can be built as
>> modules.
>> 
>> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
>> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
>> Cc: Luis Chamberlain <mcgrof@kernel.org>
>> Cc: linux-modules@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Lee Jones <lee@kernel.org>
>> Cc: linux-omap@vger.kernel.org
>> ---
>>  drivers/mfd/omap-usb-host.c | 1 -
>>  drivers/mfd/omap-usb-tll.c  | 1 -
>>  drivers/mfd/twl4030-audio.c | 1 -
>>  drivers/mfd/twl6040.c       | 1 -
>>  4 files changed, 4 deletions(-)
>
> Please adapt the subject line(s) to include the drivers changed.  It might
> also make sense to separate out changes to cover one driver per patch.

The subject line is automatically generated, and uses whatever
subsystem prefix was most commonly used for all files touched in that
subsystem, while not containing any prefixes *not* so touched.

It's also automatically split up per-subsystem from a single big source
commit that changes everything at once. I can split this bit more
finely, but that means automated regeneration will be impossible, so
it'll probably backslide if I ever have to regenerate it -- and I've had
to regenerate this series a *lot*.

In fact if I'd split this bit per driver, I'd probably have
automatically got the subject line right as well -- but if the series as
a whole were split up like that, it'd have had about 400 patches rather
than 120, and got a lot of maintainers even more annoyed than they are
now.

For now, I'll split this one into four and mail it out again: coming
shortly.
