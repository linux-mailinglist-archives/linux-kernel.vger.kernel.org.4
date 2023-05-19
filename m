Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07EE70A346
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 01:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjESXY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 19:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjESXYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 19:24:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741091B7
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 16:24:53 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JNOeB4012867;
        Fri, 19 May 2023 23:24:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ZcTDtIrtYhjydlrqmYLqcgI4Bz2wjFjjkYBMnUsotAg=;
 b=Y9cMCmThMTb7TbZq2hluQFrEZDQut4xXQcRhp9XUjRYDvRLhhJ8BoAFv0PNfA/dUZbRE
 udyMYhlte/M/6nHQLzNMvYNlnWxl8po3/Xl/j2Lxfz+7mBm6xAQmEyfwmj+BD/wdWCq5
 fuSfN+mtoJ5GV1UBOAiJPra6pjsFObM+7ziMBCesFZoHDiu2epWucJkvlK9Hj2vuOw12
 8bGz/b6kXSNcqL5kS6i/VNHYBPnr0EV87htVfqrudAnei22uTY3VMxmnU4J/M5yeUAdf
 JrSyQM58FUNT6dSmTavdRkGkBXNdxmdicPd/59qRscJbTeqOcyWsR55M+Tu2LocqpEZe yA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2kduphx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 23:24:39 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34JKYxUx032193;
        Fri, 19 May 2023 23:24:39 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10eqftn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 23:24:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=miJZfav371i/tocm/duQgZh0RVUlsLBFf3vCr6iJjKjO8W76R+77A4sYwkq0Wq9BAvsyJRibRutGvfNz/Mj+DyPgT8UHibEQJnQ5zSTA0zdxdrNQUVntuHtCxrVLT3drL1Y5x9ashLBGds9ciumqhF6pM0A+8zEqsbs+p+kkL1tXZHJpCexRVtNWkvSWk2j9702XxU/qBi1GxrysfLKyLCPeyNAZsDDlVb15ir0jk+f0K1b9/aAbvvyXpsHoLYe6JgnJS3MseaEToP+RMkKB+TljWdvGSmF77KSdesr23RIiHtJ1h3INE4ogDm3LzelpO0tXAzc4TNZj7PlsY3txVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcTDtIrtYhjydlrqmYLqcgI4Bz2wjFjjkYBMnUsotAg=;
 b=Q68yPLrxjnZByR+mDVnbXrhdHkiiBJEMKyNTt1UI8L5N+Z3SbWqMzYPj69uRvo+5Bb8E5TeNhdy/7W090ETpo+10WJIHO0F2cbJz9qdCIQeO8+GRKpXjacM5P+DalSeHGKuu0Yk/4aG/B63ALitcyBPnoef14tYcC2zFEbiK+ogPZiCNJBYS2CT68fvQfZVaxdVpw9X4LnowccuEJgNoCA5X5TGLJDJxTaULOfm7NvabrHl7GAiBYSSFaiuEm8eUHFU88I5QFTfGLoG0wRSmT6nwViEVsEPKzE+EzSEh93guPy92Bvp5IegC2OgQwWQg3JHa9F+6v76V7qp41yPHbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcTDtIrtYhjydlrqmYLqcgI4Bz2wjFjjkYBMnUsotAg=;
 b=BLl0NdYRxpV+6IdPFSE7vUNr8CmQUZP031vLjbfGMuElk10aAOF4Okfp5+Fv5oSs46vCFKwdgURQ44Kkccb0tJDeZto8yFq70PjXxRE0Atj+qqsqMRKT5Zj1QqwY2dhutnBz3j2dwJixBtOtxGSNY54Mpvgocioqh3AtuvsS+PY=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CH0PR10MB4988.namprd10.prod.outlook.com (2603:10b6:610:c8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 23:24:37 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 23:24:37 +0000
Message-ID: <04f2853d-3bdb-8893-91c8-074893310d1d@oracle.com>
Date:   Fri, 19 May 2023 18:24:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   Mike Christie <michael.christie@oracle.com>
Subject: Re: [RFC PATCH 1/8] signal: Dequeue SIGKILL even if
 SIGNAL_GROUP_EXIT/group_exec_task is set
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, linux@leemhuis.info,
        nicolas.dichtel@6wind.com, axboe@kernel.dk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
References: <20230518000920.191583-1-michael.christie@oracle.com>
 <20230518000920.191583-2-michael.christie@oracle.com>
 <87ednei9is.fsf@email.froward.int.ebiederm.org>
 <ab7d07ba-5dc3-95c0-aa7c-c2575d03f429@oracle.com>
 <20230518162508.GB20779@redhat.com>
 <05236dee-59b7-f394-db3d-cbb4d4163ce8@oracle.com>
 <20230518170359.GC20779@redhat.com>
 <875y8ph4tj.fsf@email.froward.int.ebiederm.org>
 <677200bd-4cd7-e0a5-eab0-46ee29128281@oracle.com>
 <874jo9c5x3.fsf@email.froward.int.ebiederm.org>
Content-Language: en-US
In-Reply-To: <874jo9c5x3.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR11CA0058.namprd11.prod.outlook.com
 (2603:10b6:5:14c::35) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CH0PR10MB4988:EE_
X-MS-Office365-Filtering-Correlation-Id: 34d057fd-eb3e-4fe2-5325-08db58c0361b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FrzA0keSGcMbSErh/FgGyUM5Jd5pjqwPCu/1smyxmo2qv5yu8496IGEoBUJqf1eQbdTdQ9mpTZbWpnpgRiUj33BBY257Tn6teUqZ+sxgE9h2AVZuG7b17amp4rzTabJYjRoLqAWByOCclU8KbtkPbuoITXy95rVO5h0rh7tvnF909OdTY8pHoKhhsBMT+ZeI4zMUzYETjbOJjyODt1OjCv+LXvXW29QuW2e4Uv9zR72aQx11kHhdHUxUPrNapTdAc44XqWXYUSDtaImkFWRdKkF3GSn3gm3zq23ABru6svyRdjqGR0q2lMZ+czTQLP9gVcRX3pWV1ZslLJdALC2RAvOtnUUqltndT/9+RBQZzy3yUO21GuAJpjxMVu9rGZHT5+ELMDzzNNYmtEtLpoJpAetYZxfOk1FG6Q0eDRFcNO04g/ryS/CN4KUjSyTTnb4UoEM8GyF176GJ5aByGMtCOynY6+F9HiM1zv3YdYdx6+Ext7+AWwK6lmKbvUzwSFqqUzDSyg163+6FwpycKqBZrqTJoGOfDktgIPbLqsKmZjJWDkNfarMRRA8rGXjvaowQlt3gY6oyal8ME0IbgQVfVHDCXS7x0yZ8LgzUzAeqAdBBd4A49/AovyDtaCnKs7U3vYukJfUXs4idrS1FDWUgJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199021)(31696002)(86362001)(53546011)(2906002)(6512007)(6506007)(66946007)(6916009)(186003)(26005)(66476007)(66556008)(478600001)(36756003)(6486002)(6666004)(38100700002)(2616005)(41300700001)(31686004)(8676002)(5660300002)(7416002)(8936002)(83380400001)(4326008)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDlneGdqSWxsR0RCeWV2NjBpV3pZcEQxVjVoaEt5NVFNcHFVTTQwYmt4amhU?=
 =?utf-8?B?bTlXTHc4SEZMS0wyeEI1M3k0bUs3ZWRMZE5YVStaZUlsN1NuRzgyVjNIUVJu?=
 =?utf-8?B?eG9VTmpLdjVMbWp5SHYvWUhHMHpaZE45YStzTmp2c2J5UnZCME9CajErTzlp?=
 =?utf-8?B?SVNncHNNM2pmM1U2SU15L0dEYll2OHdNc0RWNTM0T3N4TjZ0bFE5MEhWeTho?=
 =?utf-8?B?ZS9Cc1gwN1pZbGtGTUxVU0FNald4SWxDdFViWmsyT0FycFl0U3pUQzlXUlhu?=
 =?utf-8?B?TERuZmJNcVc2WWxKT3JrVkd3a1hwOG1oOUpmM3k5K0hGTWhuWitPb3p1QzZR?=
 =?utf-8?B?a1RJNTFrMjFqM1JiTGEvWGl2UGhFa1h3WjR4em9Nc05kbUl5VFVLQVJScmk0?=
 =?utf-8?B?dDFzUDdKVnBXdWQrZHNYTEJMY3lFTDR5Uk5Bdi9CNkhZbEt1dzQ2VUcxZTVq?=
 =?utf-8?B?TmtwSnB3M3NobFNyY2xmTzNxRjBESzJNcjNKS3Q2YjlCbCtKVVFRM3FmQ2xa?=
 =?utf-8?B?ZlExUkViSU0xSTd5VWljby9jVDNDRW1JZktYZGkxQTBBaG0vek5weHRoREpY?=
 =?utf-8?B?cFBxK2FoakpTQ25xbEZEZUtzeFFyOUFVN1E0VnhFcDI4N3FFcVNSZTZvRHIy?=
 =?utf-8?B?K1Jwa3FMeHpKc0ZkeDd2QmZtM0FDaGlKOEVPT3JDM1BtS0x0YWJMUTNFeXN5?=
 =?utf-8?B?dWhzQmRnYWp2cUNoU0pRRWZJWEpNdTBFUDJGSm9jeG4zeWZQWWliQStOVzRj?=
 =?utf-8?B?K2t4RlpWS3BDR0hJckRwWEdZZXF2YlRsMk5pUERmRDhPdkZFUVlEUCt2K3cz?=
 =?utf-8?B?VTVnSVZtRHZTMWdkQ0NsWUJvblFaTFNFbGZhdkdoVU1QVlE2NDFaQ2tDdUVw?=
 =?utf-8?B?VnlUcnBZcTJkN1JmZ08vVXNOcXhtUFZFckJ2UEdOVlVmay93bzREbEVMeHpR?=
 =?utf-8?B?QWxCQzFDN1o5RHZUczViMEZLaWROS2FnSFpHUUNPVy90QW5ta2l0MDRrUzFo?=
 =?utf-8?B?bWtyR1U3Z0tkNEM1bE5JVGkxWGpwbnFvSWJIOGJlV1MzdXlmVjBFUnpXMEFD?=
 =?utf-8?B?NFY0T0I4QWlnUUpyTzFxQU5CTlZqcFdLbmgwRkRMOW9zTmY2aFVLSW1ZV1Zi?=
 =?utf-8?B?UG9idHhCcVVyOGI5TUk2Wi9XVFlPQllHS3phdjhtVDFrZjltaG8rYlhub0pn?=
 =?utf-8?B?Q1cxRDNCTUFNVE5XUDVxK3Fnd2xVWVFBUGNYUlhJUjQxMk9kNDBRd3BhZG5p?=
 =?utf-8?B?T0hyVXdoSDR2TlNaeUxGQ1NDYVoyR0Rnb1RrWG5FZGpiaytHUzQ3Q3dCaldH?=
 =?utf-8?B?OXFRam5NbnN2WDhSMDNGT1JsTHo1R0lCcUdkS1ByOUJoc2lnN3dEQ1RmRHZy?=
 =?utf-8?B?aWl5TGs0b0RWb01WYXFHbDNETFgrOVhMVzJYbk1NaG1tU0d1cmh5eDhLVzdz?=
 =?utf-8?B?bjZyMTYxWnAvRXRIcXhrMHpDL3ZVWjJtQ0JDbXhjVDUxbkJhbVZiWXVJMEVF?=
 =?utf-8?B?eXhtaDlNY0hTTktaNENNa09Hc0Y3WnQwcHdRVnpTNlk1R08yUkFSVDBOcXhX?=
 =?utf-8?B?bms5Y3krS2tDNVl5Mk4zSkJoR0lZVVdrZzhnVXdEdmNZL3gzczVWUWxleDhK?=
 =?utf-8?B?ci9IVHlmYXJkbnZzSEdCd0ZJNW1CS3I5dlZGd0d4S1hWWW42VFFIRUJLOUg4?=
 =?utf-8?B?eHRYeWR0N1VDeVV4Y0xLWDRtdnBtYW1pSlR1ZW9ycnFtdHh4d1UxTHBZeHVy?=
 =?utf-8?B?Y1l4aHZHclR2VlFFUEUyT28wRytCbDZFRXZycWZoUmtKei9HWlZETnQ0UCty?=
 =?utf-8?B?NGI4Z2VmZW1aVU45MVBFV0RvZlNXeGZ4R3hpOElTeGRoY1FGSDcxSUdITHA0?=
 =?utf-8?B?OEl1U21uNlBXRE5kMHRPSi9TUVIwekYrK0RFM0MxWEtzQjVreGpzVXU1L29k?=
 =?utf-8?B?WTNFeU1XOGlFVGFmYmJHcEdsVUM3c0RhdVRpcGRjdVZhUXJ0TVpFN1B2VHB1?=
 =?utf-8?B?dzVHb3VXaklkUXAwWUw5aEpCNzk4U0hBMHMrTi9GQkN4U1ZDNzkzWWR0RWlu?=
 =?utf-8?B?Ui9KcGtMallKT0l0OGVJcllDOU40ZWs2VTZOSVdVWDFZcmV1TWphcmFNcm9m?=
 =?utf-8?B?TWN6U2RJeVpNTEJNYUdQZkVSTXVMSUFZdlJHd09LWXNPVFZDTTJ3MWUrYjVQ?=
 =?utf-8?B?bGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?d1lvR2dpZCtldHp4MVRFNkxaM3NYaENMa0FMd1FVYjh1UnZpb3hNbjFPaHRm?=
 =?utf-8?B?dHgyOGdkL0V0NUFOQnJIV2tFRytqSFRTMVl3NlZ0VDJ6NzhzVXg0eHRGU2F5?=
 =?utf-8?B?dHgzRUZMY3Rlc291ZVlEZ0x5Y2ZHY21EcUl6aWo0OEc1cVd1OUcxdHhORVdG?=
 =?utf-8?B?ZmRBMWtldDk1WE84Um5LWjdlRVVRNGJ6eTdsWE9qN1g3b0txblBsaTJVOE5w?=
 =?utf-8?B?YmNxRjc2NCtwZVRCM0I3QWZRT041K3VRY3A0T2lxcU5XaHRBQkJLbm5qYWVa?=
 =?utf-8?B?TjJualRlV3ZZTEpJaURTaWV3RmdWSTY5K3o1NjhaaEVmM25ZMVJpWDIrYUtK?=
 =?utf-8?B?VnJxR3VwQTdOeWlHOVdYVW11Z0ZSR01OVkx1QTZxYVVQVkwxRkVxMllJcDdu?=
 =?utf-8?B?Q2xhdHJIcjMvamkzMHplNXhNNGpLelZtdmZpNForcTl4NlQ5akVrL3ZnM2NU?=
 =?utf-8?B?QnVpNFVIaU9Sb2h5UWg2bU03U2N5aXg1OG5tdGppWWF2UjY5NzdFZlpwK3hN?=
 =?utf-8?B?dEhvTlBDakpRY0lPVXBWU0IvK1k3eEMvaVdKMTl1R25NYWxGOXo0aTNNSDJJ?=
 =?utf-8?B?UmtPKzBpVnE1S2hMU2Rja2hrQmxpcURzU0VmS1p5YkhnNWxSQytaMEZNTG1p?=
 =?utf-8?B?T3FVbWc4aVl0dzNnN1pTK2tPYWZFb3Y2R0lRSEZXZUF6eGNwUWNsOU55bXo4?=
 =?utf-8?B?andqUmJ6Q3ZWUmkrRCs4bXdscmR4blp1ZEc4ODF3QUZrdExJWjZ5Rk5WWWJq?=
 =?utf-8?B?MFJwNi9XRVEwOG85UUFXZ3Buc2RkQnpWRWsrOVRWck5mK2ZpZUlKOVdWRW1F?=
 =?utf-8?B?K2ZHUmN4RndRRXdpdFhTSHFRUGFNeWJVU3NnMUp6ZzducEtYRkFRUlpMajRB?=
 =?utf-8?B?Zm50aUdMeUFuMEV5VU5HdTNYaGtnbVhvSDEvcm1UM0xIZlZ5SjhHUnpmTTNp?=
 =?utf-8?B?SkZQZmZxZUJ4NkNlR0ptZkpGNHJZYmRJUDVidEN5cDM1ZzJSMmxCUkRYV2FV?=
 =?utf-8?B?ZStzekhsVFFJeXBicUNrY29oUjhVd2lQeG93WTlEVllETFl1ME9ISHNXck1B?=
 =?utf-8?B?SWJVbVVZUFVlQTJtYWoxdTgvTmRKYTUyL1lFNzFodkVaNm0wcDdPeUdpdW9y?=
 =?utf-8?B?QjZ0VlV3cGc3L1M5eTFPL2ZNM212ZmNydW1Oa1oybnIzT0hENkxuOHVLdUY3?=
 =?utf-8?B?ck1FQ0ZjTmwxMGw0VDZDR3lXd1p4eElLUnIyeWw2c21KeEtJZ3lFOU1ydGpv?=
 =?utf-8?B?V3ViWkNwdDRzQml1cGZLYmhlQVZKRGZBRXlhQ3pGd3FNYlFQdDlQUmplRHVW?=
 =?utf-8?B?dzh3TE9NR0NUMm9jSlFReXdLUndNNTdWNk0ybW1HSkZXbGRNbzdORFdiNUhv?=
 =?utf-8?B?L3dYeDRoVkV2ZkR6VkZ1VUtnRjdKK1d2TUJ4OWZiVU9YcTZtWUxzVnB6ejJt?=
 =?utf-8?Q?zwqoNyvS?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d057fd-eb3e-4fe2-5325-08db58c0361b
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 23:24:37.0517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5oRl+1Qu4fQS8H1afPLItTPKe8RQFtjQGw4LwusaRDSfQI9jNX1tBgen1W6fHzSfpu8ZXaoLwDUZAfnYVaTCBdiL5dlSJkvdZsQsfsrsvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4988
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_16,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190201
X-Proofpoint-GUID: hFF5-vPjA_8jZOjcPAdPd-Bv1yiOd8aE
X-Proofpoint-ORIG-GUID: hFF5-vPjA_8jZOjcPAdPd-Bv1yiOd8aE
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/23 11:16 PM, Eric W. Biederman wrote:
> Mike Christie <michael.christie@oracle.com> writes:
> 
>> On 5/18/23 1:28 PM, Eric W. Biederman wrote:
>>> Still the big issue seems to be the way get_signal is connected into
>>> these threads so that it keeps getting called.  Calling get_signal after
>>> a fatal signal has been returned happens nowhere else and even if we fix
>>> it today it is likely to lead to bugs in the future because whoever is
>>> testing and updating the code is unlikely they have a vhost test case
>>> the care about.
>>>
>>> diff --git a/kernel/signal.c b/kernel/signal.c
>>> index 8f6330f0e9ca..4d54718cad36 100644
>>> --- a/kernel/signal.c
>>> +++ b/kernel/signal.c
>>> @@ -181,7 +181,9 @@ void recalc_sigpending_and_wake(struct task_struct *t)
>>>  
>>>  void recalc_sigpending(void)
>>>  {
>>> -       if (!recalc_sigpending_tsk(current) && !freezing(current))
>>> +       if ((!recalc_sigpending_tsk(current) && !freezing(current)) ||
>>> +           ((current->signal->flags & SIGNAL_GROUP_EXIT) &&
>>> +                   !__fatal_signal_pending(current)))
>>>                 clear_thread_flag(TIF_SIGPENDING);
>>>  
>>>  }
>>> @@ -1043,6 +1045,13 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
>>>                  * This signal will be fatal to the whole group.
>>>                  */
>>>                 if (!sig_kernel_coredump(sig)) {
>>> +                       /*
>>> +                        * The signal is being short circuit delivered
>>> +                        * don't it pending.
>>> +                        */
>>> +                       if (type != PIDTYPE_PID) {
>>> +                               sigdelset(&t->signal->shared_pending,  sig);
>>> +
>>>                         /*
>>>                          * Start a group exit and wake everybody up.
>>>                          * This way we don't have other threads
>>>
>>
>> If I change up your patch so the last part is moved down a bit to when we set t
>> like this:
>>
>> diff --git a/kernel/signal.c b/kernel/signal.c
>> index 0ac48c96ab04..c976a80650db 100644
>> --- a/kernel/signal.c
>> +++ b/kernel/signal.c
>> @@ -181,9 +181,10 @@ void recalc_sigpending_and_wake(struct task_struct *t)
>>  
>>  void recalc_sigpending(void)
>>  {
>> -	if (!recalc_sigpending_tsk(current) && !freezing(current))
>> +	if ((!recalc_sigpending_tsk(current) && !freezing(current)) ||
>> +	    ((current->signal->flags & SIGNAL_GROUP_EXIT) &&
>> +	     !__fatal_signal_pending(current)))
>>  		clear_thread_flag(TIF_SIGPENDING);
>> -
> Can we get rid of this suggestion to recalc_sigpending.  The more I look
> at it the more I am convinced it is not safe.  In particular I believe
> it is incompatible with dump_interrupted() in fs/coredump.c


With your clear_thread_flag call in vhost_worker suggestion I don't need
the above chunk.


> 
> The code in fs/coredump.c is the closest code we have to what you are
> trying to do with vhost_worker after the session is killed.  It also
> struggles with TIF_SIGPENDING getting set. 
>>  }
>>  EXPORT_SYMBOL(recalc_sigpending);
>>  
>> @@ -1053,6 +1054,17 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
>>  			signal->group_exit_code = sig;
>>  			signal->group_stop_count = 0;
>>  			t = p;
>> +			/*
>> +			 * The signal is being short circuit delivered
>> +			 * don't it pending.
>> +			 */
>> +			if (type != PIDTYPE_PID) {
>> +				struct sigpending *pending;
>> +
>> +				pending = &t->signal->shared_pending;
>> +				sigdelset(&pending->signal, sig);
>> +			}
>> +
>>  			do {
>>  				task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
>>  				sigaddset(&t->pending.signal, SIGKILL);
>>
>>
>> Then get_signal() works like how Oleg mentioned it should earlier.
> 
> I am puzzled it makes a difference as t->signal and p->signal should
> point to the same thing, and in fact the code would more clearly read
> sigdelset(&signal->shared_pending, sig);


Yeah either should work. The original patch had used t before it was
set so my patch just moved it down to after we set it. I just used signal
like you wrote and it works fine.


> 
> But all of that seems minor.
> 
>> For vhost I just need the code below which is just Linus's patch plus a call
>> to get_signal() in vhost_worker() and the PF_IO_WORKER->PF_USER_WORKER change.
>>
>> Note that when we get SIGKILL, the vhost file_operations->release function is called via
>>
>>             do_exit -> exit_files -> put_files_struct -> close_files
>>
>> and so the vhost release function starts to flush IO and stop the worker/vhost
>> task. In vhost_worker() then we just handle those last completions for already
>> running IO. When  the vhost release function detects they are done it does
>> vhost_task   _stop() and vhost_worker() returns and then vhost_task_fn() does do_exit().
>> So we don't return immediately when get_signal() returns non-zero.
>>
>> So it works, but it sounds like you don't like vhost relying on the behavior,
>> and it's non standard to use get_signal() like we are. So I'm not sure how we
>> want to proceed.
> 
> Let me clarify my concern.
> 
> Your code modifies get_signal as:
>  		/*
> -		 * PF_IO_WORKER threads will catch and exit on fatal signals
> +		 * PF_USER_WORKER threads will catch and exit on fatal signals
>  		 * themselves. They have cleanup that must be performed, so
>  		 * we cannot call do_exit() on their behalf.
>  		 */
> -		if (current->flags & PF_IO_WORKER)
> +		if (current->flags & PF_USER_WORKER)
>  			goto out;
>  		/*
>  		 * Death signals, no core dump.
>  		 */
>  		do_group_exit(ksig->info.si_signo);
>  		/* NOTREACHED */
> 
> Which means by modifying get_signal you are logically deleting the
> do_group_exit from get_signal.  As far as that goes that is a perfectly
> reasonable change.  The problem is you wind up calling get_signal again
> after that.  That does not make sense.
> 
> I would suggest doing something like:

I see. I've run some tests today and what you suggested for vhost_worker
and your signal change and it works for SIGKILL/STOP/CONT and freeze.

> 
> What is the diff below?  It does not appear to a revert diff.

It was just the most simple patch that was needed with your signal changes
(and the PF_IO_WORKER -> PF_USER_WORKER signal change) to fix the 2
regressions reported. I wanted to give the vhost devs an idea of what was
needed with your signal changes.

Let me do some more testing over the weekend and I'll post a RFC with your
signal change and the minimal changes needed to vhost to handle the 2
regressions that were reported. The vhost developers can get a better idea
of what needs to be done and they can better decide what they want to do to
proceed.
