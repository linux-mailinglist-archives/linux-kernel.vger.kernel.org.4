Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101E066378A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 03:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjAJCxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 21:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjAJCxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 21:53:42 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0128B41658;
        Mon,  9 Jan 2023 18:53:41 -0800 (PST)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30A2hGvV012889;
        Mon, 9 Jan 2023 18:53:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=2dNkPdo2CGBLEgLth5AGZRfV+Ch/2kKTCkklNW2xAqI=;
 b=ZMgyVtkCAQ5n5Vcj3k5H6UNk1pa/e9WMedXOl2KWAZthlJyxOUVR5nTFcPWXO0wW2/9S
 zhOvlCQqdAdrSN25etmn39HjuFyC0L8VX49Aczom7coYbn4ICufTzbcyKF0S++Kfrm9t
 2y2FmwfMC74hoV1OgISK2q6cexEmsX4oVxLZBA0FN6yoVLIr3yQdsa9XT5mWRwCXPhPN
 Fq6HfaQHFbuQYgBsYzippeScI4ozXLq+aEzuSC8d8CGob9j/oMNG+RaFTKobb4e4blYE
 1pzykulbXxWlpiLPNGqdVqp8T9O7EcWXfGH79S41LDZtjT7uv46s9uNkkRS4pZ7rfR+l qg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3my8mtek7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 18:53:31 -0800
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 36AA44007B;
        Tue, 10 Jan 2023 02:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1673319211; bh=2dNkPdo2CGBLEgLth5AGZRfV+Ch/2kKTCkklNW2xAqI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=MKqo99VG/KYh7I+2N4/4AXWZzloUmiUN4E2uOHXRYFgisLLDZjtsb3/U4UduNoKBj
         CZtMmUyW6kynS74COe/ceHqA71dRv7mJHG0gmVBei2iKj2aePV4S1dcRc1U/U4Yvvk
         03hWlcsfZVdXYo6Gne3dJSkzwL65qqvgjdsoQqBObk4DtMdFBp4r3Kmd+4qpDavJvg
         bsXwsiktzTvtfet+KnXK2riOG7ocO6ek9Iv9kJBK0Y8Wvgab1QgMR1YRgfwIMA7/GW
         7rj9yWwMkVVDfRugx9Y3gVI4Z6J6DE0IGm+QuMa04pLXGE7eA6Gewi7spMP1xtoMKy
         P1AjW3MuYs65g==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 9D50CA005E;
        Tue, 10 Jan 2023 02:53:30 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0B52880095;
        Tue, 10 Jan 2023 02:53:29 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="RbhemMWL";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYBZBDCCxioC+UHzahCv4dtiq8OvXk5H1Pa8SxblOshSDtdnOOU4K0S6aDiMtmxPlSl/P7ZxB6dWpvmhvz91TfuOFURIf1p1dbDUKzNg0Z/qQri4QYNMehYFqbHS7jbJjpBDlpO6uhQIlDzOUk24j6uT21n9v25cUbqGujS5UPEWqJn/O+LqUijJcB6eOO8G6mITOGSrJxMl1oGwVSBxT6Ym/WEOKFTXLSpVT9Ziz6B94jvkp1lOoJWmanAOu+cUdWivrtUPxUwMgnm5Fe39c/AxBGlXa7lwQwPRAJSJscUkyOyXRLFM9USJdLt2g1i9wqm3GxVDJw1jJsyyTidDpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dNkPdo2CGBLEgLth5AGZRfV+Ch/2kKTCkklNW2xAqI=;
 b=DmdYn5abKtKvIGO8ZUFEiAd3/oqmrj9ugGLxMQBnypCXZ9lNtaRIcjYI5GimFjGzU/6aaMgJWogaLeA6BNVX71ULjhr4keL1d4xlNoDKh8e8ShxGqnAkH26Osyu8AEqSVKfB/eSvWlcAmkgzgDmTEeMJKyfK8tNevlBW3xIEveZ7iUpY3jypDvbdKqwJYZx293PyqwOrUtWR9cDGpK9J7AQvZXo1pqrKV1L3BwzPDKCa+Yr8z8zAWKc/rMW91cZG9rmMdByaowN5mPET88KmSZFRcR7gxL/SdfyEgqJKhkEO51Udh7brYALJWROvjZX3/cv/LvZqJU0tGfScuLJcwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dNkPdo2CGBLEgLth5AGZRfV+Ch/2kKTCkklNW2xAqI=;
 b=RbhemMWL/bbmHicE5IdwOXDHPaDIGAAzGSbTl6cdWL9peDk8XQa2fnsMpY6il0DjZ1CsX4c5XEA/75mYVQL+S4/BqSJwl3SRRiprWxj+fpGQlDH1SVW981YZbN4moZ4MwN83GlTsQGhEowvKA/lWoULjvWn9cr3QQE1toVwiEl0=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BL1PR12MB5922.namprd12.prod.outlook.com (2603:10b6:208:399::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 02:53:25 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e395:902b:2e90:b7ee]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e395:902b:2e90:b7ee%4]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 02:53:25 +0000
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
Thread-Index: AQHZHmjkAYxM4HeOyE6Dd8zsa51+rq6PLu+AgAABtICAAGoRgIABIhKAgAW2rICAAH0sAIAAD+kA
Date:   Tue, 10 Jan 2023 02:53:25 +0000
Message-ID: <20230110025310.nowjnrmo3oag76xd@synopsys.com>
References: <CGME20230102050839epcas2p4b9d09d926f9a14c3b8e8df2574d334c3@epcas2p4.samsung.com>
 <20230102050831.105499-1-jh0801.jung@samsung.com>
 <af32e2f5-de45-38af-2b4f-47c1ac21ea9e@quicinc.com>
 <c4e01a0a-1c98-3103-2b91-2fe0ba8c3118@quicinc.com>
 <000201d920eb$c3715c50$4a5414f0$@samsung.com>
 <0bbd2355-2290-17c7-6860-d8b25930aed6@quicinc.com>
 <20230109182813.sle5h34wdgglnlph@synopsys.com>
 <e7217471-5b08-eee6-fba8-06e879118d77@quicinc.com>
