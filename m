Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E16C7034E6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243207AbjEOQxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243175AbjEOQx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:53:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20656185
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:53:06 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FGo9B2028891;
        Mon, 15 May 2023 16:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Phu2tzzTxBxPE7yk3aOKVO70yzFfcRkbddLRTXnhoRw=;
 b=QC8na6L8EgsPp8SdqJrO7QIVJolMXCZPMEIsUSaAdmCNQRiZ4P78xfdeDvLGJdT80oA7
 TtM8Xss3LTQCoPD/fdk/8kAnfo3F3Lk6NEx/vrnYzYXyWZpcaS/bvD7T7uMeBNze5+wq
 TudNvLTLZr2NnI/ldqMD2YGER31VWXdIDU2Cel2wSaWyadOOVV1Uj77TwrIZOnpfBTLE
 KWMIwT7n/VmIczxyKITRpGqzK9sHhxSmv3JmbIpxTwT4GHd2Ly52YZerVm1j9ZGaQ7rC
 Rm9lwvgknPFBi6T3UbtHIk2A6ifJDToloPuHkGyJmjb7+C62wz+Co7MGMdqxkZTOFgS7 7Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2eb069u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 16:52:38 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34FGnQlP017864;
        Mon, 15 May 2023 16:52:38 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj103daq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 16:52:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4Rjh6nEuZ9D/WmrmLEyFP5OlJUPpkuuSaWFFu1mHuiLrG19NrfpcLmMh4flQq93BWS6de3rGgpeGJrWT0mpL4hss16P1eQB9x513PdGNJQ75of4z4qI9IN36kuCMNBE62Nq7VefEhRIEJccoxH1AVugP6a1xIgd7OodlKOJDJWgaZ+Beakfign5Eo3r/kkPVoiqFX/SNdQznaLhAYcQygZE8DteFTHwp7s6nDBPnBHLH+n+d2SvMuJoX2fGWvmCiSuhGFzojmdPEojq8WDadCJM2vptxvBQXTJhQI6iA5UKXUovh5gMkZf6e4uK11kyxelO/ekfMzIc8zt78wlQVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Phu2tzzTxBxPE7yk3aOKVO70yzFfcRkbddLRTXnhoRw=;
 b=hXq5nYQG8KCAXMR+Yjdo/VhDu7HclB8eNvIrkG+32C61nFc2AU66ki5EfWUJMo92OLq1nH3GoVq2q7BOZ1qHvM5yVM/j/l5GwC8PcK9jusX2rl3r8UyBtWk9K2PiOwC1U4Zl2nLDGZa1AddYzKTqZrvc34yEkh2/QYueTUc0dtrAcONHIPUI/QOjllz1IyzPetDNblRkLadAjuxWrnhyIKOWZ1eiIJb+HMksuD1PQI2ySGDBeRCE5cm77SgK3F5Qu5HAVTdxvqRZZv1Pd5p5IiTTZKEG0ET7RXyCPO/dRzxgF/5szmHSbOra/3GDsb1lAk7vWbQV1pIWpYt5wPIOEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Phu2tzzTxBxPE7yk3aOKVO70yzFfcRkbddLRTXnhoRw=;
 b=Qx703UmOg+jt88RCx/hIjY0NBUZ2AGpbOWpgbWPe0tVkd4/Dq8pa0t3l5GD1UafWhlpZ4mgIxzZRyII9Xk3mX/Y55/IltNSHMrcyBYIKPtEKPv8N180AeiXeH5h2bwIXNL3TCuPhvs2QAkfU1n0u1UG3ssvIjReEk1fLLejW2rQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN6PR10MB7442.namprd10.prod.outlook.com (2603:10b6:208:470::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29; Mon, 15 May
 2023 16:52:35 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 16:52:35 +0000
Date:   Mon, 15 May 2023 12:52:33 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH 02/10] maple_tree: Drop mtree_alloc_{range,rrange}() and
 related functions.
