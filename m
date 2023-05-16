Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984EC705058
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 16:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbjEPORL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 10:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbjEPORJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 10:17:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200406A57
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 07:17:08 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GEFsJP011364;
        Tue, 16 May 2023 14:16:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=+JhGA3KeFfY7ToxHmf/Jg9lsK7mmRv+NWiVQZEx4TfM=;
 b=3Rxka0AmyXoLTlmSS9yMY0bDZUMcik+NZa1mMNXMAJ0grVGfK9VnjNDZeXFdLPoRmJW4
 GuURLrf8WFnSIEF/fauHMnwRHa3J7J2rj0BkoOFxHV0HSPPwWEXNXsf0TVrEqjqK8RWV
 7SZr+1dyzIXjnviQqRNiw2iaIYEP81AVHIKybww0RR+hsLmDazxNWS+amwEKb2U28GkA
 xNlASM358whHBIM+zTNJi3beSxY0Ogk4I5GJ2Ce21Vrmj6YBtFXmcqsYlHNlZdJlUfLN
 6ARB3Z1kJddUV3ILbQ6OPWlBXtaK0YvuTnKg+1o4P+t85Ch7QadJiF68uNkGrCNqvY6i +g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1fc37cs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 14:16:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34GDsSwE040286;
        Tue, 16 May 2023 14:16:31 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj103vkf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 14:16:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUcXouuwblMjsvzPOLfdQlTMfLovwCwsASR21eAIBz18LnzIchJDbt577UimuhPjzQAVcMCsqyyZz3KNGFEVnVkpTSOEaOPmdnHoGJ8PHnqi1mKwVAKOqQTgN2kdW5v/amcvpDvyDSMTW713xXBOW2dd+N2UV68x9JV4p+JX7aw2Y/NbppVL/d7yQu1xjJ+fq8WJ0Y9S9SzAG4UADGzLP4lUh2f7vftzF+6FrPDLd2sl8FmFUIqvrhwKNBfh3aL8ITza+vjzZLDu6C1TAyjHkC3DZLirQmPm+vYW9XlikVdGf+S/ZKsnuKaM11jsoBm/lX+RY1N+gpmrwdLeZjhtyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JhGA3KeFfY7ToxHmf/Jg9lsK7mmRv+NWiVQZEx4TfM=;
 b=QuvujhgVFBZ83dDmSE027MIY780iIf6JunMgXP5MaLy3KV/O8G0+CwCb7Qq5NnTsTElHGW8+t9OPwrfSFbLjctUIzDWwko1778jEFxjtn+HMOKpXtaVF1OvqYNRmxMyZu1tEOEy9pk7Dz3N2RAmzRW1bSato5RQllPdg9kC+Y9V999t5GCLOP025wKsu8vFh8Mo/721j3pw8GzEGeiHlBWVXbFOifNwtgy9FambifKN7QgoBexnu5MFX5WseODSP2CDnAJzfbYSqL6CX1IqLQjly3i/R4Lm4xSvIjJ0/9740XhaH5Nvh0i0gmwHQzU0g/mS7ShvpzLT7EJ3vr2jWGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JhGA3KeFfY7ToxHmf/Jg9lsK7mmRv+NWiVQZEx4TfM=;
 b=qh9KMCjeIpknJjcf84xFG7k7xs9U06n8gzybAqjgHm7yHN1IFsbPnSEEmDmhyYMOo8f9Pi+TM0ZZQ/5i68QzWhbOHb6cJER9eoGN5L/kc7xcAJoj3DcPAsI314ufaGDVPed1Vd0hS9ok1Z9jYdpND2XFVPSAdPOHV96vD7emf54=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH3PR10MB7233.namprd10.prod.outlook.com (2603:10b6:610:121::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 14:16:29 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%6]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 14:16:28 +0000
Date:   Tue, 16 May 2023 10:16:26 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH 06/10] maple_tree: Wrap the replace operation with an
 inline function.
