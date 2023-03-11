Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1CA6B5F5D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 18:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjCKRti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 12:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCKRtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 12:49:36 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5390A1ADE4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:49:34 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32BFrjAr008985;
        Sat, 11 Mar 2023 17:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=YoJC9rRYcz+rMKHKOA6Ov3enU8+Cn+FNyLlkzj4Zzi0=;
 b=IzIXD3b6z1lwdmxIjJqRJ/EsYvSJVogdUCKzs12ibM19TGvLLWmUcsUYnG9ZZtQFSkQ0
 oQcK2vSISleJWKgO2sJud9/wIDt3vKIWqHDYrmonWBz+WDlREd46AdHZ+h6vL0JK45/7
 8TkR23iCBG0bH+FuHebKCCg+8J0yzXhILzki+uOxYux+tB7qAl1/LdUx0BISmlmyQNI/
 fZkqp1sPwqS4tinPkZFZ73zFnOsyQnR9R7iNXXW6rnPG7wQowvn/IXROJcggYHifV5mn
 vaIdi7W6Gn9fK+nhCJXVTzN/IG7ur+FlppdqUN5S+x2mShzNlObrlm6Cx1OMZulZeLT4 +Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8g818nkb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Mar 2023 17:49:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32BFvwkg033640;
        Sat, 11 Mar 2023 17:49:18 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g32rkg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Mar 2023 17:49:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZAH4Acm+YPJq1Vn6rxv8WLa4tY9GDtxqQpjVuqH2rWVRwInSoqcqenf1TM838vs8gBZYgjzqh4EMP9JCcUf4dUmLEWrUb35UAJvTgEYadwK/jj7PzIWDb6WdzTMgtBX35+T23lKktMb70tW6L+4gtsdSb7YN4XM5CvNlXsdehfES+LDn+I91NMbuzilIh03ksUVVm/3x22sln8rq4c0CSrGGUJBW7l9WsQKKSsrAWJ5bFbZv0OuBvErA31YNROFH1c5giLhOSBLGEHVhnjynUqUht98sKPTcbWYsSONoX+xByjjoAOcmpesl+AFo3i1rJ80aB1pFlBtxxMaih7lTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoJC9rRYcz+rMKHKOA6Ov3enU8+Cn+FNyLlkzj4Zzi0=;
 b=WTreWcqDrrW4w5NkxgCXAm7tN2QaKxMOBqukTZ9DjiTEBIl8cA6beMizjU7mASezgl34g+AEeB0tILYXQLgKvVGtT0Ef40Qv0dPWMplIE51fCai4MbNBEeWwVzN2EJCvpZGO+zvTb76YyVXDQOx9jwS3H2QyHqMJOojonWbAhrU+BAPCv3nEMzk1ZxzvoT2JC88W2XYnLqW9Cozx8OBqdqbHjzUlslMiSZZ9tRIGpmggjCRowt0zCLL3turOEjG5VkdUz78h6NdJitl7aZOFcuQa1KMGuIspAD7nCwuNEiWX6tutP8N85HW2AuxXc8QGzqC+2bEs3auFNxNBumGkfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YoJC9rRYcz+rMKHKOA6Ov3enU8+Cn+FNyLlkzj4Zzi0=;
 b=yigyPTZ1JR3IUQ0tbeBNfL/qufltWNmKG9woPuiiTJ8WfmCXSq7bUFBtzLHenucpO8ed1i9Q2EMVvysDzU3LM5KwGNytXEJd3I3H5uAEwQeWpWGglV4hW/0REi/PlV5hTbC7sIFiaji4FaVEHJqLypdyCnKI/KBCyNwP9wmvTEk=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 IA1PR10MB6268.namprd10.prod.outlook.com (2603:10b6:208:3a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Sat, 11 Mar
 2023 17:49:10 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::7dd7:8d22:104:8d64]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::7dd7:8d22:104:8d64%7]) with mapi id 15.20.6178.022; Sat, 11 Mar 2023
 17:49:10 +0000
