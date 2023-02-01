Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0E3686E86
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 19:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjBAS6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 13:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbjBAS62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 13:58:28 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842AC241E6;
        Wed,  1 Feb 2023 10:58:10 -0800 (PST)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 311FxFmJ011645;
        Wed, 1 Feb 2023 10:57:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=b3KQT3u0GMigHC10ECygXUyt/SEvLvNxlCkR4uDeAdM=;
 b=cqw+b7MPYNdwFAMVnJCGdpqStqPQAtmg4RP7CS8VjtHouuJydnNTq5dRmkYnIY61YUWt
 cg7mdBjZLcAC/37cZcHeBeBozsNz4RvjC7iVz9RNx0EvZQ1Czh8R5/qwHYp8RMUAkRyV
 Jg5qj6fEMF6NEVAqr+iGd0MyQNptO+5yLtHjVqV7Bk5rohNWyrr87chBzus5zHmCWDPl
 GaZXFYhdg7Fnbz8g9gAbwYT41H3pV/iHx2LVYMT1I8acVRCw9S+Q7TM1JxorjM/pKsSz
 GYleSn63uBqKhqmQi8WaOOsDrYkGklfBm3y/+DPRBkDo23o79tKi9X7SOiebNywoA4H8 jA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3nfp8k9nem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 10:57:53 -0800
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 27CA8C008B;
        Wed,  1 Feb 2023 18:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1675277873; bh=b3KQT3u0GMigHC10ECygXUyt/SEvLvNxlCkR4uDeAdM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=dUhX1nxhYcj2WbWC0eB+yA+mKb8eJVGmRFEZa8Uc6m0wLN3Lom0j/2/gWaJBmGKP5
         b/PI835364qExEEqshS/s+QbI1t0UweDwLSp+j5GTZOPVWXhxUWU9AiR+mkkPgj2iv
         TdnWFiGB5iIIEPHhQQf7gNx1n8mZbfW9o9nOin//x7BSCkrycSRHObuFDuKvsWXZAe
         f8dWvaTrVpl4CiqHIFd2i4n6mGSS78NPm2djVxWvj4wtLfp1mKVT2Mcdbhc545N58L
         QJM6VHSABcbAvTKc0agFqgWSdN42LPxX2+pU3jI/Cl8PuV/I910JXPboUNR4vFs2yg
         qQ2NDsPlX3/mg==
