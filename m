Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03B36FB4DD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 18:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbjEHQKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 12:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjEHQKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 12:10:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BA26580;
        Mon,  8 May 2023 09:10:33 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 348BIfMQ019079;
        Mon, 8 May 2023 16:10:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=v6W2g19Hhyq4dA0x+LiJEUcY3Lb6fanLdVdvDgm9ugA=;
 b=ya+kIfebtl1gD/lu3Xq4VJ14Bj2/gue+Y7engQ4Zm1G7OMMDMP6cgNBgIvXZMDa70pvi
 0S6C5GHWJtnG7NEqoQZkhUWWCYZXC9nS7so/h7okIyIiPVZZrUrLRfq8lk9M9SpSIOc/
 FLStVKiFlgCW6v4cg3z3brg0BKqfUkaw+OSZcrjVO0nHq9ulRvMby0Or+Lxs1DTkUfPH
 3GRfHzKhczekYzoxWr+6yj3k+Z6U/rTQfYxM347ptb5UkoZH+1T4MJaoZvT86diIKyqE
 n07TIxlbvV69P0wei339nH0u+tj43F67XqNOfT7u+W6GwxOZ7PrsFBQHB3BbUmzbJO/i FQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qdexdktfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 May 2023 16:10:17 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 348G7QYK037296;
        Mon, 8 May 2023 16:10:16 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qddbb6rjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 May 2023 16:10:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkNn0o6mQGJ6KNUwJlU1b2972ETObddXrtdb83n2E+wSdhOAtEzuw0OyAxSUfafd46gny4U2hKuJD6rrDdemSc9R8GdvipSrT6IXSzznNCEGcDKnMir26gGLBV4esnTDe3MGRT56tfLr3IPrdc0Zy7SD/SFppddd22So1hMKUqpWFf2J5zT/hThZ5b1dPE1DfHlfbfkSm/J2YluBF9ijKLt9Egn5owLd3lXgD+n/+yzivUX1fmFj4WvpCcbwNzBE3pBCNcSMASgpsK2+xlhGQCdmn9ESFGv92gP5p/Ja1tOIhZT0gg2LcI7zHNg+usiH2AuJ01tWqG49cbFkFsaUlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6W2g19Hhyq4dA0x+LiJEUcY3Lb6fanLdVdvDgm9ugA=;
 b=fN+VyAXRdAjxgXtgoxknn28O9UnQdJmaYQ9xyhSg59pJ1w63YNTEtExDkMs7ek9YxQS5mItGzm0gtEuQLYQriKgkVkrD6h13kparFYvus8lA2q5kZD3Oooj1LldoJmQPtvjmsShACww0OrYFU1vdmPnJUIAjz7t3USjLdtm5HQ/mIGAAkPn7QwfXKUIW5nlDGhiKYiQMaiLbHH38WLOcJBLa7Zpxf6IxOay+pck7h4sxUHEJ7VclRT7qPDcEfsnuJ3HpeqDl1k0nqtGf0VfxvuTeNJPkFbkMU4Wov0UwnNH/SwODDXl/10KYmhuUmewERhFCwwp7Xpuz2OBka3qNHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6W2g19Hhyq4dA0x+LiJEUcY3Lb6fanLdVdvDgm9ugA=;
 b=kN70zTeca6G8YXJ7iUuOIxd5Qq3dTJnbBJ/2QlaHKyjeHoR47puJ98v7g597Y2bjKorzL7FQx+hYMvHWfxVSbqCNFHA7Bt23/UxgTt/KJcwEYoiu8Dn4V8IaqbpymqNCeGx466YdGdu/4kcDtzomjIZ3OwnJ/p+o6faNssdCPjk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB6232.namprd10.prod.outlook.com (2603:10b6:8:8f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 16:10:15 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c%6]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 16:10:15 +0000
