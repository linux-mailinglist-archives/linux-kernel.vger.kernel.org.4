Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607F470B35C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 04:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjEVCv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 22:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjEVCvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 22:51:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5848CE
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 19:51:48 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34LN2IfC028689;
        Mon, 22 May 2023 02:51:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Gt87w4Jfjb+sWoEEah7cPPFoRSKxykQS/KOcwmS0CYg=;
 b=nmgphjSvuGOHLEJGyYYdIzg+Y9lwORBe0jO8kbtaDorss+o7SFRFvqI9GnRgPf+2yai6
 yM9mEOFAS+oNgm4BIuY3mSAtpLMUHrxVERxN/L2yLQ3/h72/LhfQs15HMpsfvll54j2u
 NSuUu4TUNAaULb7OkUHS4HzpzsbRsefYa9QaRY5lg/Y5lxHZGfnwksGnvibnVyfaFVfM
 I/u9h8HSosXszqWEZGap6qfAfdqHwWLMpQiK+XKXGFykiThyP8MvHeJP0R2CnmvlLNbn
 NGPA0pinfoK+xZ9IYn6rkYCBA382wW12h7DsHihxV7D6FpqRpBjSWzIHPmQwlQSV0b4A sA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp44hq77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 02:51:36 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34LN3faM028764;
        Mon, 22 May 2023 02:51:35 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2p4dga-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 02:51:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6dbM7hHy5+LqcuOjDwKXHI698HD/Cl3uBqRBSqhDaI5klhR9Q/Xyw82Dq15XoRPfGVptee8pfR0J84UPXqJjdMTI+h6ibdI5DqCnmj59OADiM46Cccds1c7K8zs0oQDN7Hkb246khXmSnW9lHK4Rz3YWOh6PLA1MxsLwm1b319UahtWge7RAAqbdXR97qae3ybCIlBmgKpHVByHwdOlCy959RaHCUFZf/3g2kOFNqNaGLkBM78lvgd6nLPU8NXLaPcklEickyORA8pOvAUS5CEPiKZMLBnsCUWuQw0XMwGD7zzhOGylj+QJqHRwOmqujTQLo3JozuydpTJRMCQuEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gt87w4Jfjb+sWoEEah7cPPFoRSKxykQS/KOcwmS0CYg=;
 b=k0VugeraFcpXKV662IUQN9Q6gXZUtUOhdT6KpK0n5A+Knt/nBKXrG4SN6OzcTxVML5jaZfRUGl9TLQB8SghwfckzWQG9SwN3WvoUcuuximvlqogOHEe8Vg8zHL7kFAAPtwXC2/Wt5naBe37QpYAd7OuKNhDr2d1BTWnaV8EDWnYcqICl7mewIApI39Y8XVPj7IF5IpeqaNipvLcY4fL/Y3v8Tt1FuC0P4yGMW+sDKRx3d2c5g+fkqxMJuH3SRUfiZ+YRYiZLhhAGAMR/VUP6QR76wKT2wMsAApyz9mAYcFpDOMnXVv83WEMTAvEzKGZB3OeRib35IOCRtRef2jtkpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gt87w4Jfjb+sWoEEah7cPPFoRSKxykQS/KOcwmS0CYg=;
 b=koLgPOlJQIHAgolId/GvAZAoz1YWo6G5wrfTU2bTPMNHFsv/WF9ns7QEU9cUJmz710A8vmAoVgWEMbbxtUfSrzomeJ8xeBQ5fTl4BX+x3ZGt2kEDZf1ieRXjugSDfxn4tdtrgDVS9iDW48NKp9tog+3bZa8kLam2Vjx6ml9MTbk=
