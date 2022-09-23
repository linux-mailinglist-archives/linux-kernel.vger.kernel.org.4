Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA075E7790
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 11:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbiIWJoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 05:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiIWJnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:43:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C292AF186F;
        Fri, 23 Sep 2022 02:43:27 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28N8v5vb022816;
        Fri, 23 Sep 2022 09:42:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=tlQ7vQ11soU0Ru9M02QR/tqfAsmyBXbR07g0ov0Du18=;
 b=N5PO8pavAxchnf5y+WgMmTPD1mS31I1I9h/fJLKuOsP0c6CjFCHIUAz7io+yqobuNhhg
 TjfPHI8I7CsQbJXVVZm+um0P2Zs2m8LiKU2Wa+wThbDbWGvDNp4MHXmoR1I86mivKQz/
 SvU7vk6dexsx8lktsJ9PvHaYuqXHjmVw37K0v3t6dY5L1VB2cm59d2QX2tg6LxtVbSG+
 I2n4VeS67tb7dTFE53dVqP5onA/E2ajRcdHCJAgUbdvk+s1ylv4D9cZPdQZxRWO97Wiw
 TOIYY7QZKhLSSh+iS7spdijiJ8YyOVWPXOluZ2ofltQO+jlN+RDoRCybhEq0W4qyJKMc MA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn6strmbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Sep 2022 09:42:33 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28N6MFIW028896;
        Fri, 23 Sep 2022 09:42:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3d5jksq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Sep 2022 09:42:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZK2GXgFkNBecIzTlw64F2BVza7qwNAkgRj8tf750OGxu5o3+6aPBgB8RLWhhpORqx1jPy/w8iUhS8RNPHp9PQNclWEi+pGeB/lgFqwPYZZVSsEg/fWuwJ48izvBusnq4W/Ez6vKMDyOmQw+U5qWtHcPDLsztIeCUHlJeIQSIpodQo7U6FUhdyuAOvw/DxvK+GvoYgL+ZMSkNvaf8zE5KNIZydWymLmk0tYepEyexjo85yp6boQwVzqJGIrSEysOWk1zC6tzeAKZu4wOA2WdbhKVE3ZZPxWCi3b3duNobeW2IKFmBa32N8H2ltcUyFZPIBVB0xJ1yNmANQXCGeJMBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlQ7vQ11soU0Ru9M02QR/tqfAsmyBXbR07g0ov0Du18=;
 b=PGZB9euPkYgLVhGbPpQVjumaqeAeeadQzLuIY1Iw7aoXW8Sk6jQSjIsZl/XSkQ5FjoJ2BTHkZutJ56NbgaEDnUW8fQ4DFmQItIfRE8FO6p63gZOjv9cHKzdBfCtI2hpJ0i8pbnlqpFgGLxU5803D4K/UEgcdH+rPxD9vireE7ihhSL7wLx7jYGx4KrHiIAPzmLRHKBS5/kDUxOn7+F3Mf6mpOMVrkPU1EzimqqtvLCHRw08YjCx0q+VNZ7+dbi1wqmEyyzBvWqVwZ5A3OYPE7T73gP+OnUBPo1GRef5aBnp1paZMNUdyEOSUQxAf6xOjlehHzwdi3Cb2FszsJ/zH7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlQ7vQ11soU0Ru9M02QR/tqfAsmyBXbR07g0ov0Du18=;
 b=jzTXZ7hKkkq+zi1IBR4B5jVZlnfAgB6X6S2Kgy4FR1hEgp65vOazR5BFBh1CFRPy0VlfPeJsBOFSTIdaPMq+iyDS8Id9fAOD6Hjl4S+r54fEL538n2Bl9xOxD+KxBIzBQhGKRZuXyc0YQUADPNDlK1JEKP8yIzNRDF209pX/3xs=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ1PR10MB5905.namprd10.prod.outlook.com
 (2603:10b6:a03:48c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.17; Fri, 23 Sep
 2022 09:42:30 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5654.019; Fri, 23 Sep 2022
 09:42:30 +0000
Date:   Fri, 23 Sep 2022 12:42:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: da7219: Fix an error handling path in
 da7219_register_dai_clks()
Message-ID: <Yy1/dhtp3VCCRkWI@kadam>
References: <e4acceab57a0d9e477a8d5890a45c5309e553e7c.1663875789.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4acceab57a0d9e477a8d5890a45c5309e553e7c.1663875789.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: MR1P264CA0212.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:56::20) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|SJ1PR10MB5905:EE_
X-MS-Office365-Filtering-Correlation-Id: cac3adb7-1f88-4456-eba6-08da9d47eed7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: owy9BdFFXuFtqmJaGsK+0RdmtQO17sompuPPNK0mLM9X3jN3fdDnwkLg6nwZzYxPLdVhhFz2kaqzKZORA1P1LS0MKgQR4IUTTvkMnzLIb1QjNppKQpYODZPEqatScsaViib6e85gLeOJTAEV2wVddVic7NteKm9C42ftAWcQ2UmwheApFR/EMzE8Sx49MBOaGl3tPMDSlaR/ZuhYKA3B9bHm0UiZ7FY3RgpQbvyIFvmRdvsVqsqSEobcohGyOMZy6aaRWdjMh32+dnoWjBUNSNkIkBifF4P5WNohBtxYisHMpUIAu1AACIL8abjEGTIs1LbrWcTrFdJoLUvjnI/aTMnGUoXYEOsKLO4F0Q0H25nPwcd8iaH7Y/Js1m8DPBCl0CK3urJj/HoAwB44V6k2tfINn1WArWZwnShNc1bNUJv418+EZyp4GmN8b8BfMj/r4Pw+OLS2ExJ7mjhLc7xz6HOcJQUiTA1+gzJlqWbCPWpZMVPrZVqoOJceR2itXWMzXhNdPqvmlbbhqjBZaGO3+SOQvflXLOIkUp8c9XnuywimjTg7iZwmir3xuH1RVhm/A7mhmlAa6svGkEkFlVi+zNMD15qlFQoobK619nQI/1qhqgSOBSOnmJb5EfnGQFnFVa5lQ9NLvL56KJukIeMmN97w8CpQ0bpRR3eWFBEF9OJBewh2/h6E/9VowJgE256X3H3rzJ5kJ3n/dh/4L0zaomqRNY9k0kd6myt6PVQA6+A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199015)(66946007)(44832011)(5660300002)(41300700001)(8936002)(38100700002)(86362001)(66556008)(33716001)(66476007)(7416002)(2906002)(4744005)(4326008)(8676002)(6916009)(478600001)(26005)(83380400001)(54906003)(316002)(6506007)(6666004)(6512007)(966005)(6486002)(9686003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C255m8xxFWjDuptT/GHRXJTeoqbv53SvQtXsMZtNHKLKgOTd/SK+4FDtFbLM?=
 =?us-ascii?Q?uc8LqfFa9L15liDFy53kBls0XzloWJJ0+/HAb2xCjdEF/bCPAwtwaOTitnZe?=
 =?us-ascii?Q?Zw88EC5Yb4vZfa9qXxC7Qunr0iUO+CZCkRzy37e9d1MhJuBqgxgCF8Vq1ZA2?=
 =?us-ascii?Q?sRlSL96T3OEprgRFTBivSrZBIhRYhhilG6k6zN+DeB6GwtoF74OXYqAskymW?=
 =?us-ascii?Q?61n/9FVBR4jA4zHEkC60f35aIg+N3wceLR+c+zXRBfT35SCx3foz9MfnDxUL?=
 =?us-ascii?Q?lEg3zw7TvSG7Nt0/hPYh7y2rFMBxD+QHj2pgsHlaOB9vwu/wojiQTwJSaSJs?=
 =?us-ascii?Q?tss9X6pBxktzfCjwQJ3KtqCp2OY1TAKYYWfeaqeeS4E7Ncvjk1HEnPYAY4cA?=
 =?us-ascii?Q?cLsseyMkynucwcGpceAwMGE4htK8eS+PN9OXWZYNEURp5jMFaoWMDUzypev+?=
 =?us-ascii?Q?YrdWoAZ2SPgMPE92U21Isu6WhiY4ZaZ8TsPEZ8M6gSgM/HzWKXCzdhtoAuCN?=
 =?us-ascii?Q?hMJv1X1lIkUt9XNLFCZZZJBXZTmoftp+svdnJqh/dP8vOtdbXgzFcY9kwAWB?=
 =?us-ascii?Q?iL4FffAmln1vqF3wZZM1wbzSNH0rvIaG2otQ8aCIIlN9N5KRcFwj4+8OMqMC?=
 =?us-ascii?Q?Kifo3Blzb4DDDiMphTMybDdYzfSOHHLmeRYJeHjScB3TXPshF4eg4Cqzrzqx?=
 =?us-ascii?Q?H+jYaubywOL+Sq0eI/indSZsAl2aGEdXIDBjgDCAJ/FUPilY7gYJ5oLlPX55?=
 =?us-ascii?Q?SW7TUtdK3liPfiFeQiG00T3suBAx0vOPTXm6YG3y98hBfPJuGhkwgjqfGg29?=
 =?us-ascii?Q?kc/O3QmMND9T+3Xuo2X8P7Y1XL1B8d/7ak4hfFUcIFKH9Fj0e8ujrO8/iPDn?=
 =?us-ascii?Q?p9sSq6g3s5HF5WKvM7heX1SXFYCXW664oD6XeYqI9gXG/itbiFxnWBNzZWVe?=
 =?us-ascii?Q?MjGdyeyxzMFZh5bFcyMJZhD/8C/VffCNJWEHILvFqB4vSj3B/eC66zgF+8T3?=
 =?us-ascii?Q?VlGwYdDmbUBYXvqpuGqFBxpkq1SS4ben+p1rSzXFsNG6SkwIG1CFg0OJE22y?=
 =?us-ascii?Q?+u90C5cWKkp/lvGe1j5gu5j1TUdSGW3RMdPYuZUfNP5QMnydW2XvZ8Q9TJxq?=
 =?us-ascii?Q?JuANJdZRwD7vplMwV4HBvsTe0RrQZkN+4muYIFRZ1W1lWFahIsCsu97lykBE?=
 =?us-ascii?Q?kT+4JrPdUdJ8So1nL61TAP8Mx4xWOaRCFBIE6Ujwuz9/phAaX1+DIoXUD1y8?=
 =?us-ascii?Q?AdnQOOqBsNEPHOUb7J4vkYc9LTXMy859VhoJxvCJToVrcHqOEFJQt6w40uK/?=
 =?us-ascii?Q?kg6FfCDRtmlOQKwq35+uBQatl/ZYp4sIGBjxDig+kgLFzRM7EYyXCVFKMv70?=
 =?us-ascii?Q?KbN/sZ1EaQFWoXCgs+3o4NO0xCNpGOz25e8HuNDiD6MTjzOq2jVyMOE7UGsS?=
 =?us-ascii?Q?43n3rZugoDTocq2+GiQellSEKhsqCIJvHBfDxdievanTZBJJEHIZ5KmKYcEP?=
 =?us-ascii?Q?Mr+FAghSakQZwh2IQET0AhOx+AbJ8w/pC2fmdjsgTuld1+ZJtsFe6pUK4hW7?=
 =?us-ascii?Q?sFcEWwfYaVPXGGP8GzJFLuWYTjuX41jxR/pQEeNGke2q2JCYEuG0JUITB5Nv?=
 =?us-ascii?Q?JQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cac3adb7-1f88-4456-eba6-08da9d47eed7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 09:42:30.5150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TpGyFodM8evPWsXP+Q9vFwsF9a1rRf6ItrevCn8xkjTPAvsfOVlQrjggNe2KvSO3OIqzhFFjQ5AYM7K0fWpWo+qFjwuolD2gh9Rzk5gH+7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5905
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_02,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209230062
X-Proofpoint-GUID: 3A502JtPGMrCtRvOL5TbQBoLRDBrBcTu
X-Proofpoint-ORIG-GUID: 3A502JtPGMrCtRvOL5TbQBoLRDBrBcTu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 09:44:57PM +0200, Christophe JAILLET wrote:
> If clk_hw_register() fails, the corresponding clk should not be
> unregistered.
> 
> To handle errors from loops, clean up partial iterations before doing the
> goto.  So add a clk_hw_unregister().
> Then use a while (--i >= 0) loop in the unwind section.
> 
> Fixes: 78013a1cf297 ("ASoC: da7219: Fix clock handling around codec level probe")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> See https://lore.kernel.org/all/4fdde55198294a07f04933f7cef937fcb654c901.1624425670.git.christophe.jaillet@wanadoo.fr/
> for an incomplete patch sent last year and Dan's comment on it.

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

