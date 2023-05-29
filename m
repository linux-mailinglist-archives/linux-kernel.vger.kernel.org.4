Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287E6714FBF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 21:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjE2Tfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 15:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjE2Tfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 15:35:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9CAB7
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 12:35:38 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34TDO0Rh010182;
        Mon, 29 May 2023 19:35:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=3gtVAI4hKtf/+E3EiicJkmkXA6J9DKm6KruoPPSxiHk=;
 b=YEL+ST5WCAbnPzGiDN7AhUP6G13hDQ0b6hEP0bPtVziTMzmJBlQgO1qHHbiBHAbQyVjh
 pHFh2uTeePJyHDQevDF5FmfCnpBQe1jOHV5vIx4SZ2oqgOIyf+sLhl+z8Lfx96/csr+r
 0Ej8JvvvMqlENREfv2k3KmFbn+YNDpob+7SCUD/P4dmHklf6OVxp7fYQg2Nr3csZXiqy
 lCBHyfpx3Ncg6i2R8WdNjYe8NfTnEw8454MBBYgGX7hExBzP6N0/6lBhPBaw4K93rFs+
 PAIFca8esi/rHKNJqPirtmoC17zkzf/GK03v9lCklVNnj6/o9j+u/CxwCb2Ft7fTv384 wQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhd9sc6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 May 2023 19:35:25 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34TIb3EH003735;
        Mon, 29 May 2023 19:35:24 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qv4yaet1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 May 2023 19:35:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1yu+OtoEgmuYStKoPBKRPhRuy2btdg565uRUFrXd/OwBXtBH7VH+CgbNtKuhTze/PqtNdouoAK3ML1S8BTlMv/WuIgx3z1yw8UM25WHoPfXGGeF4G4GmOLqBWPX3s2gv76AI49tcyPPibv7+aYPX0l0zeRNS1q7bvLi/iLpBI9MOWeNfWc63R/lVKXI/BXac7VP0tXHhCe02UKRg4pGidyCXLjVoLO6VkK4i9a95aOMtUacJsdXX/Dydsb1yzIySZHnxSinEP7h7UVflbW8lGQs+K9+9N19HqvsNQJcd6/WFO5KNayBS0vo4FsvfVEIIeCpKU3QLSYv0lbYRyHezA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gtVAI4hKtf/+E3EiicJkmkXA6J9DKm6KruoPPSxiHk=;
 b=CEslP/GZL2BJCAVVYEucVNeLXA/h7bZSjAiCGUjmXEGAUgGc8XsM2Jzf0g7hC7kbCnM438QTAZg/BAC4TunnKG0/L/gO/zSpECVsaOLHjaR2H/mSxQ7hdj6XE4+EiwWeA0+qrMqdpWnChQxzZB7QyyrKFpB70WFkdBQzQExl/rDhyPJMGGmLs3uSPxOE+6wsHMpeYh162MxGWKDub3OlfeyQxaJHnNQ5fHyLOjgSWUsTSdY/Z6/FxX7tJAp5GWP+axyLRjcCX26vmZ0+gR0zsJnb1+C8L/PeiEArS8+IYigDxSQxlXQmAdM9k2xffEa4D/MtSh7g6KtQYJIPU4oMNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gtVAI4hKtf/+E3EiicJkmkXA6J9DKm6KruoPPSxiHk=;
 b=JswAZxpCJDyHOL6m4a4IqxXPPfMFluVp4cpsF7quKRfdbmh6bjpIfpS+2ueInv3jF3tqwPszh7yaFnrZKHdiz62BAB2wAdaO39yXkKQ/z99Ra6AfUnAZpu9CYXPCcr0eLnAWrEgD+IlTYaPDwnDQd3Wnr5KYygrIwCzIQQeMP6s=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by PH0PR10MB4455.namprd10.prod.outlook.com (2603:10b6:510:36::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Mon, 29 May
 2023 19:35:20 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 19:35:20 +0000
Message-ID: <ff1bce1a-62d8-1b2e-4560-1ce1ffc209bc@oracle.com>
Date:   Mon, 29 May 2023 14:35:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Content-Language: en-US
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux@leemhuis.info, nicolas.dichtel@6wind.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
References: <20230524141022.GA19091@redhat.com>
 <87ttw1zt4i.fsf@email.froward.int.ebiederm.org>
 <20230525115512.GA9229@redhat.com>
 <87y1lcxwcj.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wj4DS=2F5mW+K2P7cVqrsuGd3rKE_2k2BqnnPeeYhUCvg@mail.gmail.com>
 <87cz2mrtnk.fsf@email.froward.int.ebiederm.org>
 <CAHk-=whsi9JFP-okH3jXHrA8rh8bMuuSt6ZgkmPwiDMAn437qA@mail.gmail.com>
 <87mt1pmezu.fsf@email.froward.int.ebiederm.org>
 <20230529111859.GA15193@redhat.com>
 <022f4de6-9eae-0a94-0f55-b84be4982fc3@oracle.com>
 <20230529174646.GB15193@redhat.com>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230529174646.GB15193@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::21) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|PH0PR10MB4455:EE_
