Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3604C6A3D2A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 09:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjB0Ibl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 03:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjB0IaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 03:30:05 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on071c.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0c::71c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5E51D91B;
        Mon, 27 Feb 2023 00:26:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+GRx8jJAErT0HAtaUUajKbVCD41OMfYUdgznVBUsfWc9A+5FWYb4tyhNDjBoTSorEknduxLCZ2JTZoFJzCimWmyE6PtqEJMM/qpyxZMyl/jEKiWyo6oiVM53dnksCbL6BWxD58smFOOdLzepZAE9GxwKQ4Mbq69q7lHHxaf9ggMcF9Zh3sJFGYWvf8YlCBU6XQmOa0IjgM+P2OpRhQxHMNe5S4jYrf7TDkQKQU9iRVa3BKpQiKtaPcSG7S4NZFqrgPWB6I26yNUXypdwJwlsWxTeJ8QAnNGLVEXusNwa/PLqXb5W1O6hNKvFJuJIUx+isbCWfzgiiSNd8MBPWvLjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdTSnhR64elq9GsalNDPjpGg8no/HkxOL3w/MtWFujU=;
 b=gkTO2rsdyAl47TrR/Zpl3ZHSY4T7q2X/TYK+/3NMzK+kB2nHQysbFcDPR9TiRWCfARGmiEOLtEbiKtWsbWh0+l5roCcywEj/pgACC6wsLU/LuAmF0Bl8Z5af/474TiiPwS0wfYxWngzLeBydkb+eCJOf8e3VR44Dk1nQ481YtLGYoekXUA41rXLvPLABjJn281Z+kSab3gmClBbNtCXsnF9xNPklA5TJ9DzkPTowYt6S55zeghK5kSZ4KVLH+w3RRarexwIX4nPbKrOVt3jAeHjD0lo/VL+8LMvrXjsKacYGt8aadzM64LmMiM+aW80SAk5bd3U9JaufAKRkeLOliQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdTSnhR64elq9GsalNDPjpGg8no/HkxOL3w/MtWFujU=;
 b=d7CR2Ew2TJCGZgYLPu9AJ0kcvafpiDi7rEd+9MgnN6Lg7Gj80CKGqEnYVJF/d13qWUfeISCGR5wO9RwMv+oUJpxWSikBGzz1oS8GK2kG7gZl2NSjb1J2OhZKYVTLNs5vOXQkoHvBw1FIMvSN3iuEaTXVgl9o1cxyeGwCV54fxuk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34a::22)
 by AS4PR10MB5500.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4fe::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 08:24:51 +0000
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d067:93ef:f184:668a]) by DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d067:93ef:f184:668a%4]) with mapi id 15.20.6134.025; Mon, 27 Feb 2023
 08:24:51 +0000
