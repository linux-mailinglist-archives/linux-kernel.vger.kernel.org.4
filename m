Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7F3642CF3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbiLEQek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbiLEQdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:33:45 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E31DF67;
        Mon,  5 Dec 2022 08:33:30 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5FhsIx018566;
        Mon, 5 Dec 2022 16:33:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=9F/+18Uokw90L39bo1hOkJcegJluMpq3v31MmwEUqhw=;
 b=NVroG4hZMYWMvhVeKPIFnny+aLEwlL7wopIDWEvF+fLDJOHN2MENnRglOqbprT/QFubt
 c7ZTG5HAuNIpwfF43Tv77ClhdScx427dMNdjnsrnr2cevDUunwVuBF3N9xEy+8QcjrKA
 EDQBUUybDAbifPo/fOgAjvHhxv2cZ08rmNBk7kPCuW8Xx50ENW5kWURWI16dd5Gx/MfU
 +xP3IrzY/DN1PHLP6iRMRm9nxQeVjh/5274PkVGX3RFAE52VHmNBeDCag8qjaYjNnl16
 YGj3PtHSWeyWu0mSx2p2cvS6NajSARrxUBN0/vdJ+iZzAeoeaEC4E4P6FtJURMtAXX11 lg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7yb3c9su-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 16:33:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B5GQu6m027839;
        Mon, 5 Dec 2022 16:33:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m8ua9dpwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 16:33:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbm9JFuSJo5oxlOUFDh+a5FQWGYsDL/hCyr/lGwg3uEBx7Opawi31ECywY/JAs/srcvmCyJsRvGhNoB9G3FxaXyQpcSIdwMEZqbw1CYEZ4DASeEW+p3hJ9es1+En058IVIH0VHWdLZ0dPt9U/S2BoL5/RycSLsUFVACLTkepsL15+VgDbJ5Zp39JLN23ClCPDsMXkPEgX8EKJHUMdChkXwVWNTX57EqvLZAI941z6oNWIUALEDw5zz7rHBPO2L/KMQ/2G+TdGxzxKKVkZNKkE+aIEjWFYu1qSlBX3Yc7cXjIGlpwzsWXe/BSMO+v0JpDurC98tRfqngi7P99zRdz1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9F/+18Uokw90L39bo1hOkJcegJluMpq3v31MmwEUqhw=;
 b=RqI9GCfyCQ3o2uK3UBeQP6vWMYbN2YuH0WT2lrDhBcaGFunjeyTSmU7eKN6ei2vFsKTRCwzvJfhu0x0GJcKrvu4aBD5uue20jvuwF4Eq0jkUv3dqnLfwCqZbTGNokdR5fQ2uzdHVmBioWelxfVwiYm7B559A0pyqpjkLChPsy/EsWc7IWS44baAs97AM35U5I20fm5a+PBJDoOmKM+Z+6+MSi6qVOLMhcc01hiJTdtq90hq5hDrsPKNFTlhreMaZolCyc3/vzQcNRyZuQmbqEey3fYmLaxsNVNt39okHbQ07Jl89V4S+PjQ1CyjT595Qvak+GoPrNmCiEn9GGlMvOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9F/+18Uokw90L39bo1hOkJcegJluMpq3v31MmwEUqhw=;
 b=nrvLkK9Z1dgudoLULqjmLx6P2LZhLvZs5H2tlxJHz4XC1eNy0W7QIse7wyPUJGma1AJgxcYw7/toyJsZfsA+JHS8BS5xy+T6ClTbx2jfjcRnz/liB777tCE2azolHg8wOZDVKjMS5UU/w7hMhRBfMmGBB8xshADIf0NNH7UqLG8=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH7PR10MB5721.namprd10.prod.outlook.com (2603:10b6:510:130::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Mon, 5 Dec
 2022 16:33:21 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::6e94:e2a2:ca1f:2a7]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::6e94:e2a2:ca1f:2a7%9]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 16:33:21 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v10 10/13] kallsyms: optimize .kallsyms_modules*
