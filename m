Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43566B53D5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjCJWG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjCJWFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:05:16 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506851F48C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:04:06 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32ALhqbl029130;
        Fri, 10 Mar 2023 22:03:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=v8a5sUISoqr50dJnX+Y8JANGyogcVF47yg6asa7t+20=;
 b=Z74ll1CO/atSbY17sYbfUKu66YxjJ5wTC+PpQvHdCL46Lzr/pCot5WzuAE/ZLJ08ESaR
 W6n35yfAjgVNxIiTCxO3KaY2yvdrIWsl+tX2xyKIcqiGmFS3fpvj44pB14Cte/CU5b6y
 KMUEh3/MfNFbxycVdtMGLThTDsqVk2aTi2rjyduwv+FWhxIQzKuf2hIKdDMI/ZNRLRlZ
 BmoognswItI4ThvcUEDhiP7XcklqugiRwtwmmIlQQ6nA/yEidbtUEHb8E+qVN7/B2R5N
 0+E86qg8smr5qzfALe07FEja8EudGRl2sny62StES9LowgO1tyw23jfTstCvuIldD2sO qw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p415j6dfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 22:03:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32ALuuYo024947;
        Fri, 10 Mar 2023 22:03:54 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p6frc9tw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 22:03:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAylnIri3inhGYAFb9KM3V5X3CC3hJ5RFQ0rFn3iZr38rLUqaWSmqwmFk+L/VtDt0V0w1CuSHGOyH6YPbSdX+9kaUhwTrn7C4R+Obtj+LJZWTew2mwSmuakWhMHZfKGhwNCLQHyJWe686HSYU5vlE5aoYGStt+YPHU0XR0AoQfxTX1x4IgEnBmJS3MyUGY3Bsbb13mr4+zUf7UmK79HnvxIRQSixVIj1y/lxFH+Bu9Y9M4xIOgKb2hn8ux+l4RxA33WHpqLO6iiAkwnc8Ob2FmqB11UGeyWQhzCVGtFnDYyDqpCGyPw7OGbbLS94Gfl0bFsOPDqF1t9+snSIWwIONA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8a5sUISoqr50dJnX+Y8JANGyogcVF47yg6asa7t+20=;
 b=TfCCvCQSh0NYuJk03cX15xsu2sF3C8yUpGxUeaI8WXeD6psOJwzi6eNrMEjv4m5ZeNnddAmJEDFWZpYbIwZSlSo7Q70y6IL18vLiWD7UwbE+VKrt0o9jUAsGt8O5JUTFf++A8JYQqmn7imo1KgoeCS/trvS6dlWJEMT/Fz52UAjCmFvNEyaiy8MN1C359hlFbZUO6Bfok2yvAIGVQc8lwNDlOWex3Cxzwr37m/Q7H4hWtw/vuHSrtc8o7/yyWkCQhNRf6prn0xCPBObl0Er12g/TOli3jA5NNk+MnDN79zzE7E4uKNuhVGLusxQo2S9gljO249JHJd0NfXxR6UEspg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8a5sUISoqr50dJnX+Y8JANGyogcVF47yg6asa7t+20=;
 b=Ap4avpHJo1YZbqejdBrbIkbGmjx7vXBlnzDdC/qkGry+AUUtmNA1BAYIg+osaYppraOGo8iYIeQMaVDOpd/9JzL1+UV7YlTXs3f6hLTEEBKUDshZcKbZgnhTFA4IMx9izyaOS3Fwy3Aw990XbfsWVG5iGhdyKTsWWtVxrNrizSw=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 CY8PR10MB6514.namprd10.prod.outlook.com (2603:10b6:930:5e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.19; Fri, 10 Mar 2023 22:03:52 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::7dd7:8d22:104:8d64]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::7dd7:8d22:104:8d64%7]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 22:03:52 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, torvalds@linux-foundation.org,
        konrad.wilk@oracle.com, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 10/11] vhost: move worker thread fields to new struct
Date:   Fri, 10 Mar 2023 16:03:31 -0600
Message-Id: <20230310220332.5309-11-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230310220332.5309-1-michael.christie@oracle.com>
References: <20230310220332.5309-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0131.namprd03.prod.outlook.com
 (2603:10b6:5:3b4::16) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|CY8PR10MB6514:EE_
