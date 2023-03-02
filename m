Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDDE6A7931
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 02:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjCBBxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 20:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCBBxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 20:53:05 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F3934018
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 17:53:02 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 321NRcxW029067;
        Thu, 2 Mar 2023 01:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=2XHVGNXTlGI9/WuedaWuUTKoIWfvZM+UDvfGnWZtWcw=;
 b=wrXnvvbHSzDlQrpSJhej+kd1ea7kLHRjhThwcncX1bqUxvIBehg59RM46v0Tb5CC04Zv
 ZaBPMr8rxHzBkYzGwnUZildukWlLRUMMR13SVqjWVEDc2iM606AjQ6Wn57sSx9Zi3mUf
 ev+QW4qXJXgtILO1Rcqdn04YNpUs00hvj64qXgC13M9RMrqufxZ5oQNQ4a6TugNRQhoG
 4V2EctLtd5G5Z3av4K02MS6uvXHJMw+67RpGoHDVKnO1RVd+bJg+Ad+9SIRs8FMho0mk
 Q6jdnN53tiTsWMcJg3W9HhInf4unKR/NNnQ7sDHm4BViZ0IHX+MyevVPh/FF0Hlc6woG PQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb6ejf7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 01:52:52 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3221eJjq033045;
        Thu, 2 Mar 2023 01:52:52 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s9bx7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 01:52:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzrDmQhru+8nl+lZyMOHztl99KbAoFfZvyJRptCI+TQfOa8u8r7E754nbzO2k2M04OSxRP56l0LvWZmNWf4E8uj8EKE52fmXYTz6HVHCrVDAIqOsY04YEY6nPBjnE0iWVVB+1Rmb1nNzebPt9FEfkZx1hZE8ayi53wSAAy6DDqOQYUv1LJvePo17D3PDMce09pygXWJlLHXwcLxJdI6a4TG3/HULYPsI2BYkHnDzHN5XyXXd/Ep4PEF6oAn4Dm39jFk/aAbwxuqObD7wwpjNwEcAS3STVhYzF01wLgK+6ArZZoq8gn8I/vZZrI8RFTAVzjHvGVkWabH/blr5X5Ll6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XHVGNXTlGI9/WuedaWuUTKoIWfvZM+UDvfGnWZtWcw=;
 b=FjRgmJEpa9FxqyUx0mkyERYrpM4JdoGaSSfEso73eM9miQn/cfhGYuiwnvuUthLVARXNNAAbn4OgQMteakZQcL2erd0q0ci+2DNk0FRWnxv+6RNCkayYwD0HXF/CO07tT40r6InnJbzpVH42+Zp7pXYVu7/tST5WVa1lD0vczerW6yTEcz3251UisfzhGWkO/JoeRa+6TDx3bA/YUmArsEHC/3tnDmDP1YszU4R+DQxFluUOnzX33MyW2U3VNeGnx1fo5a0Sof1IwKTYOzeaM14SFpbL49qPc6gp81VLj9Hvmxzk8Ygmc2dsnNGTT+GWYCPQn687J5lm4Lt0kzYixA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XHVGNXTlGI9/WuedaWuUTKoIWfvZM+UDvfGnWZtWcw=;
 b=DzsCkPdZzoU1rpnZURXBKq+Oj4/BAu62+e0c3KCr/zcCUbeEas0lwWZiwRtnYlTK0aJJmrLyP5ZXeGBZFwj3jCRGxtoOU7hPeZj4JgJcBml6junGSE9v5NPaqQMt3HucX7qnMJXLd2rGjTo3RdlY68wMfeV1kAqXVyrAp6gC87A=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5123.namprd10.prod.outlook.com (2603:10b6:208:333::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 01:52:45 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319%7]) with mapi id 15.20.6156.017; Thu, 2 Mar 2023
 01:52:45 +0000
