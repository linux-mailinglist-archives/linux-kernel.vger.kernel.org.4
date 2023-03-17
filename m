Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2F56BDE3C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 02:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjCQBnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 21:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjCQBnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 21:43:18 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Mar 2023 18:43:14 PDT
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C503BD98
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 18:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1679017394; x=1710553394;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kbRQ5jdWhvkcVUc4cqj55W9+Pg66dVFSpnqqZC2oTJk=;
  b=dhMK95AEWxKm76zukrm2IAKqcYhj+TOBO3ikJNVF8V8vip41DsHhFG7G
   kBmjzivnZYm1hCYmGa0plhkxxFDFDAbd0bKLGOlXkVEp4cCU5IYYK6GRd
   ljnInMltrCweuwdpNcKbl4tvRephx3OZcNEpG2XoqaUOqNK9en9pWBkxE
   dBKWujp6mMPEWHrpg1tyTNDzqhLT2BpxpQZ2budSdMeWeLq+HIejsOujO
   I3T7VRrlnpxUt4dlishxk2FstuQPUlsXaSML4XZIaYrmkl5o3frppktBi
   k64Z5m8DlxUJUzuepNzM73ZkdTuw3kERPv0DQos12ovR3uOVuIbkzDFuV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="87600172"
X-IronPort-AV: E=Sophos;i="5.98,267,1673881200"; 
   d="scan'208";a="87600172"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 10:42:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkxwUGknAlHQBTVr2dpDuBpBZBZo9N/2Wt7R+x8RXMQZWYjgBvXPaRwafkU6kGlYf87z7nI2sS6Z5Z4FY6fPLGk6G82orcwtV+2LznWvqxC8yIf+EVlbMtDReg0fcs99ayVrCycy0aZI28ONtH+QimrE6fp6uzGKCi87nURloBNZ5GYkXrqm9KkcTC6ji3L/YAWfVviJVBwEfmDj4aiEqYz4YdgtYa1OSKjO606z8OtO9quQJWkV0H9vvmMszHmfPzamS5ochW6mGG2wdnBbm6jNE8q45y/pZaA26520u9B2CJY9OUZRE0s5NLHm1kOd4PT/FOJsNFAfY1hWdLu4/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbRQ5jdWhvkcVUc4cqj55W9+Pg66dVFSpnqqZC2oTJk=;
 b=JvfsSib1BjeIKVRmRj8vWawlPWMrAV3QF9IngA++4fFHqqqOtfJFsx/H+Abw8jJ6l3LamLONbrtSZMGmDSg8q8WUQAwabNg8zi0kwVI62RT6V0MZRTYEKvmRwuNjPIk06CXGzlkkgytaGBT4FGqan1P8uO1uG+Oe6kKU+yM0WticMyZ2hXcYIOyBB/8jaqJp3MuAS/Q6UpaRjqJveoH3ybZkrUGWaJ4Vg0VCVZ6uc93NLzNDRgBLXFPnXlRCXOBRyJ0GBFBduAqJ5ZMGm8igtnQEBfQaM8ILyupsLQ2vBqHazKB7700uJ4s9LsBRo4LfRKzmB8+FunjWQk7H0MqtCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB10399.jpnprd01.prod.outlook.com (2603:1096:400:244::9)
 by OS3PR01MB10341.jpnprd01.prod.outlook.com (2603:1096:604:1f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Fri, 17 Mar
 2023 01:42:04 +0000
Received: from TYCPR01MB10399.jpnprd01.prod.outlook.com
 ([fe80::7532:1424:bac5:7688]) by TYCPR01MB10399.jpnprd01.prod.outlook.com
 ([fe80::7532:1424:bac5:7688%3]) with mapi id 15.20.6178.026; Fri, 17 Mar 2023
 01:42:04 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvdimm: nvdimm_bus_register: Avoid adding device to the
 unregistered bus
Thread-Topic: [PATCH] nvdimm: nvdimm_bus_register: Avoid adding device to the
 unregistered bus
Thread-Index: AQHZV+LVN1DLpX/+y0yTP+b0+z/XPa79j4OAgACkEIA=
Date:   Fri, 17 Mar 2023 01:42:04 +0000
Message-ID: <ca55bea9-d2a8-ccce-010e-a26f6003a059@fujitsu.com>
References: <1678955931-2-1-git-send-email-lizhijian@fujitsu.com>
 <64133bcbbe368_269929415@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <64133bcbbe368_269929415@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10399:EE_|OS3PR01MB10341:EE_
x-ms-office365-filtering-correlation-id: 88d449a3-e25f-43ca-7c78-08db2688cfa6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IqbrKM6Wy+oOZoucr+u7z7kw5lpVmU+v8CL/MW0tZbiFfsI2zWLgPbC80+BwyMTFyk6PoYoy9bzrwXq7Aq3QPi0VcsS/xKWtEXQFLjU5TTTPFSbNdnlo2oFF5JL25SZcjEBNzVPTkx6JwANpg2wt2b3v/NqpjsnXPPnFcMKMZjnALgvp8tk7Tlg3sE1F5C2I70QD+RFJLr6SE01cV4ioaW0hvat6xINRHequ6wufzTnrTq58uqBxpugk36Sz2/rIv4GjjnJgGU7/9Hg0aElK4mFxMeM1pKc6YukEUnyyY8lOmb6RorLLuP4H9xZNacksS+YpcHyJo/sJZ1ZnkCNRlwhR/xU2o0oAxBLPQ1VCk+bO6MrZY2Eeb+BuVA4CwUI/AiJq+EToitFtY7FTTdXby9IsBVBdgk+/LoxUnakRGrON4GIYJon/lQuzjSrzIgAwVdQ3cvyjBtjVAWBNEDNs56shw/onJGoq8qnrODuWKwbwa3SbGrTYdIf85yvJvW9E0zC3f82SMsaCFgqyUd3gEmg7VOIXTGEptkrP88lRVd4B0EPhvnBsfyl/fh3QAtXkwhiKkhAuvoduMKJylmtfhp7YbuiCJAxq9EPdnXh0O/Qtp/eL3xFug9JadPKBFVKF69njcKvHsBKcKeTQUX5Y1WGSAWh51QPcIPRSMfx5M9GW/U9S8pdikBLL+krBeY5edXIxWAzDDF3qXyrz3YVcpZoKfrg15BbhvRacxNjo4u8ymc7ifvSjAj65DtRqsJVNns62tG8DIE7IJ0UKKeCXeiQyJqxYA7519fBAM+KR8hY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10399.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(1590799015)(451199018)(86362001)(66556008)(31696002)(38070700005)(8936002)(76116006)(85182001)(110136005)(5660300002)(2906002)(41300700001)(478600001)(91956017)(66476007)(66946007)(64756008)(66446008)(316002)(8676002)(36756003)(83380400001)(38100700002)(122000001)(26005)(6506007)(53546011)(6486002)(71200400001)(2616005)(6512007)(4326008)(82960400001)(186003)(31686004)(1580799012)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFYwdVdJMGxvYXE0aU9KaE81V0huaHc0MjFLeC92cVNUb1VDVVFRMXdZMjRQ?=
 =?utf-8?B?N2ZjWjNPKzloRmJUYW9Nd2FNUndkU2x1eHUwWmxPMjF6WVBwMmFUQWhMYURo?=
 =?utf-8?B?aDZjci9KUXEzS0VaaC9NNG5HY3hoRk1LWTBnSlF5WVpheEtqWlREUUtjbXRK?=
 =?utf-8?B?T1I1OE1ZUTUvY0ZrUU50ZGw3MldjdHN4NnNMeldxcVBCZFJqRzkvbkZzNlFK?=
 =?utf-8?B?Y0JxZDhvQ2N0YWtsVzJBY29TTUdTMWZYWnN6eURBeWJsYVF2SXlTMVEzdWZP?=
 =?utf-8?B?TXU0aXlmc08yWjNBTC9FK2ZiZUhFWEFRQXlzYXdpWUJLcFJ1c3FLV0YzbVQr?=
 =?utf-8?B?WWNIdFBHNUJGRWl0dnd0bWsyRHU5R1NudG0wbThyUEIyazZuamROQnpLNmFu?=
 =?utf-8?B?QUpwU0tPQnhYd3JFM295Q2pKbGllcWY1dTQrSmdjYW5yNjZlWmRlOEFQcFI2?=
 =?utf-8?B?N0RJNURZaS9CdkJMemRKeCtTVi9adDBhQzhoOFFDS01zZkxDWFVKcGFaSGpL?=
 =?utf-8?B?VGE1K0ExOUREbVZEeDYvODRrMlNxK1dmdDFEZUVSMUFLeDJUS2t0RUxjMmlz?=
 =?utf-8?B?N2lEZ3p6UlQ0WW91R1c5S29LUzJqZ09DVHQ2bkZzSmtDVUc4WU5hQ05iUG9L?=
 =?utf-8?B?YnZ6cTNBT05RTHY2NFNaRkdMRW9CSHZKMmNKUjFaOThuUkJTTEc2bnhJUHhC?=
 =?utf-8?B?VE1YcDRRR0VNOWExdm1JczZML2VtM2UxenI0WTgxMlVLWjVKSDlEa1ZBNzFp?=
 =?utf-8?B?ejFmVnJxNE0zeFNXQjZMT3g4RUQvV0lVU2hKUlVPdXIwRkhkVUVsUnJBNk5Z?=
 =?utf-8?B?NjFLalB3SVpBV0l2Y0c4MkRCM3hGTzhnZFNsa0tRNXh2QnZMV2N0N1NBaWFx?=
 =?utf-8?B?YTJjUXYvZEVxZXgrZm9WczA4ZnhiY1pRUCtOVnowcWNDWG9tbjE0Ykd6ekV0?=
 =?utf-8?B?U0V0NUVZZEU2Z2xEUTdQVzFNR1lnc05nbUcvcFcwN2g1K0tXWUxlRE1iQWNm?=
 =?utf-8?B?OXprMFhweTV2NEJGTTVvcy80N0lvV3JUenFlV25GTzhkdDdEQUxWQWowZW9m?=
 =?utf-8?B?VW5lYXd6QVJLZlRhYk9CdnlValBCendZdFNzTjFQQi9WYUczT2kxNkFMZVZh?=
 =?utf-8?B?VlE4dXVZekxaQ1NTRmlwakQxaG5vaHJaUFVDOXhRVzh4aFprd0JSQlY0ZWxE?=
 =?utf-8?B?TGk5RnF2eVJHaTJDckpWaUNiREJZY0g4V2tSdUQ5d0RNd1Q5c2xWUFJTQ2FR?=
 =?utf-8?B?R1RLbDZqeXRFWjhscVZKQm5WTXJJL0FBUGpleXMwZStLZVdRNm1VM3VkdVhw?=
 =?utf-8?B?ZHRZcUt5cDZpOE02OEdVRzNHRlhLWE5KUzFWNk1GeGF4ZWZhUHFCQlB4eVZT?=
 =?utf-8?B?YnpaeE1ScGF1R2ZqR2M0blN1NFdJbXFJQUoxcnZwWjdBNHVDODBzR1ZBMlpO?=
 =?utf-8?B?aW5GYjhyeU9nWjZpNmFFVmJCV24yeTZwQlhYVkVvbVhpbkR4UnlldCtIOHNq?=
 =?utf-8?B?b1hUdlJWRFUxeXEyZUFrRHduQUxGN00vTmpPQ1pOQjRVaS9BOXdISXJtTmZh?=
 =?utf-8?B?Wnl0aGNWVks1OU53OW1GMkJJaW9RNlRveWlSMmhQcm9VenZUUkxNQURudnZY?=
 =?utf-8?B?d3dCZCtVNkJMVUVtcGk1ME9teW16KzliQ2FlS0pDU1BlaGJ1NXhrS1BDZVo2?=
 =?utf-8?B?aS9xcU5LeElMZEIwV3JMWWdFRk9uYjNOTmNpdGJGbUhDbjRmSlpacjVwRC9r?=
 =?utf-8?B?RDBFbXF3bmFIcDRNTFVRSk1MWUphaDdFRHAzNlBveU9YenZ4WXVDaVRGR2pM?=
 =?utf-8?B?V3ExT0Fxbms4b0NteGxhbkdhSGdmelJiZkwxQlNJSTV6Mkk1TjBSaG01L0Zo?=
 =?utf-8?B?d1BSOTY0SzNacmZwNWxVNVFZaE9SazFVcWw1bUMzbzBseUhEc3p0WGtBTDlm?=
 =?utf-8?B?S2xRMnFKeUFwdTZEdXlaRUljM1AxZFZObHloZFhPTnBXMEtheEd0OTdCOWtz?=
 =?utf-8?B?b2lCRTdPNUJIcVJPZnlJbFN6TEd4U0ZVM2N4djZmSDJySW1URVRtdGtuS1Iw?=
 =?utf-8?B?MFRXbkxuNjBLUTltNEluWGxPRmZIQkFqcnlKd2R1YlZOSmNINHhCKzdSdGgz?=
 =?utf-8?B?ZTlSTUNYUWwxcE0zTlRWUDIvMGpZTGtnc0JOQTg4VVlER3F6ZzRrMTQ4QW1Q?=
 =?utf-8?B?TkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7197E05AF0648D468B72F50CFC08DBB4@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5dicIZsfdco0Ywqa7ZnjuVfFg2IgNUiO93tqSkXkmd1J1sxpY3rYgXKNL7Q3M9QvK6JGVSMbnYlTKI1wHnPhL0aqgGLDDz6Y+sp8AYxT6TVC1dIrPotyPmnL/CZ5yuB1e1njSBL6ZBOntJPdBlQj+3xkj6uHycpdAJ+v6rA2d6VIC+sw93WK9IzbUiO/T8Zh8VaQA+vYRh2mSvavtmcl4SC2kjqI6IuEpsj0tQkNLDf5QIbfE297zukI227vk/IdiscLorK2XQHBFAW8vw9wKligsdgVxYlXKlyrRcxIkRBIf0Oqx+hzm0YKsgixSJPL+057Z1UitwkodZrLms4IvuWFxHf/A+X/K845luMO79oUemRj0qjDTmvLLT/0R+kFdw+49E1fJSj1gz/ZwWMlhfXfI534ve+HyL3ZglcHW4SJ2mc7lYMe2TNTw9tUWRUdkng4Tzhwuv5LIZCgjp9v+xnAjsHQsjVTLnv4SDBny8nmwz52WAmQT3BsDZKySgzEe0Qqw+78G8w6MbGsAbLVX1vdidlbwhsdKgJaOIZp5KeyEQi+2CBgrjhS+0JC2gDJJvCvIKEA1cgRwhE0sCugj/hU/T/HmC5fDNUX8sFW4SgzjjAM7NDvI4e4brmXqUqcm9BEFwssOn6wYvgXMiEqiViMPDMjaH5+SFmc0goq/l0nLohejcUlJIh6jPYn4DSfFs44ggy43qmVIVv0Ac/uOKVlYy8WLTaNdelE1ACgOpFdRHr1sTrNGmeG9Y94NW14yTiJ+/OPBkGk7KN/sjPS+rfStwTimImitWptUGJk3kkZUymuuQ1KdiQL097HjTJDHfPlB0/6X+9WNPMZXco3IA==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10399.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d449a3-e25f-43ca-7c78-08db2688cfa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 01:42:04.3947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SpWj/qJCx8KiV5GtMA1ADUzgX2Y44SmKqiqH8zuje8wIe0Q/6X36ERnTRPF4GwDYh7nNDz8uAzuA1Mmuyo9KDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10341
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDE2LzAzLzIwMjMgMjM6NTQsIERhbiBXaWxsaWFtcyB3cm90ZToNCj4gTGkgWmhpamlh
biB3cm90ZToNCj4+IG52ZGltbV9idXNfcmVnaXN0ZXIoKSBjb3VsZCBiZSBjYWxsZWQgZnJvbSBv
dGhlciBtb2R1bGVzLCBzdWNoIGFzIG5maXQsDQo+PiBidXQgaXQgY2FuIG9ubHkgYmUgY2FsbGVk
IGFmdGVyIHRoZSBudmRpbW1fYnVzX3R5cGUgaXMgcmVnaXN0ZXJlZC4NCj4+DQo+PiAgIEJVRzog
a2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSwgYWRkcmVzczogMDAwMDAwMDAwMDAwMDA5
OA0KPj4gICAjUEY6IHN1cGVydmlzb3IgcmVhZCBhY2Nlc3MgaW4ga2VybmVsIG1vZGUNCj4+ICAg
I1BGOiBlcnJvcl9jb2RlKDB4MDAwMCkgLSBub3QtcHJlc2VudCBwYWdlDQo+PiAgIFBHRCAwIFA0
RCAwDQo+PiAgIE9vcHM6IDAwMDAgWyMxXSBQUkVFTVBUIFNNUCBQVEkNCj4+ICAgQ1BVOiAwIFBJ
RDogMTE3IENvbW06IHN5c3RlbWQtdWRldmQgTm90IHRhaW50ZWQgNi4yLjAtcmM2LXBtZW0rICM5
Nw0KPj4gICBIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJkIFBDIChpNDQwRlggKyBQSUlYLCAx
OTk2KSwgQklPUyByZWwtMS4xNi4wLTAtZ2QyMzk1NTJjZTcyMi1wcmVidWlsdC5xZW11Lm9yZyAw
NC8wMS8yMDE0DQo+PiAgIFJJUDogMDAxMDpidXNfYWRkX2RldmljZSsweDU4LzB4MTUwDQo+PiAg
IENhbGwgVHJhY2U6DQo+PiAgICA8VEFTSz4NCj4+ICAgIGRldmljZV9hZGQrMHgzYWMvMHg5ODAN
Cj4+ICAgIG52ZGltbV9idXNfcmVnaXN0ZXIrMHgxNmQvMHgxZDANCj4+ICAgIGFjcGlfbmZpdF9p
bml0KzB4YjcyLzB4MWY5MCBbbmZpdF0NCj4+ICAgIGFjcGlfbmZpdF9hZGQrMHgxZDUvMHgyMDAg
W25maXRdDQo+PiAgICBhY3BpX2RldmljZV9wcm9iZSsweDQ1LzB4MTYwDQo+IA0KPiBDYW4geW91
IGV4cGxhaW4gYSBiaXQgbW9yZSBob3cgdG8gaGl0IHRoaXMgY3Jhc2g/IFRoaXMgaGFzIG5vdCBi
ZWVuIGENCj4gcHJvYmxlbSBoaXN0b3JpY2FsbHkgYW5kIHRoZSBleHBsYW5hdGlvbiBhYm92ZSBt
YWtlcyBpdCBzb3VuZCBsaWtlIHRoaXMNCj4gaXMgYSB0aGVvcmV0aWNhbCBpc3N1ZS4NCj4gDQoN
CkRhbiwNCg0KQ29uZmlndXJlIHRoZSBrY29uZmlnIHdpdGggQUNQSV9ORklUIFs9bV0gJiYgTElC
TlZESU1NIFs9eV0sIGFuZCBhZGQgZXh0cmEga2VybmVsIGJvb3RpbmcgcGFyYW1ldGVyDQonaW5p
dGNhbGxfYmxhY2tsaXN0PWxpYm52ZGltbV9pbml0Jy4gVGhlbiBrZXJuZWwgcGFuaWMhDQpUaGVv
cmV0aWNhbGx5LCBpdCB3aWxsIGFsc28gaGFwcGVuIGlmIG52ZGltbV9idXNfcmVnaXN0ZXIoKSBm
YWlsZWQuDQoNCg0KRm9yIGtkdW1wIHB1cnBvc2VbMV0sIHdlIG5lZWQgdG8gZGlzYWJsZSBsaWJu
dmRpbW0gZHJpdmVyIHRvIGVuc3VyZSBtZXRhZGF0YSBpbiBwbWVtIHdpbGwgbm90IGJlIHVwZGF0
ZWQgYWdhaW4gaW4ga2R1bXAga2VybmVsDQpbMV1odHRwczovL2xvcmUua2VybmVsLm9yZy9saW51
eC1tbS8zYzc1MmZjMi1iNmEwLTI5NzUtZmZlYy1kYmEzZWRjZjQxNTVAZnVqaXRzdS5jb20vVC8N
Cg0KVGhhbmtzDQpaaGlqaWFuDQoNCj4gbGlibnZkaW1tX2luaXQoKSAqc2hvdWxkKiBiZSBkb25l
IGJlZm9yZSB0aGUgbmZpdCBkcml2ZXIgY2FuIGF0dGVtcHQNCj4gbnZkaW1tX2J1c19yZWdpc3Rl
cigpLiBTbywgc29tZXRoaW5nIGVsc2UgaXMgYnJva2VuIGlmDQo+IG52ZGltbV9idXNfcmVnaXN0
ZXIoKSBjYW4gYmUgY2FsbGVkIGJlZm9yZSBsaWJudmRpbW1faW5pdCgpLCBvciBhZnRlcg0KPiBs
aWJudmRpbW1fZXhpdCgpLg==
