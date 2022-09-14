Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B22C5B8C09
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 17:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiINPhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 11:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiINPgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 11:36:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC26274CC3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 08:35:01 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EDYUHx008370;
        Wed, 14 Sep 2022 15:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=Uysov38MsLQBOvd4ZG59VQb47rpPepw8DPxXB+H1H5Q=;
 b=rzlV6NE1sikItd9jBiYiIeX0RQKgqFqwf5vhlYAwK1qKGMQ5C7QOcoRrU1fpQyjZxwda
 pPfsv8WpDCTX0dPk+Y3o83T7XJEpB4GQNz76g2UUUnpyJWYSm3gDPHtAh4D7KzluBwIJ
 WLs0v95kz4XHhq4/RIQGad6r7lFTKn3OizY5lgcYSfE8w19oNUs9/sjNvQoHKGXhXP+b
 tgFPcLwVgtf7YS94ou4FttPtOBA5lHfdxbqU3ssqxjsQ5JGlmN6yarwRLR+XXNwbnt//
 i7RdJVADYZ2g1DC6X50AD4Vi1Tfaz5b43VT0JWqQI/apy2JaAPzHylK+tv7xPvOxkhmu kw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxycapyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 15:34:43 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28EDZb3R035428;
        Wed, 14 Sep 2022 15:34:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jjykysf88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 15:34:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJ4spBtVqu/548WQIoxXv9JA4EnbVQCoF+2H2dgOYqksCzVwlUkViAuCetn5kv8TE2Che9F6+tVKkN5fbB9adyvWpOfGJRtocvq1o1lsh+MgYKZ0B1Z0n8SSS8pbm48pFStzVEiQyX9n/xZmb90JrFIs6Q2qsvNQNlpCTF8YsxaW2BaZ5uJP/C0pfKxHCEMYD5ZOd/Q895xV0Uv28Xm77hFnYcHWkt1/lb4kNJuYyoVLLF0zv+AOe+7oA1TCYRY00OjrjytCigp/wGXWfjA+0fnJti8eEgoyBJVgprra7HwQx3lzNydo26mbaKtTecq8uPb0QqfDx4/GAauiKiPJeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uysov38MsLQBOvd4ZG59VQb47rpPepw8DPxXB+H1H5Q=;
 b=D7s1nK58hL8RGvHTRVJ+i7+50kJfr0Vs1znYf4xqdlR+Rtv1JiBYtM/9XsyWVP1KXD5HLdqIq86DT0uGmI19m4RIi2uVHgt8N6KVCRxqbq/C2iVQP0N1tLzfNc+NGoO3R9l18VXzRLx3+SVSNhj4aing9cH5m1ZMNOCFwHL0ECNp3t43ERIuK9yPH5C/Qg6q4tySbxjgyZfmaCCbwvLHXFDALggRgDvtKn/8YyzMX1ZIaht0B+NfMnkv2+XHFnL7LlLG1P2GluHo/MXDkGOCPVoC6T8AqMZhr6ubP8hjRXMacorDQrUU4NUmVtqaqrFSs9LvGQoxOVEAIZSEgBueqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uysov38MsLQBOvd4ZG59VQb47rpPepw8DPxXB+H1H5Q=;
 b=UEeSRddCYS8qC6Uv5qF3UW/3XRxnOaJd/0pLEajm00+DYo2ka4sa3+vaXeDeOYXHYgL5fqjEOJLWgmDtH7BT92bNwaTFpLncBVdb4hB1UbBi86Mdey1qe+d2Qfq1ntg+0SxWy4pvB/Fjs3cc9sZ7c824IX7SUB5/cGzfRQbtwcU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by IA1PR10MB5969.namprd10.prod.outlook.com
 (2603:10b6:208:3ef::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 15:34:40 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 15:34:40 +0000
Date:   Wed, 14 Sep 2022 18:34:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     eadavis@sina.com
Cc:     syzbot+c4d950787fd5553287b7@syzkaller.appspotmail.com,
        almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [PATCH v2] fs/netfs3: add a boundary check for EA_FULL
Message-ID: <YyH0dkkuJnFNE9xT@kadam>
References: <0000000000005af92105e80510f2@google.com>
 <20220912065431.3043731-1-eadavis@sina.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912065431.3043731-1-eadavis@sina.com>
X-ClientProxiedBy: MR1P264CA0086.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3f::31) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|IA1PR10MB5969:EE_
X-MS-Office365-Filtering-Correlation-Id: e56ee051-1a51-42ab-d830-08da9666a354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5UqcyD2xlBwOlPxLja2twBHTuZDL2YP6qtXJpSDYbyBq4A2nwLoonz/u4Kl5eQfqo06qv2fiaLS1/su3YZewNFVyJeuySq+Nf0DCVNPcgqL7FD4APfrIEY239HCwzwjwiisi/TaYkmAqOEgebXq8c1k9kRR8W/ON2zopIQ4wzscgaay8iiYolKQl6SzwsfULymKTmHmRlaEDd2jVeT21g1bY3NhXg1RK4y8+uzyZx5YM7ckQwnFzXK9Zs8eGy9eR9s+vMmXljtcACO+5Qcjz60qvD+/TaXxvqRL/hllecATcvARS0NmVrHfs1LmBoQ9k6Po8b2TCHM55SeJQG06utkW12fWr3Bdd0NOgT4CUWEUf9WS4dGiOICITAdsk8vSk5jhAVj1sXJUTYIyY2FTr10oNeaZkYiq0p3tI8sDQLmBg1nEprE445cHNYQM/SzgB73YJ7T6COKzrlKZW1rzv+J/vUFf+uyHA6sN0BA2wkqNvOzWky08MWMKx+FBMVzLbhfaIFdxddC6I8lmMbVA4JdIyFaJGbrAcRCbZU95ZXGjEw/liUT/X1RUu8PcUqI+XbWbkWWvvxekR3Kx8cPinmk9oWbJj75B9jeDhArZKcLDJLEs+hgVn7irpbh/Tpc485aZhjUpzmMtgkav3eXPYtbzB9OrlT6BOKged+lmr3y7WHFMtIQ31VE9j4GI32tB7lNUEz5wN2bdg/uXFeGM3wx1VjBEUcgW3V0aQPIIlDXxBpVPydv+sJDaYLY0VpYT1YEaLzJFxmw6K67COUYPtWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(376002)(39860400002)(346002)(396003)(366004)(451199015)(9686003)(8936002)(44832011)(6512007)(38100700002)(83380400001)(8676002)(6916009)(966005)(26005)(478600001)(66946007)(6506007)(4326008)(86362001)(7416002)(66476007)(186003)(66556008)(6486002)(5660300002)(6666004)(33716001)(2906002)(316002)(41300700001)(99710200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RM1u2Y5P1CJ2RGjo0DCIy43KZWn/yKLGCw42rH8Nkb89Bv0clVIxkcG+rq0E?=
 =?us-ascii?Q?blqjltVCuEFg4/nbGq7w17R76qXo41/Rt6r4+jHEa6x32XzBOxyihUZJVIHU?=
 =?us-ascii?Q?JrOCGRzbi/BAU4laLfSVqJuDcXBzRJ7Gh39d0l/QHYoW2EYdvjyxQZIoEJX2?=
 =?us-ascii?Q?unltSvsjtVdAWcJcKFjJcAGDgIyGzJqt0FeV+MFUOGqh/Dw+89imPvNxmEAG?=
 =?us-ascii?Q?nsL/Akm0OKu1UnK6NHN/yv8qedtKkNXw86zhO4t877zAiapFlDqDgN4/7jWs?=
 =?us-ascii?Q?lkHzfkIHdiHP0W85TDusFpkYk7rpRuo2hJLst7NgLAlPNeDR1xJel+k8cDz+?=
 =?us-ascii?Q?KjzX9GebQc3zlX1dI7cYABaVKR1mBkCvOqxnN51KS73YJ5LwKCC09BYq9CZ7?=
 =?us-ascii?Q?J9VqxyVK/aWRqBxuOFVjQoM0FGnxAwQHbMwzsXGIbovm8qo6PyWt6Qm42JSZ?=
 =?us-ascii?Q?p9ilvdGnH5OiZNrZkHqgYvfIhIF18GubD7ZZklGgjkJNag059ngc/xz7guNQ?=
 =?us-ascii?Q?aOvz1ViTWw+qGJOo/wqPJRsIKPR1Z+bvXbIQiMl4i4muNau8JJfHozvo541M?=
 =?us-ascii?Q?cNcNgE5/KXr5HKp5nUZj54uQ+DFvkDvhxu8cXzvXXz9HDxqGVQZ0mYDtNffh?=
 =?us-ascii?Q?rhUKIyxu6Bs4JuW5QpR2auA+AT/M3yI710fg6snn4FmtTSE/u3zNX2VnyuM5?=
 =?us-ascii?Q?xsbs9X9Ig4BFEHaxwWxQ4LYYs4Qn1CfhWMwFgiP4y73vHHeSskIBRX3EBMSB?=
 =?us-ascii?Q?GmsAENzjvdlN2OzkjLgd9qB3jziRfPyuW3YoMwyHfB1XyynSFKisHgEHVBTV?=
 =?us-ascii?Q?xQQ784AGVEkbN2euw4Rjn0fLthMe0+TDNHP5IR5SDeAzsbCP9KWBrSwqdrhQ?=
 =?us-ascii?Q?F6F+qUORkkQ07UTz03UH0sPS0OGoTyupcN+DPRsu1FfxI/cOsyAy9WXu4oy4?=
 =?us-ascii?Q?g4n8rg63d+rAWHW7RS0+2T7ylroTH4TOP/f44aWV0TG07Nx62sWiTE9v7WaC?=
 =?us-ascii?Q?7DhYkPdT0BMwsJ+HKPQHlvFA8q13E3WElWFfZmxVrlZ6Wnb0OUPyF2CupjIP?=
 =?us-ascii?Q?71viNnDzZvapEXdojpbHkZOulv9ijafVZzZLHvK1b48Wnub1MjEMvwk6RfcA?=
 =?us-ascii?Q?eGJWG2xWwXDn3777DZFgVZm8J0rhknwl/bW1sSPP+lLBkojZpYW6fXvvFz1n?=
 =?us-ascii?Q?htZR7ZfmrfV16IUfOwL/5+hnwwr1gRHVm8G7YUZSyWgZ0HIup6IiB5FUsEO2?=
 =?us-ascii?Q?2HL4SR72f5bX6mRv5f4e6fa2JMmMfGg8AnZFKiJ1V9I9+AfyLfx+7FO2Ey9I?=
 =?us-ascii?Q?cmJFVaEgL8Ch28fLnq9chp2SSCBcfTiBLL5hl6bexA/D+IKJvvDwMHLKBUz3?=
 =?us-ascii?Q?Hnoyy2OOW0tLpZck2ulglbEVl6mbtuw6V7v0LgFDl47Zgfewyl5N2wPnOAev?=
 =?us-ascii?Q?UsWyD8SlKPAUapSMQhrUnX/r1zo0YmeaAgYQffRcU8bvhiE52FEr0egMPSbd?=
 =?us-ascii?Q?7MPkhfIMllEqcpZmv1kXJcm+8x96tbcvf4bPsg+welxElcsvAVMA5h2d4ge6?=
 =?us-ascii?Q?IoxLPX37n+TpsxrmAJmz+ECIWZQ0OQxAH3V5Lzjn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e56ee051-1a51-42ab-d830-08da9666a354
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 15:34:39.9767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6VVDtFC45uJGyLfAD4RmofnryH8eOUOadit2lTVS2Bc6BIfgj6N4h0yF2IY0R9V4/NNKo7YQ10yvvxfthRkE+8QziPE6IGk8hw+WYqEsVdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5969
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_06,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2208220000
 definitions=main-2209140075
X-Proofpoint-ORIG-GUID: En9qTSrqw2eQe789Z0ohZbpn_fwjd0E6
X-Proofpoint-GUID: En9qTSrqw2eQe789Z0ohZbpn_fwjd0E6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 02:54:31PM +0800, eadavis@sina.com wrote:
> From: Edward Adam Davis <eadavis@sina.com>
> 
> the root cause is: 
> The remaining space after the offset is less than the space needed to 
> accommodate the next EA_FULL struct.
> 

This needs to be checked on the first iteration as well before calling
unpacked_ea_size(ea).

	if (bytes - *off < sizeof(*ea))
		return false;

> Link: https://syzkaller.appspot.com/bug?extid=c4d950787fd5553287b7
> Reported-by: syzbot+c4d950787fd5553287b7@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@sina.com>
> ---
>  fs/ntfs3/xattr.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
> index 7de8718c68a9..c90cc453390d 100644
> --- a/fs/ntfs3/xattr.c
> +++ b/fs/ntfs3/xattr.c
> @@ -52,6 +52,7 @@ static inline bool find_ea(const struct EA_FULL *ea_all, u32 bytes,
>  	for (;;) {
>  		const struct EA_FULL *ea = Add2Ptr(ea_all, *off);
>  		u32 next_off = *off + unpacked_ea_size(ea);
> +		u32 next_len = 0;
>  
>  		if (next_off > bytes)
>  			return false;
> @@ -63,6 +64,13 @@ static inline bool find_ea(const struct EA_FULL *ea_all, u32 bytes,
>  		*off = next_off;
>  		if (next_off >= bytes)
>  			return false;
> +
> +		next_len = next_off + 8;

8 is a magic number.  Use sizeof(*ea).

> +		if (next_len >= bytes ||
> +		    ((!ea->size) &&
> +		     (next_len + ea->name_len + 
> +		      le16_to_cpu(ea->elength) >= bytes)))

This is open coding unpacked_ea_size() but slightly different/incorrect.
No need to check this anyway, because it gets checked at the start of
the iteration.

If we add the if (bytes - *off < sizeof(*ea)) check to the start of the
iteration that means we can delete the "if (next_off == bytes)" check
from the end.

The second issue with this code is that unpacked_ea_size() is a user
controlled u32.  We're adding it to "*off" which is also a u32 so that
can have an integer overflow...

See diff below.  (Untested).

regards,
dan carpenter

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 7de8718c68a9..c3dbe06fb784 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -44,14 +44,20 @@ static inline size_t packed_ea_size(const struct EA_FULL *ea)
 static inline bool find_ea(const struct EA_FULL *ea_all, u32 bytes,
 			   const char *name, u8 name_len, u32 *off)
 {
+	const struct EA_FULL *ea;
+	u32 next_off;
+
 	*off = 0;
 
-	if (!ea_all || !bytes)
+	if (!ea_all)
 		return false;
 
 	for (;;) {
-		const struct EA_FULL *ea = Add2Ptr(ea_all, *off);
-		u32 next_off = *off + unpacked_ea_size(ea);
+		if (bytes - *off < sizeof(*ea))
+			return false;
+
+		ea = Add2Ptr(ea_all, *off);
+		next_off = size_add(*off, unpacked_ea_size(ea));
 
 		if (next_off > bytes)
 			return false;
@@ -61,8 +67,6 @@ static inline bool find_ea(const struct EA_FULL *ea_all, u32 bytes,
 			return true;
 
 		*off = next_off;
-		if (next_off >= bytes)
-			return false;
 	}
 }
 