In-Reply-To: <e7217471-5b08-eee6-fba8-06e879118d77@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|BL1PR12MB5922:EE_
x-ms-office365-filtering-correlation-id: 57438d56-3f91-42e2-b9d3-08daf2b5d82c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GHk2tnlP0jVfkR55Oc9Tmt6Ic7mLAlNwZsJRA/WcI0WuMPACn+AKu+In4m6sDWMb2JPi/ZEB4DP5nHrTH+SDgMEPRx+rj2HuXH6WatQh63OAsdETiL6AXXFPl0XMT76LHr2Rb9UKlJPDvAatqEy+LKm0oaFy0tPSuyD/HY2VC3pxSIxkT9svq5IhBE1jhtL3VaNk1A8osPYvdk8unFViqFpHifvLRPkGRqYIf9jEbJfYw2JYprxSPQbHLr7ZFiptl7vNo7xFGtkyeKUGtftNuLF0KfRzK6mr6OzwIekjoLzZA8dRVkHNK9JMv+F3QvU8mECHhaurG9moWM6Ckya7J4WofKou/+qsmJGGWb09pzRV7TGPwr2CKsff8MZ/BlzMcCvFyiBFd1pEh6SmnK27PzBPlh81+t7n2iTD+//Y9gwkJKMqQPV8jen5fPzMTqha/lGwfFnHWdosY0Cls7rY54DfLygPFWgmgC2VvWrx8XRzNsK43at03mix2Ea/BzTBl624OfQJcBaC9cXQ4/aHXNj/A9lpmnSHnY5Db+gyz5Nf1dPM6rR5x5fyIauJEARuiFgQ41WR2k8VZpxlbe6rUeK3I7B/UCfjXI2Banp1pxfOv/JZ2TQClRKrSfxyDD3oZWViwGBhnpVbto4nNSC8GVwYlNAV5vzLshEbNRLd/JHfhlgIe48Ra0caEFJn1lyUt7y84iymPb6dY3X8Qc8hDigs3TAresg2X2m7y/OcAYU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199015)(8936002)(2906002)(5660300002)(41300700001)(71200400001)(38070700005)(66446008)(4326008)(76116006)(6916009)(8676002)(64756008)(66556008)(316002)(66946007)(66476007)(54906003)(26005)(6512007)(1076003)(122000001)(2616005)(38100700002)(86362001)(186003)(83380400001)(36756003)(966005)(478600001)(6506007)(6486002)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXRoSFVVYy9iU3hEOStJMHlWMW9abWxEMEJmNE41WkZGV3BKeGdtYnl1Rm1V?=
 =?utf-8?B?T0FsOUNBZVEwOWFsOEhQSTFBcXkrUExQQjdBbndBL0FGcEJHV0ZMTUpEa0w1?=
 =?utf-8?B?L1NIOElKUy9BbXBTYTlxTlBzblkvVmVrZ1NwOS96am1jdTkwdzVYM2N1L1VJ?=
 =?utf-8?B?S281Y3F4bnUzeVhpTTdHWU5UZzUyaVhqemFSdzBjemlldVVoTmpDR1hZUGow?=
 =?utf-8?B?NlB4RDdUWDhnVm1NeVFmcUE4Zm1lcDZ5dXNIcHIxRDhyaTFBakZxK0ZqY3kz?=
 =?utf-8?B?OFFzd05XT1NpMnVlRVgrVWo2Q2taSExvV3JNclh2ZGlLTGxXdFRlNjU3RldL?=
 =?utf-8?B?djF2UldRaEJrUkY1VjA4dkxDZjVpdHJaZG1Mb2JkR2VJSGQxQ2hqVWx2eGhw?=
 =?utf-8?B?VGdQU0lBZkdKR2M3dlozNzJtTnp3d1liT3NyTC9RK1daQ3A2U0dRSXc1NWxG?=
 =?utf-8?B?MGNNNGhkNHVqKytUOC9xRjJaQTU5cUZZVjRhaWtCVmhPditJbGY0RVlua1Yy?=
 =?utf-8?B?clFPTlVJbUcyK0NlK29LMC9XTEhTWVBtMkwyK3ZQL1BlKzRDVmw1eFdtdFZ5?=
 =?utf-8?B?dWZlYVdCdjRWdTRvZWF4TlRVdjNDaGIrVkZqdUMrNHFSSC90Nk1MVWlCZkZU?=
 =?utf-8?B?ajVqZTdwdGJNbklva0RZT1R4ZG9NZVI5di9udzVSQjYwQ3l1UzVlNnduRllk?=
 =?utf-8?B?U0MyeFZQc2ZEVWRsQ2FFZ2JBbWh4aEZqcy9SVDdHQkhwZ1BJS2xMTTVoVElr?=
 =?utf-8?B?UnpOSS9GVUwrWDlxZEwweldwZ1V2WGxlT2V3a0lsUEZYQmpZWGxxelBpSmRy?=
 =?utf-8?B?b2lvcG5STk5hMkJkT0NpOEpKUEVaRjhYbHI2RVBSRXA3akpHYnRkRmZaL3M0?=
 =?utf-8?B?UTJoVGwwZVZrSkl1ZkxPTnZ3M0o3Q3FOQzEyRlpqb2pYa0FCRzJFeGp3emRu?=
 =?utf-8?B?dVdUcit0YUJLWE9STHYyZ3JtdDYzTHRBcmNBaThjckVjU2lITEI4T3hBRzdw?=
 =?utf-8?B?YnVWNS8vUU5DY01aUS9uUkNDQUsremhpY3kwSHZ0VWpqNDAycTIzRG9MRk55?=
 =?utf-8?B?TFA0OVRYUWhseWJ3T0c4WDhCenZEbEpSYUt4MXRkVlRORWJuS3Urdm4xbmlX?=
 =?utf-8?B?dk1JNVNOaFVxVnY0QVdlQkNEa1Jhb2YzOHhDOWZ6WlZLTE5acEtHNXlJZ1kw?=
 =?utf-8?B?TWdSVTl3KzJkWmc4RXF3dk1XWHFsVGV3a25hR3pxZjFtMFdPY1VFUjZnMERi?=
 =?utf-8?B?S2NiOGM5UDBHakdqV3RKY2dQRWdlYmVZSzI3Zm14UGhOOXlIV3pLOXlVMkdB?=
 =?utf-8?B?clluczBDQzlQYkM2blFaWmM4cVlKNlE5ajN0WFJuTWRYUTY0UjNNQ3FaVTJ1?=
 =?utf-8?B?NzFIcmVCalBVZ0lPVUdLbUUzSGJ3MGN1ODlpSTZta0xnZCtQL3BEZllsbXZW?=
 =?utf-8?B?M3RxVjNNQXpQcXN2Mk9pZkVUOC84RWFseXgzdE9QZHZlZzh5TEo3d0VpbFVU?=
 =?utf-8?B?YUhvc1RmS3ZDdVEwSjl0OU9tWnYrWjQxd0RzUmRMcFJIbU9CUS9LLzRBL3ph?=
 =?utf-8?B?b1V5Q0lsQVhhSFlvU1BwbSt6OXgvZW9LdStGQWc1WnVBR3I4V3FkRlhGWnR3?=
 =?utf-8?B?QmhOQXNiSTE4RUQwM2dES2xYVjczWUNxR2hxRkNySjg0a29meXZ2QmtxTTF2?=
 =?utf-8?B?VUplSzZyaVRHUE1vaExMN0ZhTmpiNTJES05wVTNNVFBmblN1RTZVNXJwYzlQ?=
 =?utf-8?B?Mk8vU3FjMCs4YytJNjNZR2MvR1NtWTdrTGtBeXFOMjl0d3A2Z1BPVDVNQnJL?=
 =?utf-8?B?UVNzY2NvRXBlTy96MFRWY0VRazFDbU9SMmMvMU00SGszcXhRMmtFMmJDbGtu?=
 =?utf-8?B?V0JyM1hGM3lQZVRRU1JhNUtxL1plTzM2VWNxSFB5OFdqMVcyaEx5eWlLMDQ4?=
 =?utf-8?B?K0tPUXh1RlRDWUpsMHdFaHdZd0FsQ1FXMDZsRWJHMXk4R2hpTVlrYUVLRHcw?=
 =?utf-8?B?OFc2WkZtL0F4WGRBNE5IYnpYekVJckRlQ3huS0kzQlM3dncvRGNLNlprYWw2?=
 =?utf-8?B?RUs5NVBTemtoVUZIVWxsSGltREVDd3lIYmYvTzBEN2IvUUZ0LzRENmpiSVBt?=
 =?utf-8?B?OW13MXk5Q1o5UDVPS0d6V3Nka2VidHFYM0I4RHNpckNKNTIvQnMrd3d2MHlm?=
 =?utf-8?B?RXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2684A1A7242FE47890E4A23A55830BC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dnUvYytsbkgrSEVXTnd4WmV3dnVtbUJoWi9wSXIwWk1vZGR5QmtuVlFnUTd3?=
 =?utf-8?B?TlhBVEY3M0FZbVpGZVp4aWhZSkNRbHFLdEJnV0gxZ0ZzakpiRFllajNXOFEw?=
 =?utf-8?B?USt1U2RleXM5UC9tRDlUWHBzajBFOGVQc21IYW9jbFFiRzlxdXJzU1lEQWtI?=
 =?utf-8?B?OUFGVURxWjRlN01qY0VtcGIxS081M0EyKzY3N1p3amRsTlZ3ZkxQd2FqMlFZ?=
 =?utf-8?B?QUk4R21COWNqTGorR2g2c2FodW1HL0JLczVwLzhOS2NwNFJzTXhxN3FZRk04?=
 =?utf-8?B?ZlZFMlZuM2RvM01vdUdvZFpQZmFoSHZJVUQ5UlNRcDB4ZFc3SEhSZ21EUHVN?=
 =?utf-8?B?NE5Gd2ZvZkc2eFJMeC9vZUkxWGhsTEwrTjNjY2VpdnZFSEVPcVI5YkI1NHpJ?=
 =?utf-8?B?SzBtTWpoWG4vVVo5MUI5d3ByemExUSs5Tm0wODNMYTNLUmJmaTl5cVhFOWxu?=
 =?utf-8?B?aVNmYjZHWi91THo0V1lTVjFRa0ZYN08wVHJkZ2QzREY5aXBhTW9PNG8xdTJX?=
 =?utf-8?B?cVJoajVsbjcrV1lzWkh4KzdnbGQrWkkyejZxc0RaWUlVa05PdnpNa0t4K1J2?=
 =?utf-8?B?VVhXdENxYUdwR2l4SnViT0NvMEVNMlJ0UVNzYzA2VVgwQlJLcHp2by9LTG04?=
 =?utf-8?B?TWY0RVl3MWhBQ2orczQ1cDEzTXNDakU4R1FUYzFDTzJRVGx3MTlTbDBpZno0?=
 =?utf-8?B?dUdhdXlUN1BBT1RKUTZhT0xUNTFGVDZCU3hqNmFnL09rYkdKdUJFZ2dDUGwr?=
 =?utf-8?B?NUZLYWZPY3hpdjVWQ0Q1SmhxbUo5V21BT1F1c3RXZTU3TWMxQWtadTExaWhi?=
 =?utf-8?B?SngrUlB1MlhzVFkvUVlkdjkyQWxlYmJMTStISjNyNnRZRFY4YnI0c3JCSWpo?=
 =?utf-8?B?MUk1T0x5MGpqVWxtTjNRaTVIRm0vaiszT3ROM1FqbkZLK3UvN1dSaU05aksw?=
 =?utf-8?B?cWpUMXBxZkF6VDNUb2k3clQ1QVZvVWdsNUVPaDAyMWFSRUh1M0ZHcS9mZjZN?=
 =?utf-8?B?VmZQbW1iZGV2TXUyY3V0anZ2dlZwYXU4L3VFK3RFcm1mZENaTU15UGlaMmQr?=
 =?utf-8?B?VFhLODRMdnNocUZQQnJRMzl3SlFrZHZ3RWxhUWZCck9HVkxMbGtqdmJkaFBB?=
 =?utf-8?B?YUMzOG55YTdjN1R3OEZJODdXVWtNd0dxZ25NMGk0YytXbytDYnhQVjE2NFdS?=
 =?utf-8?B?ZlNIRlJMMVluaDNLNzB1Z2VFd3JnUlZPYVZLbXhOS0o1VG1JaDY3UzlsUmND?=
 =?utf-8?Q?uOJaa8LlJzWF/rk?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57438d56-3f91-42e2-b9d3-08daf2b5d82c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 02:53:25.5846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y4f8+pJOZ5gemjn2WAuEmCXbOORo5Su1GJmjvIyyUkeabg55Z7BdFEgSiuUQU2WdKyCD7zXEANNDNb6/fCezsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5922
