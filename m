Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C671B681A6F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237508AbjA3T1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjA3T06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:26:58 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53A29EF1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 11:26:56 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UHY9cC010083;
        Mon, 30 Jan 2023 19:26:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2022-7-12;
 bh=EpblbO+gfinw3zm6IShT+z5eGfj6lv/b+pbNWzdgSCc=;
 b=C1joi7vNu3YjPBYlJaamJEXWOkCwLFmvXwcVs0sayFNZVe2pesnnpCMZnwnbEfGzCSM9
 LABU1GKPF/7Chhf8xJJg3zgb8BSBNGUsevvcT5vaJYV1K2IH0wJ/0kVrNkcMlVnaUyR5
 mqMtb7euqLEPM1J/n/qZWNTDfHiSd9SMOYjaI5E6L8p/redibd7janONFEsW7HpDiMwo
 iqItvDcUgoG3yAYk6g4Ff5V0yO5kgTDlo45BqRfkPdyQkp9axGsWg/qsIM90+QUR8st0
 v1mKDo3CfqGuJnVeyvzr/XKJcGEcHQGB4bnMJ+60xZXGX641QzT+Mb9Xa7NW4UCxWvBN jw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvq9ktf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 19:26:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30UIFtpW031757;
        Mon, 30 Jan 2023 19:26:40 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct54jj0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 19:26:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DllDboGLx3D9SErB3VrQQZ11rr/o7bTV8bDijPNt5J2Ay6MQRHB3SJGLNBDfjq2H7ibylNFDExujZboTz2NOjpM+KUoxZjT3Vcq64yJqW1ASE4/+qgPxDy/K22O1Gccfw/Mm03AmAQhy7d3h5iCD5ureBCChc3k2GyYvFt4IujCGX98d7xWGGAznlHBYIB3Yl11N6so7SYnv7MTnnzxTUCB3KI2tZEo8t6JwJ3TQQ7zCUvYF6063dxJrPu3M0wKVHevRu25c0ylh/QXvdG7O7Yjs4pKThPmYB1nD6L1Op20deIKSRJ/CthL4Uk21CGK3QiUWqzZHg1cDa8zWjKEBaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpblbO+gfinw3zm6IShT+z5eGfj6lv/b+pbNWzdgSCc=;
 b=lbMz5m2QUM0fDMl09Oqo3siYWsf3HFr4jzdJQ8qypq1u0sH4/16v/rNcabE7q0Wv9h6HH8KgdGZOp7Uvt3+POY9Z/ypXXRcfR0k4KmZ8eVeuajyA3U0B4hAB0klTZL9fSSZyxfIuBN/lqK6NRSHtquuTQHta9vxy/hzhBYn3WO5qJCm/AvDK1a+43B6c6fkhVrO6Or2TAf576Fq+73ULElvqB6ly0IRO642k9rSIn2cDGK5B2NMCF+N8sbLf0676OMlgjgmhn4jUlhueFtTJ+HPAodEDbGJwVw9UVAQq76v+za/BpMTfZOvl0er+OJwUaQVAKYjBQYYqoT38HMoMEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpblbO+gfinw3zm6IShT+z5eGfj6lv/b+pbNWzdgSCc=;
 b=FQNGWRuphEWTvZ+i6x8Ubz1zDxMWIN2EzLdLX+Xf6ptEYN+pw8PRHwMSU7gW24PiGOYZMKQzBLIefP4vqrSCZ5Ktox50w468JH2ggTapxpL4XA8MXbU0dMl4H5FHrbIpmJfeL6097CFkct17ZoJMRN5uEkBl8cQ/rGeF0ao66rs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB6984.namprd10.prod.outlook.com (2603:10b6:510:288::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.20; Mon, 30 Jan
 2023 19:26:37 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6064.021; Mon, 30 Jan 2023
 19:26:37 +0000
Date:   Mon, 30 Jan 2023 14:26:32 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Sanan Hasanov <sanan.hasanov@knights.ucf.edu>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "contact@pgazz.com" <contact@pgazz.com>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        Huang Ying <ying.huang@intel.com>
Subject: Re: kernel BUG in page_add_anon_rmap
Message-ID: <20230130192632.lk6w5fhi2nbm3lpz@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Sanan Hasanov <sanan.hasanov@knights.ucf.edu>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "contact@pgazz.com" <contact@pgazz.com>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        Huang Ying <ying.huang@intel.com>
References: <IA1PR07MB983017D2FBA174D2FF78CEB6ABCE9@IA1PR07MB9830.namprd07.prod.outlook.com>
 <Y9LNCouUvsUFCYkT@casper.infradead.org>
 <adc9152e-c547-12ec-3538-006500619896@redhat.com>
 <713c6242-be65-c212-b790-2b908627c1b4@google.com>
 <9d8fb9c-1b81-67cd-e55b-34517388e1ab@google.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9d8fb9c-1b81-67cd-e55b-34517388e1ab@google.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0081.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::14) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH0PR10MB6984:EE_
