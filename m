Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50A86B865E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 00:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjCMXyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 19:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjCMXyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 19:54:22 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B62A260;
        Mon, 13 Mar 2023 16:54:20 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32DK0aqd010150;
        Mon, 13 Mar 2023 16:54:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=sHSYuo4SdSUF46llT1LS1U1is+TfEg+HpLYUrGexAdc=;
 b=sN8k05IAiebZGp4kUSujtEThnGHvQXpa4DCpJAbhtp0FVJTc7zXtPwyQe2q0kSLBHW/Z
 OtjYX7nLzGmubAmU0DkFWDHisK9RHOWYZ/wDc5/Nr7qgjov5rhbDg6bo2nDBZ5p0YBOK
 Kq27x/gms7TzfR0P8MI8vAqpeSkA6C7I2t9eIAEveqyJhvpL0OFx1aCzuijj5f1lzFJ6
 7Zi+/nI1vdgLdboIpOJbc3a7IbbsOpd64yOeoWHTfGM9g88chAhIQBqlNewxkvVj/uHA
 odkoiApYRPdYfCGZNWXp0NdwwUIp8AleFDA1xyY6nSQwoNan4CKM7EpGy/cSWqo+98Xp gQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3p9ar4774u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 16:54:00 -0700
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 26B9AC04BF;
        Mon, 13 Mar 2023 23:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1678751639; bh=sHSYuo4SdSUF46llT1LS1U1is+TfEg+HpLYUrGexAdc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Uy7T8okl6pu3FY1/lLYT9GPyNBvbcrZZZk1VAd4ahRdIBMWX3fOaqi9JnLKVK2MFt
         i4X/1CpV+n7xvvhxX5ZBhbJukBKfWlCcLwBAd3OhWx9BzpPtNTaTsI6dnZi+XSgvUm
         1xWC1RAeYGNcmXYwnVDCCuBWwHigjJOMqaZoF0qNwHp0u77OvBaa3npcuIYZHCx86l
         Ti8UVm0mfuLvZJkbFNliqDJcVCuBAgaxN0n86ZX7u10SPoHlTxlaTQ/avz5vroFLxd
         q7+K07VdOZW8CEX83+AT9OQLSCDn/IkdHAxSWhKV12gvw5HYNRDsErC1OxVf18s54X
         iAqUCFU03C6hQ==
