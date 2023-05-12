Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55EC701279
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 01:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240711AbjELXaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 19:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239441AbjELXaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 19:30:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D025CA
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:30:08 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CIn4Hc032429;
        Fri, 12 May 2023 23:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=Ff+iGZfXA+4sXbIOJ4p9W0rcu3wZ5qrt+Aygs5BDJaA=;
 b=lPjAwu4PoZ/nFsziM1X3OPmPahT85ojfBMYrQHr2BdHeijxoB97WLhcAegcjjhMSKR5Z
 DmoWTqRsn2q8Z2Hy+RtsuYK2sT1ZnIdwvA4vPG99lmVsuPXo/dBN86vWkyKsym1JnZxG
 CV7pbeMeyK7363WjsPo/DQchmBW/PJwo8hDlzmIB9KDmcBWaqVanJqytuGKPz0A9br+n
 /QIR4aXiZvjhZEkQ3VHey+NujyfqIToLhLU+gxDqrBh3N26SwEN4bHYzrWQmtPYVSPrR
 p2N440MQPC9uEF6gfEVHTyOdkh5ttgH9IL83GFZU11h90uiMht4iUZURlLMkzZI0+/dC GQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf777ckjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 23:29:54 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CM20Yt030617;
        Fri, 12 May 2023 23:29:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf81k7gfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 23:29:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/P/t6aVk8R73+IRYxd7Z+ElBIgLN/FBsg8dBho4MLmo8OemPqe2dMqK4+BdmYT6WHlBpvz4zoKQuV0bvwBCjNzJ2NbuasMFdwvCsxE3kshc3yjg1tC05cJFNk6pKoDyc6zTrcGVZmeheQT5juyuJE0cV1gXh/WQYmtZUvvNo+sZHtN/hxL6fW6RFZQZAPQ6s7hYOtbuC2TKS4Smd9tMzrWEj3xa7Fp0Y2sVjbHXoxj13HlicM2CjMGsrfXbKsj9zbCMroyjKcISeZ1bLbmgZADOsSJyzGgEA1rG7mnjvZABw1GC6PhuAxA5tv0lvEijphHmytpoPV/OZCSThxXMOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ff+iGZfXA+4sXbIOJ4p9W0rcu3wZ5qrt+Aygs5BDJaA=;
 b=F/r0lrFlNe8mTQKBI+KbvJYHER/NOqYSP+BAQH0jhDzsBMyT53sXVIqCk/NAApT6tR3KQsklUppuDdIZkgJE4k4DGBCTZJcmz4tquDKVOHNzf/ixViWUxkVYQmSVbYcA0YQU/tlmiGtY5Gj+zqb6bStOP6mzc119gN/I+3IGgK9KiXVm4sGCh79aQFDesUcH3tSqoYZie/fCFaBXV4Ay/v+fOAZxm88mCmHXCBav6GLqAuoI0fcc8O6DEqPceXA4ntGlJzrw4nyr38o9Sh9+11YpJEuqRZDueJpphICJYkLctyEte1H7b6zRPbUt/siIWh0XcyvtIJ2gJPY85BUxAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ff+iGZfXA+4sXbIOJ4p9W0rcu3wZ5qrt+Aygs5BDJaA=;
 b=w2MtiUaRZwFzwCW4Bkle1wkrCXIP7ti71BnfXF7oPVZOITMnLnQGglMMatgdiq9dM/cVoY8JwzLbPZf22f7Xl0yU5FdPlfQzNmstLNzlm3axFGlPIJgTP8norWxg1gmZehlvxnnj/CJ8Vi7gu++xSVsTsrTOO8eB5fJPBC39hJo=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by IA1PR10MB7334.namprd10.prod.outlook.com (2603:10b6:208:3fc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.23; Fri, 12 May
 2023 23:29:50 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb%3]) with mapi id 15.20.6387.024; Fri, 12 May 2023
 23:29:50 +0000
Date:   Fri, 12 May 2023 16:29:47 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Junxiao Chang <junxiao.chang@intel.com>, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, mhocko@suse.com,
        jmarchan@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, muchun.song@linux.dev