Date:   Mon,  5 Dec 2022 16:31:54 +0000
Message-Id: <20221205163157.269335-11-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.38.0.266.g481848f278
In-Reply-To: <20221205163157.269335-1-nick.alcock@oracle.com>
References: <20221205163157.269335-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0002.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::8) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH7PR10MB5721:EE_
X-MS-Office365-Filtering-Correlation-Id: 615acd7d-2005-477f-1276-08dad6de5cb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zIGz6JQ50rhB5Qb5znSlWjv6YKt4jAUhIlil4/JR+J52yOKUoOlf+sAQFaFd3tSTkMXKmDTBC40eb/zPfZEYvZbZEHdzDF//6ngu5PCMkQtksSa+JSOaXFDU7mDYG0W9rQzgdosaBQHp4TPDpRbCLo146ydJxWe4wo0tR9TTcSIE03tyTC5SrfbFU79JhmeuNsapptvIF9E7CLX0dJ1fj11EO5K7o/iyicAbEKurXliIgEM2G9NnARGvTEJqCGPPeHizKQard3W7APMNweL+fIXh/OVg64pPEBO5CBN4Qj93/xbfedR1wWmd8HT/Cu8O2HhGpnVCtW5w6Yynlxndg7rK+3szQDxrr7lDgp4gh4s3KbHz8qgkfUIKvg92HVOkGkXaoaBwTKPKaRxNJUHAarfCeA7ak+gxOsX8isKfPag7lpEp7InKNNi7wClZIEmr1uopfxfN4qXJXalkNEbMshsK7cxdsGUXPBiKdTJxnv864hCCd3bS74WJUImfV6C96b9UWaY2gW8zGx8eVQcndvuLTY/qK2s9EjZkxRaDRWW9qJvI5Ktmf3JGmbaxeKyZcKBv6kCu7Q4NtjlwZEa1h7y4XTYu0Y1+hNj3vaSitYlHUNA3IvmxX6wuuNmQAJp/Fr9yYafoGSy5/xcn35Wh2JcLdZqIyxxXElauAY8yIr4in6vNJPEX9mZJrLZaCCq0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199015)(316002)(6486002)(107886003)(478600001)(6666004)(6506007)(6512007)(66946007)(8676002)(4326008)(66476007)(66556008)(83380400001)(30864003)(8936002)(5660300002)(44832011)(186003)(41300700001)(2906002)(1076003)(36756003)(2616005)(38100700002)(86362001)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cDeQ7vIJ8NU3niMj9fCUX+MR7ZLLvWAMPAbsjnaOacKmxi+ICVlHF5y9+ji8?=
 =?us-ascii?Q?Vr2EK2Ucn4SOJjYd0fzGDc7z99d8TK3ikbCe++teRke2YNFa4n8GLAeCoALc?=
 =?us-ascii?Q?5LlOEC5pFLpsulgKuqmxi7Q5ZcRcy/rbY7Jvo/LYM6bPEy8UWcu7SL1WgJjB?=
 =?us-ascii?Q?iqByU+qPsFx/AZOuNq5FbpO7r4/fKqTQ9j3yaYkjhop4gmcHOjcJevXRDuIW?=
 =?us-ascii?Q?k3KBV1zZHPNmB5EsbszBn4mzq+2UgUNsH5envC7NLO3bU/Ttpqw9LH8zylfi?=
 =?us-ascii?Q?GGXnndbTwGSTrypYUqmLD253tl75+OrUjhAD8ipF45B8YdWA7z4oxVUdJC/v?=
 =?us-ascii?Q?c7sxOl8O7svs2V5dVRh5UkMsYMQowCGjjy0XI7zH/lOsab2GK3zKTO8DlfUs?=
 =?us-ascii?Q?AGdeRAWhzzL7B6MVYybdxFTktm6Wx66cPAnxXY2cynZhwG7ASSl4ICR5yVgp?=
 =?us-ascii?Q?BmJOj+d3ImnN06Iyw0bjziiS9zgikBL7D9jtbM5Wgvvgz2+6rb7IumUgAcot?=
 =?us-ascii?Q?qc84DMYiL5ci+WhdHrrDcV38bBfYwWcHTKmK07P6xQ1M+ZNKO7neNaCWxaO9?=
 =?us-ascii?Q?k2IA0VemrqEoxBeMO0LEuNZMD9SvWQ6a+s9+GL4rZBbXC7qJkdzMKGaDME//?=
 =?us-ascii?Q?ttJ76UbhgiGNFOIfum0YTKEGciugCwkji21bBAufn6j2oWfTjDiIJdpm3T8P?=
 =?us-ascii?Q?XwOWbtQ3sz5nsbxH9i6OdiFxaYFJbIFjx+KYGwTMnUw11Apyo9OhUadN7xuA?=
 =?us-ascii?Q?NMA4fFaZW0YFd0g0Rx/DCEhxDmFinv2ATjsWA+pTNve15gW8y8+pi4q9B5Nu?=
 =?us-ascii?Q?UdxfHJ/7gbeya/84JGtOAxkbKLVRTASm/gWhtXS42EyylGZXLn6dPoSbkmFh?=
 =?us-ascii?Q?rsGji4SmNVLMfI5UZccWbPDuCS0GlaNoA0LdV+S8TKE7NTlEjS4VAn9jo+Fd?=
 =?us-ascii?Q?W4mM8AWQQ8lSdgjmuRK841cEzR5NWNlDVoU71sViwG7tYv4jXh+UVIUIeV0Q?=
 =?us-ascii?Q?/Udb1lyeE5QCnLt5Fx2nOlFd4jRLmhcEolAibmEoiWzrF6O4P8p2kcUYi30H?=
 =?us-ascii?Q?vqzYcc5qkj9+R9Y5kx9PnNk5OiTxi+A+aGkdwm93e9i+K9qgI0nJFWMuq5n3?=
 =?us-ascii?Q?0+gpVvQxM94V6T5wAG7Fen0WV7vK0maK6jc0u2ztcq850cdFRgZY8lTiyr+m?=
 =?us-ascii?Q?WdVf3cyL02EqgGSLaarYCrxRzAyHsy+txocL1ZfoUFntXUU8opeuO2EX33YK?=
 =?us-ascii?Q?z0Evj7Jiw4rVukLc1ZDB1BR1OwlmLKd9gpa94XZ7nS9eJvA8ZITRvmVasoQ4?=
 =?us-ascii?Q?8A9/a4liHxU+s40mrDFRM3LeWqX9HczP6WT04/VwFpIk1lpM9KBT2xWoc4T+?=
 =?us-ascii?Q?DXpbaGEwJ6uBOqBeZvvYAqduSXucb4cbfwtlvBODDCng1xST09vP6aJoPwTG?=
 =?us-ascii?Q?V34PmmMRs5ASBWRZCgySl7rbhqW4J6weHVczyuCqMCA6udDVpDuwjfhb4sRt?=
 =?us-ascii?Q?y0j7+7NXXXX5qc0Qa9547kOLcT/w9fpVvFinH6WM07+32krcw82TMm7syxQO?=
 =?us-ascii?Q?uemHZJmdv1pMtyQrSvk9EzNblK7nkLUbmCHE9rQEPNhycWyg6PbYW5Ezn7zt?=
 =?us-ascii?Q?tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?dgCQsu4r/M34W39t0Fo4/yHGrf57YRQtRAtodlXB50uM9kOxingRALtdraFn?=
 =?us-ascii?Q?RqFA9pk9x4FOSiEQozA05B6PcV4nOW1Dnl95WZgqOCXDKhtIx+YvNl0oGxw/?=
 =?us-ascii?Q?5X5dKe4owGSoxKylNucv49wt+RI5VOZi13VjoIYcdopLYxN9ExDJwxsQWqu0?=
 =?us-ascii?Q?t48vE+bQ58U2eBotEYPSaSR4i3/Nnv8ByOoSfM4SnqPNMERrM4Wj8cV1vmU5?=
 =?us-ascii?Q?qWhmAxyqQrrGTTtATzTEjjd6DSbryk+IQU5EczneKi/mECWToBiCFyLsCNlb?=
 =?us-ascii?Q?6e8NSnY4cAXu3XwCJu1z0xC2PBEfHmnxvt8kX0s/DyoMtPX/8uRMMb8LH7gw?=
 =?us-ascii?Q?jgNxAWimcMOpErawjX1wWLdazvGYNMaWr6e4KoOSdAeqnoghAeJ2s3Zun2Fa?=
 =?us-ascii?Q?d/71pL5Q62v6RN1dGxMx/nDliMvcFiXAAEeCap5XuYjCA7mNr3dwDq/BJMoa?=
 =?us-ascii?Q?LBXN/Lxd6zUF3ij73gNjzB3KpRK62+IvtXeQvLlQwCLstjvsfFOsvh5SiNox?=
 =?us-ascii?Q?Y7NIZxPE13i6DOOFwJRopXfMH28vI+l5E87wCfm0agLRQN3UjwmFX9r/kS3h?=
 =?us-ascii?Q?OfeE1ulX4oktm0+IET69poRg+3g6WygsVWxDp+4VUtCGUbxMLz2UwnMdEzkv?=
 =?us-ascii?Q?XZNwtho+2LI5ssgf3AexDRTjV0oScNbkIyFgrKSyZteIxDyKQLCCkRv6J+eh?=
 =?us-ascii?Q?3XtJFNjehRNeErKbrsq0ye4ktORGvFAy0y5rVcWu3KV8X3PKmAXKxN4S4NrX?=
 =?us-ascii?Q?h3SlWX6rXTjmp4blxqopX0T0Melj8maDh4RXDf4KOS71+xtn5vhvkEUmk/1e?=
 =?us-ascii?Q?Ubrqq+dw3aN5Ris/0Szz0TjkTt+BN/5a6zzjRx2bQSxCL3qLLDHLZuOFevLF?=
 =?us-ascii?Q?mZcpxT89vWL/8DiXFMokbm/qx/eifMt5DWesjR0/Xpuj5B0o1sp2h37BGm1U?=
 =?us-ascii?Q?W3B7tLBVvoVpjv0LjJanSyyNv5I7ZraO9TxmgdTXcPQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 615acd7d-2005-477f-1276-08dad6de5cb5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 16:32:55.4676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +pHEMiVPmVVTJnYRqpfE5eFYysvi5qDwImlh3nO1L5UNpB7ufARIHR//T55l6rHtVPdQQOEwvkb/W8e5lHc4yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5721
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212050138
X-Proofpoint-ORIG-GUID: C4E9OcYX2-g9Y0-NzDQpP2A-z_uC3ePK
X-Proofpoint-GUID: C4E9OcYX2-g9Y0-NzDQpP2A-z_uC3ePK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These symbols are terribly inefficiently stored at the moment.  Add a
simple optimizer which fuses obj2mod_elem entries and uses this to
implement three cheap optimizations:

 - duplicate names are eliminated from .kallsyms_module_names.

 - entries in .kallsyms_modules which point at single-file modules which
   also appear in a multi-module list are redirected to point inside
   that list, and the single-file entry is dropped from
   .kallsyms_module_names.  Thus, modules which contain some object
   files shared with other modules and some object files exclusive to
   them do not double up the module name.  (There might still be some
   duplication between multiple multi-module lists, but this is an
   extremely marginal size effect, and resolving it would require an
   extra layer of lookup tables which would be even more complex, and
   incompressible to boot).

 - Entries in .kallsyms_modules that would contain the same value after
   the above optimizations are fused together, along with their
   corresponding .kallsyms_module_addresses/offsets entries.  Due to
   this fusion process, and because object files can be split apart into
   multiple parts by the linker for hot/cold partitioning and the like,
   entries in .kallsyms_module_addresses/offsets no longer correspond
   1:1 to object files, but more to some contiguous range of addresses
   which are guaranteed to belong to a single built-in module, but which
   may well stretch over multiple object files.