Message-ID: <20230516141626.4aqzxbmxdxc4d3ll@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230515131757.60035-1-zhangpeng.00@bytedance.com>
 <20230515131757.60035-7-zhangpeng.00@bytedance.com>
 <20230515170722.6eqyckjaggw5wijq@revolver>
 <830328dd-ddb6-bdc5-2d74-35b5212cc569@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <830328dd-ddb6-bdc5-2d74-35b5212cc569@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT2PR01CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::6) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH3PR10MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: 08caa37e-b64a-49f5-2fdf-08db5618240c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w7KD6ArueZkhctwzh0Rtfcdn3adbkA/Yi7nIOKYTwJC8lTTwWeC61TLx/i2chQexFJ845wJngHBDRrTFpli4EJpguoK76DXYN2Db8wrnOMmrVMtiyFzFyznGAvh75xbxl8uC7ISBhmsB5jOYgnBSV4s8y9KH/j2+I8x1mi8F6QfqFKQX28xjJVP1Ka8B60Fzw7R2tJmfdAHrMjrCh1vxhLRr/VDv+S4qgMk2MrvdcjoezaCSU7l04SoW+HZbg5c2cEhebFKgEkCUI8eNjL4rBgMBBX3rFkzravuRKmGsdCAie1rjb3Ysv0oYVZnbokwFJ0FydgiwYjstxBSHXJzxNfvshpjiLe7CqoXdu4lCqRsqa66vQ4ptLmepl7Ko6T3hRHhJwN89yQ/PFx+UrrTKLpCoNjDMPfZWBRLBiclhYSTKVaOqTxXjUUK7Bep4smHHRm/G+Q42BzfL5yrkfu0bOzjedm4vxvx+lSWWsuYdpFBlvnkj9NzSQt8JEaPP0KWffudrOCwxXm9u4akdKpwfn6fMuPS8w34IUzMlQB6B3RBY1Zv5m7mkWN1r1mLss5s0UqhVsWN/au0cbz9X9K5MZg95QM89jNqp5h4506drt0Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199021)(5660300002)(8676002)(8936002)(86362001)(83380400001)(26005)(33716001)(6506007)(1076003)(9686003)(6512007)(38100700002)(186003)(478600001)(6486002)(41300700001)(316002)(66946007)(66476007)(66556008)(4326008)(6916009)(2906002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1YzYWFjdVArN2JLZVhvdG5rWmJHVlN3LzhDOCtlZ0R4NG5xZGhzWS9BcFBo?=
 =?utf-8?B?WFBGRG9FWUlDblNPSm5QcTllMTdsR0wybHlJbC9ETFZHN2pCL1hKSlh0eS83?=
 =?utf-8?B?Z2dJNnlaRmZtcUdWamRBdlJlOUF4UGlrM1pFcU8wSjlqYzZTaEFDRCsvSWJB?=
 =?utf-8?B?TExIUWpCeFk3YnZpbXNvVlV3Yzg3NlB0V0R0U3BnRWM5bVBEQzJadU00aTQ1?=
 =?utf-8?B?eGpKdnBwK2UzalZzdm5JN04ySThUVW9VUklkMzdUWDFNQjdsdmwzaFpaVFBZ?=
 =?utf-8?B?N3czWm53bC80V2MrQmRYbVRrR29jTC9ObG5EUGxzZUdlZHc0VE0zb09tNmow?=
 =?utf-8?B?Q0lNaC9KQnd2WnhjT3JRS3Q4bkNjYTFhVEx4UE4vYUdFNzdTZ1BuRnVJQmFS?=
 =?utf-8?B?aFg1TXp3akR5UERIUnIrNmRuL3pCVjFCNFh6RnpiSEVsWnhBbVRrY0g5WUQ1?=
 =?utf-8?B?eldYR0NBV2ZxRkl4dXdNbWFaL3VQUnFLTVFTU0txakxhSDJpa3FLN3M4bEJ1?=
 =?utf-8?B?a0d6UStab3dvM2ZaSVNWam9IOTRsVjJUS1ZxY1JrU1RRbFlLTkZWYTlDMURL?=
 =?utf-8?B?U0JqbU9aVjNNcVNvRFdRWXRxTm5yc3FzdmpWU2paOVFqci9LdklwZ0JpR1hn?=
 =?utf-8?B?RXB2bWMrNlc0WEtGbjNjaERuTFZoaFNxYytIV2p4TkpRMGNKRU9RcWQ4OFJt?=
 =?utf-8?B?ZUVBUkhleDMwc0V4V3h5R2FXMzZBMU45Z3hxSGpIN0I0VEZ2YVRndFpIVGQ1?=
 =?utf-8?B?dTZ5cDVHeWl1R005Rk02WXlSMXdxcTBZTjd3Wkw4OHZlOHM5OTRHSS9IYVpw?=
 =?utf-8?B?Wm00WloyeXRPN2V1dmFQaHVuTUlYSGwyZFd1NWtITThIRnZTU0twN0ZGNlZZ?=
 =?utf-8?B?Z0FuRWpQYU01eEsrOERlNk5tN005ZWU3cmRjeDZKMWVrSGNaMHdCZ0FWZDYx?=
 =?utf-8?B?dkk3L2gvcHVsak8zb3lZTGp4cW5mLzhkU2g5cUY3UHkyMWhvKzhEQWJ6dlhF?=
 =?utf-8?B?b0pMMFJGVmZLT1hBR2IzUlh1ZWlzRXg3UTd6RnNyQU9WcnRKUkM2OG1EQ1NQ?=
 =?utf-8?B?aDZSM1VHSEVveGF4NHc5cWsvejVxU0ZIWjNVRlpJRWZpOGZGcFp4NU8yTDZo?=
 =?utf-8?B?NmVxTmliUkxtV1NISnVHd09KVzNFdVRLem8xL0loYzdtVjJrZTRFUm9uaUJX?=
 =?utf-8?B?NUFNdjFXVEhQTkM0WVcvQWFDSmZNVkNmczQ0R1ZDNnh0bk1MV204TFNzU1Yw?=
 =?utf-8?B?clZJWFRCZHNCd2VoMEVzUTN0SUxiNm1VQUY1eW1Ca0lQYTdFSE9ZMzAzV2Vn?=
 =?utf-8?B?VHZDUlB4SU10aGNpZjJtcG9HdGhNcVg1Wmd5eDN0dW9XbkpheHJiMGZjT0dL?=
 =?utf-8?B?OWVtbkI1M1pzV25LSGtCNjhMWi8zSmpMcEE1b1BWLzhCZTJuTkNPMkNYd3c3?=
 =?utf-8?B?alh6UUI2ekVFakthVXFNVFpYZmswMDdNcWtrNHdXNG5tbHdIZWZaR2tMbzZ5?=
 =?utf-8?B?LzkrOVNQUEpYMzVaVVd0amRuVUEyZTV4T0xCTWQ5Qm5VTThFQmhIb0x4NmxI?=
 =?utf-8?B?a2xBWWtwNkJaSE5seDVhNnhERDZPZ0pLNFAwM1doVEtYME9lOW5GbGdNNVFX?=
 =?utf-8?B?Mit6d0VQdVhWY3NRUDJnYVF2Rk1ibmZaUEZuaGMzdGhUWW9oVkxCVkVHVHZm?=
 =?utf-8?B?ZXdBYUJXbVpQeWZRMTEzYi9SODFGZTYrd2szdk1HS0w4d2pBK0NrL2lGL1Zl?=
 =?utf-8?B?ZHA4VW9aV2Jua2VUQWQzc0d3eFhxQ0tkY1N6cXQ5UEZsazZEVmMvdmVtUmN2?=
 =?utf-8?B?UXFVaGYwRkRVcFpxb05xWkg5NjV1WTB3Qy9jVldUS0dJcnhnN1cxVUd1eGFD?=
 =?utf-8?B?SFZwRUM5YkFZS0F1cC83aUVsaGhvUTFvbUxrdTBwVFZmU0YwZWgyYnR2RkNH?=
 =?utf-8?B?bEQxYjMvckd3TUNaL084czFFd2pEem1PZ2REZjlhQjh0OGFpeXR4WmZjYVps?=
 =?utf-8?B?a3FYWHdoMXp5cy9CWFlEMlQybFhRMHBFYW1La0tPK092U1g5R0VVUHRhZzIx?=
 =?utf-8?B?YlJBM0IyTGYvQy9NaUtVSGl3bE56R3lyZzhZS21aVDloVm9uczVJL3ZCaHVx?=
 =?utf-8?B?MldYelRFUHQ1eWNDZldtWDVKK2N4UERLZEp6SlNvM09JQm8vV0x3SEdnZkNL?=
 =?utf-8?B?ekE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?N3FOZmVQaUNvOXZBU05pTFJxUS8wRG5ZK3dVbjB3UnJhc09HaFdzdURQRVFH?=
 =?utf-8?B?WVE3NkZSaWNZRlB6alpyWE53SGk1Nm9BMTJZWi9oTWVZdHhmSXA2N0dON1dh?=
 =?utf-8?B?S2VIUmdmTEhLTkdMc3gxdjRINlh6VlMxMmRpeVk2WHg2RmFtV0FJd2dMZkR0?=
 =?utf-8?B?Z2pTWmhUdktuTFpWeG1wNG5Ob0RWZEcrdGtHQXNkYVVIYlc2M2dtbUVjeFhC?=
 =?utf-8?B?YzhvZXpXK0xkOG1tUEF6WmpPU1JOaFMxazFqeHQ3WFNDWVhnQmwrUjhIYXpC?=
 =?utf-8?B?ZmtCRkRxeDhiOVNRUllTajBSR1RGK2p6VWZ1bmtmV3VDWU02NG1hbHcyV0U5?=
 =?utf-8?B?aHhZSVdQZWEyc0ZKZHg5N0F0OHdCVDVjVGZYajJ4WmhwZFhwcHcrMVEySEV2?=
 =?utf-8?B?NHZCVkV2S0xQdnppVVVocE54SGh3RjdjN3NtN3RkTzVRek9neFFjRXJ0TVVu?=
 =?utf-8?B?TWhMQ2xIRHhhOGVVd1pBTDZJRjBmN0kxOTRKTjFmZXJhTmE3NkR5eXJJd1dy?=
 =?utf-8?B?enBNMmI2NW9CVGNtRUQxVmtXUkJIUzlDbjkweUF0RnlvTGxoR3JPQzNXSms5?=
 =?utf-8?B?Wkg2TzdRN1dOUzlTOUw0U3FvZDI4REZGWHo4UWVrWnU1eUkzYmVITk56VExG?=
 =?utf-8?B?UVlNakxsZ1lvMmkwc3hXNFZmNU1ZWktNbHRWdU9yalMxZWFwZFRaVGJxT0ky?=
 =?utf-8?B?TGoxRnh4dFl2b1FBZW94UEpsZFdVTVBva1p1dUQ0aGtMSzVUaXZIWmpVV0Vm?=
 =?utf-8?B?czI5MVRCWUpNTTFjZ2VHRFl4MzY3aWV3WCs2VW4zbWlwVll5blRJZ1d4Z0hJ?=
 =?utf-8?B?MDlJTFdDOFc1cnZNaUNid0cyaVVzazBQdWRNcVdGTEhGK005RDZpNGF1a0xP?=
 =?utf-8?B?ZERyS2VMMXJiZmpvbXpxRmdya3lOQ2x5ejVRY2ttSm9kV2Y3R2R6dEtmQXJE?=
 =?utf-8?B?ME1HZzNHMUJHMkMxSVZWQjV3L2xkZERQc2dUdVVMalIzUzQrMGVtQVBrZzFh?=
 =?utf-8?B?OE00THVabVR4TnRaTG5Rd1ZJb1ZDWXpxZGtGSHB0UlpNUWhZSC9Uc3lIakNw?=
 =?utf-8?B?SStkcWFiV0M1SkUzWWRtdFlHV1BNdlZQblM3L01kUVFMMVBiYWZPSmFqQ2dV?=
 =?utf-8?B?cERhUVp2YkN5djJRSkxpRXJhV2NWMjJmT08wamZ1dER0MFJhQUd6emN6NTNv?=
 =?utf-8?B?WmxDaDVuekNhbkxSSUNJUE9jaFQvWXQ3WFgySTBMWFB2Zi9QaW5qMDF2RmtV?=
 =?utf-8?Q?ZvwF6c6rze+OL/s?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08caa37e-b64a-49f5-2fdf-08db5618240c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 14:16:28.8500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7opfyx//NoiJLiOK/9dGuOjrfDvrYxyRUowwBeB7vRp8yOYITL1IFiPYgoa9b6iRMnqxopfjVv4+KvSQsEIMwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7233
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_07,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305160120
X-Proofpoint-ORIG-GUID: D4I61_0EqBdJajcoAfw45t3Wxv-H42WR
X-Proofpoint-GUID: D4I61_0EqBdJajcoAfw45t3Wxv-H42WR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230515 20:46]:
>=20
>=20
> =E5=9C=A8 2023/5/16 01:07, Liam R. Howlett =E5=86=99=E9=81=93:
> > * Peng Zhang <zhangpeng.00@bytedance.com> [230515 09:18]:
> > > To make mas_wr_modify() cleaner, wrap the replace operation with an
> > > inline function.
> >=20
> > mas_wr_modify() is already pretty small.  Is there any reason you want
> > this in its own function besides it looking cleaner?
> I just want to make the four fast paths in mas_wr_modify()
> look uniform without any functional effect.

