Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4888E688894
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 21:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbjBBUxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 15:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjBBUxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 15:53:21 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F02981B39;
        Thu,  2 Feb 2023 12:53:20 -0800 (PST)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312J8U2e028316;
        Thu, 2 Feb 2023 12:53:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=fOWzlcVOCCT1CmmuXXE/fN0JnDc2m7zFtUMAzRLO67M=;
 b=klM/A/m17I9HzYO3/ekjk07/8TZmwFwG8GHnH0Mf/iRG1eyXp1LVTksSTDSo7hv1ZKtL
 Kr6/oqHJJAZ9YEkf+zRSC+HilSSn09jVsYpl+1KLGogkAQZXF23CmEQDVMZMUkgc+PPY
 ldJfJZ3vsNW84CEC0fLa7pvW9hWLIcYsLD4oKdm8MsLihAP+1QFBEdC0Zk5ciTJhdmjz
 BvT8kcuTZYu3s2dF9fguD6lWGZBWDp87ASXEvenbGtnHE85i3BNbbg+AdfZiQaf8qNp9
 VyNtfvqVK00rAB4E6Tqy4BsrVbgGJmYIWRo65lYhz1PNDBx3GevwkKfOGL10UjaQ1wpw YQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3nfq4nr9a1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 12:53:13 -0800
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0A762400CE;
        Thu,  2 Feb 2023 20:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1675371193; bh=fOWzlcVOCCT1CmmuXXE/fN0JnDc2m7zFtUMAzRLO67M=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=BNqZ98vkEX26S+vX80mty7/6M6jNPeqMJKy+2nx+uw8OCq23zsmcwEljLfVM6V8oJ
         z3a4h5Pt+bSXA+P22zG6rZHs5chxAFp6qFzokcbk+MY9/dsXAnrR/gIb6KWLAv+FjT
         uA/+BqN2HRQb1AH0+SabiJVSICFM026CEiXOiR27Rars74+vAZHZ7wKhCvVErVstYJ
         6JgW1MHpSUJv3TA7P0Gbc/EPe5r3OMKgTWPWgGGNw6mwfi+dCT/81jTbIR8jE892Wq
         qkVy+J/G4tdKJ8g4k3pypBZmUyyaysn2QhKI/YCUo6R+bNb5v69k5hVThbtj12/d4C
         rSpo9MAai2oDw==
