Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0166A51A5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 04:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjB1DK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 22:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjB1DKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 22:10:54 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AED1E1F8;
        Mon, 27 Feb 2023 19:10:53 -0800 (PST)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31S2mBpV012164;
        Mon, 27 Feb 2023 19:10:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=2U7W5uwvp7vvRAMyOEm1q1QWGcHfGnAL97SyQpSPQmI=;
 b=v5MK6VFIuzBVpkJ6jWbI5SQVHXuut7qsnA0CO7hGj1I5kUZnsiIKHTUSryo61+kwFOG9
 Uw+M7AjtFz9istint7azzHzeGQrmTbmyvIVGqzbhB+llaKt63HGxx8kaN9uFIfUr7lBs
 Z+o/fn97sAUHeqCewAI1I6TJDM18r/nvSouarwcwo+AqCme5J44D8uurQ/ciSJ9J2PBj
 Q6GC4U8hmt6S+TUtpAwzBAayUTy53z99p6wCJMUujdUX0YsX//SI3hZeM/HGm9Vg1alo
 faSZ11nxfXy6U9u+2+DF/VuWjOgQbiAalRZYQci6m4qYy3P4zsvt7KvTL3fgpJ+s80XN dw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3nyhumdkbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 19:10:50 -0800
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A92BBC05B0;
        Tue, 28 Feb 2023 03:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1677553849; bh=2U7W5uwvp7vvRAMyOEm1q1QWGcHfGnAL97SyQpSPQmI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=b449wx3icAuoeD3SyHXk8XvuqMJ+sLcOXC+G8rcojW4xoK7881en5ZWo72AVzoE3F
         mvnilSprCqZgyTjWbRLRdLJAxbnOS2FnUzngmrqKRXnLHmObeS/xenw2OwEbFlooi+
         5KQT4F1Enf0a2Vj1QkWHmGYXzT+49vzt9hiepFkoWt0YphKEs7Kz0xY3ocz4jtilee
         BIvMXQgcLv3KhrRqqsUcVZOe8+AEuRoEBIzLCKAb9GQ5+cnYL23m8sHURZsM6bHCYV
         2I5E7JGIbx1KXrCk0L8nHpv0+N6+GHa4XGeBCMrXeOQkRuGzDUI595LLxMaJrT9Lj5
         IfG3gGoV88caQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay5.synopsys.com [10.202.1.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 3564FA0060;
        Tue, 28 Feb 2023 03:10:48 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id BF407A0094;
        Tue, 28 Feb 2023 03:10:48 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="fKKuh8kI";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2llm6m/CDjGyxu+w026249hh2HUkRcwH5Tp1IfoUG9+mvzAYg7LoZdIzqya5f3bQIqtlH3PFR5fdAVIezb6M2IArYhTQWRmMiwQRt4wa9HIlDz2Ln05W8Er1m8SBiAWdsdCzdDbZUdYdn/nwBoZxeh0ovGQdDGfWylsZ0VMjr1VmSKxp6RJr3t+gJXT+N1DdWfJZPrAEnRp+7kuxjccJRKqoJIMfjajGxrRqIVGy9O/mU7/7woYnasgkpKKRCqzfxU466fb7YbzDoRHPzMsc4WpOwnQ5j3aUFLakRF956UNmNoxlr758VFxOHox2xZPGS+g6j1gfMd/BUQ3zWShNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2U7W5uwvp7vvRAMyOEm1q1QWGcHfGnAL97SyQpSPQmI=;
 b=R9sFd/icXk+ptSZ7ApMcggU0JgQdjIeDy7NU/Dc93BJZQ0L+Q5CkmZTEh1caprj8CNLoef57sRMSE0u7xlIvFkIcVbHtq3t9CDIR2mf59/I3uqulUleYuekVALC9sBnOyDaf+0kI0aQZ2bO3qoXng3K50edTda2vWXHiawI9vGZV0qLZ7LQ+LxDN/fpGKXDIxheVoxkVcyjlnhrxWlzfIcv/SIXLo/Y5D1fUf0In7dgifVZMK4pyR8/KyZDy1ts4jmHFOcmOOnw44XWk1VsszD4iMpL5htoMj2LEFGne2G07g8NKdXreOvGevj5LT28Vh11LAzsJ5bBNoLPrauoLxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2U7W5uwvp7vvRAMyOEm1q1QWGcHfGnAL97SyQpSPQmI=;
 b=fKKuh8kIFZ9liZyOtc6EqrUi7HKZgGve6+T0X2U/24a7ADlAoxSQPDpi5t+ej9FwioiB1INjNzUDhhhJRZT4qb2XRdNQm5FirpAMGjYbIZyTE4ZcGsC3ioI32hLdo4hkODRGx53Z4p4ujXmz/SIymnfdkChyayeUhTZimT4B210=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DS0PR12MB8456.namprd12.prod.outlook.com (2603:10b6:8:161::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Tue, 28 Feb
 2023 03:10:43 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c%7]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 03:10:43 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH] usb: dwc3: gadget: Add 100uS delay after end transfer
 command without IOC