X-MS-Office365-Filtering-Correlation-Id: 4290c892-6fad-4e95-18cd-08db607bd69d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VE+eF8lkteMoi/HdU75DYOfp9EKeQEfnvLXgjaKbs9OLy/b9TSwyq5kW95CE3FFr0gSr0Dy2C0Ew/iA88SVeap+59+LMX95F7r9yHwz4DIwSCUo6cCsxxYRFiOIoSVbb9KmjsR9mCGIXIxyTJoLcXeugBR0bJKZO9+X0LFtnMxEBjwxalLKJIXwweevJQW/On7g2alFzT4OXhnnO7EUHDoDGD4XrRtElFyBxcjjVJSpoTE7l2RIA51uShMdZAgQWnt4SWqAEzs6DTAXrWtV73mROotdnlxxlkijU2BXayTsD17ym331QQwXpQ8m9WiEqoTB7cKdW1Ve3W+HRQK0C4TG8pBX/KJWjGTGGNEVcm/dtXN4eO9v5q957VCfswZ3Dth55iVJlD1xO4BZ3Te6aTWZ8ojxI4ie3I+nr98n71+xEYpNCJ36DgWffEKMNyEBAuHDZG606JOJ7Dn1jzkVBf4lK20mSzgTMOcG10GY24Cw3qeC8TkH5sO+8i+LFzFE1EBUOdweHZ9PNk+7eVoz/a6Q1da/EQmcl3+GF/YJLfFcuAGqUp+ipzYpzLixmSWOfPV9r42Y9CMGms2CFlubAk8gW86ntNa6VqO9HNS7w5O6/ZqeBcm0/8hFS11wpnpT48jAyoxIJVnzMM81mmsMiYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(396003)(346002)(136003)(376002)(451199021)(83380400001)(38100700002)(186003)(31686004)(41300700001)(6506007)(6512007)(6486002)(26005)(53546011)(2616005)(478600001)(54906003)(66946007)(66556008)(4326008)(6916009)(66476007)(316002)(7416002)(8676002)(5660300002)(2906002)(31696002)(86362001)(8936002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHpGaXowRFk3MmdodjhqNlp4YUJUNExQcDV5SThaOFA2dmZyall3WG1IcTVL?=
 =?utf-8?B?dkNUVjljSjdmS1FsajFOdHV5WmFORmczejY1bklPcWhaei9iVEhUZU05NGRa?=
 =?utf-8?B?OWRmVktsVlBTRkZxMVlzU3JSRndZQUR2WkZETkNzSXhzZnJXV2NWOE9UaVor?=
 =?utf-8?B?YXRhaUpOcEl4czdqcEpBYmk1Q0l1dERpYnN6V0UvbDZBQXYwTlprM24xM3p3?=
 =?utf-8?B?TnBESnU3TWFRY3VMUlpFdFZRbjI0dzBJL1lORnY3Nnd0STYrWTBIMDdZQWpY?=
 =?utf-8?B?RkhodkMzRGRGaXdhOVRsZUk4dGFkSkkyaitoYnBTTXR1dGVJdHl5QlVFZEVY?=
 =?utf-8?B?U042TVkvRUxmSFc1c0dFaU8rUDhLUENHdEJRcHpUTUd6NHdUQUg3QnNjb1dR?=
 =?utf-8?B?ME51cVZTNDZHd3p0MVZ6eFlWalN4MG5haGNxdTJqVzdxWERPVGljeFdIMXcz?=
 =?utf-8?B?OTB0Q01oQjRENkVvUTYwdHIvcllpclowL0IvTzUwSUs0dGU4UmgrOUVPTlVl?=
 =?utf-8?B?ZUpLN3BMaXhvVXBET0w1dHcxSkNlSXJpOTFPRU5mYkQvZnV6TGsvd2Rqa29P?=
 =?utf-8?B?RjIweUo1cXU3b281V1VwWTcraldNZ2hhU0NROHRvWHdlTkNLYVhJTkVCM2Va?=
 =?utf-8?B?N1BvZGpnaGE2L20vbDl0KytTRlI2WjE1SkhwZHdTTG5GUzA2d1NqdnFKUC9I?=
 =?utf-8?B?a05CcG50UEF1akFoMjNPUlo3bEZJMW5qbTZ2bzV4dW1JYlNzNW1BUXAyMkRZ?=
 =?utf-8?B?aTBKbFVJOVNKb2RzZGhqSjR0MmFWeWtBWUl3ZHlNTkZQeEZrUU52anlNREdj?=
 =?utf-8?B?RjI4RnFTelAyNnJGcHdpZXR4ZzV2a1RNWGFJRG1QejIrZmQ4Tms3V2Z6a25x?=
 =?utf-8?B?Wk54dldOWjNXd0pGSVdHc1p1M3FPRDZCbjhCU0dKM3BNclZJc1oxMG45R1hY?=
 =?utf-8?B?ampJL1hBaXo3azBxYUk4YWx2dzkzcG85b2Rjd3RMMXU5aWJ0MnFvNzEwdEl0?=
 =?utf-8?B?YnROZzFSb0ZYNURxWGhPaUFxWnlZbk9ObTIrYnVSczd0TUdMUStKbGU3cW4z?=
 =?utf-8?B?cXU4Vk15N1pGM0pBRFdZV1B4L3ViVFdydXpkVS9MbmtDS3R4WVNsc1U0RUpv?=
 =?utf-8?B?a3IwdlZpUWxvRkZ5K0hPZFRGVmlmV093RnJpWXpZQ1JBRXlSRlE0b1B4V1RK?=
 =?utf-8?B?V0VQQ1RpdDA1WG1WRnJyRktCaUpYd0dsT3VvYXlwS21Xb1VjTHJGN3cxTWNO?=
 =?utf-8?B?b1ZvTno3R3Q5VGE5QkN6R0E0K0RIeDVtSG5sNlZiQVpmTzBCKzArMFllanJu?=
 =?utf-8?B?NUtNaUpZMDZMVkZvQUhnU3Y2RVhtaWN0TzI3bnh5VC9mdFZndUtoNmloNkh3?=
 =?utf-8?B?clh1Y0dIUlRVNHAyZk5WQ0FQRmM0Zmg4YnpPTXNXQXI2RklWY3VXLytpWTlJ?=
 =?utf-8?B?RTBmem5RL21YSE8vc2dmL082NlJpZkdBZE5rb0dNUEF0OFJOMlV5NmhEOENV?=
 =?utf-8?B?WjNzVExHSkZDSVhJbWR4RVJzQlZZcUhHUDNEc2NQNXZRbjl0MWlOVkxqT28y?=
 =?utf-8?B?WHdWNS9LMjFDUFNzOWR1blQxdmt4elUvT2RWR29TdmpoeG5hT1ZxdEx4Z1Q2?=
 =?utf-8?B?elZNU0RlWURLTDZ5a2VpSWVySEJneFdLaXRESG5QbWpKWUJsY3pQK0ZsYlMv?=
 =?utf-8?B?WFZ2TmF1UG5ibVpMQ2poQXN3K05hOHdWM2lxaHZRZUlwd05BVjBMeE5Wald5?=
 =?utf-8?B?WlU4OWp2UGd4YnAyYjBGWVR0eVBiWHVWM3JubCtIL2NueVRNMWNpWk1oc09R?=
 =?utf-8?B?ZDBZQXhpdU5kL1ZaUlJtNGFKWWFucjM0bUpuOFlncUNnQThoa3hVbHlrSldj?=
 =?utf-8?B?NzVhejdFR0NYY1hqUjVvMktOcmhNTUVrWURaMTdtdmJ2cUw0MDd0eHE0L3F0?=
 =?utf-8?B?Y2ZUODNPdDVJUlJjSTJQdXh3bzUvSnRCYnlPYVJHcE8rdDlmNGFncWtyNmhx?=
 =?utf-8?B?K2RhN0Yycy9hbHdxWWhoS3gzcUplb3JXRjVaQUt4aVhuU2l6NkVtMzJrMEFI?=
 =?utf-8?B?NEdwWlJId3FTMzFRaEkrYTFuUktMQTZBY251cElEZFpZdmZ1Rk9XUTVmVTVq?=
 =?utf-8?B?LzlBNmRZN0VycnI2SFJtVkhWZVZOV0pneGtWc0Y5RUJkaHpZd0lvTWZQRm9z?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dEFLbXNzSi9nelhZbGlrZE9aUUpzc2EwWVVxVjcydFV6bE9JNU41MFhpN0NO?=
 =?utf-8?B?NUU1TTJZbmJnTkpvYlpEd2k0VVQ1WDlRWlZURFZ2cDNHS05kRDMrVnhNemE1?=
 =?utf-8?B?bHllbWFPK3lZbWFOUmFXVWxxMGVtWW9KYmFpWVp5QkRQUUlrSldQeUdwMjM2?=
 =?utf-8?B?OU1KUmliTXkxTjk2VHZNVFZSc0RLdXNsTUxueUpJVmVaMHhrTktFZFpMS3Jt?=
 =?utf-8?B?TEp0Y0JFeEk1aEl2TzZMUkNYYXpiQnRzQ2pqSWZoQzNYUytmbWh1dlVXM1hl?=
 =?utf-8?B?aldwQVNGMi9jTTBrYjBpMTM1c0cyOFQzVTBMR09Rck95SGdiTWdsbGRKWitv?=
 =?utf-8?B?MFgrQmpFd3JHaC9GS3IvT2QvcCtDNEtRRTE2Q1FFZjZqMzBpOHFiV1MwYk1q?=
 =?utf-8?B?a3g1ZWRRa3R2SGcxOGJCY28wTGpSZ01hOElQMGNSMGI5SjQ2YUpqSFRpNVRG?=
 =?utf-8?B?KzBNZUMzeWgwV1BLcURYNUhrUDJTNDczTXFFSUhmMEtoMzhUUDRmdFlQeXN0?=
 =?utf-8?B?Vm14dVZBOHc0VWg0NlRIbWRlMFpIYnYyOVlvejF3akIzRjdBeWYyelo1UDQ1?=
 =?utf-8?B?RkUrZGVheG03clpHeFNnS2VJUkJ1Y2RPR3laa09pRWtkOTZEbG1UMitnajVL?=
 =?utf-8?B?Z3R5U1drUnlzUW4rcUZOMkV3WEFRWkNUNGxwU2M0cWcxOEtXblBJbDRCWFBz?=
 =?utf-8?B?QUwwd1ZtT0ZDckVYemVZWS8wQ3V6OEdCOEFoV0lPTHVOSVYvQ3NoR0xzZUlS?=
 =?utf-8?B?eW5OTVRCa3dRM0o5bHBiK3hENHFEb1FjeDRsNi9zeG8yN0picXNtanB6YWty?=
 =?utf-8?B?M0ZrUUMyY252ZExEUDBLZW5rVGdRUThXTUNzQjdXaTVSZkt1MFd5TXpxSGtN?=
 =?utf-8?B?emFHSmhyNkw0dUpEOU1uVW5rN2FHWk5OMEt2WGVFRnQwTEFkT1Rzb2hyV0o1?=
 =?utf-8?B?S2FaQTJIMnJmb1kwUWtqRHpxZGc1YmFkWFVDQVVReWxaRnJDbHRsNlFrb3JT?=
 =?utf-8?B?Vzl6Q0xyYjZ3aDNQZkY1aUJ2WVJqQmNYQmVzNk1IZWM1ZStMb01ZRkxJbEhw?=
 =?utf-8?B?NWxiVFdNUm1yL0tLSHZ1Z0xZUkVtY1RxOTl4L3dJaHphWE11NDZvVlpRaVFE?=
 =?utf-8?B?TW9mSlBobzJuVXhScWpWTVdTdlpWZ09CUFhSM2VYSTdMM21ReFE3aE0rOW9x?=
 =?utf-8?B?WjdiU1BHbVp1cmRZWU84WEJzOUR6M2NDYkZIUmZxUkVqTEd2VFlMNUNEOHN4?=
 =?utf-8?B?VVJ3RkhVaXdLd1FzNkg3ckcyamppdlFTOXN0VUpEanJGWUdqcHpOR0JYaFFL?=
 =?utf-8?B?eEYwWWpQWWZOVTl3SFhEaHNQTk1EQS9hU0pCQzZ2YXlyc0llVjA3c0g3YndD?=
 =?utf-8?B?ODdOUmdGYnp1eXFJVkc4UTBkT3NpUFA0SHpoT1FwSEZ2QXA4dkNBamFIRHd4?=
 =?utf-8?Q?yZFHMNLS?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4290c892-6fad-4e95-18cd-08db607bd69d
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 19:35:20.2965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yTrH1FirX0izYMC6kff/sjtH/p902DuRJXBkmTrgSnYLsbDOUyD5O0lhRuhvYoThWCuw0afxnDieN76RZqxm5eMZtiB9ZWYXERpvHSuzlHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4455
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-29_10,2023-05-29_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305290164
X-Proofpoint-GUID: oMYhh36ivWUJ1lbTMjObGCRGAw9g-4z9
X-Proofpoint-ORIG-GUID: oMYhh36ivWUJ1lbTMjObGCRGAw9g-4z9
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/23 12:46 PM, Oleg Nesterov wrote:
> Mike, sorry, I don't understand your email.
> 
> Just in case, let me remind I know nothing about drivers/vhost/
> 

No problem. I get it. I don't know the signal/thread code so it's
one of those things where I'm also learning as I go.

> On 05/29, michael.christie@oracle.com wrote:
>>
>> On 5/29/23 6:19 AM, Oleg Nesterov wrote:
>>> On 05/27, Eric W. Biederman wrote:
>>>>
>>>> Looking forward I don't see not asking the worker threads to stop
>>>> for the coredump right now causing any problems in the future.
>>>> So I think we can use this to resolve the coredump issue I spotted.
>>>
>>> But we have almost the same problem with exec.
>>>
>>> Execing thread will wait for vhost_worker() while vhost_worker will wait for
>>> .release -> vhost_task_stop().
>>
>> For this type of case, what is the goal or correct behavior in the end?
>>
>> When get_signal returns true we can code things like you mention below
> 
> and you have mentioned in the next email that you have already coded something
> like this, so perhaps we can delay the further discussions until you send the
> new code?
> 

Ok. Let me post that. You guys and the vhost devs can argue about if it's
too ugly to merge :)