Message-ID: <20230515165233.sssqpxuxzgt77why@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230515131757.60035-1-zhangpeng.00@bytedance.com>
 <20230515131757.60035-3-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515131757.60035-3-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0469.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::7) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MN6PR10MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 1054a331-4123-48ff-65af-08db5564c8a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M3B8xWQMc4zfhX0tBTLMFH/jBh2FC+ncheGL+2Ucb39W+REqg3RhtCkOAW2Pn8r0sxzWp/WtgJfN4Eu+BdQGZqLsbHYBvnZ1znjFZsXpOEMgUs/njGDZiOyIr0srs5wWHcspFVCajupHsECP8nKZmBokxJX5EByqZXpaGxaFCIJb0zImg0EB5zF66xCFyiaWg+j3U/1+LXE9gp9dECBNU6d5fsxqJYIBmW1M+O3/ZYr1XAQRY6iJYGNrPvxRLdajoh4LIUKaRjPL4/FM7Oo2yhOMaGAwi1lG2+LmEtn4I57VBZarh09lUTFqR51gcBAe6KifgyqUGwk1fClBr7/UDqnxLHLYQLyhKkxTaQz+6sWHULy/d9jJtPCiKQg7sASbC15ezzvg9B6aP7dKILZf58FrDx3DtnY5Ebf3paBroR9JeZ+AMD8xxG0mOeJ56rhUURkZutju7WsMxjR1r96JMqWTCGWJ81KZgd/Tb9DZzOmrCmvtO8+V4VBG3fnwT2Ctd+c64bIcXK39vhdNsi3v5P+0rKCu6+ozK6pJ4hx1zMX6rZrS2+zI2te7wwKwpixW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199021)(4326008)(6916009)(66946007)(66476007)(478600001)(6486002)(66556008)(86362001)(316002)(83380400001)(26005)(1076003)(186003)(6512007)(6506007)(9686003)(41300700001)(5660300002)(8676002)(8936002)(2906002)(33716001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pNO6+9EfoZWttY5FOVg+/WRn+NxiZ6NQwGrAqBCEsqlnqEWfp3qfeD71Vg54?=
 =?us-ascii?Q?ldVBimX6eJ2RSN9UiFhZTzjFoYjHSobSt7JIHH4ZsireJiuyeyPhivg7Cw5F?=
 =?us-ascii?Q?xgOJp12Z6Ba0WYdCoX9OctM6Mumap0mdwcb4uZsdTnGsqouEMAxSpOdHPX3V?=
 =?us-ascii?Q?tpCYlHhSBluo3JM6KgCPQTKHc7F22qPnyGdJUK2pTEKTTn9sIwIhPd2K8K9v?=
 =?us-ascii?Q?/C3eUPGMFSqNDk+QTWxMhbHK3v7JgF35cESu+KrWHURz0sfS/8x9np1I3fF9?=
 =?us-ascii?Q?tqk71nqX5z8hx4tW+WBjHlv2Ws71YhvD0FtmRhy2aOwUZCp4TTXBzv0ZzXr+?=
 =?us-ascii?Q?bZ4W27nZdNGlodi58QFguqb6/wLS+zKDT0PL9AHdo+FqQ29H3vwjNOpvWl2H?=
 =?us-ascii?Q?BW700wp6cYs6wKvEpjUxF7XRrnKKIw+FRLrrk7YxDaTOQDLjw7mF3MPXUoRz?=
 =?us-ascii?Q?6hNtnhEVIZahD4QXLRAec3UBos75RhYVDMILarDW0ZuSgr24zMhXph5kqRtI?=
 =?us-ascii?Q?mJBOgJ4+t72QBtDB3LByHNnZjiBvwqaOm/OVAbG4INJelszDLzjiLHl2q5kf?=
 =?us-ascii?Q?auXiAYBwmju/ub91mtU+/XPYTvZ8PMQZ37uQcRx0RPjLNj5y5nrujQEuZG3w?=
 =?us-ascii?Q?LlI/O6+mycQIL1oSkmoU9vbNIDuHD78zxalDY8nQNUBUHOY+/UWjnIpMwmGV?=
 =?us-ascii?Q?XiXaV9PnTDhJZGRkyJzVbaX5gEHKVbBWqob4sB4BlI2hfo4ey8eBQUud8PNC?=
 =?us-ascii?Q?8pIu7b3z9J/ymgwnCuGiUsrUOxExhf+RNcJDMEF9l1OygXCIqNplaaM0Whdm?=
 =?us-ascii?Q?9nhnoIhx/FQo30GFeaGXY83lQbSL1L894SIFdSAM2Po6TOef4+TJSrmXDfbN?=
 =?us-ascii?Q?RTbvlRHcGiJ35k0qFuNxPae3CPqQG/3FPr103YsWShIfdF0hjlmnS5NmFj6U?=
 =?us-ascii?Q?lPI1Pok4CgmrUgxppcV3icFS7i+rwzvJBn8N62N88hqEGgw4rXwA99FGHKXI?=
 =?us-ascii?Q?vjNG5wvkqT5Ga1U1u6Pe5bn0XJm+oJVr12cbbRnH7uU02se7IzQ/btcsdHgx?=
 =?us-ascii?Q?QV6zAwl46qa5HYL8LvKkkehOSlcvOR1fTJxp7iayw6mYaWBW0B9BjErUisNQ?=
 =?us-ascii?Q?MvQJ4HcFO8W7V8H69RW+7FQxmZdNVPvHgfa0t18cEP4PTlS7LBOyXQEqCpg6?=
 =?us-ascii?Q?s4+qZFZUg23IyGDGg8iY1qWIxHCM+VAY9k0rNqvJMZSCcm4CHH4ubysSQyqS?=
 =?us-ascii?Q?Zwwc3Zey2w78gvYJIrhaYD6U7MSBv1VFGApH6DCfLmz2kGvx6gDN456mM5S5?=
 =?us-ascii?Q?VzEA9gKmTlXDdsu8VIQxuy55VlqnmP2lW/4tW8Bf+ef+7eDT8LUIXJP194NJ?=
 =?us-ascii?Q?DYGKX4xmfTjtEFbuB8g+VUYuziClAgIPpKb+m7L/EkVFSnzRtaYfbdOUO5eH?=
 =?us-ascii?Q?8vgiTqjy7rJduA8zkzahxoRgZ6OPzZeFVO0dcfarIAPVjLJr1THRPiPaJxfX?=
 =?us-ascii?Q?hvW6ov96lHI7n0WYYQafg0sdJLt2LtO69ZYzWOwlGIGlOHpqMNuPKwiOF4rK?=
 =?us-ascii?Q?xY4sNI/JRDkz9tXGBfG1QGpWnJvehB7MyR8RH7W69FlDd/UG8bVlhYRGAsqc?=
 =?us-ascii?Q?Eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?T6+njEY+lrcM5o5l3d2RkiAebn9lvr9vLds9PqZ9IBgebOGFS3ywYvATs3YH?=
 =?us-ascii?Q?airkHs2aeNpRh91+f6jaHNiE1FueOFmDze9YNTPEfeuLm+JbnYB0pXLAG/d9?=
 =?us-ascii?Q?wl2bu3vdE2USok4d0Hq4kHky8BTPg7SpLtiquBxoeui0MR8rE1+ESEx9cC4+?=
 =?us-ascii?Q?34POcek2zhnTfko+VO+eZCYY1t5PGx2lq5nXJ9cC9Y/4wte4ebClJPFzRN5Y?=
 =?us-ascii?Q?/RWSgX9G9Te/q7zoXOZro3czm5CgimWcrXKrPN+oKNinHRa9Sitd2LghvhUl?=
 =?us-ascii?Q?dAwnO3NZweiESVycrg0zBDqBILIHKxMpozlhGsYOe6o3E2DGkxcwokVoFSaz?=
 =?us-ascii?Q?m+XxLf1A/IE1VtgVM+4DLPIuyWvUalB+1FT7C8zAHFu7WEyCTwp55EnYjfMB?=
 =?us-ascii?Q?e4OUKf6JsN7jpIXhlm2eBsuPc+U7rKPCEkCS1AJBbAKVu1ObwTogddxsl08j?=
 =?us-ascii?Q?ArivMzeR3mCNAXnPvg8d/Zy8rQPleuT5+OVWE80dPIKlbrM1KPyMAnYbvvQR?=
 =?us-ascii?Q?GWDYlZ8OyBU+zX85Iy+PscG61BUyJqtVV2827KXa9BHZiRYIEkYw/t+rFDAF?=
 =?us-ascii?Q?MaxJDP5rYiMv/ak4AYgaE1Fi2LZZ4XEgRhcXjyHwPLoPLmKLz/0UuyXrUT0R?=
 =?us-ascii?Q?6jT1cXkU6TnH0KkHp9QFUDzaE1ptLHWNNRG8f/hsE78CH6vB4Ljga1WgNDUJ?=
 =?us-ascii?Q?lMf46BpcFcdX2PZHSo07n/jo1LfkeP5ODS/27SP/+MO+/UbngP1omG82HXb1?=
 =?us-ascii?Q?9slIv6/KoKRELt2tdkr6gty3suTkHMHy1Vb1wbSL5rt5yux5ohV/ZE+JvozM?=
 =?us-ascii?Q?l+hKLh6WyBHRr9XZgEpeyrWlhF0JedOnV5G5oGTsayZxxvBc20pOMdez8oNZ?=
 =?us-ascii?Q?o+EJ6xIvjPPxkBCVMHQpyxWBQBvb6wbYN08SMvXbWhiDvpt9iUawbQNOEK1M?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1054a331-4123-48ff-65af-08db5564c8a4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 16:52:35.5983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ExVkadTNy9im0wP1ORy7H2ej7yovFqUewqhIA1hkNgDbBjEKaX4tr641FQspDoaRnAOjNjlBkQfuPbd14waQHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7442
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_14,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305150141
X-Proofpoint-GUID: 9oTSpf1eWrtac8YlAz-r-latMkr5SYnu
X-Proofpoint-ORIG-GUID: 9oTSpf1eWrtac8YlAz-r-latMkr5SYnu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230515 09:18]:
> Drop mtree_alloc_{range,rrange}(), mas_{rev_}alloc() and mas_fill_gap().
> mtree_alloc_{range,rrange}() currently have no users and can be easily
> implemented with mas_empty_area{_rev}(). mas_{rev_}alloc() and
> mas_fill_gap() are just their internal functions, drop them together.
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  include/linux/maple_tree.h |   7 --
>  lib/maple_tree.c           | 177 -------------------------------------
>  2 files changed, 184 deletions(-)
> 
> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> index 542b09118a09f..3dd6edccf83af 100644
> --- a/include/linux/maple_tree.h
> +++ b/include/linux/maple_tree.h
> @@ -306,13 +306,6 @@ int mtree_insert(struct maple_tree *mt, unsigned long index,
>  		void *entry, gfp_t gfp);
>  int mtree_insert_range(struct maple_tree *mt, unsigned long first,
>  		unsigned long last, void *entry, gfp_t gfp);
> -int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
> -		void *entry, unsigned long size, unsigned long min,
> -		unsigned long max, gfp_t gfp);
> -int mtree_alloc_rrange(struct maple_tree *mt, unsigned long *startp,
> -		void *entry, unsigned long size, unsigned long min,
> -		unsigned long max, gfp_t gfp);
> -
>  int mtree_store_range(struct maple_tree *mt, unsigned long first,
>  		      unsigned long last, void *entry, gfp_t gfp);
>  int mtree_store(struct maple_tree *mt, unsigned long index,
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index b37065a6f570d..49dfe81dfa1b6 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5120,46 +5120,6 @@ static inline void mas_awalk(struct ma_state *mas, unsigned long size)
>  	}
>  }
>  
> -/*
> - * mas_fill_gap() - Fill a located gap with @entry.
> - * @mas: The maple state
> - * @entry: The value to store
> - * @slot: The offset into the node to store the @entry
> - * @size: The size of the entry
> - * @index: The start location
> - */
> -static inline void mas_fill_gap(struct ma_state *mas, void *entry,
> -		unsigned char slot, unsigned long size, unsigned long *index)
> -{
> -	MA_WR_STATE(wr_mas, mas, entry);
> -	unsigned char pslot = mte_parent_slot(mas->node);
> -	struct maple_enode *mn = mas->node;
> -	unsigned long *pivots;
> -	enum maple_type ptype;
> -	/*
> -	 * mas->index is the start address for the search
> -	 *  which may no longer be needed.
> -	 * mas->last is the end address for the search
> -	 */
> -
> -	*index = mas->index;
> -	mas->last = mas->index + size - 1;
> -
> -	/*
> -	 * It is possible that using mas->max and mas->min to correctly
> -	 * calculate the index and last will cause an issue in the gap
> -	 * calculation, so fix the ma_state here
> -	 */
> -	mas_ascend(mas);
> -	ptype = mte_node_type(mas->node);
> -	pivots = ma_pivots(mas_mn(mas), ptype);
> -	mas->max = mas_safe_pivot(mas, pivots, pslot, ptype);
> -	mas->min = mas_safe_min(mas, pivots, pslot);
> -	mas->node = mn;
> -	mas->offset = slot;
> -	mas_wr_store_entry(&wr_mas);
> -}
> -
>  /*
>   * mas_sparse_area() - Internal function.  Return upper or lower limit when
>   * searching for a gap in an empty tree.
> @@ -5307,74 +5267,6 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
>  }
>  EXPORT_SYMBOL_GPL(mas_empty_area_rev);
>  
> -static inline int mas_alloc(struct ma_state *mas, void *entry,
> -		unsigned long size, unsigned long *index)
> -{
> -	unsigned long min;
> -
> -	mas_start(mas);
> -	if (mas_is_none(mas) || mas_is_ptr(mas)) {
> -		mas_root_expand(mas, entry);
> -		if (mas_is_err(mas))
> -			return xa_err(mas->node);
> -
> -		if (!mas->index)
> -			return mas_pivot(mas, 0);
> -		return mas_pivot(mas, 1);
> -	}
> -
> -	/* Must be walking a tree. */
> -	mas_awalk(mas, size);
> -	if (mas_is_err(mas))
> -		return xa_err(mas->node);
> -
> -	if (mas->offset == MAPLE_NODE_SLOTS)
> -		goto no_gap;
> -
> -	/*
> -	 * At this point, mas->node points to the right node and we have an
> -	 * offset that has a sufficient gap.
> -	 */
> -	min = mas->min;
> -	if (mas->offset)
> -		min = mas_pivot(mas, mas->offset - 1) + 1;
> -
> -	if (mas_is_err(mas))
> -		return xa_err(mas->node);
> -
> -	if (mas->index < min)
> -		mas->index = min;
> -
> -	mas_fill_gap(mas, entry, mas->offset, size, index);
> -	return 0;
> -
> -no_gap:
> -	return -EBUSY;
> -}
> -
> -static inline int mas_rev_alloc(struct ma_state *mas, unsigned long min,
> -				unsigned long max, void *entry,
> -				unsigned long size, unsigned long *index)
> -{
> -	int ret = 0;
> -
> -	ret = mas_empty_area_rev(mas, min, max, size);
> -	if (ret)
> -		return ret;
> -
> -	if (mas_is_err(mas))
> -		return xa_err(mas->node);
> -
> -	if (mas->offset == MAPLE_NODE_SLOTS)
> -		goto no_gap;
> -
> -	mas_fill_gap(mas, entry, mas->offset, size, index);
> -	return 0;
> -
> -no_gap:
> -	return -EBUSY;
> -}
> -
>  /*
>   * mte_dead_leaves() - Mark all leaves of a node as dead.
>   * @mas: The maple state
> @@ -6481,75 +6373,6 @@ int mtree_insert(struct maple_tree *mt, unsigned long index, void *entry,
>  }
>  EXPORT_SYMBOL(mtree_insert);
>  
> -int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
> -		void *entry, unsigned long size, unsigned long min,
> -		unsigned long max, gfp_t gfp)
> -{
> -	int ret = 0;
> -
> -	MA_STATE(mas, mt, min, min);
> -	if (!mt_is_alloc(mt))
> -		return -EINVAL;
> -
> -	if (WARN_ON_ONCE(mt_is_reserved(entry)))
> -		return -EINVAL;
> -
> -	if (min > max)
> -		return -EINVAL;
> -
> -	if (max < size)
> -		return -EINVAL;
> -
> -	if (!size)
> -		return -EINVAL;
> -
> -	mtree_lock(mt);
> -retry:
> -	mas.offset = 0;
> -	mas.index = min;
> -	mas.last = max - size + 1;
> -	ret = mas_alloc(&mas, entry, size, startp);
> -	if (mas_nomem(&mas, gfp))
> -		goto retry;
> -
> -	mtree_unlock(mt);
> -	return ret;
> -}
> -EXPORT_SYMBOL(mtree_alloc_range);
> -
> -int mtree_alloc_rrange(struct maple_tree *mt, unsigned long *startp,
> -		void *entry, unsigned long size, unsigned long min,
> -		unsigned long max, gfp_t gfp)
> -{
> -	int ret = 0;
> -
> -	MA_STATE(mas, mt, min, max - size + 1);
> -	if (!mt_is_alloc(mt))
> -		return -EINVAL;
> -
> -	if (WARN_ON_ONCE(mt_is_reserved(entry)))
> -		return -EINVAL;
> -
> -	if (min > max)
> -		return -EINVAL;
> -
> -	if (max < size - 1)
> -		return -EINVAL;
> -
> -	if (!size)
> -		return -EINVAL;
> -
> -	mtree_lock(mt);
> -retry:
> -	ret = mas_rev_alloc(&mas, min, max, entry, size, startp);
> -	if (mas_nomem(&mas, gfp))
> -		goto retry;
> -
> -	mtree_unlock(mt);
> -	return ret;
> -}
> -EXPORT_SYMBOL(mtree_alloc_rrange);
> -
>  /**
>   * mtree_erase() - Find an index and erase the entire range.
>   * @mt: The maple tree
> -- 
> 2.20.1
> 
