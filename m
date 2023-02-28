Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226196A5230
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 05:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjB1EDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 23:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjB1EDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 23:03:21 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7DD2D4C;
        Mon, 27 Feb 2023 20:03:06 -0800 (PST)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31S0iO3C009960;
        Mon, 27 Feb 2023 20:03:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=fTP3jWW3mCD5d8ClJBJ3VcygW2+n/x5C/0w3vwU6/ug=;
 b=cIQ02/8zIk2/QaCNt+mkpLnO2UYqQQ5I+p3YKufHK+YvJLCN1Y4DX7LxGD99+B7Tmmf8
 l9KmWW6XsgcB4xX+KpJUFxu/A7g19MGkb6OmnU1MyVhynA2nYYj+N0IvJKQlHAQiqSmQ
 BgWMYAT0EBxTpaiH97Y38A4P11S6sRJpmvJMEX0e1qzvFjvhy6giaXhy0HgHhjr+dtZe
 DL50z+AT5JN6cYIGMqRylpM6LIPNjeFwBK2PIAak/gYH+DvHP4Opd9z/ZX3PoIuVNFZl
 dvWTn4VfgBAJlFcvNqTwRYbVZTzdrlRRuACYV/CjWFAFua9c+2KggSag5ZelwuNm6YFO xg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3nyjfd2c07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 20:03:04 -0800
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CB187400E8;
        Tue, 28 Feb 2023 04:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1677556983; bh=fTP3jWW3mCD5d8ClJBJ3VcygW2+n/x5C/0w3vwU6/ug=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=U3IYu3KyuPwYZy8F6VTlxIMjgH+q80vpvcHmHEQaEPLWUnx4gYvRcrSsVnbTecklB
         AtSHb3SUIVKx55h5AG2O2NKIZdJVmSRjiHLyUuIbPdvUNgu4FmGcrtXhFFw+Jqc0Yu
         TbIaTTZzk4AEczVV7AyRrns8Ei1e5OwhSLVZg566U4Vh16cYHDbR4WlnrDVGvffdEO
         UZ6VBxtFlqVyP4YqEykmnK9XnHqW1KVThp0qlKDIC7npLP/WMbkfNqtJA9lulYPyiI
         a0fTnXIEA95XdnBKZ6jFDfbKyGUgmxEHFXKmjidjGCOQJnmxkQchajDB4137CRo6Dp
         Iq+Z03eUKLs/g==