>> and
>> clean up the task_struct.
> 
> Hmm... If we you CLONE_THREAD the exiting vhost_worker() will auto-reap itself,

Oh wait, are you saying that when we get auto-reaped then we would do the last
fput and call the file_operations->release function right? We actually set
task_struct->files = NULL for the vhost_task task_struct, so I think we call
release a little sooner than you think.

vhost_task_create() sets kernel_clone_args->no_files, so the vhost_task task_struc
that gets created works like kthreads where it doesn't do a CLONE_FILES and it
doesn't do a dup_fd.

So when we do de_thread() -> zap_other_threads(), that will kill all the threads
in the group right? So when they exit, it will call our release function since
we don't have refcount on ourself.


> 
>> However, we now have a non-functioning vhost device
>> open and just sitting around taking up memory and it can't do any IO.
> 
> can't comment, see above.
> 
>> For this type of case, do we expect just not to crash/hang, or was this new
>> exec'd thread suppose to be able to use the vhost device?
> 
> I just tried to point out that (unless I missed something) there are more corner
> cases, not just coredump.

Ok. I see.

> 
>>> Or suppose that vhost_worker's sub-thread forks a child with CLONE_FILES...
>>
>> You mean the vhost_task's task/thread doing a function that does a copy_process
>> right?
> 
> I meant that the vhost_task's sub-thread can do sys_clone(CLONE_FILES) from
> userspace.

I think we were talking about different things. I was saying that when the vhost
layer does vhost_task_create() -> copy_process(), the kernel_clone_args.fn is
vhost_task_fn() -> vhost_worker(). I thought you were concerned about vhost_worker()
or some function it calls, calling copy_process() with CLONE_FILES.

