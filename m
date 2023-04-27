Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF7E6EFECC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 03:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242803AbjD0BLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 21:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbjD0BLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 21:11:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B770C0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 18:11:10 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QGx6an014746;
        Thu, 27 Apr 2023 01:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=wZ1ADttNpSNi29i4dyWLkNemxc+dKOygzzOT5f9RYs4=;
 b=rK80HmslVf0cwryrZkYvpuRgFYNW1djTac4pzx/OXEmmldr5WpqK5X9aTAwOphK92Mgf
 RxKvLoQ4Z88ECeixTlEHCu9nF5TazI6ARzUM+waPs0JVIR2fjj6NgyAGQDH5zQpWQi7F
 1/HWXPKWTsnhgKMcS3PQZDo+V9iRhEVc2GzQ0Y+Kh8tvOV32kCvurEmqqDi3qLrxeFTo
 VmnhQL0aWhJmINe62KrKviZGuakeEfsGrzbjuusxVCdvYVfkxvmdo6N49JsMlPjmacJU
 NdVROqIm5g3cBf6pg0CUqaiCZUtloGfpxSjzwI9hVaHjiTmhEqEObaTo5MvXSS+L/Aah cw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q47fatps6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 01:10:49 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33QNqJ8c008496;
        Thu, 27 Apr 2023 01:10:48 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4618whak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 01:10:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANxFW2/fA+9dwHufXa448a32TpGZ9tGzwIT+inXoszRp2FEQmn+MUylmleipeRrIF6RFW/vEqgjaLPKrRep0D1GRTMpc6QRe86M9mViIxUsg4ljT94LopuAVcvOceSfQRfc9zkS6IAhWKqgLFMJr0q4B5rpMhnoeXCcRxPwBI1pE2X/oFsa7WItXBv4KbCZwEe5LXwLw6dtjXxJepiYmZ/num6Dq87kff/WWiVl92l7Tsdqu6MCfdJx+khdIobn/UjYRXSdtGnIhx6j+GWlCRtg6At9yCdc1H7tvTW9EbMYs0pBdZcnt2xHlg1boIBgPJM7WUPdBo8ScQ/OQh2EBdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZ1ADttNpSNi29i4dyWLkNemxc+dKOygzzOT5f9RYs4=;
 b=i3looDAvYB86XoM41F2ZcQ9UXaod0UtjomyEcWC/zoSO/kL8Wh3OPIOStvsTttVuWG55l2pueCwnYcT1c229BMHBfA3JagZ6OsRDLN9mW32qZgM1H30qYanWxHVUlzt8bmGg1wkE8LqqRq4gXSj9P3SoswgeulJxKvJYbBBEn3Sa6qUMap2P9oLD4T0Hqr1nlmZvsRikK2ZhfhcojKESuh88ncfQcWYvNstus7OxhKbxbKDSNxgj5691eUDN0cZsnzDHvGujHIvcP2K6ORuufjb377gkUu+BxdIfsS5BZKN2JgQKKA5vgCgEvZmacqK37oeivzHaODW/lWLx8Mh51Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZ1ADttNpSNi29i4dyWLkNemxc+dKOygzzOT5f9RYs4=;
 b=q6nlEc6L57C3NA7/UgLiywSALCyStapmPjhMiOStq8nqQglNp+sOiPGYVDro1QHnAsJtGhB2EQIPuP/94l4Uxw0PmvdndvOK8K+9LnDxTuFQHpP1N5IUsiIiRdzuU/0RrQsgC4NF6jPuCKK59sB70BwufjF0BW3vTERtDw+nF84=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4685.namprd10.prod.outlook.com (2603:10b6:a03:2df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 01:10:45 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Thu, 27 Apr 2023
 01:10:45 +0000
Date:   Wed, 26 Apr 2023 21:10:42 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <perlyzhang@gmail.com>
Cc:     Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH 3/9] maple_tree: Modify the allocation method of
 mtree_alloc_range/rrange()