Date:   Wed, 1 Mar 2023 20:52:42 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH] maple_tree: export symbol mas_preallocate()
Message-ID: <20230302015242.xi3y53okc4skmonn@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Danilo Krummrich <dakr@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
References: <20230302011035.4928-1-dakr@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302011035.4928-1-dakr@redhat.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0308.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::19) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BLAPR10MB5123:EE_
X-MS-Office365-Filtering-Correlation-Id: 964a86dc-6f06-4ee6-e306-08db1ac0d123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zDJPohM/opQsThFiJ3HioOtuZnCBv27aYf96MlftfGoITC09TD/YN5mMVe9rD0wdCIjOOsJODhLIVJbf4cR9VEf6JN4PtlWc21Xn/xPoOxjanD7bhVXJFn7xGz9NZp4fIckrCXTVYHJMBMAG7tN3ivgeSFppcRi/r42WeOUSMZlHOt8GcmxnSkpfke+z9UiGZNpFF2cTQz95AkFlqJlswXl9kID2qu7ny7xcVafyrm0jkAOvNtDJZRN0DI8OIMZooxEAfL3bxIBQEWo9PkccDWOLcf7VkpSsjK+oPjvoX6uq4GyuhYC86/OjG1+Ci+EGngQPuKzl2pvMlaf8ORxFlclQ6Wu1cJTRJs5ByWmoTHhOhxTtu1WX/lfg87K91VnQ4axAkYmlOZTV48nW63K8gC3GRj30XjJ8vmxuIDLPlu0tvX/O2F2yxO7a7KYZiCuItqOy7IQdSbLAeimcqbg9hm51TcQrHaHd8KL2mKsrAcjqdzB2YvC83XoSKOnM0pBr2VdX1lFevH/JIO1wVDLFbDIgFVVx81fUpkECxOPjUsQ84TJOM7+F3ZW+ZWJ1aOrqlhBdaTO0kgbS31KUFbxc5VoWpFn/Uo85zvpp/lWx7jcZlxQeuGshINzSmFQBPXHpU+0b9rx2vFVbB8yy31Ozshtjzi8np09oyqX9XO3EI9ZtO76+rIzzecjzb04Nqu49
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(376002)(39860400002)(136003)(366004)(346002)(396003)(451199018)(5660300002)(41300700001)(4326008)(6916009)(66476007)(66556008)(8676002)(8936002)(4744005)(66946007)(33716001)(316002)(38100700002)(2906002)(6486002)(86362001)(6512007)(6506007)(478600001)(1076003)(9686003)(26005)(186003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jTbSIX75Txna2lC3PNRJhWNs1kWCLmo14TwnFj5Iee/SCpFau/VLdZPaHWLl?=
 =?us-ascii?Q?LXsEIEc9/KgMelD+vRCPt2xBHI1V/qflRdnshyxqBUrou6aHzWgYo3Y3oacF?=
 =?us-ascii?Q?YV3x4IjHgMOwHiO73ceoH3vkWDZMVHaAVo7TLAmUr1hUOLDtFXPZtsSN3w/0?=
 =?us-ascii?Q?hw/9MAp9rPSy9zeD5gDAP0qTC2e7vDlb469shiH58XJRb2ocfb6keJ5gC/Ea?=
 =?us-ascii?Q?kpeKoFRR5VRUqPQhak8mkcU9lrUdprQPfvu64i4XfRPe335h37c9TUF9dS+X?=
 =?us-ascii?Q?Fu1UA+S8rIPnj67z7p7gGUfNISGhRgAGgnqwCjR4q3rhwjdSFgrjYoHTOe5J?=
 =?us-ascii?Q?lFYF2JvNN7hyISTCxMiwxj+g18krZi54t9zF7hK+q+qYlPbvvTQqzYllEzBQ?=
 =?us-ascii?Q?rix2fIkGWGCoS5NGoOB7XV36rBzrsL4Cno/V7txm2A5AtKTf+0Hyjltu05gG?=
 =?us-ascii?Q?giUxTTBOvZpz6bGsN43el6Cc+tbDM/+LETrI3mtB7Colp0m5CBSGJ/+aqAwO?=
 =?us-ascii?Q?FU7ghcITGf8y2XTIfc8zez6RXD723Sk3sqs6MhJRagB5kNksq2aFx878vt4x?=
 =?us-ascii?Q?4qw0W/z7TOrlPlreGNrXHyPVqsleCM6Kpm/BEO75cAelGF3M/yeB3SwOc3ST?=
 =?us-ascii?Q?Wmok5yZ05mCLRVIvdf983d/C/4gC5mVP3IiXXnc/UO238gZWP58Ykm17ezuf?=
 =?us-ascii?Q?4G88+4INB3lw9PSW1UpNwmWsJbo09yxL+P9+wb3uoyc2tPY+dng0CQm2VloW?=
 =?us-ascii?Q?yTMkFvCEce8V+d/tCU5ENqAjRM722wN9Yyx/dZn24ATVKba5wpCELFdgVY3g?=
 =?us-ascii?Q?i15OnaU97ZxgArrYNQYqjqOhgAVehpabafp7DgPI1qcqB9dQg16HwKBSSOlp?=
 =?us-ascii?Q?Q7wyhkmhdOi2cvLTIrD0K/BVC8IHSP8TTJryu4q//p9MEBi7QBm6ItX/8RjM?=
 =?us-ascii?Q?muSr0aVwJ3reHzo+ZjVDxjxBf8YsJooP4fAdtb8D9DM6LrNH+88iRPNIpc1N?=
 =?us-ascii?Q?6zuxY3r3IjWYcSED0VN9o7NyAwT3+qb5X4UXkczZytUrAcKaGD7Y5uiRrdGN?=
 =?us-ascii?Q?IkJllBgkX8XwUjGYbZW451qIvVL/2/sGZe1gtFORR8+gPikDtZFUc3EAa9nU?=
 =?us-ascii?Q?OpIRW5S+ItGxiK4Et5HxXdqc8dZ0//ShHDJGzTQ0d4w+YwV4pveYXDSDkPmq?=
 =?us-ascii?Q?7p/iGDO383ybEjzFgaylYq4O9XfLsiqG3veiA2A9JzTWVxG8yh7vRZ8GbXuq?=
 =?us-ascii?Q?tldrp4fNM9hCLusxLRL8Ebu+N7OhnfUThVnK7Odkg4gNeL6RvY6Oz3FePKNC?=
 =?us-ascii?Q?1Igy0B/AXj5+dkDK81kiCm0L7GNLK7593WU8c8Vu7whXTh8uVY2fTHQDqB0F?=
 =?us-ascii?Q?ilaD0QIwajspjm+HADYzdI51disRZvl6bOI5H1sU/B71GX27DjNd1Q/S6BiV?=
 =?us-ascii?Q?Ieb4SGQ4yv8otrmzKPAbbstUBVzGYTRVFx+cDZCKX0ogvKT81UYd5wrUVVUd?=
 =?us-ascii?Q?SqlaRXH/3h4wkzKh9ttU/LH+u2nY+vjbuo1fDsLhAnkFSxqh8PO7Wtx8N2WK?=
 =?us-ascii?Q?35eKZgOw1DhdEUmXgf0fhxTtuiXlu2UvLOmwqiAl3UHeY5Rd8WTmoAWjGMO5?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wIyCcHZp+MWa/ERe/mEd1nIts1wjuwKoQTqEPkyaWc2gl56pT9gSQOs1yWv3ulS4S3+U4gy1ZTMrypFXVJI5oiogUVWnkmrsuQjSRhTGMJyA1IpkOwraClbaIq6N/KvsJAoWnVi/qC/Njupa3D0IUcX8errSPDLcwgXDDw6wdZ2JgL/Q1p92y+dDqX1HRH/bVqXJcVauLETRtfT4xJK8UGnlJx82jumcYnoG5oIfHxPIe2FDYuqow6q7UAYqQv2jUZ/VB65GM6kKiyVPUchE0nCOSTvvBAJhgd5h7EwXqctGU2hzvfDh26gjP3PERbNM5ysSHX87THn+0m4yNEPPvzrqtOb+0MgmcIRZLZhqt5r6rdDsV53szcY3C6QHyMK2mWE2BxU/ysbVqb32lObxtJM1h3hpbQalHfwJztKfdCev4s3JQ4Qrh8U7I/8zP/zmqg/dH3zC8wH29asRhjv38CTQmpN6OyV0vVfh0Pyt3Wtc004Jl0kC4EjVinQie1vme2XoK77/QXdxx6Wnc/tcy6kfeqhBHAsQeztYNTkA9vqn5vRyG36glbFjpfieFBWUfY0vNNZJgwOuNYOdCxDuCqewuuhE4mBx8zHhu8I6/OAVKUj8PC/8N9LiF832nKiBaezUCBeC2UgiTnma15sVRkiQjrlafMaL6lFkfv1KQP7BLQeyLmlHZau6tZwPLRXuiY8xBq5Goagw4YZmleAL8kBc744iQG74v1Pp9UZBSIB1MRC/asvT5xIsY6iZQR4tQBnAq/fTUSCawrux2LGEIZWGgEyo+yIfp+Xsr9kNP2OVKmln01t5FQGITF3K6jEW02Csaq2xlIxPxVtC2PWfhldm99S4sZwTo/JFm1vNkBv6s2w667M5JZJe6Uozj9Qn
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 964a86dc-6f06-4ee6-e306-08db1ac0d123
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 01:52:44.9296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cvYCCiRTN6Z9varTAxmo2AveDOxlXAKpHIMABHqyBr/JaX46yNIj9Yj/vaA0PqkVF9mtj25KqESAoxbjegxKxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5123
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_17,2023-03-01_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303020012
X-Proofpoint-ORIG-GUID: gQdRF79rIemAl787gVBZ9KAGzck39PQL
X-Proofpoint-GUID: gQdRF79rIemAl787gVBZ9KAGzck39PQL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the patch.  This should indeed be exported.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

* Danilo Krummrich <dakr@redhat.com> [230301 20:10]:
> Fix missing EXPORT_SYMBOL_GPL() statement for mas_preallocate().
> 
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> ---
>  lib/maple_tree.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 26e2045d3cda..3bfb8a6f3f6d 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5733,6 +5733,7 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
>  	mas_reset(mas);
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(mas_preallocate);
>  
>  /*
>   * mas_destroy() - destroy a maple state.
> -- 
> 2.39.2
> 