I'd like to keep it the way it is. I think the comment stating what is
going on is clear enough and mas_wr_modify() isn't too big.

> >=20
> > >=20
> > > Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> > > ---
> > >   lib/maple_tree.c | 21 +++++++++++++++------
> > >   1 file changed, 15 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > > index 4c649d75a4923..ce695adc670ec 100644
> > > --- a/lib/maple_tree.c
> > > +++ b/lib/maple_tree.c
> > > @@ -4288,6 +4288,19 @@ static inline void mas_wr_extend_null(struct m=
a_wr_state *wr_mas)
> > >   	}
> > >   }
> > > +static inline bool mas_wr_replace(struct ma_wr_state *wr_mas)
> > > +{
> > > +	struct ma_state *mas =3D wr_mas->mas;
> > > +
> > > +	if (wr_mas->r_min =3D=3D mas->index && wr_mas->r_max =3D=3D mas->la=
st) {
> > > +		rcu_assign_pointer(wr_mas->slots[mas->offset], wr_mas->entry);
> > > +		if (!!wr_mas->entry ^ !!wr_mas->content)
> > > +			mas_update_gap(mas);
> > > +		return true;
> > > +	}
> > > +	return false;
> > > +}
> > > +
> > >   static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
> > >   {
> > >   	unsigned char end =3D wr_mas->node_end;
> > > @@ -4347,13 +4360,9 @@ static inline void mas_wr_modify(struct ma_wr_=
state *wr_mas)
> > >   	unsigned char node_size;
> > >   	struct ma_state *mas =3D wr_mas->mas;
> > > -	/* Direct replacement */
> > > -	if (wr_mas->r_min =3D=3D mas->index && wr_mas->r_max =3D=3D mas->la=
st) {
> > > -		rcu_assign_pointer(wr_mas->slots[mas->offset], wr_mas->entry);
> > > -		if (!!wr_mas->entry ^ !!wr_mas->content)
> > > -			mas_update_gap(mas);
> > > +	/* Attempt to direct replace */
> > > +	if (mas_wr_replace(wr_mas))
> > >   		return;
> > > -	}
> > >   	/* Attempt to append */
> > >   	node_slots =3D mt_slots[wr_mas->type];
> > > --=20
> > > 2.20.1
> > >=20
