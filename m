Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87D06BAF6B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 12:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjCOLjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 07:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjCOLjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 07:39:20 -0400
Received: from esa5.hc3370-68.iphmx.com (esa5.hc3370-68.iphmx.com [216.71.155.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3873666D2A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 04:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1678880359;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=OnuYNNfduY96gaqGSwJ2LI+je9K+GJ9W5gDxCOSZzNI=;
  b=KaEuLh64pxojPHSqgsa8YucnRPghjV8L6h41SL5i7oaJBz91H+BDdkGI
   1layjWxIu+O+ANuV1fXq4wc0zWX8V4YRaMm9k5YeYZII4kLB9HC1BVNgN
   4J/hIcwXI02unxhER4toS0AWda9Wu79BJ476zZYaQjJ/fhmapNyIKwBdF
   w=;
X-IronPort-RemoteIP: 104.47.58.108
X-IronPort-MID: 99740067
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:RwstRaqAQ1miysA+MdYR6uHp6tVeBmLZZBIvgKrLsJaIsI4StFCzt
 garIBmBMv2MZjHxLd90PY2+8UhS68PQzYdnTAI4ris1Ei5BpJuZCYyVIHmrMnLJJKUvbq7FA
 +Y2MYCccZ9uHhcwgj/3b9ANeFEljfngqoLUUbKCYWYpA1c/Ek/NsDo788YhmIlknNOlNA2Ev
 NL2sqX3NUSsnjV5KQr40YrawP9UlKm06WNwUmAWP6gR5weFziRNVfrzGInqR5fGatgMdgKFb
 76rIIGRpgvx4xorA9W5pbf3GmVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0MC+7vw6hjdFpo
 OihgLTrIesf0g8gr8xGO/VQO3kW0aSrY9YrK1Dn2SCY5xWun3cBX5yCpaz5VGEV0r8fPI1Ay
 RAXAAINdiunqe+N+pDhT7A3otUjfO/UIJxK7xmMzRmBZRonabbqZvySoPN9gnI3jM0IGuvCb
 c0EbzYpdA7HfxBEJlYQDtQ5gfusgX78NTZfrTp5p4JuuzSVkFM3jeiraYKFEjCJbZw9ckKwv
 GXJ8n6/GhgHHNee1SCE4jSngeqncSbTCdNNSOXgqKECbFu7mV1UFUIrTViBoLqJmny+ZOBcF
 h0Sw397xUQ13AnxJjXnZDW6p2WJsDYbV9dKF+Q85EeWx8L85wefG3hBTTNbbtEinNE5SCZs1
 VKTmd7tQzt1v9W9WX+bs7uZsz62ESwUNnMZIz8JSxMf5Nvuq511iQjAJv5zQPCdjdDvHzz0h
 TeQo0ADa647iMcK0+C3+A7Bijf1/pzRFFdttkPQQ36v6R5/aMi9fYu05FPH7PFGaoGEUl2Gu
 3tCkM+bhAwTMayweOW2aL1lNNmUCzytaVUwXXYH80EdygmQ
IronPort-HdrOrdr: A9a23:TdAvI6G/LQb6f2wppLqE18eALOsnbusQ8zAXPo5KOGVom62j5r
 iTdZEgvyMc5wxhPU3I9erwWpVoBEmslqKdgrNxAV7BZniDhILAFugLhrcKgQeBJ8SUzJ876U
 4PSdkZNDQyNzRHZATBjTVQ3+xO/DBPys6Vuds=
X-IronPort-AV: E=Sophos;i="5.98,262,1673931600"; 
   d="scan'208";a="99740067"
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Mar 2023 07:39:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AL+xvJYG8XlpoMpItKYBeQm4PC1Rku4TlZTVxi02igbO5uEV5WBGvR3C65f4jxjm45sbjbW4iuu+BpTtLmOxxaYbQuEc43238ktaTvkx6pxJija1q0C0dakHnkqbpJI0txF/eSR7uA9GZ3LcnMrSgr1d+xcHvd0QIBPY7om8tk0kjC83Yi5SZksJMVhD+VDF/oaZshumXOjSqERHEiS2uCGa7VFCz7f//xkFph8ci8HOqF6jAa2AGE0/9FwD5x3f2Zta6luyOZnKEnkdinzHU1lxIukL9UaiXVz7aJPKWBO6r5e/UJl9qJIDBsyJdl3RppXCGfYFQQH1cl8CYnGTnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4fRlybSR1bc+I+aNsH+5GVToMfjWaDm+E76t6s/sss=;
 b=P99/A/hyE3vh0WSXxF/ufeVGRP1R4QkDi48MTfuk4ObfUvzqmOLXe2UN8G18ugCTEwnmt3LKR0Vi0npUVeZLXAOIBp5dENNRH6Vn8xrmw80xXWnOK+tCcx/SZwmNp7mrUVN9kr/47n3NYW7rWXDv5EFgmjDmfke2VpDQzVy9ambObGXsXqzaRA9v6lBe6Wu6SlInxmlVfbf8kgFTqt7/zj0N4n/x3a6XvBCR2rtqhkJ+CPaA1CdZ4YLlpb38Tb7iuSaRgvFiMuuq2ORx7iNizmBxbZOiR2P/oJfjqeivCba3gIcZy5RJT6zqtkI1ZwzG/LhGdLsrRAs3hLpRgHH1sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4fRlybSR1bc+I+aNsH+5GVToMfjWaDm+E76t6s/sss=;
 b=RIVJGRYX/fP6WIC4yXHe7JVfDqCfnFaoFJFqz/HSs6yxkozNDuCDorDTUHC/9EZsC2MQ1chzGiOWCY/MkYxhOq9JZrDXqf/hPNDsOoucMXny06bPjOxXFh9DhBI05yVg6ILeyiDGdDCF/DPP84H6iEy2kZOAq9ZY0BKyYBNKWLE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from PH0PR03MB6368.namprd03.prod.outlook.com (2603:10b6:510:aa::21)
 by SA0PR03MB5531.namprd03.prod.outlook.com (2603:10b6:806:bd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Wed, 15 Mar
 2023 11:39:10 +0000
Received: from PH0PR03MB6368.namprd03.prod.outlook.com
 ([fe80::4fdc:e60c:b790:d034]) by PH0PR03MB6368.namprd03.prod.outlook.com
 ([fe80::4fdc:e60c:b790:d034%5]) with mapi id 15.20.6178.019; Wed, 15 Mar 2023
 11:39:09 +0000
Date:   Wed, 15 Mar 2023 12:39:02 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Josef Johansson <josef@oderland.se>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Subject: Re: [PATCH 3/3] xen/acpi: upload power and performance related data
 from a PVH dom0
Message-ID: <ZBGuVjyDpuUZ3MnZ@Air-de-Roger>
References: <20221121102113.41893-1-roger.pau@citrix.com>
 <20221121102113.41893-4-roger.pau@citrix.com>
 <407b7c10-ad1f-b6d2-2976-2b297755b2b3@oderland.se>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <407b7c10-ad1f-b6d2-2976-2b297755b2b3@oderland.se>
X-ClientProxiedBy: LO4P123CA0636.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::14) To PH0PR03MB6368.namprd03.prod.outlook.com
 (2603:10b6:510:aa::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR03MB6368:EE_|SA0PR03MB5531:EE_
X-MS-Office365-Filtering-Correlation-Id: 480ae2c7-80a1-44e2-7201-08db2549e401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GI7F4OjBG7StcuNZK6lAHjUvz5lqU10jX/P3WuzVTGiThL8U9+ewi2FA4fay2dZB6NO0PyLYskJGoEA5RlRar1q+zo34g3ch4TVKgYCQQizs6N2waQJ7wZzdD+fx3DadVm8eIMXhPCk+1vhJ0JNmxIaVMYFUcCe/QPb1GXQ9LaZcvuDgKGqV4EF5pmKtupYuAIkg4ISUMdrb+3qEt9Pjo6rIfCUNQ/F5h9up2xQhixosTvEqJo8WHpyjZGoSDeWEB0HqPfZIHy1EY5Ob0vrAWAOw/Xh2w2QiINbxFAEg1O99oHN9Yyq4Oh9nrn+HQkk3KHneo68u3GA30NMwGwYrMndYVjvRBAjh1dN56IDvIpIzx9qPXC+KV/0cQSiOwRTfYD2bZO6ow9TqQy3l+7Q8h2vE+NcDF9xwfleA9TqSltTHOmW3o9z6m8JFppemAmk9msdp+c8zOm74mkTqvO+YexM8g9mDH2Sfr33diQpdQRTRS4bN/G7IT/DW4F1Aa2gRLetf1/IPHS/l3zXavw3uqrpi+XShDT0BH1v9Lv3uT21jqYETwkgize9dMxC80MPtKM9IFgKdwR9Ohr3DQvgo9vTRm27Jrdo4TDptIq1ZcJDjBx1urilKNZpC7ak4cIDp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6368.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199018)(85182001)(6486002)(966005)(82960400001)(6506007)(6512007)(53546011)(186003)(9686003)(26005)(83380400001)(6666004)(8936002)(86362001)(4326008)(6916009)(5660300002)(41300700001)(8676002)(38100700002)(66946007)(66556008)(66476007)(478600001)(316002)(2906002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0FObm9DZ1EwaGJOM0I5Q2RXV25iNlRjTlcvM3puSWh2emNSNitCZ28vSXFZ?=
 =?utf-8?B?UVd2am5BWG44VUR5VUlMZ3NCcTFVY3dPSy9JeVowQ25QTkhySktCUnJhQkJI?=
 =?utf-8?B?d1Q4OWoraXo4MFlRQU1Ha0dJUEJOSk5YamFuQ1FzdjBsakZNV1ZNVU1Xclox?=
 =?utf-8?B?TGVXZzZ2Vms2TEhjWkNMcUhhSjRHNklHeHpsUEZMRFhQbDZVbVcvQjBKSVJs?=
 =?utf-8?B?akEzc2IwbjQySjdkNjFSai9SUEdVR2hUcGZwY3FXNFNuQTg2S083L2VUbWFI?=
 =?utf-8?B?YzZITFZxVWxMSWYwVzgwblFGMEg1dXNOWWIrTlYwSkhMQVVYQ2V2WU5yYVQw?=
 =?utf-8?B?Q2Fud2t6ck5QT2xPQ1htMkxqc1l4WU9qWGRXc1hLS3ZRNXdGcXRESzFZMkds?=
 =?utf-8?B?c3FtczZvQkkwNlZlalRwV3BvTzMrWFhjREFpaU5pS1JVdkZZOWo4ZHh0SVhn?=
 =?utf-8?B?dTBwMWwwWHZkVWNLeVU3YkJteGJYa2pBeWVEeWdpUDNKQnBGZXZWc2VmM3E3?=
 =?utf-8?B?KzhlT0ZRQUhHSU5pejFPeEgwTGoyaU5HRnE5dlU1VFkwR3N2dWxyLzNOSWtv?=
 =?utf-8?B?R0ZYS3p5TXcrWS8rV0dTSnh0NjhEWmJ3YTRLbTdhNThpa013VEVXcVdqNlVL?=
 =?utf-8?B?WmROUURraXA4Y0NZUlVjWjlkNWo0azB0R3VZeS9BRHMvb1RMSTZCUHBKb2k0?=
 =?utf-8?B?WkFXbXJBSTU0N2RxaWIxSkRlLzVrRTJ3dDlEc3VORUVXTDJKeVplcTNiVTRG?=
 =?utf-8?B?Q3hPVVExUTRpeERJUnZMc1RucmZBK2FuYUFUYXBuR2lLQlczYVNGYVlZOWVw?=
 =?utf-8?B?OVRYTzVNNHVQY2s4WTE2TnVLTUh3c0E1MHNEaVVjbHRJYU04NnNkUEhXNks5?=
 =?utf-8?B?UHhMYVlOQldDTTZOVUdwREtTWlpxaVdCNnFjMzgveStCSzZ5LzRBcUxyOWpY?=
 =?utf-8?B?VytiUWFsWTkxcUtUVWxId1YwckJaYmFENWNTNWRXZVdEbkdpcm5qdXNjbVZV?=
 =?utf-8?B?NUlGajVBcTkwYk1DT3BsRVpMb1RMQ00yR0gyK3Y3c1NsZmNkWEpSUFJVdmNt?=
 =?utf-8?B?Q05OcHlacll4b0t2MWp3WTJBSlFDUlVuMDZibFA4U0sxN1REdldCRUcwdU05?=
 =?utf-8?B?K2NIK084NzVtc2JQV05adHV5M08ydy9PZDBEYXMvRy93NnAvYzkxd01EVFJZ?=
 =?utf-8?B?cGdHYzNpNGk4NjZHaXpWWldiTDRNaVUwb1VOcGo1dE5CV1AvQ29TT2RhS3Zh?=
 =?utf-8?B?TFU1Kys4Si9HZncwM0loMFRKb2t2MzB0cXdaNmZLTlhjNmswZ0Z2V01nUm1L?=
 =?utf-8?B?bmRjTHZkc0ZwTkR2MnVUWDd1bkZmRXgvaUh6UWUrTlNDRzJkT3d6OUtKaHZU?=
 =?utf-8?B?NU4ySXBqMHFyN0xjejNjU2d0UkplUk9SOW9uSmwxaHVCZmh5RmNnL0ZUZVlB?=
 =?utf-8?B?NS9OYVNtc0tsZW1mQXhCMmVlWDlIRFZQcDJacUFsSUZ1OWwyN243Y3R6eS9B?=
 =?utf-8?B?OFh4REZwU0Z1MUZBUVhVSHFjWUhqamR2N2RhQ0I5UDlwZXI1TzdnV2l0aXN4?=
 =?utf-8?B?SXFCUWhsNUc3bEVEQU14MWlGTVREVFZTQTlDeXcvVFhMd0x0OWVBallMMVk1?=
 =?utf-8?B?ejNoZ3Fva2lZVU1jRDF1amdJdjU4cGllRy94VEJRdEoyamUwSy9sL0FuS1BM?=
 =?utf-8?B?ZWR1T0pEdzBCOG5MUXhKS3ZkRUV6VWt6VXpHcTUrUkJyV21ieURaWFB3eUNh?=
 =?utf-8?B?ZldMTk1uaUc4TDZFQVpNY3A4eis2L0l5NVRKemI5RGtGamkyMEx0Zmx5djU1?=
 =?utf-8?B?WENDaFUxOVREazJET2tJSWE4NFV6dU4xc2hKajBJSEtpWENyV21lSFVxankx?=
 =?utf-8?B?MmpaK1Q0UkRuc1NrTnBFQ1RHaTZ6ckJFZHY0Yk9KL3NDaWZpTFhLMmtNOWtu?=
 =?utf-8?B?bE9iNHQzMDF0alJwQ3VDYzRJTlgxQzBGQ01yRmdJTmxWWVo3RVAxZzJRb29W?=
 =?utf-8?B?UVZPUGpsblhFbzZQQ1Fja2dmZm5JS1BRS0F3cVB1U0R4Sm51MXJ5eHljNFFh?=
 =?utf-8?B?Ym1mWmtQdEpXemFDbjIzbVoybTBUV3kxU3BLSUU0NUt0RTNTOGQ1RjFIWTBE?=
 =?utf-8?B?dXlLMXU0M1BwWlI5WUx5M1dkaUFyWnZiTktDZWRBYmhwcllJYzBCOUZNSzd5?=
 =?utf-8?B?Ymc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: m3bnvX2+0KO1B2JxMjgoMu1sG9lur18OCewqffr8PWQyRYnAmYeSqe58P/XMfg0BVnMUFDdoB4m+S7zz1eo/U/NfmVIGAAFEV/EE7GTym+it90fxHooIEmPQfxP1MtOTT4xxiIjBQPuDszMfGesp2xNPejo/1lZij8IAqUFTpaAJOwrMKfyqHHs6iVJJiWS2pY7gcTZ3R3ucvGOoukFLsToruKL62LzdM7UnOn169bBc3DlcHvBcJUF/wMQ09SkCvbzfAV6SpbquiW2DTnOJ+UGm9IJL/hVUzF8cJ0IBqZPtpn231Q9J+4G1lxeNlxagTwMyhKl3p2zufkdKzs3QHIc1w9Q8IWeOq0mOP8SODn3y7iUT6YRyZwI9sWLwEyDZZ0VUYRz8XWo3W1NP/uzX8Z+m3HMPBtm2R76SpxqyRW1C00TLZcnNO6mwfXFgBZCJQXT4CTOI9QAcCJlXRDBaiOB9xqx50qogGR+koRy4qK+OCC8WpTEr59ysqEh0ICpsHOaYYpA9xm4IPz8Imzgj47yistoiijq+0Zhwyc4v7a4Cv9mrkx0CgBfHuFtPtqVRAerYDYkF2lnPTyaqxDnd43C6MOig9siNApqcyt2vAbGWQosIrlMdr/13DnDwsWBlgE41yeL+ZGqh4iSR4JCoPrHZz6W/DsrTvZtneVZX5e8LaLb4qhyr9XZbs4ebS4HqoP/beZN9nlahcmurofXk2uUmNb3stMtyaVc1FQnhHXXuJp88FV5ua0u2dSHaTcVlz77UyiAiwR+WVT/4osgnH8/rceHeAHCGfjStkFtzxUjQo7LlaX3QwzkEYGBtWcDKw1u4keUXnWJydM7xgLlPZGP3Hw+6uKE/DwAOkTRu8ZAiCYpZ3I5rxOBbSKD14fg/
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 480ae2c7-80a1-44e2-7201-08db2549e401
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6368.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 11:39:09.4479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7u8/tnOpZzKOjNOc1MigJymw4emFsL96gEUQmG4II6lRNuoeutMxoPCH6du8ZQoT1HSMDdn/M55vFg68u0ZZyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5531
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 10:10:05AM +0100, Josef Johansson wrote:
> 
> On 11/21/22 11:21, Roger Pau Monne wrote:
> > When running as a PVH dom0 the ACPI MADT is crafted by Xen in order to
> > report the correct numbers of vCPUs that dom0 has, so the host MADT is
> > not provided to dom0.  This creates issues when parsing the power and
> > performance related data from ACPI dynamic tables, as the ACPI
> > Processor UIDs found on the dynamic code are likely to not match the
> > ones crafted by Xen in the dom0 MADT.
> > 
> > Xen would rely on Linux having filled at least the power and
> > performance related data of the vCPUs on the system, and would clone
> > that information in order to setup the remaining pCPUs on the system
> > if dom0 vCPUs < pCPUs.  However when running as PVH dom0 it's likely
> > that none of dom0 CPUs will have the power and performance data
> > filled, and hence the Xen ACPI Processor driver needs to fetch that
> > information by itself.
> > 
> > In order to do so correctly, introduce a new helper to fetch the _CST
> > data without taking into account the system capabilities from the
> > CPUID output, as the capabilities reported to dom0 in CPUID might be
> > different from the ones on the host.
> > 
> > 
> 
> Hi Roger,
> 
> First of all, thanks for doing the grunt work here to clear up the ACPI
> situation.
> 
> A bit of background, I'm trying to get an AMD APU (CPUID 0x17 (23)) to work
> properly
> under Xen. It works fine otherwise but something is amiss under Xen.

Hello,

Sorry for the delay, I've been on paternity leave and just caching up
on emails.

> Just to make sure that the patch is working as intended, what I found when
> trying it out
> is that the first 8 CPUs have C-States, but 0, 2, 4, 6, 8, 10, 12, 14 have
> P-States, out of
> 16 CPUs. Xen tells Linux that there are 8 CPUs since it's running with
> nosmt.
> 
> Regards
> - Josef
> 
> xen_acpi_processor: Max ACPI ID: 30
> xen_acpi_processor: Uploading Xen processor PM info
> xen_acpi_processor: ACPI CPU0 - C-states uploaded.
> xen_acpi_processor:      C1: ACPI HLT 1 uS
> xen_acpi_processor:      C2: ACPI IOPORT 0x414 18 uS
> xen_acpi_processor:      C3: ACPI IOPORT 0x415 350 uS
> xen_acpi_processor: ACPI CPU0 - P-states uploaded.
> xen_acpi_processor:      *P0: 1700 MHz, 2071 mW, 0 uS
> xen_acpi_processor:       P1: 1600 MHz, 1520 mW, 0 uS
> xen_acpi_processor:       P2: 1400 MHz, 1277 mW, 0 uS
> xen_acpi_processor: ACPI CPU1 - C-states uploaded.
> xen_acpi_processor:      C1: ACPI HLT 1 uS
> xen_acpi_processor:      C2: ACPI IOPORT 0x414 18 uS
> xen_acpi_processor:      C3: ACPI IOPORT 0x415 350 uS
> xen_acpi_processor: ACPI CPU2 - C-states uploaded.
> xen_acpi_processor:      C1: ACPI HLT 1 uS
> xen_acpi_processor:      C2: ACPI IOPORT 0x414 18 uS
> xen_acpi_processor:      C3: ACPI IOPORT 0x415 350 uS
> xen_acpi_processor: ACPI CPU2 - P-states uploaded.
> xen_acpi_processor:      *P0: 1700 MHz, 2071 mW, 0 uS
> xen_acpi_processor:       P1: 1600 MHz, 1520 mW, 0 uS
> xen_acpi_processor:       P2: 1400 MHz, 1277 mW, 0 uS
> xen_acpi_processor: ACPI CPU3 - C-states uploaded.
> xen_acpi_processor:      C1: ACPI HLT 1 uS
> xen_acpi_processor:      C2: ACPI IOPORT 0x414 18 uS
> xen_acpi_processor:      C3: ACPI IOPORT 0x415 350 uS
> xen_acpi_processor: ACPI CPU4 - C-states uploaded.
> xen_acpi_processor:      C1: ACPI HLT 1 uS
> xen_acpi_processor:      C2: ACPI IOPORT 0x414 18 uS
> xen_acpi_processor:      C3: ACPI IOPORT 0x415 350 uS
> xen_acpi_processor: ACPI CPU4 - P-states uploaded.
> xen_acpi_processor:      *P0: 1700 MHz, 2071 mW, 0 uS
> xen_acpi_processor:       P1: 1600 MHz, 1520 mW, 0 uS
> xen_acpi_processor:       P2: 1400 MHz, 1277 mW, 0 uS
> xen_acpi_processor: ACPI CPU5 - C-states uploaded.
> xen_acpi_processor:      C1: ACPI HLT 1 uS
> xen_acpi_processor:      C2: ACPI IOPORT 0x414 18 uS
> xen_acpi_processor:      C3: ACPI IOPORT 0x415 350 uS
> xen_acpi_processor: ACPI CPU6 - C-states uploaded.
> xen_acpi_processor:      C1: ACPI HLT 1 uS
> xen_acpi_processor:      C2: ACPI IOPORT 0x414 18 uS
> xen_acpi_processor:      C3: ACPI IOPORT 0x415 350 uS
> xen_acpi_processor: ACPI CPU6 - P-states uploaded.
> xen_acpi_processor:      *P0: 1700 MHz, 2071 mW, 0 uS
> xen_acpi_processor:       P1: 1600 MHz, 1520 mW, 0 uS
> xen_acpi_processor:       P2: 1400 MHz, 1277 mW, 0 uS
> xen_acpi_processor: ACPI CPU7 - C-states uploaded.
> xen_acpi_processor:      C1: ACPI HLT 1 uS
> xen_acpi_processor:      C2: ACPI IOPORT 0x414 18 uS
> xen_acpi_processor:      C3: ACPI IOPORT 0x415 350 uS
> xen_acpi_processor: ACPI CPU0 w/ PBLK:0x0
> xen_acpi_processor: ACPI CPU0 w/ PST:coord_type = 254 domain = 0
> xen_acpi_processor: CPU with ACPI ID 1 is unavailable

Hm, that's weird, do you think you could check why it reports the CPU
is unavailable?

Overall I don't like the situation of the ACPI handling when running
as dom0. It's fragile to rely on the data for dom0 CPUs to be
filled by the system (by adding some band aids here and there so that
the PV vCPUs are matched against the MADT objects) and then cloning
the data for any physical CPU exceeding the number of dom0 virtual
CPUs.

IMO it would be much better to just do the handling of ACPI processor
objects in a Xen specific driver (preventing the native driver from
attaching) in order to fetch the data and upload it to Xen.  This is
what I've attempted to do on FreeBSD, and resulted in a cleaner
implementation:

https://cgit.freebsd.org/src/tree/sys/dev/xen/cpu/xen_acpi_cpu.c

I however don't have time to do this right now for Linux.

> xen_acpi_processor: ACPI CPU2 w/ PBLK:0x0
> xen_acpi_processor: ACPI CPU2 w/ PST:coord_type = 254 domain = 1
> xen_acpi_processor: CPU with ACPI ID 3 is unavailable
> xen_acpi_processor: ACPI CPU4 w/ PBLK:0x0
> xen_acpi_processor: ACPI CPU4 w/ PST:coord_type = 254 domain = 2
> xen_acpi_processor: CPU with ACPI ID 5 is unavailable
> xen_acpi_processor: ACPI CPU6 w/ PBLK:0x0
> xen_acpi_processor: ACPI CPU6 w/ PST:coord_type = 254 domain = 3
> xen_acpi_processor: CPU with ACPI ID 7 is unavailable
> xen_acpi_processor: ACPI CPU8 w/ PBLK:0x0
> xen_acpi_processor: ACPI CPU8 w/ PST:coord_type = 254 domain = 4
> xen_acpi_processor: CPU with ACPI ID 9 is unavailable
> xen_acpi_processor: ACPI CPU10 w/ PBLK:0x0
> xen_acpi_processor: ACPI CPU10 w/ PST:coord_type = 254 domain = 5
> xen_acpi_processor: CPU with ACPI ID 11 is unavailable
> xen_acpi_processor: ACPI CPU12 w/ PBLK:0x0
> xen_acpi_processor: ACPI CPU12 w/ PST:coord_type = 254 domain = 6
> xen_acpi_processor: CPU with ACPI ID 13 is unavailable
> xen_acpi_processor: ACPI CPU14 w/ PBLK:0x0
> xen_acpi_processor: ACPI CPU14 w/ PST:coord_type = 254 domain = 7
> xen_acpi_processor: CPU with ACPI ID 15 is unavailable
> xen_acpi_processor: ACPI CPU8 - P-states uploaded.
> xen_acpi_processor:      *P0: 1700 MHz, 2071 mW, 0 uS
> xen_acpi_processor:       P1: 1600 MHz, 1520 mW, 0 uS
> xen_acpi_processor:       P2: 1400 MHz, 1277 mW, 0 uS
> xen_acpi_processor: ACPI CPU10 - P-states uploaded.
> xen_acpi_processor:      *P0: 1700 MHz, 2071 mW, 0 uS
> xen_acpi_processor:       P1: 1600 MHz, 1520 mW, 0 uS
> xen_acpi_processor:       P2: 1400 MHz, 1277 mW, 0 uS
> xen_acpi_processor: ACPI CPU12 - P-states uploaded.
> xen_acpi_processor:      *P0: 1700 MHz, 2071 mW, 0 uS
> xen_acpi_processor:       P1: 1600 MHz, 1520 mW, 0 uS
> xen_acpi_processor:       P2: 1400 MHz, 1277 mW, 0 uS
> xen_acpi_processor: ACPI CPU14 - P-states uploaded.
> xen_acpi_processor:      *P0: 1700 MHz, 2071 mW, 0 uS
> xen_acpi_processor:       P1: 1600 MHz, 1520 mW, 0 uS
> xen_acpi_processor:       P2: 1400 MHz, 1277 mW, 0 uS
> 
> As a bonus, here are the previous debug output on the same machine.

I think the output below is with dom0 running as plain PV rather than
PVH?

Thanks, Roger.