The optimizer's time complexity is O(log n) in the number of objfiles at
most (and probably much lower), so, given the relatively low number of
objfiles, its runtime overhead is in the noise.

Optimization reduces the overhead of the kallmodsyms tables by about
7500 items, dropping the .tmp_kallsyms2.o object file size by about
33KiB, leaving it 8672 bytes larger than before: a gain of .4%.

The vmlinux size is not yet affected because the variables are not used
and are eliminated by the linker: but if they were used (after the next
commit but one), the size impact of all of this on the final kernel is
minimal: in my testing, vmlinux grew by 0.17% (10824 bytes), and the
compressed vmlinux only grew by 0.08% (7552 bytes): though this is very
configuration-dependent, it seems likely to scale roughly with the
kernel as a whole.  (The next commit changes these numbers a bit, but not
much.)

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Reviewed-by: Kris Van Hees <kris.van.hees@oracle.com>
---

Notes:
    v9: Fix a bug in optimize_obj2mod that prevented proper reuse of
        module names for object files appearing in both multimodule
        modules and single-module modules.  Adjustments to allow for
        objfile support.  Tiny style fixes.
    v10: Slight conflict adjustments.

 scripts/kallsyms.c | 297 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 288 insertions(+), 9 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 48bf4661bd09..4d8289040ad5 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -104,6 +104,17 @@ static unsigned int strhash(const char *s)
 	return hash;
 }
 
