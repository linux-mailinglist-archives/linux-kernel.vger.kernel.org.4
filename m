Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2978629D15
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbiKOPQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiKOPQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:16:04 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871B827FC5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:16:03 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AFDuVAK022483;
        Tue, 15 Nov 2022 15:15:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=1/vGzofdEFnzN3S5ulw5ztUM0Gh4g11ZLLOup79gDII=;
 b=fVg4yLabyu184P4SSuLeBgsop/MZGVeTumwF5CqbnEywj2YJWJ/X+qLDMWV+5xJ1L5Ok
 UKW0Q1+hbQ2Zp1nWD56a6DcFlWdxkdzWLYLi7DxK0TdtAxE+jcqC0rdwwAfOiIQqBbRw
 9Xs67DNsbrPGg5qHpZPFQ2sgEcCtAjEOs9UCarx1cywkFV5j7KVC0ogUtm8CmTgIAmsM
 LJy9R8ehqaGB2HKCG/W0UhJcFpj4GOJ19vTK/JrIvK4t26qGdzMTMDh+0jsamuTwiPGi
 WJabeNlnufD600fetR/HXIw2U+Adn8fuDdeQQZENApZ+yaAHf6e/+m1iqpcNzteU7tma +w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3ns1py2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Nov 2022 15:15:09 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AFE5a9d034895;
        Tue, 15 Nov 2022 15:15:03 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1x5w124-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Nov 2022 15:15:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4Q+i9j9piZgwWrMy/mayf3DIiT70O9FM9LkTYFWBw4LSg+ieIBtOBQanRFt++lnZRaXNBU+iWH+frSQJEvNeu/vP1Et6NGhe0yllz/8YVrBYrg7/uniJHBLzivuU+VIiNP9ywZuTDLbs9KNTbYPkODXg9NWkCLikjEiH+e+h6TcJp54zyEn9M5IllQR2+HByyJbVWxNSEjmmOLDYVSKQ+vLP5CKMDQmNmLa+2zOZF1lCz0DwVKszAuvx+/cOewWkUJcGv6c9jvfceTpUXqNcEixrtit7pau1KTDyUosb1dPLT4PIZHytTvdqfbcwavqzI+yyAeWTMnjKnGpp6YBvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/vGzofdEFnzN3S5ulw5ztUM0Gh4g11ZLLOup79gDII=;
 b=UjFvRAEM6cw7VQe8EcBCWnrh7haHmUG9bhKJaIMHAbGDFI+TcRIK5p4Pjx+b5WUIIwlcTRB5iG/VZ18cvDJ6zbm6IcXBpqKOCg2SpoEfXW4GakPw/0BEguNWihhZTqu9O/4ddtnrmMir5gaJkmZqZ8c42bEd9vRlIoeAk9riXs9vEeHJs+BgXlWXIkh2aWo2GOKnX523BsKFyElvi2UXjsjkZ+U8ndAV2QlAXZ/cKuJJdP6OuBz64/EDvIq0qjUVlCX0R/WDEOcqb+dYbxfrxkVDTCX9dN5Ku4EOFqHJ1Fgx58Z7YPwuBf1HcSBV9F4A1W+6QMshwBcL0snFbs0Pew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/vGzofdEFnzN3S5ulw5ztUM0Gh4g11ZLLOup79gDII=;
 b=A7oyMY4eJAUxdaZbYLP0abuj0Sa0RWNNRwEdwiwoOrQS/Bo/QJ+lIS+K2sZNlrc9Oema+IzFRK5MkqQGO5SoDX5ZDm7vdO7qKYKhU9lO+NjYl6UHvcmkU26Siwwq38Rlht2aU6P2hfCy+9nvXPxkiNKgLJcvRSExKftjM9/iOEk=
