Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BB85EA596
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 14:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239453AbiIZMHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 08:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240065AbiIZMGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 08:06:16 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2072.outbound.protection.outlook.com [40.92.98.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E354DF36
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:55:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TyXzwsYbaGwyum4rwPHHEGimJA3rtkpp5xhyUyqGfks/xJ3mz9xvOMnpt1ky75LkSotaSV/Cgk2aGTArd4rrwEVqfenrihJUmBbdY2w+aoQN4KUNIhVD/XPfIQ1WwAazECG2RdB1+pnY83oAszmQUy0nvjgbPKOQG+6eeswdB6U2bDiVdXSxakfNtKBc6pxbhBUL6jc5u+Sf5lrLov0ywL/LNebfSpBirglkdNGyjeEOJoJZKQxKpDuZyQ0vPw5BsIla3J0z8lhZODG1sI6TO+lKkmOKf0xmMgz70GMvbhMHNhUr2+feYPgNAbuAddE6RA/NR7Mx5JdCdHyPIxteoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDY4+LTi0PDN2TuCGruIoEHyLEOW7nAW2UV/QpdiK5A=;
 b=AN51XdK8KervHrpjw7WDSqVm81f7+zddOxIa0CO8W03zYUcCJ8P1WVLbXG4J+J3Bj7uUI/Eh+i/01GlZTOBkHYOMXoLtpu1LsowipqAs+x86wn71GqhEykWY6OZ0HWEW3xy82Ch/XsMW375seEcKYPkgyNSncBW5NDwKy91Nqdek49ct8sbWC9e9QpSDs6H442vve1ID8r0H4zn3JkbaLXWeMrmrHp9E3S99pM7XzJ+jY2roMuW+nbRfKvHO18JZ+50fZJC6GaHYEyFdN1mKPM4vYDQN6gOAEpnr9/SttALFqSlQoI5O+fGzEojAaBr/SVeXH5BadtZS1NKnZSDPHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDY4+LTi0PDN2TuCGruIoEHyLEOW7nAW2UV/QpdiK5A=;
 b=r51WL/UUFlGKic5UQJws/tZ5j9Q+Nfx+AubmJt1MHkh/Oa2cVsCRNebZDCDVMa5JyptIr45y6qx2YixZFi8YC1sn0cREHg39hwqIfEVKnwD29kTZqhlE+R9cPh+9rrvf5wEhGipE06jpDe1ysfXzGMsQc43znXz/4PsIiNYwaUAVzu2kBLMvSGZD1rUkRpD8fG+LCesiAIfVbaXEl76vnjZ+OMOJaoMVXPxywre8Mb5BCpCYN5cTJwZEpPoiQUntPj23VxZ3qFRPj1BBSSdHR3LHpb8Qo1H2N4nvwSnSfz8TYmyW+hZE727ePJdrAMjhmRx/+5hz+4EtqQkZGrvBXw==
Received: from OSYP286MB0103.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:83::12)
 by OS3P286MB1640.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:161::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19; Mon, 26 Sep
 2022 10:47:13 +0000
