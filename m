Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1746C733B3F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 22:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjFPU5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 16:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjFPU5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 16:57:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E49430F1;
        Fri, 16 Jun 2023 13:57:17 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35GCi78P026624;
        Fri, 16 Jun 2023 20:56:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=FVRYkNYp7O2zzPKQAlsWaH5BwcccTNYSaWp65RYt8YI=;
 b=KXlaULBRYzeZwTgPZnkmP4f3q8N1Ss3lH7yhS4RtsIqthtkeJdgiFFNvyy38RsN0MXAQ
 wzI+22Nr3sz4E5BFlrJGWT4l9XsKjTtbn02d7b9UlzTJEbbnW9N15YiLgdJOrz5qbRg7
 0/twnyf7MCyMWcZxZRwIjLX8HLRv/XdxX7c6Fv7wjncy7QrMv1HQ/XKiFcmbXmgyfiPe
 j2am03pyh9qWJ2jkPWs5KhdrT0ZXqez63eX5LHw5eeSMMN0EntA7MjLTDijUHmVrTDLN
 8O7XjjXa5lMmvQrfUus2r2RRTa9iwKMpYx1zS0qKqf0mM/h41bTlz8dkNKApjI43f9ph EQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fy3n2ur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Jun 2023 20:56:35 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35GKFVJX039213;
        Fri, 16 Jun 2023 20:56:34 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm8dx38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Jun 2023 20:56:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHGiqsKlHSogCw7J5fX7nlchzw57BN053ayvmfmTti/mVr0htrj0AaTCk5kL14QhmRvWpBUYRajfGlT5bHUsU/W1RYjh0xJsB2Spr0ivN/jVxmWsxeSRJVw+rGVJPVsMAQcKoBqYOMXBCJt+YWzuLyCoCBWGcZ7ZS6XqYZgql345Yvb83zSOiPWP1jm5bHUgzliyUyE3vtMOMY8K5JgWwmeX9+ykhrjfl38TQ5so5XLSo4ohbT7Ohy7s33jHOIwgCKPD7G+NhKC81b/CNvT1ProS86yuAsMG2PlSa/Y1yupxKs7eYaW6i+Zyfz9teivfPJXYe/YrcVkU7HpgOaRiGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVRYkNYp7O2zzPKQAlsWaH5BwcccTNYSaWp65RYt8YI=;
 b=eDr1H776nRmsBhNREZesJ3rfEG0bAXS7psPBZkkyr++1DpyVCpBgItCcoliOCZdEVJq9EpgP7oZPImHiuNSGhq5WQdjYZym7Na4p2Zv4Pf0bBjjbpMDDMTvB9lOTK6Is/QSuDdN0CP9xlF3M8AKRXvLm7L1xrigTtRuVEjjhdT46Ka7tBtFydo0T2leGF97ioJjSfBDwz9jXxbDLsAdinj2nO8xw3Wm/d14vIg6LhgHRpmj0t3peu8Dcy0Q1L+bF4vTvM06IC16NkNrdDOuFdwRAYV5vG+X1pSHAgTG6zr9qJOJvXAoXCp5nsC80L2qVNCqxTnVKA8i/PiS60oNHLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVRYkNYp7O2zzPKQAlsWaH5BwcccTNYSaWp65RYt8YI=;
 b=rcyXOs8LP4YIgKg+6xMvHdHFreR2nLgfPhnI9aM/kunPhwefu/W4RGhiGDYBjjTn3kVDDD5C95F1DOYLpWa3Cp9tJ7mjnC6yi+EARpwqJjpxp2vZ/7HTowrpQVMDGWFEXAXi/TG7EnKgYAF2oOFduvilFx8xYmR1cPEP+XjIGOs=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH7PR10MB7850.namprd10.prod.outlook.com (2603:10b6:510:30c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Fri, 16 Jun
 2023 20:56:30 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 20:56:30 +0000
Message-ID: <7c2e90c4-6ef0-c1d2-8a0d-655adc265547@oracle.com>
Date:   Fri, 16 Jun 2023 15:56:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v23 4/8] crash: memory and CPU hotplug sysfs attributes
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org, hpa@zytor.com,
        rafael@kernel.org, vgoyal@redhat.com, dyoung@redhat.com,
        lf32.dev@gmail.com, akpm@linux-foundation.org,
        naveen.n.rao@linux.vnet.ibm.com, zohar@linux.ibm.com,
        bhelgaas@google.com, vbabka@suse.cz, tiwai@suse.de,
        seanjc@google.com, linux@weissschuh.net, vschneid@redhat.com,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20230612210712.683175-1-eric.devolder@oracle.com>
 <20230612210712.683175-5-eric.devolder@oracle.com>
 <2023061320-vindicate-usual-6643@gregkh>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <2023061320-vindicate-usual-6643@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0374.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::19) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH7PR10MB7850:EE_