+static unsigned int memhash(char *s, size_t len)
+{
+	/* fnv32 hash */
+	unsigned int hash = 2166136261U;
+	size_t i;
+
+	for (i = 0; i < len; i++)
+		hash = (hash ^ *(s + i)) * 0x01000193;
+	return hash;
+}
+
 #define OBJ2MOD_BITS 10
 #define OBJ2MOD_N (1 << OBJ2MOD_BITS)
 #define OBJ2MOD_MASK (OBJ2MOD_N - 1)
@@ -113,14 +124,35 @@ struct obj2mod_elem {
 	size_t nmods;		/* number of modules in "mods" */
 	size_t mods_size;	/* size of all mods together */
 	int mod_offset;		/* offset of module name in .kallsyms_mod_objnames */
+
+	/*
+	 * Hash values of all module names in this elem, combined: used for
+	 * rapid comparisons.  Populated quite late, at optimize_obj2mod time.
+	 */
+	unsigned int modhash;
+
+	/*
+	 * If set at emission time, this points at another obj2mod entry that
+	 * contains the module name we need (possibly at a slightly later
+	 * offset, if the entry is for an objfile that appears in many modules).
+	 */
+	struct obj2mod_elem *xref;
+
+	/*
+	 * Chain links for object -> module and module->object mappings.
+	 */
 	struct obj2mod_elem *obj2mod_next;
+	struct obj2mod_elem *mod2obj_next;
 };
 
 /*
- * Map from object files to obj2mod entries (a unique mapping).
+ * Map from object files to obj2mod entries (a unique mapping), and vice versa
+ * (not unique, but entries for objfiles in more than one module in this hash
+ * are ignored).
  */
 
 static struct obj2mod_elem *obj2mod[OBJ2MOD_N];