Thread-Topic: [PATCH] usb: dwc3: gadget: Add 100uS delay after end transfer
 command without IOC
Thread-Index: AQHZSwIl2lqyJq8SIUKTvkcQR1aWb67joCOAgAAOQoA=
Date:   Tue, 28 Feb 2023 03:10:42 +0000
Message-ID: <20230228031027.ghrfnda5lkt7qfmt@synopsys.com>
References: <20230227232035.13759-1-quic_wcheng@quicinc.com>
 <20230228021925.j5bquwnwuvog3hx6@synopsys.com>
In-Reply-To: <20230228021925.j5bquwnwuvog3hx6@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DS0PR12MB8456:EE_
x-ms-office365-filtering-correlation-id: 81565b6b-e4b9-4002-a40e-08db19396079
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hbJHke01N1vB10sd8jm9PZmmUo0NdEKTyJWUb1eeEVKt+QUSUiS1fpeuFDSiRYax8ZI4+pfJNHfe+8rFQX+ZNPiW+DGXaxVYrTCBbA+pFp65KDxd7VFmpdhgbO2RAeQQhQT8HOCoeszZirvwh436Bzw8g9wZHUs1oOwBYaoZjHkEWcyS7PHtrea5HmIOit+mtaST+oGZVxoB4waYzeMNFPSNrD79b51+bWe73jHt0SBYyeVbpbYe+6mirBF+VV8RLyDy5Td/AT37RJUlMI5Tw3dAX+uDtWbLWx6MR4mu2kOQ8GujG4b60yquxV4NiOFskPcbqPLD0IFoKVuI9li209+TjUgerD5Q+133cxB8nj8fzv3JNiyeAkUmsuQRvRQ6hdX0L0CY9jLa1pJdroBtg5Zy8VKtWqPy8zbyqqWqBFrFt3t76hKYPAXlKYIzJgkW46iMLAgnQu7BFleHoAkqiQI9CpBHBQjwj9vY/Waekzk+IL5GS7X10m7L/iXE0AOMC0+oC3EG+42SewpyKcLQjPcThJrGP7zuArHWif8syhP1C4eNHcLxodTeQXXJqeI4SRKy2tpYyhfRcRmnj3a934ojSGsfN1x0tQjeVGSYwGC+OZ1jNuvn1GT+4KSLtBomXoK2GHb+ilOUa1MfxXJiuCwL3h2TJI+sdrx/BbO++3Rv7eFd3lnoBFjBwGCQ9srH1chMr2r7ZheZKp7J0Mymtg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199018)(8936002)(122000001)(54906003)(316002)(36756003)(38070700005)(186003)(478600001)(71200400001)(86362001)(6486002)(6506007)(6512007)(1076003)(26005)(2906002)(2616005)(5660300002)(38100700002)(66446008)(64756008)(83380400001)(41300700001)(66946007)(66476007)(76116006)(66556008)(8676002)(6916009)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkswSkNMQjdqOTRONEdGRjAwckgzcHQ0Y1dXbEZ0aEtCOWMxNzFFWkpoektl?=
 =?utf-8?B?YUNtdE5PY0FBYzhxcjNIYmwzVEdnT3VGTDAzaHBFL3F4ME01Q1MvZHJYU0Fr?=
 =?utf-8?B?MnNhWU9nQTJDT0VrQ3pYWVpOa1M5U1QwTEh5ZTBQM1RyMFRLRVQzRmtvaytR?=
 =?utf-8?B?RjFtUzBjS3VrZmRUcE9kbmNTQ3RiTjZhRTA1OGdMSm55amR1Sm1IQ1BnMUJP?=
 =?utf-8?B?RFlmTlYrYlpUTVlGK1RqbXRMbDNYSFJTWkIyakl6WU5pejdpR1V1dzNmMG5Y?=
 =?utf-8?B?ZG53cmhTaThtNk5mRjg4SlRKcjRTejJ0UGdsTUFFZmZYQkUwTVlqL1dtK2NW?=
 =?utf-8?B?b3kxRXQzQnRyYjM3clBmblBScVJwYWFnU3dpemV6SGRLNlIvNVh2OUJtWjZX?=
 =?utf-8?B?cG04WWErNnB3TnJwRkhjRkh4eU5uQ0VNNTl6ejg0VU5sRzhvL3JKeGlwdUFh?=
 =?utf-8?B?Y2gyRTlCODZob3czWEJaRXVTdzNhY1kwa2lFSWpBUm1xb1dXb0ZYS2UwYXg5?=
 =?utf-8?B?ODdaeUMzSk1VcUlYcG9yUnZQUHBrZjAzcktkcmZMRnlrZmp2RDRyYkkrYUZK?=
 =?utf-8?B?TFZ5dnpna0twVW9meHdMRTI5RzBwNzJZcXdsOHNHS29oSTc5KzlVVURMVkRP?=
 =?utf-8?B?bzVMVVNWci9BVzlUbTBFb1BlbHJxWVBtb3dlZHZ4SFRhTHl4VnFPclczTU40?=
 =?utf-8?B?N0pldE1jRWRQVTBXMVBRUDE0MkQ4eDdIdnJmemlqdnJpRjliazlxYmNRSVZS?=
 =?utf-8?B?VVFTSmcxdFRUUVEzWTBIRnFoaWVYb2dydGM5bEpFajhCa0tEbXlrdjZpZ2hp?=
 =?utf-8?B?UmF5VFlaZ1hHMnJMend1dVFKbER6NHkyTHh0RTV0SkVhQjUxM3hncGVYSDY2?=
 =?utf-8?B?cWRmdFdEVXBKZ01UUTJhbDdEMkNLVnltZHFoSzF1S0l0TkpET2R1VGdtWmJk?=
 =?utf-8?B?a2xabFVPd1liaDZEbjhwT1BzZGNmaE1vSEFuVUdVY3JoQkdDUDkxRWZMbjEv?=
 =?utf-8?B?S09kai9GbEpPc09peFBLdEhNdURnTnhmZTRUbm5xdUVNYkFlWkZXeFFFcndX?=
 =?utf-8?B?Lzd5TkxDUnh1RHdNd0twWFl6NHRjU29UUlBwRE1yL3FDRnBGbytRVzlqcW5Q?=
 =?utf-8?B?cUljUG1HMWErSVJGNWVTZmRBR1Y5akgwb0JCc3BLZFRPYitEMkwzRURGVnVp?=
 =?utf-8?B?bUErNGNnY1dLSUR1WmhGYnlsQkViNUt5UWo5YlZpNjJId2VDWDhMNjZXdUJs?=
 =?utf-8?B?OUY1VnVscUFGSUdJN0pPTHUwdS9QTTZianY4a1pNNGdLRytzSW9sSksybUZK?=
 =?utf-8?B?YmdLOUVaR0ljdkFQaURFeThCek5HK0tUQTliUElPdHBCOE9rU0VVVkpxWjBw?=
 =?utf-8?B?dkkzNjZycFBndUI3Q3RuNkJuYVVCcGZSTkVDeGxySG1OaWFEc0JzZjdqZCsz?=
 =?utf-8?B?SUo4N0FIR24rS1pwQ2pFd1hJQ3ovdTlicGtqQy9maU5VUUNYRXFoamJjWlB1?=
 =?utf-8?B?em1lekphd3NIbUVaODRyOEh5ODV3T0pUdGZwQVU4WWZIcHo0VnNtRzNua2ow?=
 =?utf-8?B?NytidzMzM3FWZjdPZnpDMURxRytxamhnbzllbmtsVEVvbXprYUhVWXhjb0xK?=
 =?utf-8?B?VjU3cG42cDVaZS9zS2pJVmU4UHI4QzRFd2hRS1dmcjRMd0tCSzJoNVBnMEsv?=
 =?utf-8?B?d1habWFNcjhWaXVhVlhSVUR0U1g4L1ZtamFMMVRUTXdRNGpSZVFMWW5ySkhu?=
 =?utf-8?B?M092SCtwS3N4RXE2VW1SeTVlMGpIWEdndFlLSVZETXhCazJRUjNHcTNUMGVY?=
 =?utf-8?B?SG1mdXBDYmhKLy9pNGIzZzdYVXlmRFpWWnBDdWRsWGwydDRkaXRQTHQ3Zzgr?=
 =?utf-8?B?Mlk4MmlXYUI5cXkrQUFJVi9aVk1kNTd6aVorMkNYQVBheURYTnJaTG5yWTFM?=
 =?utf-8?B?WEJWVzlwWHZoQ2Z3V0NBVmZRbDJ6MXRjK1IvN3R4Rkh0aG9MU2xSN01sdjF2?=
 =?utf-8?B?SW01S3BVT1JxSnJzb2JlNy9oa3lqUm1aNUlqamFFcEYrYVg5eXRRTFk2ODJM?=
 =?utf-8?B?SHRDSnpqYk9MaUg3RTBRdVpCOUpnSkQ1SnlCMVZPRjByOXdnSURna0RLdUNx?=
 =?utf-8?Q?yX9m1XHFfdudyCSjresTPusMD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7CA6E71BFED5E94CA4C794B4387367A5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wJPbNbHZUz2Z+/oxaYT/Q2ZML48jX6eDPJetH1/O7fehZW61P45978Xqllh0TcwT6WJ2SWmRpbuI0NM/hsrRGohlQvAreS/Qfpl8whlIHXDCln5K2HU5WYKlI3iF/fef/PYrKjRAdZI8hZMab8I8/YakBVCvXxFsR6yKYWjzbqu1OLdKp8jd8QMImG6Adn2az2ilrI0XCQ2dR0cuU9jPoLC9ZMBwyyDo253S8YeLmcMlq+bmIBkYIpO1bP8MMqr7Zk42dYTPnh3XCbafzc/hLmIvrN4lVcueEBDcVYj0FxiPOWT++SUVQrbh6ucY+aYru8uf6OYou+Q55WJJ8Neejgy8cWOJBTM2p206S/D6A+7Mka575P1V8vSsOBKSY0le8tQ2ix5dUwgYmP7sV5nx9veX1XkttVhNuOPsHjTJ1d31NWmMDv46w/iFMMvNL5iWxn5vimu75DSY7tXDJtCS+XOUYGdDYpL7sO3yH/DsWH4+cTDoWerzdXj57CsNvh9Ju94yxgQSdwRSX1pfC2ArlpBQOCYBIWdPoA0aryFxw7wR+PjioSTJn8Yjn6umKec+Tsqdq/XDcoDgnOGDQLVoZLNEUfc4G6Gz0czPSpSFC9xLhjZw1/5XaxIzy0psI3X1r6ysRV6wFnfb95A9K5OMpmyTf81RLys/LRa3uJScLw7wPfEGUtwY9Nolti/d3oBSSnFYmNkHAJWL+ojzO5ZIqSgCCdBhM/LLgf4zNYTZ9m4BxrEv5X6PiQofnF4BwviyGLi9iDw+XMwzAssUR00GxO7w8+pQ8UQdBmdjnP6KrmCB9o3MN/lidSEmzQJk1CnKNpRREJDX0C8spjRWv0dpvQivvzklkgEsmO+CqbhkAWDWtLnlN7jJYMgFWwvYdUBwGab4tCwKSBg71mQKfpPrOA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81565b6b-e4b9-4002-a40e-08db19396079
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 03:10:42.4847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iGvbvjRJEMMjI1JdCgFvM8v0uQQM4AmadPDGAR1OOKzzvx2SEytnhSNGhVn7sliGcXM+af/35jZQGozBOI4jRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8456
X-Proofpoint-GUID: r8QuazBeEeSIeKAElggVjSebz1XqREiA
X-Proofpoint-ORIG-GUID: r8QuazBeEeSIeKAElggVjSebz1XqREiA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-27_19,2023-02-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=835 adultscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 phishscore=0 spamscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302280019
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBGZWIgMjgsIDIwMjMsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gT24gTW9uLCBGZWIg
MjcsIDIwMjMsIFdlc2xleSBDaGVuZyB3cm90ZToNCj4gPiBQcmV2aW91c2x5LCB0aGVyZSB3YXMg
YSAxMDB1UyBkZWxheSBpbnNlcnRlZCBhZnRlciBpc3N1aW5nIGFuIGVuZCB0cmFuc2Zlcg0KPiA+
IGNvbW1hbmQgZm9yIHNwZWNpZmljIGNvbnRyb2xsZXIgcmV2aXNpb25zLiAgVGhpcyB3YXMgZHVl
IHRvIHRoZSBmYWN0IHRoYXQNCj4gPiB0aGVyZSB3YXMgYSBHVUNUTDIgYml0IGZpZWxkIHdoaWNo
IGVuYWJsZWQgc3luY2hyb25vdXMgY29tcGxldGlvbiBvZiB0aGUNCj4gPiBlbmQgdHJhbnNmZXIg
Y29tbWFuZCBvbmNlIHRoZSBDTURBQ1QgYml0IHdhcyBjbGVhcmVkIGluIHRoZSBERVBDTUQNCj4g
PiByZWdpc3Rlci4gIFNpbmNlIHRoaXMgYml0IGRvZXMgbm90IGV4aXN0IGZvciBhbGwgY29udHJv
bGxlciByZXZpc2lvbnMsIGFkZA0KPiA+IHRoZSBkZWxheSBiYWNrIGluLg0KPiA+IA0KPiA+IEFu
IGlzc3VlIHdhcyBzZWVuIHdoZXJlIHRoZSBVU0IgcmVxdWVzdCBidWZmZXIgd2FzIHVubWFwcGVk
IHdoaWxlIHRoZSBEV0MzDQo+ID4gY29udHJvbGxlciB3YXMgc3RpbGwgYWNjZXNzaW5nIHRoZSBU
UkIuICBIb3dldmVyLCBpdCB3YXMgY29uZmlybWVkIHRoYXQgdGhlDQo+ID4gZW5kIHRyYW5zZmVy
IGNvbW1hbmQgd2FzIHN1Y2Nlc3NmdWxseSBzdWJtaXR0ZWQuIChubyBlbmQgdHJhbnNmZXIgdGlt
ZW91dCkNCj4gDQo+IEN1cnJlbnRseSB3ZSBvbmx5IGNoZWNrIGZvciBjb21tYW5kIGFjdGl2ZSwg
bm90IGNvbXBsZXRpb24gb24gdGVhcmRvd24uDQo+IA0KPiA+IEluIHNpdHVhdGlvbnMsIHN1Y2gg
YXMgZHdjM19nYWRnZXRfc29mdF9kaXNjb25uZWN0KCkgYW5kDQo+ID4gX19kd2MzX2dhZGdldF9l
cF9kaXNhYmxlKCksIHRoZSBkd2MzX3JlbW92ZV9yZXF1ZXN0KCkgaXMgdXRpbGl6ZWQsIHdoaWNo
DQo+ID4gd2lsbCBpc3N1ZSB0aGUgZW5kIHRyYW5zZmVyIGNvbW1hbmQsIGFuZCBmb2xsb3cgdXAg
d2l0aA0KPiA+IGR3YzNfZ2FkZ2V0X2dpdmViYWNrKCkuICBBdCBsZWFzdCBmb3IgdGhlIFVTQiBl
cCBkaXNhYmxlIHBhdGgsIGl0IGlzDQo+ID4gcmVxdWlyZWQgZm9yIGFueSBwZW5kaW5nIGFuZCBz
dGFydGVkIHJlcXVlc3RzIHRvIGJlIGNvbXBsZXRlZCBhbmQgcmV0dXJuZWQNCj4gPiB0byB0aGUg
ZnVuY3Rpb24gZHJpdmVyIGluIHRoZSBzYW1lIGNvbnRleHQgb2YgdGhlIGRpc2FibGUgY2FsbC4g
IFdpdGhvdXQNCj4gPiB0aGUgR1VDVEwyIGJpdCwgaXQgaXMgbm90IGVuc3VyZWQgdGhhdCB0aGUg
ZW5kIHRyYW5zZmVyIGlzIGNvbXBsZXRlZCBiZWZvcmUNCj4gPiB0aGUgYnVmZmVycyBhcmUgdW5t
YXBwZWQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogV2VzbGV5IENoZW5nIDxxdWljX3djaGVu
Z0BxdWljaW5jLmNvbT4NCj4gDQo+IFRoaXMgaXMgZXhwZWN0ZWQuIFdlJ3JlIHN1cHBvc2VkIHRv
IG1ha2Ugc3VyZSB0aGUgRW5kIFRyYW5zZmVyIGNvbW1hbmQNCj4gY29tcGxldGUgYmVmb3JlIGFj
Y2Vzc2luZyB0aGUgcmVxdWVzdC4gVXN1YWxseSBvbiBkZXZpY2UvZW5kcG9pbnQNCj4gdGVhcmRv
d24sIHRoZSBnYWRnZXQgZHJpdmVycyBkb24ndCBhY2Nlc3MgdGhlIHN0YWxlL2luY29tcGxldGUg
cmVxdWVzdHMNCj4gd2l0aCAtRVNIVVRET1dOIHN0YXR1cy4gVGhlcmUgd2lsbCBiZSBwcm9ibGVt
cyBpZiB3ZSBkbywgYW5kIHdlIGhhdmVuJ3QNCj4gZml4ZWQgdGhhdC4NCj4gDQo+IEFkZGluZyAx
MDB1UyBtYXkgbm90IGFwcGx5IGZvciBldmVyeSBkZXZpY2UsIGFuZCB3ZSBkb24ndCBuZWVkIHRv
IGRvDQo+IHRoYXQgZm9yIGV2ZXJ5IEVuZCBUcmFuc2ZlciBjb21tYW5kLiBDYW4geW91IHRyeSB0
aGlzIHVudGVzdGVkIGRpZmYNCj4gaW5zdGVhZDoNCj4gDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gaW5k
ZXggMzA0MDhiYWZlNjRlLi41YWU1ZmY0Yzg4NTggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNi
L2R3YzMvZ2FkZ2V0LmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBAQCAt
MTk2Miw2ICsxOTYyLDM0IEBAIHN0YXRpYyBpbnQgX19kd2MzX2dhZGdldF9nZXRfZnJhbWUoc3Ry
dWN0IGR3YzMgKmR3YykNCj4gIAlyZXR1cm4gRFdDM19EU1RTX1NPRkZOKHJlZyk7DQo+ICB9DQo+
ICANCj4gK3N0YXRpYyBpbnQgZHdjM19wb2xsX2VwX2NvbXBsZXRpb24oc3RydWN0IGR3YzNfZXAg
KmRlcCkNCj4gK3sNCj4gKwlpZiAoIWxpc3RfZW1wdHkoJmRlcC0+c3RhcnRlZF9saXN0KSkgew0K
PiArCQlzdHJ1Y3QgZHdjM19yZXF1ZXN0ICpyZXE7DQo+ICsJCWludCB0aW1lb3V0ID0gNTAwOw0K
PiArDQo+ICsJCXJlcSA9IG5leHRfcmVxdWVzdCgmZGVwLT5zdGFydGVkX2xpc3QpOw0KPiArCQl3
aGlsZSgtLXRpbWVvdXQpIHsNCj4gKwkJCS8qDQo+ICsJCQkgKiBOb3RlOiBkb24ndCBjaGVjayB0
aGUgbGFzdCBlbnF1ZXVlZCBUUkIgaW4gY2FzZQ0KPiArCQkJICogb2Ygc2hvcnQgdHJhbnNmZXIu
IENoZWNrIGZpcnN0IFRSQiBvZiBhIHN0YXJ0ZWQNCj4gKwkJCSAqIHJlcXVlc3QgaW5zdGVhZC4N
Cj4gKwkJCSAqLw0KPiArCQkJaWYgKCEocmVxLT50cmItPmN0cmwgJiBEV0MzX1RSQl9DVFJMX0hX
TykpDQo+ICsJCQkJYnJlYWs7DQo+ICsNCj4gKwkJCXVkZWxheSgyKTsNCj4gKwkJfQ0KPiArCQlp
ZiAoIXRpbWVvdXQpIHsNCj4gKwkJCWRldl93YXJuKGRlcC0+ZHdjLT5kZXYsDQo+ICsJCQkJICIl
cyBpcyBzdGlsbCBpbi1wcm9ncmVzc1xuIiwgZGVwLT5uYW1lKTsNCj4gKwkJCXJldHVybiAtRVRJ
TUVET1VUOw0KPiArCQl9DQo+ICsJfQ0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4g
IC8qKg0KPiAgICogX19kd2MzX3N0b3BfYWN0aXZlX3RyYW5zZmVyIC0gc3RvcCB0aGUgY3VycmVu
dCBhY3RpdmUgdHJhbnNmZXINCj4gICAqIEBkZXA6IGlzb2MgZW5kcG9pbnQNCj4gQEAgLTIwMDMs
MTAgKzIwMzEsMTIgQEAgc3RhdGljIGludCBfX2R3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXIoc3Ry
dWN0IGR3YzNfZXAgKmRlcCwgYm9vbCBmb3JjZSwgYm9vbCBpbnQNCj4gIAlXQVJOX09OX09OQ0Uo
cmV0KTsNCj4gIAlkZXAtPnJlc291cmNlX2luZGV4ID0gMDsNCj4gIA0KPiAtCWlmICghaW50ZXJy
dXB0KQ0KPiArCWlmICghaW50ZXJydXB0KSB7DQo+ICsJCXJldCA9IGR3YzNfcG9sbF9lcF9jb21w
bGV0aW9uKGRlcCk7DQoNCkFjdHVhbGx5LCB0aGUgVFJCIHN0YXR1cyBtYXkgbm90IGdldCB1cGRh
dGVkLCBzbyB0aGlzIG1heSBub3Qgd29yaywNCmluc3RlYWQgb2YgcG9sbGluZywgbWF5IG5lZWQg
dG8gYWRkIHRoZSBkZWxheSBoZXJlIGluc3RlYWQuDQoNCj4gIAkJZGVwLT5mbGFncyAmPSB+RFdD
M19FUF9UUkFOU0ZFUl9TVEFSVEVEOw0KPiAtCWVsc2UgaWYgKCFyZXQpDQo+ICsJfSBlbHNlIGlm
ICghcmV0KSB7DQo+ICAJCWRlcC0+ZmxhZ3MgfD0gRFdDM19FUF9FTkRfVFJBTlNGRVJfUEVORElO
RzsNCj4gKwl9DQo+ICANCj4gIAlkZXAtPmZsYWdzICY9IH5EV0MzX0VQX0RFTEFZX1NUT1A7DQo+
ICAJcmV0dXJuIHJldDsNCj4gDQo+IA0KDQpUaGFua3MsDQpUaGluaA0K
