Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFC2713DF1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 21:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjE1TaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 15:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjE1TaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 15:30:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3032DBB
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 12:30:17 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34SIqFPG021189;
        Sun, 28 May 2023 19:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=G6LnNtzvhi5xPJQPJycdggHX6y0yw14j+Iy4UN2lU0c=;
 b=iH5vV+fu30sSvP6B3sX1I9qXly9X25OS46XBdUWoS1c/xB0nzf9CKevSxxC6jjA1iyr4
 OjckeInBKw2orFM8yEgONZIcB1cuzAv13+vo9InPReOQvSBgkV/0A518u+4WBeYpwt6Z
 3cVOz33cpoQ3Rod2YnZmbetiFRDJLG6Prph45XmZMOF5YsrXe+c0zmDojSRMq/qXbdA+
 Lzh7IYCUt5ULHYmLJjH4dXkFg8b89fxfJRo6Ae30K6SO5TIq9CSXMOCtREZHlDd+a61O
 bXNueIDRN+7ippHMBzBpHPx6c1FKTTHdLNifjz73cBo4Kav5so5uTpF21kLuRYyQAHiz Tg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvck200kx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 28 May 2023 19:29:56 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34SFE4tm030230;
        Sun, 28 May 2023 19:29:55 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a2mvma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 28 May 2023 19:29:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cH59CDq28srRebrSnGK8kl8I1pvRECBUQ0dd3r/aFk2JeQsLg1EqYoLJ5ha7DkcqZ0QazWXawdr9vOZTWmUk3YZu9vd6PuASUIBQf2tvyaQ+E7KSm5IzZJ+RisdIPWtXniar5bx0NICnZUWF1vH3OhFDVPqA/DAy+vMSO6kG04jxkvKUHGt2y4kAbH+4koChUcfj6XMmXXzwniHVqBQL53hf63dsEUvr4sI9GtjtrVCKAzBeAHC9zlyhNyPkOMRUSQzvbl11D8z9Xe7XA7ocBCnV1yi/j7nnw8DWCd+l8hpMmS/8ERPajEznQn6VpJ84W1kMhqXR8RUpRZUM1/fleg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6LnNtzvhi5xPJQPJycdggHX6y0yw14j+Iy4UN2lU0c=;
 b=SmQl4LclGj2EtkfwIUfOzVeLCsF+0tMIGhAtL1Fn5uuObXtHYM4aZtxhr5RV6hmeIckRM15YWsZ7FX7xxnenooGlVRhnfEGZ43jR/6XWYZv7F4FZe1Ci47rGMvL2Dus5Ec42DKIHiOeW4gq32Ec7HkIlPSJjFjslraTl0qb8kziOmov50soY5wMmkExIo9M0wjQzU3m+aZXZCUcxpiXO2dDKQ4pSbp6NlYcpNw2bOJgwgvI4b5Ts3eWCQ+6jC8F4dlrjpq+lbcILXGUfW1fzbGLWicchkOXUl8YDr4lu4CNleu+htKyWJkTkZEy8cZhuhiOt2WLpgaRP1xM+4fGaNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6LnNtzvhi5xPJQPJycdggHX6y0yw14j+Iy4UN2lU0c=;
 b=axfh79VoJK+jxHOZLcno50yD6AjPrcj3kVKDxN3VFZhLUuW+xN/IeUFfWH64r6A1o9uOfQ2sp5CKX7+qjiEt8iXPhbBitNqEqjdAfHt8XCn8kkzNA8T0h6elamlk4NB+kXv/HjoqgG/miEX2bQX7c/xadzjljLIk5DZjJ6uEnCQ=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Sun, 28 May
 2023 19:29:53 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6433.020; Sun, 28 May 2023
 19:29:52 +0000
Message-ID: <7b0be276-28ff-1011-8faf-0cba618369a4@oracle.com>
Date:   Sun, 28 May 2023 14:29:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, linux@leemhuis.info,
        nicolas.dichtel@6wind.com, axboe@kernel.dk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