X-MS-Office365-Filtering-Correlation-Id: 394b88e3-2cec-42ba-f03c-08db02f7e7a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UQMmj+33/PJy47WV8bk4Ks77mGv7sOBLvmTnSLQGpCDuXm1zeAUnkOzS9X573k/BsLRlffxI2rnVHcti0vJ10eo4Wh0Vo2vIo0/px3aIY4MdRBfD5XTn+i+uSjqyCnXJlAH98vsC8txAv/rNGgr3/TZj/4DKtHeWfJKPIApvEuoohvJ2+nWCWqZpeRbu4gJ1iBJoYYuhAImFGLE4UWfguAH5Ow3bISBk/4jL1UPQg9Nd+5R2zvcWWrwIiIekq8puaFJ5xSu4HG9jMQIxTPBAgUuY4NpxHbKQrY+kmfYLm49SwTjqSt7Z/l4rOfioT7DkcbdrLje0HSo2ZDTDSIYsc5dF8y7Cmprg2CcpVO1WopPIMYabr1dVGkqKPfiaMDDEETENeti1OlwOUBZcOy75iFeAgEFGtA2nctutR6LCk2mjFGjzIAujOL6QJJD2WxcyqEIcdLZ8dvjGrHs4a+3MNG3lg2SCJE4Tj8ws3EH9pGTTPjX87OEGT3i/C+FBtYqtTMmDXPVxgNTWTwQrDBLZyehUrLAtJ8WiIAy+ityyt68yuTyyDxDQ4cVfxXk5+ey+YbctKRg/e4nwc5HVcOcBXO1Si76B5F3IORJgLV3+g9oritJZY5QlykCFInl2TLNKu9GjjC7Fr0xZ89ERUMGsQWiH3WoXOeMFFbHzVrPIGTQcb/XR/7almh03gf9+uNudP4nZmqycpaSAydttuqV1vgSR75Qk5+w/8pjgou5khzClcvIueTrPo/YXdT+/7/ILF/aBAQUeQfMmXF4tNngMrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(136003)(376002)(366004)(396003)(39860400002)(346002)(451199018)(54906003)(316002)(66946007)(83380400001)(5660300002)(2906002)(7416002)(8936002)(86362001)(33716001)(38100700002)(66556008)(66476007)(6916009)(8676002)(4326008)(41300700001)(478600001)(966005)(5930299012)(6486002)(9686003)(186003)(26005)(6512007)(53546011)(6506007)(6666004)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Ke9xLNqkVw1oq21lXETWe8FGsEf6Ehi1u6ldCfl1FKOekFWyacKhluuNau?=
 =?iso-8859-1?Q?3oD746hbpTNSaiYBcl2cnT8X6uLFqAuBJfhNzFtewU9qKwbcCYwIwp5xW3?=
 =?iso-8859-1?Q?JvGjuaayy4XvDqxlnwStYO9ZHPhj2K1JsfwQUL3zTWmJRU/6ClOkVK4gVb?=
 =?iso-8859-1?Q?3uVXc3ezQI8xRqefFLo3CwS6Rtg/ANA0EiAou5/h9wGjbZH8WTeKHx7CAp?=
 =?iso-8859-1?Q?hE6JH0QzAOHgpoLLyJXLOfC2uRrr2DWauoKeZyj1qgG3xBkVBLQLi9DwcX?=
 =?iso-8859-1?Q?LSGGrTC1IGAxL8Mga3sEGa3A/9fK+ass+hHPWo1TZ00vpk8quOSjvt9t7z?=
 =?iso-8859-1?Q?tKtVMPOovGiEU0gZ9rxW+Nx2OZg8MAO7D+kmzxX5cdHa+Tnfv/q5+/igm0?=
 =?iso-8859-1?Q?VfD45a6OKiJ8edRcWuOi0u8DbawMsT0ikKb4HmZdPQ01mHdxW1SJMqLGKE?=
 =?iso-8859-1?Q?Qgl2FkfxKSkPgytDXHjpBBD8FQNIaminMJPQ3bWaDr+0Va+JmZIBsODphj?=
 =?iso-8859-1?Q?zEk40cW9ABf2QhSVVShLZDN7fLIP/ZPgE2QnAh0uJXqQrinnexPbVq54qz?=
 =?iso-8859-1?Q?jMlFNFUGzoemTeug/7dWkWDHdTauDZ/i151KAr2Esn86RVC00utZADVVMw?=
 =?iso-8859-1?Q?pSSr6Of8B9DOMG0O+mKm7U44Peys9g4MzLF9X6yWhb2xawPA8sr+k/BYRU?=
 =?iso-8859-1?Q?uHfxbOoankneBWoizqE5yNxT6DmskeKtY5cnM9w0NqCdnyP9Dg5pFeBwYf?=
 =?iso-8859-1?Q?/bPXDDDYJyZ3eVNkwRd63GKmaoGOzviHm74D5+cnVGp+4eBh/5FJ0TbX5V?=
 =?iso-8859-1?Q?bNlCnDXg4E1e6wRBCeQT/o1D2LuXCaFR4gWwWc8BTC458ZF1bUT3JgNjgu?=
 =?iso-8859-1?Q?2xU+/9vCTtW0nAK+SVRnEmf6HUB29yfqNp1UNz03iX9ntuqSWD7fKBly+Z?=
 =?iso-8859-1?Q?6dZD+A6CrRwhQYF1JwsG2reZc8qkDLP2i632hTDbUgRnqVK0xn9pMHGpEM?=
 =?iso-8859-1?Q?COyAcMswW6dd1AD7EKC68V/Zz0S9xiQ/8kw9IzP2CUEnG7Xz/R94NkzfSo?=
 =?iso-8859-1?Q?CeZNL5/IjLdTi7ppFCpFucy2wlYlbdOn3WTKlR/vUZIA5IyXSIPGLPYMtS?=
 =?iso-8859-1?Q?Q/LNj7vxLm8EgFZqtljPfi2AxtYJgqerTpeYdH3cDrZY2+YiAIe37XgTyM?=
 =?iso-8859-1?Q?TN/PlJ4s8MpkeaMh0RB57apmaEUuHswDB5VvYkVl/ICR+pc1rTumZZTv5N?=
 =?iso-8859-1?Q?Jdo3ww/AWkTlnve5dZobCRl85oWwKLD544Bq6XwVdyFI01bsovFMd55kc1?=
 =?iso-8859-1?Q?SpCvMvXvslt13sYs9Q6tDo1xnlA2VkQvUaAZd2MqFI3eenYJ8eaB8pzUtw?=
 =?iso-8859-1?Q?qqPiUAKZjYJ80TThgt1gp5lBI+rsdE1kytpTp39CZnTXtMJWht/aunluQh?=
 =?iso-8859-1?Q?Rp5kE1RXYA9Y84Xro+G+ISDHNQDWfZMDp0KQzIsKjOWzUZgi1UDP7N++vg?=
 =?iso-8859-1?Q?HHqyeFRLDhtDI+wS9Nh6BjDAw7lnnANd4Sm99wovYudAEgCYWvcyR/sICw?=
 =?iso-8859-1?Q?i8TtXsaqxRfqSJgxn0DMOI5O9IzoWwCSWjkGy+8mEK4N4I4IBP5H8XvERD?=
 =?iso-8859-1?Q?xaGmJe3Ta6wFRi22mKf4QROWuMJVK5iAFQXNyK3cMBmNYo6DV6rgGv9Q?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?scgtvSIuIZ8kuTSXA8dotd0d5jGRd3mcSsxBXuA0oMLyT4Q/FuROPIM6Kh?=
 =?iso-8859-1?Q?NbkuAONuIa82lELtiaelF7vm8jFi9mVPKPL/xv3FN5jxIA1rMWj6DH+RKh?=
 =?iso-8859-1?Q?ze0ITtg0OKSeZsLM6/Z9sSIPg4IPTetWbN9FcLGHDya+05jgdgeuxwmj61?=
 =?iso-8859-1?Q?NWwe7r1s5b+zgMa55SdHfKPqfgqEell7rdqmPkHqIJQS4xrr94FC6EHko5?=
 =?iso-8859-1?Q?ZAn2c8nBMRFxuQYeYzxIiHgJ7p2J6KL1fPLrxDF/y+fswsT94/uvc0J1pP?=
 =?iso-8859-1?Q?lhSnm02K7zKchfrAxG1jKjGMkaoshJre0Oc46Skl5vwj19ymRcSnRheT8k?=
 =?iso-8859-1?Q?3KGk5krBLXJDo9Kv8+c4WduzKuzg5sSjur2KGSkzvHA1kFZy6ovsh4LO19?=
 =?iso-8859-1?Q?PHbEw9bcqjtMGyfDEJqjQxp4m1sqfos3qrEu64S67k9aclLuTq1ng0ptSM?=
 =?iso-8859-1?Q?WSMjEI1CSZseed/ou6ws0wTbKmf7QiXyNriY55JZF4zfiwNE3k+9xQk9tc?=
 =?iso-8859-1?Q?hNsHSuP7U+TEXog83+Re+E9uLREO7rk2YBx68Dyppg850olvYbHYt3gACW?=
 =?iso-8859-1?Q?aikBYND8q8g9qaGVmg2pFce3XKEGK75Xd6EA9LMaM1Q9GXgdDp4eerwk4t?=
 =?iso-8859-1?Q?7T9VLzpsYBqn1hDL9+YA+878XeYCrJr5kiXUGFpIXT3Z7GPxB1CXL238se?=
 =?iso-8859-1?Q?Y7bpUIj9vpF8+FLLDUB8rj2iHEh1xrPENwNS2aDldIIIB9Cv5ih0XJfkUk?=
 =?iso-8859-1?Q?Jz4r6yCkBAnRD8buokNazcyXP7U+rXGzip4MZ6HYNSatcHc90PqBTy+i3T?=
 =?iso-8859-1?Q?ER02Qa1+AW4KYIcJ94troaNc2A8pJBhjeugEI53/xNUPS7NLUITqofASG3?=
 =?iso-8859-1?Q?dSj9aZ/XJafbFkOXvgmluR5r+pHB81ZEKiC/m3lKrWrDYvTXRYqF4NJAQS?=
 =?iso-8859-1?Q?twOTnWuEBY57EQQg1HEEGbHz0fib4piwu60pQHwwlQ7hAFrXcdsoN6UGwn?=
 =?iso-8859-1?Q?FOOZr+ApItmq6jElsf2a/0O2HKHaZiQrmc7YD3pcjyfji9YfaGdzs0wm/Y?=
 =?iso-8859-1?Q?bZOIQqEfPpRMrW3zYSSjqDWbu96WgyHO5Lxqq4cHrzPYopbk9c0zbir/yi?=
 =?iso-8859-1?Q?jYz6M5bA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 394b88e3-2cec-42ba-f03c-08db02f7e7a0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 19:26:37.0568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L4Nyf+Ib915VMEzbNkUAt9uMfrhMBAihmCPnpYdLv+TJVowUHpifQiwC60rK6qSGrrTWa+Jk8Qft9jm+hstGpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6984
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_17,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 mlxlogscore=935 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301300182
X-Proofpoint-ORIG-GUID: PWoHMf5WTfSL7YuGgb5ABREsf9welU1B
X-Proofpoint-GUID: PWoHMf5WTfSL7YuGgb5ABREsf9welU1B
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Hugh Dickins <hughd@google.com> [230129 01:49]:
> On Fri, 27 Jan 2023, Hugh Dickins wrote:
> > On Fri, 27 Jan 2023, David Hildenbrand wrote:
> > > On 26.01.23 19:57, Matthew Wilcox wrote:
> > > > On Wed, Jan 25, 2023 at 11:59:16PM +0000, Sanan Hasanov wrote:
> > > >> Good day, dear maintainers,
> > > >>
> > > >> We found a bug using a modified kernel configuration file used by =
syzbot.
> > > >>
> > > >> We enhanced the coverage of the configuration file using our tool,
> > > >> klocalizer.
> > > >>
> > > >> Kernel Branch:=A06.2.0-rc5-next-20230124
> > > >> Kernel
> > > >> config:=A0https://drive.google.com/file/d/1MZSgIF4R9QfikEuF5siUIZV=
Pce-GiJQK/view?usp=3Dsharing
> > > >> Reproducer:=A0https://drive.google.com/file/d/1H5KWkT9VVMWTUVVgIaZ=
i6J-fmukRx-BM/view?usp=3Dsharing
> > > >>
> > > >> Thank you!
> > > >>
> > > >> Best regards,
> > > >> Sanan Hasanov
>=20
> This is a very interesting find: the thanks go to you.
>=20

...

> Upstream's fine; on next-20230127 (with David's repro) it bisects to
> 5ddaec50023e ("mm/mmap: remove __vma_adjust()").  I think I'd better
> hand on to Liam, rather than delay you by puzzling over it further myself=
.

Thanks Hugh!

...

> > > Indeed, the mapcount of the subpage is 2 instead of 1. The subpage is=
 only
> > > mapped into a single
> > > page table (no fork() or similar).
>=20
> Yes, that mapcount:2 is weird; and what's also weird is the index:0x20003=
:
> what is remove_migration_pte(), in an mbind(0x20002000,...), doing with
> index:0x20003?
>=20
> My guess is that the remove-__vma_adjust() commit is not properly updatin=
g
> vm_pgoff into non_vma in some case: so that when remove_migration_pte()
> looks for where to insert the new pte, it's off by one page.

That looks to be exactly correct.  I am setting the vm_pgoff to the
wrong value in case 8 (for lack of a better name).

>=20
> > >=20
> > > I created this reduced reproducer that triggers 100%:
>=20
> Very helpful, thank you.

Yes, thank you very much for find this bug and the reproducer.

...

Thanks,
Liam
