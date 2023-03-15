Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0EA6BC09D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjCOXB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjCOXBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:01:24 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F35511661;
        Wed, 15 Mar 2023 16:01:22 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FMaE7e005363;
        Wed, 15 Mar 2023 16:01:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=KhQulp0bA1mu5e6339RImrOj2rRGEJJ5wdv6XsA4nXY=;
 b=oQZ+eGu75Pu4cRX99J0f9epEaU+IodzyK94PWf42uiCBUR+6nSb9GFZwJDOecD6xtN5v
 1gscdzyoVbUh1l8Tuf5EsRx/oZ7pv7nXcj+yTNY5XyQPkV5z5AlBhTkF6lWJotzrRSmF
 TS4id44as1bPsdX0gDUWk65WgBRmOYTgrtQGPw2CZfEnPkgj3sF+8Q6Ylv1QnbdWY54s
 i36jkeERRbeuxXRztDe8WEtYyiOSDXpK+ZH4xIMzjaECbyJIock62s6DHQplZVgzqIj6
 7nk2+C+3YUbttNLkn0XKif1lT4NLd7mpsfz244xf01p7lURknl9fECNteJpA6NAB3/DC Kw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3pbpxt02cu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 16:01:14 -0700
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 017134008A;
        Wed, 15 Mar 2023 23:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1678921274; bh=KhQulp0bA1mu5e6339RImrOj2rRGEJJ5wdv6XsA4nXY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ldgpSs4rUt03NyPWnxirUJKuXPqt0Nk+6T3UQPOfK+8A0FDpKr4/WNv/iWJz5Q5Kx
         zlaIs1dops18oxrW2lwRD+az0qYdXStloRG0oU4GaPNalcFJp1l/Z1U9q471t/XwFO
         Z3JMPvbmw4p8j0B6k+Uandqw2UdOo958uDstQNhUxzBatM0T+T4HaKngugU4DKoxY5
         PsNbhmVOuN8gc1M/NvTR8YiIykHwQqj0T4PFNSI2rJyoZDipIFd+dYbs+ZNgyB/iHi
         MA7MVxIdwjrH3pTsiE/IZCISP2PTgsmZFmEB6uuQitxP4jXwA5pQhN+QmttngK7Th9
         ejxLhVHfv7vGg==