Subject: Re: [PATCH] mm: fix hugetlb page unmap count balance issue
Message-ID: <20230512232947.GA3927@monkey>
References: <20230512072036.1027784-1-junxiao.chang@intel.com>
 <CADrL8HV25JyeaT=peaR7NWhUiaBz8LzpyFosYZ3_0ACt+twU6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADrL8HV25JyeaT=peaR7NWhUiaBz8LzpyFosYZ3_0ACt+twU6w@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0152.namprd04.prod.outlook.com
 (2603:10b6:303:85::7) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|IA1PR10MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: 954b6c42-9e97-490b-2330-08db5340c820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MmdsXf9nDsOS/vERN5JgDk2FrkQlUCw+XV5Kyr9vNUXwykLcHq2BX+7kto2k/xIM69c6/t5hVSu1dZe/HXmC15kepW2hTXCmWPt6hkRWRdwVFoAcZjJb5r91mV47l+RondHMeCxr+PfTTYpUh6JhqF4Wy9CG1khEV3PrN2yZl7q/+3DoJX1WCwW1vKm3NifcDYANLaqqiRTY2vmZLxi9AN8oBA79YdWT/rVJ5HxVACDU8oEO31ua3DYY39tW/Pdw4/BUCirUBIRE3dS2QGi5HeWQfbUCuAsehfH+qi4wl9Bq54P1ybs+mlSwunT8D6Zcogy4kgE8lY+Wh/21KPuMo2bIMfz4sNVPfxdQNBB3xPpM5ErAEpq73EaG2qt1PBvNZb+glIN9nduOGW+wleKXDXj20OFkBhtj+aV1IESQXYPMbSoIKLFv9ChLMl8oVaNhjd9x+OZJ94T0b/s4wW3MBlQnEq2Ge31f1SrWVfogx4QpQFmiLMMT6MiRPTni1ImWuQEvGhlDPPggFrTBjH4pv9pas9mXe7vixeD2JgmO68o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199021)(38100700002)(33656002)(33716001)(86362001)(5660300002)(44832011)(966005)(8936002)(8676002)(1076003)(53546011)(26005)(6506007)(186003)(9686003)(6512007)(2906002)(66556008)(66946007)(66476007)(478600001)(6916009)(4326008)(41300700001)(6666004)(316002)(4744005)(6486002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFYzdVBYZkhISzRDRnhFc0N4MFI0TW5RSVB2dm1MWlVBN1ZaOEhmdVNHZG4v?=
 =?utf-8?B?cW4rR0l6TEVMSHpSMFJHempUSFRjSmlBS1pzS1lzOUVBQUl2RTU3R0ZaZW9W?=
 =?utf-8?B?cTQ3K3hTY3FHNForZmhEUGFrQ1E1TnhMUDBZbXUzRDVGK3psQSs3NTMvUDNl?=
 =?utf-8?B?WFgvMW03M04zK0pnbHI3QUtEZjJYZGlrS1NJY3I0N25rZW9UYkxnUzM1Yk96?=
 =?utf-8?B?RHRNZU40MFFLY1BlOVdzMzFKbEFOOVQwQU50aXB1WlYvZ0pMZVNsT2lWSXUz?=
 =?utf-8?B?T3Z2bTQ4czlRbXhRdEZFV3RyTFBlNFRoYzQ1OW9GdWZHZ0RJdmo4UE9JcTAx?=
 =?utf-8?B?QmpMaDkzUW5JQnp4UWI4dTJtNUVXVUVoSGNaL0hRRllFaG5YSjFlZ1dIMnZU?=
 =?utf-8?B?cXdBR3c2UDkxa0hsMGQzc2lEUk1rUmZQSFRrZG0yR0Exc3BISnZHQXR0ZTlJ?=
 =?utf-8?B?RmlrbVlqb3BhcG1vNGpHRWE4aG1zblRWUEdhbktDRE85WXBpRlg5bkxsZ0hN?=
 =?utf-8?B?bTN2amxqK3RmaGZ5NHduS2szUUpENi9PMEprM1FubW01bE5nRnBQV1hBeVJl?=
 =?utf-8?B?MHpZQkhxdjNGa1pUQnRmUWFMU2VXZm5kWVFPMlRic2U3bkM2alFQL3lvQkFa?=
 =?utf-8?B?eVpqdmNWcC9Gd0FWcWUxbXpRdGxpTXQ3WnA4RGZzWDBmSjJVY2c4V1ZuTkdj?=
 =?utf-8?B?ZkMvbkNTZmd0R2k1cnNmMktxMnRCaVdLOFZkVDdKRGdvbTNzNUN0OGhIRTd5?=
 =?utf-8?B?bVplUlYzSExPNmFMcnBKMC9HMlBORnBPTW5IcUNCYUpoMHhaS0c5TlRLTCtq?=
 =?utf-8?B?NGdsVEhNTHR3QjRpcEJyUW96RkVGdzRjL25QY0VNMTFwRXUzR3R1NldabnBJ?=
 =?utf-8?B?NCs1TFNtajhCdkVKTWZHZkhsZkZVdDhNMmV0UWN1cnAxRzhLdGxYaGJLZjky?=
 =?utf-8?B?V1E0OEdGSGtjdVRjZnJIdWNWMFM3bU12SXFNVjdpVkJaeEcrdzV5eXFzaGV2?=
 =?utf-8?B?Rm4zbVpBUlkyUkVzbGVHWUF0ZTlEaXZHNjBUOG10TW9PYU1BUnpVZmJPL0Fj?=
 =?utf-8?B?T0RuV21MOXpxVjFUaHFadVkwY2pTTHVYU01OVEZ6Vlp1Y29xQ0IxT3NKdmt4?=
 =?utf-8?B?K3BjaFBHaTl4V3ZPSkMzWndEZkVzTG1McEVYV1Y0MXJiNmlESkNnWFBQOXhk?=
 =?utf-8?B?L3dpOG82UmNILzBzeDlBK0lEaitVK3hqOEg2MTVzdVRkUnQ4UXpoMzVJTkYr?=
 =?utf-8?B?SUxsS1lMTXB5VXp6WUhNVkVnZFF3K3MvdGc0MVZ5Tm9QZ2kyUGdOM1F1eW9R?=
 =?utf-8?B?U0kyeFBWbEF1anRpaFlSeVdHaFBDN0p0WU0rOGRvUDBLd0ZNUXgyaDNxUWNp?=
 =?utf-8?B?K1dZaTl4a2JJUXd3N3NKUlBQTzl1TGliRTA5ell0U1daRjBlNVZXV0pXSFVu?=
 =?utf-8?B?eCsrcEdyYmpLbTF3Y0RGNWRtMTBhTm1YMjZWOXFPdjdHT1RoR05SMWx6RUNN?=
 =?utf-8?B?Yy91TXBvUjBjZWZvc0ovdkdheDBBcEdwRHk2c2NPODdOTnJSUjVsd2lOUStl?=
 =?utf-8?B?TmdEZFZ5MEhTSFNQakZFRlFtSFpURVBNbWczU1pSWGM3NXo1azEvQ1NOV0JD?=
 =?utf-8?B?UUJkbjNEWnQ0NmIyTE5RbHdXV3d4eTNrRWFzWW9ncWJHWG9ZVi9waHkwTVc3?=
 =?utf-8?B?UjQzTHczWUJoSkwzSXRZcXptbnJTcFhBRjBPSmdzdUF4K1pLWGcva0g3Qm9J?=
 =?utf-8?B?VG1mbW8yb0hHT3lUbzArUzZxaVFJMUp5djBqYnhIcnFic0pGMkFpSzRzOXhu?=
 =?utf-8?B?VWVLRHBub0FmaFl1TVhyeGE1dndlL0dMU3BjVVF6MTRJSk1YUEpqbGE1TTF1?=
 =?utf-8?B?cFpvS3BWaEJ5R245VU5vZ3NoWEVCV25PYlVBY05GbnlxWmpjQTByVTBLQWhl?=
 =?utf-8?B?dUpoRFpPcUNNUStWUHByR2pSaHFSR3Q4Sys3bDVaUDFFa2dTNU1sTmN4Y0JK?=
 =?utf-8?B?cDUrWkpRME5aQzVNWkNOVUp5N3hNaUFmMlYvN1pTcU94akF2T1pINm8wYWor?=
 =?utf-8?B?dVVlVnV3bE5EcGI4R0k0cGNpbEFWcGJ1eU9ISnFGdmUvYnpoSm1GWnpjRzlm?=
 =?utf-8?Q?0WinR1hcfY0BPIGHZDPJNoWgX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?S1BUbzFkU1hQdnBXVlUvcHo1U2NvK2tUZGJPdjQ4Uys0N2cxcWJFcHdia2xw?=
 =?utf-8?B?bGVlSk4zbVVxQWt6ZG1LY2NSUzJ4M2h4b2Q1bURoRFNRdXlNMUtJWEJPTFlZ?=
 =?utf-8?B?TUJnQTZPU1QrMGk0NlZyc2dRNDRoeExkOExHWldRRTJWVUI0MUFMdnpnY0JM?=
 =?utf-8?B?SXRoRE44algzUlY3VmFhVHA2K0ZaZWdLd2FJNWNoaG93YnVROXBEN21hQVFk?=
 =?utf-8?B?RS9ldHV2RkR5cFkxYWRseVIrc2ZrK1JndTNOL1NodFNyMXVXN0U5UDJURGMy?=
 =?utf-8?B?QVI0YURvb3NFTU9XVHNZZHVvTDVBZ1JmV3NwS3VORUJCdlZrN3h1amRvK2xR?=
 =?utf-8?B?L3VmNEhDcmtnV1g5L3ZwTHViZ2lwZmFBNWxySFpYN2ZFbXZxSU1FK0JBM1Bk?=
 =?utf-8?B?SkYwcVJ6V3NVL2FaNnVUWUtYQk1oUHdscDZPWHpoMG1SUU1BVzJUcmt6Z0JC?=
 =?utf-8?B?WEcvN1c1eFB6TnVBaUgycUd4KzNtZnRma05vTFNYcFV3SVpubFpwcGk5VU9a?=
 =?utf-8?B?b1Z6ekIxMXJOYTV3bGo5T0gwNVZGdVgyYnBHbnVwMExaWHNkYllscDhrbTd5?=
 =?utf-8?B?QjFXK0ErR1FYOFBaK0FNVUZRYWlGeit6V2lFaWRFQXlCZ1djaDRNckJkYWpS?=
 =?utf-8?B?WFNEczlVUCt0Rm1GQ3RXSTdUcklNNGJRSDRoTC9mV2dKSDE0ZGF6c3huRmZw?=
 =?utf-8?B?S0Z5eXpXdFZhaXZnMEg2WTBVQ0NybWZETzhUUU9uMFJkR3NCWDU2SVl5enlx?=
 =?utf-8?B?anBCclFZOE9TMlRCL3k3OTZzSlZjY2xsK2FLWlpOY3IyNlpvbFRPLzJwb1JE?=
 =?utf-8?B?NFlxLzBlME9mdFoxQmZXQkp2Y0o3eUV1bmJVZk9ubGdPY1pqUGVYTE9VMmFS?=
 =?utf-8?B?eGxaeExpdjczeWRxZnRHKzdKdjY4czM3UjAxWDNZTWFTMi9GQUNJcXlhSjRG?=
 =?utf-8?B?cXQrK3N1ZnVGTk94VHZ2NHZiNDB0dTZwcHpoR2JveUEyNlZXcHNISmlWZi9Z?=
 =?utf-8?B?cmpTQXhBcmxncnF6Q2p3SnlNdE5Sc2FZL2dRMmVmOTBMUXE3Tm4yVkkvL3NE?=
 =?utf-8?B?cGNMVkNqd2hpNG5SVXR5K3pGWkUvL1hYaEtxSlMvWnFQM0cyenlvT1ZGSnYx?=
 =?utf-8?B?SWNJTXRCR0JtYW1BSkJveXdwQ2I2TWV4OE1xUzZIVWh3ZCtpTHRSaW8wcHRE?=
 =?utf-8?B?VENaRmw0c1pEWEUyWms0emY3d3doM0U4dFN2NkoxNmJzZVdsTmZuRS9QR1Fs?=
 =?utf-8?B?c1NxUitiTCtIQTVzOEtDUUowcllrZlp1UEg2TzBuZWJ1aEtadUExaUw4V2p1?=
 =?utf-8?B?VFRtSi9MUXAvTFZTRVovbDM1YnR3LzRpQm5kelFxOUdGbHVIaDRzZnVPTDVk?=
 =?utf-8?B?dnArcWNIRFM0V3c9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 954b6c42-9e97-490b-2330-08db5340c820
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 23:29:50.5807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nPw9DeIiXHFujCyMLmBJsGvNWahqYbUSm39BlY2xq0O+noReo1FssLmwbZkndZdUGi6cHCibIfRzCe6+LCm6tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7334
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_14,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305120198
X-Proofpoint-GUID: qDbcy8DYK5fy6UMImKznwmsqMMBXGqCe
X-Proofpoint-ORIG-GUID: qDbcy8DYK5fy6UMImKznwmsqMMBXGqCe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/23 14:26, James Houghton wrote:
> On Fri, May 12, 2023 at 12:20 AM Junxiao Chang <junxiao.chang@intel.com> wrote:
> 
> This alone doesn't fix mapcounting for PTE-mapped HugeTLB pages. You
> need something like [1]. I can resend it if that's what we should be
> doing, but this mapcounting scheme doesn't work when the page structs
> have been freed.
> 
> It seems like it was a mistake to include support for hugetlb memfds in udmabuf.

IIUC, it was added with commit 16c243e99d33 udmabuf: Add support for mapping
hugepages (v4).  Looks like it was never sent to linux-mm?  That is unfortunate
as hugetlb vmemmap freeing went in at about the same time.  And, as you have
noted udmabuf will not work if hugetlb vmemmap freeing is enabled.

Sigh!

Trying to think of a way forward.
-- 
Mike Kravetz

> 
> [1]: https://lore.kernel.org/linux-mm/20230306230004.1387007-2-jthoughton@google.com/
> 
> - James
