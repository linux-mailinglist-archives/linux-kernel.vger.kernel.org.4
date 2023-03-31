Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D716D27F2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 20:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjCaShy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 14:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjCaShw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 14:37:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2CD1CB9B
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 11:37:51 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32VHOXtA007490;
        Fri, 31 Mar 2023 18:37:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=mBKk4NcfodLv0ImusBAuR3rGtvSjVwkcXShCFfwPU5k=;
 b=GzECu/eiiPtRe1JLT1eOXrOxByUTxJVcOc0Y5tBHB4WZKcsyq3EoDqE+YQHsw0MQgDmT
 o/HtgjZkI4JDJ6Iv9wGDe7ae/3k6vfS/PV++x/HCsrdfyweJHrzWzL2S1LDL+ji1oewH
 YfmDo3OxuJ02DGRXF3Gl8SUFXuIl5C1v6865Al8HT3LKE9YsjrE34wnbztfNw1vPnnDA
 Y0QIoTjw0okIKdLaU0l0GoHl3XoYH0DN/pQoduMq84ZGNxZyb/g7/eGcBGcN90d2NBD4
 f9PXIrcOy2sa9z2ZJ6ruUhK2kJNzbKZ8VVg+9IqHZMmRK9625ZX3vpJHO5RsGk4YZ6gd sw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pmpmpesfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Mar 2023 18:37:33 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32VHitbs018525;
        Fri, 31 Mar 2023 18:37:32 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3phqdj25d0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Mar 2023 18:37:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izi2p4Dcn36EZ38kfyQrg6SztTP/CRWxb1SNY0pBRA0zPfX7zF6D/0LnhMSuqXCpHbT69izZlDQqVNZWY1EFdmqVSVALN+ja/MznO7QTICR3+wgBWsNqq+sr1XIYJBRCcVRXoQVmZyjySVQ1Q8YIS4LLze+WMvav5JArN0PH73pveaB1u2x+CfV434vsD2pBdWTHqWbkzx+BFI43Xdln0eoiTIqg14rKj/cM3vx9GmZ3/Wm5LWeBgkYIscwAhCVo4nK1ntqFbSMAQOLApZC2GQW3XyJT+pLwwFRxq1VsEPoxPBK2rHsTOK7dr8wMs69GEp2jHB9oGaXQxAiTVxPekA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBKk4NcfodLv0ImusBAuR3rGtvSjVwkcXShCFfwPU5k=;
 b=Gb+Gs6tlgFXIubBYu/VfrSTGgaYgMJJ8y3cwbAbbNRQpUl2Abk8PeZ8W9DP5fzE+wJyLUDyluCJdcf2FslZeFZl2mjK0Rwr4nKT0YBlsXbpDISFEjc4bxnQk6CSgAeCnMltGA+f7LrnaXuE9l1aQAoXsksSzJ6hy2TxbvReEAppBDO4Lb2ZNyIKzXXXx3DxwoNUD7IMiOLoqds+Oj3a7n25H0OBHQKj/M1xfgvbBFH6RzupdbUdu8aRKEgN5caEnJwyXuAhETxho5Rdi3IpS8Ly6PRoGtylQuT3lcHaZLMLcNXAkh+g7zAnOtaL/PQzBbmm2aXGVgXaloc0upDeSPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBKk4NcfodLv0ImusBAuR3rGtvSjVwkcXShCFfwPU5k=;
 b=cX5SnBK0AGlsAr72bG463bXTjawWC6N5ysthRzP1j7plm7DmdM6V9+gQ/KA+HaondkkN3YVmpp6JtIOV3jlO9YWsn8RQcB85qmXAg8PCSNneRLBVhsPONdya4XL35+uOEQPaVTqxNq5Rw295QF1wR9oXlUUZgHNMUv6uX+QtDeY=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH0PR10MB7484.namprd10.prod.outlook.com (2603:10b6:610:182::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.24; Fri, 31 Mar
 2023 18:37:29 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a%9]) with mapi id 15.20.6254.023; Fri, 31 Mar 2023
 18:37:29 +0000