Received: from o365relay-in.synopsys.com (unknown [10.202.1.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 6585EA005C;
        Wed, 15 Mar 2023 23:01:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 95EBBA0094;
        Wed, 15 Mar 2023 23:01:11 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="MnjcKK6D";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRCAYU8tvxZa4fZeSa2AcB65yF/arz+A6kvho3qF870P7/3E95Mxq9u6SXZ0SoD6wVQOm7RJFNuEh92zg72jTe7bU7HH9vgIizb+0m3heWS0BgiWySdIKXJqzSF9CCRsB/+ZTKhkrFGXiHbgn8dbLSbCLOQBiWyxM/VHt4Dg9pEjgFGZ5NpZt+OryIJQmGDpBubPMg9Kp6c3RVQtRA5nCz25b9hdV4LwzQuWXsAI51aKaznpmxknmFVjqktxv35aSENgKpOSS0RJuJO1C3A7KVS8gp6Z2HGOEW6n1vJKr5qe4EGhu6UjEkb/YNETqbQEhfGI86VcyxFT02k3u1mcPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhQulp0bA1mu5e6339RImrOj2rRGEJJ5wdv6XsA4nXY=;
 b=GNIE51aWPoBf1lmJ8tBDIagr+Bcp+z4awcelh7lmhPKaH06IFxX0FNPtYdQb+7Z6Ke1xxT44MUfPj3U8cPoXNkaD/kxDYi/fx4a7G444tx6UByccoDtbj9M3CM55K/ONDtWNxuu3P6DetMqeO2+tYTjNAsRCj4CESpz/1baI/4QlwyEp+z12cySNVhLurGe2OHUtEgkyvuksLCHkGVHkVG64cBKvb1wD0XZOzqY4u/8S70G/yYp0NJzqNl46d3AXWTMxkXB0OpCzG72HQQTgDn+hRaglQtBltvleAKYhM6wGf0yAKOIRNEJvZHlNLL3Y14YsoPwthRGc9vJj82G+nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhQulp0bA1mu5e6339RImrOj2rRGEJJ5wdv6XsA4nXY=;
 b=MnjcKK6DPwHMXTW4NTiwkwkPNwhQ081w6U99T1NsI0d0TPgGroa+Yg1Og9B5F3tf7pjqizaTQE4+ew+l4j6KP8R7mNxQsuk0t9S2xWw0YnD60d6vNutvfCsC3onBP0xJBYh3ASDlDTqVfniYJ7fFI2/bic6vOJYXUfki4jo+eFA=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CH0PR12MB5043.namprd12.prod.outlook.com (2603:10b6:610:e2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Wed, 15 Mar
 2023 23:01:08 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6178.026; Wed, 15 Mar 2023
 23:01:08 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Serrao <quic_eserrao@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v10 5/5] usb: gadget: f_ecm: Add suspend/resume and remote
 wakeup support
Thread-Topic: [PATCH v10 5/5] usb: gadget: f_ecm: Add suspend/resume and
 remote wakeup support
Thread-Index: AQHZV3RzS33N7pq22UWSeyeBDY77Mq78Pw+AgAAYoQCAABfbgIAABY+A
Date:   Wed, 15 Mar 2023 23:01:07 +0000
Message-ID: <20230315230059.ldb75jcxkuhguamo@synopsys.com>
References: <1678908551-27666-1-git-send-email-quic_eserrao@quicinc.com>
 <1678908551-27666-6-git-send-email-quic_eserrao@quicinc.com>
 <20230315194733.yjp5ddymehxm6abl@synopsys.com>
 <20230315211542.z6oc2zfgpnrixgi5@synopsys.com>
 <510cd700-7d2e-2bb6-7b76-4ce8305618ae@quicinc.com>
In-Reply-To: <510cd700-7d2e-2bb6-7b76-4ce8305618ae@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CH0PR12MB5043:EE_
x-ms-office365-filtering-correlation-id: 3631a12f-d809-42f7-1655-08db25a9298f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZrnPZcBPM96c9St6Gf6UxaAripa4k40zRCLdEEMF/JyVn0BgFfN7TyVNBQmzJuevKNFQMvmKqaz4bW4dgKwdJjxDESQh+aI3bFuSVkb7ZXlDCszBahvReKLf23T073It+ojKiTKySngJJUfdrFzHkDNC8Xp77slEL++lIp/2QVkx1est5PburHZ+qedzLdzeEb5QelzzJW3sFJIoCjyVegJzxS/h7mEo4DQPe+/QXgPCuxOOSyNEQX9yfXA2/WaqITbwfTeXude+OGXt6QGusDZ/Yu5LUwKVIsvgFnX9P3qxHpzfFu23wMEmtInOSuJmoeHgaZ6p9YhQEZgINjxaQMi3xdY9tOlP3KCyLn7dl2CNVJsFEbKKpvRFLgPc+ES6/jX8J2ZWarh/e0Ti2ZeCpr8WKb8+1kD4eN4DThiSSRHVT3ZSiTFw9IDvGMJ/v1YlDRvv8f6KjpMqIlSXGZmHG7IdJxhWk3GXZ+tCwaPuql0gP5msxSmZXd1UrEOUqXhaOkxqHPsEBktY8Ie8TOLjTW3z5oy+JNtJ7WPRiiM6T699oNqXlplmk1tJwkbmJxGRPjg/61cikxedy1UOXvCgxWLiDZK/8sZAGHST2sqDaj4LK7MG9YIN5EmYueeNqIUPCNjA7GLjc2NIDNs8QAcfSL9ucgn6IiG5seNkCbmYg4TLHTsIuYRgz8XJQSEFBCb7UYahEp2CyxMJxvdHPuREqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199018)(5660300002)(2906002)(36756003)(15650500001)(186003)(478600001)(53546011)(54906003)(2616005)(83380400001)(71200400001)(26005)(6512007)(6486002)(1076003)(6506007)(76116006)(66476007)(66946007)(66556008)(66446008)(38070700005)(8936002)(86362001)(64756008)(41300700001)(6916009)(4326008)(8676002)(38100700002)(316002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVZZcjc1YkZ4OTVkNVdLSGl0ZFU1QlloUHZvNXBSQ2JLdldZUmUzTkZKUVJQ?=
 =?utf-8?B?YlJnTFIvN0FwelV0clAyUjNWaW5LTWh0YVpnekRjbDA2V1E2V1Nwb1k1dEll?=
 =?utf-8?B?ZjFBUk5jNGxiT2g2akY0WlZBb2xtd0drVFF2azhFRHdtOG5DYWJpMFFDb3BQ?=
 =?utf-8?B?Q2V6ZVJCQzNmMmpDck1Zdm9PQUNud3JHN3JtbHY2RklWOVN1eEk1ZERGRXpM?=
 =?utf-8?B?N0M3UlNYK3ptbDQ3KzhpWmpQTnU3OVdyWlkzQ0laSFRTd1ByMlV3UFNVU2Uw?=
 =?utf-8?B?aERQckJJODQ4cjN1b09tMUFYZ1JudmVTSUlEbHQ4WUVSMGVSRkl6Y2I0WHBI?=
 =?utf-8?B?WVh5WHhFN3ZBVzRTUHBxNDIzb3NmMjBabHZlQlp4amFrK0hUVjdpSWFwaDJG?=
 =?utf-8?B?UDExcVlxRnNvRE9nLzlJa2JPNDkzVldQOWlhR1QxdkpodnNGZTdZVjdQV085?=
 =?utf-8?B?N0FxMytNWlVrOVh4d3lYd0JDK1BERTVKM0lTd2dRaXMzMkxITHhIVHhXMlB5?=
 =?utf-8?B?azk2UGJkWlZLODNoVldvVkV4RVI2THg3c0w5eHQ0MGE2aDNDUHZKNlkrYkhn?=
 =?utf-8?B?U28yS1JtRGsyb2lSdkVFcWEyRWt0UXlZVHZSaFB1MVZjbFRwWHJhb0hLWGV4?=
 =?utf-8?B?eGNjRDRmY2QxV2pZRzVTSW0xOU1tVXpaWWRFYndxK0ZTRCtDUnZmNTkwcE5J?=
 =?utf-8?B?emdQRWdJZWxRWngrTnJJWkVOa1dMSWJFL2ZhWG1jOEg3djJOU21NTXd6c3hv?=
 =?utf-8?B?Vk5CMlAvcmd3OThaY3Vyb1hpVzZMYlQ5SVNSSjl6UlJENHRRZ2k5cUJrWitM?=
 =?utf-8?B?V3ZidDhJUVFtNTNpU0tZT3pSWExobTgybmFkbmpob1hwM0M1K043ZlFUYU1l?=
 =?utf-8?B?N1lEbUc3ZkRYS0tmYTE5cENuYnFOZFFzU0cyYjR2bmpyd205ZGhUTXFzUjVn?=
 =?utf-8?B?cldwYnlNRXFDUmx1MHRCYjAvUHowaDk4cFc2TjRwaEh5RkVpZ0ZtNmFiVmVT?=
 =?utf-8?B?UmljUmlMRTdpOUprNVZUZDVLcHpaNWwvbzhLckVnZ3VvZms3Nkp4K3ZacmtS?=
 =?utf-8?B?RHNuSFU2ekw0dGgwd2VxMDVHTE9YY2gySE0zZDJicjNzdnZqV2lqRXk3a3ds?=
 =?utf-8?B?NzFkVmsxcWJNck9IcWVhblFsU2ljY2h2aXc0OTVhUkx2enB6cnM0K01pZHNQ?=
 =?utf-8?B?Z1ZZTzZVOVQxVXpKR3F0MS9BWFdrTEQzSUtJZk9PWWt0clp6dlZ4dEFMUlhj?=
 =?utf-8?B?MDRKUXdkN2lNaGhsaTJoUnZMKzF1RkdHVnU5QVBpdXJ4N001R0NUMERsemYz?=
 =?utf-8?B?MGgvbmhPU0FlajBmaFVyeGVJdERWTzZqTnZuL09WSm5sNmFOQVFINU1HUFlZ?=
 =?utf-8?B?VHIwVVRKTkJNUTNaTmx1RURvNnBwYjZrME9SZVBKT1VtaS8xRXFNMEg2R0pn?=
 =?utf-8?B?dGZrVTZRdERlYitwbE5yWURlamxxTHpoY1g2ZGRaQTZXK3VVTmVia1BJdmNw?=
 =?utf-8?B?c1hsSmhnc0ZGN1N1clZlZU9reUtWUEY0S0o1c216Z0RldE1mbEErQW9mMEVh?=
 =?utf-8?B?RndYTXFjd21nVTFuVVNmU3Y1SkFKMjlka3hyNnN2c0s2T2Z4Ni9EQXVmWUY1?=
 =?utf-8?B?RHlJZDlYRFhWbC8yODdoRDJ0QzY3VEhBUDVkNzNBRnhwRGhXekJDcEJZMWNx?=
 =?utf-8?B?aHE5SURhUTJqSWVKT3RYOWtkbVc3cVdZc0FEK05MRWJjN0krWTJUL3hqaGRV?=
 =?utf-8?B?VjF4R1lMY3Uybmw2bWVqTVhoekJtUHlib24zdlpqaDZMS0tPTXhXVjllMmpt?=
 =?utf-8?B?Yzd0T3doMnNneVowOGxEV0NwalZrcmp1V2xocGZwVlJHY1I3YUNyZ0xvL1U5?=
 =?utf-8?B?cXV4MlI0Tmg5TktEZXRnVHVZZndHcVJkaXV0ZmZoa01JaUJtN3VjRzhMWjQr?=
 =?utf-8?B?Sit4VFlVY2ZsZ05MVTdtYzNERFFUSFZSTnFLVExjU3B0SHJlaUJkL3dRVFBP?=
 =?utf-8?B?ZDVjQitmS1hZdWZOQUVYOTkwdk52TWVvdDdBWmR0SSswNVlCNnpmNE1RYXRt?=
 =?utf-8?B?ZGtQWWdjRTlMS3g4VGRsdXgzaDdPWTduMTk2cDRwSGEzdFVvMjcwMm9iZktO?=
 =?utf-8?B?L09tTXVxVXBUbGt3MUdnUTBRWkVlWnJNUkh6TjZCR1l1TWhDbjZyTlAyQmdC?=
 =?utf-8?B?SEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <94EC67DAE70EF642A4499DB9CD0090F2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +ouPhi6ceAjkqCJLVrfytdQ7gKZoE6SQa+rlxfaiKltFPl2ZYGfgRtv8ieYOVslNUXnLTQireFLcrq+GBqLIX5lG7AmCJTYGJudQtJTUve20EnKKaEABb/ii8mNdcwoVpVE95rXyhP6vOHKjL6MaZBLcaK20xC3r74JB1rMxzPVV8lC3O/QZNXqrlrg0Elx6YNh4J4ihIABzE6ctUYMi68Vnt5ySr2yrArFbzk8K84NQrHUUJMddecWlSPUutawxS1JnGKOEpmTm2sTNGJl0epr1bBF/WiO2sr/2Aq5LrltwKe20X4vz7tjF/U0LgCAzQiONv9VqjyeUzSaG85ddeQ8UUuQLUubOcnUqPdqHW0E4Eb3teSbeuBgn98ZHe1mNuiYL6sj8GkGFyUqzoXWwMJS4pOrJG5LhJgn3g8MYsr9gQdi3hf8zT9oTgX7LSw6+5DrIOu3W1QgWWixpwNhdw+Fn0mPs89uDu6tgaf55b+xsed8Xf7FlxUAVuyHoja8sRzAC3JoNZ4660zfogRiWdBbWcLN6c8ysJ1y8jnZqJKQxADU2pfiyI44Oj+fEZBNtJKb8yeQHHSqRFW6EA4lfH10KLyRaQLXk+UtHgw3wQdrp3FhpQsO83Zr5hTS5esG4+/diU08n1jp4CYusbImdmEgY0pTsOdk2IsxB0xGUePw30dvpE/Cvyi9xcZaUkmDv3QASNCuTxGIEOBPmDbzvZ1eZP3u99ywBUp+8/JzZGg9WoJBO9w5m5nwRIfvIwQj8KcEZp+8Nhiqp9SBvqz91du+oTs0qAXWUOB++dKNw3S6764MAFHAuN18LxzllYRNe/foDQEvzeXDIlM1uZahBiOrFkym7VqYnjFmCywiLcHNmUl58d+D/gYCzz4bWT4SSL+0x9qvH07LreQKewKdUTFUvoxU4ID1BemMhNBFY2PM=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3631a12f-d809-42f7-1655-08db25a9298f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2023 23:01:07.9376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hoYdPbrvi0rLLuEg9Rfa5P3AyYWpCrALtpZjUptYf2w8Hfwym13ubj0oaNSM6xfpwkL12g37MlDWAyigB3nPfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5043
X-Proofpoint-GUID: m6sEudy4svwwZE9N5kSmxaORf_RLGtjx
X-Proofpoint-ORIG-GUID: m6sEudy4svwwZE9N5kSmxaORf_RLGtjx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_12,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 spamscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303150002 definitions=main-2303150188
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBNYXIgMTUsIDIwMjMsIEVsc29uIFNlcnJhbyB3cm90ZToNCj4gDQo+IE9uIDMvMTUv
MjAyMyAyOjE1IFBNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gT24gV2VkLCBNYXIgMTUsIDIw
MjMsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiA+IE9uIFdlZCwgTWFyIDE1LCAyMDIzLCBFbHNv
biBSb3kgU2VycmFvIHdyb3RlOg0KPiA+ID4gPiBXaGVuIGhvc3Qgc2VuZHMgYSBzdXNwZW5kIG5v
dGlmaWNhdGlvbiB0byB0aGUgZGV2aWNlLCBoYW5kbGUNCj4gPiA+ID4gdGhlIHN1c3BlbmQgY2Fs
bGJhY2tzIGluIHRoZSBmdW5jdGlvbiBkcml2ZXIuIEVuaGFuY2VkIHN1cGVyDQo+ID4gPiA+IHNw
ZWVkIGRldmljZXMgY2FuIHN1cHBvcnQgZnVuY3Rpb24gc3VzcGVuZCBmZWF0dXJlIHRvIHB1dCB0
aGUNCj4gPiA+ID4gZnVuY3Rpb24gaW4gc3VzcGVuZCBzdGF0ZS4gSGFuZGxlIGZ1bmN0aW9uIHN1
c3BlbmQgY2FsbGJhY2suDQo+ID4gPiA+IA0KPiA+ID4gPiBEZXBlbmRpbmcgb24gdGhlIHJlbW90
ZSB3YWtldXAgY2FwYWJpbGl0eSB0aGUgZGV2aWNlIGNhbiBlaXRoZXINCj4gPiA+ID4gdHJpZ2dl
ciBhIHJlbW90ZSB3YWtldXAgb3Igd2FpdCBmb3IgdGhlIGhvc3QgaW5pdGlhdGVkIHJlc3VtZSB0
bw0KPiA+ID4gPiBzdGFydCBkYXRhIHRyYW5zZmVyIGFnYWluLg0KPiA+ID4gPiANCj4gPiA+ID4g
U2lnbmVkLW9mZi1ieTogRWxzb24gUm95IFNlcnJhbyA8cXVpY19lc2VycmFvQHF1aWNpbmMuY29t
Pg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gICBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9l
Y20uYyAgIHwgNzcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiA+ID4g
ICBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9ldGhlci5jIHwgNjMgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKw0KPiA+ID4gPiAgIGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91
X2V0aGVyLmggfCAgNCArKw0KPiA+ID4gPiAgIDMgZmlsZXMgY2hhbmdlZCwgMTQ0IGluc2VydGlv
bnMoKykNCj4gPiA+ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQv
ZnVuY3Rpb24vZl9lY20uYyBiL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX2VjbS5jDQo+
ID4gPiA+IGluZGV4IGE3YWIzMGUuLmZlYTA3YWIgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZl
cnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX2VjbS5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvdXNi
L2dhZGdldC9mdW5jdGlvbi9mX2VjbS5jDQo+ID4gPiA+IEBAIC02MzMsNiArNjMzLDggQEAgc3Rh
dGljIHZvaWQgZWNtX2Rpc2FibGUoc3RydWN0IHVzYl9mdW5jdGlvbiAqZikNCj4gPiA+ID4gICAJ
dXNiX2VwX2Rpc2FibGUoZWNtLT5ub3RpZnkpOw0KPiA+ID4gPiAgIAllY20tPm5vdGlmeS0+ZGVz
YyA9IE5VTEw7DQo+ID4gPiA+ICsJZi0+ZnVuY19zdXNwZW5kZWQgPSBmYWxzZTsNCj4gPiA+ID4g
KwlmLT5mdW5jX3dha2V1cF9hcm1lZCA9IGZhbHNlOw0KPiA+ID4gPiAgIH0NCj4gPiA+ID4gICAv
Ki0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0qLw0KPiA+ID4gPiBAQCAtODg1LDYgKzg4Nyw3NyBAQCBzdGF0aWMg
c3RydWN0IHVzYl9mdW5jdGlvbl9pbnN0YW5jZSAqZWNtX2FsbG9jX2luc3Qodm9pZCkNCj4gPiA+
ID4gICAJcmV0dXJuICZvcHRzLT5mdW5jX2luc3Q7DQo+ID4gPiA+ICAgfQ0KPiA+ID4gPiArc3Rh
dGljIHZvaWQgZWNtX3N1c3BlbmQoc3RydWN0IHVzYl9mdW5jdGlvbiAqZikNCj4gPiA+ID4gK3sN
Cj4gPiA+ID4gKwlzdHJ1Y3QgZl9lY20gKmVjbSA9IGZ1bmNfdG9fZWNtKGYpOw0KPiA+ID4gPiAr
CXN0cnVjdCB1c2JfY29tcG9zaXRlX2RldiAqY2RldiA9IGVjbS0+cG9ydC5mdW5jLmNvbmZpZy0+
Y2RldjsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCWlmIChmLT5mdW5jX3N1c3BlbmRlZCkgew0KPiA+
ID4gPiArCQlEQkcoY2RldiwgIkZ1bmN0aW9uIGFscmVhZHkgc3VzcGVuZGVkXG4iKTsNCj4gPiA+
ID4gKwkJcmV0dXJuOw0KPiA+ID4gPiArCX0NCj4gPiA+ID4gKw0KPiA+ID4gPiArCURCRyhjZGV2
LCAiRUNNIFN1c3BlbmRcbiIpOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJZ2V0aGVyX3N1c3BlbmQo
JmVjbS0+cG9ydCk7DQo+ID4gPiA+ICt9DQo+ID4gPiA+ICsNCj4gPiA+ID4gK3N0YXRpYyB2b2lk
IGVjbV9yZXN1bWUoc3RydWN0IHVzYl9mdW5jdGlvbiAqZikNCj4gPiA+ID4gK3sNCj4gPiA+ID4g
KwlzdHJ1Y3QgZl9lY20gKmVjbSA9IGZ1bmNfdG9fZWNtKGYpOw0KPiA+ID4gPiArCXN0cnVjdCB1
c2JfY29tcG9zaXRlX2RldiAqY2RldiA9IGVjbS0+cG9ydC5mdW5jLmNvbmZpZy0+Y2RldjsNCj4g
PiA+ID4gKw0KPiA+ID4gPiArCS8qDQo+ID4gPiA+ICsJICogSWYgdGhlIGZ1bmN0aW9uIGlzIGlu
IFVTQjMgRnVuY3Rpb24gU3VzcGVuZCBzdGF0ZSwgcmVzdW1lIGlzDQo+ID4gPiA+ICsJICogY2Fu
Y2VsZWQuIEluIHRoaXMgY2FzZSByZXN1bWUgaXMgZG9uZSBieSBhIEZ1bmN0aW9uIFJlc3VtZSBy
ZXF1ZXN0Lg0KPiA+ID4gPiArCSAqLw0KPiA+ID4gPiArCWlmIChmLT5mdW5jX3N1c3BlbmRlZCkN
Cj4gPiA+ID4gKwkJcmV0dXJuOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJREJHKGNkZXYsICJFQ00g
UmVzdW1lXG4iKTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCWdldGhlcl9yZXN1bWUoJmVjbS0+cG9y
dCk7DQo+ID4gPiA+ICt9DQo+ID4gPiA+ICsNCj4gPiA+ID4gK3N0YXRpYyBpbnQgZWNtX2dldF9z
dGF0dXMoc3RydWN0IHVzYl9mdW5jdGlvbiAqZikNCj4gPiA+ID4gK3sNCj4gPiA+ID4gKwlzdHJ1
Y3QgdXNiX2NvbmZpZ3VyYXRpb24gKmMgPSBmLT5jb25maWc7DQo+ID4gPiA+ICsNCj4gPiA+ID4g
KwkvKiBEMCBhbmQgRDEgYml0IHNldCB0byAwIGlmIGRldmljZSBpcyBub3Qgd2FrZXVwIGNhcGFi
bGUgKi8NCj4gPiA+ID4gKwlpZiAoIShVU0JfQ09ORklHX0FUVF9XQUtFVVAgJiBjLT5ibUF0dHJp
YnV0ZXMpKQ0KPiA+ID4gPiArCQlyZXR1cm4gMDsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCXJldHVy
biAoZi0+ZnVuY193YWtldXBfYXJtZWQgPyBVU0JfSU5UUkZfU1RBVF9GVU5DX1JXIDogMCkgfA0K
PiA+ID4gPiArCQlVU0JfSU5UUkZfU1RBVF9GVU5DX1JXX0NBUDsNCj4gPiA+ID4gK30NCj4gPiA+
ID4gKw0KPiA+ID4gPiArc3RhdGljIGludCBlY21fZnVuY19zdXNwZW5kKHN0cnVjdCB1c2JfZnVu
Y3Rpb24gKmYsIHU4IG9wdGlvbnMpDQo+ID4gPiA+ICt7DQo+ID4gPiA+ICsJc3RydWN0IHVzYl9j
b25maWd1cmF0aW9uICpjID0gZi0+Y29uZmlnOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJREJHKGMt
PmNkZXYsICJmdW5jIHN1c3AgJXUgY21kXG4iLCBvcHRpb25zKTsNCj4gPiA+ID4gKw0KPiA+ID4g
PiArCS8qIFJlc3BvbmQgd2l0aCBuZWdhdGl2ZSBlcnJubyBpZiByZXF1ZXN0IGlzIG5vdCBzdXBw
b3J0ZWQgKi8NCj4gPiA+ID4gKwlpZiAoIShVU0JfQ09ORklHX0FUVF9XQUtFVVAgJiBjLT5ibUF0
dHJpYnV0ZXMpKQ0KPiA+ID4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiA+IA0KPiA+ID4gV2Ug
b25seSBuZWVkIHRvIHJldHVybiBlYXJseSBpZiB0aGUgaG9zdCB0cmllcyB0byBlbmFibGUgcmVt
b3RlIHdha2UNCj4gPiA+IHdoaWxlIHRoZSBkZXZpY2UgaXNuJ3QgY2FwYWJsZSBvZiBpdDoNCj4g
PiA+IA0KPiA+ID4gCXdha2V1cF9zZWwgPSAhIShvcHRpb25zICYgKFVTQl9JTlRSRl9GVU5DX1NV
U1BFTkRfUlcgPj4gOCkpOw0KPiA+ID4gCWlmICh3YWtldXBfc2VsICYmICEoVVNCX0NPTkZJR19B
VFRfV0FLRVVQICYgYy0+Ym1BdHRyaWJ1dGVzKSkNCj4gPiA+IAkJcmV0dXJuIC1FSU5WQUw7DQo+
ID4gPiANCj4gPiA+IAlmLT5mdW5jX3dha2V1cF9hcm1lZCA9IHdha2V1cF9zZWw7DQo+ID4gPiAN
Cj4gPiANCj4gPiBBbHNvLCBJIG5vdGljZSB0aGF0IHdlIGNhbid0IGRpZmZlcmVudGlhdGUgYmV0
d2VlbiBDbGVhckZlYXR1cmUoKSBhbmQNCj4gPiBTZXRGZWF0dXJlKCkgaW4gZi0+ZnVuY19zdXNw
ZW5kKCkuIFBlcmhhcHMgd2Ugc2hvdWxkIGhhbmRsZSBhcm1pbmcgdGhlDQo+ID4gcmVtb3RlIHdh
a2V1cCBpbiB0aGUgY29tcG9zaXRlIGxheWVyIHNvIHdlIGNhbiBzZXQvY2xlYXIgdGhlIHJlbW90
ZQ0KPiA+IHdha2UuIEl0J3MgY29tbW9uIGFjcm9zcyBtdWx0aXBsZSBkZXZpY2VzLiBJdCdzIHBy
b2JhYmx5IGJldHRlciB0byBiZQ0KPiA+IHRoZXJlLg0KPiA+IA0KPiA+IFRoYW5rcywNCj4gPiBU
aGluaA0KPiANCj4gWWVhaCBhZ3JlZSB3aXRoIHRoYXQuIFdlIGNoZWNrIGZvciBmdW5jdGlvbl93
YWtldXBfYXJtZWQgZmxhZyBiZWZvcmUgc2VuZGluZw0KPiByZW1vdGUgd2FrZXVwIGluIGNvbXBv
c2l0ZS5jLiBTbyBpdCBtYWtlcyBtb3JlIHNlbnNlDQo+IHRvIHNldC9yZXNldCB0aGlzIGZsYWcg
aW4gY29tcG9zaXRlLmMgaXRzZWxmLiBJIHdpbGwgbWFrZSB0aGF0IGNoYW5nZQ0KPiBhbmQgdXBs
b2FkIHYxMiBhbG9uZyB3aXRoIGZpeGluZyAndmFsdWUgPSAwJyByZW1vdmFsIHRoYXQgd2UgZGlz
Y3Vzc2VkDQo+IGVhcmxpZXIuIFBsZWFzZSBsZXQgbWUga25vdyBpZiB0aGF0IGlzIGZpbmUNCj4g
DQoNClNpbmNlIHdlIGRvbid0IGdvIHRocm91Z2ggdGhlIGZ1bmNfc3VzcGVuZCgpIGFueW1vcmUs
IGxldCdzIGtlZXAgaXQgYXMNCmlzIGZvciBub3cuIElmIHlvdSdyZSBpbiBjb21wb3NpdGUuYywg
dGhlbiB5b3UgY2FuIHNraXAgZG9pbmcNCmZ1bmNfc3VzcGVuZCgpIGlmIHJlbW90ZV93YWtlIGlz
IG5vdCBzdXBwb3J0ZWQgd2hlbiBob3N0IHJlcXVlc3RlZC4NCg0KVGhhbmtzLA0KVGhpbmg=
