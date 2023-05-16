Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFAA70505F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 16:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbjEPOSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 10:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbjEPORw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 10:17:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE9872B4
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 07:17:45 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GEDpYq001547;
        Tue, 16 May 2023 14:17:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=t5foa9uT/MuVwr30fxcMoTpFIzjq1cce81v2BltxQ0k=;
 b=r69QG9YwneMf/yudnzv5GxaL3gEhhHTjeLeaZUh3SYkXw4lku961DYmr3ybXMidm5hLm
 i33W6snofBIFnHtR+PmVQqWxmmXjrSKB2mpbVl9uhxKecWiUA6tpE9uuEOessz4sHFc/
 VmUi0GH6cGJY0m1fDgp+0Qrj/rbECTneKcLakn2Qn9w29FLH1IEW32tx8byLvf6sbqqA
 Q1tpX8alci3wHWCJuyGvhiDfKT//VX64A6jhPaz8Jnq7Sbe8K12vsfV4H87z3mVtcGjQ
 yMyidkwNz96dPlXEpps+Zrlj+68Q688Fw+bPnPG4mtxAKx1dz/qsh8DXnIk0IKc4SdiZ SQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1b3ubdb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 14:17:23 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34GDsSZ2004165;
        Tue, 16 May 2023 14:17:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10ad559-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 14:17:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHbxZSIR6r+pqmcEpPdOUm9N6kEWV60a3FUScVYPjKmv/5tarqz9qcUMOVjmPw79zY9TdyA4AAqKLHoSZ3gfYkYczSCPjO6a1WvU7OvcFCKIaID3vBcm4BtSTmvnolLOx35XAFFC5pLz+dQne9fLV+t9FqXUiePOU1oCBl03dwl9nEFzimb+5u2nm8D45rBhKmKo3cX0p4iJno6EXRkKzJNF/blvTab5eYnuY1is0yCfiuYVBlo/9jPjy3KKOujrrs/z/VkpzLO8wyMfiPycmhACChsI0CjPEWTrpco30Y1VBemeirM3pL0JQOu76rPTruQxw0+oXQhRlA5JRpwQAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5foa9uT/MuVwr30fxcMoTpFIzjq1cce81v2BltxQ0k=;
 b=WFtyY43gDlRDWMXh71ucC5X92hv2C5M7PMNP8/6ujrJvV29TUJR8p7xJBu4x/sbOYpCoaQUAR7E+Gwe9Oeh+d42IqGgOhv78P4Mf1ctx0NCrntlrrGs0mKnCF1r0lEswrfHNfgXlD3NktuCxtpu43k3hFZLlXsUPqxaY9iWQphehMU/9NaqP5iRjYXV/1ICV9+FchHwZ99VVX8Q3I+D72XJKtHVQ6nw37e4Rb7yqu8rGvYcd2c9e/rHbBx95D2k82QX0k72fIyOABbgfOs04PTUxt7Y6yROayXFieKrYaWGt1avb4GuBijO3oZ7CVibEHz3wA3KZZqVxfhwUIpbOEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5foa9uT/MuVwr30fxcMoTpFIzjq1cce81v2BltxQ0k=;
 b=pM/6G2xnO48JFEBuW1F9cupxFPS0WBLyLUfciNf1qL7KvZ6l7pRPpQl+pgN7acBch+VwXLJihin3e22hFhWM6f3pIvD4rAZROel2iLsJS3Fkvtj/T9OAZuxz3P0ipDgVho6AkkG3ES845k1ZBPaEiaBRHSqneHfmwEXToOJMoNc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY8PR10MB6707.namprd10.prod.outlook.com (2603:10b6:930:93::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 14:17:20 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%6]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 14:17:20 +0000
Date:   Tue, 16 May 2023 10:17:18 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH 09/10] maple_tree: Rework mas_wr_slot_store() to be
 cleaner and more efficient.
