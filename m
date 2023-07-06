Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F3374A3EE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 20:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjGFSy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 14:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjGFSy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 14:54:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A07E70
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 11:54:55 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366HY9M2007380;
        Thu, 6 Jul 2023 18:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=kLTN4pe+ywAbgHLPYuQkiAuRRtT1+cT9FIahRpr9+GY=;
 b=qlS/7x6YZDdqT6aQPlAToaclfQTXT7L49w2mlJMk1xdliOV+/WaXSlbdXRtkJit/U0PO
 5JvUS5KVdbIInEtz/Ok35g2YLSCVp623QxKhXnQBo++5SdFWct7H96h+upG/v2zweHE6
 T+S+Hm/OBGlKg3SpJswfRQePVdbg9CNsiwk6ttwllt9c8XS97uS7arqU43yqsfqJSyyG
 PiQXXVEsfzXthGQ8Zsc3EbrrebxowELD2erucvRJU2BS0PS424VY8AfqMkb8TobpI1wj
 QmeN6/0i3mpAeD77RrKiCcIg59OjsDJHiqWNQzp4Uv/tcHqQp3u96pBq+VCuOymmumDb PA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rp05bgh6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jul 2023 18:54:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 366IRJR5013587;
        Thu, 6 Jul 2023 18:54:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak7g3ve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jul 2023 18:54:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZE7avhFxMbWr0lB5BH94DEose+mbFHq67n50ggwfFJvnf+dBUooWVWyYM1QC0Y0R4puGgBEY8C88bKP+wW0TE3P+9zmBEpCrWj9aRHIJqn8okjMeEd8/eSi0MgnNFjmvpDWDul6LQJ8hXh/4LoLYITcrCTdn3jNkW+nGGXwL7SMZW8LdAHzlubp6mGui0FfhZQYatTXVrlr4aWasAOpNH/RPsNluDgfLl4xzhk6xFK+jzzU13mHDLoqVb33ib5qh39PFor7msUKNNMeASFlzpH5lRbjivHsUQOUFCRJ4gPBd7RxEruzYcUOmtnTKeiAAJw+sFky4c0CrN2Ugk6OrNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLTN4pe+ywAbgHLPYuQkiAuRRtT1+cT9FIahRpr9+GY=;
 b=mWN2vF2OpkrVaN6fG/Uv/knp5it7GxuxyQK1PPdS2HvLO33uh6K8C8scSATRyoLSaVGT6oZ97F1E6VjsoVw3LY2OobFXjgkAAtFfeFwCC+6U5IM/YmPZETIW8X4VqhikqhVreXl+5g4zCa6UZmBZFaTclfgQxy+6h78s2lcWAUaubCHYPIf4H8M/Z43M4nMYJZUjVVTbnEwfGDIkTFTjc9YVGYTC3oVKroUDzP/WSinwWHPQ7jpH9u1s/tWKj6pcMY6nkySznSUvSqAO3Ckjq2G0pyHj8HO1Hx15W2Qvm7OkU8aBc7GK+KfWhFTapc3dVyfuqOLpGwDnHxnFWzRUIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLTN4pe+ywAbgHLPYuQkiAuRRtT1+cT9FIahRpr9+GY=;
 b=yEadXC3hKRhNRI0tcHcNlcC8tBJ4MdJLSxFZYLoRMhXrl60MUgQ/sKxdCbgaF70S74DbE7QvsWzmm7q7pL1L1dtOilySry0dZdg4LchtCjWJzr5gXr4JKHT4yolbiMr+42auPJzERvDcLu+x5afo0HecKwl/dLa79jgzqWDtQ0o=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY8PR10MB7316.namprd10.prod.outlook.com (2603:10b6:930:7a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 18:54:39 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6565.019; Thu, 6 Jul 2023
 18:54:39 +0000
Date:   Thu, 6 Jul 2023 14:54:36 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     John Hsu =?utf-8?B?KOioseawuOe/sCk=?= <John.Hsu@mediatek.com>
Cc:     Andrew Yang =?utf-8?B?KOaliuaZuuW8tyk=?= 
        <Andrew.Yang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Qun-wei Lin =?utf-8?B?KOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Chinwen Chang =?utf-8?B?KOW8temMpuaWhyk=?= 
        <chinwen.chang@mediatek.com>,
        Kuan-Ying Lee =?utf-8?B?KOadjuWGoOepjik=?= 
        <Kuan-Ying.Lee@mediatek.com>,
        Casper Li =?utf-8?B?KOadjuS4reamrik=?= <casper.li@mediatek.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
Subject: Re: [BUG] trigger BUG_ON in mas_store_prealloc when low memory
Message-ID: <20230706185436.agobbv72o3hma43z@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        John Hsu =?utf-8?B?KOioseawuOe/sCk=?= <John.Hsu@mediatek.com>,
        Andrew Yang =?utf-8?B?KOaliuaZuuW8tyk=?= <Andrew.Yang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Qun-wei Lin =?utf-8?B?KOael+e+pOW0tCk=?= <Qun-wei.Lin@mediatek.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Chinwen Chang =?utf-8?B?KOW8temMpuaWhyk=?= <chinwen.chang@mediatek.com>,
        Kuan-Ying Lee =?utf-8?B?KOadjuWGoOepjik=?= <Kuan-Ying.Lee@mediatek.com>,
        Casper Li =?utf-8?B?KOadjuS4reamrik=?= <casper.li@mediatek.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
References: <9cb8c599b1d7f9c1c300d1a334d5eb70ec4d7357.camel@mediatek.com>
 <20230613141114.bwbnqsdazqbmyj3u@revolver>
 <3b14df2fc2a7f18fe12f87a27574b7d40f2899ba.camel@mediatek.com>
 <20230614155826.cxcpv33hs763gyrg@revolver>
 <ed7899c7328aabfbe9bc9589f0776a75e6c9d1ee.camel@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ed7899c7328aabfbe9bc9589f0776a75e6c9d1ee.camel@mediatek.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0450.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::29) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY8PR10MB7316:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cb6faac-8bd5-4fb3-c446-08db7e527391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h6NZrFN7jpiUnn13mwyjWKUCVf6LpDiPtvP127IQv7zS/fZrpk53zLy4b6K+Md8F8Pd74QFNrLY5UzFn97P7T/+ZKsJfdm+DYpUz/lDXs8O4qeRhUYgVPmDPlgpSnvH7ILxif9BFxw+8663EvQmuymnaPcNe0LWRwx4GkszkTQCRAPOmqzpMAkDSeZTTRJh8DGHZuGcB6sT4wqyz5uxn93Ve7psB14ur2MmB10ULSHvFppoE/GvkaGG4uwEXsdZIhea3fJMXIPA690ZKcQ9Eu45Vtv1sXEB7W0ZSH53gqVdU90obgc0vCzbMG1exSOQo7MI6ljoVed6qQCeH6Tg7iR1fHSXBA+0DUG8lyIOHz3yTLbSD9VXyY37F+fZbtikuztZim9kReax+g0uLLBsps9IoNjPR7e4I86XEz/Ty8RX3+wzwHYdajveedXKJ48VxGZPK/DXP07ZShcWHEbwuGiNu++IyktTdM9LMosSnGJ1ktefEgKXodrGPA82dPf+UrR8ryPZV/ARbY8a6XLYtJE7z0ptZPJFCBYzOXh7nJcLO0zu7hjnOolysoeCswxf/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(136003)(39860400002)(376002)(346002)(396003)(451199021)(54906003)(6486002)(478600001)(6666004)(83380400001)(86362001)(186003)(33716001)(66946007)(2906002)(26005)(1076003)(6506007)(6512007)(9686003)(38100700002)(6916009)(4326008)(66476007)(66556008)(316002)(41300700001)(8936002)(5660300002)(8676002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enlIY2U0TDNZT2hyQU94SEJEWno1NjNDZ0VOK1prMTZzQTlHeHRBT1hRT3VZ?=
 =?utf-8?B?MFlXbDdUWTVoL2dpc1dEVXZLNFRDV0duM09MVWdwN2QrUnlPaDZLV29yRDNu?=
 =?utf-8?B?ZjZ0Um1pb29wcGVvNW82UGlQZWI5TWpDZlZwcXNWaGhzR09xeTZKR1lhcmUy?=
 =?utf-8?B?aW1vM3ArUUZkejVZS3BMVXoyRXg4QkdyaVhzWWtVbVlRWmlNZjZiSVVSNHdx?=
 =?utf-8?B?MjhyVGFId3BURGkrelJ4c2hVZFZnWkttSkRiaWlKamE0SXJ3Wi8zY0FZWkMz?=
 =?utf-8?B?a2RFZDVBM1dGeVRORE5yeFhCNnpHYVdXeTJMWXhGMGZXRGJWLzRFZ0NTa1JI?=
 =?utf-8?B?WTIwRmVNeGk4TzlUZU1pUlcwditoRTBuUEF5Yjk1RGwxUkMzalMvUjkvQzBh?=
 =?utf-8?B?Z08wV2VmL0RNVzFsUEx4eDIyc2xxcmRaV3NvMUhxVVBOZTBpbEUwclN6Q2JW?=
 =?utf-8?B?OWRDWThrOE9IeWFEQXJJOXR5aFJDRHhsYzJFOVhvRWhBamQ3eFZBN3doZzRB?=
 =?utf-8?B?REdSY3l5OWZ2RlBlMElKMERxcXdIUFMwSG1RSS8wWUhFQmtEYVdwNElCVzRl?=
 =?utf-8?B?VUZ4QklnL1JYTlkvT05vVno4eUVEVDJJaDJEaURJS1kycmRzQTRDR2V3RGph?=
 =?utf-8?B?RWVUQ3hNd2FQa3E1cUZPbnpUVGFtaWcvay9RWGwxOThiUkJnbFFJdjd6ZEd2?=
 =?utf-8?B?dDE1RjhKTTdRYWZ2MEVXblNEaGlIL3hZdFZDQ3pLTHpNL1RxZVdmL1JOaXNR?=
 =?utf-8?B?TDRBVlZ2R0JMTVZlQ1Q1RkZzZ1hYZmxlc1k2bWEzYWxzUllrVGF5SkQveG40?=
 =?utf-8?B?RFhzL0F1TytNQk9jRUY1SndHMXBMbWc1SzNBajdObmRNeDZYdDRSY3lKUUUw?=
 =?utf-8?B?Z1lOSlZwRlQ2MkNKWk1FR3JrNCtpbnQxZGN2WWZ6SnZvaUpwQlcvMXdtTFQ5?=
 =?utf-8?B?OTZMRmFqS3VjL0ZtMVB0YzZIVWFJeHQ4YXo0elBhakpwMGVqMGtHdTFKeDJn?=
 =?utf-8?B?RWV6dG1CZmdsMmNma2FmNXgzYm4wOFh4TmlIaFRNcHN1ajRLRGU2U2NIRUZt?=
 =?utf-8?B?c2t3aUQ3cUdtaCtYZ05sbVpEcENWaFg0N0ZrNVdRQ0lPZ0ZFSkExaFd2Vzc3?=
 =?utf-8?B?cWpZcm9LSzV3MVVQZEMyM0xQWjV4Q2JKK3FkRXc1ZVBpUkZmMmNhbnRramdG?=
 =?utf-8?B?bkFLdnVBR2U5KzJTbnN3T0dXK2o2cUtKRmMvOGNYNGpUYXlkUVNtMk9Ed2g0?=
 =?utf-8?B?VzdDLzlZWmlld3hGYUZRK0tEd1plR0xnb2xQQk4reTRHVmEyYXdUSnY1SjlF?=
 =?utf-8?B?Y2taaW55R081MVM4cXFDVmZGcUJma2FVRzNPSHdzL0d4SmdJRUVlYlZteWJY?=
 =?utf-8?B?Z2RITVh5TDc3Z2JtVVI1c25NOHllb0FZbnlhN0JYOHE5VmdlZk0rMmNVZDh6?=
 =?utf-8?B?enNzVHBlSE5FOURJUGJnamFxYi9tbU1ySFBHRTI0TkI4c1BQcUk2OXJMeXI1?=
 =?utf-8?B?ZXYrRnRaQzg3VitRejVsaEdreXBxYXpEYlY1d1BxcVE5a2trV1pybmdiQ0Nv?=
 =?utf-8?B?Sm9IR1hWbWRLOERJTXJmWm9kYXl3YnZRajR2OTd1UXNUUkxTaDNpUkF2dUNn?=
 =?utf-8?B?Ump4Y3ZtZDJ4S212eGMydCs0UU1DMUQwQXdlNFFPSFFjNTRkdG5Uc3dTVUxi?=
 =?utf-8?B?NFRac2FTZTBOZHV4OERORW0wVlNvbFBxTUMzQ0pNNS8wdkdYclh0bEhmUWxE?=
 =?utf-8?B?a3R2L3R2bXpMdXhBak1rNThGODA0clc2WFhIaW01QkVsaTVTNzJ0eXhGbWVz?=
 =?utf-8?B?MGxia3pEcVZtYW14cUlKbklxQ3JVNkNvakNtYXZoRzNsZVVydllta2tSR1lH?=
 =?utf-8?B?aE1Sc3Y2LzZVeHhSQkx2Z0ZnUFFKZ08xNDJ4SkdqYkdIeHpSa3d6bW9Ka0hJ?=
 =?utf-8?B?eWxzVXRIUHVFaDZ4S2ZzRnA3Z243L1d2ZFkwNjBQci9rU2QzWjRqVXp3cGN2?=
 =?utf-8?B?NFAzYUdocHhFVTFUL0FUZGRUMDVkRG5TbFNPMGRSazBVTXlGZ1c0eEtUSTRh?=
 =?utf-8?B?UG5VbGhpaHVrU08xUk5PNkpId3oxcE1PNFdQaGM5MGIrV3FJSGVrSXNqZSt5?=
 =?utf-8?B?WlZRcGtQdVFZRnNtTGJVTUU1UFBwYmdOK1dOWVBFRFNkYlBjaXJhQWFsdk5Y?=
 =?utf-8?B?V2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?emdnaUMyUW9ISWdHaEZnUldYRGV0UDNaaXRmSVZDVnF5WWhXNzFTSUdBMk8w?=
 =?utf-8?B?cEZQbVJqQU1XMHMyMTFtMlA1eE5HWi9aR2pRaWZsZzlROWRtcUwxY0hzVU1r?=
 =?utf-8?B?cjU1SHRpOS9taUlQUGdPOVN6SWtzZXpqcUNBOGxzdHhoUjNvYmVxRjEwbUFm?=
 =?utf-8?B?QmtydXhsMmx0TWJ0V0d2Ujd4MHRJOTQ0cDZ4NnJzbW9wL0tnVXptRGp0VlU3?=
 =?utf-8?B?RjZzTjFTS055UUdnTUFGcFhlQ0FSL1dZZ3lvdTZSUXZPM2kwaWhZZ0tyN3hv?=
 =?utf-8?B?b3MyQ1pyZnZtR0lhSGRtL0UxbVdaSm9VaWIrMWdVTkFWNE1OYWVkdytLYmRJ?=
 =?utf-8?B?b0Z3Rm5aRHNDTzl1K2plQzRLWldnMnEzR1ZSUDg1Zm5rMjlPcFI2ZUNFNFBS?=
 =?utf-8?B?SjlSQ3g1NHZQaFB6RFhhUnZudGloQlpjYTVvSlJLeFpyQ1Flb2V1MnppS1dH?=
 =?utf-8?B?TTAzTjNlU1pOUlpiZldGRnVXRWZPNTdhM29XZmFKWWM3a2VRVlJ2SmJzVlVo?=
 =?utf-8?B?aktxTWVMVkV2VzhjeXNHdk9aOGpoWnVZcjFmWnBKR0psWUJsTzRzT1dtMk9D?=
 =?utf-8?B?YStXa3NiNGRXdUdKWmE4KzVCN2ZKZHIvczdUUGZyR0FIclBiRS9LeVI3M3Rx?=
 =?utf-8?B?NUQ5NjhNY25lTmJ4ejFTSGUxc2lhWkNNUVFDM1dZMjcvb1RjMXhZZHQxdU44?=
 =?utf-8?B?ejBDN1RyVXgwaWlXWThWRnBaTmdVZlNaN1MrVUZDb1dMbHVpRXcrTlhJTytx?=
 =?utf-8?B?Qk8wdCsyRHNzUjVGMzVRWGxULzhTUkdVbjA4NE9yZXNkMVdTRnRsczI4TG1n?=
 =?utf-8?B?TE96bmtPcUE0RkxuemRzZHBpTTBqclRBRGtETlZjT0tUYm5GV1RmYUVJWmNF?=
 =?utf-8?B?ZktDMkRQRlRKSm56OFNXMEgvUnZaZGZMWEZ2ditrOFBTQlA3VWIrY0xoODll?=
 =?utf-8?B?VzY5Y2xIT2xWQ2p3ei9Bdm5Ic3Jqc3Rua2hDWlFnUzJ4NVdWck1kMjlOR3ZQ?=
 =?utf-8?B?cTRkQ01UZGVweGRDSDExcFRxWUU2Tlk4SnlXbitUREUxMU56NkJ4MVNUeXUw?=
 =?utf-8?B?T0RGWW01WEljSmNjT21SaW5xS21uaHA0Ylc5TVdxZEdpVlhzSmc5dGFTYmdx?=
 =?utf-8?B?bVN3S0tod1FYZDBVUStxR0lDZ3NXOTlsMGV1SE9WMUxQVmFzcVI3UFpFT1Nm?=
 =?utf-8?B?TzVOM0VuTEVTWkNFMUNIeUR5T1Rwbi8zekNPcHc5eWpzUmlSRFFXUDZHbVlw?=
 =?utf-8?B?WVg5SWwydUUvQ1JXUU9HYlVtR2dJUzl4b3BhQVlhZktCY2dUZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb6faac-8bd5-4fb3-c446-08db7e527391
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 18:54:39.5203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BcuBC6Arrde5xwqgoLrMreDXNi+ccDTMG0ZoSJz3Wf3LIQIC5dqf/lpP7Btv2AFNf2cKQGOWOEgDyBMXUMawwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_13,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=914 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307060168
X-Proofpoint-GUID: WgLvFLZySR_ii7BQH8tX5ama0sK79bes
X-Proofpoint-ORIG-GUID: WgLvFLZySR_ii7BQH8tX5ama0sK79bes
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Apologies for the late response.

* John Hsu (=E8=A8=B1=E6=B0=B8=E7=BF=B0) <John.Hsu@mediatek.com> [230616 05=
:19]:
> On Wed, 2023-06-14 at 11:58 -0400, Liam R. Howlett wrote:
> >  	=20
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  * John Hsu (=E8=A8=B1=E6=B0=B8=E7=BF=B0) <John.Hsu@mediatek.com> [2306=
14 03:06]:
> > > Hi Liam, thanks for your reply.
> >=20
> > Sorry, your email response with top posting is hard to follow so I
> > will
> > do my best to answer your questions.
>=20
> Sorry for the wrong format....
>=20
> > >=20
> > >=20
> > >=20
> > > version 6.1 or 6.1.x?  Which exact version (git id or version
> > number)
> > >=20
> > > Our environment is kernel-6.1.25-mainline-android14-5-
> > gdea04bf2c398d.
> >=20
> > Okay, I can have a look at 6.1.25 then.
>=20
> OK, thanks.
>=20
> > >=20
> > >=20
> > > This BUG_ON() is necessary since this function should _never_ run
> > out of
> > >=20
> > > memory; this function does not return an error code.
> > mas_preallocate()
> > >=20
> > > should have gotten you the memory necessary (or returned an
> > -ENOMEM)
> > >=20
> > > prior to the call to mas_store_prealloc(), so this is probably an
> > >=20
> > > internal tree problem.
> > >=20
> > > There is a tree operation being performed here.  mprotect is
> > merging a
> > >=20
> > > vma by the looks of the call stack.  Why do you think no tree
> > operation
> > >=20
> > > is necessary?
> > >=20
> > > As you mentioned, mas_preallocate() should allocate enough node,
> > but there is such functions mas_node_count() in mas_store_prealloc().
> > > In mas_node_count() checks whether the *mas* has enough nodes, and
> > allocate memory for node if there was no enough nodes in mas.
> >=20
> > Right, we call mas_node_count() so that both code paths are used for
> > preallocations and regular mas_store()/mas_store_gfp().  It shouldn't
> > take a significant amount of time to verify there is enough nodes.
>=20
> Yap..., it didn't take a significant amount of time to verify whether
> there is enough nodes. The problem is why the flow in mas_node_count
> will alloc nodes if there was no enough nodes in mas?

What I meant is that both methods use the same call path because there
is not a reason to duplicate the path.  After mas_preallocate() has
allocated the nodes needed, the call to check if there is enough nodes
will be quick.

>=20
> > > I think that if mas_preallocate() allocate enough node, why we
> > check the node count and allocate nodes if there was no enough nodes
> > in mas in mas_node_count()?
> >=20
> > We check for the above reason.
> >=20
>=20
> OK..., this is one of the root cause of this BUG.

The root cause is that there was not enough memory for a store
operation.  Regardless of if we check the allocations in the
mas_store_prealloc() path or not, this would fail.  If we remove the
check for nodes within this path, then we would have to BUG_ON() when we
run out of nodes to use or have a null pointer dereference BUG anyways.

>=20
> > >=20
> > > We have seen that there may be some maple_tree operations in
> > merge_vma...
> >=20
> > If merge_vma() does anything, then there was an operation to the
> > maple
> > tree.
> >=20
> > >=20
> > > Moreover, would maple_tree provides an API for assigning user's gfp
> > flag for allocating node?
> >=20
> > mas_preallocate() and mas_store_gfp() has gfp flags as an
> > argument.  In
> > your call stack, it will be called in __vma_adjust() as such:
> >=20
> > if (mas_preallocate(&mas, vma, GFP_KERNEL))
> > return -ENOMEM;
> >=20
> > line 715 in v6.1.25
> >=20
> > > In rb_tree, we allocate vma_area_struct (rb_node is in this
> > struct.) with GFP_KERNEL, and maple_tree allocate node with
> > GFP_NOWAIT and __GFP_NOWARN.
> >=20
> > We use GFP_KERNEL as I explained above for the VMA tree.
>=20
> Got it! But the mas_node_count() always use GFP_NOWAIT and __GFP_NOWARN
> in inserting tree flow. Do you consider the performance of maintaining
> the structure of maple_tree?

Sorry, I don't understand what you mean by 'consider the performance of
maintaining the structure of maple_tree'.

>=20
> > It also will drop the lock and retry with GFP_KERNEL on failure
> > when not using the external lock.  The mmap_lock is configured as an
> > external lock.
> >=20
> > > Allocation will not wait for reclaiming and compacting when there
> > is no enough available memory.
> > > Is there any concern for this design?
> >=20
> > This has been addressed above, but let me know if I missed anything
> > here.
> >=20
>=20
> I think that the mas_node_count() has higher rate of triggering
> BUG_ON() when allocating nodes with GFP_NOWAIT and __GFP_NOWARN. If
> mas_node_count() use GFP_KERNEL as mas_preallocate() in the mmap.c, the
> allocation fail rate may be lower than use GFP_NOWAIT.

Which BUG_ON() are you referring to?

If I was to separate the code path for mas_store_prealloc() and
mas_store_gfp(), then a BUG_ON() would still need to exist and still
would have been triggered..  We are in a place in the code where we
should never sleep and we don't have enough memory allocated to do what
was necessary.

Thanks,
Liam