Received: from OSYP286MB0103.JPNP286.PROD.OUTLOOK.COM
 ([fe80::8b83:8fb9:2676:a925]) by OSYP286MB0103.JPNP286.PROD.OUTLOOK.COM
 ([fe80::8b83:8fb9:2676:a925%9]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 10:47:13 +0000
From:   =?gb2312?B?1cUg1PPT7g==?= <zeyuzhang07@outlook.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: 
Thread-Index: AQHY0ZVRwUJA9XrgsEWuKnUeHJAz3A==
Date:   Mon, 26 Sep 2022 10:47:13 +0000
Message-ID: <OSYP286MB0103B3E4EAFAA82C9D9FC188B2529@OSYP286MB0103.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-tmn:  [y0bG0WwQi8Drc8DaROAQ6R4y51P+coCm]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYP286MB0103:EE_|OS3P286MB1640:EE_
x-ms-office365-filtering-correlation-id: 65dd169d-5004-448c-28d7-08da9fac7891
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kpHGz7tiFp6MisJkQobFo0EXSmADfAQzSUB4Kjj+30Gotjjs1xhjioGCg0naKBqew4WbAe/g0mjlv4/NsiOsn2va0B04/FtC4JvMKcD15eXZXnZiuEHGUanjLVyXAMnv3wPrOQ3Pb01J6DltpVLWaqXhtgq/nJtjEJY0yM6U5KkyElzy0VdohoT4q0oYruJnUsZbcjGHxU/mUyisOhEb2jRckl6+TJwjbCHhoPXy1mSYHEDppA/kpYG0OguUQZkDOGHromGvvqTJpLeGEtDxXdjXjBor0B1JKgl6mpIiMjAavXymBT7GEBInMRKmdEYzRzTpf1KGG/RzVYAdy1/UHI2FPgQEymfOIsBnpQrZD2Jtqt2/pTcqyD1Usd8aUpBq78EWCsCSGtfVSSY8TS+8AuZR+kWo3+8uSRMU6QZI4IUofLLkz22VnNMrvM4FswQmqK/cBBFxnj0r35/4zzPFnenyRTPt4Z2gYcfIZPcZXQq+x3bPxj6hxFU+rG66Eb+rTPeLc5FHXPTKATxbV6S9xnowU22Iw+DGNGiwtgL6JXZ/Cs9x2rZ8xr8VdnEtywblScDQzpczxeO6YMSpiWds0rwVy3iMIOFcuXH0ECCcReqTJdNCnrauNZNC53F7mVBw+qAvbLvYoUA6/u6cJXWHOw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?VEkxSVcrMWVhYUFtNGEvTTZTK1lPeng5R08xRDE2eldjWTZrbWFBRzB1YWpW?=
 =?gb2312?B?TlJ3aHdOZHNMeUJoYVZQUXdIZG1qMmVCYUh0d2ZnYUR2Y096dE1NdTkzMC9J?=
 =?gb2312?B?YnpaSDl5Vnp4bXVuOVdQTlJMSEhqOGl6eUFSWEdGU1Zvc2lxVERuNk9XMkJp?=
 =?gb2312?B?UTd5NG1BYWVoR1kxK3YvcDVDTDlJd0VzSkxZV0VQVDgxM05WUzF0Q1YydDdO?=
 =?gb2312?B?UHhqNC9oWk1ldDc2NHQyUGszbmlHOXJoc0JVK1lLSTdRTzFBNFpIK3hkamF5?=
 =?gb2312?B?aGNtbUxJRktIK3VVL1Jucm5pOUJHRTJCT3JQT3RUTkIxSVZpMGxDWXUzT3JU?=
 =?gb2312?B?MmhsSDRyc3p2Sm9FV25FMHJyM1Bsdy9hbHNzSjAzQ2dCZjFtdno4WHdhNkNL?=
 =?gb2312?B?UlpFOEwyK3NvZ1FYT0ZYelU3T25QYStEdmFQKzFOamh0T1I3YUdQWFBmcEZ4?=
 =?gb2312?B?am5LSkRTUlgxRHlYWlB5cU9YZUFGMnRCc0pFOERUVG9zRmkwby8xZGdYN2xK?=
 =?gb2312?B?dlRUR001cnMvcEt2KzhMZ3FzaHlvaEtpMUxodG5nNVg4NWw0RjdCbWFsR3Bl?=
 =?gb2312?B?Vnl6QmxwclRoQkhSZWk0aXozK0RmRURsQ1ZETGJYcEh4YkViSHlzWk1rUWZo?=
 =?gb2312?B?SE5IWmxSZjNtdzdrbkdQREJXbS9sWW5zTjJYY05xVS9jdzV4VTl5TkJ4YnJo?=
 =?gb2312?B?dFNyYUk3M25VZTVRV1NtUEVLTzh1YWhiZUpWb3Q4ZzdxcFpKdjdCM0VHWlhM?=
 =?gb2312?B?TGJzQlkwMU10NTBhZ0ZqalY2S2hPVGsrVThLcnpCd2IyTy9HRFZ5RmpCZWUx?=
 =?gb2312?B?K2JCZVYwaWFMbkthcnY1UTkxYXhiZHE2d3M4VUJJTzlwVDVPSGpQRm9Uenk5?=
 =?gb2312?B?VnNuNzZ0a0x6NWROQUpXd254cG9yTU8wOHU3U2xFVlAwNldrcys1OUZCZ0g4?=
 =?gb2312?B?TkZFWUl6WDh4SVZLQXJUSUdUUEM3NWwzM290TDRVdDZPME5oK3AzTDFvbGV1?=
 =?gb2312?B?amtBc1VmL29ONlJIZzgrRFNKWmZMcnpOemJPNjdWek8wOGFXak9DMGM3OTY4?=
 =?gb2312?B?ZkdIcXZwUytUZ3duN3RQdm1pM0pKdnVSZk9BM2xtajBiU1VNdWZHTFRPQVFq?=
 =?gb2312?B?ZGRqMXdIUWZMUDZ4ZTF4L005VlJ1eDk5QjNPR2hhRGZZSDVQaElSZ2tBLzBj?=
 =?gb2312?B?UmFIdjRNU2NDSWZhSFQzbzZ1N3lVSm5kcXYxK25vbjJDeGcvTmc0Q1BHTGw0?=
 =?gb2312?B?bktoZlNnd2cyUXNZQ0Vjb2lKUjhOS3E2dFNaS1doSitwdW4rSTl1NXhMbk1n?=
 =?gb2312?B?czEzWDlEbmNwR0NDT2ZSQzRqbk91bmlUcjRoQVpTK2xhQnlBUmxJQ290dFph?=
 =?gb2312?B?MVpkS20zWHcxWklSWE9lZ3VTV0hRMWdkY2FDZFkwd1FSZ0ljYkVteUtRMmVw?=
 =?gb2312?B?QTRpZHBFVElPS0lyRThCM1kxbVJ1TEJmVWJxTGJBYnIxeVU5cTFXaFRSdkp5?=
 =?gb2312?B?dzVLaXhDUUdUZHI3U2lxRUZOZWdaYm9DNHhQOW5jSWVDNjRtb1E5dXZoelM0?=
 =?gb2312?B?WVJKR1JuTWx2NWVobDlYV0s0MUcrbzN2ODc1bFpJNHU4V25ERGluVFZySzYv?=
 =?gb2312?B?dnd3TTRkQ0VIWmJNNW9IeTJJVFlzVXZ2ZnFOeWRNWWxBeTVaMDczclB5WWFt?=
 =?gb2312?B?WEk3LzZhL2RjOUxWSU5YWnVhdFZjMGUyV3oyRVBUem5kVlZrRUpEdnJBPT0=?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYP286MB0103.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 65dd169d-5004-448c-28d7-08da9fac7891
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 10:47:13.1692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB1640
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        TVD_SPACE_RATIO autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dW5zdWJzY3JpYmU=