Received: from o365relay-in.synopsys.com (unknown [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 92207A0062;
        Tue, 28 Feb 2023 04:03:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 37D49800FB;
        Tue, 28 Feb 2023 04:03:02 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="O0R7uR8l";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJ984n1/Cvc8clMuunqQeJFxvCyPQO6BGLzElbdv9onnVuKB7pOJsumyRMhsv/jkAlg4GBTLgPO28+B2ZrG6Kx/1Tip0LYtau7Rw7WhzZR04TAT7/QUCCrIT4dsGN6JIsNam/Ga4AWFLFwbut0gRL8u9qjH+JuaxXFUACtyKyZQtdezTJQVgCbDWfKl5GZ4VOQXYQx32oeL9SKXuX0KcQuFPerucXvIlIREu7dbdwSZ1puxz+35PYE4/47jd48I4RKrG05iF8TVhCbhgYuJ5/pStVtwP/uiofzYPu5IiGTwOEz+k5nxW2+5TxZTKM942CVzK5SFPGXI0RrH1pfnrHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTP3jWW3mCD5d8ClJBJ3VcygW2+n/x5C/0w3vwU6/ug=;
 b=Ez06Mmf+tCI3mhc2ylQGq38JLhh9iL0Zr3ZqBUnEERssFMVHZO1MJ3u4OVhdlxkWSQn2qy51shvwu6870YBm2WYI2itT7CeBOT1YXTN9fNDGQDYDWcEYaRQ8Y274YMu/3U1vLpHER97mXV53KGg0ij+Clmzhj7tGu5zzHw+0YtNCzZUw7+trCbG0svrYDr8IQIzPQI6QyoYMC8CEXor+a8dL4i/uNW0tUUJMs1jxdAN2dv+96aEFkSgkKdKAYSNGXVByecr/NxcsQvjBndkwCUFZwIpq3RSMK0mCP9EwVKg0Ju9hq6rdGlVRXsoOe+Fc+uvRZ4S33JL8iMH6TAuKaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTP3jWW3mCD5d8ClJBJ3VcygW2+n/x5C/0w3vwU6/ug=;
 b=O0R7uR8l8hUcWbFP+WSHoLIYZZQUbyN6nCl/yZhdWdjZwIfwGUKSaNSdJ1o9j/DcOkxYk+B5DxoBLc/KZVRHqGic8rqhDzzSpCLb2y1RNzHapGspTUh5+FT0Bzy2w7CIV55EpUMZkOegZQRz28K8lo857ym/R/BC8lRZeP7/z1g=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by PH0PR12MB8128.namprd12.prod.outlook.com (2603:10b6:510:294::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Tue, 28 Feb
 2023 04:02:59 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c%7]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 04:02:59 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH] usb: dwc3: gadget: Add 100uS delay after end transfer
 command without IOC
Thread-Topic: [PATCH] usb: dwc3: gadget: Add 100uS delay after end transfer
 command without IOC
Thread-Index: AQHZSwIl2lqyJq8SIUKTvkcQR1aWb67joCOAgAAOQoCAAAN6AIAACV2A
Date:   Tue, 28 Feb 2023 04:02:58 +0000
Message-ID: <20230228035625.rrda7hpitfrfx34z@synopsys.com>
References: <20230227232035.13759-1-quic_wcheng@quicinc.com>
 <20230228021925.j5bquwnwuvog3hx6@synopsys.com>
 <20230228031027.ghrfnda5lkt7qfmt@synopsys.com>
 <24af4a1b-0cc5-e65b-ac66-f767f891520e@quicinc.com>
In-Reply-To: <24af4a1b-0cc5-e65b-ac66-f767f891520e@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|PH0PR12MB8128:EE_
x-ms-office365-filtering-correlation-id: cf952cc8-4dc8-41ba-bc51-08db1940adf3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /sTm6uslM/xlD8UAB33UuqulOmPdK4g4BnMbPSmhwQ6Af3tinRfPQI3ZBNAyt90N+PtvWWUFe3MynGWfkLGqfR8RfRPJjeyzJwNW8vNsp5WebT1FdDOco+Q20zK+ge8I9IiUMuCPGOi5jgHeO6DLq6bCwo01jSmHY4U0Ds6dtES+N0Y0CfMUN7TF8eC/9khsu2aJX0C+ipQPDtYjww+NhEsrdwaAmaljQpRbJFeL/WTvTDUZs7TfCloaErsn2JNM1TMMgrE4dW1xnnjACWYsc2sCqywa63AnKXBDKV4NviqfXYCh6E9s5YEhMd5zt4vo0PuLbPg3US4t9rFeWcpOwvLXoQq0u4QinmYgLU9pVauq4LUpl5UNRVsy4Yb5/RV/QTm4bg0pvYmtuN8fOpCNvnqi1jL2ZUvakHYibVEE3EL4YwNlT/MYiC8zZ/TQrxW3RH8KB6xs8uxCcEWZhmGMI5LNhNIU0t49eoA25HjHrj4+QqoPfsRrI4kWTpCfx9JFyGg2J4Sjmvjde4M+yzC0ajQDa5v+deamo5YVkQGAlC1eGyTfke8Zgw6z/624QOF1sjN+Hl7lSyLck0K9KSmxHeO+cwi8RgJ6sT2+FyNhR6P6PBUD1s/i2/Bvu/v03TMIhRnossMnzsA/Z/5ilLK30ZYn/ImRQid3GRdjkLqtdV657U0kaBmqZcWt6oXcI6coo4rdyzpylfslWSt4wqLSIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199018)(38070700005)(66946007)(6506007)(2616005)(6486002)(66476007)(66556008)(316002)(86362001)(8676002)(76116006)(478600001)(54906003)(71200400001)(36756003)(66446008)(41300700001)(6916009)(1076003)(6512007)(186003)(64756008)(4326008)(53546011)(2906002)(26005)(38100700002)(8936002)(122000001)(83380400001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1phc0U5L2RZSjZJOXFQSWo5M1VYMDFGMVp6RndtOXlSVVNQMDZWVWViOGpz?=
 =?utf-8?B?NFFsMUlmM3pVRGtwTHpHZU9Vam0rMTNwR2NEamFwS216MlhhWnN2SVcvTFJo?=
 =?utf-8?B?MVlobUdjNzZGUXFSQUFBWi9VeXhvdHZDS1dxUEhTbGUvdDZ0U2puT2hNdXV3?=
 =?utf-8?B?emxHWGhBTTNMcU5nUUF6YVlmSk1tTkU0aFlETm5tRDRHeEEzN25iV2J2S2I5?=
 =?utf-8?B?UkFic3RQMTlYZkpIUERLK2MyajRUQjJBMDdUc0xORlRhTHo2bTlRM05xMTVr?=
 =?utf-8?B?TGFQM2hCUHBXOVAybzhkQmc0WmE2SDJuVm5zM1RPUTljZGpQN29tQTJNMGVl?=
 =?utf-8?B?TWxZN2ZPUEtWL09kVnlabVpFYkNBZXQyRElwZHJlbmQvcTh5RCtYZitwT3ho?=
 =?utf-8?B?bmNZU1VERS96ZC81VkhPZFRhbTJReC9Pcm5SZWVsTVNCMThRdjlkUlJFR1Bh?=
 =?utf-8?B?RkVpRGpOcjgvd1owL3luN1dseEVNUU14V3FkUGx2RGpOR3phSHMxU0tsc2Er?=
 =?utf-8?B?MVhzZ2dabk91c1FXbnE0cWNMK2ZDSm9aY0dvREg5a1dNQnZvSnZka1o2Qkxp?=
 =?utf-8?B?OVBRNThUSlh4YjNoOHJMUWRsTWVnSXErTGx6WGI1bDFIalNLZVhGcTlWTTRB?=
 =?utf-8?B?YmlVN2tPek9YMFE3UVgrVmZONnpTaFRwVmxuMjU0Vys1aXZ1Z1hDUWQ5T0Jk?=
 =?utf-8?B?Sy90NWJaTlNETXVmZUhDUkVEUFVCbHZSVjByaXFPRzlmWFl4RFgza2ZzemVq?=
 =?utf-8?B?cmxJdis1VjZEMWdaZXRMZFhhbktDdXVnd01hNGhudlJQT3pCMFZQNURjMXIz?=
 =?utf-8?B?clczYU9BR2ttSDh1SWRCMXR3Ymg4Ty9mZE9IL3JNMGpLbDBaVXdnZytCZ0xZ?=
 =?utf-8?B?SW9JME94d0dhbkJERE9zRnNJY2NBVWtMbGFMV2dFdTBWKzJTM2tpQnpQVS9q?=
 =?utf-8?B?Q0k4TnU1U0NZL1VIcEg3c3NDNXVRR3Q0bFlsdjJNS0xkRDNOYnQrU1U2amZ3?=
 =?utf-8?B?QTFXWTdwdjRXNGtBaGpjNUV1OGUycjlwdjBuZ3lETC95cjVhL0NHZ3VZQUFS?=
 =?utf-8?B?Q2EzLzQ4dFdmU2NmcHVtVkhlTklkbmo3ZEJ5UDJIemoyc1ZtbkppNGdib0ph?=
 =?utf-8?B?Z3dSY3h0NXhwOUVoYmpVam42eWlsY0RNamRQVFlxaTRqbFh4YWNVK1Q4c2dR?=
 =?utf-8?B?VmIxS2l2NDdldUNNTlU1MW0zNHNjbHdoNmZjbWtRdzNyaEdBWkU2djZqVGRG?=
 =?utf-8?B?dVkrSTRXT2dJT1pDUGVya2ZTTUl0Rno3Zmhhd1YvSE8wYTJxY1pWY1NJWGhl?=
 =?utf-8?B?MXhYNnBDSTcvQWViWk12Z2Y2SnViYkxkYWhReHlEOE51NExRODFnVFNaOC9K?=
 =?utf-8?B?a2pyWW4ycURvMGFmdnJMdUJ1L2J3bjkwZTlpaFRObmI5RGp4T0hVVkZ0STg1?=
 =?utf-8?B?RkVJQTM4UGtXRWlKanpSdmp4Sms0S0luVENUNWYweTNwaTlQYzBZdjhKUUtO?=
 =?utf-8?B?TkJ0L0E5V3NDR1dmTFpyc3QwdnFVYjQyMVFqdlM2eXdmbi83M0RQeVV3OS9O?=
 =?utf-8?B?WjlYZHNJZ0hwZ0JXZUE5NzdXSW1ybkU3cXI0U2t3V1JiSW1TVXFtOHpMU0pE?=
 =?utf-8?B?N2lRbzBtSGF3MjhNck1HV0JzT0tnVDJGOVpKaG1Ed0NTMzFsa2dUNW5tQ2lQ?=
 =?utf-8?B?SGFNa014L3V5TW0rM3F0VjNSWEc0dSt2NGgyb2tGZjRYMFBrN01LeHFQekox?=
 =?utf-8?B?RHBkS0V6UHF0bDArd2NlSkJLUWdaSWNJMjQ3dXFNMWxjMk1ydzh4NzJjZ3Mz?=
 =?utf-8?B?Rks3cWphN1ZWMndDZ1FVeDBvdi9Ja0ZUeVhJOWZzM3Y5eHFLbnpFNFkyTnBQ?=
 =?utf-8?B?SDBGVlFvRDJYM2lvcmNLMHdLd2NScTdYdnE4cXNPTVB0bHpFaGNnNUZqc0F6?=
 =?utf-8?B?RzNlQkdCWld6bDlXQnhoLy9WNXMxNUZ5ZWsxbUdEU0xzTXRvdGxTSS84WmdK?=
 =?utf-8?B?V0dFRTB0V0JjdzBWeXhhc3hXY211eTgzWG83aTgxL0RLSVdoNDZjdllVMnRy?=
 =?utf-8?B?c0dOVmxzQWZYblY1c0RaK1hrd2xXbWR5bWhaM1M1R3I4VUFzWTVvVnN1ZG1J?=
 =?utf-8?Q?JIvvMjtvE9hX+OZO1vHFdr5sW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5638073CAE482942AD19B54D31979726@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jJQOyly2KEU+H2snz7+LsAm6tDGO5y+39ouMadX5wbIwcx2sts8qM7F75Ywh79g7/uh12YTQE00MBY3Q6rxK8nSkPM1Ht6a91xt5rV3VXh5cWK/vIi/K9GLdUIVQK7U8FrpjrDyYRb2hFuYva/ZnQWED7S91BHB/tzuTTWXQUgqfSLUvnXT3wQfOXEZM5aOhsxTeadzHoY5xSUK/9zjK44kedtR5+H1PeJ8ke7ga7FlgUC18xxIdbdkcZw8yCfGnoLwGfwH/3xG5yS1KJJsyVAmcpBM59Rx1Icmb+ShdH3jrQzcybxXvZIhLdxPMLdlgQV2vOXXTidChqg6KQ02tuCReOyXhMNanKQrE9UCwqMDszIFLestyFJRMyk5Ju4V8hV15iR4RyFcGiJr0/pt0jdUAYoxMmjT/VMWjNzSCTN5mXjzTTpp5PtNPkb6XRbvaLaK5j1C4wBXUTEQcBpQ6Bl/NnzYat6nvAvn/KXny1g2dUFYOPQd63bwUGemIWqXZnzNGgPuE711DDC7PeZ9WvcZkbJKuNpRBXbssBLqzXtFDQdKu4xfLoI0IcUU0qovawpXp+sGgNLYlzeHcfCpasOWk7EIHPlj6l2BD78xyGj4jVKIRIdTLwJfQ4R3HY6fk950fQtVnSGexoy227CKABxDeCjjH+HAggkas6LaK1mh3uvAKuKZg2KF0RPBQtZKa+XN/8oj8AZ4ZEuUDxEusoFx+8rBjhABLCjDI+H/iafIm/C6zU+O9kR90V4pd/hUVz+6em+3WWzd/BUUDFlPvsq76dLazKxjdyPY/48qZ03+Xd7RNCmnyuor7a/Sm1istXq5rYK93sPxq0CT+QB5PiPAi0Eab76Dl3x6bPG07Kp/cWAcj526h60ktEfC3kNphDUel+4bggTNfYPkW4enqLw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf952cc8-4dc8-41ba-bc51-08db1940adf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 04:02:58.9621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a2Ao63+wnhxRfmnCN6sSFOSO+qQ8jb8kluTWCevv2sBvovC6tNDxbNPtXKJ5iYRvYMWtnSLGglM9iApsYhn/Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8128
X-Proofpoint-GUID: -wnWyXpt3BkHQFG8tzCl2jwcv0wSlazD
X-Proofpoint-ORIG-GUID: -wnWyXpt3BkHQFG8tzCl2jwcv0wSlazD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-27_19,2023-02-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 clxscore=1015 malwarescore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302280028
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBGZWIgMjcsIDIwMjMsIFdlc2xleSBDaGVuZyB3cm90ZToNCj4gSGkgVGhpbmgsDQo+
IA0KPiBPbiAyLzI3LzIwMjMgNzoxMCBQTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9uIFR1
ZSwgRmViIDI4LCAyMDIzLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gPiBPbiBNb24sIEZlYiAy
NywgMjAyMywgV2VzbGV5IENoZW5nIHdyb3RlOg0KPiA+ID4gPiBQcmV2aW91c2x5LCB0aGVyZSB3
YXMgYSAxMDB1UyBkZWxheSBpbnNlcnRlZCBhZnRlciBpc3N1aW5nIGFuIGVuZCB0cmFuc2Zlcg0K
PiA+ID4gPiBjb21tYW5kIGZvciBzcGVjaWZpYyBjb250cm9sbGVyIHJldmlzaW9ucy4gIFRoaXMg
d2FzIGR1ZSB0byB0aGUgZmFjdCB0aGF0DQo+ID4gPiA+IHRoZXJlIHdhcyBhIEdVQ1RMMiBiaXQg
ZmllbGQgd2hpY2ggZW5hYmxlZCBzeW5jaHJvbm91cyBjb21wbGV0aW9uIG9mIHRoZQ0KPiA+ID4g
PiBlbmQgdHJhbnNmZXIgY29tbWFuZCBvbmNlIHRoZSBDTURBQ1QgYml0IHdhcyBjbGVhcmVkIGlu
IHRoZSBERVBDTUQNCj4gPiA+ID4gcmVnaXN0ZXIuICBTaW5jZSB0aGlzIGJpdCBkb2VzIG5vdCBl
eGlzdCBmb3IgYWxsIGNvbnRyb2xsZXIgcmV2aXNpb25zLCBhZGQNCj4gPiA+ID4gdGhlIGRlbGF5
IGJhY2sgaW4uDQo+ID4gPiA+IA0KPiA+ID4gPiBBbiBpc3N1ZSB3YXMgc2VlbiB3aGVyZSB0aGUg
VVNCIHJlcXVlc3QgYnVmZmVyIHdhcyB1bm1hcHBlZCB3aGlsZSB0aGUgRFdDMw0KPiA+ID4gPiBj
b250cm9sbGVyIHdhcyBzdGlsbCBhY2Nlc3NpbmcgdGhlIFRSQi4gIEhvd2V2ZXIsIGl0IHdhcyBj
b25maXJtZWQgdGhhdCB0aGUNCj4gPiA+ID4gZW5kIHRyYW5zZmVyIGNvbW1hbmQgd2FzIHN1Y2Nl
c3NmdWxseSBzdWJtaXR0ZWQuIChubyBlbmQgdHJhbnNmZXIgdGltZW91dCkNCj4gPiA+IA0KPiA+
ID4gQ3VycmVudGx5IHdlIG9ubHkgY2hlY2sgZm9yIGNvbW1hbmQgYWN0aXZlLCBub3QgY29tcGxl
dGlvbiBvbiB0ZWFyZG93bi4NCj4gPiA+IA0KPiA+ID4gPiBJbiBzaXR1YXRpb25zLCBzdWNoIGFz
IGR3YzNfZ2FkZ2V0X3NvZnRfZGlzY29ubmVjdCgpIGFuZA0KPiA+ID4gPiBfX2R3YzNfZ2FkZ2V0
X2VwX2Rpc2FibGUoKSwgdGhlIGR3YzNfcmVtb3ZlX3JlcXVlc3QoKSBpcyB1dGlsaXplZCwgd2hp
Y2gNCj4gPiA+ID4gd2lsbCBpc3N1ZSB0aGUgZW5kIHRyYW5zZmVyIGNvbW1hbmQsIGFuZCBmb2xs
b3cgdXAgd2l0aA0KPiA+ID4gPiBkd2MzX2dhZGdldF9naXZlYmFjaygpLiAgQXQgbGVhc3QgZm9y
IHRoZSBVU0IgZXAgZGlzYWJsZSBwYXRoLCBpdCBpcw0KPiA+ID4gPiByZXF1aXJlZCBmb3IgYW55
IHBlbmRpbmcgYW5kIHN0YXJ0ZWQgcmVxdWVzdHMgdG8gYmUgY29tcGxldGVkIGFuZCByZXR1cm5l
ZA0KPiA+ID4gPiB0byB0aGUgZnVuY3Rpb24gZHJpdmVyIGluIHRoZSBzYW1lIGNvbnRleHQgb2Yg
dGhlIGRpc2FibGUgY2FsbC4gIFdpdGhvdXQNCj4gPiA+ID4gdGhlIEdVQ1RMMiBiaXQsIGl0IGlz
IG5vdCBlbnN1cmVkIHRoYXQgdGhlIGVuZCB0cmFuc2ZlciBpcyBjb21wbGV0ZWQgYmVmb3JlDQo+
ID4gPiA+IHRoZSBidWZmZXJzIGFyZSB1bm1hcHBlZC4NCj4gPiA+ID4gDQo+ID4gPiA+IFNpZ25l
ZC1vZmYtYnk6IFdlc2xleSBDaGVuZyA8cXVpY193Y2hlbmdAcXVpY2luYy5jb20+DQo+ID4gPiAN
Cj4gPiA+IFRoaXMgaXMgZXhwZWN0ZWQuIFdlJ3JlIHN1cHBvc2VkIHRvIG1ha2Ugc3VyZSB0aGUg
RW5kIFRyYW5zZmVyIGNvbW1hbmQNCj4gPiA+IGNvbXBsZXRlIGJlZm9yZSBhY2Nlc3NpbmcgdGhl
IHJlcXVlc3QuIFVzdWFsbHkgb24gZGV2aWNlL2VuZHBvaW50DQo+ID4gPiB0ZWFyZG93biwgdGhl
IGdhZGdldCBkcml2ZXJzIGRvbid0IGFjY2VzcyB0aGUgc3RhbGUvaW5jb21wbGV0ZSByZXF1ZXN0
cw0KPiA+ID4gd2l0aCAtRVNIVVRET1dOIHN0YXR1cy4gVGhlcmUgd2lsbCBiZSBwcm9ibGVtcyBp
ZiB3ZSBkbywgYW5kIHdlIGhhdmVuJ3QNCj4gPiA+IGZpeGVkIHRoYXQuDQo+ID4gPiANCj4gPiA+
IEFkZGluZyAxMDB1UyBtYXkgbm90IGFwcGx5IGZvciBldmVyeSBkZXZpY2UsIGFuZCB3ZSBkb24n
dCBuZWVkIHRvIGRvDQo+ID4gPiB0aGF0IGZvciBldmVyeSBFbmQgVHJhbnNmZXIgY29tbWFuZC4g
Q2FuIHlvdSB0cnkgdGhpcyB1bnRlc3RlZCBkaWZmDQo+ID4gPiBpbnN0ZWFkOg0KPiA+ID4gDQo+
IA0KPiBUaGFua3MgZm9yIHRoZSBjb2RlIHN1Z2dlc3Rpb24uDQo+IA0KPiA+ID4gDQo+ID4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMv
Z2FkZ2V0LmMNCj4gPiA+IGluZGV4IDMwNDA4YmFmZTY0ZS4uNWFlNWZmNGM4ODU4IDEwMDY0NA0K
PiA+ID4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiA+ID4gKysrIGIvZHJpdmVy
cy91c2IvZHdjMy9nYWRnZXQuYw0KPiA+ID4gQEAgLTE5NjIsNiArMTk2MiwzNCBAQCBzdGF0aWMg
aW50IF9fZHdjM19nYWRnZXRfZ2V0X2ZyYW1lKHN0cnVjdCBkd2MzICpkd2MpDQo+ID4gPiAgIAly
ZXR1cm4gRFdDM19EU1RTX1NPRkZOKHJlZyk7DQo+ID4gPiAgIH0NCj4gPiA+ICtzdGF0aWMgaW50
IGR3YzNfcG9sbF9lcF9jb21wbGV0aW9uKHN0cnVjdCBkd2MzX2VwICpkZXApDQo+ID4gPiArew0K
PiA+ID4gKwlpZiAoIWxpc3RfZW1wdHkoJmRlcC0+c3RhcnRlZF9saXN0KSkgew0KPiA+ID4gKwkJ
c3RydWN0IGR3YzNfcmVxdWVzdCAqcmVxOw0KPiA+ID4gKwkJaW50IHRpbWVvdXQgPSA1MDA7DQo+
ID4gPiArDQo+ID4gPiArCQlyZXEgPSBuZXh0X3JlcXVlc3QoJmRlcC0+c3RhcnRlZF9saXN0KTsN
Cj4gPiA+ICsJCXdoaWxlKC0tdGltZW91dCkgew0KPiA+ID4gKwkJCS8qDQo+ID4gPiArCQkJICog
Tm90ZTogZG9uJ3QgY2hlY2sgdGhlIGxhc3QgZW5xdWV1ZWQgVFJCIGluIGNhc2UNCj4gPiA+ICsJ
CQkgKiBvZiBzaG9ydCB0cmFuc2Zlci4gQ2hlY2sgZmlyc3QgVFJCIG9mIGEgc3RhcnRlZA0KPiA+
ID4gKwkJCSAqIHJlcXVlc3QgaW5zdGVhZC4NCj4gPiA+ICsJCQkgKi8NCj4gPiA+ICsJCQlpZiAo
IShyZXEtPnRyYi0+Y3RybCAmIERXQzNfVFJCX0NUUkxfSFdPKSkNCj4gPiA+ICsJCQkJYnJlYWs7
DQo+ID4gPiArDQo+ID4gPiArCQkJdWRlbGF5KDIpOw0KPiA+ID4gKwkJfQ0KPiA+ID4gKwkJaWYg
KCF0aW1lb3V0KSB7DQo+ID4gPiArCQkJZGV2X3dhcm4oZGVwLT5kd2MtPmRldiwNCj4gPiA+ICsJ
CQkJICIlcyBpcyBzdGlsbCBpbi1wcm9ncmVzc1xuIiwgZGVwLT5uYW1lKTsNCj4gPiA+ICsJCQly
ZXR1cm4gLUVUSU1FRE9VVDsNCj4gPiA+ICsJCX0NCj4gPiA+ICsJfQ0KPiA+ID4gKw0KPiA+ID4g
KwlyZXR1cm4gMDsNCj4gPiA+ICt9DQo+ID4gPiArDQo+ID4gPiAgIC8qKg0KPiA+ID4gICAgKiBf
X2R3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXIgLSBzdG9wIHRoZSBjdXJyZW50IGFjdGl2ZSB0cmFu
c2Zlcg0KPiA+ID4gICAgKiBAZGVwOiBpc29jIGVuZHBvaW50DQo+ID4gPiBAQCAtMjAwMywxMCAr
MjAzMSwxMiBAQCBzdGF0aWMgaW50IF9fZHdjM19zdG9wX2FjdGl2ZV90cmFuc2ZlcihzdHJ1Y3Qg
ZHdjM19lcCAqZGVwLCBib29sIGZvcmNlLCBib29sIGludA0KPiA+ID4gICAJV0FSTl9PTl9PTkNF
KHJldCk7DQo+ID4gPiAgIAlkZXAtPnJlc291cmNlX2luZGV4ID0gMDsNCj4gPiA+IC0JaWYgKCFp
bnRlcnJ1cHQpDQo+ID4gPiArCWlmICghaW50ZXJydXB0KSB7DQo+ID4gPiArCQlyZXQgPSBkd2Mz
X3BvbGxfZXBfY29tcGxldGlvbihkZXApOw0KPiA+IA0KPiA+IEFjdHVhbGx5LCB0aGUgVFJCIHN0
YXR1cyBtYXkgbm90IGdldCB1cGRhdGVkLCBzbyB0aGlzIG1heSBub3Qgd29yaywNCj4gPiBpbnN0
ZWFkIG9mIHBvbGxpbmcsIG1heSBuZWVkIHRvIGFkZCB0aGUgZGVsYXkgaGVyZSBpbnN0ZWFkLg0K
PiA+IA0KPiANCj4gWWVhaCwgSSBqdXN0IGdhdmUgaXQgYSB0cnksIGFuZCBJIGdldCB0aGUgRVRJ
TUVET1VUIGVycm9yIGFsbCB0aGUgdGltZS4NCj4gRG9uJ3QgdGhpbmsgd2UgY2FuIHV0aWxpemUg
dGhlIEhXTyBiaXQgaGVyZS4NCj4gDQoNCkkgbWF5IGJlIG92ZXIgY29tcGxpY2F0aW5nIHRoaW5n
cyBoZXJlLiBXaXRoIEZvcmNlUk0sIHRoZSBjb250cm9sbGVyDQpvbmx5IHVwZGF0ZXMgdGhlIGxh
c3QgVFJCIGl0IHByb2Nlc3NlZC4gV2UgZG9uJ3QgY2FyZSBhYm91dCBwZXJmb3JtYW5jZQ0KbXVj
aCBkdXJpbmcgdGVhcmRvd24uIFRoYXQgd291bGQgbWVhbiBtb3JlIGNvZGVzIGZvciBzb21ldGhp
bmcgdGhhdCdzDQpub3QgbmVlZC4NCg0KQ2FuIHlvdSBhZGQgYSBkZWxheSBoZXJlIGluc3RlYWQ/
IE1ha2Ugc3VyZSBpdCdzIGF0IGxlYXN0IDFtcyBhbmQNCmFwcGxpY2FibGUgZm9yIGR3Y191c2Iz
MiBhbHNvLg0KDQpUaGFua3MsDQpUaGluaA0KDQo=