Message-ID: <78a679b3-42f8-09b2-d465-1220a3e05d2f@oracle.com>
Date:   Sat, 11 Mar 2023 11:49:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 00/11] Use copy_process in vhost layer
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org
References: <20230310220332.5309-1-michael.christie@oracle.com>
 <CAHk-=wgenic8Ba1WxNP=9YJXk78k9Sg6R7RLkhduYjtVy2gdkg@mail.gmail.com>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <CAHk-=wgenic8Ba1WxNP=9YJXk78k9Sg6R7RLkhduYjtVy2gdkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:5:40::18) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|IA1PR10MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: 731603a4-8035-4568-8e92-08db2258eb40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aBjkt7fho3m//D9DF+KZ6v+OfDlGEkJIcKuLMD1FbjQchwMBKOUM45SXlUX01b8pS80cmEVTB4hYayK++k6t/VACFfmZxfB409Q2uGtDoIl6hR3YLOHCBO2ZI6i2jPtVm5HoqZbIvdNWZy3Q0xWDy3zFN+1j57XwHVjT9YhFZqGmEM6w4ZLRr32fTfdikjNOJWZdHFKVJ3QyN+RhFPB16mUYQIq/3LE2D7JrdK+QehsJUK/eO7jgc/oA44uEplAOTJGwN/GDTNsx2u0jIDEkrDsl6gYUvIFhrSEIMFa7jRJYeTEH4g/YrGfkmyAWeXsTuGwTD1TWk4Sz8AZgY9iUJ45ZOYHqLa00ZmTvp9Tk+UFW6+Kw07ZP+BcYyQulCCaP9G21cbHcILcNJCV5od2WpfL+V6R3yFA9xvOqbCz9aP6ZoGApyAiabKd7U2NMDYrN+tTBytc3jpBGa3PjIReQt8AoAGphip1Vqa8ZBG1fq7Jy6OmCDXzt6RPio4w90WzZpnt8QCemH8VBPIPjGbb97SmizwcUPtPzGMTLgLTCsSvC46A4DacHF/lVn3xtvXKMzrjXduaska4+WEN3R3OhHLowQ1zHVZP18o16zAmI3IpvtA3WC8CTwbnpbLKxxZ/JX/XwFSHU0APGbBSxkfq2NI6qBEsBAq1yiQVNMPtocaE+gS4mgJC71Rp/xn7EJ3QOYJ00S1Vz59cDFawr2AIci3L7+Uf3hCugt6bkcox+IO4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199018)(36756003)(4326008)(8936002)(26005)(5660300002)(7416002)(8676002)(6512007)(41300700001)(6506007)(38100700002)(53546011)(6666004)(83380400001)(2616005)(186003)(86362001)(316002)(31696002)(66556008)(66476007)(6486002)(478600001)(6916009)(31686004)(66899018)(66946007)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGRFS2E4ZFFWNUVOY2FWbGJGNHBJN1NTRlBmKzVjd04xK1RtMy9Jd2pOL0hV?=
 =?utf-8?B?L2liTExvN1JnY045Y1NRNHdGV0RIeE0yM2pMMnV4NDFyNW43bmlNMU8zcFQ0?=
 =?utf-8?B?MVptakpxZVJNN2pjMnVOdGdxMGxORUJxOEVBNTFUN0Vlc0JieDdRcGhPUmZj?=
 =?utf-8?B?ZXU0a0Vlc2c2VUJkSmVlMHRqQjJHS2FyWTZ1UEpHanAxSUpPRVpzejJsbHQ1?=
 =?utf-8?B?TzZlZWY3TTBaZmNqSXhLZUhWQnc4Sk1qcXVZZ3V2Q1JtYUlSTzRsTitRZjZm?=
 =?utf-8?B?MHVhc3pBL1RVWGt3cC8wWlFIQ2duT250NmF1ZlNrdFg4bmhVMU8wN0U0TzFQ?=
 =?utf-8?B?QlB6U2diSUhMbWlGN1VobXp6bUludGR0eURCN2F4MnVNQ2tkOXVvVndvOGFH?=
 =?utf-8?B?bXZULzNYRllHNFVlaGQzQVJxKzVWd0ttVGl5Y1hPVmt2dkxMTFZFa2RNcVhO?=
 =?utf-8?B?SXRGalpsU3hDU1kzZXc3ODJObkg2c3pldFNjaERMWEQrZ2NpV0FzQkpvZHpH?=
 =?utf-8?B?dXlGREFJNTZmQlQ3anJ0dWtXdWg3MDlUc2hSRkZ3dUJIUkNYV1pJMFU2aVR0?=
 =?utf-8?B?UFFNcmJsUGFNOEdWQStjbjBCVWZVNzdXS29SdzNnWEFqbkdqb3hLSjRPRlMv?=
 =?utf-8?B?REx2emZ1OURXNGNWYWQzZEJEOXZuc1p4UElyWmNCcjFpTnJrb2d4TFBRVFpY?=
 =?utf-8?B?dXU5aHgycmxrM2pPUjRMOXlGZ1V5SUQrcGpxOFJkVFg3YnJXSnBub0sycXpZ?=
 =?utf-8?B?UFp6bWtBRmhoYVJhQ2tzZFpVNnZyUFRnM29WL3JGNEV0TEloV1hscHFyRWlu?=
 =?utf-8?B?cjRXMzhyRVoxbmxhanBtdTRvN2lQVitWRUw1NUljbXN1NkxmYUh0dDVuSXFk?=
 =?utf-8?B?RVVXNXlNUWJoR0ZYQkJkWTFKRjhUUENYbkY2VnlPYXBDTzFQTU1VSjAxZTR2?=
 =?utf-8?B?MlFSQ3JVbC9VbzgzbnVsSVVXVzlVODBEVVY1TVorbkdsNU9ZMkUyUDQzVk1l?=
 =?utf-8?B?MGZDZUdPS3BUQXl3UXR2VVp5ZkJoS0hobnFFajZ1VklTMStISGxQcjFvMEJl?=
 =?utf-8?B?am9YV1FMTTFzRS9RdTdoMUxhYjRmR05GZk0zMnJkZGRBWW5RZmZybS9laFpv?=
 =?utf-8?B?TW9lNHg3V0ZDRi8yQ1owaVZNOW55UklYTmR1VnpWMldBRHJSQm1QUEo3aEpX?=
 =?utf-8?B?cGxTR3NDZVNVQ1J5cFFKTzFjR0xNSDBvMmZkTDZPQm1FRkhDMmpDWlhiWk8r?=
 =?utf-8?B?ODUrOWovSHRmVEh2cTkwNzFCaHBWZnZhWWFTeWtOYzBVdE1hck1wcGltSVgz?=
 =?utf-8?B?MEw4WkhUY0Z2Z0ZOdGRLRVUyYzcrM0xIRStHYjNjc1RtWGJqbW9xb0ErTzZy?=
 =?utf-8?B?K3djbWhUVWpJTGhneVA3MFVjb1dvK1Uyb01aL1NmR3hUWGZNRFRlNEM1QkRZ?=
 =?utf-8?B?bFMvTkkrY1ZDUWMxKzZXN1I0R2kvU0hZNnY4ZTBPRmtUQU5rdXJrNUpvaFow?=
 =?utf-8?B?N1czdDJHUU10NSs2ZjlWRUE4MkJVSTdaTUthZ1NOaG1kSkFIZUJ5Y1daRWVN?=
 =?utf-8?B?bFhwNUl3Z2RvaU9tYy9FZlBXbmFsK1lVbmE3blZjTmd2dmw3eUtvdzBTajFQ?=
 =?utf-8?B?SzhlT3RWcE0rdStrTldabm9WWExtNDNTN1dqT3ZXN3pGU2I3RE5jbzRZNUF2?=
 =?utf-8?B?cWU5VkF3dEhaUHlqWmFDZzBldHhTZ0NsT3lyUU9kYjEyb1JTOHc0cGladnVj?=
 =?utf-8?B?L3MzellOUGtScWVEdlh6Z1o5Q1laSmRDVk85OEdYN012ci9NTFN5d3VZYlcw?=
 =?utf-8?B?QmZTTG90NlVsQXprTXlQN2tEclFQNHdWWThoSFczc2kyemJZeVgyTHd1NDR2?=
 =?utf-8?B?R3dGY0pvTHFoaW50WXNkU0c2a3IvQ1NZOVIzN01QcHFnWHA2eUZSRHdVS3ZB?=
 =?utf-8?B?MEJMVVBnQTM5aW9yWXVUYWtVRUVoUXJrUUZzZ09UUkFzQmZaNUJUY1NMODNz?=
 =?utf-8?B?UWRjeXRtMXZkcVlReWhnbW1zQVFrQmlEMjZ3TVNDbTZoR2RkZUUra0hZaEpL?=
 =?utf-8?B?OUhOdkZaOTQ0V0xvSHVRWUxMVHQyUWc0K2dZcG4yOGt2M2VzekRzY3phaFYw?=
 =?utf-8?B?TlFPSDJDUUpJUlhodjQwYnJzWEkwbDQ4bmxHWmxGUjdUS2UzcU1WTjkwMStW?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aCs4N2VqUWxRb0lqRnozL3lUNUJCSUR5V1VFVXIxQlM5RG5PSDRrT001YjQx?=
 =?utf-8?B?dzZ5UDZ6dFY1UE5yQnROb3hxeHdiK01ldTZIR2txRmlWZW5CWGlaWFRFcGdr?=
 =?utf-8?B?Vi9FZU1ic3RwaXUydlJ6MjRjYWMwZE04bFo4ZnFFOG96MmEvVVg5N3hyUlo5?=
 =?utf-8?B?Z1BJM0xFdWdjODUvamNwelVNS1kxRXcxd29CQjdSZWt4bHd0OUJMR3dZbTNI?=
 =?utf-8?B?c3FscS9zMXBOelVNKzZHMlFZc0dXSkFzZnl2emQ2QUxjUThTOWl0bkFseWRM?=
 =?utf-8?B?QTI1MmlBRHRHRlpDL2djLzFNeGUyQXdjbDkzTHc4RUxVZ1lhOUNoMnVJOHlm?=
 =?utf-8?B?MXA0WjY4bittT0dQVzY3VFdCa25UalQxRkhndVRVcWdOemw3a1haeitQcERs?=
 =?utf-8?B?RC8xTHhkR05Ic3N1ZE1LOGxVdDhBR0ZrY00zTmd0Nnl0UGhZMGI0Y3BLRXFB?=
 =?utf-8?B?QnBwMWp1OVA1MWFPcW9lZ2IraHJveklXdG5YK0pFRk4raGpVcWdmWXlCUXlF?=
 =?utf-8?B?L0R4dG1FRjVwOGQ0V0txUjdidTBnYTJJSmJWTWg5cFpkUHBrRStEa0M0VDFj?=
 =?utf-8?B?b3BuUmtoY0NiRGk2R0ZQKzA2bTFncWhDNllYRUpRYjc1eWViMms1T29Ldy9Q?=
 =?utf-8?B?eTF4VWF1YjBjVTNWUFlVclJESE1ZVnRyMzNrc01kY2RDbTFOSDV4dHFqN1hx?=
 =?utf-8?B?bjRXUnFSRU9ISGV0QnZ5OEdFeG10ZWZ0TXFRdDVTZlQyN2tXVVVsR0FlazRh?=
 =?utf-8?B?ZHEzQSswUTFqR0dhMHJQbEpscTd1TzUzSTBtb3huUVB0cUwzSFRzZUJnck5z?=
 =?utf-8?B?OXZXSjhxazlvRVBOVi90eGMxMWcrU1NCRVB4dXl4TjlOZ0pBcHhFUE8wRnZl?=
 =?utf-8?B?LzlBc2hHR05tMUt0MmJEV1dib1Mzb25pcnlTcnpMRVlqS3J3TWFxSGlCK0ZW?=
 =?utf-8?B?S3NoRWxZT3ZBdW9qQ3ludDJhZ2dKT3VMY3lkTUlhR1ZBUG1IQjlDRXE1Mlhr?=
 =?utf-8?B?ZXUrOVhtSU1kcWZyQVI2Nm9MSWdqMG9WaWNiQUt3VVl0SGp3d05KcnlHUlp0?=
 =?utf-8?B?WHhCTkxHeXhGNHl0Tm11MlNWSkRyL0hjOWsxU0JKcnowUGRFUnRsSWU2WGFs?=
 =?utf-8?B?a2xuMjFzU0wzVTBjWTFDYXRZdkNQNFhzalI1ZTVKdytxUEF6VWdJeTkxcTU3?=
 =?utf-8?B?UC82aDN2TnB0ai9aQ2lhN2FSOFpVaTl3ZGpJT1E5YVVxRG4xZGNHcFljWEE4?=
 =?utf-8?B?OC8zZFJKeHZobmplcThsR0VUck1EUVdwK2hSRUprMEd4Q05WUWwzek9PUGZP?=
 =?utf-8?B?Z1RtMmUvYjFZSGk1MmxFZ1A2VEFxaHAzajU5WElKUUw1STdWb0RZeUlOaEpZ?=
 =?utf-8?B?Nys4TjJ0Z3BBaWc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 731603a4-8035-4568-8e92-08db2258eb40
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2023 17:49:10.4274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QsB2Jn6R2TXC/2ZTWlJlgS9nv98UNHLteNj2etN+l4YQWLfBiKRtbgU7Zr3CFiGcw8O+F1nWLmERUDT0n1wphfB/dsAoVqxUaYX8H3rjsI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6268
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-11_04,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303110161
X-Proofpoint-ORIG-GUID: KXVYA2PFkDDLsxtUfthWseMfj8gB577E
X-Proofpoint-GUID: KXVYA2PFkDDLsxtUfthWseMfj8gB577E
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/23 11:21 AM, Linus Torvalds wrote:
> On Fri, Mar 10, 2023 at 2:04 PM Mike Christie
> <michael.christie@oracle.com> wrote:
>>
>> The following patches were made over Linus's tree and apply over next. They
>> allow the vhost layer to use copy_process instead of using
>> workqueue_structs to create worker threads for VM's devices.
> 
> Ok, all these patches looked fine to me from a quick scan - nothing
> that I reacted to as objectionable, and several of them looked like
> nice cleanups.
> 
> The only one I went "Why do you do it that way" for was in 10/11
> (entirely internal to vhost, so I don't feel too strongly about this)
> how you made "struct vhost_worker" be a pointer in "struct vhost_dev".
> 
> It _looks_ to me like it could just have been an embedded structure
> rather than a separate allocation.
> 
> IOW, why do
> 
>    vhost_dev->worker
> 
> instead of doing
> 
>   vhost_dev.worker
> 
> and just having it all in the same allocation?
> 
> Not a big deal. Maybe you wanted the 'test if worker pointer is NULL'
> code to stay around, and basically use that pointer as a flag too. Or
> maybe there is some other reason you want to keep that separate..
> 

There were 2 reasons:
1. Yeah, we needed a flag to indicate that the worker was not setup
for the cases like where userspace just opens the dev then closes it
without doing the IOCTL that does vhost_dev_set_owner.

2. I could have handled #1 by embedding the worker in the vhost_dev
and then just testing worker.vtsk. However, I have a followup patchset
that allows us to create multiple worker threads per device. For
that patchset I then do:

- if (vhost_dev->worker)

+ if (vhost_dev->workers)

so I think it just saved me some typing.
