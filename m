Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDA96DCCED
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 23:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjDJVwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 17:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjDJVwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 17:52:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1084E1BDB;
        Mon, 10 Apr 2023 14:52:00 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33AJdxwg003211;
        Mon, 10 Apr 2023 21:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=BTesMhSEf69kylTBHGNONFKk5qdXsgUaKN/8LcJkZUU=;
 b=jbQ4+vDZFat6lL5EDSKkJtyjgtqwkGzLR6ViaG5KDWNG/fKqnU4s9urHOGObE7IcZHy7
 mdNeZMq9zGWdcDnG87U84YNFeGdZUrNqH+EjvOO3UDI9siXi0Yr1BPephFczKxKAQphV
 yEa/px81Pvh2j44qclij8Merv7ZrDds3jN828mDm/X9fN4M2TQC+L7qRgLQI+aL1cxUg
 rHmJcWDsIawr06w4bEMIU01t02v+n5vPCwdbFtV2WDag+q5ApuxJpMOk/3iYc3FmGgeg
 Mtz+XfuJgFixryDKhqyAodgLBS8F00qnyZyv5OnxRz+pXracHik0gsP6xCIiKld9HVdN VQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0hc3x0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Apr 2023 21:51:54 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33ALjTVg038888;
        Mon, 10 Apr 2023 21:51:53 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3puw85nj6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Apr 2023 21:51:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoewZLGYp1jzl0EwfVsSf3hU8b81PDDHylw32cXa7BgAT07BGD4AzFIBJgX24vB5Y3OCBVLkV6cqB6B3yRf07Bf7xvRPf9DAVkbpW4LwXuZWRXASkxWepnoJWLfSXGIGrUfoZiTvlNxrLzSPk/4M1hvpQJ0ESJbFQCzfU1FuHwmeapJYKAt//pksZ6MTubOgGEBDXLwOLq7HO9LLEybijCqojIvOpcqCqUKJ+3ZVRXZQwKqKfW5wfPyxXJMs+jaCX4Cxcg4IF2pDJ55RGp8RHL3xBMSagBFYsSYfY3LQURl4nCDe2uKbMSvtS1ah3ZxOya7SbQcgrPoAJ/uC+KXDOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTesMhSEf69kylTBHGNONFKk5qdXsgUaKN/8LcJkZUU=;
 b=W7oJC/HmEyf/fw0N8HK06oRb3DOVI2Y5ODhRD5qCR7pxuks2ZjM8CCfqL2VWLNA8ohM1LwpWs1pv86N8tkFHhkwz/Ycjd3VVvyVC82P9m6Z4ei2B9iSF1KCs219ko9E3rU+fIvRRnZ3B4mEpJjxvYwdO76QS1v1hpJ8uxByMPXMaUduOSarDwehUPBViSSr6LNrOAXtT4oAoP7LjN59FEmZ/RecgLJv7s24qDUPMMQnKMJCwnUjjUABgBUOkhSkZEB1dlIKM7bZjNNEVckM+O4TFuQULGJaFRKmz3jGGkcy6OCziCpjBHND6VmrluP5pnN/OF9c1VeLyWofNnkoXjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTesMhSEf69kylTBHGNONFKk5qdXsgUaKN/8LcJkZUU=;
 b=ngv3O4ywbkyrR45ZJFkwQXbB4gMY4xiPvfDJujKKrwrJLrhJG2Pjvb9W4dHAJ/kfIa2mk4s421Ftwqt9J3oEDbdb6cwBhdBvkCPdjxJo6TFeoa5R1Ep7hHXSUdoJU236PBU92TSbFzYR3UAJlXI841t7UBdefbNg1vX0nXqufEY=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by IA1PR10MB6735.namprd10.prod.outlook.com (2603:10b6:208:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.38; Mon, 10 Apr
 2023 21:51:50 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::b3a1:e02e:37d0:afa1]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::b3a1:e02e:37d0:afa1%8]) with mapi id 15.20.6277.035; Mon, 10 Apr 2023
 21:51:50 +0000