X-MS-Office365-Filtering-Correlation-Id: 211895fd-461f-481f-f7ea-08db6eac28d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qZJ1vSQ9l5/yHGtIGd/o49s5wX982Qk0vVxpgRPGEZph8naKBoJ1StL6ZEt5npq4cb2RFgA4k4zYWOByxUEBIqdQ1oPRf9XHXskT0yW2EZej7u2AXF7fUSoWkaqFCneydBUiZheavgjMP0iDV46sppLYQTfaKbZDy7TFlTLU/Q1zomqQVnZOdy3+oJ/+L/9lnZaSwWNhauLL9uBdPVq3n02Wg9m052z7ibLuwGZalYw02nYpr9g8CNDsutzidoy8R4PTpMzHkaARyvqagJF5vaNa064j78H7EtTlzM8Vc/yzP95jW2jfmeRoB6kMA7QJyCviyBvavB895un3m8IPkiqL+Dw3ADr//5iEx3H1aE2jY7Dim5st4rNhcgziVLCutxjjx8aN3nDBLMt2P32g3o+062hS1EYJmXH1x/Ot5OK3Ja1YlTy2PYWobLh/O7YikhLNXd10SFurmfmZz4drTs/Rqinvv4m7euP1blXkS8FIjfS1BxgGCxodAS7B6doFIby9hCtiRt2T6rODnC74fxrlrLluD/oNN3kfKcCtBYqOTeGxvdKViq+4S5rn4t/ps9/monoFmsiainG9r42p/GvepUlaixhnF16xLITq7t+9dFOrjB0VVXeuyKWpuO14AdPHLrnIzVmKyt2nJWcGxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199021)(36756003)(38100700002)(86362001)(478600001)(8676002)(8936002)(41300700001)(6486002)(31686004)(4326008)(31696002)(6666004)(316002)(107886003)(5660300002)(7416002)(7406005)(53546011)(6506007)(6512007)(186003)(30864003)(26005)(2906002)(2616005)(66476007)(66946007)(66556008)(6916009)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGhja2JNb3lSY3ovNCsrQllVb0lRZmo5dU1ieU1mdm90blZlanZpOXBnTmNn?=
 =?utf-8?B?L3Nld0RIYkRwckJ6Zm5tOVgxc3NUbTlXRFJrSTJoR2NHSWdEbkQrUlhoZmlq?=
 =?utf-8?B?V0hlcHN2U3dRQnI1QllvZWxOWUFhNjEzdkx0M0ZqN1owMmVIbEh6QnRuTzRD?=
 =?utf-8?B?RTZ2RmtnRlpiVEE0VzRIYXo2M0NTWXRWN3hzTk1CNGRFVTlVenVNWi9mQWg5?=
 =?utf-8?B?SUc2Z3NaQ0lieGJISk0vbi9UaXdJMFZ4NTBsa2dkQS9uN3FMaURkUHdqMXFK?=
 =?utf-8?B?d3ZnQWZLM0M3cU1tWWovS1lJREpyeVdYa0pCN0Nwa1l6RnZwRWkyYlpjbHVh?=
 =?utf-8?B?eWh4UjB3TXBwV1JBK0svYlJqclhzWlRnQmIyeVExWm5Bdng1VUxKanJncnRi?=
 =?utf-8?B?TkZLYzNwWUFKckVwY0VMMjBkNDhjRWlJSE5VcXVzWm85eFdvM3k2R21XR1M1?=
 =?utf-8?B?dTFneWN2aGJGOVFuSktvd0RDSS9pMzlXclgyb1FaZDE3aEZ0T29jZGZiVGVM?=
 =?utf-8?B?OVdSNjFXSUVkc0s4NldzekcreTR0NUFwV3dPUnBKcjEzblZkMnVsSjFjbjcz?=
 =?utf-8?B?TTdQeFN6dkE4UElQZzIzYjZDWWc2OXNIeDEraEhCS1FNazZoNDdxWkJKRlN3?=
 =?utf-8?B?UmlyRXhLNWtCZDQ3cTg3TDNRY1V4eks1MFhKMWJ6MzRzZkZZVmxNY1A4ajdt?=
 =?utf-8?B?SjRXeUZ1L0UzNmczSjMzSXFPaVZDZlB1akVNZElKSWorRFpmRVFES1dnL2dN?=
 =?utf-8?B?T3o1ZUlWbE1ZZk5CKzZqV1lpYy8zK2o5cUJRL1RNSGdFNUNkeDhWWjAzTmgz?=
 =?utf-8?B?eEN2NHJIRWhwZjBDK2UxMzhTeDZ1ZE1JZFVQTnBLeDRBOTlrWE5TODdhaEJN?=
 =?utf-8?B?VGhDQklNc1J4eEtlTUc4TlJZYjdiM21UQWFFaGpMaVhQOTJ3eE53cldLaFd2?=
 =?utf-8?B?TUg1ZUJ6ZllMdFF2d3lzUXdGUTJCN29pV0lmTEVzRCtraEFzL0FqQWMzallO?=
 =?utf-8?B?dWZ4Sk1PdExDWmFuMzloU1pjbHI5Q1VoM3pmN2YrUnF5V0NMeCtKSGp2OHpL?=
 =?utf-8?B?dkJwRno2UVdaUExoQllIS2c1YmtweDl4aEJFU2M3Tkt5OFVEUlNvbE56NHlI?=
 =?utf-8?B?K0pUUUdlYTBWU2ZkcHhGemF6cytzK3BWR0gweFRVTlZWU2NFZi9aRjh6ZjZN?=
 =?utf-8?B?VEVBL0R6NSsrODZ1OGpISEpVeXRObkdaVnI4a0p3NUVBT2xmeEd2NTJUUXdM?=
 =?utf-8?B?bWVmZGM4cUpKZXB5QzVac0RVYy9WWDBEMFdYOHJHV09nNUlNQjMrSCtCcFFw?=
 =?utf-8?B?WkVlWnF6YnFFOCtRaHlFTkYvQ2I5bFBKd08yQkU1OFpnZjZRUjllZmt6Qjg5?=
 =?utf-8?B?TzNZY2t6c3JiVGpLZWxKcUo1WjNZUjlIQUd0V2NpNDdsZEFXdnJVUm94ZWxW?=
 =?utf-8?B?WXhJaU5vc09QdDdFb25qaXdpNXg0WXpEQ3RZVHkwUDFYS2pqcDV5TjJPR3Bn?=
 =?utf-8?B?NmxUSE4zK3YyVHROOE1PUTVBWDNwQXB2Y3I2L2JQRTBQeXVMcFFrS05xd0cv?=
 =?utf-8?B?S3FjdDNQSkI4aXIwWU11SmZoeW5DV3BqUVB1UExZSDlYeTBlT0RhZmhZQzBJ?=
 =?utf-8?B?SmxOQ2hBeFdpN0hqK1U0UEJId1cwN1lkNjdVMHNXTXRRL0NnNkw4WklmNTRT?=
 =?utf-8?B?VGJpMGhLOUlNQkFQYVFGTjd1cUk2dW1STzkxZjR1UDI3YXgwV2swZ20zWFQ3?=
 =?utf-8?B?ZTJxb0JZNE9UTlBsTHpCWFk4UnhjYUlBWFpyWjJSRDJoSFlHdU8vVmdsYmpu?=
 =?utf-8?B?cE5iM1E5bVVOSjhSSURYTHd3N1Erajg5THZFMjlzeHBKdmpaK0xpUHhlbzRp?=
 =?utf-8?B?S3RIVDNNWm1HRm1XYS8yMy8rR2VDUDlhbytqaDFIaFMzKzdSREVJemx4bHAv?=
 =?utf-8?B?Y3JLL21jd3BLVlVRaUpNRjVIaUErUmlhWHY0dTRuTEFFWFpXU0FzQU5DQi9y?=
 =?utf-8?B?bFVtWlpOaG9GQ0wxWjRyU1N3UHNYNmhhUCtqajlhZ0g3Ymtmb28rUGJuR3Vs?=
 =?utf-8?B?cGQ1Rm8zeWgycnhIRENzWjJsY3JKMUZBM2puM0t4Z1g2aVFPQVIrMVByTnk0?=
 =?utf-8?B?WVRrU285ZXROODFORWtLUys1Vmg4L3hFYXUwVEVCK1BTSVhnR25VQlRadEdE?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MGp2RWtPVHNSYnI2d0Q3VWNTdG13TUtwS2VBeFNmZHNZRHNaaHZsejZoLzZQ?=
 =?utf-8?B?aXZldzNtQXhkelpuSzhFZVFMZXNWSXVORUhwVHpib2FNUkVwem85QXk3OE9n?=
 =?utf-8?B?TTM5SjlOMTlINmh1Vmh6TGVpbERCbERYZEkzdXIzUUJEbTNwS3ZZdFk0N2c1?=
 =?utf-8?B?Wk9IeEErNkRqclliaExLb0h3eUt1dStxM0RlMy9MeDlJMTR3ZmRnUmVPRkRl?=
 =?utf-8?B?SWVYei9CanBhQ2YvNXBNWU8xRmVQaE5XVU5LUTh6UE1RYXZnRUF4QmxMVWhM?=
 =?utf-8?B?RVhnZFpkcDBWTmF4cmlIbVNOTXJ0U0xrTVJ6akEzbzl6MkZVbGk0UklrNFlB?=
 =?utf-8?B?UXIzQWNjUXVNQXVZU2lkK0sxSCtCdm16N0F5eWFnektucnFPVXBCRUlRTjRo?=
 =?utf-8?B?em9EeXlCYTZRdkVJQ3g5RUIwMmZVTFZlSmJJR0pJZEFYb3lHeFkrdGZCSHpT?=
 =?utf-8?B?WEtBYUhsMFlzRnRGSDNXeTBzZjJlWFVpbUxKRk1KQ1h5S2pVQkp1RlZkczFa?=
 =?utf-8?B?M1ExK0ZhZmdxUHhIVnR1OG5rODFHU2syUXUwYklFNi9va3d4Tm4vZ3RtYXFN?=
 =?utf-8?B?T2tHdDRjOHE1NmFSZTU2aU9IKzIvNnpxRmJ3ZHBtYXUrQVJ3Q1dNZis2dWly?=
 =?utf-8?B?K1gwd0I1ZDBnRnVud1B6Ylh2b2thMy9wZU1rMWpyZy90TkJKSDFvbEg4N01m?=
 =?utf-8?B?b1ZMa3NCVjhKaEhqaHlWVDJ1TUdEMGFTTkJUenh1QW1iWWJTdGdNOEY1ZEVK?=
 =?utf-8?B?enNFS3NXRlUrOE4raDB5NjVPWXRCYWFQMUZZQnljaFZGVlFwT2JVZ0ZEcWk4?=
 =?utf-8?B?blJhWWZXNWZpSEFpOUZZeEpBQTM2RjlKVlU3a1JkMzFsaGR0WHBDU3BFajFK?=
 =?utf-8?B?OEg1alJFcStKQWZUNm9kNG1ETWRBMkhTQ2xzNmpCelRwUzBZbW05QW5FVlFx?=
 =?utf-8?B?aTlYK3FOZTVxd2JZOHdCY3gyN2l2cnJBZDVKK0hzdE5WREx0N1BVL2ZiSzVi?=
 =?utf-8?B?Sis5MDJPQlg4NGIrUVdGbWNSWGs5UCtMbUt2NU5vWXlWSW1GaDFXS3ZJNmxG?=
 =?utf-8?B?U21iS2l1a1hNWU9tUS9SbjV2c1Y2d3hnczU0eDVrMktqc0ZCNGh0WHplVVQr?=
 =?utf-8?B?ZVIrMDlYZG5wQjhzUjVRTzFxZWIzQ0tSVE9mRXFZZGR0Wnp6ZThVQjB4emQy?=
 =?utf-8?B?U2FDRFZPeHphU0F5Qi9WWUxDaWFMYVpUYWczSjdaR3Y4REtKSzF3UkdLSFU1?=
 =?utf-8?B?MENMaWlXWlBmYlB3aitldTNmS3VTeVdPYVpUaVBTYitlOWpEV1dIdmo3cnQz?=
 =?utf-8?B?aXBrYW40empZSk1hWVVvR0Z5Z2QrWkl2TGh3R2VRTEhUNDdLYXNBOUZOWDFo?=
 =?utf-8?B?RWF1L2tNR2d5SURTaUlYVmdlQkMxVzFzclQvZWMzdVpkUDVya2o2K3phS3Uv?=
 =?utf-8?B?NU1KVWV4TnFoUHdnc2lGL3NnRndSMjVNQ2M5YkNnQXp1am1HeWMxeVhHZlJJ?=
 =?utf-8?B?bUgrTU52QTBPNG5yalpxWEg2enpPMFpBK0JpSDkvTnhnSUl5MmtMNFhNcjVi?=
 =?utf-8?B?OEpjQXBYTEZwQlJvMnFSc0w5eFRHOHFLTXVtbjlCeW5jY0hJL2NQTDkxbjNR?=
 =?utf-8?B?enNEZ2g4RWJKUkF1S1lsYTl0d00wWHNyRGs2dnQvdDNBcDBwTXppZTZiTU1r?=
 =?utf-8?B?cXRHNGhqeHlzbElBb093YVRTZ096aE1WcEpxZW02NEg3UVdKL3R3dkRFdnJr?=
 =?utf-8?B?ejFseG1vcS9KTVZIcjBxNUlXUC9ueHljU2RjWER2SFJSeCtxMFc4dWtaZUVE?=
 =?utf-8?B?Zy9JZk5kbEF1WS9JT3B6Q1dCRDAvemFFK3dNQ21sN2FmdURGSVdhMXBpQnRB?=
 =?utf-8?B?Q05NVm81VVNMc04zY0dlOU9HakNScGtySFNJOU9ONjBKQ1Q3S05sVnUweGR6?=
 =?utf-8?Q?k6GNozLJyS4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 211895fd-461f-481f-f7ea-08db6eac28d2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 20:56:30.3185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bl/045UduvxRJlA2QIBKrZuTKUX2BZknOKcsSlgmh+vaJAQL/1Kklpw5Pg3/lhUV6rUTo/U5wh5278iKH8rKZdgNAjpkP5z0jOxbXcS9Qh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7850
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_14,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306160189
X-Proofpoint-GUID: VGHe44fpbmrCc7XNSa7BUCj39NKX72_0
X-Proofpoint-ORIG-GUID: VGHe44fpbmrCc7XNSa7BUCj39NKX72_0
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/13/23 03:03, Greg KH wrote:
> On Mon, Jun 12, 2023 at 05:07:08PM -0400, Eric DeVolder wrote:
>> Introduce the crash_hotplug attribute for memory and CPUs for
>> use by userspace.  These attributes directly facilitate the udev
>> rule for managing userspace re-loading of the crash kernel upon
>> hot un/plug changes.
>>
>> For memory, expose the crash_hotplug attribute to the
>> /sys/devices/system/memory directory. For example:
>>
>>   # udevadm info --attribute-walk /sys/devices/system/memory/memory81
>>    looking at device '/devices/system/memory/memory81':
>>      KERNEL=="memory81"
>>      SUBSYSTEM=="memory"
>>      DRIVER==""
>>      ATTR{online}=="1"
>>      ATTR{phys_device}=="0"
>>      ATTR{phys_index}=="00000051"
>>      ATTR{removable}=="1"
>>      ATTR{state}=="online"
>>      ATTR{valid_zones}=="Movable"
>>
>>    looking at parent device '/devices/system/memory':
>>      KERNELS=="memory"
>>      SUBSYSTEMS==""
>>      DRIVERS==""
>>      ATTRS{auto_online_blocks}=="offline"
>>      ATTRS{block_size_bytes}=="8000000"
>>      ATTRS{crash_hotplug}=="1"
>>
>> For CPUs, expose the crash_hotplug attribute to the
>> /sys/devices/system/cpu directory. For example:
>>
>>   # udevadm info --attribute-walk /sys/devices/system/cpu/cpu0
>>    looking at device '/devices/system/cpu/cpu0':
>>      KERNEL=="cpu0"
>>      SUBSYSTEM=="cpu"
>>      DRIVER=="processor"
>>      ATTR{crash_notes}=="277c38600"
>>      ATTR{crash_notes_size}=="368"
>>      ATTR{online}=="1"
>>
>>    looking at parent device '/devices/system/cpu':
>>      KERNELS=="cpu"
>>      SUBSYSTEMS==""
>>      DRIVERS==""
>>      ATTRS{crash_hotplug}=="1"
>>      ATTRS{isolated}==""
>>      ATTRS{kernel_max}=="8191"
>>      ATTRS{nohz_full}=="  (null)"
>>      ATTRS{offline}=="4-7"
>>      ATTRS{online}=="0-3"
>>      ATTRS{possible}=="0-7"
>>      ATTRS{present}=="0-3"
>>
>> With these sysfs attributes in place, it is possible to efficiently
>> instruct the udev rule to skip crash kernel reloading for kernels
>> configured with crash hotplug support.
>>
>> For example, the following is the proposed udev rule change for RHEL
>> system 98-kexec.rules (as the first lines of the rule file):
>>
>>   # The kernel updates the crash elfcorehdr for CPU and memory changes
>>   SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
>>   SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
>>
>> When examined in the context of 98-kexec.rules, the above rules
>> test if crash_hotplug is set, and if so, the userspace initiated
>> unload-then-reload of the crash kernel is skipped.
>>
>> CPU and memory checks are separated in accordance with
>> CONFIG_HOTPLUG_CPU and CONFIG_MEMORY_HOTPLUG kernel config options.
>> If an architecture supports, for example, memory hotplug but not
>> CPU hotplug, then the /sys/devices/system/memory/crash_hotplug
>> attribute file is present, but the /sys/devices/system/cpu/crash_hotplug
>> attribute file will NOT be present. Thus the udev rule skips
>> userspace processing of memory hot un/plug events, but the udev
>> rule will evaluate false for CPU events, thus allowing userspace to
>> process CPU hot un/plug events (ie the unload-then-reload of the kdump
>> capture kernel).
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> Acked-by: Hari Bathini <hbathini@linux.ibm.com>
>> Acked-by: Baoquan He <bhe@redhat.com>
>> ---
>>   .../admin-guide/mm/memory-hotplug.rst          |  8 ++++++++
>>   Documentation/core-api/cpu_hotplug.rst         | 18 ++++++++++++++++++
>>   drivers/base/cpu.c                             | 14 ++++++++++++++
>>   drivers/base/memory.c                          | 13 +++++++++++++
>>   include/linux/kexec.h                          |  8 ++++++++
>>   5 files changed, 61 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
>> index 1b02fe5807cc..eb99d79223a3 100644
>> --- a/Documentation/admin-guide/mm/memory-hotplug.rst
>> +++ b/Documentation/admin-guide/mm/memory-hotplug.rst
>> @@ -291,6 +291,14 @@ The following files are currently defined:
>>   		       Availability depends on the CONFIG_ARCH_MEMORY_PROBE
>>   		       kernel configuration option.
>>   ``uevent``	       read-write: generic udev file for device subsystems.
>> +``crash_hotplug``      read-only: when changes to the system memory map
>> +		       occur due to hot un/plug of memory, this file contains
>> +		       '1' if the kernel updates the kdump capture kernel memory
>> +		       map itself (via elfcorehdr), or '0' if userspace must update
>> +		       the kdump capture kernel memory map.
>> +
>> +		       Availability depends on the CONFIG_MEMORY_HOTPLUG kernel
>> +		       configuration option.
>>   ====================== =========================================================
>>   
>>   .. note::
>> diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/cpu_hotplug.rst
>> index f75778d37488..0c8dc3fe5f94 100644
>> --- a/Documentation/core-api/cpu_hotplug.rst
>> +++ b/Documentation/core-api/cpu_hotplug.rst
>> @@ -750,6 +750,24 @@ will receive all events. A script like::
>>   
>>   can process the event further.
>>   
>> +When changes to the CPUs in the system occur, the sysfs file
>> +/sys/devices/system/cpu/crash_hotplug contains '1' if the kernel
>> +updates the kdump capture kernel list of CPUs itself (via elfcorehdr),
>> +or '0' if userspace must update the kdump capture kernel list of CPUs.
>> +
>> +The availability depends on the CONFIG_HOTPLUG_CPU kernel configuration
>> +option.
>> +
>> +To skip userspace processing of CPU hot un/plug events for kdump
>> +(ie the unload-then-reload to obtain a current list of CPUs), this sysfs
>> +file can be used in a udev rule as follows:
>> +
>> + SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
>> +
>> +For a cpu hot un/plug event, if the architecture supports kernel updates
>> +of the elfcorehdr (which contains the list of CPUs), then the rule skips
>> +the unload-then-reload of the kdump capture kernel.
>> +
>>   Kernel Inline Documentations Reference
>>   ======================================
>>   
>> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
>> index c1815b9dae68..06a0c22b37b8 100644
>> --- a/drivers/base/cpu.c
>> +++ b/drivers/base/cpu.c
>> @@ -282,6 +282,17 @@ static ssize_t print_cpus_nohz_full(struct device *dev,
>>   static DEVICE_ATTR(nohz_full, 0444, print_cpus_nohz_full, NULL);
>>   #endif
>>   
>> +#ifdef CONFIG_HOTPLUG_CPU
>> +#include <linux/kexec.h>
>> +static ssize_t crash_hotplug_show(struct device *dev,
>> +				     struct device_attribute *attr,
>> +				     char *buf)
>> +{
>> +	return sprintf(buf, "%d\n", crash_hotplug_cpu_support());
>> +}
>> +static DEVICE_ATTR_ADMIN_RO(crash_hotplug);
>> +#endif
>> +
>>   static void cpu_device_release(struct device *dev)
>>   {
>>   	/*
>> @@ -469,6 +480,9 @@ static struct attribute *cpu_root_attrs[] = {
>>   #ifdef CONFIG_NO_HZ_FULL
>>   	&dev_attr_nohz_full.attr,
>>   #endif
>> +#ifdef CONFIG_HOTPLUG_CPU
>> +	&dev_attr_crash_hotplug.attr,
>> +#endif
>>   #ifdef CONFIG_GENERIC_CPU_AUTOPROBE
>>   	&dev_attr_modalias.attr,
>>   #endif
>> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>> index b456ac213610..24b8ef4c830c 100644
>> --- a/drivers/base/memory.c
>> +++ b/drivers/base/memory.c
>> @@ -490,6 +490,16 @@ static ssize_t auto_online_blocks_store(struct device *dev,
>>   
>>   static DEVICE_ATTR_RW(auto_online_blocks);
>>   
>> +#ifdef CONFIG_MEMORY_HOTPLUG
>> +#include <linux/kexec.h>
>> +static ssize_t crash_hotplug_show(struct device *dev,
>> +				       struct device_attribute *attr, char *buf)
>> +{
>> +	return sprintf(buf, "%d\n", crash_hotplug_memory_support());
>> +}
> 
> This sysfs file has to be documented in Documentation/ABI/ right?
> 
> And did you use checkpatch?  It should have told you to use sysfs_emit()
> instead...
> 
>> +static DEVICE_ATTR_RO(crash_hotplug);
>> +#endif
> 
> All of these #ifdefs should all be removed and instead use the
> is_visible() callback to determine if the attribute is shown or not,
> using the IS_ENABLED() test in the function.
> 
> thanks,
> 
> greg k-h

Greg,
I've been examining this request, and could use a bit more guidance. Taking a look at just 
drivers/base/cpu.c for the purposes of this discussion, I need to add the .is_visible method to the 
following:

static const struct attribute_group cpu_root_attr_group = {
     .attrs = cpu_root_attrs,
};

ok, that makes sense. The request is to remove the #ifdefs from the following in cpu_root_attrs[]:

static struct attribute *cpu_root_attrs[] = {
#ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
     &dev_attr_probe.attr,
     &dev_attr_release.attr,
#endif
     &cpu_attrs[0].attr.attr,
     &cpu_attrs[1].attr.attr,
     &cpu_attrs[2].attr.attr,
     &dev_attr_kernel_max.attr,
     &dev_attr_offline.attr,
     &dev_attr_isolated.attr,
#ifdef CONFIG_NO_HZ_FULL
     &dev_attr_nohz_full.attr,
#endif
#ifdef CONFIG_GENERIC_CPU_AUTOPROBE
     &dev_attr_modalias.attr,
#endif
     NULL
};

In order to remove the #ifdefs in this struct, as requested, that means these attributes need to be 
always compiled-in. So I can move the declarations of these outside of the #ifdef which contain 
them, but these all contain a callback function for show()/store(), which is inside the #ifdef. The 
struct device-attribute .show/.store pointer to the callback function must point to something linkable.

Is an acceptable solution to place nop callback functions for show()/store() on an #else part of the 
code blocks in the file? Ie:

#ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
static ssize_t cpu_probe_store(struct device *dev,
                    struct device_attribute *attr,
                    const char *buf,
                    size_t count)
{
... real function contents ...
}
#else
static ssize_t cpu_probe_store(struct device *dev,
                    struct device_attribute *attr,
                    const char *buf,
                    size_t count)
{
     return 0;
}
#endif

I've been looking around the source tree for examples, but I find most are either groups that are 
all strongly related and thus compiled-in/out together (ie drivers/base/cacheinfo.c, 
drivers/acpi/nfit/core.c), or utilize #ifdefs (ie this file, drivers/base/topology.c) .

I may not understand the goal of the request either, as it appears it would result in a kernel 
slightly larger (struct attribute containing entries for items that are not configured in the 
kernel) than a kernel utilizing the #ifdefs as-is currently.

Thanks,
eric