Received: from o365relay-in.synopsys.com (us03-o365relay5.synopsys.com [10.4.161.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id AF0D9A006D;
        Mon, 13 Mar 2023 23:53:56 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5C6C2800BF;
        Mon, 13 Mar 2023 23:53:54 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="ICpxqrnK";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwdgzSzjHwZTlo2rfAeabDe/KtpJA2TRdulZ3APua3CiMefWeJkYNbnS+YZI1nsuANM23jg+cUqDGPoSyw5Y4MrxqHPpZPBBKD2Rn+oWef7K5hk7k78b+oE7ohQKF2WG8aXyYC+9lr5RVNYBuYUyD1synnQOhNt9Sfmy6W6F4AYsvicDQ6dJT/vcPhvdR+VgDe5kv97oSvAwSxs+cp0LN8hIX2xbL+wkghYGgdGWzKTvqtsVydCX9HuHu2Btm6kaS76y10uioKsEHM5aBYYSXw18aj57uxX9XP3kAiWTB/b4IjW4CPH3GaDrn/cgKCVaKFfhoZCZ2ovwF0WrzmT5Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHSYuo4SdSUF46llT1LS1U1is+TfEg+HpLYUrGexAdc=;
 b=hpOSq5J0qB7dm2BpVJutPqD0Gx6SVJ9y1cDAaQKz76l8pUq8mz7Ll4p4Rzpn0TD7UWTuAnlKoAqlBwJK3MuJQxtWvDyUaZL3GxwxVroQ3nZ9hPNekpwxGTBuXBN8PBsRl/PSTHmJYMZO7HEhMuTy5L5cYaxcLJmWgmu1cepYF8D5XMOlapUDhAyFI2Cyb9u+afriqruQErsMoCVR/X1prtpiuW2sfpnh4GGJdGpOKbCfTSQs7KkAR/VliykbGJcFN0klyjCs7msFZW14TX+bW1qzJhPEWIEzQNGgqmSo22QrkC6xO4y1mtWm+TfNTzKmdgnlw/h/ncLWLoLHdjaKvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHSYuo4SdSUF46llT1LS1U1is+TfEg+HpLYUrGexAdc=;
 b=ICpxqrnKJP84XOw+uHFifQIzVzuWiiUUXmMo8sJHdY5+2JtJeAO60zzj/qrXOLm5Q59hTT80mxcFrk3caiAn5wR6jc1OY4EzJrh6/p8NVjIBVxnLWPfnbsHXicw6UV+Ce2VOo7UaUCkFAnl+1r0VDXkTIWuNcHRTZPaK6A0zKUg=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MN6PR12MB8472.namprd12.prod.outlook.com (2603:10b6:208:46c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 23:53:50 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 23:53:50 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "quic_pkondeti@quicinc.com" <quic_pkondeti@quicinc.com>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_harshq@quicinc.com" <quic_harshq@quicinc.com>,
        "ahalaney@redhat.com" <ahalaney@redhat.com>,
        "quic_shazhuss@quicinc.com" <quic_shazhuss@quicinc.com>
Subject: Re: [PATCH 2/8] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Thread-Topic: [PATCH 2/8] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Thread-Index: AQHZU25OkivR3WhNOEuJyDnjX7usOq70sMKAgAAx2ICAAALPAIAEgdMA
Date:   Mon, 13 Mar 2023 23:53:50 +0000
Message-ID: <20230313235346.pidgmk3lufepxrex@synopsys.com>
References: <20230310163420.7582-1-quic_kriskura@quicinc.com>
 <20230310163420.7582-3-quic_kriskura@quicinc.com>
 <20230310235537.afl76rs3pcifbn46@synopsys.com>
 <c23453b3-4f91-aa0a-c45a-de99ac369048@quicinc.com>
 <966c1001-6d64-9163-0c07-96595156fc8c@quicinc.com>
In-Reply-To: <966c1001-6d64-9163-0c07-96595156fc8c@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|MN6PR12MB8472:EE_
x-ms-office365-filtering-correlation-id: 3edb7935-9451-49ba-58df-08db241e31d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z6ancn2Dy1hGr/BfCGDPBMlKCt3PWDbtxe3oXvMi7RJ4EHGWQz4YlmFIyTtOIVeTSxI+XnSpqLcHZmQE7q6C2T86y6bambrMfG7hpZ7elKiOQro3hqLemgLLOf+QWNTbBO/G2KDmGJ8C/RKA8UpmbF9Y3Lic33OOh2snoiUWcb4+CA2SZ4+VLXF+2u1j2RlD+mL/eEPC5A++8ZH3Z9aYa8JhcM92WQA56ElGV/r1V2bsTmFcR0X8mptaA4fd/bsJU/x2d8d5PpQkjrIvm5aSsGU2sllaocZgsmAZlO/YZwZhbm4mqyA0zsfXq1g1QUM7SKhdpw6i01HXf4mpiu0QL9Fw2FOO02K5Z640xNPwnseACK1yugRekURZJz0KtZLBOIve5d85SSTDeZ3GGNf834aQAqf1dHR8QsgnmX4bpp5E8Rq+Brw6koHs2TfbM9ivYBiRBVTS92sdrkYc1ym/QTFQSH2g6zLKm5wL88+MlOVGugJo2fa+y+kjeTaW3r0ZlFfBEMkKsyvVfAGUICIRN0gNglC9LmhTYtbMz3Qjixh0f2rvs/AMLBNJJfyDOJgI7vD/ARAXnu4yBGI8HkjGx3Feoo89bS+olV2xnovhpIlgSnJ5wECoihbANUw3rbURoiDcY35GnT+GhigV535afB2E7OD0TdAS2AFR8sGacaY0eKssXdiVNUEGjvA5OQ3kqxK0pugU3a89+XWaMmZEyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199018)(38070700005)(36756003)(86362001)(122000001)(38100700002)(8936002)(76116006)(66476007)(66556008)(8676002)(66446008)(6916009)(66946007)(4326008)(64756008)(41300700001)(478600001)(54906003)(316002)(7416002)(5660300002)(2906002)(2616005)(6486002)(83380400001)(71200400001)(26005)(6506007)(53546011)(186003)(1076003)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3FJQjFiV2RtRjFGVkoxT3VBQ2V4UkQzcUx3K1lSZDNHelpIVE1oVTNZYnZK?=
 =?utf-8?B?VWt1Y25YZ1BhWmNiOUVVSXdJS3JvSGJYa2gyMHJwVkN2MU0yU282blZ6WThE?=
 =?utf-8?B?ZXZIdzdzaENmd3NTTytMUEpkR0V0bE5NYk4xd0dpYmsxZFdlZThEdU5keCsx?=
 =?utf-8?B?c1RGZFJYd0dPM21SdXlMVXdHNkRtaW44aDdRSmtHRi9XdjlxdW1PdzIwcUNQ?=
 =?utf-8?B?L1lnYnZlTkNqZzJCMjlsb0ZkTGtTUFlsVjNCSG9OcDZyblBBeDVtRDZENlQx?=
 =?utf-8?B?ZDU2bUh3T0dYcG1vZ3NZZXlHT3IvRmdsVHRJRUIxamRLTWpPUWFMTGJIVnFG?=
 =?utf-8?B?V0pzVXlka1N4QkxFTmZXR2I3dGdORzJJYVl0bDJHMTIwcWE0ZkZZd0c1RjJn?=
 =?utf-8?B?cS95ZHRVeWVNeEthSDlGdm45ZnYxQ1JGb1IzdkdJTVgvWUVXVWZsekFxb21D?=
 =?utf-8?B?V0tLL2g2bnZvWCtrU09rb0QxOU1mOGdYYVI2cm1IelVmRnlKeTRDYURZNU8w?=
 =?utf-8?B?WnpWaStWUkJXdk1JcUQyR3NJWkl4ZlYxNmRVVFd2QUlhRGNYdm9mN2Q0R0U3?=
 =?utf-8?B?UDZMVVloV3RQTTd6ZkRYdys2VkhxZHdHTVpvRE42NTlpUXpSTitCSmtBNUpF?=
 =?utf-8?B?RTlzUjZ6SEFWeERQRExYdlJkN3RVSVc1WHVUeG83bjkxQ2NGcXVocFYzUXJp?=
 =?utf-8?B?azdhdlc0QjZCWkhTUy9hbWVSV2dRU2NxZlp0T2NiU3ZObXRZL29XTzMraWxq?=
 =?utf-8?B?OFhCdkVYenYyeHVmUmZPT0NjQXdSTUtnM1g0RkN4K1JBbkhGU1g5Tm1oWW9u?=
 =?utf-8?B?V3R4MjJaNzU4aDdORld4ZmFxcmExYXBpTzdQZWk3M3VDTVZUbHlVN0tUN3Fx?=
 =?utf-8?B?VkVnT2xBcEZxekhWd3BzQTM3UUI0Rjl1VzJmc2l5b0pyU0JsTm1CdWJ1Z00r?=
 =?utf-8?B?Q3R4MnovVmhJZzh3bkFobXA3OXU3WW9aQ0RWQUNTdEY2YnRLR2hXV3owc1Fj?=
 =?utf-8?B?allFN0VQUllTWHZ2YTI4NWxRTTVGWlExb1VtOGQ0WWRPKzYxdmhFTTUwYTdQ?=
 =?utf-8?B?S0ZoQy8rU2NRS3ptOUcyMFNNOHdGNG5Ndlo2b0tDQ3lRQmVQY3A5N1hGWG9h?=
 =?utf-8?B?S0oyK0IrZmlEOUJzQk5Yb2UwNGFoazVrOTB3M1gyV3NzMTB4YTE4Vi9DSUc1?=
 =?utf-8?B?ZWJsQlRiVWczMnIzQzlYQSt1SWpSdWs4eG5Uc0h0cjVoNHVpdCtBbTE4TnRB?=
 =?utf-8?B?UGNQV2lFbGdpbHhJWnBLd1lNdldwNkFMeXptYS9TZU1aNWp0VVJLbktRUm4x?=
 =?utf-8?B?eUVLbUhEdkxzMlg4eFZkK0VvQXBTdWlybWg0a2xoM0pERGpZVTQ2dFFuUEkz?=
 =?utf-8?B?Ylc5TW1XUGUzcjhOeXlBbkZVOGdDZlJ1SjdYYllLSE1mdWpNdEsyTFpYSnM5?=
 =?utf-8?B?azJpTVBFR1JmcjB1aG5kbjgwUjNLZUErNUlQMXNucXUraFZHSElZVlN2Y2RO?=
 =?utf-8?B?SmZkNTNOS1RuN3VCNVg1eWVqL2pXazhXaUljajVyOStvTGhZZ2RZYm01ZnI4?=
 =?utf-8?B?WTR0OXlyQkJkNGtnazRwN2JnODY5TmZkaHVMWTVoYUxQbk9CZSs3azlaMzN3?=
 =?utf-8?B?NmdkN3N4TGhNeTV3cFRxcXMrcUtuTFRoQmNHR2JPTUVZeUorQ0NqN21NWjlt?=
 =?utf-8?B?RGhITzU4dTB1RFhIWWJJZXVJSTQxZ3AreENzbFNPNERaSDdheFMzSzRIc3pI?=
 =?utf-8?B?Z2VyelBCV3hqTEJNUTVkWEJ1K1o0RHVqK0xTbzlOY04rYjhjVm10RjBVR1do?=
 =?utf-8?B?RzIrYWxyTTZ4TTFYdzZwZEhFTFpWMnQ5czNDMUUwVlhuZkphNi9rWEdiODBX?=
 =?utf-8?B?QTBBdWdkbkFEKzlZV0gwVFJuWWxUa3BFQkU1QzdCWVI1VVI3OFlKclFwYXJI?=
 =?utf-8?B?Z0I2QXpZQkQ5ZWhKeDB5RThMR3NYaE1KMUQyVW9KWVhjaHNib0M1dmZySlMv?=
 =?utf-8?B?eWFBV2ZzMTBjZnA1QnlNNFpZSk9rWHZDQU0xUm1YbU1QYkhxN21iSnpZaEhy?=
 =?utf-8?B?ckJSWjVwdnAxQlhldUtkekY4QkpXVlJ4SG9UdDVtY2pPZGw0Q2cwL2F3eENY?=
 =?utf-8?B?RnVhRE1GZ3hQYzZhYXVTOGV6RENWUHpCRjRNakh5dUhCaytEREwwUnYxR2Uw?=
 =?utf-8?B?dGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31A6F4B30061F44C891D7D74BB39011A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?M3ZyKzBoMDdKMm5OYjMzSnJUSlZvelE3OENTK2tmUWZjem9kUENqcis4dEhO?=
 =?utf-8?B?YW41R2k5Sm0rTWxIVHNIVkVEdGMrZW85NklWQXlrMVhKWXRieVdaVU1LZGpp?=
 =?utf-8?B?UG0rODZaclJxalRIMGVSdWJBdHdaM2NneFMwQmZ2ZUhRdzJ5WWs1ODJHY3lR?=
 =?utf-8?B?WFc4R3ZRQ3RnMTI1b3lEaGZMR2RRb2pSb0pXL1gxTWRiL2ZaaVBoL3M2VVR5?=
 =?utf-8?B?eWZOWFZtQms3MHVVeElIKzBJa1BJekx6aHg1VVFBTnF6b25FWmdobE9QUFBl?=
 =?utf-8?B?VVNxN255cVpRejk2MlducE9VTDdRRS9tS2o2WlFwNzdYZUs3SFJzaXIrM2sr?=
 =?utf-8?B?Uy9qQm1tVUZNK0RPeVdIdExXNXVpNENSd2wxd05kcGhNcm1PZWFkY0k5S20z?=
 =?utf-8?B?WVRHM2VRYitodmpsczNCS2l4RTdtVkdVN1pla3JsSUFycmUzTld4SW9xWWRn?=
 =?utf-8?B?bFVGYy94a3NBRWsvU2JRVVpVV1NYYlRacnoxeGRaZUIzU3Rtdy9PalVRZkV1?=
 =?utf-8?B?ZVh1ZHY2MCthL1BtMGgrTXhrakY0U1djNVVJMEo0RHRsODNGV2N4emErbmFE?=
 =?utf-8?B?eHR1NUJmTzlvSkRyZzNQaDFvUk80ZXNSWE1uYUtJaDgxY1crbnBlUjEzcDNy?=
 =?utf-8?B?VmpEL0cxd2MrZy9QZnYrWTloeUVwWEZyTStWS2RRL0kxZjE4cGI4eUFVTU93?=
 =?utf-8?B?N1hPWnhvVFNuVHJwY3crNmlhQm5rY3lpZEwwV29TZDM5OG1XZjhmdTlZL1VF?=
 =?utf-8?B?SUpMbTBLOEFXQ0hnd3hXWGJoVDVNMkZ4c1hmVGIyWmRHUUJuYzdCVk1MMUdu?=
 =?utf-8?B?L0NsUnJlMG1BUGdhU3RyZzdTUEdBN1lNSWZLU2Nabytxb1RpNGw3N043L3Iw?=
 =?utf-8?B?a3VBNldSL2VCdWFLSjVuODMwV0hCeDArdk5pZW9iSnYyY0RXOFhqNDhUZnlP?=
 =?utf-8?B?UncvQlBSTzBVOXoxYmE2TGNxV0szemhtMW5pR21DWXRyd3ZzcVprbW5QNkVa?=
 =?utf-8?B?Rm83Z0JGcm1zY1VSVVdyMG1wcE9lemh3eUZCdVRpZFRqam9tRG5hY1owcnd0?=
 =?utf-8?B?WUEzREpjVUszTCs2YVA4Z0lycFh0eUtWU0xZNFdmcm1PemFQY3BUbzZRREVo?=
 =?utf-8?B?Z1hMQ0dsK0VmeTJwYWJKNFhycEdKOFNWMWZjMFdibW9Pb0xkdENBVDM4aFlZ?=
 =?utf-8?B?MGo1NGJBRGpma1k0TjRjdVhCamwycndMbTVySmhpY3NzN1JjL1FHMUlSbUFZ?=
 =?utf-8?B?azc5VlJ0ZHFGZTJoRGE1YzByeitzZ2RmOXdHbGp0QUREdUNBZGFMOThUaFQ4?=
 =?utf-8?B?cnBZREJMdmhDV09qMWJLSUkrWGxwMzJiMUU4aG10b3RXN29ERG1xdXpmYkdT?=
 =?utf-8?B?TTY5dWhFVnNWcEE9PQ==?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3edb7935-9451-49ba-58df-08db241e31d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 23:53:50.6534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2dol85XMdA+QkI7ePC+bg37jonTv8h46zihLG8A53Qpt9+OOgqXPZ7/vW5aBIx7iTYeWAGMHZDwqZbZbKy56WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8472
X-Proofpoint-GUID: Nq5zfOw1jO0-JRr8zJqUPNpbOQ-MS3Wz
X-Proofpoint-ORIG-GUID: Nq5zfOw1jO0-JRr8zJqUPNpbOQ-MS3Wz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_11,2023-03-13_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 mlxscore=0 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303130189
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCBNYXIgMTEsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgUFNTTlYgd3JvdGU6DQo+IA0K
PiANCj4gT24gMy8xMS8yMDIzIDg6MjQgQU0sIEtyaXNobmEgS3VyYXBhdGkgUFNTTlYgd3JvdGU6
DQo+ID4gDQo+ID4gDQo+ID4gT24gMy8xMS8yMDIzIDU6MjUgQU0sIFRoaW5oIE5ndXllbiB3cm90
ZToNCj4gPiA+IE9uIEZyaSwgTWFyIDEwLCAyMDIzLCBLcmlzaG5hIEt1cmFwYXRpIHdyb3RlOg0K
PiA+ID4gPiBDdXJyZW50bHkgaG9zdC1vbmx5IGNhcGFibGUgRFdDMyBjb250cm9sbGVycyBzdXBw
b3J0IE11bHRpcG9ydC4NCj4gPiA+ID4gVGVtcG9yYXJpbHkNCj4gPiA+ID4gbWFwIFhIQ0kgYWRk
cmVzcyBzcGFjZSBmb3IgaG9zdC1vbmx5IGNvbnRyb2xsZXJzIGFuZCBwYXJzZSBYSENJIEV4dGVu
ZGVkDQo+ID4gPiA+IENhcGFiaWxpdGllcyByZWdpc3RlcnMgdG8gcmVhZCBudW1iZXIgb2YgcGh5
c2ljYWwgdXNiIHBvcnRzDQo+ID4gPiA+IGNvbm5lY3RlZCB0byB0aGUNCj4gPiA+ID4gbXVsdGlw
b3J0IGNvbnRyb2xsZXIgKHByZXN1bWluZyBlYWNoIHBvcnQgaXMgYXQgbGVhc3QgSFMNCj4gPiA+
ID4gY2FwYWJsZSkgYW5kIGV4dHJhY3QNCj4gPiA+ID4gaW5mbyBvbiBob3cgbWFueSBvZiB0aGVz
ZSBwb3J0cyBhcmUgU3VwZXIgU3BlZWQgY2FwYWJsZS4NCj4gPiA+ID4gDQo+ID4gPiA+IFNpZ25l
ZC1vZmYtYnk6IEtyaXNobmEgS3VyYXBhdGkgPHF1aWNfa3Jpc2t1cmFAcXVpY2luYy5jb20+DQo+
ID4gPiA+IC0tLQ0KPiA+ID4gPiDCoCBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyB8IDc1ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiA+IMKgIGRyaXZlcnMv
dXNiL2R3YzMvY29yZS5oIHzCoCA5ICsrKysrDQo+ID4gPiA+IMKgIDIgZmlsZXMgY2hhbmdlZCwg
ODQgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gPiA+ID4gaW5kZXgg
NDc2YjYzNjE4NTExLi4wNzZjMGY4YTQ0NDEgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMv
dXNiL2R3YzMvY29yZS5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+
ID4gPiA+IEBAIC0zNyw2ICszNyw3IEBADQo+ID4gPiA+IMKgICNpbmNsdWRlICJjb3JlLmgiDQo+
ID4gPiA+IMKgICNpbmNsdWRlICJnYWRnZXQuaCINCj4gPiA+ID4gwqAgI2luY2x1ZGUgImlvLmgi
DQo+ID4gPiA+ICsjaW5jbHVkZSAiLi4vaG9zdC94aGNpLmgiDQo+ID4gPiANCj4gPiA+IEkgdGhp
bmsgYmV0dGVyIHRvIGR1cGxpY2F0ZSBzb21lIG9mIHRoZSBsb2dpYyBpbiBkd2MzIGRyaXZlciBh
bmQgYXZvaWQNCj4gPiA+IGFueSBkaXJlY3QgZGVwZW5kZW5jeSB3aXRoIHRoZSB4aGNpIGRyaXZl
ci4NCj4gPiA+IA0KPiA+ID4gPiDCoCAjaW5jbHVkZSAiZGVidWcuaCINCj4gPiA+ID4gQEAgLTE3
NTAsNiArMTc1MSw2NSBAQCBzdGF0aWMgc3RydWN0IGV4dGNvbl9kZXYNCj4gPiA+ID4gKmR3YzNf
Z2V0X2V4dGNvbihzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiA+ID4gPiDCoMKgwqDCoMKgIHJldHVybiBl
ZGV2Ow0KPiA+ID4gPiDCoCB9DQo+ID4gPiA+ICtzdGF0aWMgaW50IGR3YzNfcmVhZF9wb3J0X2lu
Zm8oc3RydWN0IGR3YzMgKmR3Yywgc3RydWN0IHJlc291cmNlICpyZXMpDQo+ID4gPiA+ICt7DQo+
ID4gPiA+ICvCoMKgwqAgdm9pZCBfX2lvbWVtwqDCoMKgwqDCoMKgwqAgKnJlZ3M7DQo+ID4gPiA+
ICvCoMKgwqAgc3RydWN0IHJlc291cmNlwqDCoMKgwqDCoMKgwqDCoCBkd2NfcmVzOw0KPiA+ID4g
PiArwqDCoMKgIHUzMsKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb2Zmc2V0Ow0KPiA+ID4gPiArwqDC
oMKgIHUzMsKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGVtcDsNCj4gPiA+ID4gK8KgwqDCoCB1OMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgbWFqb3JfcmV2aXNpb247DQo+ID4gPiA+ICvCoMKgwqAgaW50
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSAwOw0KPiA+ID4gPiArDQo+ID4gPiA+ICvCoMKg
wqAgLyoNCj4gPiA+ID4gK8KgwqDCoMKgICogUmVtYXAgeEhDSSBhZGRyZXNzIHNwYWNlIHRvIGFj
Y2VzcyBYSENJIGV4dCBjYXAgcmVncywNCj4gPiA+ID4gK8KgwqDCoMKgICogc2luY2UgaXQgaXMg
bmVlZGVkIHRvIGdldCBwb3J0IGluZm8uDQo+ID4gPiA+ICvCoMKgwqDCoCAqLw0KPiA+ID4gPiAr
wqDCoMKgIGR3Y19yZXMgPSAqcmVzOw0KPiA+ID4gPiArwqDCoMKgIGR3Y19yZXMuc3RhcnQgKz0g
MDsNCj4gPiA+ID4gK8KgwqDCoCBkd2NfcmVzLmVuZCA9IGR3Yy0+eGhjaV9yZXNvdXJjZXNbMF0u
c3RhcnQgKw0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIERXQzNfWEhD
SV9SRUdTX0VORDsNCj4gPiA+IA0KPiA+ID4gSXNuJ3QgZHdjLT54aGNpX3Jlc291cmNlc1swXSBh
bHJlYWR5IHNldHVwIGF0IHRoaXMgcG9pbnQ/IENhbiB3ZSB1c2UNCj4gPiA+IGR3Yy0+eGhjaV9y
ZXNvdXJjZXNbMF0gZGlyZWN0bHkgd2l0aG91dCBjb3B5IHRoZSBzZXR0aW5nIGluIGR3Y19yZXM/
DQo+ID4gPiANCj4gPiA+ID4gKw0KPiA+ID4gPiArwqDCoMKgIHJlZ3MgPSBpb3JlbWFwKGR3Y19y
ZXMuc3RhcnQsIHJlc291cmNlX3NpemUoJmR3Y19yZXMpKTsNCj4gPiA+ID4gK8KgwqDCoCBpZiAo
SVNfRVJSKHJlZ3MpKQ0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIFBUUl9FUlIocmVn
cyk7DQo+ID4gPiA+ICsNCj4gPiA+ID4gK8KgwqDCoCBvZmZzZXQgPSB4aGNpX2ZpbmRfbmV4dF9l
eHRfY2FwKHJlZ3MsIDAsDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBYSENJX0VYVF9DQVBTX1BST1RPQ09MKTsNCj4gPiA+ID4gK8KgwqDCoCB3aGlsZSAo
b2Zmc2V0KSB7DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoCB0ZW1wID0gcmVhZGwocmVncyArIG9m
ZnNldCk7DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoCBtYWpvcl9yZXZpc2lvbiA9IFhIQ0lfRVhU
X1BPUlRfTUFKT1IodGVtcCk7DQo+ID4gPiA+ICsNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgIHRl
bXAgPSByZWFkbChyZWdzICsgb2Zmc2V0ICsgMHgwOCk7DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDC
oCBpZiAobWFqb3JfcmV2aXNpb24gPT0gMHgwMykgew0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBkd2MtPm51bV9zc19wb3J0cyArPSBYSENJX0VYVF9QT1JUX0NPVU5UKHRlbXApOw0K
PiA+ID4gPiArwqDCoMKgwqDCoMKgwqAgfSBlbHNlIGlmIChtYWpvcl9yZXZpc2lvbiA8PSAweDAy
KSB7DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGR3Yy0+bnVtX3BvcnRzICs9IFhI
Q0lfRVhUX1BPUlRfQ09VTlQodGVtcCk7DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoCB9IGVsc2Ug
ew0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfZXJyKGR3Yy0+ZGV2LCAicG9y
dCByZXZpc2lvbiBzZWVtcyB3cm9uZ1xuIik7DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJldCA9IC1FSU5WQUw7DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8g
dW5tYXBfcmVnOw0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqAgfQ0KPiA+ID4gPiArDQo+ID4gPiA+
ICvCoMKgwqDCoMKgwqDCoCBvZmZzZXQgPSB4aGNpX2ZpbmRfbmV4dF9leHRfY2FwKHJlZ3MsIG9m
ZnNldCwNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgWEhDSV9FWFRfQ0FQU19QUk9UT0NPTCk7DQo+ID4gPiA+ICvCoMKgwqAgfQ0KPiA+ID4g
PiArDQo+ID4gPiA+ICvCoMKgwqAgdGVtcCA9IHJlYWRsKHJlZ3MgKyBEV0MzX1hIQ0lfSENTUEFS
QU1TMSk7DQo+ID4gPiA+ICvCoMKgwqAgaWYgKEhDU19NQVhfUE9SVFModGVtcCkgIT0gKGR3Yy0+
bnVtX3NzX3BvcnRzICsgZHdjLT5udW1fcG9ydHMpKSB7DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDC
oCBkZXZfZXJyKGR3Yy0+ZGV2LCAiaW5jb25zaXN0ZW5jeSBpbiBwb3J0IGluZm9cbiIpOw0KPiA+
ID4gPiArwqDCoMKgwqDCoMKgwqAgcmV0ID0gLUVJTlZBTDsNCj4gPiA+ID4gK8KgwqDCoMKgwqDC
oMKgIGdvdG8gdW5tYXBfcmVnOw0KPiA+ID4gPiArwqDCoMKgIH0NCj4gPiA+ID4gKw0KPiA+ID4g
PiArwqDCoMKgIGRldl9pbmZvKGR3Yy0+ZGV2LA0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqAgIm51
bS1wb3J0czogJWQgc3MtY2FwYWJsZTogJWRcbiIsIGR3Yy0+bnVtX3BvcnRzLA0KPiA+ID4gPiBk
d2MtPm51bV9zc19wb3J0cyk7DQo+ID4gPiANCj4gPiA+IFRoZSBlbmQgdXNlciBkb2Vzbid0IG5l
ZWQgdG8ga25vdyB0aGlzIGluZm8uIFRoaXMgc2hvdWxkIGJlIGEgZGVidWcNCj4gPiA+IG1lc3Nh
Z2UuIFBlcmhhcHMgaXQgY2FuIGJlIGEgdHJhY2Vwb2ludCBpZiBuZWVkZWQ/DQo+ID4gPiANCj4g
PiA+ID4gKw0KPiA+ID4gPiArdW5tYXBfcmVnOg0KPiA+ID4gPiArwqDCoMKgIGlvdW5tYXAocmVn
cyk7DQo+ID4gPiA+ICvCoMKgwqAgcmV0dXJuIHJldDsNCj4gPiA+ID4gK30NCj4gPiA+ID4gKw0K
PiA+ID4gPiDCoCBzdGF0aWMgaW50IGR3YzNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikNCj4gPiA+ID4gwqAgew0KPiA+ID4gPiDCoMKgwqDCoMKgIHN0cnVjdCBkZXZpY2XCoMKg
wqDCoMKgwqDCoCAqZGV2ID0gJnBkZXYtPmRldjsNCj4gPiA+ID4gQEAgLTE3NTcsNiArMTgxNyw3
IEBAIHN0YXRpYyBpbnQgZHdjM19wcm9iZShzdHJ1Y3QNCj4gPiA+ID4gcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQ0KPiA+ID4gPiDCoMKgwqDCoMKgIHN0cnVjdCBkd2MzwqDCoMKgwqDCoMKgwqAgKmR3
YzsNCj4gPiA+ID4gwqDCoMKgwqDCoCBpbnTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldDsNCj4g
PiA+ID4gK8KgwqDCoCB1bnNpZ25lZCBpbnTCoMKgwqDCoMKgwqDCoCBod19tb2RlOw0KPiA+ID4g
PiDCoMKgwqDCoMKgIHZvaWQgX19pb21lbcKgwqDCoMKgwqDCoMKgICpyZWdzOw0KPiA+ID4gPiBA
QCAtMTg4MCw2ICsxOTQxLDIwIEBAIHN0YXRpYyBpbnQgZHdjM19wcm9iZShzdHJ1Y3QNCj4gPiA+
ID4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBnb3RvIGRpc2FibGVfY2xrczsNCj4gPiA+ID4gwqDCoMKgwqDCoCB9DQo+ID4gPiA+ICvC
oMKgwqAgLyoNCj4gPiA+ID4gK8KgwqDCoMKgICogQ3VycmVudGx5IERXQzMgY29udHJvbGxlcnMg
dGhhdCBhcmUgaG9zdC1vbmx5IGNhcGFibGUNCj4gPiA+ID4gK8KgwqDCoMKgICogc3VwcG9ydCBN
dWx0aXBvcnQuDQo+ID4gPiA+ICvCoMKgwqDCoCAqLw0KPiA+ID4gPiArwqDCoMKgIGh3X21vZGUg
PSBEV0MzX0dIV1BBUkFNUzBfTU9ERShkd2MtPmh3cGFyYW1zLmh3cGFyYW1zMCk7DQo+ID4gPiA+
ICvCoMKgwqAgaWYgKGh3X21vZGUgPT0gRFdDM19HSFdQQVJBTVMwX01PREVfSE9TVCkgew0KPiA+
ID4gPiArwqDCoMKgwqDCoMKgwqAgcmV0ID0gZHdjM19yZWFkX3BvcnRfaW5mbyhkd2MsIHJlcyk7
DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoCBpZiAocmV0KQ0KPiA+ID4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBnb3RvIGRpc2FibGVfY2xrczsNCj4gPiA+ID4gK8KgwqDCoCB9IGVsc2Ugew0K
PiA+ID4gPiArwqDCoMKgwqDCoMKgwqAgZHdjLT5udW1fcG9ydHMgPSAxOw0KPiA+ID4gPiArwqDC
oMKgwqDCoMKgwqAgZHdjLT5udW1fc3NfcG9ydHMgPSAxOw0KPiA+ID4gPiArwqDCoMKgIH0NCj4g
PiA+ID4gKw0KPiA+ID4gPiDCoMKgwqDCoMKgIHNwaW5fbG9ja19pbml0KCZkd2MtPmxvY2spOw0K
PiA+ID4gPiDCoMKgwqDCoMKgIG11dGV4X2luaXQoJmR3Yy0+bXV0ZXgpOw0KPiA+ID4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmggYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUu
aA0KPiA+ID4gPiBpbmRleCA1ODJlYmQ5Y2Y5YzIuLjc0Mzg2ZDZhMDI3NyAxMDA2NDQNCj4gPiA+
ID4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gPiA+ID4gKysrIGIvZHJpdmVycy91
c2IvZHdjMy9jb3JlLmgNCj4gPiA+ID4gQEAgLTM1LDYgKzM1LDkgQEANCj4gPiA+ID4gwqAgI2Rl
ZmluZSBEV0MzX01TR19NQVjCoMKgwqAgNTAwDQo+ID4gPiA+ICsvKiBYSENJIFJlZyBjb25zdGFu
dHMgKi8NCj4gPiA+ID4gKyNkZWZpbmUgRFdDM19YSENJX0hDU1BBUkFNUzHCoMKgwqAgMHgwNA0K
PiA+ID4gPiArDQo+ID4gPiA+IMKgIC8qIEdsb2JhbCBjb25zdGFudHMgKi8NCj4gPiA+ID4gwqAg
I2RlZmluZSBEV0MzX1BVTExfVVBfVElNRU9VVMKgwqDCoCA1MDDCoMKgwqAgLyogbXMgKi8NCj4g
PiA+ID4gwqAgI2RlZmluZSBEV0MzX0JPVU5DRV9TSVpFwqDCoMKgIDEwMjTCoMKgwqAgLyogc2l6
ZSBvZiBhIHN1cGVyc3BlZWQgYnVsayAqLw0KPiA+ID4gPiBAQCAtMTAyMyw2ICsxMDI2LDEwIEBA
IHN0cnVjdCBkd2MzX3NjcmF0Y2hwYWRfYXJyYXkgew0KPiA+ID4gPiDCoMKgICogQHVzYl9wc3k6
IHBvaW50ZXIgdG8gcG93ZXIgc3VwcGx5IGludGVyZmFjZS4NCj4gPiA+ID4gwqDCoCAqIEB1c2Iy
X3BoeTogcG9pbnRlciB0byBVU0IyIFBIWQ0KPiA+ID4gPiDCoMKgICogQHVzYjNfcGh5OiBwb2lu
dGVyIHRvIFVTQjMgUEhZDQo+ID4gPiA+ICsgKiBAbnVtX3BvcnRzOiBJbmRpY2F0ZXMgdGhlIG51
bWJlciBvZiBwaHlzaWNhbCBVU0IgcG9ydHMgcHJlc2VudCBvbiBIVw0KPiA+ID4gPiArICrCoMKg
wqDCoMKgwqDCoCBwcmVzdW1pbmcgZWFjaCBwb3J0IGlzIGF0IGxlYXN0IEhTIGNhcGFibGUNCj4g
PiA+IA0KPiA+ID4gVGhpcyBpc24ndCB0aGUgbnVtYmVyIG9mIHBoeXNpY2FsIFVTQiBwb3J0cyBy
aWdodD8gVGhhdCdzIHRoZSBudW1iZXIgb2YNCj4gPiA+IHVzYjIgcG9ydHMgdGhlIGNvbnRyb2xs
ZXIgaXMgY29uZmlndXJlZCB3aXRoIHJpZ2h0Py4gUGVyaGFwcyB3ZSBjYW4gdXNlDQo+ID4gPiBu
dW1fdXNiMl9wb3J0cyBhbmQgbnVtX3VzYjNfcG9ydHM/DQo+ID4gPiANCj4gPiBIaSBUaGluaCwN
Cj4gPiANCj4gPiAgwqAgWWVzLCBuYW1pbmcgdGhpcyBtaWdodCBoYXZlIGNyZWF0ZWQgYSBsaXR0
bGUgY29uZnVzaW9uLg0KPiA+IG51bV9wb3J0cyBpcyBzdXBwb3NlZCB0byBpbmRpY2F0ZSBudW1i
ZXIgb2YgdXNiMiBwb3J0cyBpbiB0aGUgY29udHJvbGxlci4NCj4gPiANCj4gPiBJbmNhc2Ugb2Yg
c2E4Mjk1ICg0IHBvcnQgY29udHJvbGxlciB3aXRoIGZpcnN0IHR3byBwb3J0cyBoYXZpbmcgc3MN
Cj4gPiBjYXBhYmlsaXR5KSwgbnVtX3BvcnRzIHdvdWxkIGJlIDQgYW5kIG51bV9zc19wb3J0cyB3
b3VsZCBiZSAyLiAoYW5kIG5vdA0KPiA+IDYgYXMgd2hhdCBudW1fcG9ydHMgdXN1YWxseSBzb3Vu
ZHMpLg0KPiA+IEkgY2FuIHJlbmFtZSB0aGVtIGFjY29yZGluZ2x5IGluIHRoZSBuZXh0IHZlcnNp
b24gYW5kIHVwZGF0ZSB0aGUNCj4gPiBkZXNjcmlwdGlvbiBhcyB3ZWxsLg0KPiA+IA0KPiA+IFJl
Z2FyZHMsDQo+ID4gS3Jpc2huYSwNCj4gPiANCj4gSGkgVGhpbmgsDQo+IA0KPiBPbmUgcmVhc29u
IEkgZGlkbid0IG1lbnRpb24gc29tZXRoaW5nIGxpa2UgbnVtX2hzX3BvcnRzIGFuZCBzdGlja2Vk
IHRvDQo+IG51bV9wb3J0cyBpcyBiZWNhdXNlIGluIGNvcmUgZHJpdmVyLCB3aGVyZXZlciB3ZSBu
ZWVkIHRvIGRvIHBoeSBvcGVyYXRpb25zDQo+IGxpa2U6DQo+IA0KPiBmb3IgKGkgPSAwOyBpIDwg
bnVtX3BvcnRzOyBpKyspDQo+IHsNCj4gCXBoeV9zZXRfbW9kZShkd2MtPnVzYjJfZ2VuZXJpY19w
aHlbaV0sIFBIWV9NT0RFX1VTQl9IT1NUKTsNCj4gCXBoeV9zZXRfbW9kZShkd2MtPnVzYjNfZ2Vu
ZXJpY19waHlbaV0sIFBIWV9NT0RFX1VTQl9IT1NUKTsNCj4gfQ0KPiANCj4gVGhlIGludGVudGlv
biBpcyBhcyBmb2xsb3dzOg0KPiBJZiBudW1iZXIgb2YgdXNiMiBwb3J0cyBpcyA0LCB0aGUgbG9v
cCBjYW4gZ28gZnJvbSAwLTMgYW5kIGl0cyBmaW5lLg0KPiBJZiBudW1iZXIgb2YgdXNiMy1wb3J0
cyBpcyAyLCB3ZSBkb24ndCBrbm93IGZvciBzdXJlLCBpZiB0aGUgZmlyc3QgMiBwb3J0cw0KPiBh
cmUgU1MgY2FwYWJsZSBvciBzb21lIG90aGVyIHBvcnRzIGxpa2UgKDMgYW5kIDQpIGFyZSBTUyBj
YXBhYmxlLg0KPiBTbyBpbnN0ZWFkLCBJIGxvb3BlZCBhbGwgcGh5IG9wZXJhdGlvbnMgYXJvdW5k
IGFsbCB1c2IyX2dlbmVyaWNfcGh5J3MgYW5kDQo+IHVzYjNfZ2VuZXJpY19waHkncy4gSWYgdGhl
eSBhcmUgTlVMTCwgd2UganVzdCBiYWlsIG91dCBpbnNpZGUgcGh5IG9wZXJhdGlvbi4NCj4gDQo+
IFdoaWxlIGRvaW5nIHNvLCBsb29waW5nIFNTIFBoeSBvcGVyYXRpb25zIGFyb3VuZCBudW1fdXNi
Ml9wb3J0cyBkaWRuJ3Qgc291bmQNCj4gZ29vZC4gRnJvbSBjb2RlIHZpZXcsIGl0IHdvdWxkIGJl
IGxpa2Ugd2UgYXJlIGxvb3BpbmcgdXNiM19waHkgb3BzIGFyb3VuZA0KPiBudW1fdXNiMl9wb3J0
cyB2YWx1ZSAobG9naWNhbGx5IGl0IGlzIHN0aWxsIGNvcnJlY3QgYXMgZWFjaCBwb3J0IGlzIGF0
bGVhc3QNCj4gSFMgY2FwYWJsZSkuIFNvIHRvIGF2b2lkIHRoaXMsIEkgbmFtZWQgdGhlIHZhcmlh
YmxlIGFzIG51bV9wb3J0cyBpbnN0ZWFkIG9mDQo+IG51bV91c2IyX3BvcnRzDQo+IA0KDQpIaSBL
cmlzaG5hLA0KDQpJIHRoaW5rIGl0J3MgY2xlYXJlciBpZiBhZGQgdGhpcyBub3RlIGFsb25nIHdp
dGggdXNpbmcgbnVtX3VzYjJfcG9ydHMuDQpXZSBqdXN0IG5lZWQgdG8gbm90ZSB0aGlzIG9uY2Ug
YW5kIEkgdGhpbmsgaXQncyBzdWZmaWNpZW50Lg0KDQpUaGFua3MsDQpUaGluaA==
