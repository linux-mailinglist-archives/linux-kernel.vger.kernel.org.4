Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEA1629A12
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbiKONZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiKONZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:25:28 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B88FAC7;
        Tue, 15 Nov 2022 05:25:25 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AFAiJel022487;
        Tue, 15 Nov 2022 13:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=Y3Rrvj/KBcxxXqWXavJkHH4Q8sEwKpfh/8jgJhUscYo=;
 b=MEoZ/qQL8+EsZy+P8h8nlOI+juSgilRBVMQ17gcRebjUFbU5yNnXIoNqdPNwIEQEaIcS
 gjxINZyZh3icq6ZBcuNt0EVY/Zn2rQBv71FEnSWpv+NqkC+BjXn1SKeY06kTEFht1tlj
 hnJZit9KyW4EuaxDZr6YBNv7fv2GyC5v2aJJZ6Fjgaw1KQFnz2k9RVde6COAxx5aF+uC
 YjhV0Y4HJbr3zy3viOee0NdWxxyjrSCQ5tKL1YRStJwdG9R3Uz+36DceS0vjgFOjOk/Z
 w/jv4VrdfOshBXjTD1DBst8jFYDdkAgQ0yzFnr3wZsc3IEqCWr0s4kyM/3QC/xWbJnMJ aw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3ns19a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Nov 2022 13:25:11 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AFBg77b019286;
        Tue, 15 Nov 2022 13:25:11 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1x5qqw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Nov 2022 13:25:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIPdhPhzS8PFcc6KZsjK46OU9HcKP1jL+NZauxqGGnPa6lUzLSossHZ+XGtU0cbwjCpuxZXIrmHFllQY3zpwS1eZSiBjYfItOqiMYSxjqXml1YlWWz6qvWK/OVzI4gOJHF8s9kQe6N+pDvxWXT6yUKNR1QIpieKH1qJU/zbD+5y/y01oMNPIU5luARL3DjIDzjtgGMcR/XXwvs/FH6dkieDiEaxbIq8yRTw/KFdEbylbPS4L0MA0FAkAgRx2eXSXiSgOVxEswGSHNhSS/XL5Vsq0nuJebSmp1ptLJ7jSndy4bCA5UU7T+Xbokw24Im2omtaDwgkaNTkiUc+dd30bvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3Rrvj/KBcxxXqWXavJkHH4Q8sEwKpfh/8jgJhUscYo=;
 b=PZP1n9NAnzE0rUEidkQy5+SbUcOHKX3teQdzTC9dO3l2lInbLGbLJO549OQXsl3d6aEemh8Q6uUR4lawDRe07LopMKXNZUitHzo/7iiOPPx6+DvhUpRPL8cVjTWzIfEuH7sWvRCTmfDzA9BtbX9aCHvpPCvltIaRsBcG7p7sYXZbFKnaUHsOSEpahE2w5TYNtIUuEKMWugRIkxo5l/kFpXTCEeCB9keWj4AeufRLAof+7QqNCmJXgtlZ0q8zhAkao6BSt6i/eZShFQuOFyCEYuTPJOySBy8zvH+HOPPNLJjqCEP2/XKi/h9AY5CkDxN89BMTXaXsN6wUaPzHz71XpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3Rrvj/KBcxxXqWXavJkHH4Q8sEwKpfh/8jgJhUscYo=;
 b=A30a/sMkkq1LMjSm6YzRaVI5OqDRePIix6x3lUjomB9Iqrc6XY8s2tf1jtF9dlf3b9yo2IA0wTptwMl8quaTeMTnivdNqM1INRDDTh2oRPntTUEU8c+sWA+OA1yBHPAmZDY06MkwBvuZVKlY2wKqpUkKMMThHbEOVl0u/cCSZ6k=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by CH0PR10MB4825.namprd10.prod.outlook.com (2603:10b6:610:da::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 13:25:09 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d361:ae7a:f995:2bb2]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d361:ae7a:f995:2bb2%3]) with mapi id 15.20.5791.027; Tue, 15 Nov 2022
 13:25:09 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Nick Alcock <nick.alcock@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>, <masahiroy@kernel.org>,
        <linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnd@arndb.de>, <akpm@linux-foundation.org>,
        <eugene.loh@oracle.com>, <kris.van.hees@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v9 4/8] kallsyms: introduce sections needed to map
 symbols to built-in modules