Received: from PH0PR10MB5895.namprd10.prod.outlook.com (2603:10b6:510:14c::22)
 by PH7PR10MB6674.namprd10.prod.outlook.com (2603:10b6:510:20c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 15:15:01 +0000
Received: from PH0PR10MB5895.namprd10.prod.outlook.com
 ([fe80::5900:4c18:5b47:6a9e]) by PH0PR10MB5895.namprd10.prod.outlook.com
 ([fe80::5900:4c18:5b47:6a9e%3]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 15:15:01 +0000
Message-ID: <ae901608-0580-010a-26e3-99d0b704b88b@oracle.com>
Date:   Tue, 15 Nov 2022 10:14:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-US
From:   George Kennedy <george.kennedy@oracle.com>
Subject: [PATCH] ubi: ensure that VID header offset + VID header size <=
 alloc, size
To:     richard@nod.at, miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     eorge.kennedy@oracle.com, linux-mtd@lists.infradead.org,
        syzkaller@googlegroups.com, linux-kernel@vger.kernel.org,
        harshit.m.mogalapalli@oracle.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0077.namprd07.prod.outlook.com
 (2603:10b6:5:337::10) To PH0PR10MB5895.namprd10.prod.outlook.com
 (2603:10b6:510:14c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5895:EE_|PH7PR10MB6674:EE_
X-MS-Office365-Filtering-Correlation-Id: c5f33908-7ddf-4912-6223-08dac71c2978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bt+lX+P69IsNO8TmSzLh9rThRZA8iWbi6jmMP94A2xubGju1qMvHEAOZjZVBnwzt9/ORUkcnLKvjoFPLq2T+5GBi8xHf0vqHkpUKkN/xivaZtVcKEvt4msSIIth8+DnzTNQKVESOGgPcfLABduecBpaEwtA9wE+xwX0mYqD9Fhwz3dno14+xpDYUtKbjBBmIqQS8Yq6e5CoDg5ldXlh9eXvbUOtODhP6WWxm71F82LKCPWHmHX+27KQDzv3wCwMBDtDcfTZnkdCuwZxvrk9IEH0BMq3kP8QopwXcwHGpo+8E/X8wRLjctcVx3ii865HIpgbJiLbGe039yfpdvIxzH7hoY2CMWr+jytgxFGheWf8TxDn9c65a0D5sXB3YGZRyUSEvsBba9UGMQkdNcleoBes8UBJO8F2UMGQzADQZgAaZYT9SiCKAEDMqEITV0sp9zHZFZ2OQvS33qb4r/I2NiC3k96mrsX94cPKQGfNVswUbWlCwz358W8wBGwfFRge6f4e2oeHxPohuoqXodsk0gpwJvbKohLswqAtuZtjLtX90R3NGLJwaGEhbzTI/nUkmPJvwx6BFRcayq34pBT2xxQT5WlhYn4O9RXrUxAaizDKwIc5nmMdEkPEEZgDJfr71/2dbZ55DfejGgBE2TOLm0AJBFfN8mdAKEE7OyS8g5Pcp7OSz32fUaDaqrhU7aWI/D6sOs/+oZQpdUNrdbg6dfLcR1cKVE8/ptmkcByGWaEuyWxr2f4Tkri7oEQLCxQaACkczv0Uwml4jcsGAlzLTR8KPVDgWcDaHFEyIHSNGVEvwx4KNInmD//HLdeE3Tay9SCVjfSdi4GedRmAmaKYudQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5895.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199015)(316002)(6506007)(36756003)(2906002)(26005)(83380400001)(41300700001)(2616005)(8936002)(44832011)(6512007)(66556008)(4326008)(66476007)(8676002)(66946007)(31686004)(5660300002)(186003)(478600001)(6486002)(107886003)(86362001)(38100700002)(31696002)(6666004)(45980500001)(43740500002)(505234007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDIxemhSUnZiS05YV3k4NmQ0dmgxZEhKeHZiMjlzRmFwOTIwamtWUjZITENr?=
 =?utf-8?B?NkNodnF4V2R6OUxiRmVHRkdxQ2dzODNpZEQ5VlNUWittZTR3b1BNQTdlRWln?=
 =?utf-8?B?OHpheVIwL3Z2OUFhZHpXdElSQVdzY3NlSGU1T2ViNXF4SGxPUG03dHVKcEdt?=
 =?utf-8?B?ODlkb0Z1ejZES1h1L2JrSWdjbWw4RWh4VTYrY2Q2YThib1pxdldteS94NTB5?=
 =?utf-8?B?WHorOGJ2OFh1TWhtWDZCNG80SHl6STVnTlp5UDQvQnhyenh1SDdwYVB1c2pD?=
 =?utf-8?B?eHNOSjFja25VUFVtUnArU3UwaWVyU3FGZVAwdDVnaFRnSysrME1kZms5bTBZ?=
 =?utf-8?B?WjNMUkE4S3Z5M1EvRHo4M3RtTU5aV2EzSTEwSVlkQytjYldQcjVyT1V5R2Vl?=
 =?utf-8?B?K2F0RlRyREN0dDUwNFNucytYVDU3ZkNSeFQvdCtzUnBrTDh2K242K0lSckVH?=
 =?utf-8?B?R0YvRDZaam5PWDlQZ3JiditUS09nNHJKbWVpTWl1Wnp3NVZya2J5eUJCQ3F3?=
 =?utf-8?B?YTIyTlI2MGh6WVN6UlpUTXJUV1IyU0tVWjRSRU5QdkFYaHFtaTBMdHR2MTBR?=
 =?utf-8?B?RFpHSGRSaWdnZUU4RlZuaEdwd2J5VTkvTSs0eEFueUVoZXJRU1FLOTBlUUVX?=
 =?utf-8?B?Vk9yRDBncHZZaU00NjZoSnMxdURidm5JVWdiNTluN0h5WUpLSU5yeHpMZWds?=
 =?utf-8?B?VTdPSnVSNzFiN1lOYi8rVmtLNHNwMnoxWUtQbUlLNnJTK293bXdvYWZaRXpG?=
 =?utf-8?B?MlVuTGUzK2IvU0dpdXppVjB3WCtna3o2TFdFQjd2cGp2TjFsTURUV2s0cGVi?=
 =?utf-8?B?VzhCaXlvaS95UmJvT2Z6NTRvUG5MZitGQ211aVB5eTc2SHJ4WVE2K0NEdTYy?=
 =?utf-8?B?WUl3K3BGYzN2RXdyaERYMTJYK2JDZVBQMUN1bXFCUElXTkkwSHRWUk42MDFm?=
 =?utf-8?B?bXlFQlFBcG8yNllVV0l0QXo4YU5XQTkwdkVoQWozdE1kekxCT201SmZvenlC?=
 =?utf-8?B?K3JNbW9Obk1hL1FzVktGQ3NJY3IrV0sxZGlyZU9mdVdvR2NoSjlMTTR3V1BZ?=
 =?utf-8?B?dHFNN2ttbjV1Vzc0OHV4aW9ZKzZBS2szeUYwMloyTWJ3SmtkS2lHOThjOVMr?=
 =?utf-8?B?cEhtN1Naa29rMlhPeEJIUkkxQTBreVZKS3hJUzc5bVdWQjZkZzB3RGt3TUZX?=
 =?utf-8?B?ZkYzWXJNR2RrejZma0JrUExYVDdyK1ZNVVNJaHJIUEQ3dkFKZ3g1OWNGRVdn?=
 =?utf-8?B?djhIMFBEL2F2RzNKRSszb2Zyek9weXZQNWJSZUR4WlJPdU90WFNpOGNiaTNx?=
 =?utf-8?B?ZE9MNkpobW9BSnJ0V2VwQjNLV0V1cVlpdTVZYXJQTmxlcm1PeHVtVTV6M2lP?=
 =?utf-8?B?dG02NE5vNmVzbWVvUy96ak1TZU5HdWEyZlhWYkdaWjVtcHg0Z0VsZk1zcVB6?=
 =?utf-8?B?ZFRCdk5CTE1TTmJ3MzBaSkw2QW1SVkRXcFdpcmVHS0Nza3h6SlU1Qk85Rmln?=
 =?utf-8?B?RnRDbExydURaL2NWVElHcGhnWTlKTDNDU1NWOWhNekJYNjRJQ0pTeURNbXVT?=
 =?utf-8?B?b3dvUVRuR3U0SHhibWFmeGMyN3NmdEl5RU5KUmZycDYrRmhFaURzem0xWDFJ?=
 =?utf-8?B?djlGWDVpcitMZkhmOW1WSVFjTG9Zc25qMDJyU0FQcU5NSHN3cnBVNy9BOGUx?=
 =?utf-8?B?QTcxUkF1VEttVGhNSXd6UUFKS3l6NG1nc0IvZFVKMFVjcXlUc1lPK090T3Nh?=
 =?utf-8?B?SHBTVW5uRGJ0UkNjTk5CcThYQVBLRFN5TG9xVDQyU1E1dytwaFRXRVg0NXJ2?=
 =?utf-8?B?SWdtNGxYNmMvOUcyV3BKV2ZZYlJ2a3VwY3hXaDJESUM4MjZ1ZnBvSnN5M2Nh?=
 =?utf-8?B?L0E2OGo1dGtZVmhXbkhIR0dUbENScWdxYlgvb1pQeU9UV1BUWXF6dmJ5MDVa?=
 =?utf-8?B?eTlHYlYra25IUDl4Vy8xeWlJWVNzVm0yN0xVdnZhUUZOTUZaWk5HM3JjM1Zo?=
 =?utf-8?B?RERRYm1WbEU1MDRsNFRWZEx6RlNZNDBFb1lTc29PZ3JCcThDdFBRTGxrUE1P?=
 =?utf-8?B?RmZsemxrK1RqODZ5WThZSUtTYjdGOUxuNlpaTmdJbHc5eUNObFFKMWVHT005?=
 =?utf-8?B?Wm9jdkZ2VThpb0F4RHZjZDhMVG1IOEVLWG9hTlgyMVBONWUwbWt4ZnI4WElV?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WW03VG43eEZQWkx3ZWxxVXRLUmp1YXR6SU5DbTNZaEVWd2RqMjJPRGVET2VG?=
 =?utf-8?B?NlVPTzZSSTY4T2ZUTFdWQkp2WjhndDgwYzcrRUlqZStDUGlWTDhDZ2NRM0hV?=
 =?utf-8?B?MVIwL1FLUGNYbGhiaTlQZERLZndlL3dKWjFQZUVjc2d5dmUzejFjbEU3UWs4?=
 =?utf-8?B?U0NiN2FXM3d1bm5tc1Z2UEwrYXY1QXNQU2NueVpkRGFvbFI5RC92ZVUxSzlI?=
 =?utf-8?B?ZXNFR2paeXU0YzcvUHJNeVZxWlZhWTZUZGN5dmIxbVZ0djY1bnEwZUlLR3RP?=
 =?utf-8?B?Qnlqd1pxYW9SRm5wazFnczJWL0JUQ0FYNEZSUnUwVzU2RFdjQ0R2RHNJSm5B?=
 =?utf-8?B?SDJSdFpKT2czanBZaTdTSDF4VEZVVmFpWGxwdGx6UG5STDBFNnNjNDVIWlZo?=
 =?utf-8?B?ZDB4clRIeUgrT0JGUlZwTXMrZXlhdm1DZDQvZGZENHdrWmtnN2tLOUFqZ1NQ?=
 =?utf-8?B?c1drNHBwaEl3Z3h2WE1vRlNDdGVvaVFtRllVME5mQXZqeXY5R1kwOUh4bk11?=
 =?utf-8?B?bDVZR1lPUlcrWlpyTDBxUkkwZ0V4WWRpeWtNVWVNY2M1bDNqckcxVlZMbml2?=
 =?utf-8?B?a2JQVVFxQ1JtSEVpNE1MY2dhcHFyc2ZTM0dUd21zK3dyMVNpWFhtQ3QzWWh0?=
 =?utf-8?B?a0E5aWJPa1RJYlh3Mk5PWE1wVFkraHJwdDl0MTQ3VjN6RzhoT05IYWt1Wi8w?=
 =?utf-8?B?TEx3cHBOeVBrM0VPRWI4RVZiWDkzRDdhNDJYUXJQTjluaWU1Qi9ia1JyUllh?=
 =?utf-8?B?RFBVNmJmNHQ4Z29xblVsSFkwNXloS3FaNVdzaktyK3N2ampjdmlScEszaTd6?=
 =?utf-8?B?UjVuZTlJZDhEN1dJdEE4d3FncGR0akxoUDNIc2RTUEx2d05JNVU1RUd0KzlM?=
 =?utf-8?B?M3ZMdGt4ekJpQzJ2UUc5YmxEdWNBUTRRc29MenVvckRmMmVlSjRTaUFTNU1Y?=
 =?utf-8?B?bDVHYmVQWE1vT0k3aWM1bHpkUkVJUjdzR1FTYkYwS2pjUkZicWZLeU1xWlY2?=
 =?utf-8?B?S2doWUdBallMMXlIalNZK0g4ekNwaktKRTBvdEMwTXczbTVldWNZeHd0ZFlq?=
 =?utf-8?B?WEZ5cU51OG1NSlVoeThVSHhWZ2dXL1BseFJFdkc2MGhKNFBzdFNBMHpUOUhE?=
 =?utf-8?B?VjQxV2lhdjBkeWoxOUNnbVAwTE55Mm9WS3ZBYVM5bmd5MmpDQjEzQ1g5bGlk?=
 =?utf-8?B?ZnE1QlBOZUhVZllVOXVDWXJCejNyMUdmTHUxOTA0dytmK2Q4MFRXY1FGZC9W?=
 =?utf-8?Q?T2EJEOy12+MgSKa?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f33908-7ddf-4912-6223-08dac71c2978
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5895.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 15:15:01.0269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t6JxC58OvIyJ7bbHg9LEteTwIHOtGAdztwdWQrEsp3w5YgFfr7mL5qIi5bskNii2/FyilNWdls0jRuaiih8vWWvjbhBj+CVkZG8IHUsPmhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6674
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211150102
X-Proofpoint-GUID: 7vqFN_6kCxP146Qf2Zh5UFhplGhylBgK
X-Proofpoint-ORIG-GUID: 7vqFN_6kCxP146Qf2Zh5UFhplGhylBgK
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that the VID header offset + VID header size does not exceed
the allocated area to avoid slab OOB.

BUG: KASAN: slab-out-of-bounds in crc32_body lib/crc32.c:111 [inline]
BUG: KASAN: slab-out-of-bounds in crc32_le_generic lib/crc32.c:179 [inline]
BUG: KASAN: slab-out-of-bounds in crc32_le_base+0x58c/0x626 lib/crc32.c:197
Read of size 4 at addr ffff88802bb36f00 by task syz-executor136/1555

CPU: 2 PID: 1555 Comm: syz-executor136 Tainted: G        W
6.0.0-1868 #1
Hardware name: Red Hat KVM, BIOS 1.13.0-2.module+el8.3.0+7860+a7792d29
04/01/2014
Call Trace:
  <TASK>
  __dump_stack lib/dump_stack.c:88 [inline]
  dump_stack_lvl+0x85/0xad lib/dump_stack.c:106
  print_address_description mm/kasan/report.c:317 [inline]
  print_report.cold.13+0xb6/0x6bb mm/kasan/report.c:433
  kasan_report+0xa7/0x11b mm/kasan/report.c:495
  crc32_body lib/crc32.c:111 [inline]
  crc32_le_generic lib/crc32.c:179 [inline]
  crc32_le_base+0x58c/0x626 lib/crc32.c:197
  ubi_io_write_vid_hdr+0x1b7/0x472 drivers/mtd/ubi/io.c:1067
  create_vtbl+0x4d5/0x9c4 drivers/mtd/ubi/vtbl.c:317
  create_empty_lvol drivers/mtd/ubi/vtbl.c:500 [inline]
  ubi_read_volume_table+0x67b/0x288a drivers/mtd/ubi/vtbl.c:812
  ubi_attach+0xf34/0x1603 drivers/mtd/ubi/attach.c:1601
  ubi_attach_mtd_dev+0x6f3/0x185e drivers/mtd/ubi/build.c:965
  ctrl_cdev_ioctl+0x2db/0x347 drivers/mtd/ubi/cdev.c:1043
  vfs_ioctl fs/ioctl.c:51 [inline]
  __do_sys_ioctl fs/ioctl.c:870 [inline]
  __se_sys_ioctl fs/ioctl.c:856 [inline]
  __x64_sys_ioctl+0x193/0x213 fs/ioctl.c:856
  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
  do_syscall_64+0x3e/0x86 arch/x86/entry/common.c:80
  entry_SYSCALL_64_after_hwframe+0x63/0x0
RIP: 0033:0x7f96d5cf753d
Code:
RSP: 002b:00007fffd72206f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f96d5cf753d
RDX: 0000000020000080 RSI: 0000000040186f40 RDI: 0000000000000003
RBP: 0000000000400cd0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000400be0
R13: 00007fffd72207e0 R14: 0000000000000000 R15: 0000000000000000
  </TASK>

Allocated by task 1555:
  kasan_save_stack+0x20/0x3d mm/kasan/common.c:38
  kasan_set_track mm/kasan/common.c:45 [inline]
  set_alloc_info mm/kasan/common.c:437 [inline]
  ____kasan_kmalloc mm/kasan/common.c:516 [inline]
  __kasan_kmalloc+0x88/0xa3 mm/kasan/common.c:525
  kasan_kmalloc include/linux/kasan.h:234 [inline]
  __kmalloc+0x138/0x257 mm/slub.c:4429
  kmalloc include/linux/slab.h:605 [inline]
  ubi_alloc_vid_buf drivers/mtd/ubi/ubi.h:1093 [inline]
  create_vtbl+0xcc/0x9c4 drivers/mtd/ubi/vtbl.c:295
  create_empty_lvol drivers/mtd/ubi/vtbl.c:500 [inline]
  ubi_read_volume_table+0x67b/0x288a drivers/mtd/ubi/vtbl.c:812
  ubi_attach+0xf34/0x1603 drivers/mtd/ubi/attach.c:1601
  ubi_attach_mtd_dev+0x6f3/0x185e drivers/mtd/ubi/build.c:965
  ctrl_cdev_ioctl+0x2db/0x347 drivers/mtd/ubi/cdev.c:1043
  vfs_ioctl fs/ioctl.c:51 [inline]
  __do_sys_ioctl fs/ioctl.c:870 [inline]
  __se_sys_ioctl fs/ioctl.c:856 [inline]
  __x64_sys_ioctl+0x193/0x213 fs/ioctl.c:856
  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
  do_syscall_64+0x3e/0x86 arch/x86/entry/common.c:80
  entry_SYSCALL_64_after_hwframe+0x63/0x0

The buggy address belongs to the object at ffff88802bb36e00
  which belongs to the cache kmalloc-256 of size 256
The buggy address is located 0 bytes to the right of
  256-byte region [ffff88802bb36e00, ffff88802bb36f00)

The buggy address belongs to the physical page:
page:00000000ea4d1263 refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x2bb36
head:00000000ea4d1263 order:1 compound_mapcount:0 compound_pincount:0
flags: 0xfffffc0010200(slab|head|node=0|zone=1|lastcpupid=0x1fffff)
raw: 000fffffc0010200 ffffea000066c300 dead000000000003 ffff888100042b40
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88802bb36e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff88802bb36e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88802bb36f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                    ^
  ffff88802bb36f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff88802bb37000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

Fixes: 801c135ce73d ("UBI: Unsorted Block Images")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: George Kennedy <george.kennedy@oracle.com>
---
  drivers/mtd/ubi/build.c | 6 ++++++
  1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index a32050fecabf..53aa4de6b963 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -663,6 +663,12 @@ static int io_init(struct ubi_device *ubi, int max_beb_per1024)
  	ubi->ec_hdr_alsize = ALIGN(UBI_EC_HDR_SIZE, ubi->hdrs_min_io_size);
  	ubi->vid_hdr_alsize = ALIGN(UBI_VID_HDR_SIZE, ubi->hdrs_min_io_size);
  
+	if (ubi->vid_hdr_offset && ((ubi->vid_hdr_offset + UBI_VID_HDR_SIZE) >
+	    ubi->vid_hdr_alsize)) {
+		ubi_err(ubi, "VID header offset %d too large.", ubi->vid_hdr_offset);
+		return -EINVAL;
+	}
+
  	dbg_gen("min_io_size      %d", ubi->min_io_size);
  	dbg_gen("max_write_size   %d", ubi->max_write_size);
  	dbg_gen("hdrs_min_io_size %d", ubi->hdrs_min_io_size);
-- 
2.31.1