X-Proofpoint-GUID: pzbUwxQF6ZngpyL5UsGQINxxwMBf2N2d
X-Proofpoint-ORIG-GUID: pzbUwxQF6ZngpyL5UsGQINxxwMBf2N2d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_16,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=437
 bulkscore=0 adultscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301100017
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBKYW4gMTAsIDIwMjMsIExpbnl1IFl1YW4gd3JvdGU6DQo+IA0KPiBPbiAxLzEwLzIw
MjMgMjoyOCBBTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9uIEZyaSwgSmFuIDA2LCAyMDIz
LCBMaW55dSBZdWFuIHdyb3RlOg0KPiA+ID4gT24gMS81LzIwMjMgNTo1NCBQTSwg7KCV7J6s7ZuI
IHdyb3RlOg0KPiA+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+ID4g
RnJvbTogTGlueXUgWXVhbiBbbWFpbHRvOnF1aWNfbGlueXl1YW5AcXVpY2luYy5jb21dDQo+ID4g
PiA+ID4gU2VudDogVGh1cnNkYXksIEphbnVhcnkgNSwgMjAyMyAxMjozNSBQTQ0KPiA+ID4gPiA+
IFRvOiBKYWVIdW4gSnVuZzsgRmVsaXBlIEJhbGJpOyBHcmVnIEtyb2FoLUhhcnRtYW47IFRoaW5o
IE5ndXllbg0KPiA+ID4gPiA+IENjOiBvcGVuIGxpc3Q6VVNCIFhIQ0kgRFJJVkVSOyBvcGVuIGxp
c3Q7IFNldW5nY2h1bGwgU3VoOyBEYWVod2FuIEp1bmcNCj4gPiA+ID4gPiBTdWJqZWN0OiBSZTog
W1BBVENIXSB1c2I6IGR3YzM6IENsZWFyIERXQzNfRVZFTlRfUEVORElORyB3aGVuIGNvdW50IGlz
IDANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBPbiAxLzUvMjAyMyAxMToyOSBB
TSwgTGlueXUgWXVhbiB3cm90ZToNCj4gPiA+ID4gPiA+IE9uIDEvMi8yMDIzIDE6MDggUE0sIEph
ZUh1biBKdW5nIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBTb21ldGltZXMgdmVyeSByYXJlbHksIFRo
ZSBjb3VudCBpcyAwIGFuZCB0aGUgRFdDMyBmbGFnIGlzIHNldCBoYXMNCj4gPiA+ID4gPiA+ID4g
c3RhdHVzLg0KPiA+ID4gPiA+ID4gPiBJdCBtdXN0IG5vdCBoYXZlIHRoZXNlIHN0YXR1cy4gQmVj
YXVzZSwgSXQgY2FuIG1ha2UgaGFwcGVuIGludGVycnVwdA0KPiA+ID4gPiA+ID4gPiBzdG9ybWlu
ZyBzdGF0dXMuDQo+ID4gPiA+ID4gPiBjb3VsZCB5b3UgaGVscCBleHBsYWluIHdpdGhvdXQgY2xl
YXIgdGhlIGZsYWcsIGhvdyBpbnRlcnJ1cHQgc3Rvcm1pbmcNCj4gPiA+ID4gPiA+IGhhcHBlbiA/
DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IGFzIHlvdXIgY2hhbmdlIGRpZG4ndCB0b3VjaCBh
bnkgaGFyZHdhcmUgcmVnaXN0ZXIsIGkgZG9uJ3Qga25vdyBob3cgaXQNCj4gPiA+ID4gPiA+IGZp
eCBzdG9ybWluZy4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiBIL1cgaW50ZXJydXB0cyBhcmUgc3Rp
bGwgb2NjdXIgb24gSVAuDQo+ID4gPiBJIGd1ZXNzIHdlIHNob3VsZCBmaXggaXQgZnJvbSBJUCBs
YXllci4NCj4gPiA+IA0KPiA+IEhvdyBhcmUgeW91IGNlcnRhaW4gdGhlIHByb2JsZW0gaXMgZnJv
bSBJUCBsYXllcj8NCj4gDQo+IEkgdGhpbmsgYWxsIElSUSBpcyBmcm9tIERXQzMgY29udHJvbGxl
ciBJUC4gaWYgaXQgaXMgbm90IElQIGxheWVyLCBjb3VsZCB5b3UNCj4gc2hhcmUgaG93IHRvIHBy
ZXZlbnQgZnJvbSBTVyBsYXllciA/DQo+IA0KPiBzZWVtIElSUSBjYW4gaGFwcGVuIHdoZW4gZXZl
bnQgY291bnQgaXMgemVybyAswqAgd2h5IHRoaXMgY2FuIGhhcHBlbiA/IGRvZXMNCj4gaXQgbWVh
biBldmVudCBjb3VudCByZWdpc3RlciBpcyBub3QgdHJ1c3QgPw0KDQpXaGVuIHRoZSBpbnRlcnJ1
cHQgaXMgdW5tYXNrZWQsIHRoZSBjb250cm9sbGVyIHdpbGwgZ2VuZXJhdGUgaW50ZXJydXB0cw0K
YXMgZXZlbnRzIGFyZSByZWNlaXZlZC4gTm9ybWFsbHksIHRoZSBmbGFnIGNoZWNraW5nIGZvciBw
ZW5kaW5nIGV2ZW50DQpzaG91bGQgYmUgY2xlYXJlZCBiZWZvcmUgdW5tYXNraW5nIHRoZSBpbnRl
cnJ1cHQsIGJ1dCB3ZSBjbGVhciBpdCBhZnRlcg0KdG8gYWNjb3VudCBmb3IgcG9zc2libGUgZmFs
c2UgaW50ZXJydXB0IGR1ZSB0byB0aGUgbmF0dXJlIG9mIGxlZ2FjeSBwY2kNCmludGVycnVwdC4g
VGhpcyBleHBvc2VzIGEgZ2FwIHdoZXJlIHRoZSBpbnRlcnJ1cHRzIGNhbiBjb21lIGJ1dCB0aGUg
ZmxhZw0KaXNuJ3QgY2xlYXJlZC4gV2hpbGUgaXQgc2hvdWxkIGJlIHJhcmUgYW5kIHNob3VsZG4n
dCBiZSB0b28gbXVjaCBvZiBhDQpwcm9ibGVtLCB3ZSBjYW4gYXZvaWQgdGhpcyBzY2VuYXJpbyB3
aXRoIHNvbWUgYWRkaXRpb25hbCBjaGVja3MuDQoNCj4gDQo+ID4gDQo+ID4gPiBidXQgd2hlbiBj
aGVja2luZyBEV0MzX0VWRU5UX1BFTkRJTkcgZmxhZywgaXQgd2lsbCBhdXRvIGNsZWFyIGluIGR3
YzMgdGhyZWFkDQo+ID4gPiBpcnEgaGFuZGxlci4NCj4gPiA+IA0KPiA+ID4gdGhlcmUgaXMgb25l
IHBvc3NpYmxlIHJvb3QgY2F1c2UgaXMgaXQgY2xlYXJlZCBvbmx5IGFmdGVyIGlycSBlbmFibGVk
IGluDQo+ID4gPiBkd2MzX3Byb2Nlc3NfZXZlbnRfYnVmKCksDQo+ID4gPiANCj4gPiA+IHdlIHNo
b3VsZCBtb3ZlIHVubWFzayBpcnEgb3BlcmF0aW9uIGF0IGVuZCBvZiB0aGlzIGZ1bmN0aW9uLg0K
PiA+ID4gDQo+ID4gVGhpcyBpbnRlcnJ1cHQgc3Rvcm0gY2FuIGhhcHBlbiBiZWNhdXNlIHdlIGNs
ZWFyIHRoZSBldnQtPmZsYWdzIF9hZnRlcl8NCj4gPiB3ZSB1bm1hc2sgdGhlIGludGVycnVwdC4g
VGhpcyB3YXMgZG9uZSB0byBwcmV2ZW50IGZhbHNlIGludGVycnVwdCBmcm9tDQo+ID4gZGVsYXkg
aW50ZXJydXB0IGRlYXNzZXJ0aW9uLCB3aGljaCBjYW4gYmUgYSBwcm9ibGVtIGZvciBsZWdhY3kg
cGNpDQo+ID4gaW50ZXJydXB0Lg0KPiB0aGFua3MgZm9yIGV4cGxhaW4sIGkgZGlkbid0IGtub3cg
dGhhdC4NCj4gPiANCj4gPiBzZWUgNzQ0MWIyNzMzODhiICgidXNiOiBkd2MzOiBnYWRnZXQ6IEZp
eCBldmVudCBwZW5kaW5nIGNoZWNrIikNCj4gPiANCj4gPiBUaGUgY2hhbmdlIEphZUh1biBKdW5n
IGRpZCBzaG91bGQgYmUgZmluZS4NCj4gYWdyZWUuDQoNClRoZSBjaGFuZ2UgbWF5IHN0aWxsIG5l
ZWQgc29tZSBhZGRpdGlvbmFsIGNoZWNrIGFzIHN1Z2dlc3RlZCBpbiBteQ0KcmVzcG9uc2U6DQpo
dHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC11c2IvMjAyMzAxMDkxOTA5MTQuM2JsaWhqZmpk
Y3N6YXpkZEBzeW5vcHN5cy5jb20vVC8jbTdiOTA3YWE2ZGE0MDIzY2IyMGZhMDBhNTc4MTNkMzFm
ZDg0ZTA4MWYNCg0KQlIsDQpUaGluaA==