Received: from o365relay-in.synopsys.com (unknown [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 0C7E6A005C;
        Thu,  2 Feb 2023 20:53:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1946E800AA;
        Thu,  2 Feb 2023 20:53:09 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="H6sPKMIc";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ka7jIyCdg9gBxwKa+UcPfjLIWcgSJRY95guEs5npRWu/lax04h6Tp1q2DIbF1C+V5wPywWHrg1kaYrO1mtXmV99bIilEyvpAlVdYv5G2iAkWeuX06+oIGb8Eb3UfVbd8Q0T+VO5qvRtynCCaF4EbzsV8b5DYhtQXIKk7IY5uxsnM1IILcKRa1EoXh0JYW37zCZRBYdSpMLci0VAO5cdb3OP+pqUY2N6sjHRI5IRWN5jknY8oFfx5Q/yH/quY5j/B0yjY5IuOa5LJGxQN/+JzGytGd3UR4Klh6XtX3Syc6+9J0KIDMBYG0oUJFuvN3I8F7sbAiRMZ3mRnNE2KVFTJXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOWzlcVOCCT1CmmuXXE/fN0JnDc2m7zFtUMAzRLO67M=;
 b=oDmWSLLv2lBBmLteo2X45orDYO4Lni8BrE0BjDCCRXhidQrt7bw2P0mQulSd69vqBTBXlaqWpVk39erjApCLTRVRycFLHohspAQHunm49A0ptWK68XTn/Aoph/gbf9pXiPMi7XsCLOly4A8wkuJb/c71AUrD9UQuXjk0lgveDmBZjHlcwGLgi6GQK+rdkjGX+aOJrYyQsH/6IfNhMR6xLdFWQTH0QPe/bhkATR1q4WRqwPSj3JbdY9Y426qSOcVXKs5Fw0/oJW9Xd3o+4ao/nRTQ5aW7JwhxeIqBxmxR7hJwcnrNoIsKPhfMAPUCJAG8uta1qrFm2gzON6wf4TwQTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOWzlcVOCCT1CmmuXXE/fN0JnDc2m7zFtUMAzRLO67M=;
 b=H6sPKMIcwlGPZEOpCJZS7dCOFeeAEcBneQGtfJ4Ks6CsGWfVKHaw/OFy5zNCEjpGqSpxB2a85bRHkhT5TKMYS7/Sb68EiF3AAZLLKcAxYycGYxzgLsm6BCVRq/myvy3phc8L4tjpFxsXZPd+vtp8uf7QhxoRfyUR0lSxzm9KwAw=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SN7PR12MB7909.namprd12.prod.outlook.com (2603:10b6:806:340::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 20:53:06 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c%7]) with mapi id 15.20.6043.038; Thu, 2 Feb 2023
 20:53:06 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Bruce Chen <bruce.chen@unisoc.com>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Cixi Geng <gengcixi@gmail.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: dwc3: fix memory leak with using debugfs_lookup()
Thread-Topic: [PATCH] USB: dwc3: fix memory leak with using debugfs_lookup()
Thread-Index: AQHZNxsFYPcX0cUyXku/iNee/1iTYa68InSA
Date:   Thu, 2 Feb 2023 20:53:05 +0000
Message-ID: <20230202205259.4n4skr7dvmelystt@synopsys.com>
References: <20230202152820.2409908-1-gregkh@linuxfoundation.org>
In-Reply-To: <20230202152820.2409908-1-gregkh@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SN7PR12MB7909:EE_
x-ms-office365-filtering-correlation-id: d7ebb19c-7032-4d3b-d423-08db055f7ba2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IoG2O6444aj/20coa4KfrnZqWil7rdgPtC9HHcK5nRtVuk6l0g55p5LsIMMrxY+KAk/OGuhWspineznw8VZM9wimvIFNgo2jQIW6YQbmyilwGNWYRWfQqM33Yi5zs6sfaD8fGsJxICcu8FIU7AbECf2n/mhy0naZQ+ihDllqAb7k4VqU3qZ6XzcEf6ksZOJZqTE3Kzj2yqt9HaUeIb4/tVr80CzUGoHDSvdZF3RunbyzzQjscfHWfE6QzBdJPY2r9ekDtAqb4PlVDG/KdV57aU/JHSnyb/8N8CBeCloSiL6NgGK2/k4jCFYtTFTZcADxvF1HjR7JTQ2PgFe7Q6iW9WhfME+ujzaK2gltTcvzxezoSzm/a6+rBjzHbbnaxyJGMwfPDRVZ7Qwes2Ibp2wD2ELPThCn/R/IyunNGfUkh4jFM/DAFPvccxnFy/mfLxBOqohGCkqo1TZD0Vx5KRt65leZTEoVhuzJJqdOD9U6buSl7TKXeJy+3XfjzcT0zU7BVlKNm4bCAHQ6wy773vMu7vgLwbTW/S7yrBRiR30fTwWPqr+BQnGxHEtO1/2bCa5O5RyOSnwASOqeZEqFm5cvfS+STxoeC4/Wzb4jZeexb4gKAEaMxguNdX5MgxiHGIhuA+vLGii4hGyFoyop8ejMIu/9WNfObabEeiEpsoHl++UpTPai19/lDwFeLbEhhnJyn7vzsnlzsQeU78/4oa8NOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199018)(36756003)(38070700005)(122000001)(38100700002)(66946007)(2906002)(6486002)(8676002)(41300700001)(4326008)(54906003)(316002)(76116006)(8936002)(5660300002)(71200400001)(86362001)(26005)(1076003)(6512007)(64756008)(66476007)(186003)(478600001)(66556008)(6506007)(66446008)(83380400001)(6916009)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnVXQ0pCeTc4TWNYcGhJT0gvSTdmNWlQVDNHM3Z3cjZkZGoyVXZlY3E1bzgr?=
 =?utf-8?B?TE5BamVDRGtZNUFCUEhISmxTdUNTei9jOEw4MTVBbENaWkZsSitGR1FIcitj?=
 =?utf-8?B?ZHBkVWlDdi9LWk8raVVNelVMS29haUFaTDQwVVB5ZjJJQ0hxWkNKbDUzdUNl?=
 =?utf-8?B?a1padjZvN0NhNnlkZFl1cXdTMDhhWVZwT1hiNkR2SFQ0N2pPUS9NcndCT0lW?=
 =?utf-8?B?QmZLdTYvK0hBdkIrbGNrRFJybDE2RGQ0VTNwV2dsYXdvVjNuaGdVWXB6SHcz?=
 =?utf-8?B?V0xWdmxlQnNUWGVUSmZld05qZ2o3ajdsODllaDNpNTM4cEh1Y2tnclF4T2Fq?=
 =?utf-8?B?NjJ6aUp1YTNIRTIvWUdSREN6cmlGWUcwRGhCNWgwUVBWVGYwVnhtREYrRE9t?=
 =?utf-8?B?cTE0OGlWdlQ4SG1nTkpzenlEdlkvNERDWTVRY2JIRXFxeWhFNHVYVytieWp5?=
 =?utf-8?B?ZjNSNzRVbmdIT25NdkJDdUxjdkx1NG5mUEt5eGI2eFZsNnJiUTIycXNyM2pp?=
 =?utf-8?B?MHlnSjR3eU9FT0g1ZDdZTmU3NUVyRytZV3pwdlNuS3UvUEJRa1pXYkw1aFdm?=
 =?utf-8?B?RzdBOE9SbXJyc3pubWhlTDhZZnJ0ZWh5TEhocXFrQkYyMVdlYUM4Q3IwS3M1?=
 =?utf-8?B?MlczTkhOSlA2a3FSYmdIQzcrMGVVN2gyUEpOWTJ5ckNEWU5NSDZtbU5vNkht?=
 =?utf-8?B?WHo0bzJ2OVRjUjd0Y0docXE0YjZFVXVab1dGd1ZUUVpqQS9YQUU4TWtVZXJz?=
 =?utf-8?B?Q0tpanBseG1wVUZRaWZwRElxa292anhGSEFOS1Y5MUhFbFhwZE9BcFAxNUJk?=
 =?utf-8?B?QXRrS2xOSmtqR2t0L25vUFlNVTBGYysrVnNnd3dqZ05qMk9RQ3M0TzRNN25C?=
 =?utf-8?B?enRvOHQ5dmFPVWdESGpYU05RSytlWnhYNVVqY3c4S0RxK0hBOU5SZTdEYlV3?=
 =?utf-8?B?OEQ3MGZjMC9rZHVxajRXQm52RmRnY1MxcjBRcTI4dW01Y0tYZk0rbTdoUzhH?=
 =?utf-8?B?cC9oNjdWYk9xamdmZ2ZRdndVbEhqMVlXcFY1T3NxVUIwVFFEVDlEeEd1cUU3?=
 =?utf-8?B?Ly82REcwQ2lDb2JWcmk3RWxscDhlcG9aNU9OMnMrWjEvWmpnc2gyVW5vZG1G?=
 =?utf-8?B?bUx6T2J5NHVDaVBGLzZaQy84ai9tOStkamMvV0xSUWtjUE80cnFsNlJuWUFS?=
 =?utf-8?B?V3pjUkZiNmpoR2NaRTYwYUk4VEY2VmhHM29FNmZGYUNaTTljOGl3M3RPb3hw?=
 =?utf-8?B?dFEvRW9JNkdDMmw1V2g3eHhrVGphbGliQ2JrR2d5Y2VEdGRvNDRyS2EveE92?=
 =?utf-8?B?Ny92TTlkbmZUM0ZINkJrR0JoWjNYN2duV0pzZXE5MUh2eFI5dFJ2cEtrYjNT?=
 =?utf-8?B?ZTdYNDJVcEVIV281T2lYa1dGS0lFa1RYeHNXL240K2I1VTBLRFY1SWp4dGVj?=
 =?utf-8?B?a0l2TFFwdGQ2ZURkU3NUbWk2UU9Ga3RGNWR4dWJFZ2VvTkNTUUIvNFF5dEkr?=
 =?utf-8?B?blNUdkF3OFBYaWYrSnRVbFI4TzhzOXlzL2F5S0JyQWkxWGQ4VmxrR0lVWHlK?=
 =?utf-8?B?RVBqNUQ3dkErZ0YwUDZUVnZ4MDA0S29EMlFkd0U4SGh1dDlyeG1waUFEdHdp?=
 =?utf-8?B?Z0RwRjl4R1pLT3NvRUJBVkRZRmNuSXpBMFkvUGxHQXNUSjkyY0NWWjYrR3Vj?=
 =?utf-8?B?TGlYakdCcUhQc3RTT0IvaVR0clFaOGhvcmxpK0R3NExsUXNYQzJ6K2k1M3Z1?=
 =?utf-8?B?Tm94TDBzcmFLOVBxRnc3dWhmZ0NOcFF5SUN2R0RLRG9RVXBhTDliVm9IVzU2?=
 =?utf-8?B?OVJHZ2V3YVRUUkxWWWlWSDBtU2Z6clVPTHNRdklWeFY1NmluSjB1Uyt3c2pC?=
 =?utf-8?B?K3JBWUhzbmV3R3R4RzdpOEZLenBuUnVxaUZpZ01wM0VsQmM2WWdJRG80Nys5?=
 =?utf-8?B?MUFVd3B3UzZwUjBRQzQyeFNQcDdOTXV6Yzg5M2E0UllVRlZhTGhwUk5vYjdO?=
 =?utf-8?B?aSt0OHllT1BWcm1SamRQcDZHdUZaWHdsSnpxVm1JL0piUTFjMG1RTVl1VnI2?=
 =?utf-8?B?TlRCUjM0aVJxd09wTTJwYXRqRWc1ZWNQSE9tdUtOK0FBTXJsS0o3cTRUUXo0?=
 =?utf-8?B?VjB4dVc1aXRQcnFiblVCYnU1bGVGM1hBSEIvMjY3Ym15aWg3QmZYaGRaWkxy?=
 =?utf-8?B?Z1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DA9EFC6A91533409A56EB28A3926A61@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VfJiV8oX9GPVz/tRcztgatS5OS3eywR2mb8O6CAVCKc7T+dy/u1+DoIqkTqLPc467fR04w8sTcf1/aiIZ5gKXT7ygiy6zgg5aEqcQ/Q78tTKIVpts4PHNhrB57Et3Dw7rpEmlV+Z6ArEqWqyG4dCqQaVFxRUlxucQdHoRLnX++3ZCw32aV/hlqj7NyqWwYt01mapeFtnZJhdDKN1RRnWWzRnCEeoYFv/+jnTg/HHtc5B48890TL2fDIL+aIa8+urwPLAJLVF0Iq/L8ScIT+1M7QUSBKBWCIy+54BBUQ1WXvIFiqFZqoAr+eaXZsSU1KWUgxcwcwoMnNXfKXMkFDsos7SzraIyn7iIlFtajMuE4kQrEtmeYRBbqwzHgvRG8xFdMmt5FhMrAQpZvmzpjdwluqvyGnRbAM8MGmFsfqG5cWvzjvMMnv9O6iQp6xEFamcx9JhgeoRiMIt8qWIz3xe06vaLGVJ9RzLRq75qTu61KEnvObwcgUaJ4yFPwQd+6Z+BVNHre2GX9ci6ZvimSnBFxUyo2AsZF9u4mB1TwN+tXI3B+0kHM2jnQWIXdSA5Yt8/TEYnxmuwNYNBb1Og+R7buNmtP+Bd1sOY5hV05OrRWKHHcREydg9G+tYD/iIAGOBHH7Kp5yLQo5579dmozBxmK9J4FfrAk/ZnfGwbfrsYdr/5TW9ocILHhL41GkRfItlclyHAYFSsXEq2yJxXI77qXL5PPMyimS3kGiWmwv0tFtzczW3zqFy8DZwRc9qAR4D6xUrnE/tzPJSoxaMcrkefEOXYivbB3QNP53X7G4IrrUEVx7yoWEYsGPGlot1Ecm2Rxy/jryjHklLrQ+mI005E5+b8XAExKuj9E42rL7ib4KMMjmrz83wZfOe+qnlId7mVETAjZkHI80pB7qgd7na961Sa3iNEnWNI18FsiIsLFA=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ebb19c-7032-4d3b-d423-08db055f7ba2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 20:53:05.7201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wQzcL1da1btO43ihkY+13AV7CB1mI4OjQ6ljiZoz7bUilPzvlaFHuGhv5bbqzjxzD7S08FhKdhB+zZhGr63AAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7909
