Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E21714F87
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 21:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjE2TD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 15:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjE2TD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 15:03:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74C1C4
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 12:03:55 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34TDO0ik010161;
        Mon, 29 May 2023 19:03:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=OmtSoDVIHNiB9xDO9PusNmO9p22L1BMliatVINd8KS8=;
 b=veworpSgjuZEfpxu8ys1aLfl4MH6QtLFfGO+GgnRqPRg4JT62+Ks3Ft39LyNjaIq5+0m
 uLwt4+v6l1Pr8vNr4dk1h2I9K+RJEfqffDNjmEiHTUfHQynUMaY9w/YyNPEgCfsFLaYO
 4TuImtl2fzYvrB18Bn/+PZTnm60EjLGHmV5Sx103WIYwcxZkAXTuKwNBNNa8p79AST8M
 HeouyHWAeyqLKroyO/R9vRrIauEijeLrHUuw73+W4Ml8NzoIN9ahhDVh7GTdjBB7QEdj
 fh7XIh7aGLtHbisuFZCBe1Fc70MAvg13PWLRLD1krmqIa+BnrjPukLiAlvD59XtVHWmn Cw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhd9sbbd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 May 2023 19:03:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34TG7xE1026123;
        Mon, 29 May 2023 19:03:36 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a9c1wf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 May 2023 19:03:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVfF29WdhY5X+oeP3+6ybezrTd7sLxaf12HZykK5MXMZceACD0Mikib0nkukJjsferPIwnqKpu6lAWmn5/raE3Sj1+72s+F1DeDiF4WH599xNAX5YVkVLMRCz1PLpDzzhBfJ9vyNSIJeMeREBHm85/PeF2DHbtnTJx6PklKj8ZB4D+R3LW8jiIPDoQS7A9Womfbnds+xqLnrP63s9P5KoC9ojNbpEIOsESJ5aztonEDS16Zt6sL8wpurTvkwQgI1+U0aD4XIpmxBAPRlCIkCkvx5oHRrH64wVfba0Fxkm+0wJVE0ByL/z9B+h4GPB9pzfRif+tAqP4L1gg8xkPKZEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmtSoDVIHNiB9xDO9PusNmO9p22L1BMliatVINd8KS8=;
 b=mHySYyLLbYk7fIkoXFufYlX1KKosyHlT5UPrzynoqvEa0IL9vsLpkbg2ZRDA2R4V32xzJl0fJAfclPwxVxn4lh3r+aB3ha3S3yNqHiFl0Aw4yCH2NnC+jRBpDgFFzL1wGOkrnkvLLrbv1hT0EkyTCOVIVoFump89ks1tg1b80BjXZ/bWPolB2l0QpaJ5C4+Kf+VxScR3t7L2vmkv38yleSLxq/zviw+Bko0wXKqmqfWhdRqUgZP2cnFu+Th5o+0rYVijkLxHc11gEv8xjPOtd2tsDcLL8puvkzu8pc9l4I2CSjr6Z76i4KzZ9YIRZg8Qd6RoJVaDswVxzV/AUPd/hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmtSoDVIHNiB9xDO9PusNmO9p22L1BMliatVINd8KS8=;
 b=rurPp46Ym8FL8SIFb86Zko3AlhPLmD58wlChAlIwbJyK/BS9sxjbhYNA7L7zYw4GWCFlFeaqFe1tq8YMldLmxFN8ihv49LqiVpk7rmxxquBTyDiYsfymlT6pB3MP29QDu2eGF03FmQJUlC3vWwx3oLojv4g29LnLAAqZ9ckworo=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by DS0PR10MB7407.namprd10.prod.outlook.com (2603:10b6:8:15c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21; Mon, 29 May
 2023 19:03:07 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 19:03:07 +0000
Message-ID: <a566ffa5-0d30-58a4-fb4f-284504e04fff@oracle.com>
Date:   Mon, 29 May 2023 14:03:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux@leemhuis.info, nicolas.dichtel@6wind.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
References: <87ttw1zt4i.fsf@email.froward.int.ebiederm.org>
 <20230525115512.GA9229@redhat.com>
 <87y1lcxwcj.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wj4DS=2F5mW+K2P7cVqrsuGd3rKE_2k2BqnnPeeYhUCvg@mail.gmail.com>
 <87cz2mrtnk.fsf@email.froward.int.ebiederm.org>
 <CAHk-=whsi9JFP-okH3jXHrA8rh8bMuuSt6ZgkmPwiDMAn437qA@mail.gmail.com>
 <87mt1pmezu.fsf@email.froward.int.ebiederm.org>
 <20230529111859.GA15193@redhat.com>
 <022f4de6-9eae-0a94-0f55-b84be4982fc3@oracle.com>
 <20230529174646.GB15193@redhat.com> <20230529175440.GC15193@redhat.com>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230529175440.GC15193@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0058.namprd07.prod.outlook.com
 (2603:10b6:4:ad::23) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|DS0PR10MB7407:EE_
X-MS-Office365-Filtering-Correlation-Id: 58993f58-090d-45b2-ca9f-08db60775688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6JEdh3HBXptiXulfhkqK7Bv/ZFhL4Z+vgGCQgkl2l+/RECZAa5QOo1wwOJVa1g/d/OLGRdM1rOiKkK1c/brawp5AV2N72XjrxInZHglT5MPnhAeMvLO/XgKQBIALe7GRuTCdIRNeMBqjUJvd+e5OiTYr6lhK5us/OOSL7+F2+AoL+fcT5liRdSe0uV4BZhGVpO28FaoIJZMbrk+MehOC0eJCTGxuVV70NBPyOi3+NzvBt+Vgf1s+tNyxhJKbrTA/+KMkOu8IJMLjk3dyyDzpVliB7kUynAPsgaaImXJIXIIxipH7MtexKdWOftjdJI2YeUIXbpsOsC/hDMWDuPSVkqJ3Nytkr1XzU2z7Jc+++DzNgiJ+62rP3xxCNdI6DFJtv8/qevntJWKeY1bQxfHWdZ4V6jY71ifnjEJ/O9xIHtooSGdRkJZ/HoI3tKO5ySwOuczLsHrU1mpSFzAcXQZDLVtkDcf09x6BFva1n41J5K6c+phESKGLZMJkqhsc5akd54xOQXtausX1ZXX0cKD8jzn7D/oQcJXLTNYz6F4yRY6/xz1r2QxdjoiIciRT7ZTywp3CmzTL28sTRQn2CuipH1Vge5hclsbrpw29ry5f8XEqzYoHTzLl+Zpr7Bc46tO4rkgElaqcoj6oJATZ3aoZ3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(366004)(136003)(346002)(451199021)(2616005)(2906002)(186003)(36756003)(38100700002)(8936002)(478600001)(8676002)(7416002)(31686004)(5660300002)(86362001)(66556008)(66476007)(66946007)(6486002)(316002)(41300700001)(4326008)(6916009)(26005)(6506007)(6512007)(54906003)(53546011)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWdkSllVNDN6S0k1emp5aG5zV1RhclVBS1crd213ZGZjdEQ3L3ZwVENqYXJa?=
 =?utf-8?B?VGNFcTV6THEwQmlvL25COGVlWjBVRHIvVG9MWUs3enpLa21VVk1wRDRPOWg2?=
 =?utf-8?B?bHkrQWZpYWRaZC96NFNOeTJBWVRic1FWd2RMb09DdnhkWWkvSy9tKzk3ZzM0?=
 =?utf-8?B?b2pndUlIL3doUGp1cSsyYmorYXViQTBUZnhkTUtyR0RFNGlwc1hVTDVza2tX?=
 =?utf-8?B?c2dHVFZiaDNkTzNsbUh4ZTJLbWNHVHZ2TGxaek9zS2xMVEJScXhadXNLSVBZ?=
 =?utf-8?B?Z3VGY0pWVUNyZVZiYnhWUzhTTVZKV1JsOC9pZXlZL0ppOFBLU0JHTjlwWGFB?=
 =?utf-8?B?NGx0aDg0ek11TkN0MC9lUkZFK1VyWDN3QTZrc3pHY3VGeEdHSGI4a1IzSzFi?=
 =?utf-8?B?d1BHdC9JN3VGRVZBQWdCQmtEK0lwVnIwYjJLemlkWTI0ajdCNjNVRlExK0pK?=
 =?utf-8?B?ZUNOWndaY1JHd24zc2hWR1dsUFAvd1VzbC9jc3Vocjl1clZGT2tDTkdwWG9W?=
 =?utf-8?B?RzBwTllhb08yUkt0QlhCSVBiL0VFQjgrMlg0WnFVQ3cwS3lQMHBXcjJoek12?=
 =?utf-8?B?QWp6L0NwWnpDV0NYSTBLOGxBSjFjYzJZZXNXMFM0amJUdy9sVjgvYjVTUUFz?=
 =?utf-8?B?a21PYXFzVERJb3BjYTE3bTR5bnQxWEZpdzIraE1Wc1dOWEd5WjJiWmtCUzJ6?=
 =?utf-8?B?alk5Ukk2WVo1TW90ZTRpRVg1dGtrVHVpT2FzMzdpRnNGVEtUUllLdG9rbEJV?=
 =?utf-8?B?K1ZXWWtLVnpSaXFRT1JWN1RYemRSQm9TYS9LbkpCUTlHYVBlQ0lIcWdFcERj?=
 =?utf-8?B?QmRpY3JCN283R2FFdnRCbkJZTFpqUS9rK1hOYzhJbi9JUERSdjk1aHg4YnpZ?=
 =?utf-8?B?eVNlTExveUx2TGp3V0pGcjFTdTdCMy9JQ3BPZGR1WmpTbm8vblFnZHRTWmVa?=
 =?utf-8?B?ZFp6ZE9uNUFPZ3pXZjNPa1ZvSksvQytra3N3MGlPa3FhYnZKVmVRU1pDejJJ?=
 =?utf-8?B?RGJLY01mdTdFWFR5cU8ySmU2N25HSkxDY3pwMVd2RVVyZCsweFZLbGgyNGdC?=
 =?utf-8?B?cVhWMS95aVZsWkQ3M0xtWXNNaVVpUUN2R1VqTUUrVExLMEJzVFZ6b1N4dTNp?=
 =?utf-8?B?c2FBZUhyRllIaENmWFh5YnNnNExnNlp6WEhyUWRibW1UeDZteHRsTVBiZTFv?=
 =?utf-8?B?eExKVmRqREFRdjArMC9oZG1kQUtWSnU4Rk1rajVKNlRHZ2ZKeXk3ZmY4empp?=
 =?utf-8?B?R1B0TnpXa2JHeGRabER5T2tTcEVOT1J3cEtCV2NGbFJTVVJzMUEzM2FNSjZT?=
 =?utf-8?B?QXJadU1xalZta3ZRVTRKeW1oSmYxUUpKUUFwQzNmZWY5bWdKbWVWZHFyMHRq?=
 =?utf-8?B?SmgxN2REa0dsRkNreVFueWFZQTBrWTNqQkNnd2hteWxXSGhsMWdmN2ttbmh2?=
 =?utf-8?B?OWFIZlYyays3dEpZQ2NVTkNyVzBZTkVlS1RlbWsrVU4zZjljeWtFc2NPcDVz?=
 =?utf-8?B?RnlPeWFDVWxkZTVpS3NuNlVNdjZCMEZyZ0ZadCtzYjduOTNObkhBbDR5WjUr?=
 =?utf-8?B?Q0VRYk4zZlpPWWZzdE84SkdUVWE2NjZQRE5WblJ6NS9GelJvanRQSlBNbWRw?=
 =?utf-8?B?RkVCL0x6Y2FiQ2F6UFlXMzI1Y2F2MGU2VmlBVU5vdFF1b0FMMGpmQStrUWI5?=
 =?utf-8?B?Q0RmNTREZVRjbVlGQ3htQkVvbHJkdW50akhkc0U0U25CL1p4aFNIRU0zRGlr?=
 =?utf-8?B?d04zdVJQTDV3YlhiNStWNFRuckFNa3FzTUZwOUFOKzFIRGkxcTlNNFZPVG9x?=
 =?utf-8?B?aWhkSURXcUhDR2NvTlZVaWQvazZpQkJoQjhlTnlXNWZYcDVIQXhCQWxhbFJP?=
 =?utf-8?B?MFFsd1ZrZVRVK0MvVlRKcDJqQjZPL1NFWmJuelVxSXkzYjdvT3hlTWZwMTBq?=
 =?utf-8?B?blkwSGhLNVpLTmsxNVdwK09jek9pQXRQOUZUdFN1d1dzN25Ib1F0NGw2RGFj?=
 =?utf-8?B?UHd0VDJCUDZ0S3Y1Zk5jWWViUUlMem5paTB4R1pCYWtMRmQxVFpnWGlTQlRX?=
 =?utf-8?B?NW10MGJ4VVVaalFxdkJUMk1kS3Zla3F2ODI3SlFtMmpVaXRzdXNYM25QOEt2?=
 =?utf-8?B?TElQbkVGYlpIOVpabWlKQWJqVXlkS2JBaUc5NjhyejRWU3hYZFRZNUhsaEs0?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dXRoU0VDeE5ZQ3BlQ1RHTjhHTVhlYzdQdUdMd1Y1VnFmckVERmJUNVVIc1pn?=
 =?utf-8?B?Z1YrRWMwQmJEQlEraXJRajBvN05heUFmRWNHTUhwVnZzSVVjdUQwL3BJQ2Vi?=
 =?utf-8?B?KzVKeFdOZnJBR0Nia0JmdythYnhUWnh0LzJrSEZiRUpYdWdad1hNaGoyQVFn?=
 =?utf-8?B?dWpaMEhsaUVkbGJiRitsendsTnF4N1YvT1lQcUVmcGVYem9ObEloMUNqeURQ?=
 =?utf-8?B?R3ZPV1h1Mms4N3dnRlBpdXhnTE9xVGwxdHNEQ2pZSFp4d3hHQmRTcFRqRXJD?=
 =?utf-8?B?QUhJTlZ1WXR1RUtrSjFzaUZiYnk2cWpBc3FnOFkzUUEycCtUM1pYdEd3Y1NX?=
 =?utf-8?B?UHVQd296T2RKWTByc0pWMlR5NjI2SGFGelUzSnFjajk0SVh5UWEwV054Unkz?=
 =?utf-8?B?eXAvSWNESUR2alhnbVA4TitZSE5iSnlzdGMvT2lzRGpQbG5jMVAra1NoaDNJ?=
 =?utf-8?B?TTk1a3l0RmRIdHBZbW5zZVZEeXZBUi9GMjFMRXRIKzlDUGJjbnRlZkN4enJI?=
 =?utf-8?B?VVUwTDd4MUlvZVRBWUN0aDlpZVFQRXU4dVlOT0VoYmxObjRtc3FZM3hsU25n?=
 =?utf-8?B?d0xtSHduSmFxcDdEMGR6dmhCRk5sUjdzZlFVUnhpU0JkZXFYU3N1OFdIUlg0?=
 =?utf-8?B?YmtmbllqQXg4T2VRN2EzZXZpaGtyS1NMUWRzNVpyZGo3cTV0aWZyeThldmJu?=
 =?utf-8?B?RTRsTGdxM1prbkZpSnEvZkQ1K0dPU3BGQitUSnZRNVRDMVdadVducDZ5WmpJ?=
 =?utf-8?B?eVBpVG9UN3ZqeHR1TXhBenFjMHUyaFJOcERuRDZkbWVQelp6NjRsb3NFUVdZ?=
 =?utf-8?B?RGtVWncrTXBRc1cyNkt2QVh3TllPQmRyZVVTai9pUkRVM3BDZkxmTEl3ekVG?=
 =?utf-8?B?aktwZFNGSlZraDlwRGQwMUFTZnVtd0M1S3ZvbVp0aGdTVHNRWCtvZXVYbkkw?=
 =?utf-8?B?bFFpbUtqaFBSUDFLMXlYeDgvV1RnWEJzbXVuNWJKUDFmc0lJb1JaMmZWV3dS?=
 =?utf-8?B?dG0vSUdBTk1wV2RBM0o5MWdUUi9MR1dJRzF3NW9OVWdKelN2U0ppTEErT0Ry?=
 =?utf-8?B?bndYV0Q1ZnNIUklBZXczVkRadjZJRHZCL0QwcWt3aHBOYjRSZzdwL1NNcmJY?=
 =?utf-8?B?T1NzWXBCSkJUMGltclBRQnhXRENDZU9MeHBsMEx2UkptVDhhYkdyQVRrVkdY?=
 =?utf-8?B?TDNuR1kyRTkvUlVlMCszdmVsN1hyLzVRY2wrS3JPS1FKdE9sbUthcVZIN2pT?=
 =?utf-8?B?N1BzTVAxSkRnNWg3b3lTeThJaGdZVUhuSDBYMStIMlg4Q24vc1FrL1JmUS9j?=
 =?utf-8?B?eXZ0NjBjaUhaVGt5UUVqZWlySEdQMENhRVZZeGZDcGptZXpLMmU4WS9DQ2Zq?=
 =?utf-8?B?WHdYS2F6b1pkcitmc21jc3UrbDVJRXFnMzFqMWNxY1RJUHIyaGQrUkRhUUhZ?=
 =?utf-8?Q?MXx3wr+2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58993f58-090d-45b2-ca9f-08db60775688
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 19:03:07.3598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xuzyyEC5jAHcO32+1SJVLNtm//sYlF7w/OfGKpqVLdAr/39AYMAC5kGoO8+o0dZ332qquDnzdxpzqEQc8DlVuO4yYL4mJiE2CNKf4VoF8iQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7407
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-29_10,2023-05-29_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 adultscore=0 mlxlogscore=729 bulkscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305290160
X-Proofpoint-GUID: 23DBwgqSHUnNA6nCLoXNx_mWZ2dvJVEi
X-Proofpoint-ORIG-GUID: 23DBwgqSHUnNA6nCLoXNx_mWZ2dvJVEi
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/23 12:54 PM, Oleg Nesterov wrote:
> On 05/29, Oleg Nesterov wrote:
>>
>> Mike, sorry, I don't understand your email.
>>
>> Just in case, let me remind I know nothing about drivers/vhost/
> 
> And... this is slightly off-topic but you didn't answer my previous
> question and I am just curious. Do you agree that, even if we forget
> about CLONE_THREAD/signals, vhost_worker() needs fixes anyway because
> it can race with vhost_work_queue() ?

You saw the reply where I wrote I was waiting for the vhost devs to
reply because it's their code, right? Just wanted to make sure you know
I'm not ignoring your mails. The info is very valuable to me since I don't
know the signal code.

- I think you are right about using a continue after schedule.
- The work fn is stable. It's setup once and never changes.
- I have no idea why we do the __set_current_state(TASK_RUNNING). As
far as I can tell the work functions do not change the task state and
that might have been a left over from something else. However, the
vhost devs might know of some case.
- For the barrier use, I think you are right, but I couldn't trigger
an issue even if I hack up different timings. So I was hoping the
vhost devs know of something else in there.