Message-ID: <20230427011042.dvxn33dm5hbrbxh7@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <perlyzhang@gmail.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230425110511.11680-1-zhangpeng.00@bytedance.com>
 <20230425110511.11680-4-zhangpeng.00@bytedance.com>
 <20230425160815.mionpme7bmdequzb@revolver>
 <1ee0cfa0-c442-1e31-24a8-90dd8b7ab2a6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1ee0cfa0-c442-1e31-24a8-90dd8b7ab2a6@gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0417.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::21) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4685:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ab59f59-f864-422c-58f8-08db46bc3a75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: abh3t0li2HKc7z4WxjUMtKK8pmnwzWv4PNSPCyybF7wXcc6BTBIYuX5HiG0G1U0iKOgSWMUi7MyQJ71xX/QTD8Fp4/KU4BLzdHOtY1Yi3vLgBktavybO3hUWHARkKoql9QUmrQ+eNn4Lseubsi+a82k5jLoghrEMfpkS0yV2OoF2gNndMeSmmOAJj4Cvdz/YfzBxQ14n8JirRlKfgWbOxf4i+3xEe9Nl9hFGBxjOGNsZ+84rstlNDSgndM1vsfIjd/JeejuScIeaFzWJFj8RAH3hajm6w8As2O1xyc7Zshi+qzfE8aQSE8UCfjYzDxB00r7JCyWluQgnwhAYoOiGk/JaogJJoO2ZYyKtszlmX0+8e1ll+nVDQl3aDB5GpOU3be5epk2ItAEmGSZjIejPUsG5fGxq4k/0xTggy6iNgqs4iDQ6yFxhqD8FSqIKbxEUkOwKG4vrN4LrmVGh8KSgQldyy+jze3079ZRJxko37n1MDmEs+DripvHz8pqm58TMmh9OKtBaPWAwW00vdWVQ1Fds/nGoVwcGZoLTIwD+87C6RxfMXNEOhLKO6wcyjZyc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(396003)(376002)(366004)(136003)(39860400002)(451199021)(66899021)(86362001)(33716001)(478600001)(6666004)(6486002)(38100700002)(8936002)(8676002)(41300700001)(66556008)(66946007)(6916009)(316002)(4326008)(83380400001)(186003)(66476007)(26005)(9686003)(1076003)(2906002)(6506007)(6512007)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTI2TENhUjZESmxZSHlySGJoemZINjQ1SGpIdVZ5b2E1QWl6dER2ek1tc3FQ?=
 =?utf-8?B?QzZtamlmYVhjTUs2eGpVYmdoeWZITVc4cXNQQXdBelhLWHFSdXJnM2ZwRFRT?=
 =?utf-8?B?WDYvWXRaM0F6VXdDcG5BVlBzdEh2U0xBN01KN2JVZVU5ejNBUkFDbkdya3Jo?=
 =?utf-8?B?dU1OREk0MW1sRFpLNmRIZ1duWE9oUzdaSlZDcFpGVm5pS0tPVmJJVW1qZzFX?=
 =?utf-8?B?TmZ4VjVTK2F4WHpUeTVYNGk5SnA5RE5KenZ6WGNnZUhpQ2lLZU5UdE1RcENI?=
 =?utf-8?B?VFY1WDc3WDdUL2FnU1RSNHlzUVd4ZmhUaDhNdDNZTXZ0a0J2d1Fkbzh6bGN2?=
 =?utf-8?B?blRrb1FJeTN1UldrVXFNMStjSms2SVFxUUE4bnRMMUZLOEZGeG4rMG9XZzlI?=
 =?utf-8?B?QjVzejJaZUdWR3NrakJhYmMvQmZ4bVpUbjFIVlNGTlJQQmV3KzB4a291dXdC?=
 =?utf-8?B?UW4wbHBMYUQva01rVFdDRzdlSFlFVnl1eVFaRm41ZC9rR3ZZdFFHVDdSVmVH?=
 =?utf-8?B?QXZCWE1zenQ3TnM0N1h3NTUzeHVFSWJpZmFDTFFXNUUyWHROUkhuWVB2VlQy?=
 =?utf-8?B?QnJJeXl5SlArWkY3c2ZjeVhpWjFxTUx1KzAxMmFwTys5RnhiaElXZlpwRTc5?=
 =?utf-8?B?N21PN3hiY090bklzS0VodVNDbFFsRjdDSm1Cb2YyR1FVMktRcjRqbDJMMENS?=
 =?utf-8?B?U3J1SG5nTlRyL2J6VEhMbHAxN0NaYjh2TjVqbmFlL2FiczM3ZllTODQ1Y04z?=
 =?utf-8?B?MXNGRk8yLytpL0orTlVINFVIbjVDNG9rdDgvY280V2IyYWF1OTdOdSt1VGVE?=
 =?utf-8?B?MUovOFVFcURYL01MQmU2WHZXdStCUUJabGNtQ0h6N3I0VGVGT041MjFkdXBV?=
 =?utf-8?B?ckF3VndEL3NXSzlHM29LZ3BZL21tbDd3c1dBMmh5MklPYWZkK2lNaHFydWk1?=
 =?utf-8?B?QzhPZzFTUjFHR2Z0VXpDbHlQWXFic0x1dG1lN01HVzJITWV5TXA3K3VEUmw2?=
 =?utf-8?B?VGVqNnRUbFZ5OTFNazZXb1NzbmlqcDBzd3orSWtCdGt6bVc5c0Nwd25wS09j?=
 =?utf-8?B?ZUt2TTd4TnJkYU9LQWMzMTgyZTl2YndZVXlpb1drNnQ4NytIRHd4UnpDYUFl?=
 =?utf-8?B?UHZERnJhVHVNbzkzTm5ha1BJNFR3cjcwbEVyb0s1Mll1ZDdUV1I1M3VldW43?=
 =?utf-8?B?Q0YzSW05dG1oWTJkcnpjdUZoZG90OVNsZHhLNzhoMVBnUFpNb1hIc2Z0NjlX?=
 =?utf-8?B?Vk9XQkdENFUyd2ZIQ3U0TEcvK0RiN2RVNm5YVGtNTWwyVDNJR1ppRnR6d29K?=
 =?utf-8?B?OVhaQ3RHUUdoSENhZ0VqRGx6bmlRamlrTUFCSzlMdUlCWkZZeWhmQVZHWDV5?=
 =?utf-8?B?VS9NS3RrNjdDa1pDRER1bWdNMllkZUNlVG9FejVZMFFXTDZrZTN5TWU4Sjd1?=
 =?utf-8?B?M2lOVUpvMUh3WUNmQjA1a0s3S1gvbDFmRUZMZ1ZnQzBXQTRlOFRXdHY0NGtW?=
 =?utf-8?B?Mm1yc0E5aTdTTnZFdGY4YkIyZ3k0ZXhxakZNVUUzMnZzWnRKcmRMd2hSQ3N3?=
 =?utf-8?B?QW1kdjBQaklaTTdUK213Z09hMkc3dGpjNDUvMmVuZDNoRWxERmhyeUlkL1A1?=
 =?utf-8?B?dnJsUTc2eTZLNHJyVU1qYlNSb2ZEZFgxWlV1S3kxSjJyODAxM1hVZWpiUnd0?=
 =?utf-8?B?U2JEcEErQlU2S1BNWUxpRnBCcURHRmc1eDJkUkhrTzEvSm9vVTEzT0JIOFhR?=
 =?utf-8?B?dTJVYjZSWUN0eXljL093WjBZVHYzZENPZmJXMkRZQjVPTFZYMEFkaERZMkVt?=
 =?utf-8?B?dmllbFFrbUE4Qm05YnRvc2w2R3hjMXVVcERYTkFHcnV3WEFqVXAyVldzcTBs?=
 =?utf-8?B?bUlsRGR1VVFuVzdac3MyTW9nUDJ5aGVvbFFRZHlyaUhqWnpFWmRKampvWXZk?=
 =?utf-8?B?S1lKbWg2S2lPS1g2MFl4eTl0eFBkR01xWUhPY0FydzNVZUJuVmw4K25MZW1v?=
 =?utf-8?B?QXFuczU4L2h1enZFaFhqRDlscTZHaUtKOEJWTDhTYVlKNFJWNUNuNERZVk12?=
 =?utf-8?B?eEp6bERRcHpoMkUyWEU5SVg3ejFFVXAvbFBQbjFLUmVlMG5UbDJTajQ1cG1l?=
 =?utf-8?B?aXdSVitNekxhcTNvTy9nVDYvYlY5bVlUak5GVE9hU0JIeGRVb0NXVGplMWZk?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZHUzTGNWNVRiem05QUJyTk4yZ1FzcGxLYnV4Q1dTLzN2OW1JUWwxWG42VUlG?=
 =?utf-8?B?RnY5bWpyQkpuQXZxYWJrMjg3SDl6Yyt5YnZCZWM1WjNzdnlYMnE0aWtYZko1?=
 =?utf-8?B?blVsQ2FkK1FGMkZ4aWhiL3l1c01BcUJIMkplNUVQQnRlVHhqVlN2R0ZSYnFu?=
 =?utf-8?B?NlVHNlpVbm1UK2Zpblg4eEZ2YndRUmQwYW4zSE5XdFVQL2xieGZoS3U0Z3Vn?=
 =?utf-8?B?Si9IdXhwZzU5dWxuODU0UkZUZzYzUVI5ZVVJZDF2dENnZ0V5bWNyVUR4YTFn?=
 =?utf-8?B?QndZMFJQUDFqenV6dTdjZEI0d3VmMmxQcGovckdaZ0RiRHBUQUNqMzAyeEl6?=
 =?utf-8?B?RHpiVnpaUXlrai85UGVwc3p1NSs3T0s4OWpoa3hxeVc2QTZNN2t4elA2Y1kw?=
 =?utf-8?B?SHpSdTZ0ZVo3SnI4cE9nc0R2dkFvZGdsdXcvaHpkSHlHQ3poZ0F1RzdYejlT?=
 =?utf-8?B?WEg1dDB2MDhqcXlIdlBkU1FiUXNyRjR3TE93MWJCaXZoeTVHZWVsZE5zUzcz?=
 =?utf-8?B?d2daT0g1STNvcHFlRE9NTEFHZmlnUEZSck4zTkJOSXpua0ZiQnphaVcxbmYv?=
 =?utf-8?B?SU05d2c1emJSSG1TREdENGFZNmxYdVd4NjlvUTRCVmhxejdRNENVTGpWdUt6?=
 =?utf-8?B?L3VvVFZMMnNRL3hnM3kzVmlzNzBaejhmNjd0NyttbEVrbjRSdHNjbzdReGRo?=
 =?utf-8?B?cmI0Q2l1aEQvcEFHK2xET0VSc3FyYjRhY0FyZUV3cnJGSjRtbTBsTEVqcjRt?=
 =?utf-8?B?YkFyMUVRaXc4c0JaUkZ5UHB5ZHVGV2hkSitMQmVkeERldHlwMC9HMENEOGJp?=
 =?utf-8?B?Tms5aGFTSUUxdnJRcDBzSVhxV2djQTR2VGJsQVVLOWZ0c3FwNWxjeG9LR2py?=
 =?utf-8?B?aW9kSDlmR0ZhRHE5MktJaGN2bzh4OTFFRXZKeUs1b292Q0ZVN2M3YUVUM2tj?=
 =?utf-8?B?RFg0ZjNheENlSmVrdEdiVW94MUgveGJXTVdKNHE3T1RWd3ovK3ZMckdFWlJ4?=
 =?utf-8?B?aFpaUWt3VWZ1ZG5WV0FxZTBKcUx4MWhZRlB2ZCtRSDVycDhUTnNTcndHand6?=
 =?utf-8?B?MjZKREFOUlVxTElRY1VLVGc3dmJxMm1wdWRhVnZuOUVlbFNhSzUzWHYvOVVj?=
 =?utf-8?B?aUZXZFpzWlgzZmJWV29TbElCMnZtSFVCUjcySzU0cjhOMkJ3TjUvRkZ2d2hu?=
 =?utf-8?B?ZXVyVmUwaHROVGlja3Nkd1lQRkRueWJ4OWljNHM2QWo2UHJNdS9RdFVpVXB1?=
 =?utf-8?B?S1B0aDZLbzZxeXk5cWRBL1NUU2dXSGRVQ25aVHFhQkl2QVlCUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab59f59-f864-422c-58f8-08db46bc3a75
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 01:10:45.3143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oPPR0HFVL/B1JF/k/d++EVK4n+P7vLonlplngkp5rR/bnWn7JnxV8wy/4RSax24WFMJKDF6kp8Hi1/yTfwvKlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4685
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_11,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304270008
X-Proofpoint-ORIG-GUID: gphUFZiE3HrDNkNxS9zQf_Nl-Kir4w_I
X-Proofpoint-GUID: gphUFZiE3HrDNkNxS9zQf_Nl-Kir4w_I
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <perlyzhang@gmail.com> [230426 08:34]:
>=20
>=20
> =E5=9C=A8 2023/4/26 00:08, Liam R. Howlett =E5=86=99=E9=81=93:
> > * Peng Zhang <zhangpeng.00@bytedance.com> [230425 07:05]:
> > > Let mtree_alloc_range() and mtree_alloc_rrange() use mas_empty_area()
> > > and mas_empty_area_rev() respectively for allocation to reduce code
> > > redundancy. And after doing this, we don't need to maintain two logic=
ally
> > > identical codes to improve maintainability.
> > >=20
> > > In fact, mtree_alloc_range/rrange() has some bugs. For example, when
> > > dealing with min equals to max (mas_empty_area/area_rev() has been fi=
xed),
> > > the allocation will fail.
> > > There are still some other bugs in it, I saw it with my naked eyes, b=
ut
> > > I didn't test it, for example:
> > > When mtree_alloc_range()->mas_alloc()->mas_awalk(), we set mas.index =
=3D min,
> > > mas.last =3D max - size. However, mas_awalk() requires mas.index =3D =
min,
> > > mas.last =3D max, which may lead to allocation failures.
> >=20
> > Please don't re-state code in your commit messages.
> >=20
> > Try to focus on what you did, and not why.
> >=20
> > ie: Aligned mtree_alloc_range() to use the same internal function as
> > mas_empty_area().
> >=20
> > >=20
> > > Right now no users are using these two functions so the bug won't tri=
gger,
> > > but this might trigger in the future.
> > >=20
> > > Also use mas_store_gfp() instead of mas_fill_gap() as I don't see any
> > > difference between them.
> >=20
> > Yeah, evolution of the code converged on the same design.  Thanks for
> > seeing this.
> >=20
> > >=20
> > > After doing this, we no longer need the three functions
> > > mas_fill_gap(), mas_alloc(), and mas_rev_alloc().
> >=20
> > Let's just drop mtree_alloc_range() and mtree_alloc_rrange() and
> > whatever else you found here.  They were planned to simplify the mmap
> > code allocations, but since there would need to be arch involvement
> > (coloring, etc) and alignment, etc; it is better to leave this job to
> > the mm code itself.
> Ok, I will remove some useless functions here.
> But mtree_alloc_range() and mtree_alloc_rrange() really don't need to be
> reserved? Because I don't know if there will be users using it in other
> scenarios in the future.