Received: from IA0PR10MB7255.namprd10.prod.outlook.com (2603:10b6:208:40c::10)
 by CO6PR10MB5620.namprd10.prod.outlook.com (2603:10b6:303:14b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 02:51:31 +0000
Received: from IA0PR10MB7255.namprd10.prod.outlook.com
 ([fe80::6f12:fcdf:da87:2bfe]) by IA0PR10MB7255.namprd10.prod.outlook.com
 ([fe80::6f12:fcdf:da87:2bfe%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 02:51:31 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     oleg@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
        axboe@kernel.dk, ebiederm@xmission.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 2/3] signal: Don't exit for PF_USER_WORKER tasks
Date:   Sun, 21 May 2023 21:51:23 -0500
Message-Id: <20230522025124.5863-3-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230522025124.5863-1-michael.christie@oracle.com>
References: <20230522025124.5863-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR14CA0008.namprd14.prod.outlook.com
 (2603:10b6:610:60::18) To IA0PR10MB7255.namprd10.prod.outlook.com
 (2603:10b6:208:40c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR10MB7255:EE_|CO6PR10MB5620:EE_
X-MS-Office365-Filtering-Correlation-Id: c11d73f5-b747-4034-f72b-08db5a6f7260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UW4ZvwHtgwT/Uf8B4RsUQxEpjwdeluTVArY4v7Mfr9rh2WX/+k45QMcbsOl5rxC/06mTbzGMV6bDOxa+Q7u3/h4ajTpRg6WoMrT75lRzKdyQPrWLAw6clK88Efs4/pYuvF1qg/NqpcGLqV9Q1aT2HNye7JRA+KeYtS/+0Zn0vI4AXvm8u/AjNa8lpN89IYPZaivMMXu1Tlties9qj87GShdL9hnE7veo4BI3e50DASoE0zXDIXk/hKKBn7FILGtaTs9flO8ZJgm32PlIUxRwHGIOPHxPbV5tIyQqXe+jXTkXBS+xi1weixHlJlOpk2F2cLq4g9NK5jrCVWNOMycOAtocaLT+Zlw6R5nQXWBg2zuvRxQIiSL7JQpb2Tg0MT3QTOToLjLxkwcKG9KFhv7a7jBYKC7HIraNz5lekcg/ih6tc15PdA7vF7Sg2bDfT+x4evj16/eALbFWkDBJnzp1KDDng3didHNAgJSJIk9jO6nF8cGnoGvWUW1yDf96MOaJB2Lkmr2WmhE9HI0pP9hvqVNyzVG/ltfflY0hb5xFRmgqG2/nwAfbwI/mQIamnYbaCGS2t34A3hPd1yvNesNWqNU1izHYxxS84VB0B4DZeAA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR10MB7255.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199021)(921005)(38100700002)(8676002)(8936002)(7416002)(5660300002)(6512007)(6506007)(1076003)(26005)(186003)(2906002)(4744005)(2616005)(36756003)(83380400001)(107886003)(86362001)(316002)(6666004)(478600001)(66556008)(66476007)(4326008)(66946007)(41300700001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gUy0K+k7Tqc8wDxUZDWK8V9uwsPzFae4T8FxoTmD7cfeqDGzhmgx0D+d6Fso?=
 =?us-ascii?Q?y6QgHKe3tpd0AAkjoqPS/PlpQo4skI3/Gh2q4ROgeotmpFEmDaOLSiZqr83V?=
 =?us-ascii?Q?clRA/TacL87CZG0uN+XJN4FLRTHJO31DLZAlmyWXZwCrY23PipsJD8Nc7xsW?=
 =?us-ascii?Q?0QDuLppGR5Bw83ZP2wRgjLIJD/Ej7E81ab2BEx7apfum3SHyWbIecCp7Ya9a?=
 =?us-ascii?Q?Uz+lCI0ju0aneZa04eggVLItaJvMtiTYSXmdhn8pdpS5lVebxBzCPqLW6Nzx?=
 =?us-ascii?Q?dVvPlBCTiLeeScJY8QYL7PfbfzFC0lkjZepfWF4AYhFVFwYGdUCIiXriU6re?=
 =?us-ascii?Q?jiKLC811OixTnYE6fuyJnRzkPtw+LlroUiljwpnnnS1GyAYNkdzf2Mf4Rp4h?=
 =?us-ascii?Q?Y9CD+ddRp6fkxC1cW0OaDCJ8D41OPw/9KXaHn9ca0pmRC9tcKYdaFDybQ7mG?=
 =?us-ascii?Q?dWrtZ8TewoxdJp+1T2M77sXb1YBtloywBFm7MARFO8vp9moI3opryA8m6iOH?=
 =?us-ascii?Q?r0r2CVXOn8fFil/BRIEGM1xFqKRT43pqnq56DrM7MJDRv9zPT6DRAyAmjeZg?=
 =?us-ascii?Q?Df2c8UTqtoA56/K9cDuue0RdwJ/dm3xuIfLNRboH7x5XUqQ8SFjeeRYpPY0F?=
 =?us-ascii?Q?L94HcMM58hvsGmLS/9+5ymtCC6AI+B8NxaIOfmcs+tCCWgFjLOg24OkPDApa?=
 =?us-ascii?Q?sMEtxS2slM/XIBMjmvXHbuqm/ACLBWMVw0ll0ZRrrMvGl5qUQTgudOtR0fkZ?=
 =?us-ascii?Q?PJpG6m3oSbltggZAzRKw23jkqxBkG254B8ohgnd8y26lqg5MtM2dEKECZJJ3?=
 =?us-ascii?Q?OFOUfpttIla0swCOID/5T+IRlVzRVo4GuS3iAxFnx75l6Pd2k295Fyj2J94f?=
 =?us-ascii?Q?MDMolyj49o5KOhhmF118wQspu6k1WkdAjouUpUnat9F0QPuYEC0tX3yHWBGW?=
 =?us-ascii?Q?MWLTcWKOrQ7gCciVupqXzxL9i4TLSum7aP5BVagGIN9R26X5kfYJImFh+pJ+?=
 =?us-ascii?Q?oQlnwjBsODi/vlVpZfjEX8vObuZSLy+Jd6V4s7yfohddeJqfEZxyxpuIIoed?=
 =?us-ascii?Q?nyJcTGPHg1x6+SgCW6+HNDPucxlls/o4YkHjLkOcqRbYhk8tRT8y66fqNZU7?=
 =?us-ascii?Q?vekkkK7KWd2hg6WH9JNEFz1cfkyu5W8BTgEohuebWcG845/hw+LuRIRzB4GQ?=
 =?us-ascii?Q?DctdNXLaMfZvvNCPbYRjt4Hl+ehkuQ/UfZCR4yxePPz2+pWUO483HkFxg/LT?=
 =?us-ascii?Q?MXuFHz3qwyD++bb+6IXMU/q6kQPEfm4rmJYPt4V8B7/PH64MKr8EA50+spcD?=
 =?us-ascii?Q?gT7gGye5DoYtqdeNiSoLxxYPIzWJ9m0zm4p9F9qvZ1I/owznBqJ90e6D2qAB?=
 =?us-ascii?Q?b61Wa2lgx2R8X8MKl9Xp7vskOgfC0Z8fAgqxCy1TE0iChIwRSiArplIom4YM?=
 =?us-ascii?Q?LOF+MGyI6cthw7Oap4tKqu62DQwL+hMemFuF8MbyhxkF6bsYda4s595561zY?=
 =?us-ascii?Q?z+gFd/7blcPeAHWMQRw2Pz6A734REykB3zpjMavlK0KLRTA2RM5Y7umqKeZy?=
 =?us-ascii?Q?HhvGg8IpsdcbvrxQG/Td0WM5DrGZC2b1k/IoMzu9F9SoRHSTEpgZLZbt6QJ6?=
 =?us-ascii?Q?Vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?TOIBL4HStYs6/A2YvLMJmo8zzlr6KpJl78028HvtOk4NJbzp5r3tK+fDiD8z?=
 =?us-ascii?Q?pevjeOteNAOnQ1lW2/IFB/l4Wm9jP7Q2jpbiuVcXCcfbvSrJfvPwjMcU4VYn?=
 =?us-ascii?Q?Apwt/Nyg/EDh1mYCh7n+XQ9nQSJlD+dndlsiLTkpNbzKee55ElQQpO+yaI26?=
 =?us-ascii?Q?2wIfBRWGCB3/ic8g3m08SdLJX8nlf0BZwhuozgf0DiJPswXNQL4vizSFXI0R?=
 =?us-ascii?Q?UypaUzQnA0cvfXB5q8FoAoc1csI65gntVMg5fBSVVBbz12sDxmQxefXxxwCT?=
 =?us-ascii?Q?kPKl0IUvK0YYOTKOCLP6iUMm72gRJvi7K9kx3UusGJKeJubX6wlPKaVrfHSZ?=
 =?us-ascii?Q?zUiFGTH7rhYJZV/wHiA1jMtLH+yLY5jexA1VgnpoLSmMwSxWDLo3uySvOwR1?=
 =?us-ascii?Q?JWyZAenoNv1Iu9uC/ie7r0oqZNJdLyvrhxxSeCqJoYkrBJ9uI5Ln6rIAP5+J?=
 =?us-ascii?Q?ulCw9b26JFZq6+Pg589kjOa/sC2YFlP5oSuPGNw7rPyWN8F9CLqzKWLXIQ9o?=
 =?us-ascii?Q?j7DSEIq1nuDN5VOpjY1FzOHc0xqLgYzHMpMXinWHL93gmFJeQ8MWIA+vpjNB?=
 =?us-ascii?Q?EIl1tF1oSUJNW9yAFZlFtEyAT1D/7/djef6zEdOi7CtRPKsrIwAKWOcIbIb+?=
 =?us-ascii?Q?JkNNAwJRjsq5ueve/EMIst8H8Ga5xKy2OK/P4+YN9sEys+wVO8KnVl64jVx8?=
 =?us-ascii?Q?scuyLHZ9FS0aJnq78fUGYoFwbKCjkJ0MSInTa/88WG5lFIxkzNE5PKOhseX6?=
 =?us-ascii?Q?83CzwriF+UizFfOvFBnS5UDV3crBa9m8LhaoFCklELphvXZD83E3q8ZGHo6I?=
 =?us-ascii?Q?l+cvcbAzbNfWawQdDKt1vV8toWWYCx2MlbWPteR4EEJezzMTV0v8KVf+nS67?=
 =?us-ascii?Q?TbnQJt3DMLVjX8BWJFtD1zKzxMJsYoq/KJR53ULUpbVJMmToBi0edcE2Ai/j?=
 =?us-ascii?Q?vVaqJz6Jmots/cfQr0OESaPY7GpghX1WH5Hh/pGrjXcgyoWrq12LvYyHL8EM?=
 =?us-ascii?Q?ThKK0zTonKbtOOuNaWN9JM1KiTCeYbEhWQCzihGIm/4yrMcGnLln0QKucAoo?=
 =?us-ascii?Q?tVTF7LB2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c11d73f5-b747-4034-f72b-08db5a6f7260
X-MS-Exchange-CrossTenant-AuthSource: IA0PR10MB7255.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 02:51:31.0960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BaD0j4X9LJJthhwimDfMB1g/uj7mwuxc0DHkhI+Y9ksPAcbHTfUH19wvUu7KD+O1svqoxmVAPDaWMdwC0E5DGryqeRV7TV7Mxw0VXJLyjGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5620
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-21_18,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305220022
X-Proofpoint-GUID: 6QR61vn1TvxUasZqAf1xqZ45Xqbwinp4
X-Proofpoint-ORIG-GUID: 6QR61vn1TvxUasZqAf1xqZ45Xqbwinp4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vhost_tasks also need to perform cleanup before exiting so this changes
the check in get_signal to be more generic so both io thread and vhost
tasks can do their cleanup.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 kernel/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 3dc99b9aec7f..8050fe23c732 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2869,11 +2869,11 @@ bool get_signal(struct ksignal *ksig)
 		}
 
 		/*
-		 * PF_IO_WORKER threads will catch and exit on fatal signals
+		 * PF_USER_WORKER threads will catch and exit on fatal signals
 		 * themselves. They have cleanup that must be performed, so
 		 * we cannot call do_exit() on their behalf.
 		 */
-		if (current->flags & PF_IO_WORKER)
+		if (current->flags & PF_USER_WORKER)
 			goto out;
 
 		/*
-- 
2.25.1

