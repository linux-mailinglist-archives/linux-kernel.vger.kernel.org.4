Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9965F49D8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 21:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiJDTrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 15:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJDTrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 15:47:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104CF5A800
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 12:47:17 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294JK5UC029090;
        Tue, 4 Oct 2022 19:46:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : cc : references : from : subject : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=wHBTo+ambuPpT2lbGLdnXGa6zDb6J6Fzm8H0eKJTR/M=;
 b=vSq3NLWZkE/7orIbiydQkiK3hl7OlWZekkkurJHhn7vLpyMsFrXCoj8QuTZ+xSHQtXK5
 xSCHRkQ9vwcOY396Fekq61rhPRNtoOhEZ2edM5rFC9x/hbqYAYxlJXK3MHcUWRXV0gjN
 mR0LRmr7+rMlRTqb/SBf9fyUx1RbkOiQxs3azFYyfPoO9zQB84PKw+9nTuu8k1Bh2tTD
 Yc57wfkG5NHMdfXISpoIZAcNoOVjkB1VFpBHiEg/icJ6gySSUUTU5D2ndATzPOPgwi7P
 cQUlfEEUquAV0A8KiPT/NTO3AdCHx1uDLABwCwYN4XG7AnpKsZB9VUA055fda1KPFi9D FQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxbyn78ud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Oct 2022 19:46:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 294IQePV001021;
        Tue, 4 Oct 2022 19:46:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc04rp7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Oct 2022 19:46:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQrVdZAZSAri+Losi/0Pvw3GlqF/bI28fd4J1V3lg2eiGqWPba8h8L+Fdtecu4Lbrc+Q9yblmDdBuLyHM/bhyjO2J7SyeZiKmBerx4i/TtwFy5Ga0mdNGBZGiywaeHa2sX1B8Pom3i0QoAw3FxnQkTunzMI+THEMit6oG9Wug5SPBXngsyHJTrWX3hfLccoOWS+TAs+ZXTsmhO7ce0W8kyoMWeFm+jwr6Q97hw/e2ce9wl5UY6aiQ77/yeFyHN0Rrwi/w55pW46mbhO/0QXqMmeHHbu5vqHV9IhdUP1Cpc+nEmOxKK4NRFYTrkldVK0m6IGrAGrpMEit08VrpsT+og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHBTo+ambuPpT2lbGLdnXGa6zDb6J6Fzm8H0eKJTR/M=;
 b=DsBXvW1AYhUzSCARo6WRaDn1wIpHJj1KhKARrU7bRwFUXSOKPSXd2FPt0gq/AOsJaMCs/y/da6kCFK9AzSfLzNKUu8l4gIIRGpdIUasavnzPh1VNUhmjmHxuD/zst5nZDlpzxjmM3FlqhPcqH3hxPhukClH0HZz8FqW0IJWV+5r11XRCaDkM178okB0F1pyhG++aEezoEpDxFAnwTQ2fHIo+JRSUWRcqEJGB4ka2KLlOZFJzJjoOnoW53wx9D3N3wzOipEZQGOuZaI/IfGm4nx8bTGHSUKlIyY/WdhPfjmaPqyQ7zBflcmVoTPvHqFHcNyCqeAJUZJ2LXJTiTdQZrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHBTo+ambuPpT2lbGLdnXGa6zDb6J6Fzm8H0eKJTR/M=;
 b=g8ZCymw26mAl64tV4RATtcs8vS42rnObOkY54zPXaiZNP9L3BSOldl5vIyf9d5rj4IV6GeffCcGNPplb4F+7NrgOAMDUMAT2ZhA5LzAsiYxgJ8Zu7lnxG1dqtBkCq6bzii/rZXg7ClzV0rnZG+RIGXb6kES15VL38Ctelu6Np5c=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by CO1PR10MB4659.namprd10.prod.outlook.com (2603:10b6:303:6c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Tue, 4 Oct
 2022 19:46:41 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::2b18:d3d0:c806:401f]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::2b18:d3d0:c806:401f%9]) with mapi id 15.20.5676.030; Tue, 4 Oct 2022
 19:46:40 +0000
