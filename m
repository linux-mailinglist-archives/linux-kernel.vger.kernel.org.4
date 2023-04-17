Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2266E4C3C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 17:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjDQO7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjDQO7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:59:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E7244B4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:59:08 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HENCTp025179;
        Mon, 17 Apr 2023 14:58:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=6Huc3juX7hvus5ZNIPGMk8ubfpAkuivjGcNC3XbAdG0=;
 b=VV0ZL11iM+IbjRU68abLSPobzVllfGWHYE+ERJLZbmlpnOMtMOnYP53misrRdii3aqiW
 vQTJILfdEiS0Uz/+/9GF3l6ZbkK/S2u3bnbXJXblyWlPKV6UNAcD2DYHkptsoYSZehCD
 VdeF74W8Nhk9zrd8T606G5erqg0DkYcFgMlFP+ZoA6lATYY1JmTUJxRpruokzNKlGDg5
 GherWZxmeYB0tN3JMUekjKUl+edxCOxU5ilhaTk13ZJPpTdF3YzHsEktrz3SKntmDpK+
 s/vYONT1d+ZJMcpQUbl3NOn8sfdALq4pi/YeXIfJo+DeZFiqBP9tpRD1PzwnJA0aZ6b0 kw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pyjq43at4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Apr 2023 14:58:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33HEDNO4027736;
        Mon, 17 Apr 2023 14:58:25 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjca8ced-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Apr 2023 14:58:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAfOE109sFNfej066gUVbNZru2Wm+hPYow7uWpug6PbrvLPSxO3vIkrFpfgjibWIGn2ZMK0cGGRTNW5YCD2LcuzFUCn3Hb+If9xBv8nXVbKiOm/reobtELnMBREcPwOyM4OyhY4CajfqXBdT2uXDidX98Hv6xDYU1VfPwpHDyx2dlM0gQGM+R1lXhGH6O7GHQKNHd96ub4BdLr0U/kuBZ2iFK6t/MJC1ggst0ePRXV7sTUCaYBSfkeUGUoRL6RIHcxBT5s+n1qtq8HH6ksklpOpVqJZTFDZhCn9l2ugH3fnHGj2Ry+/64F6RLCW/te/A0I8h3Ug61arHSgmmhieu4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Huc3juX7hvus5ZNIPGMk8ubfpAkuivjGcNC3XbAdG0=;
 b=b0k2c1CkWqXnKF5p3V2gwgDXqXitlVwf8+c4xgZecBU7MdXPY/Xl2gpr2MggihUjW1z0eYob13QuCgPlnos2XC4uTyIw4rAIASw9avN0Yw5ROLHsSLWmkwyxNd2L4QlMlnVlxLKChIAw7zqpqpgYMEuqVYCVMZ7Az6IhTV1WI+BIIj/MApcPnlyHF5dMhau7TlL39npEYiWX4blLa6gBbxNGBbro0jjD7FPl82HFWl6tfEZS2MgLvNpiS8JYcL+ve9sWx1PjuAHAc4fM5kz023I+PkEFAh4rInO0kMrSMgjYH5t00s5lwK2fNuj3rLXT8ZJJyTp4a678Hs9afR3rUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Huc3juX7hvus5ZNIPGMk8ubfpAkuivjGcNC3XbAdG0=;
 b=q90GSAhkfMcdzfg6jbqVSaYeGsBdZ79Z06xz+mIjhBM5rQvouKI9JnpA7qcRjPWUpqGFtScROoPH+b/L+8OWzci0xBHkCs8xp4TSJPUFFcXoPZCgIhvBJaMlvDcpeQNYGADukCdjEtEiimg8sFXbiJgpWkIspeBQFzWlUxLd4SQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB5810.namprd10.prod.outlook.com (2603:10b6:303:186::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Mon, 17 Apr
 2023 14:58:23 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 14:58:22 +0000
Date:   Mon, 17 Apr 2023 10:58:20 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     David Binderman <dcb314@hotmail.com>
Cc:     Peng Zhang <zhangpeng.00@bytedance.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
Subject: Re: linux-6.3-rc6/lib/maple_tree.c: Two style issues
Message-ID: <20230417145820.nzmxs42m67pyxpnd@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        David Binderman <dcb314@hotmail.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
References: <DB6P189MB0568CB290411B23A176511239C959@DB6P189MB0568.EURP189.PROD.OUTLOOK.COM>
 <cd5b6ce1-3c2f-97f5-64c5-4c4c90c40627@bytedance.com>
 <DB6P189MB0568A487A016FBA45DF108A89C959@DB6P189MB0568.EURP189.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <DB6P189MB0568A487A016FBA45DF108A89C959@DB6P189MB0568.EURP189.PROD.OUTLOOK.COM>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0077.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::22) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MW4PR10MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: 783d316e-adf7-4bc4-885e-08db3f543097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z65oBxprRJQVEFhIUL9sNMfy1Apz6zDDeMnWYLo6HNHNNN9mnoKaFCdaaHPn5ExElcpoyeGNiYJsbZMyfK1fHHhmtJ8J4J74ZeAej75x3rkDu7EHH4Fr0RQEd1vX0o9Eyb5Qv98RPmgQqnTCn357HvaSXVlqOWF+Zt9ViGnQTNzapEF966tRj1iiZqDbpjpL7uagdPvsiRRgmz81JBWowCoiqMHWF+Yjo//j3nj6wvlfpuyUcOOqlOCU0JXohWo9E8n7lC2Tqi+hIihlPApfRVlqnDT+8SBA50PfJkoU+wS0a+cgZU8q7cRw5YnuVuclHTRLCIwz3EgBjvkYB04XC3oUgXOS7tSMv2Ry2UC/ar0cdz8EkSN/pH56sGKkzmZraqrY12G6mJAqamH0sgbo+2aVov5aSys227HigysNVG10BnF3foj3oU6nPC7Luq/D0ZEABM/JTam1islky4p+/C5HbVMsEwjOUNHVBG4URB0RdDPgwzYzNJjeL7JK0Cb1i2mPUtIXP23MOQB1/XQKq6XTA4/dfDsbLfWGZtOqU3OPbmtW7dqkQizat8x54+nl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199021)(26005)(5660300002)(38100700002)(1076003)(8936002)(2906002)(86362001)(8676002)(4326008)(66946007)(316002)(41300700001)(66476007)(66556008)(6916009)(45080400002)(54906003)(83380400001)(33716001)(186003)(9686003)(6486002)(478600001)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?LfAFRrhto3xTYAv3zbawmtNlniQx2YyrkkRgGRyPqfONwEcyHsuSNdj+Ki?=
 =?iso-8859-1?Q?G3iVm7AiA8KGhiCgsWMw7HbmrFaVfFBnua4GKILUnQRtS2VGJD2zghaJdJ?=
 =?iso-8859-1?Q?oXAJU7gY8eD9tu4KMMCWc4NfrEeltDnra7Yec2tzqEFIvxyBs3xU8dAYMS?=
 =?iso-8859-1?Q?JYdQVqyP12NHI24H7m6z4mMZMznSqCJMs0/f/rLqKgrqzQPsha0NxrkAxX?=
 =?iso-8859-1?Q?ya0/eThGrr53a+gQGe1PZkKVBPDgTUelpc1a6yP0m8ZGZ0dH2cYBP4euFC?=
 =?iso-8859-1?Q?kBH0jIQ9PnXTzj3YFcc8+le9sqWMBseB3dsLtY2dnDxBVy4nx8ont+t2jA?=
 =?iso-8859-1?Q?FF2wUUsnnlwU73Aym6hnFIxcBa1T71/0jFm8uuLT8dbqCRrileFvtXtu0a?=
 =?iso-8859-1?Q?2Mz6qZ70Xi0334n9WFzYG7gQAraAQe/H5Gs2+I57mKmFY0qJTzZv/0Taxn?=
 =?iso-8859-1?Q?smWoRPrcF1Zb076i02milzXBktp6IyjB4sRlCqNCCdY5A/FU10qwFH5I6m?=
 =?iso-8859-1?Q?yLBzdoMjTIll5mENjdR+mV5IbX9bXMVB2ox9zxoM9aqrgj1EHYS34BJ9m6?=
 =?iso-8859-1?Q?pvDXGjqBdWuPxHolNpyW1NqPKQLy3qLeyxF2PchRzuHnMzk90jucZBbNIr?=
 =?iso-8859-1?Q?aI+6T+RJHaVv9DmBnou7hql/tbjO+V2ZLAYqh3/vvykISr4xUzJGnzips7?=
 =?iso-8859-1?Q?PNZQhG5JNs1+foTrlbIXh44tspwLEzRUl58GBd/3dE7AULg/xy8lEEYCI/?=
 =?iso-8859-1?Q?m4csOLZhMhuu18kxvHRkBmlD7G9lRo9sLcM6bLr/0QTACyxR/rRumMjAZn?=
 =?iso-8859-1?Q?JMjg/j6XGNB0VFgwYKYTavn6dcap7cpARAp91Yt/AUR0eyNMPJM50tF+o7?=
 =?iso-8859-1?Q?isZ76NyF2HV1OajsS1fsq5r+s55cFm1XexLq8QH4yVLn3MVOgPMzHWX0FS?=
 =?iso-8859-1?Q?CVQDQz9pAR6DCpOsS48UIDr7maC9GGNWQ9T30CEIT3EfEDsVDN03Ki4J45?=
 =?iso-8859-1?Q?r5jhnLlNCDP/OVYBMH1b3eozw9I5Z8D8dBwRWOUzjrJRaF2XND60XLZ/fL?=
 =?iso-8859-1?Q?DpbrD60OSV9LOjNAmvlMVn7kzh0mE3zAShrkSN4HfDuZqsslzp6d+qOeGK?=
 =?iso-8859-1?Q?XLbPMS6Ml1Y6hlKswzjI/L2swZ3YljSzB0FfcprJxZpl2MvYdKJ9hTzOnm?=
 =?iso-8859-1?Q?0e/ZWAV33AMIO0Ad4sWj0SXvbvnUFNifJ/yFfkOStt+qGcKeOc+X2IYqch?=
 =?iso-8859-1?Q?BDpfYqhIBvsPIHA72Riby+Y1KBVdLs4Q+RG5Qq2T/F8SLDZysEyLE+tr0d?=
 =?iso-8859-1?Q?JLwoZotUfOywFm/p+RgiyZQvR/LUlnncTAFmhZqJtIYcrLkVq0rWULVzjq?=
 =?iso-8859-1?Q?zKVtiFNlhHToa0iLi8/tTJ177ZI6JS0K5p84YMceDcjed3rILzRJ1yvird?=
 =?iso-8859-1?Q?Y0n5L0ybpDmTNDwbphe+Bcq5wIe06U5dVJvYUmNuPnnUQ+FrB0d4xuvgzH?=
 =?iso-8859-1?Q?R+Bqn9tkr1pDaHOIMEKhXBcmWN1CS32T6oWjN+efprCpguMcqMI27Hn+Ud?=
 =?iso-8859-1?Q?PxsHuTgsV/07/e9AO8luSeYnwQ18T/Xj2Q3+eUao5HyMzWlYE6N/xC5akp?=
 =?iso-8859-1?Q?sNlWRIU+f5mA/U/4EaKqExlc6Z8QWFZQ6w?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Coh05Vp4PSqzVZGM/k4FNZkL9DZ320XNXbXi7irOt+D3b/vZMCy4BFcYQdKqwqv3LsbqOrH1Ve4TFiTU2SO2p1ggnofBY/uilmkKXUd12sGcYLOtgUWZmMgvzMejqYPVE+1y9wYueORLro49DY/PwiR0ad6ejLDmJ2JjbNJ01eOWL1SEAtud3j4FZXOg/M1jtzN3Uf0ZrYDQMyVpOk+VMSwSxNve++n6wIh5B4c9ySHb4L13gTRccovctnTsnDvfYHJhU6J7wZDE+85nN6X4w2yu4n3Z/bGwpNfPju27AqKlrfs1A9wciFHxAx8CKGfBSm0jvFVpCYO47yrtLW05K77hVyeGknGCVZcdIxFYHhiNZygkRRIF65nyhpW0FFJnXCxsdtn6Tp2LKaZECijmIWFecCLI74JBgJfoNLvGb52zCHAf307DDD4qxrlfRG168VX7bh2/GkDS9H9v6ffjReoDP96HfO6RSHwmhCOU7SiIaKHPoWG/oKpIyVs+f4+dng2PKgLDXO+QByuWJgMjUedPGdUi7reO5I6mgkR3iKi5xVAIL13rmSBsthrznwxUahgpRCwJ0lcf6ouAN2SZSJttZ4JUyOltr0JoQbQizMGOKAL7zns7VcR7Ocu9EzC3pKH+KBFff4P5/3Kwl4NeLXXdocvUeNS0AEzQUzONqFemnGLkbYZGURYTT4B/FCJ2n4VLrP5ledM0Mk3cKOA8z9OGLQIawo1bYIBr7SVN+PeRHtdYXBIUDJqQ8liZmspU/bxrIs77eaAlvWv9v2+vqxzF9/Fn1SoFnyWbogWgJLS55gAcB4rTQPHKKsoBevrCbYUQ1Ghag03taIpnyYN4JXpoYOC9zyYE8uaQ5t9gX7CLIBshmSSwAIj4YJQwR0SqNr+WoB1rrjgv5lqE/riRqms3rm6trlbgVpHkK60O30k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 783d316e-adf7-4bc4-885e-08db3f543097
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 14:58:22.9183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bcXMlUC8WEn9N/XcXKm8X2fXjcDWWN5D2s0WUb5iKAVFGoCIaH81hejuZcqrEgHx/dzU2v8Lv8OrEvGOI3Xzxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5810
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_10,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=506 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304170135
X-Proofpoint-GUID: _i77lhnFp-0YUboG-JVDlU0Ql_NJ_bg9
X-Proofpoint-ORIG-GUID: _i77lhnFp-0YUboG-JVDlU0Ql_NJ_bg9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* David Binderman <dcb314@hotmail.com> [230417 10:23]:
> Hello there,
>=20
> >It should be fine here.=20
>=20
> Perhaps I have been slightly less than clear. The discussion is about the=
 *style*
> of the code, *not* whether it works or not. My apologies for the lack of =
clarity.=20
>=20
> Expression is
>=20
>     while (A &&
>         B && C)
>=20
> The static analyser notices it is poor style to have B do a limit check, =
but have A use it.
> Sure its working code, but suggest new code
>=20
>     while (B && A && C)
>=20
> It won't make much difference to the code, it will merely be better style=
.
>=20
> 2.
>=20
> >> Source code is
> >>
> >>=A0 =A0 =A0 =A0 =A0 =A0 =A0memset(pivs + tmp, 0,
> >>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof(unsigned long *) * (m=
ax_p - tmp));
>=20
> >It's not good here, I can fix it.
>=20
> sizeof( pivs[ 0]) is a better thing to say than sizeof( unsigned long).=20
> There is reduced future maintenance burden, when the type of *pivs change=
s.
>=20

If you want to make the code better, then send a patch.  It is very
frustrating to try and decode a compilers output over email and be told
it wasn't decoded to your liking.

This is far more of a maintenance burden than the code you are trying to ch=
ange.