Received: from o365relay-in.synopsys.com (unknown [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 7D57DA005C;
        Wed,  1 Feb 2023 18:57:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 253AD400A6;
        Wed,  1 Feb 2023 18:57:51 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="H26Zv3DW";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+4v3b6GlSywujTd7TSUfcwxLdbtDSSMtwRqGfT6lDmQS24qd9+75Xzj5UHYXazP7rY0y41kBQKLe5VypVMTxq9W45mQfnnbVZfyf/nvxQqha0v2jCiFgQDQD9S8/1/hGyiqjF1BjSrPHPJwtNEqAfEWPctCrJJ/cKRmlaoQfBTQ80xGMlQFRtbPtwaooJlwTjI5QltnL6vYthGy7MBEtuxwKkxpoA/IAcChNv/PdpSwFAV7r0stQtwhtN1fePCPhoh3NB9OUOsWsC1LQLNmHo1wjFDrjRdZVFTwq8/6+cl0fdO6v0XfUEwn0fnjzqdAuMKzwF6VHGyixyoj2yKmBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3KQT3u0GMigHC10ECygXUyt/SEvLvNxlCkR4uDeAdM=;
 b=Hg2JAL/jEp6cIFQtmx0BBJFV5FnUEv1rC7D1a64F9GmCgQIBiJeF53TCnD3Q1dQE89hiuhefL24fWzbxykPnJzjUPwUQWNYBBxAqGhTSvDhpnHJ4zveO4WUM0CXDfB7Ko92TL5BpyUlmuCaGEgtrwrU3D5CDd7M8QWIhb/4DeyFNFz9c585Z86mBrg88yH1WyilhzC2WWCTgJTWx1xIOA9Ev4LwXW+/8QDt/zc/fMaaR1iyecpnN1ttS/08zEAbAoXK9P+jD8cr2WzlXu6LtURdWGR5Ng9MvoyoRuuYbVpjJBR/PPQMCpx3JIpvB5U9gkSjsiva+Je9n7ZOyHUEprQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3KQT3u0GMigHC10ECygXUyt/SEvLvNxlCkR4uDeAdM=;
 b=H26Zv3DWCl/SQUsEuJazWaPeFmvQJSyluZZhZMEsztgnIXALacRxyZqNXrnhIdTX6Ss+rDSbpXejfzuTBo+9REbUij5o5ea/GnKhEQthaVDXbZEj+KRN24HBaXuVZaJ+HxBnSW598STn7YaHw6WUL+IoWhAnjOjO2ycwjfTbykU=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SJ0PR12MB6904.namprd12.prod.outlook.com (2603:10b6:a03:483::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Wed, 1 Feb
 2023 18:57:47 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c%7]) with mapi id 15.20.6043.038; Wed, 1 Feb 2023
 18:57:47 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Linyu Yuan <quic_linyyuan@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        =?utf-8?B?7KCV7J6s7ZuI?= <jh0801.jung@samsung.com>,
        'Felipe Balbi' <balbi@kernel.org>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        "'open list:USB XHCI DRIVER'" <linux-usb@vger.kernel.org>,
        'open list' <linux-kernel@vger.kernel.org>,
        'Seungchull Suh' <sc.suh@samsung.com>,
        'Daehwan Jung' <dh10.jung@samsung.com>
Subject: Re: [PATCH] usb: dwc3: Clear DWC3_EVENT_PENDING when count is 0
Thread-Topic: [PATCH] usb: dwc3: Clear DWC3_EVENT_PENDING when count is 0
Thread-Index: AQHZHmjkAYxM4HeOyE6Dd8zsa51+rq6PLu+AgAABtICAAGoRgIABIhKAgAW2rICAAH0sAIAAD+kAgAADfgCAAAI7gIAAShIAgAESQYCAAB19AIAAC5QAgB+064CAAmC+AA==
Date:   Wed, 1 Feb 2023 18:57:46 +0000
Message-ID: <20230201185742.lc26zheeuhvfuxet@synopsys.com>
References: <20230109182813.sle5h34wdgglnlph@synopsys.com>
 <e7217471-5b08-eee6-fba8-06e879118d77@quicinc.com>
 <20230110025310.nowjnrmo3oag76xd@synopsys.com>
 <4ced9c3e-c7b5-e0a0-88ec-1ac383d893a2@quicinc.com>
 <bfcfac21-3df7-7f47-576b-0717f2bab393@quicinc.com>
 <f35f0636-5b3f-9002-77f3-a3c2c53be973@quicinc.com>
 <20230111000021.r2bd5gnfwlbxzxd3@synopsys.com>
 <826538ae-d27a-fc03-c8dc-94b53c8a44cf@quicinc.com>
 <20230111022720.mcrhdrthgwlwszcv@synopsys.com>
 <c76d426c-c65b-1334-627a-1a6c615ddd93@quicinc.com>
In-Reply-To: <c76d426c-c65b-1334-627a-1a6c615ddd93@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SJ0PR12MB6904:EE_
x-ms-office365-filtering-correlation-id: 4ca59589-4bf3-416a-cebb-08db04863562
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s1FgNqOGV9kTmU8G8u985/GtUZ1fCgu4l1DgjSslVqC6D22xwnJu5oeDyHLTqLbzQhzVFVoXh8+XgaKz+lPvKVD+ouyM5uMQqNnLb+4wt8NqcjSBUFwu/O/nB/kG1gh70UmJPfcehMTY2SUF1b4XmiW3GexX2QoZHwKSASqoXSqUBfG0/XC9cfYktdXylfkSlHdb6PPK2ZqBANaEdkacWFfY4AMAavzrS6+ufArSSEKxXY551NDaU1p7h8uuWkGX4g9Cl2zQhJ7+63Qqrm5SrF9035cZl3t5oTKexuA6s+o8glePJyhfapIY6+LzrzVmPXXWQQaYDtu5vVgTuzBWTss7Y8eGtDY/RsmCej5BRa5Y/H/ikKfUjfQ2oUqUoIkUTL4FHFgeVCro8JHA2j6QawX48gi8RdH1DbJeomNDnAI7D96gvWkQWGeaa/sSbH9N0vyUDQx3jh9+baaFLJUqdXk2E/TgawRcq8v1LSOVDnYZekw0qL0MIPyNDrzekWzHp6dsit0F2s90ht8RV3S4FMF1lkGTpeudfjtEgcqosDeQm6jEJdragBrfKeTjw9dfFGOyFiRD5Rs7o6/5gcxcPCP/Obd/qVIYyis9ZjLR0jbRHRexi9qh7YeR01DALuNcH6kqJ2hOJbUzL3MgNH1LOtIoW7U7SnJkeXdchANpGfiEvMzkfJXp+lgnsGAvwwr7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(376002)(39860400002)(366004)(396003)(451199018)(5660300002)(8936002)(2906002)(54906003)(6506007)(83380400001)(86362001)(41300700001)(66476007)(8676002)(6916009)(66946007)(66446008)(478600001)(4326008)(1076003)(6512007)(71200400001)(26005)(6486002)(66556008)(186003)(36756003)(76116006)(38070700005)(2616005)(64756008)(316002)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEhtQzFNTno3ZDR2aDBBa0ZFQ3Y3QWhNWEowaGkvbmphZ2lBS1NNRENOaXN3?=
 =?utf-8?B?WXBISzB6ZW9aTHBEdWhXM1VpS0NLZkNmdldCZlZRMzQ1anV2eFB5Y1RTZEdu?=
 =?utf-8?B?bUNSNG5XWHlnNlhCcFVTSFc2bFIvaGkwMzV6SXFhdmh3bnRHQ21iT29FUFlm?=
 =?utf-8?B?blViUnNyVEVNdGpQQ2ViaWx1aTJ1Mi9RaGRzS1lZeS83S0NrTUcvUWsvZDVC?=
 =?utf-8?B?czBWckV3eG5YNDZ6OFZ4QXdFdkxERzYyTm5xTUEyZUZUNkVrZE5ibFlBZkxz?=
 =?utf-8?B?UnJUZkVGYTU3SkJINWx2KytJaDNLWllqMXBoV0t3VUhSaFhtbjlQZ1ZTUDBE?=
 =?utf-8?B?Vml3NElPcC9ibVBES01vL255THhJWHpXeTd3WlFWcDZ0d0hJQ1ZkMnJoOCtH?=
 =?utf-8?B?NE1qZlJxL2ltQXVmU1VUVG1YcFdOQUJKeTZyTXM1TEtFbHI1WWs3WFp3QUlY?=
 =?utf-8?B?TjMwNzhlS1E5eEdpRUdIb29pMXdpeVlDT0VRSG41YU14RnZYK2YzNS8yRXll?=
 =?utf-8?B?U0pzSTdBaFplV1FyN2l3Rnd4OGlyd2tpaFVaWG1mWDExRGxIdERqTzhOTDA0?=
 =?utf-8?B?OHhpdDdyaUFBNnV3d1NMb0wwRHhuTGZsVGp2T09lUGt6eEFidHlpK3M1Ri8w?=
 =?utf-8?B?YzZaUVI1RkVIdUNxbzhzQytBNVN4OGp4bnI0SDUrUEowcXBHL09OanRvaVMw?=
 =?utf-8?B?K1oweVhZOWZEcXpHdG55NFVySnRaWXE3dEhDMUx1ZnJUMnpra0pQdzRSdW90?=
 =?utf-8?B?ZHlUR1ROYzRxUFZZazRDU0VKYjlhMWh1RDBsdk1ZS1NRa01ueWZoZUZpaFoz?=
 =?utf-8?B?T2orNzhkZjE1bXNadWlSV3RSMmVHaER4Y052UUxSZGNLQ2Y2MUhhRFk0ZjNF?=
 =?utf-8?B?QjJLQ3NWT0ExR0ZiSnJVbk1paG1CYnJ5cVFpTk4veGt2UjZRSWRFS3A0ZW9k?=
 =?utf-8?B?ZnkvMW90RFQvemlvOHpQWFNwL1F4OE9RL0RGK0QvR1g2ZnNvK2ExdnBCMFlJ?=
 =?utf-8?B?dFVFT3JuSDRWY0xDUW5SOGlXanVTcnBUdDRsTFdIWTVvTE5pOGhheVNhcDNj?=
 =?utf-8?B?UzhUYm9FSzk3ZHc1c0w0ckEzWndFQ1V0UUJWVG9RaW9zUlpjcVYyV3p2NVd1?=
 =?utf-8?B?cFduL3IwT2lDTzFUbHBVVXlLWEVETGYxVHg2QVR4YWRhUzdBWG5wWXJXZ29u?=
 =?utf-8?B?akR3S24yRURQT1FJQW4vWERKUGh1SExkUUN3SzZ2NlRlandJZnBFVmw4Q0ZQ?=
 =?utf-8?B?VWtHYXdlak9qQnF5RU04WStYVFJGb1UveTNMSzFvM0R0TFg0NWI4bzBrVmRG?=
 =?utf-8?B?SkZoa25pM2hqY2kwSGFmUC9IZkMyQzJhamRTWVFCUlNLaFhXYU5SaEJTTU1s?=
 =?utf-8?B?TWxkRlhESitnT0ljRXFDcnRaQ0ppbjVKTUZnbmRMWjRSd3B5MUFDVTUzdzIz?=
 =?utf-8?B?NCs5Zk96M1RNQmxiT0c5ZDJTSE4xQUZNc2ovbWU0aHREMW9yUklwd3MvdW10?=
 =?utf-8?B?US9UY2Q3OHVjdllXcEtyOE05ZjVFUG93OWdzUWJ1R0JlTTUwQ2hFdkZOQ1Rl?=
 =?utf-8?B?U20yN0JxUjJDZEhzdmdFdXRCeXV4ZzFMMUxqYkpoWjV5aUM4VzZYS1gxRjNR?=
 =?utf-8?B?KzE2UDZGeEowZ0tGV0ZjNTd6ZWpoR1BpaGx5TXh4anhRZzR3R3FidmI0d0xz?=
 =?utf-8?B?cjJCNnZCMXFBbjExcFRCWmdldU1LOHk4aVpWQVlyOWM1SldWam0xUUVWcEsr?=
 =?utf-8?B?bUNRTkJQMC83Ujl0QWw5dEZVTEtBMXFpemF6SC80YlZ4WkN6Q3Q4V2hlTUNO?=
 =?utf-8?B?eGwzWFVkL2tTOG9jaTdOU0xqMGhqL3RJREVkaFN6dHlCb2RxUWJ2TWxvNmJq?=
 =?utf-8?B?NWxINU9tMUw0Sks5aWc2OXU0cWI4bjhvZUJ1MXpxSU9rTi9kbnNsaGlINHJO?=
 =?utf-8?B?VWN2SWo3UHFEWWZ0SHJMY2VwelFmVWlwL001R2tWblBKeDRxaUFYVFJVYWlQ?=
 =?utf-8?B?OWYzSmh5TWdzVXZHcXQyendJSnNCQXdQM1pkb3dMdndERFNyUXYxSjZNUTFo?=
 =?utf-8?B?QTlUQW1yaWU3MDBiMlJ0ZExURzFQNG14WTE5YmJ6SjNlU3hEVDFQQXlZTSs3?=
 =?utf-8?B?WHhIa3U1SzBCd2gzUC8zSTBFeEwyeTZIeU1VekFoZXZzbTZGd1oxNWFjbnBQ?=
 =?utf-8?B?VlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D30A283EF879143A02BDDFD7860444F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UUZGalpXWXlhb2ZaZkhRUXBaeUtjbVpDdE9yakpIQU1HdDlRUmJVZFVSWHRk?=
 =?utf-8?B?UFM5ZFh6bHhIRHY0WmhJRm0yVDk5N3ZzVUpEa1gwMnJ5ZXpwTTRhdU0xc0lw?=
 =?utf-8?B?OGRvY1gzb3ROdnZ0T0xDMzNEd2k3Zmk2VmtibTV5QmxJcEpkdHRLL1k4UzRy?=
 =?utf-8?B?NXd2eWNVTWtyY2FlRFBaOGZsekVTVUUra1M1NUVhM2VCZ0E2WDNoZjF2dnZk?=
 =?utf-8?B?WHdTMTkvMzJOM3l1VEtrL1hEeVpuN21ZeGV4bXNzTVMyVTcxQmF5d3ZGSW55?=
 =?utf-8?B?QjNqaVFIanh5VlRlNW9WL2w1OHNKWmIzZXJNMGZtVktLTmd2YXZmNGw5eTNs?=
 =?utf-8?B?WHdNbEVDZjdTL0YxbnZIVlUzYWdmelRBQURzRWxmT0dNemVIZkpYSEpLY0RU?=
 =?utf-8?B?TVd6VWduTGV1dVpuTXhrZndGN2ZLVkE1Sk5LUjNTQTJPVWlTWnFBNXpwQ1M1?=
 =?utf-8?B?WTV3RTBmRkdUaDFOdHZMbHBqRjlodEpnR05OSlh3ZlQyU1ZnT0hxTE52NFNp?=
 =?utf-8?B?dDdCRmFNYzFhS1BHdjRIM255aXdzcVpJZlI4S3E5cTZ0cE5icW9jSUlaSmtN?=
 =?utf-8?B?cVdkckJkS2dabzAzbVcvcDRPMjlFdDNUVWlxdlZDWkYwRVRKYlFpS29KSDgw?=
 =?utf-8?B?L1p5ZXF6RGtKRmE1NDhVRkNINTA0TlhCSnBiNVVLcFRqZklhRUhndi9GcUh1?=
 =?utf-8?B?TytieGN5WkpEN0NzdlZUY2p3RGhqYm1qeXVqa25DZDZkRE16VXdkZFhHOWIz?=
 =?utf-8?B?S05HQ2kyNHZBbFZqMS84dFhKTEEzYWY1V3dTYUEydUg3TWdiNkxCNlYxMGdO?=
 =?utf-8?B?VTZwOHJiZWFoZGFlbDJJOEJHTElVcEg3QzQ3UHRSVFM0ZGxzcDBDQnpDa3U4?=
 =?utf-8?B?TnI2Z0wzWWp1NHZ3bks1SHl0R2Q0ZTc0OFhHMWx2TG5OT0JJcW9ydG1VNFNP?=
 =?utf-8?B?ck5pbnM3alVrV2JPWmhaaXpYUGRtbUVJNFZxd2ZzNzdOVVpkOWVTdXpvSzNS?=
 =?utf-8?B?cmZvNmloN2FFOStjbE5MNmZ0NDZvQkJ1d3lTM3VpMmR3MVFFN21Gd09jTzhj?=
 =?utf-8?B?SHJEYTkwUDQ3cXRHc3VLRHdxOURKMm5FcENZRUNLamEwYm9tQjBzL3ppa3lU?=
 =?utf-8?B?Q25NS2MzSCtWOWplZzhqMUgvYjJWTTF1Ykh5Zm1uRHFXVFVuWUZMMDg0bmMx?=
 =?utf-8?B?K2JLa0hmZEZZSVBLNXQyS0dadk9kMm1tUEYvYWNNVmR4U3c4Uksxd3BmdzBB?=
 =?utf-8?Q?s1pF2nyThZYP/kJ?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca59589-4bf3-416a-cebb-08db04863562
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 18:57:47.0228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bPkLg/GNVyHB11b88K0MHJa9/FKHpMyQ8a6D0npZ+VHxyGbe791Gd2Z3HUwmAPfn74EkeSJptTosEfAIclxaRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6904
X-Proofpoint-ORIG-GUID: VAPFT83oVIDiV1BYxOKIAvMZgq9BGfym
X-Proofpoint-GUID: VAPFT83oVIDiV1BYxOKIAvMZgq9BGfym
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_04,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 mlxlogscore=394 mlxscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302010160
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBKYW4gMzEsIDIwMjMsIExpbnl1IFl1YW4gd3JvdGU6DQo+IGhpIFRoaW5oLA0KPiAN
Cj4gDQo+IHJlZ2FyZGluZyB5b3VyIHN1Z2dlc3Rpb24sIGFzc3VtZSBpdCBpcyBub3QgUENJZSB0
eXBlLMKgIHN0aWxsIGhhdmUgb25lDQo+IHF1ZXN0aW9uLA0KPiANCj4gDQo+IC3CoMKgwqDCoMKg
wqAgaWYgKGV2dC0+ZmxhZ3MgJiBEV0MzX0VWRU5UX1BFTkRJTkcpDQo+ICvCoMKgwqDCoMKgwqAg
aWYgKGV2dC0+ZmxhZ3MgJiBEV0MzX0VWRU5UX1BFTkRJTkcpIHsNCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgaWYgKCFldnQtPmNvdW50KSB7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1MzIgcmVnID0gZHdjM19yZWFkbChkd2MtPnJlZ3Ms
IERXQzNfR0VWTlRTSVooMCkpOw0KPiArDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBpZiAoIShyZWcgJiBEV0MzX0dFVk5UU0laX0lOVE1BU0spKQ0KPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGV2dC0+ZmxhZ3MgJj0gfkRXQzNfRVZFTlRfUEVORElORzsNCj4gDQo+IGRvIHdlIG5lZWQg
dG8gcmV0dXJuIElSUV9XQUtFX1RIUkVBRMKgID8NCg0KTm8sIGlmIGV2dC0+Y291bnQgaXMgMCwg
YnV0IEdFVk5UQ09VTlQgaXMgPiAwLCB0aGUgY29udHJvbGxlciB3aWxsDQpnZW5lcmF0ZSBpbnRl
cnJ1cHQuIFRoZSBldnQtPmNvdW50IHdpbGwgYmUgdXBkYXRlZCBhbmQgdGhlIGV2ZW50cyB3aWxs
DQpiZSBoYW5kbGVkIG9uIHRoZSBuZXh0IGludGVycnVwdC4NCg0KPiANCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIElSUV9IQU5ETEVEOw0KPiANCj4gYXMgaGVyZSByZXR1cm4gSVJRIEhBTkRMRUQsIGhvdyBj
YW4gd2UgbWFrZSBzdXJlIGEgbmV3IElSUSB3aWxsIGJlIGhhbmRsZWQNCj4gYWZ0ZXIgcHJldmlv
dXMgSVJRIHRocmVhZCBjbGVhbiBQRU5ESU5HIGZsYWcgPw0KDQpJZiBldnQtPmNvdW50ID4gMCwg
dGhhdCBtZWFucyB0aGUgYm90dG9tIGhhbGYgaXMgc3RpbGwgcnVubmluZy4gU28sDQpsZWF2ZSBp
dCBiZS4gSWYgZXZ0LT5jb3VudCA9PSAwLCB0aGVuIHRoZSBjYWNoZWQgZXZlbnRzIGFyZSBwcm9j
ZXNzZWQsDQp3ZSdyZSBzYWZlIHRvIGNsZWFyIHRoZSBQRU5ESU5HIGZsYWcuIE5ldyBpbnRlcnJ1
cHQgd2lsbCBiZSBnZW5lcmF0ZWQgaWYNCkdFVk5UQ09VTlQgaXMgPiAwLg0KDQo+IA0KPiArwqDC
oMKgwqDCoMKgIH0NCj4gDQo+IA0KPiBhbHNvIGZvciBub24tUENJZSBjb250cm9sbGVyLCBjb25z
aWRlciBJUlEgbWFzayByZWdpc3RlciB3b3JraW5nIGNvcnJlY3RseSwNCj4gDQo+IGNvbnNpZGVy
IGEgY2FzZSBJUlEgaGFwcGVuIGJlZm9yZSBJUlEgdGhyZWFkIGV4aXQswqAgaGVyZSBqdXN0IHJl
dHVybg0KPiBJUlFfSEFORExFRC4NCj4gDQo+IG9uY2UgSVJRIHRocmVhZCBleGl0LCBpdCB3aWxs
IGNsZWFuIFBFTkRJTkcgZmxhZywgc28gbmV4dCBJUlEgZXZlbnQgd2lsbCBydW4NCj4gbm9ybWFs
bHkuDQo+IA0KPiBpZiDsoJXsnqztm4ggc2F3IFBFTkRJTkcgZmxhZyBpcyBub3QgY2xlYXJlZCwg
ZG9lcyBpdCBtZWFuIElSUSB0aHJlYWQgaGF2ZSBubw0KPiBjaGFuY2UgdG8gZXhpdCA/DQoNClRo
ZSBQRU5ESU5HIGZsYWcgc2hvdWxkIGJlIGNsZWFyZWQgZXZlbnR1YWxseSB3aGVuIHRoZSBib3R0
b20gaGFsZg0KY29tcGxldGVzLiBJIGRvbid0IGV4cGVjdCB0aGUgaW50ZXJydXB0IHN0b3JtIHRv
IGJsb2NrIHRoZSBJUlEgdGhyZWFkDQpmb3JldmVyLCBidXQgSSBjYW4ndCBndWFyYW50ZWUgdGhl
IGRldmljZSBiZWhhdm9yLiDsoJXsnqztm4ggY2FuIGNvbmZpcm0uDQpUaGlzIGNoYW5nZSBzaG91
bGQgcmVzb2x2ZSB0aGUgaW50ZXJydXB0IHN0b3JtLg0KDQpCUiwNClRoaW5oDQo=