Message-ID: <cdde1e4e-142e-3859-71ba-f7bacf0dbaae@oracle.com>
Date:   Mon, 10 Apr 2023 14:51:46 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: Semantics of blktrace with lockdown (integrity) enabled kernel.
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, nathanl@linux.ibm.com, joe.jin@oracle.com,
        Eric <eric.snowberg@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>, axboe@kernel.dk
References: <ZC8Dbux56HbJjpTy@char.us.oracle.com>
 <CAHC9VhQ2rLpjczvb4993fQiMau7ZXLe8aTLtMZO_iF42w=1frg@mail.gmail.com>
 <ZC8eZ/RTX//0urV/@char.us.oracle.com>
 <CAHC9VhR06pa2mDwW26XFqiry11Ubz2_3YKj+ayftu0JdYx9m9w@mail.gmail.com>
 <93ef5db7-fb4d-bf3f-9456-3fb6e7d5ca29@oracle.com>
 <CAHC9VhRKzv4+fbSK8+fV7v+N5Eaevtag7YvSW1YwJrxs5gAyHQ@mail.gmail.com>
 <fa0a4afb-14ce-a387-ec0e-2098c5bec8c3@oracle.com>
 <CAHC9VhT4r4HwrfZMVbG8DWbfvVRGH_AMGpdVUS_YLmUR7L3uvw@mail.gmail.com>