+static struct obj2mod_elem *mod2obj[OBJ2MOD_N];
 static size_t num_objfiles;
 
 /*
@@ -164,6 +196,8 @@ static void obj2mod_add(char *obj, char *mod)
 
 	elem = obj2mod_get(obj);
 	if (!elem) {
+		int j = strhash(mod) & OBJ2MOD_MASK;
+
 		elem = malloc(sizeof(struct obj2mod_elem));
 		if (!elem)
 			goto oom;
@@ -177,8 +211,15 @@ static void obj2mod_add(char *obj, char *mod)
 
 		elem->obj2mod_next = obj2mod[i];
 		obj2mod[i] = elem;
+		elem->mod2obj_next = mod2obj[j];
+		mod2obj[j] = elem;
 		num_objfiles++;
 	} else {
+		/*
+		 * objfile appears in multiple modules.  mod2obj for this entry
+		 * will be ignored from now on, except insofar as it is needed
+		 * to maintain the hash chain.
+		 */
 		elem->mods = realloc(elem->mods, elem->mods_size +
 				     strlen(mod) + 1);
 		if (!elem->mods)
@@ -198,6 +239,162 @@ static void obj2mod_add(char *obj, char *mod)
 	fprintf(stderr, "kallsyms: out of memory\n");
 	exit(1);
 }