Message-ID: <20230516141718.ts6yffyytm2vpwhx@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org
References: <20230515131757.60035-1-zhangpeng.00@bytedance.com>
 <20230515131757.60035-10-zhangpeng.00@bytedance.com>
 <20230515180147.hgwk2vccsph7poxa@revolver>
 <4e40b88c-4419-56df-d720-177cf76e95a6@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4e40b88c-4419-56df-d720-177cf76e95a6@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0411.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::28) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY8PR10MB6707:EE_
X-MS-Office365-Filtering-Correlation-Id: 8961750e-49aa-4f19-c4a3-08db561842f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PM06wbqlw+PVmhprmqjcFJ0bjCpzScPMxYD28McP0HFUcMDPxpqwS8KEzzhUkhMy3geOnNrhtmIhW62MQThxFtgHpEZn8pQ7JpU9HoG7ivg8u9NyuBGi6/9ogrATw21uKuqfsg2ZtTSNy6+4ZQXdMot3xMs/5pBBDwsdT3/dxRsNW3FJPTmFeU+gpQPPaj0Pn3Ic/H9fmVGVfx03DptYwN2lYthm8c43/bML3TBEuD3yJ8l5MP0oN6Dt1oy55ZEa7bswnZhSd03vr4G9Zy9rIG9EAWnvb9bbHHeHifiU0VT3E8bqtzFzp23OfJ++09eLz/8GZtUkNVP4o6yGmWBRz0Nq8TQH26r9OycnQJwNDxvIhgASZR0Iw4umxnSQx9B6grTtuAqPHOc0IoOGQH7dYVNPNUlkTg4sYKygzCidX/eQ3490cNy6+he2OqHOPeWXE30TYHpvzCZ2hZAHWln6dWh/p5ztnfsCTTqxj0GjZkli1Ot/iTLPWXI9+NJK3yGdEC3O/fTQf7WPn8OqI7iwPN5mhmlRlGlU78MaOKA3HiPwIEHT2W8BXS6yI1uTS9/s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(376002)(396003)(346002)(136003)(39860400002)(451199021)(66476007)(6486002)(66946007)(66556008)(6512007)(6506007)(9686003)(316002)(4326008)(6916009)(478600001)(41300700001)(5660300002)(26005)(186003)(8676002)(8936002)(1076003)(2906002)(83380400001)(38100700002)(33716001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2hFTnV3VVF2Uk9GRGx1WmRUMmlBb0Z1R3dVdmN4T3NGRDNqWmhoUlh1MUxV?=
 =?utf-8?B?NnZ3c0x2K3g4VUtGSlMvOU9HQzM3bjg0VmFxc04yRFlnVldZQmtaVmF1RVEv?=
 =?utf-8?B?Zk05Rm1uMWVNKzFRVVFyYWdnZWpUN3JyaW5ZWVplWHRYUVQvQTlwaUFWZlAv?=
 =?utf-8?B?L21uQWJRZFo0b2NDdUZ0di8xUi83Z1lLZ3lOSG84K1c1STRwUzhwaHZ4RHMy?=
 =?utf-8?B?YVJ3WTB6cjYwbkJweDhXc3JUTXBPWkFhdUVqVXhIejRUMmQrdFhaVCtlYjUv?=
 =?utf-8?B?REJuelI4Ky9FL0FnVUtYSFh3MW13c25Ja3dNV0hmQ3VQUEhrdXVEWUpaSXcx?=
 =?utf-8?B?bVV5UnFidkNHOW9UcU4xZCs3czAwMUFrTXhzNFlFcUhrd25GQXhkWkh2dk9I?=
 =?utf-8?B?bXdRRXRacytaSWZIdVcwcDA4Tmx1ZXNiU2dLT3A3c1FBbld0WUZaZC9WcXFR?=
 =?utf-8?B?c21pT21mVDIvYVdOaXJ6dzBrOXFIbTBPbDY2ZlJ1VDJsVXRDckRKNXZtVGxN?=
 =?utf-8?B?TU5SeGxMbmthcVpYUHh2dzhjU1pCcHh2a09sSnRuWDdSZGVpUVNJK3dvVlZC?=
 =?utf-8?B?ZGlLRTRiOTMxUVF3QnJxcGRib2h6M3JPNnRkeTlRbXRERDVtZW1GY01LQ1Vk?=
 =?utf-8?B?SG4xY2hFOUJyN3JER01BWTdkZ2JlL09nWWlNcjVUOUZGK3VPV2xwZ1FmalNP?=
 =?utf-8?B?bUFZd3hQM1ZCL2dCSVFvM3ZMcDlZR1RxKzlpUHNlVXROTnFXTHRBMkExdjlv?=
 =?utf-8?B?STlnYkFCY2dYSHluakZlaTdDcDdZZmx2aWZtblNBRjB0QUNOLzdmWVFJQm5x?=
 =?utf-8?B?d1RWNjNGVWlqcFpycDBvQUxtV29CdkJRdm1mOGJYZGlUNnBSL3hNS3ZJTVk3?=
 =?utf-8?B?K2pOWjN2ZjdqOXVUdUFlbW8xcGFuR01iU0tobHErdTZtY2l3cDlnNldDRk1u?=
 =?utf-8?B?dmhDYUU0c1lvU0VKSmk2dWNHQzRnbWk5UXNCclBmbTdBa0ZSZVdhcHBhakFq?=
 =?utf-8?B?K0ZFRE1MbSt4Uy94OTM0aUhnTDQ5VUhLcUxKcmNtT0R5d2Q3UWNvd1RKTlNR?=
 =?utf-8?B?TzByWUpOeGdYRk51UndMckxzZm9LQm5tbFFIS3NUaXBsL1V6R1VVYW82NG9l?=
 =?utf-8?B?TTVJK1ZxbllPVnVHbFpNWHFWalV5RVJMdjJ5MmtabWcwb2gwdlBNT2NDeStm?=
 =?utf-8?B?M3M2TUJiTk0rVGE4Qyszbkl1bkNMQWF4YlhVYVg0UG54TlVGa0F1YklCSTBm?=
 =?utf-8?B?SmtPM0VXQXhORGltNDJ5WnY3N0gyZHBzbnMrcXZjUHJOSGcrNGg3bTlQOHk4?=
 =?utf-8?B?TkQzQVNpNytWUnRLQVl2ekdHeWs4N2ZJRjczbW8zcWp0MEpvdDArNk5BMXpx?=
 =?utf-8?B?Y25Hai82bHFwMlR4N3VEazJ5QUFJQy9UUTRyVUhLSTNjNnV1bDlRc25qMzR5?=
 =?utf-8?B?NjZPQXFTMktmUW9yVDIvYktEa1JsNTlqd09tRGdEN1pFV0dIcjlyTUtPOXpE?=
 =?utf-8?B?Zk96MGpaaGRDWVZlN1VtaFB0eCtFMW8yMk9ESFFGY3NZNmJiRW1XcEdubCth?=
 =?utf-8?B?ZDdEUFgvbXpuenJiTHloZkdEdytzSE1hUGV4bUZaVnhJVThUK3hvNGJKTEh4?=
 =?utf-8?B?YVUyYmdmUlhVK2pYbDdaYXpQOU1FSFZ4ZmRWTUx2S2tYS3R5djN2ekN2dE00?=
 =?utf-8?B?M2xwNlNSc2doYS84THdaK3JsaENRR0dZTmpCTEtEK3E4ODRmYnpFcDFXZ0FM?=
 =?utf-8?B?aUk1Mm9jVFNadWpPM3RqK0REMW0za2NXK1BQQWI3bGVsZENuNElMZW9UaEh2?=
 =?utf-8?B?WGQrZUgxWUZvRHA5SHFhQTg3UWgwYTJqS1ZzTnlQajVYVGN0QmwwdHVnM3hh?=
 =?utf-8?B?SWQxZGkrSVJuaElFT2ZmU2VYcTNiQ3AwRFE3VGV0ZUo0R2xmUi8yYXFlNFR0?=
 =?utf-8?B?RE1JNnVxcExmWE1CYlovNTZJMDI3cW9HS1NJcmlBSFVwTzhZSXlsY3oxcUlW?=
 =?utf-8?B?MEpXaDVWOWZXOWxvTjlwcFF4aGtiQUpBWTIwQlhXUFVCM2M3TW1PWDVvZ2c4?=
 =?utf-8?B?d2c3NWR2Z0NPaHI1U1U0NmZaRUtpVUhIUEVpYkpoRmVTYjhseDNrYTRHRkZ0?=
 =?utf-8?B?c1NFLzNva0xGcGhQSG1mVWtwcFo5dVFzdUUza1JPNWs4WVppcGhJdkU4Yi9S?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bFFjdEN2dmEyN2doSkhhZXpzeWorM0ozMkFjMENqZHlGMzVyNTgrM0pYTGFE?=
 =?utf-8?B?T2wwYSs3elA1NGJBanV0OTRQQmVMVXVYeUEzUTJoNVJlN2xsZmFyV2hIMHgw?=
 =?utf-8?B?ZVlWNmFSRzRDRFBzYXhyNDU3NmtkUkVmVXhnNkRWdnFaL1NYNWhncFJIa0hu?=
 =?utf-8?B?U3o5Y1hOMGJjcWpWbUswdEJ5NnFDUDhaK2IrQ0FmMXhYK3RhcmUzWHhFR0JS?=
 =?utf-8?B?bEdqUnZIc3NXZnNwTjdNWnhnekRSUTBna0tGc1hPeTFPb21sYXgyeUhwcVh3?=
 =?utf-8?B?QlJ0ZGtwRC9qSG5nenlmWG9zMnBRaWtLbFFsZHB3ekVNbHdMVnhhcXlib3hC?=
 =?utf-8?B?RmZ3c0NDUWlIS0ttSkV6dUpKL2orTWFkRTZTQktHdGNmQ3FHUVc5T2ZHN3J0?=
 =?utf-8?B?eXBWVnB4NEhyTlhRa1o1OEx2VjQ2aGt5dGJUTW5RUjd6d3FrdXZWWmFlK0xs?=
 =?utf-8?B?dGVIMXhVK1UrTkZjSWx4ekVrSmo2YWNIMXJEMVN5VWlSNUZyQmlCWjdnUy91?=
 =?utf-8?B?emxlV1NVTkNyemgrNWlmTE5KR0lBeEpaK2svdFU0TlgrQlJNcVJJaTJSRjE4?=
 =?utf-8?B?Q2ZXZkxjaXEzeWNKalpoWnlXNVpzYldCeDg2WlFreDF5MWRpdEhZQnU1dlF3?=
 =?utf-8?B?QVpSQmhiWURFMDFTSTg4bytuNUhjWENWZmN6WEZYSDVJZVBHYUx6Q3VPTWVj?=
 =?utf-8?B?RDI4QUsrQjRabVhMeGxJQ2pydW5mRDJjeWpOOGYwL2ZKa0plT2xiRm9UOERk?=
 =?utf-8?B?UFphV2VCajEzc1h0UXpQU2FNMUJlaTJicjFkTHZuNkVxMEQrSDRKQnJTMnhi?=
 =?utf-8?B?R0dzVFFQL0ZwRDM4YUlobUhEekV4aDN2aW5qaTZpeGtRMXNieHNDQzdRYVdX?=
 =?utf-8?B?K1UxS25OaisyaDFQaHVsRHVzK1U1TkwvNFZnVVltQThqVU9tT2hPaE53c2t4?=
 =?utf-8?B?NGVISENvRXJjUUVEQys2TldQTEkrMVR4d3N3TzRETEs3dVRpVWQ3b2oyU0h3?=
 =?utf-8?B?eHVtbkVKZCtUcmQ0ZXJWUHc1YnlaeE5uaXVROTJnSWIwbWY5NXVTOW9qbkxz?=
 =?utf-8?B?Wi9RZkhvSmg4dTB2QVNyVGp2d044WE84N1NYR3BXTEQrM0dqdlYwUzlMZnRl?=
 =?utf-8?B?eTU1NC9Cc0huQ0lRRy8vTFRXbFMzbTQ5NlRDVHJUT2tWakNnRDVxaVBqdFN4?=
 =?utf-8?B?OWVvbDZWV2N1SmxVdE5uckY3Y0R5Z3RsUEEyM3hEQzk0anFMQ003Mmw1UTQr?=
 =?utf-8?Q?0VMIupYKAth+bb9?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8961750e-49aa-4f19-c4a3-08db561842f4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 14:17:20.6497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AT1eUdgrR+E5wOZysK1k7AfgwjAU4+ruz3SclTiUJxBZHOaaSX2j3+Lx9tk7iB7LIZ6qcvsKMTDNa9d702N0YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6707
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_07,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160120
X-Proofpoint-GUID: 5u4lsqTD159I2ClN4sgRZOpY62phtAKn
X-Proofpoint-ORIG-GUID: 5u4lsqTD159I2ClN4sgRZOpY62phtAKn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230516 03:27]:
>=20
>=20
> =E5=9C=A8 2023/5/16 02:01, Liam R. Howlett =E5=86=99=E9=81=93:
> > * Peng Zhang <zhangpeng.00@bytedance.com> [230515 09:18]:
> > > The code of mas_wr_slot_store() is messy, make it clearer and concise=
,
> > > and add comments. In addition, get whether the two gaps are empty to
> > > avoid calling mas_update_gap() all the time.
> >=20
> > Please drop the cases from the comments.  These aren't that complicated
> > to need diagrams.
> >=20
> > Case 1: Overwriting the range and over a part of the next range
> > Case 2: Overwriting a part of the range and over the entire next range
> >=20
> > >=20
> > > Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> > > ---
> > >   lib/maple_tree.c | 79 +++++++++++++++++++++++++++------------------=
---
> > >   1 file changed, 44 insertions(+), 35 deletions(-)
> > >=20
> > > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > > index 538e49feafbe4..d558e7bcb6da8 100644
> > > --- a/lib/maple_tree.c
> > > +++ b/lib/maple_tree.c
> > > @@ -4190,53 +4190,62 @@ static inline bool mas_wr_node_store(struct m=
a_wr_state *wr_mas)
> > >    * @wr_mas: the maple write state
> > >    *
> > >    * Return: True if stored, false otherwise
> > > + *
> > > + * Case 1:
> > > + *                       r_min   r_max    lmax
> > > + *                 +-------+-------+-------+
> > > + * original range: |       |offset | end   |
> > > + *                 +-----------------------+
> > > + *                         +-----------+
> > > + * overwrite:              |           |
> > > + *                         +-----------+
> > > + *                        index       last
> > > + *
> > > + * Case 2:
> > > + *                       r_min   r_max    lmax
> > > + *                 +-------+-------+-------+
> > > + * original range: |       |offest | end   |
> > > + *                 +-------+---------------+
> > > + *                             +-----------+
> > > + * overwrite:                  |           |
> > > + *                             +-----------+
> > > + *                           index        last
> > >    */
> > >   static inline bool mas_wr_slot_store(struct ma_wr_state *wr_mas)
> > >   {
> > >   	struct ma_state *mas =3D wr_mas->mas;
> > > -	unsigned long lmax; /* Logical max. */
> > >   	unsigned char offset =3D mas->offset;
> > > +	unsigned char offset_end =3D wr_mas->offset_end;
> > > +	unsigned long lmax =3D wr_mas->end_piv; /* Logical max. */
> > > +	bool gap =3D false;
> > > -	if ((wr_mas->r_max > mas->last) && ((wr_mas->r_min !=3D mas->index)=
 ||
> > > -				  (offset !=3D wr_mas->node_end)))
> > > -		return false;
> > > -
> > > -	if (offset =3D=3D wr_mas->node_end - 1)
> > > -		lmax =3D mas->max;
> > > -	else
> > > -		lmax =3D wr_mas->pivots[offset + 1];
> > > -
> > > -	/* going to overwrite too many slots. */
> > > -	if (lmax < mas->last)
> > > +	if (offset_end - offset !=3D 1)
> > >   		return false;
> > > -	if (wr_mas->r_min =3D=3D mas->index) {
> > > -		/* overwriting two or more ranges with one. */
> > > -		if (lmax =3D=3D mas->last)
> > > -			return false;
> > > -
> > > -		/* Overwriting all of offset and a portion of offset + 1. */
> > > +	if (mas->index =3D=3D wr_mas->r_min && mas->last < lmax) {
> > > +		/* Case 1 */
> > > +		gap |=3D !mt_slot_locked(mas->tree, wr_mas->slots, offset);
> > > +		gap |=3D !mt_slot_locked(mas->tree, wr_mas->slots, offset + 1);
> > >   		rcu_assign_pointer(wr_mas->slots[offset], wr_mas->entry);
> > >   		wr_mas->pivots[offset] =3D mas->last;
> > > -		goto done;
> > > -	}
> > > -
> > > -	/* Doesn't end on the next range end. */
> > > -	if (lmax !=3D mas->last)
> > > +	} else if (mas->index > wr_mas->r_min && mas->last =3D=3D lmax) {
> > > +		/* Case 2 */
> > > +		gap |=3D !mt_slot_locked(mas->tree, wr_mas->slots, offset);
> > > +		gap |=3D !mt_slot_locked(mas->tree, wr_mas->slots, offset + 1);
> > > +		rcu_assign_pointer(wr_mas->slots[offset + 1], wr_mas->entry);
> > > +		wr_mas->pivots[offset] =3D mas->index - 1;
> >=20
> > These two lines need to be in opposite order to ensure a reader sees
> > either the value or the previous value.  If you overwrite something wit=
h
> > a new value, it is possible that a reader looking for the next range
> > will get the value stored at offset (but not entry).
> Please think again, did you think wrong?

I did, thanks.

> It doesn't happen, swapping the order introduces the problem.
> If we update the pivot first, it will cause a part of the value
> of the range indexed by offset to change to the value of the
> range indexed by offset+1, which is illegal.
>=20
> My assignment order remains the same as the previous version.

Yes, you are correct.  There is a place where the reverse is required
for RCU, but that's appending.

>=20
> >=20
> > > +		mas->offset++; /* Keep mas accurate. */
> > > +	} else {
> > >   		return false;
> > > +	}
> > > -	/* Overwriting a portion of offset and all of offset + 1 */
> > > -	if ((offset + 1 < mt_pivots[wr_mas->type]) &&
> > > -	    (wr_mas->entry || wr_mas->pivots[offset + 1]))
> > > -		wr_mas->pivots[offset + 1] =3D mas->last;
> > > -
> > > -	rcu_assign_pointer(wr_mas->slots[offset + 1], wr_mas->entry);
> > > -	wr_mas->pivots[offset] =3D mas->index - 1;
> > > -	mas->offset++; /* Keep mas accurate. */
> > > -
> > > -done:
> > >   	trace_ma_write(__func__, mas, 0, wr_mas->entry);
> > > -	mas_update_gap(mas);
> > > +	/*
> > > +	 * Only update gap when the new entry is empty or there is an empty
> > > +	 * entry in the original two ranges.
> > > +	 */
> > > +	if (!wr_mas->entry || gap)
> > > +		mas_update_gap(mas);
> > >   	return true;
> > >   }
> > > @@ -4418,7 +4427,7 @@ static inline void mas_wr_modify(struct ma_wr_s=
tate *wr_mas)
> > >   	if (new_end =3D=3D wr_mas->node_end + 1 && mas_wr_append(wr_mas))
> > >   		return;
> > > -	if ((wr_mas->offset_end - mas->offset <=3D 1) && mas_wr_slot_store(=
wr_mas))
> > > +	if (new_end =3D=3D wr_mas->node_end && mas_wr_slot_store(wr_mas))
> > >   		return;
> > >   	else if (mas_wr_node_store(wr_mas))
> > >   		return;
> > > --=20
> > > 2.20.1
> > >=20
> >=20