Date:   Fri, 31 Mar 2023 11:37:26 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH 10/29] selftests/mm: Test UFFDIO_ZEROPAGE only when
 !hugetlb
Message-ID: <20230331183726.GD12460@monkey>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160714.3106999-1-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330160714.3106999-1-peterx@redhat.com>
X-ClientProxiedBy: MW4PR04CA0104.namprd04.prod.outlook.com
 (2603:10b6:303:83::19) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH0PR10MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: 48b07ba3-4db6-41bf-16e7-08db3216fb69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rpZzYFFAFYTxrYg/SrdzSLoG6Y1WBF/Eh8f2m4fxbW2QRTRY5D4RS+ksonQEEVhqgnrbYUhvpILA6gOBhm6N18y9HUqhfvGb3nzwhPen4PWkuxk/55QXlD3c6KfaDKVDsBcLBA5srEw++kBt3KmIdVwsO0wv90xAKwPywMxzamkTftaCJ9ZdvIgKqvZY2KXPeX31hKgKc7r1ylAFI+pmsv1z0sRb9W2BKc/JZqJv19muK+AwFmk/Ygnukfi6b92e92nLj357y8ifAURfeoMo41RO9eSapRhog1GvWavSaPv4J7DPGfZK7HAWqYnl6NxRs2G21NaBeb0Szq7uvhRwtu/UimYDuquDwVwTCNai3/hC8QGxNy8rprOb06S0wSn3BV2iHx5h1tn+x5MfYsl3G8U+czIBibWf+evWWxlQ3vQNKfNUcdQiuzrxlC/Xn2jo/mU9sUdyz3CrnsKnrHQai1B5dNRDLrYfnrrYYXrWMAQmX1bzS7BJfR2OQw4OOQesNO44cj/wGQIWLjNosI/lI/DXEnnkcHVr0tjliU0FEWFyZntBKD99AP6WpzFjQ7CI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199021)(44832011)(33716001)(4326008)(41300700001)(6512007)(86362001)(6486002)(83380400001)(2906002)(5660300002)(7416002)(186003)(6506007)(1076003)(26005)(478600001)(53546011)(54906003)(8676002)(66476007)(6916009)(66556008)(66946007)(38100700002)(6666004)(9686003)(33656002)(316002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xDmgi5NIJQMrutiJkfI6i/nNHMkdw6mRqyqtgSLLXT6hb4w2JvUxM3hnZf3i?=
 =?us-ascii?Q?ok8NSq4kGR+oSQg7vLvlNeT5AG0IsV7PzknUIqhvjJis90reKN+8WeIliE8Z?=
 =?us-ascii?Q?AhENX5NVoy1D8AqNeLr8z1qEB81UiOBldwOM1cW9JhuITyG5hiN2E79xthA9?=
 =?us-ascii?Q?/m8LzPTdxGViUw8G0XjAKNaGqoKgS42BDgBH1TWN7GxeQ1kWPIJOvN4JGffw?=
 =?us-ascii?Q?09UD0LsTXgX26ryvyHAaRyoYQ5LwSvRdBTf9wBGxbKLJ30Gnp9MaDNwload9?=
 =?us-ascii?Q?gVwuh4x5hbRJl8nem8gNFC1N6PlqP0DrsHxCQXzLUe8VObUYkYbIgxdAKCDe?=
 =?us-ascii?Q?ba+dP1L40XTHA+uPOrEHMVVxFmBKLh+o1utl02HcyXuX1fUZJrWn8BzZyBkM?=
 =?us-ascii?Q?MssrAsy7d8VKynEGe8d69gWzBe0lE6njpVQMQY5rggv/CBp912r9tRehkDlC?=
 =?us-ascii?Q?FCEFte3L98TZC4tFn3FJ2Mf5wmD+JAik8O4MM94+Pmp6SmdGGMnNZ0aQvIe6?=
 =?us-ascii?Q?Z+mbJZ+PWpfIzYl7GsS+Ik1rctF5nxhUgzdx30yawh8leK7zTM7InB1Y5Gms?=
 =?us-ascii?Q?2Cnkjwmj+/nVjnomZtD4z1xOzoaaPaDWAhZ7Z1g04E4MSt4GXLMLRh/rHg2h?=
 =?us-ascii?Q?Ow/9JFQAEJFIwc8VPWcUfpUMOpcgTqDFDV8v5MB+XVCsB+uelgLSyKoGz/xt?=
 =?us-ascii?Q?IiIQVvbWwG8KCuxSjObCcIuW8jQ1V/S40/9ipR9rFrTp1Ki365h8CrDWjA0D?=
 =?us-ascii?Q?zJBeN4enELNrWmZ7avxCuSDjmxTQdS8PuHGoHR0dMPM+yT/PbvJY8QWBx4L5?=
 =?us-ascii?Q?7JWblb2wV/IQ3iRxFsYqZiL45Zy6AH653V1yR7BoFllVAfgfnZmLm9eTuN5l?=
 =?us-ascii?Q?LpBb0Kjus7BP1DUrK4YJ8AMIUtWnVz6zeghcEj8TTOZttqbmeRzTo2N0FTjI?=
 =?us-ascii?Q?7klp9Q4sNxxrfK50aKPbFiJDMMG6RIgtVSyYsQDx+pdH8b3idfYgh7Rs2VY5?=
 =?us-ascii?Q?SvnO8sEHkoGhCEQVek7GxRqGFOlqOzzbyK+iLBlNLXbiIFgUYstVusffzSw7?=
 =?us-ascii?Q?UsvhftW/EWUTf8iN3FFcsS6pAVAu0u1YJnKcAYZliOMgPgjni3Af3UWb2HVd?=
 =?us-ascii?Q?BuQ3RD8oU7qQqXphKeOjKx0dSmomV7cvpUSy8g7oq3DUzUVYFe5+VI6S/l8E?=
 =?us-ascii?Q?elXsrJAQAHcl/W9GFktLj1p1LvU7NWEd7LF41wtjFzHB1vxkgd1StB7x9PFu?=
 =?us-ascii?Q?r+8fMDpaEa51V0OOZB2A3mrSdWgimGrAcRSLEq0w4r7H2abdYwEAxBN0WRKb?=
 =?us-ascii?Q?QmeSsNQO9o6DpfEqeiPVzGldHsuzbsuDJo8TV+Ktg+ogM96x97v0ioroZ8+y?=
 =?us-ascii?Q?6eN0P9yTXa6cpFnwchB9RhlX7PzhxM1bp5ITPG1E7vfMBcPTxCiyatss0yxU?=
 =?us-ascii?Q?UqAw0xU2SnS/ZDb/AV4z0hP1+ClgBHBpN5OP8L2XN09A9Lufm0HT70F85648?=
 =?us-ascii?Q?G6b/byENiJLEq9LBwH131VKBqQE1lzAcFZZfQTMshJ7Z2yMb3YqMrTwVveJC?=
 =?us-ascii?Q?ZElqvNfcwiww20tlB9rgPmf7bgt3rdDpgFPEl1Y3d+p5c2TGTrpgbGTdCN/g?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?AfRyFaVji3kMZaYIBGcUC5SH0hZgS/25+kV0gyJVVDfvRlIDse4eZRqWx4BF?=
 =?us-ascii?Q?wmt6SiillhF5Dcpm9Mikf1Q4DX/y7S3eyfruPmKRQEToPbrpKbAR65lXARtg?=
 =?us-ascii?Q?CvUQWAwOJswC9f4J5DHz4rakNS10/oo+2w7ca3Y4aNla2h8KmuDCG7G14KvO?=
 =?us-ascii?Q?Bct14YxiExyuqbnfCmnUdv4Mbkbz9septCrVjobxyTP+GOnFu55Tc9TF4wfs?=
 =?us-ascii?Q?eHuP6PcbAa61StEsc4W7FavnKiG5vwChOaFg3fkLNn4aFlHitb8d6i4b4E6m?=
 =?us-ascii?Q?pvaLFWxDztdczWwwdMmgpgWn8FtcM/Fl+0eZCVKedQy7DAzxFVz6mKLNHu3k?=
 =?us-ascii?Q?9pkUq/rLmDlBJQ0TrifeNnbZhsuR7KLitbqzGafauKKpXLzkFcsu+8LIGX79?=
 =?us-ascii?Q?YIUvmKWZn5Sk69DefR7TaEsmU+3H1vbKjUlsXPOJu05OQJAxsS8TjdKgm5xI?=
 =?us-ascii?Q?TVdnWGc/RRno1Y+2g2JoYV6qMJJK/zzE2x8EF/97kV4HfO1/E6hYCm2Fm0Wf?=
 =?us-ascii?Q?v8c9c2BzQmtxTcfgVzW8MgBKG9HclkSVqSnqxQ4kF8tM8rzi1cHHaqeavKdn?=
 =?us-ascii?Q?gmWCgre5+ZYs+VV/FAmqQrPQG4G9YcaXXNAGzJFlkn1qun5RzwVlg4S7yDhT?=
 =?us-ascii?Q?azQF1WEoh65UALkmHlcNZXOqxb8Eug4z2f5GwWdT57t09B3Qp9d3E7ZAmZQ1?=
 =?us-ascii?Q?a57q/W/DBewuOyuV0C3x0AtqB8v1VY9MoIk7P4fNOvdSbLTkCmxZZ4cwLBfe?=
 =?us-ascii?Q?JY+YfsGB/OeCzqG1aBm6yXP3ZYjk4amNp4fSXIiBUgecwcOA+2uZ/l8haIk4?=
 =?us-ascii?Q?UgwtWlxUzomM+3p3pyWaHp+5wewFbqbLEjDTD0oBA5cNEleDRT/P9i3xJMGx?=
 =?us-ascii?Q?/acp97cm7UzaOMpUxkHYslUoi0JqU0W/NWoLtldiVTs+U7RznJ08lCZatBbR?=
 =?us-ascii?Q?FNprTsPlxjd8ughvXoRSwFpQthVZ2fnMB1S/C8U6mf4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b07ba3-4db6-41bf-16e7-08db3216fb69
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 18:37:29.4266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4cDxB/P6Pzl2cRi81QZtJC46jwBRLDaOKwLXdxEoXebWqaOFfcGEHZHTw7wRMG6g81K12RkWwFU9XQ8IQ2bdLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7484
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303310149
X-Proofpoint-GUID: SwXEDkTkjn81J9Aghm-_J4CD8IgZizGi
X-Proofpoint-ORIG-GUID: SwXEDkTkjn81J9Aghm-_J4CD8IgZizGi
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/30/23 12:07, Peter Xu wrote:
> Make the check as simple as "test_type == TEST_HUGETLB" because that's the
> only mem that doesn't support ZEROPAGE.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tools/testing/selftests/mm/userfaultfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/userfaultfd.c b/tools/testing/selftests/mm/userfaultfd.c
> index 795fbc4d84f8..d724f1c78847 100644
> --- a/tools/testing/selftests/mm/userfaultfd.c
> +++ b/tools/testing/selftests/mm/userfaultfd.c
> @@ -1118,7 +1118,7 @@ static int __uffdio_zeropage(int ufd, unsigned long offset, bool retry)
>  {
>  	struct uffdio_zeropage uffdio_zeropage;
>  	int ret;
> -	bool has_zeropage = get_expected_ioctls(0) & (1 << _UFFDIO_ZEROPAGE);
> +	bool has_zeropage = !(test_type == TEST_HUGETLB);

It is true that hugetlb is the only mem type that does not support zeropage.
So, the change is correct.

However, I actually prefer the explicit check that is there today.  It seems
more like a test of the API.  And, is more future proof is code changes.

Just my opinion/thoughts, not a strong objection.
-- 
Mike Kravetz