Date:   Mon, 8 May 2023 12:10:11 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the mm tree
Message-ID: <20230508161011.3fa7dozqg2oev36x@revolver>
References: <20230508145427.0edfbb16@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508145427.0edfbb16@canb.auug.org.au>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: MW4PR04CA0177.namprd04.prod.outlook.com
 (2603:10b6:303:85::32) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM4PR10MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: ceb9c9b4-dd00-4d3d-37fe-08db4fdeb55b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IGsCuwKbsnLi3craoIE64e5NzKjWIZVhT2kK7RfsP66GW3uiXA0qGZuAfWGrxWCvvpKl8AkiWDR/dUEahUmYGmoEEVYuyfHnXz5FAihSMUS6mOlcu/4ufEKh/Nl2QjoRDE7kn5qv8jAmz9xn44i9svOczlLcfMu0WOUGLJxDh/UlVMipS52MpxLzekhcDu053/8sD1woUULZUUdCXgvXk0EEyLbuglR+2J9zczNof3t0RXGMlSuAcBV/ZMYZ9/gh8GrT+rITn5puDJHhL6p6tu6dDfVMr6nTaLMPYLK2Y+v8GmOIoTz2CPE1La7+8xKCFC3M7jGn12c/NW5G6Dt3d3kwpkzhqQLtRotEB3Rw5Whbt3IqRa2Pml5U/uGbaIx8WmhqE91ORivvyjlyj0HYrNSrhUvW9gA6nVM+ukn/hhW+AzrewUNRCsp0ST30hHrJeUcxskR2uikKmISixdOXWPlvdmWWznbUmtay4v9u/1LUJ1kxrDHnXx2chgH80wVsjPhFFWie/CULOXR9mX0QkDMRhNZ3hLSXfZbMTGhgUl4BsT7XICoVxLrhcOL4m4rJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199021)(66946007)(66556008)(66476007)(6916009)(4326008)(6486002)(478600001)(316002)(54906003)(86362001)(6666004)(83380400001)(9686003)(6512007)(6506007)(1076003)(26005)(8936002)(5660300002)(8676002)(2906002)(41300700001)(33716001)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2wPKoIa5yFORHL2F/m0hlERE07EtgFmB6idsqH17W2ZmAgkQvEzInVaJ6L+M?=
 =?us-ascii?Q?YQVKuD/D8++x3ZhuojcuxDu9JQcfwW8/PfPVUyjOHQaFapzU7m9dhjVQEJ85?=
 =?us-ascii?Q?t2kifaOI4STX4lIJw8JuLYdF+vQYsX6bOt3/vlj/S6UqSi6qPZvvl+dMHrO/?=
 =?us-ascii?Q?KHffYMDB7N5JzTVFMt7N/CRQgeTfL9XKuBFPyIbpmec7y3sqxmttYAihlD7m?=
 =?us-ascii?Q?Fvw81zLHtSkcksI694ybV7zPXk0rBjoxyAE+PwccEoPKf4zFn7TOgPClhztE?=
 =?us-ascii?Q?CZFhRrqrB5dhIdRRQAQ6v1hS+yclVTUH26RUcE1UcD2zSyplxqHh9hgundl8?=
 =?us-ascii?Q?fXfXHOb/Svk4JKc4oV6siaiizwTKfqo0PPO1XProgW2udO/NHYlRxZ7FgHE/?=
 =?us-ascii?Q?1m3RLVzxu2PgiEQm+xgbK6TW+4syXNCNPwxDKRGTLUv7dMfi3kRJ1tMmlGwx?=
 =?us-ascii?Q?9DFAOEKMIw0l8OaSSMX7884WLfsy6ds8Y8xKd2DgdhAui5Dr+s5m2IgMmobq?=
 =?us-ascii?Q?ORuOA/QOwVTuhbUsyo3x4yvlFk1faXBYDwwrPXKipBv8BjIE1oqTJpmGL5RA?=
 =?us-ascii?Q?N7KJLQ6hKVj8E9tW73YRo3Ilq2ZU5lMEpwPK6d/mOmYuZ8n3EbFGKROdvWV2?=
 =?us-ascii?Q?qWIwhXjXLbhf6blIYxP+d+tFgF/RJ1tD1q2OYudsCYrrcLDtxVE/68MUB4cj?=
 =?us-ascii?Q?PP0irXVBCIyJQ+kWx3joZaKmA90JR4VB/UGEOYTZIzw41Op+XOdsnWNruIcA?=
 =?us-ascii?Q?U9AQaCweKkEqkzaCYNk/w9R5x64QqR6b5KLNE9+WSDCNc722LnVthG4kNnTb?=
 =?us-ascii?Q?6xR8lMbdn/vNstiDPf23OQp+MDK/LS5W0pQDo0ea2t8GmW9UE0lO2tBxDVB8?=
 =?us-ascii?Q?jvk1rm7in4BTfkvEwWPixjTByZNQhqQjwlvF8k1feYFGlaL8qJIuYFnPi9hX?=
 =?us-ascii?Q?x2/Lq0N/YnneJ5uGShFc3fjn4rjI16OLcii1xqn5Pw9UulLHlNiOA7/pGaKe?=
 =?us-ascii?Q?7J/vreI6AGfaqnkxEC/vWXfYJHSDNJ15bPC8KORozbbc26hCqmYbK/aJc2Vh?=
 =?us-ascii?Q?no6XCClBD7rB67FKwHuiXy6THNuNaGSOlDqqpRZXWjCuN1i2jReM1Jc28alU?=
 =?us-ascii?Q?W7zAu/KZduQDGFhoAx2FaDk0sI6bxWhz8y2blAlMy/dIBk1MhsjJj8yIvFIc?=
 =?us-ascii?Q?82K0a0a4cfNjKfqoUNBFl7ut+3ktLpsZnOPXyF7GhddSb/ywy65txSTVkPUK?=
 =?us-ascii?Q?zKOUaF7jfhGbxcNlbjchUAGGHTg74+POaddC8ncMBGJgHzPGLgeU7KdacHpN?=
 =?us-ascii?Q?ORZ3Wk6B78+EUJ22Pp8p6dB/iGFUKzg6l6GmEFVItkYFpRZKmn0lE48DvfBx?=
 =?us-ascii?Q?RYSHcXctfvbatWF+B2A+3E/ggAmG58vp+hHSox99YJU/KUWX5H7dk0LfaU1D?=
 =?us-ascii?Q?2zBXVJkePH7+Pok/9zptcVjodpKukjSP/SuU7jOwiW9KvCm6p7jlWj4E10fO?=
 =?us-ascii?Q?sd8UxBFP2UwKNEgQfgd6DwG0nhKw5VZDo3T7JFIqMw53t+rFizO/wI2tv2La?=
 =?us-ascii?Q?q7K++vZGY4AvCuagLpQhnFPmxVsDFUH8QkOL/UBm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oAcuWhFxKVrAefTy6ml1t3c+ecRcxSQFYHf3iqor1MxgdCBeUKe6a/tHi4ByGOo33fVNq33QalW7liEHSfpMrhcbg7nu3s/0OmeSgvhZCruNHKvL3rdihpO03klCRlm00K30SGw7NuVd4VqDFSM3CV4RXaJLX9+AMR4zOpovBDBvbhmpXgI8MLZ2hfpxIP0NcgyTPVqn8IOTvOzmULiXBr7VkiJuW55q+CmAXSaduVHHgck64WgPBYrj3nvTUUsmhyPXU0fpt+fumhCq78soHDLS/Xb1QYMQ0B24X4DxZK2F5GWnaUbN/eUEQPkQ1kMUEMozFDs+bHdKj+sjl9CW9buj47Uv8MJ4LpbVzFvGrKJce/vd9qkrkgs0p/oD0eOuaQ9PO6uq/+zI45UN+aEfTAYyTzyNhVcP53e37EUNuOD0YzTMVWg+nMgmaCvYBtoXGjYuHQMGSxRtKb67WIo0GKha5Nc7oJ30aziBb2etniUaCbYFhmu51bxKs5EdWlOzppoyBCWWd7PK80v3h+q3MdlOzprH6oCCYRXiOgX7JeGYjEVpL+4cj3XPn1whCiK7sQr8kEH3vX7X3JovKkSm0nLzX0UxO2KxnDrHtXUJzEdf4lTn0dcNAqKYinNXnwZg8XnMxH2qgeKKntx4dXMsCo+9xO5pahD3K3yetKZEvw7fakSBd4ov1aO4KRjb7IqKbKn+Ax7Cuzj3H/NQ4Yln8nu7WNmCKHd6ozTXbMSd0KDMTrRlKbJ5uiHgzKQbbbjI4Ihhg55HLzpj3Zkl6W+UO4klKf6k0B/n58cFjkPg5qJicQabu3lIHOqRFHfseAX3ezX0DOev0kClta5HVdgE5GWhfhQZfI952fnQ2Sc0ysg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb9c9b4-dd00-4d3d-37fe-08db4fdeb55b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 16:10:14.9942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hRosgwoLSh957qnHOIvjtdvhadhoW+bnEpLGh/qkTWi2fVn3SCovdECVCYEq6alEG62zEucYgSDiry0BrQN4hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6232
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_12,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=972 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305080107
X-Proofpoint-ORIG-GUID: gkfuUpOiRGv7Sa_PTeIvF2tdM2_pUUxm
X-Proofpoint-GUID: gkfuUpOiRGv7Sa_PTeIvF2tdM2_pUUxm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Rothwell <sfr@canb.auug.org.au> [230508 00:54]:
> Hi all,
> 
> After merging the mm tree, today's linux-next build (htmldocs) produced
> these warnings:
> 
> lib/maple_tree.c:6054: warning: Function parameter or member 'mas' not described in 'mas_find_setup'
> lib/maple_tree.c:6054: warning: Function parameter or member 'max' not described in 'mas_find_setup'
> lib/maple_tree.c:6054: warning: Function parameter or member 'entry' not described in 'mas_find_setup'
> lib/maple_tree.c:6157: warning: Function parameter or member 'mas' not described in 'mas_find_rev_setup'
> lib/maple_tree.c:6157: warning: Function parameter or member 'min' not described in 'mas_find_rev_setup'
> lib/maple_tree.c:6157: warning: Function parameter or member 'entry' not described in 'mas_find_rev_setup'

Thanks.  I'll fix these.

> 
> Introduced by commits
> 
>   ef6a3f9e88a1 ("maple_tree: add mas_next_range() and mas_find_range() interfaces")
>   3bd55a4fa16d ("maple_tree: add mas_prev_range() and mas_find_range_rev interface")
> 
> -- 
> Cheers,
> Stephen Rothwell