References: <20221109134132.9052-1-nick.alcock@oracle.com>
        <20221109134132.9052-5-nick.alcock@oracle.com>
        <Y3BhRvt53xO5A0iQ@bombadil.infradead.org>
        <87mt8tv554.fsf@esperi.org.uk>
        <76d7ba29-c7d2-d082-5928-599844112494@huawei.com>
Emacs:  indefensible, reprehensible, and fully extensible.
Date:   Tue, 15 Nov 2022 13:25:04 +0000
In-Reply-To: <76d7ba29-c7d2-d082-5928-599844112494@huawei.com> (Leizhen's
        message of "Tue, 15 Nov 2022 19:47:27 +0800")
Message-ID: <87edu4uz7z.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0297.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::14) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|CH0PR10MB4825:EE_
X-MS-Office365-Filtering-Correlation-Id: 9381d1a9-58f4-41e1-f16d-08dac70cd116
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KQoVa6ZKUuw9pbBwwLipYX1X2kBL8pA7uH5Zk6MH8Mz92q3NVTY60rnIjMpkB99QGjsyWW0bgyq03IVvDEf5y81Ns7hVe5NAclHQ9ctb+k7HKs/h7ZiZnWNkqPdqrLB8+/IntWeckbcHZIIGJSvQYnscNf8CW3XrHHlTZW4DFs/cyo1pFL3RoLxoah8ML/1quaDGpicV60TImpYOE4rdlUdU4Rm+E+Rv4cY3dwzE/KhHCub4A9W2gXsHt2pm5R9/3yEzP3Sf0qY1p//BGAqyfrmXSaNQ7X0aMfEoAsNDLdm9D02g+hmqWxtlXPh6TB9BP0P8y3au6mq1GbNBAwugnFWVx4kU9Rv8BIpo3fsi4BX34JWQCbKoeqmGecc31i9dNgCMjqcI1bO8noaE15r+3FfKBwWk62AHMvsKlwb8HoDcMcdQ0ZA7QINGdSQdXO5erHU4YtdnjmZCfrccphyOym2jmttmuUsVZECgc3LmymmJbHZDV87bGoAw6ojm3I+skpncm99KUMjUp38G16/sRTer9OlBrKj8wxPGPy8bKFOlYwqZ/WHPPJQBm1Xms3L4uVAGrUdfEo4P/ELGRpXpxIAPQgFNxwy7R/Rp5FqCSEK2gOoTZJYXBkewag5no1qtACjB9BnRD37GIC5HEv35Xy5qeXMaWCs/bvgWU+dHotTDNbhzeS2GKksoRjNZvq/SWPhE/fcKyID8eFV+Y+NBCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(396003)(346002)(366004)(136003)(451199015)(5660300002)(8936002)(6512007)(66946007)(36756003)(66476007)(4326008)(66556008)(8676002)(41300700001)(44832011)(53546011)(86362001)(9686003)(6666004)(186003)(6916009)(54906003)(38100700002)(316002)(6486002)(478600001)(6506007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VZg4x++SBUs+HwEoNt54Z7dA8M+khfbWYkdyaYNVyOMzsU1mFjssTm6w89Q9?=
 =?us-ascii?Q?nSiZFJICpfxnXm72l9b05ISi0wIMCUmr0OnTv2IunT2SDIR0iobQZfiK73ij?=
 =?us-ascii?Q?QalT3mtuLbEoEho+f+OC9Mt3YwD06tGIQlv+s3w72FU3hEKy7pw56Ek5ZR4k?=
 =?us-ascii?Q?H0v79F9D2JcujlxP/5mRAMg47+dsu12msCieZ+NaFtVl1msSHwAyXEvnNRAI?=
 =?us-ascii?Q?vwM9dVW8QUh879SnKtq+HEiYV3MPauQhm8HEjhabDvPn/VEu4RG5/gGRJ3Y8?=
 =?us-ascii?Q?XRPsa6fgz2JMAkknrIkhOFz7j8ZMWnxkjjeujV+jF/hrOyNZqKTQitJ40fxG?=
 =?us-ascii?Q?SWinDz5lq9sVr6KorMlWLbZVU8iwdT3I5GltiZ40YX/DsUCqVhbtt9VoItnH?=
 =?us-ascii?Q?c/LCXYkBhAaIGe4WmGkq9zft5rcSuoMdnR7bOD7nyI7mOECd9IE0wI49I3e0?=
 =?us-ascii?Q?ghdW2giih1f8dRk7ZhBhVreivZkQvH4+VkaWHsHnKn1qPqz2onSvjeixLx1s?=
 =?us-ascii?Q?cMNPMiE08nV07ncAl2s3MLT4ks0l9Vosh3pZdOZfNBGQ600Zdp/GjJ+79eLC?=
 =?us-ascii?Q?ISgCl7noqMeMW2KoXR7F6tdIGirLUVIkqjmkK3+M8JLrmcGnPcSerUQ2FhJG?=
 =?us-ascii?Q?JCcYcxsQNiVBLyKbiR+F5FDHB/0Zt/jkl9SKPFS4V6F5CWrmJAaB8O7w7UVS?=
 =?us-ascii?Q?YqmJxs1qmcDxngWx4JVvn3MTwqSpxYiXzDmeIvo//ulZtPGZN3d8fGu0qWtr?=
 =?us-ascii?Q?EH7anzp326IUBoU1CEVABG4ns3X8yCrWs6zfUJkLnQSZEVIQWR3RwX6Y5TJE?=
 =?us-ascii?Q?ZmFnQlzwYiRMpzuWrZ9vRMHhDpVmLygC92oVs5ZlvYA+/rEAVB1rXuXxrskc?=
 =?us-ascii?Q?UbrlBJANKREDlod0hD0R7lvTnXAxUfXCkqWBA2eBn8CYa/G+M9GZER9wXAra?=
 =?us-ascii?Q?Cqskj1YSVDzcyxq9XM+wr6rS41Myg5Wg2t5UPhL3UsaOwxu1WXtLDlt1XYPS?=
 =?us-ascii?Q?M0XX02X27Lbz9mzroXY34/ujpbQGFGTabwNfora7SXA4KS6WgR6tdTB51zaO?=
 =?us-ascii?Q?3lLM4tw1Gj7/J7IAEwPXzPAltMg58SVmvJwoVGcIBo5J8+ab5KGndMGbGVNT?=
 =?us-ascii?Q?m06Hf4W5UnB4IGdmmF98XdevMwthHi/b/la7Tske+5pwIJ2ycfhgXk0ufQT6?=
 =?us-ascii?Q?GIqR6NaoS62C5JVb/DLiOtH9F1Wmvb9Ly7v2vkWfJS7gMNjt4LbDAex8mZF6?=
 =?us-ascii?Q?NtNaQduYQuNxEpuoyJTL2QfI9EKYlhx4W/nNVklF1lp1+KFQdvxnSDV5HcaV?=
 =?us-ascii?Q?+mScC7ODF6qY/jkRen2Q+xzUdkuHQbkFDqLXCakEdFTd5cpsQ8hukWf8c7OS?=
 =?us-ascii?Q?hsnnB0AKjx+MfemxUfyixDUVt0ahxkCSUXzePMwk5N7FIRAYmulNP5/L302H?=
 =?us-ascii?Q?7lvNPF1ROWF06RWLdtowCBRtZxpH751wx+4QVWBKsnLR5K3+jmRU8LbuIy+k?=
 =?us-ascii?Q?I7zWlGCbqiefQeYXiIBdpFvzvSBZp6NHN+VccNiVV4A4qzAfQ3TIdepRGTUE?=
 =?us-ascii?Q?1XLEyFysjZ3656v33SemoIUr8hjpOWObLYO+3rmqHp2680L9FmlWuQUldrjB?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?diN20MophuqtNBXdRewJSScEINl4JdcbsPJjWqJja9+/ojqGIrCjY+gkvA7X?=
 =?us-ascii?Q?uDzlCfSUa6jUFhq5nJ7iLARjQP4k6v/6DLjJosdUlJP912fQVoRPi5usKOtY?=
 =?us-ascii?Q?lwdGaGqTqDetXXI10oVRWEEOkiQ2EBa0e6qWtui29UykjM3COY7Y6VtX8iEx?=
 =?us-ascii?Q?7EzHG4O330U+5U+wDBdtG/iy3EdUE4cVgTEmPMMw0Jvmjcj0Gd+kZ3697hoA?=
 =?us-ascii?Q?JGaQ9kYWmSzFApt6eI+JjM5uYEfIcDus7nw6r/48nkfsfMqgY0nIaZqeCLkH?=
 =?us-ascii?Q?LzIZFf6aSgDCjegWDQ8icyc3N5O1UwxJff3SJtXCj+3X6onJ+USdDBTZaIHv?=
 =?us-ascii?Q?xQiXy/h83MSPNa+1WmmWW8O5iY55yHc0+zs7gaxXXjM+X2hW7n0KHW0Rlybb?=
 =?us-ascii?Q?yCvTKfiq6ehQ8kqrnFaAA9cxbK1IZAX3O0khZD87fFcL04N68N5X7rjevE04?=
 =?us-ascii?Q?YbUUMqoBnufwQq1iuDoEvrT+dNc6VBlC+W1YmFk1Dqd/7fo6I6eXZ+JUWrQZ?=
 =?us-ascii?Q?n5fFjJnrVKujx8M6zuuzB9NLhE416OK6ov71pAEUL0jK1vcjwN5w1/P59b/z?=
 =?us-ascii?Q?u+b9P5R7/nWNQiBk9FUpxvONC795XL+KaRP+cVA9yrjCXTeYCDY1xlzgBXVh?=
 =?us-ascii?Q?EXKZhBlNo89D+KJcBKR82I64gDR+QTbtmdy77ROOYRn1lFRYzNp13uddpsPS?=
 =?us-ascii?Q?ec6lL6SokcnkGfFA7+2Z4uDzSi+CvxU9KszeclwH4iAESGWQAzMossxAjkk5?=
 =?us-ascii?Q?aYyQUUbNwcL+5AwAeRBT699Idh9C45Vy+tYYCDqI1Zh4MExvGe0G17kBoacd?=
 =?us-ascii?Q?rxaTDSyF23NJBBL9iwcSSzlGzwB7kLUoR8DZyN08QGtovQPZRDMgzRQv0jpB?=
 =?us-ascii?Q?AJ+dIQlSa1C4xFMEg8LEybU8WySpwWyEHdO8pGH5l0O4Dfsp1eKKtZlv/8LC?=
 =?us-ascii?Q?Fhcfz7pTx2HZw7TdalQpc3G0N76207i1UieW+lNAJoVDTQwl/zVihnO1HRrR?=
 =?us-ascii?Q?ZSM6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9381d1a9-58f4-41e1-f16d-08dac70cd116
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 13:25:08.9854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cToe8zAqL9GfUXAE6MfdG56bXrR/z3IqQtpRFw5FocZMSJpZNzjFqfGIDd2wKT5nidn1HmxUytcTRgB6OY0EJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4825
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=574 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211150091
X-Proofpoint-GUID: r1lqLWychXb-182q4T_vEPTB0KitWOW_
X-Proofpoint-ORIG-GUID: r1lqLWychXb-182q4T_vEPTB0KitWOW_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Nov 2022, Leizhen spake thusly:

> On 2022/11/15 1:04, Nick Alcock wrote:
>> I don't understand the question, sorry. If this is about the number of
>> KALLSYMS invocations in the kernel build, that should be unchanged by
>> this patch. This was an explicit design goal because it's quite slow to
>> run kallsyms more times and I was already feeling guilty about having to
>> bring back the tristate recursion.
>> 
>> I haven't tried it with Zhen Lei's work: will try for the next
>> iteration, as a matter of course after the rebase. (And, looking at the
>> patch series at the top of modules-next, wow is that quite a hefty
>> performance improvement. And a hefty memory usage increase :( I have a
>> horrible feeling that one of my machines won't have enough memory to
>> boot after this goes in, but it was terribly outdated anyway.)
>
> It's only about 500K. It shouldn't be a problem. Your machine boot from flash?

It's more that it only has 1GiB RAM... but it's also wildly obsolete and
I shouldn't be worrying.

(I'm also a bit miffed because people are worrying about 10K of
overhead at the same time as a patch is going in adding half a meg ;)
but that's just me being childish. And I know you can't add overhead
indefinitely or the system turns into a slug, and I know the speedups
from your change are amazing...)

-- 
NULL && (void)