Message-ID: <251124e4-64e1-385d-ea7f-c0cc31851307@prevas.dk>
Date:   Mon, 27 Feb 2023 09:24:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 01/12] kbuild: add a tool to list files ignored by git
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
References: <20230215012034.403356-1-masahiroy@kernel.org>
Content-Language: en-US, da
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20230215012034.403356-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0003.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::14) To DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:34a::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR10MB5266:EE_|AS4PR10MB5500:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c91e021-bc7d-4f1e-59f9-08db189c1896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C+lkk1jjpspHMBKOFDr3tG5AeMRFzGFIHLvGZyXtSTXeHwNUlV2IKhQL/7XyUccKWDZV1gts3+YyJw3aANck90/guyeW/VHr8XXGaCGS14e8yD+5X1dBcvN9Forjki9qH6z9FdgbNRYEqu8GpK4sktfelf5v44Py8YQ050oYZqmY2WyCcUws2SpXwkmYJYhYr9B9BJy4DKZ5gqAhUxW4JMXfQyc85EL8lXfud8tdCk3ClNn1WdodlMJZp+3Dn8TCmMwZPlLDtG4m9olEVXC1DHjaiMdGZZYt1Cgv4DQrGTDvEtDB+bbPWCPeGiAqvJhcMVYEqBNdxf5X7i6aJlD1fitKWN/KBM//AVE8SzB1eWa1Ev+Qf0kzHMiLPt0ar9jNhP4xn1NsoQFNZmT5qSmt9i0k+mlQW5sf0Wa4hw4TcOEI2e0jZmb6ZElBrHQggaKWYGbOFiI9KTkuQPSahEsQBJnxtRV6rpJ17XUGoRc3MA9o+fPhzgzHuIdSV3/NhEknh4pZfUCVpIFQnzCM4Xt2pzsxPwVWNe3dGaCuL/R/BLKO/RQ9iJTkSP2Mveuzylq/XFd4oTmBEfdEoaD/SWNd0XZ+7PlxSI6efBEwLMQ55h3XbReJ4rCuvGZvagA5JJPsjMIJzKJnJqGc+aLVufo86kI+S7mHoUgbJomjCyH+04qE6vKUuCQdeQn35hNNXH7rBpTyMvt9BKd3/RO/PfQGz7yRhu369pdN9nXBUvidxo+ZRg8vrkRlTy9u+jBsySYSbuFu1cyOGrkzr9306kxu0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(366004)(39850400004)(136003)(376002)(451199018)(2616005)(478600001)(6486002)(316002)(186003)(31686004)(26005)(6506007)(54906003)(6512007)(6666004)(52116002)(8676002)(66946007)(66556008)(66476007)(4326008)(41300700001)(4744005)(44832011)(8976002)(5660300002)(8936002)(38350700002)(38100700002)(36756003)(86362001)(31696002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0tLTHVoVklaRzNnaCtXcUF2V2NBd29XQTVocjBobG9zZHFZTGxISktwcHlw?=
 =?utf-8?B?UFlMWjlEUGNMQ3Q3RXRqSUFBR2ZmRkFOOURCQWRFS3AzZ3FDNEtpYjBvaWNO?=
 =?utf-8?B?K2g0Tm80eXdydTFma3VjbW9DV3BwUHNUVzJUTEs4c3RvRHBTdXFXQkFNWndw?=
 =?utf-8?B?REVTRy9taVp6cS9JMHZrSXViaC9IWU1DTlFkWFl0Q3dGdWZ3K0RFR0lGV3Nt?=
 =?utf-8?B?dDVHWU1ESDdJQ0c5NmVyTGNFQmMzdFovSjhZN253d1JPc3VRM2IwUVZZem91?=
 =?utf-8?B?WW4xSEVzaWgvdE5CSE5JN1ovRGpYWTUrR05PQ21SQ1o3ZExDOFVHYmtkZ2pX?=
 =?utf-8?B?UXNkNSs3THNPYit1b3BVWjFibC9jTGMxcW1nTWY3TExnMXFkMlJjL2h1TXFM?=
 =?utf-8?B?d091NFhaQlZTZ2FPbnlQcDQyNUFXaHZCUWNYWlVEVVFEamloQ3hCZDB0bm92?=
 =?utf-8?B?WFl1QkZ3a0ZpK1lEK1daL0p6WFkyQWlCRVBXcnl6MlRtN3U4QmJhc20zeEQ5?=
 =?utf-8?B?TmxOa3czdlVTRzBrQTlsSlRGK2xjTUY0MDZiZVVDekNJVWcrbW9xbmpkcEts?=
 =?utf-8?B?MjVmZTVpVUh2WTVSeFoxbnhrR09pbTJ4b0Jya2xDMGlFSlhUdkwyVXE2c3c5?=
 =?utf-8?B?SkIva284T0hzMTZBSnpaZHJ1ZXoxYkxYeWl5Kzc1TlRMUXNMelZtbVFvZ3hZ?=
 =?utf-8?B?R2QrWndRSWFpYUl6YkhyVzlLbTh2V2UvUG5ySHQ4UGNyNUJVcGxBMnpML0Z0?=
 =?utf-8?B?dzRjQ0VnVDk2bWNlM0Mycnl5dS9JYXN6V3lHY1ZnNy9xbE0veFBVeGhPOTNN?=
 =?utf-8?B?UytsQnZHWFVTUmk2QWdYVjlXT3VNbk8za3hIc3gzZFFsZnBVQ2U1cHBHdHJi?=
 =?utf-8?B?QVAyZHcwcXdjOEF6bE1qdGw5ZHVnaDBCbTV3OVQ0c056SE8zbUxWbTJCbWVP?=
 =?utf-8?B?d0hzTlJ4Wms3cmtvTGJzVTNCTGcrSi9GZ29EdWJoQy9DU2FJL0x5Q2JrYndJ?=
 =?utf-8?B?MXE5cVdSb0tkVTdvSE5adW9hOUFtblJSUzhmWGJudllGSDc1OUZjTWllc0Fn?=
 =?utf-8?B?Q2VRS0R5VUtlOUZyeWhmZDc4VWNPRnFGbDhMaXdoUk9xTFhuV2h5L2dnRHVE?=
 =?utf-8?B?ZHhrZXV4ZWtvR25acityWkhQcGNqVkdyN1dNd21qUVZWNkZSQ3FoblZMN2Zj?=
 =?utf-8?B?UWZHVE5sS0dOZmRtNzBNYTIySU1ZOWUwRGVRYzRvU2crNHBXWE0zOCtmVlhl?=
 =?utf-8?B?RlVOeEFzcWhHS3lMVElVY2U3ZDhjM2krYjIvWVlNYXJ4MXBHa2ttSTY3ekJO?=
 =?utf-8?B?TzFXMHM0ODdjLzVKRzJBUFN4U1dJSXk3cTVtaEsyZzF3RW1WdWxwU3hGRzdy?=
 =?utf-8?B?cExjNVUwOEJwR1VkdkdsRG9yOExKaFZQRWdVeHRrUytkbnozT3gxSHcyTEww?=
 =?utf-8?B?ejRPeUtyaHpnZS9SVldDVGZ0NzlLMS9mR2JoK0ZDSFFlTnExcDh4cUZ4N0t4?=
 =?utf-8?B?eWFEOXZuWHo3TSt4UjRMQktPQ3lUNStrR3JUNEJUU200K1lsWTNVTnlxOXBB?=
 =?utf-8?B?emJqYThqbXNtMVcycWZ6elZtWjVhNmpOczlOUWoyT0I4UlAvdmQydktPZ0JB?=
 =?utf-8?B?ZGJGMVRyM3o0YzBGeGhTaisxS1BwVmVwdGViYVMvZG9JUHUyUG5TZUVtNlhP?=
 =?utf-8?B?R0RqblJXalpSQ3kvSFByc2hmcXVzcEFKelE1YjRJVVk1QTZtSXp6WUZ1V1Q3?=
 =?utf-8?B?OVliUVo5SDM5Q2VpSnJrZXU5bGkwcW0wVEtTcUNSNUZ6SEZtSFhQbzRMNjlH?=
 =?utf-8?B?MVdhYUlWN3ZTcm1JeXFkYmRwZ0IxS1UxQlJmanBVZ3FCK0ZuaTNvc21za29M?=
 =?utf-8?B?L3NDQ2Zrc1k1ZGVldnE3TnRudlhvTUljWE1YbXJYN3BYa0xGbVZoNS9wUXkw?=
 =?utf-8?B?N2Z1M2VhZm5ZUysvSHdrZEt2RzI2b0xpMWNMNktuNDRrV3dvd1RoMGEzWjJt?=
 =?utf-8?B?cm9uUllRRDM1SlJOVVIrMHFxM3ZHQXFRdGtGTzhkQjY0SVAzU3cwNXMrQTEr?=
 =?utf-8?B?NTdWR2YwUFpTNkVBU2dhcFovZGZhRVY4RVQ0ZmtWdWJoYXVlSEczMUxHOUxD?=
 =?utf-8?B?eGZhaU5FV0hDa0FhYXAzODkxTzRncGtBbEVidjFKbDZqaEhKdG9Qd3hOOFU4?=
 =?utf-8?B?dkE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c91e021-bc7d-4f1e-59f9-08db189c1896
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 08:24:51.1540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LANkS3a5X7IQJDlD2aJW66AO4HhzwnFRijoYmTWz6HTTXJO2pCgbQ+BX+kyGFv5cBK2coSeF6o1XcsftoSb1x8BjW4WY9IGr5aItL5Pmvaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2023 02.20, Masahiro Yamada wrote:
> In short, the motivation of this commit is to build a source package
> without cleaning the source tree.
> 
> The deb-pkg and (src)rpm-pkg targets first run 'make clean' before
> creating a source tarball. Otherwise build artifacts such as *.o,
> *.a, etc. would be included in the tarball. Yet, the tarball ends up
> containing several garbage files since 'make clean' does not clean
> everything.
> 
> Cleaning the tree every time is annoying since it makes the incremental
> build impossible. It is desirable to create a source tarball without
> cleaning the tree.
> 
> In fact, there are some ways to achieve this.

> The easiest solution is 'git archive'.

Eh, no, the easiest solution is to just don't build in-tree? Can you
explain why 'make O=/over/there' isn't sufficient for whatever it is you
really want to do here?

Rasmus