References: <20230522025124.5863-1-michael.christie@oracle.com>
 <20230522025124.5863-4-michael.christie@oracle.com>
 <20230522123029.GA22159@redhat.com>
 <cfca7764-d210-6df9-e182-2c093101c6cf@oracle.com>
 <20230522174757.GC22159@redhat.com> <20230523121506.GA6562@redhat.com>
 <c6e9a5db-798f-fa40-5ae2-a41f2d8ebab5@oracle.com>
 <87a5xpkzau.fsf@email.froward.int.ebiederm.org>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <87a5xpkzau.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0043.namprd13.prod.outlook.com
 (2603:10b6:610:b2::18) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|BLAPR10MB5267:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b210597-7df0-424b-778a-08db5fb1e8d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YzVipGgkXNmjvY3iRKMGXRYuK+ZOjF3E/ke0hb3RHV3AU59uccQGnKujz+I8SoyrRA3YEBYhU6gdVh4rMBJZCcPMCw8gM1bOj7ak6fU4xh4U/HXbdy09lI8rKoi8zEO6bR8hllWyHPlxmjJXZFVYnXL9jhHQGjf9CZaDISpeNygkAwzHlJrVo+8bvnp52+7SG/IdNajVVerdxQRjdov3StMfkYy4HOkU0soGH9DxY8b5BA+Z6GeMQQ1Xyk7EeN0RyR1LpClt18CLbSPTzCos6t3vfxe6Rr0mEqARTkSeVRDRaz1vbR80nUhwKCzDwi3BxxJptpBkeligEecDS3Qxs0EaSYkIneyPactM8lg4Em/kTB9Q3jpkqzLTdZ0UfiXYaW5kC/C+4Q2BwkXLV6lZbu3Td99xx1cpCVMvI7/iES5zmsloVBmW4pEl94WAryAYzZSjkx3PQi5t4VqzbUU8JIafYo9CxWFV+jNH9ECwEMnCZbYR+azs/IoClSm7eMXkqdEjH2sDJ1lhcdgbIm5Ih9BVa/IxnZ4Hgs+5P8icE0J91MxrZase/c0Pd5PjCZUpiRN0va/RHGIMYnixAEIPqnGLGTl7rT4sgNwwMGk9v4W1ESRX5Aohwi1FCHh5ugucYorsQOHZe6wd6iwfvCKuCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199021)(2906002)(4744005)(186003)(6506007)(6512007)(26005)(31686004)(53546011)(5660300002)(478600001)(8936002)(8676002)(2616005)(38100700002)(31696002)(6486002)(41300700001)(86362001)(316002)(66946007)(7416002)(36756003)(66476007)(66556008)(4326008)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2N5YWE0algwUGhyVEswOVFyWmZlN090bmZPVEovOEZST2RuejlUNTBtVDNv?=
 =?utf-8?B?Z1hBRlU0SHdPeVJCSzIySWFLUjJCM1FMeFVaWnAwTzcwQXllVFMzdmJTOWZG?=
 =?utf-8?B?MjhnTzdONFJscDUvay9sSFBUVms5WDFTT3hjckdCdFc1WXdIZi9seTNwY1pk?=
 =?utf-8?B?R0dhSEgyeGhnVXJTU0Z2dk1ScXBJOExyT1E2RjJMbTlCakJMK2U0N3paV3hJ?=
 =?utf-8?B?eUhUS2k0UjdWUmpESUh1THB4azB4aFgzR3ozTnJ3SHhkand1Z1NJRE1seWdJ?=
 =?utf-8?B?VSszZ0NKQ2FuaWswWXAyeGlkRWxENStaRnNZWkEyS09sMG52NWI1T2FPMnl6?=
 =?utf-8?B?dmlNQmk1U0c4WDZ2cGkvVk5iQlgvaVc1WXc2akZqRU83K3NjcmQwYjBWL2hz?=
 =?utf-8?B?TGMxbDNDdDh3eDJtSVVGSGIzN2lITmRoaUN3NHpqRkNJSjlLTUxlNEU3Rmds?=
 =?utf-8?B?SXJ0QlBRalhQK2E3NzJZQmo2ZWlxWVVoRUJFOW1kMnExYllrZ1VHMmxmdnVk?=
 =?utf-8?B?eEIzaEMxUmtPaVJoR2lmT2oxYjBuejRGeWxrUW4zMHB5bHdlT2ZHeGFnTWU4?=
 =?utf-8?B?R3p3ZTRyK25hZG56Tk1TVGZzcFFZZ1prbWpVcW1saDJCeE1HRGFIQmpvYlRp?=
 =?utf-8?B?Yjc2M2xpek9RdWdoT3FIa0E4NDRFSnNGbGZydm5YV1Fta0d4WTliZ3IzYnhC?=
 =?utf-8?B?LzVyeWhwK2czZk1tWEZTK2NSK0ZYYTg3ZDNEdnQxQXhJV2V1OGsrSTBRbkhT?=
 =?utf-8?B?YXpQV3l1bDJPb3FSMUtzQ3pPRVBGTG83c1pRaHlyazBHMHN4dnpndkZTNjkx?=
 =?utf-8?B?UFJDUHJLa1UwaUl2QWdyZjd4cGo0bWZEWW1aa2FCSWVmRmwxa2tHNHdJYW9N?=
 =?utf-8?B?WDRjdFh0QXJaSHRZa3JEeUNmZlRVQzFkWUVoRXZHMWdnSk04dkkrdnRFUlJB?=
 =?utf-8?B?TExicE9ISWdrYVZlRDVjM3JkU1kxT01oZHo3Zm9EYTdodk96a05JRDFWTXQ5?=
 =?utf-8?B?TFJqemZsVHpLL1oybVUwYklRbktqWjlLUk8rTTJydHZiRmxFbEVuQVlja1BW?=
 =?utf-8?B?ajVhM0s2dzI3SDYxcnc5ZHgyRjdDZUNYVU5BUEJhTFlHd2liblhoWWlnVDVX?=
 =?utf-8?B?L3JIcDdZbUcwMnNjV2hwNGh1NVJxUmpScDRTbTMwcS9hV3B5VlA4cWNwU2wy?=
 =?utf-8?B?YWVzQmtXaWlia3JaZ0QwaVNDdjF2UmJ5MUgvR3pEZWhKelo5aHJhYlRzMW9R?=
 =?utf-8?B?YllSRUwxMStDZEJqMDdIMThFc0tWdXI1QnRQWk9hNVgrUEx4Vk5CR3ZFOUxa?=
 =?utf-8?B?eHRidjV0RGRyUkZTREVZenp5cHlQbVFWd2Q0QnRmRWRlN3JjS1VnbndGWnpJ?=
 =?utf-8?B?RWNBR3htNW5xdlpVblo0WWtXMXdaNFljUGhSUWd2eG5UMTBVUDdiV2JReFFZ?=
 =?utf-8?B?MC92Q0drUHFXQlFHcmFRSUtsN3g0cDdJVG1tUmdLNE9BWWk5ZmxtM21qWWk0?=
 =?utf-8?B?aWttdTB5YjI0VGlPNithOEZxcml3aDVhNFZrcVhiUWZQQXpnWC9Id2o0SDgy?=
 =?utf-8?B?S3R1RHVwTXRrVXd6R1NsMWFseURMZHlyQzZaSjV3NnVvbUZKZ0R6UlBQZXc3?=
 =?utf-8?B?cVhCUGl0SjNVby9YUU9hVGpCS3F4WUxJUml2aW1uQ0h3bU1BTDJDMFlpVHFq?=
 =?utf-8?B?OFQ5OWpjdnd3QU40MGhWMVE4V1RXTm82bDBZRHk1RjN5SlpwOXR2bFlwcENv?=
 =?utf-8?B?MWFkNUhxNU5wUTcyUTdUVzhMTmRqaHlPWjlMTlVnZU9TcTkyc0tISnhUblRa?=
 =?utf-8?B?M01GUnpwaVNlU1pPV2hFdXhXZTM3UnRWOG9YTktnTlFLSVhob1pXTGZnMXAv?=
 =?utf-8?B?dWRNZ1lOWFVzc1V5UzZtd0VPVVp0Wkt5cnF4N1dVNHJpL1ltTzZJTHJDYXZW?=
 =?utf-8?B?U04yTjkzYzNDY1k5c2ZPcFN0S3FjQ1AxYzN3dGVVT2lLaVNObzRDcWtkSDVs?=
 =?utf-8?B?M2xiMm13OVFScHIrSGRaeDJsKytsSHNrMWRDNFBIK0RPNEU0REFvUnhDd3Er?=
 =?utf-8?B?c1V0blVIWFY3eXJoSEVOdllxcmtNK0NRMXRzdytZenF0cC9lcGlseXZ0VmZH?=
 =?utf-8?B?blRGYTYyWUtYQVJSemFkMmhxclBPYzJtaVU1Z2tOcGcwbmU2TVQzQm9DRVdM?=
 =?utf-8?B?ZFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZTFCdTdvWFpmcUY0bDgyTVRtTUZxdUJFdWMwSThNM2ZFQVFpNFYrTGRTbzNY?=
 =?utf-8?B?aGVIbnJWekFpNXZSVHdzR1N6VDNiOVNGNjJBcjczamhCMHlKbDhCejRlbkpX?=
 =?utf-8?B?YzU3MW1uV3FkVk5wYlM3NENzUHZ3VXlmQlR0UkVpTFhvNlNsZWhBM1kyT2dT?=
 =?utf-8?B?Qy9vUFlFL0tRNHh5YndicTRBanZ4VUY1bUVJQkFHSlVaY2NRenkyb25qRXh2?=
 =?utf-8?B?NnJLa3RCU0NRRTdreEphd2s3RWc2NEJaT3o0OXNDUmpvNGo0cXI4SEtJVzlo?=
 =?utf-8?B?aWt4a2Y5UXRha2haV0dKZzBTSnlTMDBiY2ZlL0g1ME85Y3dSZjJlbnRlT1ZJ?=
 =?utf-8?B?RXpsQVM2ZDhVakk4QzVTb0x3ZmZPSDNLeHdqK2kxVDNhZ0c1TlRyMGdEN0ds?=
 =?utf-8?B?Q2NCT0EzWWtobnpMQno5em5kRWhDREVPVEFBdHRyV2pDYWVEQS9ZS0tnQmtB?=
 =?utf-8?B?SXMybU1iTWNUbVhTRTE2aEczR0pLZHdDdU5sdll0S2FLS3VxNytnZ1BpbDBi?=
 =?utf-8?B?V3NwaUZBamgvNGs3NlMvQ3hMSTNkejFVU3pRalh3YkQwL3dBdDVybGZTZ0U2?=
 =?utf-8?B?VjZNSllvNE5iVExpL0t2UXgrOTAyQ3QwTUo2NjgxQ1FCa0I3d0tkSHlpdVFs?=
 =?utf-8?B?NlA3bWRTR2NGZkQvaFZZMW5EdkM3REVmb0FVcUlsTHNMbmdUdzE3UlhFaXk0?=
 =?utf-8?B?cklMOWdlU2lYMXRmZXQ0WjVmbDhjZWdweGRsN25ITnV5ejBlbHgrQ0cxemg2?=
 =?utf-8?B?Y1ZLVXVIVFBwMW83ZVlQQWRUV1ZzNjdlc001OTM0ckx5dDUwNWZKR1BnSjFZ?=
 =?utf-8?B?aTh3ZUkxV1B6ckVLanFTMWQ4YUxCTEg3WVBkR3c2UXozb1pSTTBhWndUSHpM?=
 =?utf-8?B?MG92ZHhoMnhYR3p0bG5XLytGdEVSWXM2OHFpZjY5TCtTZ2JyT1FlRmV4ZWpv?=
 =?utf-8?B?UU9XRFVDQjBNQ3IvM0lqWkpLRWFoVGtsSHNoNkQ0VmVldCtscSt5ZUtiUkZl?=
 =?utf-8?B?aVFqRysrWm9ERlNKTVZGczFNaEU3di8xN3Blc1JBcTA5aXh2NG5ac3ZBL1V4?=
 =?utf-8?B?d0VhZktXazh4SzVSNTFCZmd2bURSNVZRdEh2L2ZUcUc3NVVSTzFDYytsR1NX?=
 =?utf-8?B?c243cmIrTEZRTlJhalZ4T2tKM04xRS9UZUlQTEM5Nm9nVWNPN0FiRStYVTJp?=
 =?utf-8?B?VlFTTWxNbFM1OGhhbjltcUdFRllVYkJRWVYxN0x6U1h2Ui9CT2VmUnhBY1hC?=
 =?utf-8?B?OTZUcXZ3U1RjaEdMUDRGemk0VDhTSHM0ZkZpa1pjR0c5a1lrWVdqQ1dtNEJ0?=
 =?utf-8?B?NmFHQnNsd3Q5anJMZW1vM2MwVVlrcVUrOWUwdk9OMjVzaUdXeG95ZWZPWXFN?=
 =?utf-8?B?M0MwSnFReXVYaUR2cy9LUXZhUXZRWWFDSnNlOExRRGFxU1gwbUQ0TEw4enFr?=
 =?utf-8?Q?eSxqDxg9?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b210597-7df0-424b-778a-08db5fb1e8d8
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2023 19:29:52.5456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jU5c4K7eANB48hmijtYiPOsPIfPZMUcP26oZ3QBy7slvUAxGUZzvJd2+b4jLGq4Xt6IXvZFaLK1gBg8uarViRpE1z0L1hgnnhCZA0Qz9cMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5267
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-28_15,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=978 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305280168
X-Proofpoint-ORIG-GUID: fKJl69OW-sOwwqVGlAk3f45Bg_J54H8x
X-Proofpoint-GUID: fKJl69OW-sOwwqVGlAk3f45Bg_J54H8x
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/23 8:41 PM, Eric W. Biederman wrote:
> Mike Christie <michael.christie@oracle.com> writes:
> 
>> On 5/23/23 7:15 AM, Oleg Nesterov wrote:
>>>
>>> Now the main question. Whatever we do, SIGKILL/SIGSTOP/etc can come right
>>> before we call work->fn(). Is it "safe" to run this callback with
>>> signal_pending() or fatal_signal_pending() ?
>>
>> The questions before this one I'll leave for the core vhost devs since
>> they know best.
> 
> Let me ask a clarifying question:
> 
> Is it only the call to schedule() in vhost_worker that you are worried
> about not sleeping if signal_pending() or fatal_signal_pending()?

It will only be the vhost_worker call to schedule().

When we do the file_operation's release call, we normally set things up
so the work->fn just fails and cleans up. I can pretty easily move that
code into a helper and do:

if (get_signal(ksig))
	new_function_to_tell_drivers_that_all_work_fns_should_fail()