X-MS-Office365-Filtering-Correlation-Id: 81b1b426-5000-40c7-2785-08db21b35573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qgnAphIAjujoWZMF3uBtTqUztRx4YRnXm46stL5m8WM74LSNkfASx0XGWgTbZPCX73P7bz9cQEDIT8sWhLwfaLIOpXBbUl2KNlLP/0WkzHoO7rc1MkxXV1pUXnNvtnOeQf/ghqzWsHScPVc2CsrL3+yBZPvwMEpLpenC7wueZhaeDJ8CNn9gfG1Qu2qw0phxneUS2gaziKTrgxTX6j0A76t+Tj+X/vowc1TvTOoQHZQ+iNhXN5M9xwBsnnIp69eMECCmNXEomHk2uxRBhvxBIKg0awkvG7vTqVAMtACNJS7xRfp5gre1JU0bAQPJxPXrnj/3csTbMpDssnjpI7gSTi+b/1G4kqhvvVAHXiQckiEkRFyuYNsH2u+Qf+i4tx/W1y9F8+8iXGlSefW/hFUHawla1W0XmD7p156m7uZRV1/56YI0K3EgSM4KAcbb3PiSWEoC3XB9uM1ZuAAOdBMFg9EiVwRnj0dYfvcau7BRkKT0HQ7zPFygNMLkRoSM0lLFHJ6fExoxIz6OT8UTvoW3vWDfTk8Tc1vSAClfrmzmb5sDvZBR/QYlTW8MwxPwICA+C5kr7TnezOj+fUk9WoBBhbk/xXIXjUzhmZ9hGnpYG8I30MycL/ogylOZBF2uUc4ftmrQA2OD1sHbqZ1SHybfTRMLVWsIGkVJ1r3mdM95YnRQ4eTTbTtwi71mLSm17Pqs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199018)(36756003)(6486002)(186003)(6512007)(66556008)(6666004)(2616005)(1076003)(7416002)(83380400001)(26005)(8676002)(66946007)(4326008)(41300700001)(5660300002)(2906002)(66476007)(8936002)(478600001)(6506007)(86362001)(54906003)(316002)(38100700002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dYsXqCKQQHx77nleTVgyWaaKcKo9sJafq4JULbmeErcg/pqN8JiqdRm578jo?=
 =?us-ascii?Q?QxkSj83PTY1i+w/FgQJlCUCQM0VtmMS8tI4AEEpJ5oFKlU4Pcn3Zx/j8ViRm?=
 =?us-ascii?Q?hjeEEvUCgwVHJMfWW6NLA+dckzKp70Fys/253TBYTwqKDTsGHxUDhfBztg4W?=
 =?us-ascii?Q?5msC7V/Im7c1+FcYLmBTBUhaTEdzpKd2hNeheFlD4Bp7Mljr/cfwzVXMqdIi?=
 =?us-ascii?Q?ezH5rj3orpqYqCTNFtGEtt76xBX1injK39EsOgC82O8oAKvWvVxeAPTVUCS3?=
 =?us-ascii?Q?MnpHdRJGJ50496SZu6CSWBzrgrziDK34frUsLTlOfJG+DRlk2yjqtOsMVRrO?=
 =?us-ascii?Q?3sQd94GQKjXhbAubZkruLNDAja8w5OWZ6QMYW4tg4l3ckXhrc3cch+L4tGYU?=
 =?us-ascii?Q?3COlhBjmwIrSepOJhPOzY2y7Svrya75Bd+wFq+wZSD6Nx2BD4NH97Q46B/ev?=
 =?us-ascii?Q?pdJiFjttpOeYSsa7m/B410mOZpE7ZW1zz5vvhvskARVDD82+JSKW8daOosmq?=
 =?us-ascii?Q?DvlUMoSHcUxHxpMTSluHGnBv33jAf5qIU1SpAJLXGNCjqW5+CjUEKVCfFmu3?=
 =?us-ascii?Q?V0Z5XMHxUbf0zRvqEo4CMAb6GySAEFwmCvHM4NxRPBOQu2xBR+D1J3nU5OON?=
 =?us-ascii?Q?a3F+qI9ZTyYxLaOlM5ELLC0yYzXBvYvTzYAF47372Szcq8tZp/4EcFf+uObO?=
 =?us-ascii?Q?nEI7SWZ7ZEVdH0NjyCamJ7CsexZnjVjthJ17QhpC2lOhfqwu0YUwBhE7ZGP+?=
 =?us-ascii?Q?AXsQJlFkC2Hlq2cZzzg5wVfSXx1rXGUzac+vM0VrXOvF+qZKkW/wYUpobLSR?=
 =?us-ascii?Q?qm4gqk1Li6k4qeBOyOEB2XpjmOJzjH4qg9ajTO0VmXwQ5DlYqpcZ2wOjjSBP?=
 =?us-ascii?Q?yAOppufY8IOpcQv2yQXhrFlGfQy/w9HSjpv0s3m8DR70pnzB8CkMKCKTSxFi?=
 =?us-ascii?Q?Tmmwd/Vs5/sTcBR5JFv3hhjBKvnYV3w0acch4CktP/0Ye5sbv+x/S+KN+0JF?=
 =?us-ascii?Q?wORHBsQNjclHnrs8l1+XmsZa22kz1nCZ4/Kbi5NvJJbc/knjs0BpueLrR7eZ?=
 =?us-ascii?Q?HtYlaUFCzb0Z+RRS01WsYYa86c+sAG6Ay1n/xP/sDh7TjThK3kBB4+uCSNOr?=
 =?us-ascii?Q?kSVQj+4uNxzP1i4uNIXBfQvqjkJICLkIyrDhI+W3J7HMSu8H8ksFuC4JQI/Z?=
 =?us-ascii?Q?Nl4tgU4V1BDD/RkOzysFXGnlp/pFFueczsCvPviD6PCkMKgfCPIF8CqYzKUv?=
 =?us-ascii?Q?MeFINLlgO7rnzq+T34oJfdUKyvcvLjnY5y1yXbQ5SqPuza+JIk6dLrmgV53O?=
 =?us-ascii?Q?XVPwalI7CXRONQ27Cs7gOcC1tTn0evNs1nizuXa/OQsXgRA00g6SoOkdTI72?=
 =?us-ascii?Q?UQu9lq5FnHEHbnpQTJ8vVh8UMT1yen64XnhQBF9ZqIpEqukcblCrkoSqmT7l?=
 =?us-ascii?Q?3i0NJ6YfQ9/AXLFwAHKrLkXCpe1FyjhQETxGhLg//pDK8TXfFkGs8SJXyeFD?=
 =?us-ascii?Q?yAzErJQqIsxrETMdNxVh+54zwpbkyfv4n3kUnG2N7eYsRrGLLGode5idxZac?=
 =?us-ascii?Q?eNLrijjq8SVxGq5OT1MQegJHPE9C8tQboG9kfkrlMoA+czpwyiQoKVUSac6F?=
 =?us-ascii?Q?Hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?shCHCZQg39sVxAUrjTo9Tk2ahqzr+bov/bOUSfgzXO3P1aY0akg4hkWpoWov?=
 =?us-ascii?Q?f0SMoD2xbDj3/kCyKzI67uycOpPN2EweIvTbKlLgwSt1u+tI9/wUO55dud3F?=
 =?us-ascii?Q?1iI8yR058vRUZRGxvMhK4pAr6lKoGa0f0ryFXM0unJ+SbbP6vSTbU9r5mZX2?=
 =?us-ascii?Q?GXpgtBL8tjDcd8YR27vBBhmqyeo+kBebpfMZ0xDXAz4lgNYNga4g1Fnzb8zz?=
 =?us-ascii?Q?EJ8W9zcd0xj5guxQulf81/PBgyVsC5BODVK8LtPN7e7hageFYk0fDJEYFAfG?=
 =?us-ascii?Q?iSktXwN3NPOrpXwFhay6aALB9O94QjuF3ZpffZijeMxRyZTvKsDeFKtej68L?=
 =?us-ascii?Q?Du5AAFhBzuEJc+f1OQuZMGZXaigYn0Vj1BDucWdXHb1N4IHE8PfG4Q+V712i?=
 =?us-ascii?Q?//iNuCws5UrhBLUiJQlBty65EY1kdLYGdOk5GLDg8WNzR6wozQQk+3s4bKc3?=
 =?us-ascii?Q?YA28lJRHz1SsjlC6p69qrLQwstfxj3jOFWJsyBxk6BFxh5TfEpm4EA6NtCr3?=
 =?us-ascii?Q?xETWrcmH1so/BPv040Sf+giSqDeg97K5nu5VUwnxzsgWqlhcS60/Tr/jVT0Y?=
 =?us-ascii?Q?+pfymcKshLeZcewkyvJJqtE/tmhcDKf4Jxqjq1JSIcO9j9f28kJjZrhGiGab?=
 =?us-ascii?Q?4OU7rFS19H3Qx8tDHxYAl9Gw8o1MpEAE0z4JXkROvRAQ3nuIlWWeHRDAn9av?=
 =?us-ascii?Q?5SUyOyOoHbJqjLFWFF9xB7zFoF1L2GyTD+v3WezkobS7KrSpYplwVFse7p8u?=
 =?us-ascii?Q?FfHGtwufpHNchDKhbjU15QXcJz2dBUvXMylybRGZzBjUkhyExUIAh/u1tRnM?=
 =?us-ascii?Q?+tQ0fUYX8BAWnxpNv33eDHQdEkLeVg01mFHyz/i1fPT//wkq5znN4F6rGJXq?=
 =?us-ascii?Q?VxvleQUiWNhRSgLDZnFF8Wca9MRW0VGYtt+RPl2g3CJJMHKgeD+n/5WGBhCt?=
 =?us-ascii?Q?TfOZEpt0XHMFMq2+kV2QrTA/r3W6Tn0LlN4X1Upsh6QYgPI2tLy2z2rqKSmR?=
 =?us-ascii?Q?Bs+1QDFWvnEYK/fmz4HgzJHp8ouaVUil6WyCfjLnB5efwOE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b1b426-5000-40c7-2785-08db21b35573
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 22:03:52.0779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CYmS6Cteqm7Tv6GN4bhzHIsYJcSxwttxSBHp1UcOQbSmqomrtSheemmPrGwsfi7ysq02lK8a9Dv/wNBgbCDAr8v5guRvvDT/oaRq0+6F0Kw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6514
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_10,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303100176
X-Proofpoint-GUID: SO6HY99pasH-R-4xaRhl0fUZuDId0vrb
X-Proofpoint-ORIG-GUID: SO6HY99pasH-R-4xaRhl0fUZuDId0vrb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just a prep patch. It moves the worker related fields to a new
vhost_worker struct and moves the code around to create some helpers that
will be used in the next patch.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/vhost/vhost.c | 98 ++++++++++++++++++++++++++++---------------
 drivers/vhost/vhost.h | 11 +++--
 2 files changed, 72 insertions(+), 37 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 43c9770b86e5..60282fe5c338 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -255,8 +255,8 @@ void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
 		 * sure it was not in the list.
 		 * test_and_set_bit() implies a memory barrier.
 		 */
-		llist_add(&work->node, &dev->work_list);
-		wake_up_process(dev->worker);
+		llist_add(&work->node, &dev->worker->work_list);
+		wake_up_process(dev->worker->task);
 	}
 }
 EXPORT_SYMBOL_GPL(vhost_work_queue);