X-Proofpoint-GUID: hlEuvMuNlikgHWkLSyJZlGzVbsJkn_w3
X-Proofpoint-ORIG-GUID: hlEuvMuNlikgHWkLSyJZlGzVbsJkn_w3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_14,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 clxscore=1011 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302020184
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBGZWIgMDIsIDIwMjMsIEdyZWcgS3JvYWgtSGFydG1hbiB3cm90ZToNCj4gV2hlbiBj
YWxsaW5nIGRlYnVnZnNfbG9va3VwKCkgdGhlIHJlc3VsdCBtdXN0IGhhdmUgZHB1dCgpIGNhbGxl
ZCBvbiBpdCwNCj4gb3RoZXJ3aXNlIHRoZSBtZW1vcnkgd2lsbCBsZWFrIG92ZXIgdGltZS4gIFRv
IG1ha2UgdGhpbmdzIHNpbXBsZXIsIGp1c3QNCj4gY2FsbCBkZWJ1Z2ZzX2xvb2t1cF9hbmRfcmVt
b3ZlKCkgaW5zdGVhZCB3aGljaCBoYW5kbGVzIGFsbCBvZiB0aGUgbG9naWMNCj4gYXQgb25jZS4N
Cj4gDQo+IE5vdGUsIHRoZSByb290IGRlbnRyeSBmb3IgdGhlIGRlYnVnZnMgZGlyZWN0b3J5IGZv
ciB0aGUgZGV2aWNlIG5lZWRzIHRvDQo+IGJlIHNhdmVkIHNvIHdlIGRvbid0IGhhdmUgdG8ga2Vl
cCBsb29raW5nIGl0IHVwLCB3aGljaCByZXF1aXJlZCBhIGJpdA0KPiBtb3JlIHJlZmFjdG9yaW5n
IHRvIHByb3Blcmx5IGNyZWF0ZSBhbmQgcmVtb3ZlIGl0IHdoZW4gbmVlZGVkLg0KPiANCj4gUmVw
b3J0ZWQtYnk6IEJydWNlIENoZW4gPGJydWNlLmNoZW5AdW5pc29jLmNvbT4NCj4gUmVwb3J0ZWQt
Ynk6IENpeGkgR2VuZyA8Y2l4aS5nZW5nMUB1bmlzb2MuY29tPg0KPiBUZXN0ZWQtYnk6IENpeGkg
R2VuZyA8Z2VuZ2NpeGlAZ21haWwuY29tPg0KPiBDYzogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5
ZW5Ac3lub3BzeXMuY29tPg0KPiBDYzogbGludXgtdXNiQHZnZXIua2VybmVsLm9yZw0KPiBDYzog
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBHcmVnIEtyb2Fo
LUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMv
dXNiL2R3YzMvY29yZS5oICAgIHwgIDIgKysNCj4gIGRyaXZlcnMvdXNiL2R3YzMvZGVidWcuaCAg
IHwgIDMgKysrDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2RlYnVnZnMuYyB8IDE5ICsrKysrKysrLS0t
LS0tLS0tLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgIHwgIDQgKy0tLQ0KPiAgNCBm
aWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCBiL2RyaXZlcnMvdXNiL2R3YzMvY29y
ZS5oDQo+IGluZGV4IDhmOTk1OWJhOWZkNC4uNTgyZWJkOWNmOWMyIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0K
PiBAQCAtMTExNyw2ICsxMTE3LDcgQEAgc3RydWN0IGR3YzNfc2NyYXRjaHBhZF9hcnJheSB7DQo+
ICAgKgkJICAgICBhZGRyZXNzLg0KPiAgICogQG51bV9lcF9yZXNpemVkOiBjYXJyaWVzIHRoZSBj
dXJyZW50IG51bWJlciBlbmRwb2ludHMgd2hpY2ggaGF2ZSBoYWQgaXRzIHR4DQo+ICAgKgkJICAg
IGZpZm8gcmVzaXplZC4NCj4gKyAqIEBkZWJ1Z19yb290OiByb290IGRlYnVnZnMgZGlyZWN0b3J5
IGZvciB0aGlzIGRldmljZSB0byBwdXQgaXRzIGZpbGVzIGluLg0KPiAgICovDQo+ICBzdHJ1Y3Qg
ZHdjMyB7DQo+ICAJc3RydWN0IHdvcmtfc3RydWN0CWRyZF93b3JrOw0KPiBAQCAtMTMzMiw2ICsx
MzMzLDcgQEAgc3RydWN0IGR3YzMgew0KPiAgCWludAkJCW1heF9jZmdfZXBzOw0KPiAgCWludAkJ
CWxhc3RfZmlmb19kZXB0aDsNCj4gIAlpbnQJCQludW1fZXBfcmVzaXplZDsNCj4gKwlzdHJ1Y3Qg
ZGVudHJ5CQkqZGVidWdfcm9vdDsNCj4gIH07DQo+ICANCj4gICNkZWZpbmUgSU5DUlhfQlVSU1Rf
TU9ERSAwDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2RlYnVnLmggYi9kcml2ZXJz
L3VzYi9kd2MzL2RlYnVnLmgNCj4gaW5kZXggNDhiNDRiODhkYzI1Li44YmIyYzllM2I5YWMgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZGVidWcuaA0KPiArKysgYi9kcml2ZXJzL3Vz
Yi9kd2MzL2RlYnVnLmgNCj4gQEAgLTQxNCwxMSArNDE0LDE0IEBAIHN0YXRpYyBpbmxpbmUgY29u
c3QgY2hhciAqZHdjM19nYWRnZXRfZ2VuZXJpY19jbWRfc3RhdHVzX3N0cmluZyhpbnQgc3RhdHVz
KQ0KPiAgDQo+ICAjaWZkZWYgQ09ORklHX0RFQlVHX0ZTDQo+ICBleHRlcm4gdm9pZCBkd2MzX2Rl
YnVnZnNfY3JlYXRlX2VuZHBvaW50X2RpcihzdHJ1Y3QgZHdjM19lcCAqZGVwKTsNCj4gK2V4dGVy
biB2b2lkIGR3YzNfZGVidWdmc19yZW1vdmVfZW5kcG9pbnRfZGlyKHN0cnVjdCBkd2MzX2VwICpk
ZXApOw0KPiAgZXh0ZXJuIHZvaWQgZHdjM19kZWJ1Z2ZzX2luaXQoc3RydWN0IGR3YzMgKmQpOw0K
PiAgZXh0ZXJuIHZvaWQgZHdjM19kZWJ1Z2ZzX2V4aXQoc3RydWN0IGR3YzMgKmQpOw0KPiAgI2Vs
c2UNCj4gIHN0YXRpYyBpbmxpbmUgdm9pZCBkd2MzX2RlYnVnZnNfY3JlYXRlX2VuZHBvaW50X2Rp
cihzdHJ1Y3QgZHdjM19lcCAqZGVwKQ0KPiAgeyAgfQ0KPiArc3RhdGljIGlubGluZSB2b2lkIGR3
YzNfZGVidWdmc19yZW1vdmVfZW5kcG9pbnRfZGlyKHN0cnVjdCBkd2MzX2VwICpkZXApDQo+ICt7
ICB9DQo+ICBzdGF0aWMgaW5saW5lIHZvaWQgZHdjM19kZWJ1Z2ZzX2luaXQoc3RydWN0IGR3YzMg
KmQpDQo+ICB7ICB9DQo+ICBzdGF0aWMgaW5saW5lIHZvaWQgZHdjM19kZWJ1Z2ZzX2V4aXQoc3Ry
dWN0IGR3YzMgKmQpDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2RlYnVnZnMuYyBi
L2RyaXZlcnMvdXNiL2R3YzMvZGVidWdmcy5jDQo+IGluZGV4IGYyYjc2NzVjN2Y2Mi4uODUwZGYw
ZTZiY2FiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2RlYnVnZnMuYw0KPiArKysg
Yi9kcml2ZXJzL3VzYi9kd2MzL2RlYnVnZnMuYw0KPiBAQCAtODczLDI3ICs4NzMsMjMgQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBkd2MzX2VwX2ZpbGVfbWFwIGR3YzNfZXBfZmlsZV9tYXBbXSA9IHsN
Cj4gIAl7ICJHREJHRVBJTkZPIiwgJmR3YzNfZXBfaW5mb19yZWdpc3Rlcl9mb3BzLCB9LA0KPiAg
fTsNCj4gIA0KPiAtc3RhdGljIHZvaWQgZHdjM19kZWJ1Z2ZzX2NyZWF0ZV9lbmRwb2ludF9maWxl
cyhzdHJ1Y3QgZHdjM19lcCAqZGVwLA0KPiAtCQlzdHJ1Y3QgZGVudHJ5ICpwYXJlbnQpDQo+ICt2
b2lkIGR3YzNfZGVidWdmc19jcmVhdGVfZW5kcG9pbnRfZGlyKHN0cnVjdCBkd2MzX2VwICpkZXAp
DQo+ICB7DQo+ICsJc3RydWN0IGRlbnRyeQkJKmRpcjsNCj4gIAlpbnQJCQlpOw0KPiAgDQo+ICsJ
ZGlyID0gZGVidWdmc19jcmVhdGVfZGlyKGRlcC0+bmFtZSwgZGVwLT5kd2MtPmRlYnVnX3Jvb3Qp
Ow0KPiAgCWZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKGR3YzNfZXBfZmlsZV9tYXApOyBpKysp
IHsNCj4gIAkJY29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyAqZm9wcyA9IGR3YzNfZXBfZmls
ZV9tYXBbaV0uZm9wczsNCj4gIAkJY29uc3QgY2hhciAqbmFtZSA9IGR3YzNfZXBfZmlsZV9tYXBb
aV0ubmFtZTsNCj4gIA0KPiAtCQlkZWJ1Z2ZzX2NyZWF0ZV9maWxlKG5hbWUsIDA0NDQsIHBhcmVu
dCwgZGVwLCBmb3BzKTsNCj4gKwkJZGVidWdmc19jcmVhdGVfZmlsZShuYW1lLCAwNDQ0LCBkaXIs
IGRlcCwgZm9wcyk7DQo+ICAJfQ0KPiAgfQ0KPiAgDQo+IC12b2lkIGR3YzNfZGVidWdmc19jcmVh
dGVfZW5kcG9pbnRfZGlyKHN0cnVjdCBkd2MzX2VwICpkZXApDQo+ICt2b2lkIGR3YzNfZGVidWdm
c19yZW1vdmVfZW5kcG9pbnRfZGlyKHN0cnVjdCBkd2MzX2VwICpkZXApDQo+ICB7DQo+IC0Jc3Ry
dWN0IGRlbnRyeQkJKmRpcjsNCj4gLQlzdHJ1Y3QgZGVudHJ5CQkqcm9vdDsNCj4gLQ0KPiAtCXJv
b3QgPSBkZWJ1Z2ZzX2xvb2t1cChkZXZfbmFtZShkZXAtPmR3Yy0+ZGV2KSwgdXNiX2RlYnVnX3Jv
b3QpOw0KPiAtCWRpciA9IGRlYnVnZnNfY3JlYXRlX2RpcihkZXAtPm5hbWUsIHJvb3QpOw0KPiAt
CWR3YzNfZGVidWdmc19jcmVhdGVfZW5kcG9pbnRfZmlsZXMoZGVwLCBkaXIpOw0KPiArCWRlYnVn
ZnNfbG9va3VwX2FuZF9yZW1vdmUoZGVwLT5uYW1lLCBkZXAtPmR3Yy0+ZGVidWdfcm9vdCk7DQo+
ICB9DQo+ICANCj4gIHZvaWQgZHdjM19kZWJ1Z2ZzX2luaXQoc3RydWN0IGR3YzMgKmR3YykNCj4g
QEAgLTkxMSw2ICs5MDcsNyBAQCB2b2lkIGR3YzNfZGVidWdmc19pbml0KHN0cnVjdCBkd2MzICpk
d2MpDQo+ICAJZHdjLT5yZWdzZXQtPmJhc2UgPSBkd2MtPnJlZ3MgLSBEV0MzX0dMT0JBTFNfUkVH
U19TVEFSVDsNCj4gIA0KPiAgCXJvb3QgPSBkZWJ1Z2ZzX2NyZWF0ZV9kaXIoZGV2X25hbWUoZHdj
LT5kZXYpLCB1c2JfZGVidWdfcm9vdCk7DQo+ICsJZHdjLT5kZWJ1Z19yb290ID0gcm9vdDsNCj4g
IAlkZWJ1Z2ZzX2NyZWF0ZV9yZWdzZXQzMigicmVnZHVtcCIsIDA0NDQsIHJvb3QsIGR3Yy0+cmVn
c2V0KTsNCj4gIAlkZWJ1Z2ZzX2NyZWF0ZV9maWxlKCJsc3BfZHVtcCIsIDA2NDQsIHJvb3QsIGR3
YywgJmR3YzNfbHNwX2ZvcHMpOw0KPiAgDQo+IEBAIC05MjksNiArOTI2LDYgQEAgdm9pZCBkd2Mz
X2RlYnVnZnNfaW5pdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgDQo+ICB2b2lkIGR3YzNfZGVidWdm
c19leGl0KHN0cnVjdCBkd2MzICpkd2MpDQo+ICB7DQo+IC0JZGVidWdmc19yZW1vdmUoZGVidWdm
c19sb29rdXAoZGV2X25hbWUoZHdjLT5kZXYpLCB1c2JfZGVidWdfcm9vdCkpOw0KPiArCWRlYnVn
ZnNfbG9va3VwX2FuZF9yZW1vdmUoZGV2X25hbWUoZHdjLT5kZXYpLCB1c2JfZGVidWdfcm9vdCk7
DQo+ICAJa2ZyZWUoZHdjLT5yZWdzZXQpOw0KPiAgfQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91
c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gaW5kZXggODlk
Y2ZhYzAxMjM1Li4zYzYzZmE5N2E2ODAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMv
Z2FkZ2V0LmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBAQCAtMzE5NCw5
ICszMTk0LDcgQEAgc3RhdGljIHZvaWQgZHdjM19nYWRnZXRfZnJlZV9lbmRwb2ludHMoc3RydWN0
IGR3YzMgKmR3YykNCj4gIAkJCWxpc3RfZGVsKCZkZXAtPmVuZHBvaW50LmVwX2xpc3QpOw0KPiAg
CQl9DQo+ICANCj4gLQkJZGVidWdmc19yZW1vdmVfcmVjdXJzaXZlKGRlYnVnZnNfbG9va3VwKGRl
cC0+bmFtZSwNCj4gLQkJCQlkZWJ1Z2ZzX2xvb2t1cChkZXZfbmFtZShkZXAtPmR3Yy0+ZGV2KSwN
Cj4gLQkJCQkJICAgICAgIHVzYl9kZWJ1Z19yb290KSkpOw0KPiArCQlkd2MzX2RlYnVnZnNfcmVt
b3ZlX2VuZHBvaW50X2RpcihkZXApOw0KPiAgCQlrZnJlZShkZXApOw0KPiAgCX0NCj4gIH0NCj4g
LS0gDQo+IDIuMzkuMQ0KPiANCg0KQWNrZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVu
QHN5bm9wc3lzLmNvbT4NCg0KVGhhbmtzLA0KVGhpbmg=