+
+static int qstrcmp(const void *a, const void *b)
+{
+	return strcmp((const char *) a, (const char *) b);
+}
+
+static int qmodhash(const void *a, const void *b)
+{
+	struct obj2mod_elem * const *el_a = a;
+	struct obj2mod_elem * const *el_b = b;
+	if ((*el_a)->modhash < (*el_b)->modhash)
+		return -1;
+	else if ((*el_a)->modhash > (*el_b)->modhash)
+		return 1;
+	return 0;
+}
+
+/*
+ * Associate all object files in obj2mod which refer to the same module with a
+ * single obj2mod entry for emission, preferring to point into the module list
+ * in a multi-module objfile.
+ */
+static void optimize_obj2mod(void)
+{
+	size_t i;
+	size_t n = 0;
+	struct obj2mod_elem *elem;
+	struct obj2mod_elem *dedup;
+
+	/* An array of all obj2mod_elems, later sorted by hashval.  */
+	struct obj2mod_elem **uniq;
+	struct obj2mod_elem *last;
+
+	/*
+	 * Canonicalize all module lists by sorting them, then compute their
+	 * hash values.
+	 */
+	uniq = malloc(sizeof(struct obj2mod_elem *) * num_objfiles);
+	if (uniq == NULL)
+		goto oom;
+
+	for (i = 0; i < OBJ2MOD_N; i++) {
+		for (elem = obj2mod[i]; elem; elem = elem->obj2mod_next) {
+			if (elem->nmods >= 2) {
+				char **sorter;
+				char *walk;
+				char *tmp_mods;
+				size_t j;
+
+				tmp_mods = malloc(elem->mods_size);
+				sorter = malloc(sizeof(char *) * elem->nmods);
+				if (sorter == NULL || tmp_mods == NULL)
+					goto oom;
+				memcpy(tmp_mods, elem->mods, elem->mods_size);
+
+				for (j = 0, walk = tmp_mods; j < elem->nmods;
+				     j++) {
+					sorter[j] = walk;
+					walk += strlen(walk) + 1;
+				}
+				qsort(sorter, elem->nmods, sizeof (char *),
+				      qstrcmp);
+				for (j = 0, walk = elem->mods; j < elem->nmods;
+				     j++) {
+					strcpy(walk, sorter[j]);
+					walk += strlen(walk) + 1;
+				}
+				free(tmp_mods);
+				free(sorter);
+			}
+
+			uniq[n] = elem;
+			uniq[n]->modhash = memhash(elem->mods, elem->mods_size);
+			n++;
+		}
+	}
+
+	qsort(uniq, num_objfiles, sizeof (struct obj2mod_elem *), qmodhash);
+
+	/*
+	 * Work over multimodule entries.  These must be emitted into
+	 * .kallsyms_mod_objnames as a unit, but we can still optimize by
+	 * reusing some other identical entry.  Single-file modules are amenable
+	 * to the same optimization, but we avoid doing it for now so that we
+	 * can prefer to point them directly inside a multimodule entry.
+	 */
+	for (i = 0, last = NULL; i < num_objfiles; i++) {
+		const char *onemod;
+		size_t j;
+
+		if (uniq[i]->nmods < 2)
+			continue;
+
+		/* Duplicate multimodule.  Reuse the first we saw.  */
+		if (last != NULL && last->modhash == uniq[i]->modhash &&
+			memcmp(uniq[i]->mods, last->mods,
+			       uniq[i]->mods_size) == 0) {
+			uniq[i]->xref = last;
+			continue;
+		}
+
+		/*
+		 * Single-module entries relating to modules also emitted as
+		 * part of this multimodule entry can refer to it: later, we
+		 * will hunt down the right specific module name within this
+		 * multimodule entry and point directly to it.
+		 */
+		onemod = uniq[i]->mods;
+		for (j = uniq[i]->nmods; j > 0; j--) {
+			int h = strhash(onemod) & OBJ2MOD_MASK;
+
+			for (dedup = mod2obj[h]; dedup;
+			     dedup = dedup->mod2obj_next) {
+				if (dedup->nmods > 1)
+					continue;
+
+				if (strcmp(dedup->mods, onemod) != 0)
+					continue;
+				dedup->xref = uniq[i];
+				assert(uniq[i]->xref == NULL);
+			}
+			onemod += strlen(onemod) + 1;
+		}
+
+		last = uniq[i];
+	}
+
+	/*
+	 * Now traverse all single-module entries, xreffing every one that
+	 * relates to a given module to the first one we saw that refers to that
+	 * module.
+	 */
+	for (i = 0, last = NULL; i < num_objfiles; i++) {
+		if (uniq[i]->nmods > 1)
+			continue;
+
+		if (uniq[i]->xref != NULL)
+			continue;
+
+		/* Duplicate module name.  Reuse the first we saw.  */
+		if (last != NULL && last->modhash == uniq[i]->modhash &&
+		    memcmp(uniq[i]->mods, last->mods, uniq[i]->mods_size) == 0) {
+			uniq[i]->xref = last;
+			assert(last->xref == NULL);
+			continue;
+		}
+		last = uniq[i];
+	}
+
+	free(uniq);
+
+	return;
+oom:
+	fprintf(stderr, "kallsyms: out of memory optimizing module list\n");
+	exit(EXIT_FAILURE);
+}
 #endif /* CONFIG_KALLMODSYMS */
 
 static void usage(void)