@@ -264,7 +264,7 @@ EXPORT_SYMBOL_GPL(vhost_work_queue);
 /* A lockless hint for busy polling code to exit the loop */
 bool vhost_has_work(struct vhost_dev *dev)
 {
-	return !llist_empty(&dev->work_list);
+	return dev->worker && !llist_empty(&dev->worker->work_list);
 }
 EXPORT_SYMBOL_GPL(vhost_has_work);
 
@@ -335,7 +335,8 @@ static void vhost_vq_reset(struct vhost_dev *dev,
 
 static int vhost_worker(void *data)
 {
-	struct vhost_dev *dev = data;
+	struct vhost_worker *worker = data;
+	struct vhost_dev *dev = worker->dev;
 	struct vhost_work *work, *work_next;
 	struct llist_node *node;
 
@@ -350,7 +351,7 @@ static int vhost_worker(void *data)
 			break;
 		}
 
-		node = llist_del_all(&dev->work_list);
+		node = llist_del_all(&worker->work_list);
 		if (!node)
 			schedule();
 
@@ -360,7 +361,7 @@ static int vhost_worker(void *data)
 		llist_for_each_entry_safe(work, work_next, node, node) {
 			clear_bit(VHOST_WORK_QUEUED, &work->flags);
 			__set_current_state(TASK_RUNNING);
-			kcov_remote_start_common(dev->kcov_handle);
+			kcov_remote_start_common(worker->kcov_handle);
 			work->fn(work);
 			kcov_remote_stop();
 			if (need_resched())
@@ -479,7 +480,6 @@ void vhost_dev_init(struct vhost_dev *dev,
 	dev->byte_weight = byte_weight;
 	dev->use_worker = use_worker;
 	dev->msg_handler = msg_handler;
-	init_llist_head(&dev->work_list);
 	init_waitqueue_head(&dev->wait);
 	INIT_LIST_HEAD(&dev->read_list);
 	INIT_LIST_HEAD(&dev->pending_list);
@@ -571,10 +571,60 @@ static void vhost_detach_mm(struct vhost_dev *dev)
 	dev->mm = NULL;
 }
 
+static void vhost_worker_free(struct vhost_dev *dev)
+{
+	struct vhost_worker *worker = dev->worker;
+
+	if (!worker)
+		return;
+
+	dev->worker = NULL;
+	WARN_ON(!llist_empty(&worker->work_list));
+	kthread_stop(worker->task);
+	kfree(worker);
+}
+
+static int vhost_worker_create(struct vhost_dev *dev)
+{
+	struct vhost_worker *worker;
+	struct task_struct *task;
+	int ret;
+
+	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
+	if (!worker)
+		return -ENOMEM;
+
+	dev->worker = worker;
+	worker->dev = dev;
+	worker->kcov_handle = kcov_common_handle();
+	init_llist_head(&worker->work_list);
+
+	task = kthread_create(vhost_worker, worker, "vhost-%d", current->pid);
+	if (IS_ERR(task)) {
+		ret = PTR_ERR(task);
+		goto free_worker;
+	}
+
+	worker->task = task;
+	wake_up_process(task); /* avoid contributing to loadavg */
+
+	ret = vhost_attach_cgroups(dev);
+	if (ret)
+		goto stop_worker;
+
+	return 0;
+
+stop_worker:
+	kthread_stop(worker->task);
+free_worker:
+	kfree(worker);
+	dev->worker = NULL;
+	return ret;
+}
+
 /* Caller should have device mutex */
 long vhost_dev_set_owner(struct vhost_dev *dev)
 {
-	struct task_struct *worker;
 	int err;
 
 	/* Is there an owner already? */
@@ -585,36 +635,21 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
 
 	vhost_attach_mm(dev);
 
-	dev->kcov_handle = kcov_common_handle();
 	if (dev->use_worker) {
-		worker = kthread_create(vhost_worker, dev,
-					"vhost-%d", current->pid);
-		if (IS_ERR(worker)) {
-			err = PTR_ERR(worker);
-			goto err_worker;
-		}
-
-		dev->worker = worker;
-		wake_up_process(worker); /* avoid contributing to loadavg */
-
-		err = vhost_attach_cgroups(dev);
+		err = vhost_worker_create(dev);
 		if (err)
-			goto err_cgroup;
+			goto err_worker;
 	}
 
 	err = vhost_dev_alloc_iovecs(dev);
 	if (err)
-		goto err_cgroup;
+		goto err_iovecs;
 
 	return 0;
-err_cgroup:
-	if (dev->worker) {
-		kthread_stop(dev->worker);
-		dev->worker = NULL;
-	}
+err_iovecs:
+	vhost_worker_free(dev);
 err_worker:
 	vhost_detach_mm(dev);
-	dev->kcov_handle = 0;
 err_mm:
 	return err;
 }
@@ -705,12 +740,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
 	dev->iotlb = NULL;
 	vhost_clear_msg(dev);
 	wake_up_interruptible_poll(&dev->wait, EPOLLIN | EPOLLRDNORM);
-	WARN_ON(!llist_empty(&dev->work_list));
-	if (dev->worker) {
-		kthread_stop(dev->worker);
-		dev->worker = NULL;
-		dev->kcov_handle = 0;
-	}
+	vhost_worker_free(dev);
 	vhost_detach_mm(dev);
 }
 EXPORT_SYMBOL_GPL(vhost_dev_cleanup);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 790b296271f1..3a98c4f06b5a 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -25,6 +25,13 @@ struct vhost_work {
 	unsigned long		flags;
 };
 
+struct vhost_worker {
+	struct task_struct	*task;
+	struct llist_head	work_list;
+	struct vhost_dev	*dev;
+	u64			kcov_handle;
+};
+
 /* Poll a file (eventfd or socket) */
 /* Note: there's nothing vhost specific about this structure. */
 struct vhost_poll {
@@ -147,8 +154,7 @@ struct vhost_dev {
 	struct vhost_virtqueue **vqs;
 	int nvqs;
 	struct eventfd_ctx *log_ctx;
-	struct llist_head work_list;
-	struct task_struct *worker;
+	struct vhost_worker *worker;
 	struct vhost_iotlb *umem;
 	struct vhost_iotlb *iotlb;
 	spinlock_t iotlb_lock;
@@ -158,7 +164,6 @@ struct vhost_dev {
 	int iov_limit;
 	int weight;
 	int byte_weight;
-	u64 kcov_handle;
 	bool use_worker;
 	int (*msg_handler)(struct vhost_dev *dev, u32 asid,
 			   struct vhost_iotlb_msg *msg);
-- 
2.25.1