Message-ID: <25d4aa73-ee2c-9890-164a-89fddcbe133e@oracle.com>
Date:   Tue, 4 Oct 2022 15:46:36 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.1
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org
References: <20221004084335.2838-1-jgross@suse.com>
 <20221004084335.2838-2-jgross@suse.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH v2 1/3] xen/pv: allow pmu msr accesses to cause GP
In-Reply-To: <20221004084335.2838-2-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR06CA0035.namprd06.prod.outlook.com (2603:10b6:8:54::9)
 To BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5009:EE_|CO1PR10MB4659:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fcf1b1c-3b35-4fea-4548-08daa64127f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q8xJAOLRsM7R51NTF223+aaiSXZvPUDUyGnMy0DDa6q1smiCjVigSYNKtqGydMuKLBk6C/L1vnWgIBx5QySEWRC2tIFO/jN/JuNTLrUtibmLxx/LZdN53j24JJ9+hOXGLfAn5qFVsECFaJKojdtVanlD7Ta/Wr8URybbDoRpOV9ZmiyfJb748/Ji/3Ocwvo3nQJQexAzM2ZrxxxhIRS/G0eCMnUru110tAGzy17siGoAIebOnE9hWx1FVtZ9/9EWNA2Wz20xsUk3qtHDXPJhQDCBnbCJ49yUNBePJsU++/Rdx/ZYGblzjoDuRxIPpmvbZvFhgaDHXR5nC3tgT71T17Q/b49R/oY8TkpvAoVO/UvqzinuiVAzu+SQ1xGAGBEI3Az+RRNUxe7tQMtZrT2TB62IuAX71R4U1kcaN90DSR1aPqzSh9D5U1/pM2PDUz6z+UNDm3HKAi7F9BgLKtpQJ7+cS8CET8kYE8KibuCXW7nCF1ecljd0pmPRBTSrx7Nk/8Zpx/8U/0Frfdx4wHKcge5dgtyVNo516m6xhYrr0VKN5oPLNnboKnRYysX7Vs+R5C7iPiwV5AQuvV6NaY2HRrB2bwEKCSPZkOysPHSJ7lLqatAIs076IMuFZuJrvUh43gNXnRgP65DNrZZXPBxF6dNbVCe82U+GniPp+oPGZkBvZ1KVF89p+fbH7PusWNtfFo47joYCrmjiJ/d4LXae2WMiKHpxoGIk9Stz4RFs+6smmFvf3ScvKkrwEWPo6mjhP5c0gdS4rSkD4Tb8VWFHCzGyFVw4TYdBdU+93y02Xw4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(39860400002)(136003)(376002)(451199015)(26005)(44832011)(2616005)(186003)(2906002)(41300700001)(6512007)(4326008)(6666004)(36756003)(8936002)(6506007)(53546011)(5660300002)(8676002)(66476007)(66946007)(66556008)(38100700002)(4744005)(31696002)(86362001)(478600001)(6486002)(31686004)(316002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N25IaSt4cU5IY3U3N1liUDdpbjZ0SGVaWlN6RkY0dTVtcGlXNTBvdEVqK2VZ?=
 =?utf-8?B?alBRNC9LZ3NnZmErdE1xMUtwenIwT2syVi9Qdm9RTDk5L3dzZUFGbFlGMEtj?=
 =?utf-8?B?bGtLQ0p5djJvRGpwdENyb3M0ZmNXdUhaeDcwV0QzRGNtdHZCL0FnL0ZhRHpm?=
 =?utf-8?B?SUJsSmdGVmtKRjVYWHFYZVh4RFZaRjV0bzRRR21JY2ZjYzZnUTRoNjFVUlFh?=
 =?utf-8?B?N0ppaWd6eFFkRXhjdGxlS3pudTMwcitiYS9kemdqREppa1MxVW5EOTFkcHdk?=
 =?utf-8?B?ZWcvTXA5YnIwRnhpNXorTDBwWFJhUXR2MnJlSmpTcFluR2ZyTXgzTWFWZTBO?=
 =?utf-8?B?OG44clp1M3plTVg5a3k1aGpCMVI1QVVOWCtyeWdmMld0cEZvbEJKWmdQN1V4?=
 =?utf-8?B?eGdnSGlpdTVFT2s1VWZudGFJV2JCUE9JbVM2STl0U29RcGdUWmNYOU9xWE5P?=
 =?utf-8?B?VUd1dDQvVFNTWDNTcUxEVmhzTkNteVV5UkZCeUFGYVBUbTVsRjc3bkdjTno2?=
 =?utf-8?B?VS9UaGdYd3JiNEpwY3BWNFlJN0dtM3FMYkhDK1p4U2tsdjE3WHpEQzdtUWhj?=
 =?utf-8?B?bWg1MWd4ajdibTVWWjF4ZWhURmUza0N2M0czTkQvVE1DMklMeUpKOXRrbUh0?=
 =?utf-8?B?UUJJY1E3Rzc0OC9odEM4d0xCRWJhWmJjb3k3bkk0ZGxzcFp4Y3RzRU1HUDRp?=
 =?utf-8?B?T1pLSmxpdnlWeTc2ZGh3Z2lkMzN2cmRSS2NXdVZZdzJNUU9mTnhMcXBTdDZo?=
 =?utf-8?B?T2RvcWg3Z3NVSldWZ2lMU0hBWnFITWJtYmx2ZmJoaTdDa2xHbHVkUlN1cWp6?=
 =?utf-8?B?SFlrMjVIanN6SUZ5bVVKZlVMSjB6MVZXNWZyZnBwd2N3c2xLZWlkOXp6aWM3?=
 =?utf-8?B?N0NaT0ZuR0Uzblg3QU42YXhCd1ZLYWJMVjBoZ3FDZ3MySmJSdHBuaXpKTFpV?=
 =?utf-8?B?L2Y3UE5sYWVodTc1aGRZNFNudTNMTWhRZVdHNlBDZ0w4MDFGOU1pUlQ1bE1E?=
 =?utf-8?B?SHB1bE9YdHFwZEFEelhLU3VmTGVCNHdrZWZDWjFUQXVBekFaU3RoUFVucjFm?=
 =?utf-8?B?VnNXZjk4S1BJc2pyUll5VDJ3TnpUWXI2RjJycnpQMjR1S3JVL256YXlZYnJ6?=
 =?utf-8?B?WHZscGp3MUJwaThSVUFiZ0E2MUZvdGo1a0FVV29KVWtDS2NJazEvWGluYWV4?=
 =?utf-8?B?aHhWWWIzUzB3Sjh3QzBtQmRRbmpPRWd2emx2YXFnQkhLTU10Q1dzeGJHTVMx?=
 =?utf-8?B?a0tHaFFjMXl3MFIwem1qTlg2YkpyQWNHbUIxOGNzZjllcTZCYVhkVVFESmYr?=
 =?utf-8?B?SThGbHBuVUlGMVZwRGw5ZDFoY0xibUtaNXY3eXNLdGlVeWlrbU5PU1dQNC9L?=
 =?utf-8?B?VkhBNmR3L0lVc2VFWUpMcnF0NkRNU0p6MUZBWUVIOWtCNk5JNjd6UC9EOFE0?=
 =?utf-8?B?UVBwdWFhVFJWQkI1OXRUd3RLS2crN2xOZ2pkTG43bEwybEJlMk5NZThCK2NK?=
 =?utf-8?B?RjdZWXI4M0pCWG02eWY4M3lYSEtPU0NBVXJPdm9EQUxzaUREMTA4SWZKUG1j?=
 =?utf-8?B?NGYzVDhlMXpobTVDd2xSTDJiVTNGQU5kVDhySStlSlRJVmZzYmE4MEZnamE5?=
 =?utf-8?B?eWJPcG1GVHNKM2lnbFN1elM0RGdVdk91RDlhZGh2MHpVZHhYZm5KMnM0MHpt?=
 =?utf-8?B?QWJDNDg1TjZQbFVnbTI1M1hwVjJoMUVlVHdYTzVlNGtYbGdXU2ZJdmtJUkRy?=
 =?utf-8?B?STZMV25nc1FqdWU3NGNDK3d4OTVkNlNsTXJpREZTSnVyWjRJWHJzYmhOS0Zr?=
 =?utf-8?B?RFBjKzBndThRelhXVVdFNVMxaGpCd0dMeWV0akYrSkRxSU5DaTBqakc1RFdF?=
 =?utf-8?B?ejRRYzNnSWF1bm03bjh2MS9uL3p4VHgyTU1KU1I2MjdTRjRDQnRNeG9IWGRQ?=
 =?utf-8?B?VVFhS1hqUzB4b3lzenAwZ1p1ZHFiS21ocVIrMit3dXdSSUw0WGhZMU5YOU1D?=
 =?utf-8?B?VTA4ZWlxM0wvUEhCSE92ajg2UXdkcWlZTWJUVDZXbnFnSUtRWFpjbnduNThB?=
 =?utf-8?B?aVpScXFWNUFuRlRIdFBTQkpJeGJZRjlnRStVeFE3UzFCRGI5NDRUbmlERDF6?=
 =?utf-8?B?M3A0M1AxckNPN3N1VExhYjlubzhJN0FPT2UyODYwcjlnc1liSHIyek9adzNY?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?d2xyNjdxRFhsc291b0xOMzdPRDJUcCtQU1dtc2kvM3dSTHFweEpENEsvcDZM?=
 =?utf-8?B?bnl2WGNDd0h0dlVRMnUxSDV2eWRnL0t3RUlsRVczSUpib3hWeEdpRE1mN1dF?=
 =?utf-8?B?QUM5QVdyM29ITExhYWRNQVhpSjdIVTVMeEVTN01rRCtkVVNUNm5keHExN1p6?=
 =?utf-8?B?cnJuNFhLWDNOcDZialhxTTBRcXJjTDJqQ0l5L0MyaVFQQmpPK05tQjRRMytZ?=
 =?utf-8?B?UkhvYTIvbDhNaUNGN2Q4bkt5d1pLYjNLdFdvUXQ4ZFhxL2VLRWpBSkM1VGlN?=
 =?utf-8?B?VHZQNXZSbFhuRzl2Z3hwU2ZhZDh3eG9wanJzOC92L1dYTkpvZXlla0FnSGlU?=
 =?utf-8?B?VG01M2NHNFBZV2kyRTZPaDFXSnlWVGdaTHhsWm1RNzRoME80bjBpSXo5TmhF?=
 =?utf-8?B?aU00elV4L1ZzelpRT1pnQkFaNWhHUU14aUFBQ0ZCRmt6WUNzVU9JODZPb01l?=
 =?utf-8?B?RGRNSjc1cEhBMEROcmlBaUhCMTRET0ZqOWZmZFplajUyOTVnTmFWK1oxL25x?=
 =?utf-8?B?dHlDRmxkQUhCaUY4ZWUxeVJ5bG5BNU94VkJpYUwxSE0xdkEvTEVLc1lTeHN6?=
 =?utf-8?B?SnBDZk14Sk5TNXZYUlRIZFJieHhaYjIwMHoySk5oUFRBd0xpcE14ZVBsNnFm?=
 =?utf-8?B?UkFtQ1l5bUY2MFE0WU5SU0FMSVhiSGpkV3p1Wm5Ld1N6cVM4bFE3TkNtcURH?=
 =?utf-8?B?RnVMMCtMMW01dngzV3lqTGZvVWVZWXhDR3o2ZGJyTzZnUFRXbDYzeUZqT3RX?=
 =?utf-8?B?QmgvNW9aQjZYZVhmMXdRNTNRNklMdGF0R0hnNHExZFFBdWIvcitYSklxbjYw?=
 =?utf-8?B?eFhiSU5iU1l4VGpvMXRScDJzOUZJdHM2ai9kRmlMWUtodldYNncvN1FXOGpZ?=
 =?utf-8?B?N0JMS1JJeXFkQmhpRTFxdTBSSm5VSGtiQ1IvQ2FuclF1S3VWNUZpYWlKb3hu?=
 =?utf-8?B?M0krWVFicEtFMUU5WDczaEpueExsOWpOQlZrTmpYMExidWx5YXpOSjc3a0tw?=
 =?utf-8?B?Y3NBNklNLzN2QXdVK2R4dEVGankvdmF2ZmdWVVlaRmRiQnhlNmdFOGRqVW4z?=
 =?utf-8?B?SHRBbGtkcVQ4dE41WXhWcEpoNmVaWmZhQ2JickZxUXdFMVlDMk1wdjlVNWVp?=
 =?utf-8?B?b3M1UytTTWpGKzNBcFB1NGpORmRQdy8xTjVzeUZrZjNxWHRucFltczlYNGRN?=
 =?utf-8?B?QjBPSmxiUjBGbmtoa2hVR0IrVzQ2ajAyNisraHY5NXdsWkVGUitMS2U4a0Ux?=
 =?utf-8?B?ZUs3TFFWYWhJN1U4UWhkYlloRGFDcDl3azdGMHJxeEFFU3d5UDE2TXNzYlJ2?=
 =?utf-8?B?aS90YVZDSkMwdG1CS1lYZmcydVUxUnI5cEYrNytEQkdNRGFSNWRIVC9PektS?=
 =?utf-8?B?a1o1L3pPWms4OFE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fcf1b1c-3b35-4fea-4548-08daa64127f7
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 19:46:40.1041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vrxHo5LWr0J8kXXf4b6MTf3qMV29lYEmMsMRhwfNKtv0txmvmIEqOjGVZ1ZMulDpusEoiJcFQWFEPxpx6dqGtdbHfXoDii++ncul4kN1GbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4659
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_09,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210040128
X-Proofpoint-GUID: AXT1R_4cVe_UAdcfACBE2fsro7jX7t37
X-Proofpoint-ORIG-GUID: AXT1R_4cVe_UAdcfACBE2fsro7jX7t37
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/4/22 4:43 AM, Juergen Gross wrote:
>   
>   bool pmu_msr_read(unsigned int msr, uint64_t *val, int *err)
>   {
> -	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
> -		if (is_amd_pmu_msr(msr)) {
> -			if (!xen_amd_pmu_emulate(msr, val, 1))
> -				*val = native_read_msr_safe(msr, err);
> -			return true;
> -		}
> -	} else {
> -		int type, index;
> +	int type, index;
> +	bool emulated;
>   
> -		if (is_intel_pmu_msr(msr, &type, &index)) {
> -			if (!xen_intel_pmu_emulate(msr, val, type, index, 1))
> -				*val = native_read_msr_safe(msr, err);
> -			return true;
> -		}
> +	if (is_amd_pmu_msr(msr))
> +		emulated = xen_amd_pmu_emulate(msr, val, 1);
> +	else if (is_intel_pmu_msr(msr, &type, &index))
> +		emulated = xen_intel_pmu_emulate(msr, val, type, index, 1);
> +	else
> +		return false;
> +
> +	if (!emulated) {


You can factor this out even further I think by moving if/elseif/esle into a separate routine and then have 'if (!xen_emulate_pmu_msr(msr, val, 1))' (and pass zero from pmu_msr_write())


-boris