From:   Junxiao Bi <junxiao.bi@oracle.com>
In-Reply-To: <CAHC9VhT4r4HwrfZMVbG8DWbfvVRGH_AMGpdVUS_YLmUR7L3uvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:217::28) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_|IA1PR10MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: 1779d5bc-464f-453e-5c25-08db3a0dca45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sjoRbLesmIye+dtjmug9nLLpXPb+z/JspL/IYza8bZXV4Cb6H6wA1tXc1YMluuDPu8Tfxsaxc75S6SF2U6ecgJ4OmbRH2hJUpVx1nPGCcFd+gUa+timtmsdIKIdN0mDHpW5Wfq9DTMbbJOIjHnn5JVCcRfFRKO3JeZlp1x9FAjUJcD6V3bcKlnLdZns62T2AyEZz7XEpEH5vDP9j+WoNGpiHJdLHbMfn0DItXDkOWqJHflS150UuBE5U8tJCkmn0BsRleAGYSV/OYRkeECtO0y0tzXQJvVwlgXZIsS8aVc4+nWtr2p0xCEfvd7OtTXOFsB0RIi6I+Rjci0T2WtwlPao0UlKeuhbuLxRYsm/lfxnpHvBG0uZgr4j4CSp37ugMQsyE+3J7THvy13+Lv8evmpJ+7ZpeGgXzZdlpZPSX4Aq1PlrGF6mrAgMqBBPT+NOQmt+gDUaH4NrYfwN6vbC60xqsVTx3grlAqY/QzbHvcRi6dCIv7lNZZxlt17SsK6jYiGwHhPhwxZr7aDVCNNniURWGpteWWCxO8IRQr+vg65cknPBz3AYEtwxOMBg4i+NvevpFxqf8ukc+DOtdJWwK+N7AClKJnjg6uIHyNi83FGT75Go2VM42IZo4oh5UdO6X3BntWG9O6se+2/GieVhFMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199021)(31686004)(2906002)(38100700002)(6916009)(44832011)(5660300002)(4326008)(31696002)(66946007)(8936002)(41300700001)(66476007)(66556008)(86362001)(2616005)(83380400001)(6486002)(53546011)(36756003)(6506007)(26005)(186003)(6512007)(6666004)(316002)(478600001)(54906003)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFROcHE5OHlUNVhXM2lxb0lpNmVWa2QvcVpkb2F2S2lSV2QweTlvenFGK1ds?=
 =?utf-8?B?cG5EZ2l5elNqaDJaUVJtLzB3SFBvK0tTckR4eXgwNWo4MnprMnRNRWNXRXQ3?=
 =?utf-8?B?RDY1V1JZWlRWQmNXTm53VVcyTXduMkhXVkUyeVhqeFVabTRjc3dvTHVSbFlY?=
 =?utf-8?B?YXF2SkxDWmhOTUFmY1pqWEY3cm85Y3lwajFLUUtabEZieC9WdUJzN2svNWVr?=
 =?utf-8?B?TVQzL3ZqL2wrOVVydmsxYmZuQkg1d2N1RDY3c3g2VVNkZ3VJK2ZYeVY3ekY1?=
 =?utf-8?B?QlUxejE3LzJuR0djMWVjcUljWU9ncVNkek1UaDlqbkRmWTkyMnk2VUlQb0xI?=
 =?utf-8?B?VGV4ZUpERDJ4MG9HcW5mL2VkbWdEeCtQOGIrU0VXVW5hYitHNjFtT1YyTFo4?=
 =?utf-8?B?RU1mK3NCZmZLSGxGV1VodWh2aldSd1VzYkdzZzFoSks4QmdMOFg0SnoyaXQ3?=
 =?utf-8?B?TldOWDJEMlB3YWZoa3RreUdKRkxiRWFUYnBPYnhFZlFsTmhvTS8rWm1UOXNT?=
 =?utf-8?B?c1RqSG12UW02eTBDVFk1Vm9NclZBcENqMVRvQkZuS3NKM1pjRW51YjdtYVpL?=
 =?utf-8?B?MU40dEJwOWhEWGs2ZnZubUFpVkd2dlZUeStpOXNna2k3V1AwV3FKbzdmYjBz?=
 =?utf-8?B?YWhzN2JCTFZyamQycTJ3bjloYktMV1JFeVcrK3BSWUVsbVo1V0Jxd2NqYk9q?=
 =?utf-8?B?bjdSME5jWkpjN1hhSkR3VTcvNnRLU3ZPNTBXWURmOTB6WEJ5eFUyWGRqek9E?=
 =?utf-8?B?eXRYcS9EUVFZMlUxUTY5M0NEY2h1VXhUWUYvVGdLL0VzNDEwQkFLQnQ4V3pQ?=
 =?utf-8?B?QU4rZlRaenJTUnFxL2xJSWt5Q2dBTFdxM2t1NmJoSlFXdjl5b1hQaGZ3elV1?=
 =?utf-8?B?SzJRYjJsQktwSXcveHp2U2pGMkJLaW5uYjVxS0luT0I0NnRuWVpNRC9waEN4?=
 =?utf-8?B?NHc4RkZDcUFOZWlEZE9pejcvNW1WT0ZBZ0lLVEVwK291ZXR0enhJNEdjWDZL?=
 =?utf-8?B?WCtGbTMybmx3cStVckdpTXhrVy9HRTBmQnNUbUphUU5TTStVQUNpNzYwb1hu?=
 =?utf-8?B?b1dwWlFHS2plakplSnNrQnV2ZE5raUx0ZW9IQUp5R2xmZE9NMHFRdzlIbmxq?=
 =?utf-8?B?TGZWemwyRzRaSnM4T3hFQTJtWkk2NkFRQTg1Vnl3dzZXMGZDY0FWbmNQeXJl?=
 =?utf-8?B?MEVEdkhpTDE0SDJDR2dMMEgveDZUMit6bnVUZktUZW1WNlR0V0NqQ3RKMXNu?=
 =?utf-8?B?SEw5L1J4NGxibUJObkdINHlDazVFZUZCY3dCdDU4MFpiSEdPeW9jc1VuSDI4?=
 =?utf-8?B?TVU0NDlEWFNxRGIyM1c5TUJMZFJGNG9nQk8yelgwTTNhMEtrV1FTZ1JaNlFD?=
 =?utf-8?B?dXl0djhEcldaTXQxUkhHRmJ3MFhmamFNUDhXWDBHWTBpQ2o2cGYwR1ZneUlt?=
 =?utf-8?B?M2lKcGtTSUpMQXU2NnB5VXhMNDVOMkgwV2NobVpmMHdxRkNUcGl0Q2hmNEc4?=
 =?utf-8?B?am9GSENKRjVwNWFvVlpGekdLbkFML280cGJGNW5DdGVKb2tjMTZZZlJxZHNs?=
 =?utf-8?B?N3E3RkJqQ21nMWNtYkxtK29yQ010QUxaRnJnVExwbEtBa1JQUCsrcHk2QmxI?=
 =?utf-8?B?SVpGdXV6ek1adHgxd0Q4aEhnZDZBdEFjeTRvWU9jd3ljV0dKc3dXRjRiNG1N?=
 =?utf-8?B?ajZzY3c3QW5rMEZnbFpwd1lMOEJXM1YrV0ppTEJrZVlhSE4wRDBlOHRBb0RP?=
 =?utf-8?B?eGRZYXF5bm9tSysyQncxVHcvbnRyc2FSQThldWZlWnNaU2I0dFlsK0Ywb2Fy?=
 =?utf-8?B?TlJYOXoxbjcvWFR4enovREdxb2ErTWcyVTd1WnlROEU1bmlGUndEczUwcmdI?=
 =?utf-8?B?SXZFK25Wc3RWTEhRYVA3NC92aDB6aDd6VXJDS3Z1a3NmSEg2RVdTZFRmSGlC?=
 =?utf-8?B?TmdmdFNWQkNtM0NoRnBweC9nRUxOM1NFaDdpQlorWGczc3FHWG9BanVLOGpW?=
 =?utf-8?B?d2NaQ1NyL1FEeVR6aWFOdG9OSDhDOHFjY1I0cHAwam5NMFo4R3RPVm5BZnN4?=
 =?utf-8?B?YVhZQXNqUkp5M2pvQ3RicHhVYytxVEZidXVhRlZtenFzM01pWFpkTWxDei9q?=
 =?utf-8?Q?6jMwwDsd8n+pfhMnqH9tDWwJw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vr+V5lkcw/eapHqfg8eFZfqTqDK7jf+EBkloWkX1o0S02GcW3NRycblAV8RnT7JmkTr7GwpkGVUuPQN6W0xZaXyOEeCWWtDnsXfsQJ/hq2z1vFj7oDE/JzqSf6MePoG/l62QbeegBTZNy79Wclgbtm3bmQzACurv6iM+64FPhL5lqq4dzclaxjiJLdSHRf7PpTXZpA5R+yzSsXru+OgUXxRan+eROZLdLhTxHKRKo06kHEHjecTg4izc+0KTMwbJnLZ5JQHDKFDdd8r+uel93y8/904X5Ufk7rJq0vRXUFZKrGvzXNy2lnQoCxt6BKr7Q0cjjEO56IS5vJ4Hlvmk1nXWvcUQFtCCaxfDqv81ip3f9i+fKLC6WVtYS5+PUeN2dpgqFMw4IFIlFf/W/iMoT3hjzh9HI8q70U9HdnaPfNtUeeJ/d8/q3w2x/joipkyRiEdhzEsdYF/m1ynVhXBxC2lMz3xHCSomsT7mKKrBoFp9EbBYplJOY3N5G/UrwVAuQ9hubTiHaJt6AAvaFQHcJMb6BnkBAOgO1/X15J3jtjgubBYH/NCFYcLMHYKGcxKtEJcKL2lnqf6gh8SmhDtRedKbo1U5VqD1cFK6qdokMJczXsr04C4LcHTAC1VH48Lih9eXSU6p9VaQ6CmvsCWq+70buf7U+5XYwgH9G1n5tntxNfe5R1jap2U4tJulRH4Am4FvuonjXd0yyjnsUikQU65koxo0xae84i8XVGgb7M/j8QtKAszVgKkFbo4qVwpPSc/ilrHVvUwlnVrPe0Ghua33jk8VdI7AWbkpVoiWEQXgbEqQDQ9qT1jb2sBrAsOfUfj6nQ8pSgH7ZC3/wpfaiasuxqYe8gK8uxKxb5sdC+6J64Qh9bWCU5M7Nbl0aizcxVzRw9Xrb467fCUG8DE2T0lxLatCYJiGtHnXzmoeO5w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1779d5bc-464f-453e-5c25-08db3a0dca45
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 21:51:50.7445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wp9WYc/98Z1rVkyqHEcmCbFGRPo1E+kre442RnEt13oeesl3HbE1sCI8Cix+3Fe8TVXZfsd0qiIkjf8QZEpxig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6735
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_16,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304100190
X-Proofpoint-GUID: 1S-PIcMqpybQNlVFVNmHCJyVUtBW4Nua
X-Proofpoint-ORIG-GUID: 1S-PIcMqpybQNlVFVNmHCJyVUtBW4Nua
X-Spam-Status: No, score=-4.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/10/23 2:44 PM, Paul Moore wrote:
> On Mon, Apr 10, 2023 at 5:28 PM Junxiao Bi <junxiao.bi@oracle.com> wrote:
>> On 4/10/23 1:22 PM, Paul Moore wrote:
>>> On Mon, Apr 10, 2023 at 3:20 PM Junxiao Bi <junxiao.bi@oracle.com> wrote:
>>>> On 4/6/23 2:43 PM, Paul Moore wrote:
>>>>> On Thu, Apr 6, 2023 at 3:33 PM Konrad Rzeszutek Wilk
>>>>> <konrad.wilk@oracle.com> wrote:
>>>>>> On Thu, Apr 06, 2023 at 02:39:57PM -0400, Paul Moore wrote:
>>>>> ...
>>>>>
>>>>>>> Before we go any further, can you please verify that your issue is
>>>>>>> reproducible on a supported, upstream tree (preferably Linus')?
>>>>>> Yes. Very much so.
>>>>> Okay, in that case I suspect the issue is due to the somewhat limited
>>>>> granularity in the lockdown LSM.  While there are a number of
>>>>> different lockdown "levels", the reality is that the admin has to
>>>>> choose from either NONE, INTEGRITY, or CONFIDENTIALITY.  Without
>>>>> digging to deep into the code path that you would be hitting, we can
>>>>> see that TRACEFS is blocked by the CONFIDENTIALITY (and therefore
>>>>> INTEGRITY too) setting and DEBUGFS is blocked by the INTEGRITY
>>>>> setting.  With DEBUGFS blocked by INTEGRITY, the only lockdown option
>>>>> that would allow DEBUGFS is NONE.
>>>>>
>>>>> Without knowing too much about blktrace beyond the manpage, it looks
>>>>> like it has the ability to trace/snoop on the block device operations
>>>>> so I don't think this is something we would want to allow in a
>>>>> "locked" system.
>>>> blktrace depends on tracepoint in block layer to trace io events of
>>>> block devices,
>>>>
>>>> through the test with mainline, those tracepoints were not blocked by
>>>> lockdown.
>>>>
>>>> If snoop block devices operations is a security concern in lock down, these
>>>>
>>>> tracepoints should be disabled?
>>> Possibly, however, as I said earlier I'm not very familiar with
>>> blktrace and the associated tracepoints.  If it is possible to snoop
>>> on kernel/user data using blktrace then it probably should be
>>> protected by a lockdown control point.
>>>
>>> Is this something you could verify and potentially submit a patch to resolve?
>> blktrace can not snoop kernel/user data. The information it got from
>> kernel is kind of "io metadata", basically include which process from
>> which cpu, at what time, triggered what kind of IO events(issue, queue,
>> complete etc.), to which disk, from which sector offset and how long.
>> blktrace has no way to know what's inside that io. I am kind of think
>> this is safe for lockdown mode.
> Well, you could always submit a patch* and we would review it like any
> other; that's usually a much better approach.
>
> * Yes, there was a patch submitted, but it was against a distro kernel
> that diverged significantly from the upstream kernel in the relevant
> areas.

Sure, i will submit a new one.

Before that, may i ask this question? It may affect the approach of the 
patch.

Lockdown blocked files with mmap operation even that files are 
read-only, may i know what's the security concern there?

static int debugfs_locked_down(struct inode *inode,
                    struct file *filp,
                    const struct file_operations *real_fops)
{
     if ((inode->i_mode & 07777 & ~0444) == 0 &&
         !(filp->f_mode & FMODE_WRITE) &&
         !real_fops->unlocked_ioctl &&
         !real_fops->compat_ioctl &&
         !real_fops->mmap)
         return 0;

     if (security_locked_down(LOCKDOWN_DEBUGFS))
         return -EPERM;

     return 0;
}

Thanks,

Junxiao.

>