@@ -509,8 +706,8 @@ static void output_kallmodsyms_mod_objnames(void)
 	size_t i;
 
 	/*
-	 * Traverse and emit, updating mod_offset accordingly.  Emit a single \0
-	 * at the start, to encode non-modular objfiles.
+	 * Traverse and emit, chasing xref and updating mod_offset accordingly.
+	 * Emit a single \0 at the start, to encode non-modular objfiles.
 	 */
 	output_label("kallsyms_mod_objnames");
 	printf("\t.byte\t0\n");
@@ -519,9 +716,25 @@ static void output_kallmodsyms_mod_objnames(void)
 		     elem = elem->obj2mod_next) {
 			const char *onemod;
 			size_t i;
+			struct obj2mod_elem *out_elem = elem;
 
-			elem->mod_offset = offset;
-			onemod = elem->mods;
+			/*
+			 * Single-module ref to a multimodule: will be emitted
+			 * as a whole, so avoid emitting pieces of it (which
+			 * would go unreferenced in any case).
+			 */
+			if (elem->xref &&
+			    elem->nmods == 1 && elem->xref->nmods > 1)
+				continue;
+
+			if (elem->xref)
+				out_elem = elem->xref;
+
+			if (out_elem->mod_offset != 0)
+				continue;	/* Already emitted.  */
+
+			out_elem->mod_offset = offset;
+			onemod = out_elem->mods;
 
 			/*
 			 * Technically this is a waste of space: we could just
@@ -530,13 +743,14 @@ static void output_kallmodsyms_mod_objnames(void)
 			 * entry, but doing it this way makes it more obvious
 			 * when an entry is a multimodule entry.
 			 */
-			if (elem->nmods != 1) {
+			if (out_elem->nmods != 1) {
 				printf("\t.byte\t0\n");
-				printf("\t.byte\t%zi\n", elem->nmods);
+				printf("\t.byte\t%zi\n", out_elem->nmods);
 				offset += 2;
 			}
 
-			for (i = elem->nmods; i > 0; i--) {
+			for (i = out_elem->nmods; i > 0; i--) {
+				printf("/* 0x%lx */\n", offset);
 				printf("\t.asciz\t\"%s\"\n", onemod);
 				offset += strlen(onemod) + 1;
 				onemod += strlen(onemod) + 1;
@@ -563,6 +777,13 @@ static void output_kallmodsyms_objfiles(void)
 		long long offset;
 		int overflow;
 
+                /*
+                 * Fuse consecutive address ranges citing the same object file
+                 * into one.
+                 */
+                if (i > 0 && addrmap[i-1].objfile == addrmap[i].objfile)
+                        continue;
+
 		if (base_relative) {
 			if (!absolute_percpu) {
 				offset = addrmap[i].addr - relative_base;
@@ -588,6 +809,13 @@ static void output_kallmodsyms_objfiles(void)
 
 	for (i = 0; i < addrmap_num; i++) {
 		struct obj2mod_elem *elem = addrmap[i].objfile;
+		int orig_nmods;
+		const char *orig_modname;
+		int mod_offset;
+
+		if (i > 0 && addrmap[i-1].objfile == addrmap[i].objfile)
+			continue;
+
 		/*
 		 * Address range cites no modular object file: point at 0, the
 		 * built-in module.
@@ -598,13 +826,63 @@ static void output_kallmodsyms_objfiles(void)
 			continue;
 		}
 
+		orig_nmods = elem->nmods;
+		orig_modname = elem->mods;
+
+		/*
+		 * Chase down xrefs, if need be.  There can only be one layer of
+		 * these: from single-module entry to other single-module
+		 * entry, or from single- or multi-module entry to another
+		 * multi-module entry.  Single -> single and multi -> multi
+		 * always points at the start of the xref target, so its offset
+		 * can be used as is.
+		 */
+		if (elem->xref)
+			elem = elem->xref;
+
+		if (elem->nmods == 1 || orig_nmods > 1) {
+
+			if (elem->nmods == 1)
+				printf("/* 0x%llx--0x%llx: module %s */\n",
+				       addrmap[i].addr, addrmap[i].end_addr,
+				       elem->mods);
+			else
+				printf("/* 0x%llx--0x%llx: multimodule */\n",
+				       addrmap[i].addr, addrmap[i].end_addr);
+
+			mod_offset = elem->mod_offset;
+		} else {
+			/*
+			 * If this is a reference from a single-module entry to
+			 * a multi-module entry, hunt down the offset to this
+			 * specific module's name (which is guaranteed to be
+			 * present: see optimize_obj2mod).
+			 */
+
+			size_t j = elem->nmods;
+			const char *onemod = elem->mods;
+			mod_offset = elem->mod_offset;
+
+			for (; j > 0; j--) {
+				if (strcmp(orig_modname, onemod) == 0)
+					break;
+				onemod += strlen(onemod) + 1;
+			}
+			assert(j > 0);
+			/*
+			 * +2 to skip the null byte and count at the start of
+			 * the multimodule entry.
+			 */
+			mod_offset += onemod - elem->mods + 2;
+		}
+
 		/*
 		 * Zero offset is the initial \0, there to catch uninitialized
 		 * obj2mod entries, and is forbidden.
 		 */
 		assert(elem->mod_offset != 0);
 
-		printf("\t.long\t0x%x\n", elem->mod_offset);
+		printf("\t.long\t0x%x\n", mod_offset);
 		emitted_objfiles++;
 	}
 
@@ -1217,6 +1495,7 @@ static void read_modules(const char *modules_builtin)
 
 	free(module_name);
 	modules_builtin_iter_free(i);
+	optimize_obj2mod();
 
 	/*
 	 * Read linker map.
-- 
2.38.0.266.g481848f278