As you showed, a lot of the code is now the same elsewhere, so it
wouldn't take much to make a version of this outside of the tree if
someone needs the functionality.

>=20
> Thank you for all your suggestions on this patch set, I will update them.
> >=20
> > >=20
> > > Fixes: 54a611b60590 ("Maple Tree: add new data structure")
> > > Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> > > ---
> > >   lib/maple_tree.c | 45 ++++++++++++---------------------------------
> > >   1 file changed, 12 insertions(+), 33 deletions(-)
> > >=20
> > > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > > index aa55c914818a0..294d4c8668323 100644
> > > --- a/lib/maple_tree.c
> > > +++ b/lib/maple_tree.c
> > > @@ -6362,32 +6362,20 @@ int mtree_alloc_range(struct maple_tree *mt, =
unsigned long *startp,
> > >   {
> > >   	int ret =3D 0;
> > > -	MA_STATE(mas, mt, min, max - size);
> > > +	MA_STATE(mas, mt, 0, 0);
> > >   	if (!mt_is_alloc(mt))
> > >   		return -EINVAL;
> > >   	if (WARN_ON_ONCE(mt_is_reserved(entry)))
> > >   		return -EINVAL;
> > > -	if (min > max)
> > > -		return -EINVAL;
> > > -
> > > -	if (max < size)
> > > -		return -EINVAL;
> > > -
> > > -	if (!size)
> > > -		return -EINVAL;
> > > -
> > >   	mtree_lock(mt);
> > > -retry:
> > > -	mas.offset =3D 0;
> > > -	mas.index =3D min;
> > > -	mas.last =3D max - size;
> > > -	ret =3D mas_alloc(&mas, entry, size, startp);
> > > -	if (mas_nomem(&mas, gfp))
> > > -		goto retry;
> > > -
> > > +	ret =3D mas_empty_area(&mas, min, max, size);
> > > +	if (!ret)
> > > +		ret =3D mas_store_gfp(&mas, entry, gfp);
> > >   	mtree_unlock(mt);
> > > +	if (!ret)
> > > +		*startp =3D mas.index;
> > >   	return ret;
> > >   }
> > >   EXPORT_SYMBOL(mtree_alloc_range);
> > > @@ -6398,29 +6386,20 @@ int mtree_alloc_rrange(struct maple_tree *mt,=
 unsigned long *startp,
> > >   {
> > >   	int ret =3D 0;
> > > -	MA_STATE(mas, mt, min, max - size);
> > > +	MA_STATE(mas, mt, 0, 0);
> > >   	if (!mt_is_alloc(mt))
> > >   		return -EINVAL;
> > >   	if (WARN_ON_ONCE(mt_is_reserved(entry)))
> > >   		return -EINVAL;
> > > -	if (min >=3D max)
> > > -		return -EINVAL;
> > > -
> > > -	if (max < size - 1)
> > > -		return -EINVAL;
> > > -
> > > -	if (!size)
> > > -		return -EINVAL;
> > > -
> > >   	mtree_lock(mt);
> > > -retry:
> > > -	ret =3D mas_rev_alloc(&mas, min, max, entry, size, startp);
> > > -	if (mas_nomem(&mas, gfp))
> > > -		goto retry;
> > > -
> > > +	ret =3D mas_empty_area_rev(&mas, min, max, size);
> > > +	if (!ret)
> > > +		ret =3D mas_store_gfp(&mas, entry, gfp);
> > >   	mtree_unlock(mt);
> > > +	if (!ret)
> > > +		*startp =3D mas.index;
> > >   	return ret;
> > >   }
> > >   EXPORT_SYMBOL(mtree_alloc_rrange);
> > > --=20
> > > 2.20.1
> > >=20
